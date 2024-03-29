/*
 * This file is part of GNOME LaTeX.
 *
 * Copyright © 2010-2011, 2015 Sébastien Wilmet
 *
 * GNOME LaTeX is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * GNOME LaTeX is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with GNOME LaTeX.  If not, see <http://www.gnu.org/licenses/>.
 */

using Gtk;

namespace ProjectDialogs
{
    public void new_project (MainWindow main_window)
    {
        Dialog dialog = GLib.Object.@new (typeof (Dialog), "use-header-bar", true, null)
            as Dialog;
        dialog.title = _("New Project");
        dialog.destroy_with_parent = true;
        dialog.set_transient_for (main_window);
        dialog.add_button (_("_Cancel"), ResponseType.CANCEL);
        dialog.add_button (_("Crea_te"), ResponseType.OK);
        dialog.set_default_response (ResponseType.OK);
        dialog.set_size_request (450, -1);

        /* create dialog widgets */
        Box content_area = dialog.get_content_area () as Box;

        // directory
        FileChooserButton directory_chooser = new FileChooserButton (_("Directory"),
            FileChooserAction.SELECT_FOLDER);
        Widget component = Latexila.utils_get_dialog_component (_("Directory"), directory_chooser);
        content_area.pack_start (component, false);

        // main file
        FileChooserButton main_file_chooser = new FileChooserButton (_("Main File"),
            FileChooserAction.OPEN);
        component = Latexila.utils_get_dialog_component (_("Main File"), main_file_chooser);
        content_area.pack_start (component, false);

        content_area.show_all ();

        /* callbacks */
        directory_chooser.file_set.connect (() =>
        {
            File dir = directory_chooser.get_file ();
            try
            {
                main_file_chooser.set_current_folder_file (dir);
            }
            catch (Error e) {}
        });

        /* if a document is opened, go to the document's directory */
        Document? doc = main_window.active_document;
        if (doc != null && doc.location != null)
        {
            try
            {
                directory_chooser.set_file (doc.location.get_parent ());
                main_file_chooser.set_file (doc.location);
            }
            catch (GLib.Error e) {}
        }

        while (dialog.run () == ResponseType.OK)
        {
            File? directory = directory_chooser.get_file ();
            File? main_file = main_file_chooser.get_file ();

            if (directory == null || main_file == null)
                continue;

            // main file not in directory
            if (!main_file_is_in_directory (dialog, main_file, directory))
                continue;

            // try to add the project
            Project project = Project ();
            project.directory = directory;
            project.main_file = main_file;

            File conflict;
            if (Projects.get_default ().add (project, out conflict))
                break;

            // conflict with another project
            Dialog error_dialog = new MessageDialog (dialog,
                DialogFlags.DESTROY_WITH_PARENT,
                MessageType.ERROR,
                ButtonsType.OK,
                _("There is a conflict with the project “%s”."),
                Latexila.utils_replace_home_dir_with_tilde (conflict.get_parse_name ()) + "/");
            error_dialog.run ();
            error_dialog.destroy ();
        }

        dialog.destroy ();
    }

    // returns true if configuration changed
    public bool configure_project (Window main_window, int project_id)
    {
        Project? project = Projects.get_default ().get (project_id);
        return_val_if_fail (project != null, false);

        Dialog dialog = GLib.Object.@new (typeof (Dialog), "use-header-bar", true, null)
            as Dialog;
        dialog.title = _("Configure Project");
        dialog.destroy_with_parent = true;
        dialog.set_transient_for (main_window);
        dialog.add_button (_("_Cancel"), ResponseType.CANCEL);
        dialog.add_button (_("_Apply"), ResponseType.APPLY);
        dialog.set_default_response (ResponseType.APPLY);
        dialog.set_size_request (450, -1);

        /* create dialog widgets */
        Box content_area = dialog.get_content_area () as Box;

        // directory
        string project_dir = project.directory.get_parse_name ();
        project_dir = Latexila.utils_replace_home_dir_with_tilde (project_dir) + "/";
        Label location = new Label (project_dir);
        location.set_line_wrap (true);
        location.set_halign (Align.START);

        Widget component = Latexila.utils_get_dialog_component (_("Location of the project"),
            location);
        content_area.pack_start (component, false);

        // main file
        FileChooserButton main_file_chooser = new FileChooserButton (_("Main File"),
            FileChooserAction.OPEN);
        component = Latexila.utils_get_dialog_component (_("Main File"), main_file_chooser);
        content_area.pack_start (component, false);

        content_area.show_all ();

        try
        {
            main_file_chooser.set_file (project.main_file);
        }
        catch (Error e) {}

        /* run */
        bool ret = false;
        while (dialog.run () == ResponseType.APPLY)
        {
            File? main_file = main_file_chooser.get_file ();

            if (main_file == null)
                continue;

            // main file not in directory
            if (!main_file_is_in_directory (dialog, main_file, project.directory))
                continue;

            ret = Projects.get_default ().change_main_file (project_id, main_file);
            break;
        }

        dialog.destroy ();
        return ret;
    }

    private enum ProjectColumn
    {
        DIRECTORY,
        MAIN_FILE,
        N_COLUMNS
    }

    public void manage_projects (MainWindow main_window)
    {
        Dialog dialog = GLib.Object.@new (typeof (Dialog), "use-header-bar", true, null)
            as Dialog;
        dialog.title = _("Manage Projects");
        dialog.destroy_with_parent = true;
        dialog.set_transient_for (main_window);

        Box content_area = dialog.get_content_area () as Box;
        content_area.set_size_request (450, 250);

        /* treeview */
        Gtk.ListStore store = new Gtk.ListStore (ProjectColumn.N_COLUMNS, typeof (string),
            typeof (string));
        update_model (store);

        TreeView treeview = new TreeView.with_model (store);

        // column directory
        TreeViewColumn column = new TreeViewColumn ();
        treeview.append_column (column);
        column.title = _("Directory");

        CellRendererPixbuf pixbuf_renderer = new CellRendererPixbuf ();
        pixbuf_renderer.icon_name = "folder";
        column.pack_start (pixbuf_renderer, false);

        CellRendererText text_renderer = new CellRendererText ();
        column.pack_start (text_renderer, true);
        column.set_attributes (text_renderer, "text", ProjectColumn.DIRECTORY, null);

        // column main file
        column = new TreeViewColumn ();
        treeview.append_column (column);
        column.title = _("Main File");

        pixbuf_renderer = new CellRendererPixbuf ();
        pixbuf_renderer.icon_name = "text-x-generic";
        column.pack_start (pixbuf_renderer, false);

        text_renderer = new CellRendererText ();
        column.pack_start (text_renderer, true);
        column.set_attributes (text_renderer, "text", ProjectColumn.MAIN_FILE, null);

        // selection
        TreeSelection select = treeview.get_selection ();
        select.set_mode (SelectionMode.SINGLE);

        // with scrollbar
        var sw = Utils.add_scrollbar (treeview);
        content_area.pack_start (sw);

        /* buttons */
        Grid grid = new Grid ();
        grid.orientation = Orientation.HORIZONTAL;
        grid.set_column_spacing (5);
        content_area.pack_start (grid, false, false, 5);

        Button edit_button = new Button.with_mnemonic (_("_Properties"));
        Button delete_button = new Button.with_mnemonic (_("_Delete"));
        Button clear_all_button = new Button.with_mnemonic (_("_Clear All"));

        grid.add (edit_button);
        grid.add (delete_button);
        grid.add (clear_all_button);

        content_area.show_all ();

        /* callbacks */
        edit_button.clicked.connect (() =>
        {
            int i = Utils.get_selected_row (treeview);
            if (i != -1 && configure_project (dialog, i))
                update_model (store);
        });

        delete_button.clicked.connect (() =>
        {
            TreeIter iter;
            int i = Utils.get_selected_row (treeview, out iter);
            if (i == -1)
                return;

            string directory;
            TreeModel model = (TreeModel) store;
            model.get (iter, ProjectColumn.DIRECTORY, out directory, -1);

            Dialog delete_dialog = new MessageDialog (dialog,
                DialogFlags.DESTROY_WITH_PARENT,
                MessageType.QUESTION, ButtonsType.NONE,
                _("Do you really want to delete the project “%s”?"),
                directory);

            delete_dialog.add_buttons (_("_Cancel"), ResponseType.CANCEL,
                _("_Delete"), ResponseType.YES);

            if (delete_dialog.run () == ResponseType.YES)
            {
                store.remove (ref iter);
                Projects.get_default ().delete (i);
            }

            delete_dialog.destroy ();
        });

        clear_all_button.clicked.connect (() =>
        {
            Dialog clear_dialog = new MessageDialog (dialog,
                DialogFlags.DESTROY_WITH_PARENT,
                MessageType.QUESTION,
                ButtonsType.NONE,
                "%s", _("Do you really want to clear all projects?"));

            clear_dialog.add_button (_("_Cancel"), ResponseType.CANCEL);
            clear_dialog.add_button (_("Clear _All"), ResponseType.YES);

            if (clear_dialog.run () == ResponseType.YES)
            {
                Projects.get_default ().clear_all ();
                store.clear ();
            }

            clear_dialog.destroy ();
        });

        dialog.run ();
        dialog.destroy ();
    }

    private bool main_file_is_in_directory (Window window, File main_file, File directory)
    {
        if (main_file.has_prefix (directory))
            return true;

        Dialog error_dialog = new MessageDialog (window,
            DialogFlags.DESTROY_WITH_PARENT,
            MessageType.ERROR,
            ButtonsType.OK,
            "%s", _("The Main File is not in the directory."));

        error_dialog.run ();
        error_dialog.destroy ();
        return false;
    }

    private void update_model (Gtk.ListStore model)
    {
        model.clear ();

        foreach (Project project in Projects.get_default ())
        {
            string uri_directory = project.directory.get_parse_name ();
            string uri_main_file = project.main_file.get_parse_name ();

            string dir = Latexila.utils_replace_home_dir_with_tilde (uri_directory) + "/";

            // relative path
            string main_file =
                uri_main_file[uri_directory.length + 1 : uri_main_file.length];

            TreeIter iter;
            model.append (out iter);
            model.set (iter,
                ProjectColumn.DIRECTORY, dir,
                ProjectColumn.MAIN_FILE, main_file,
                -1);
        }
    }
}
