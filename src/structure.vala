/*
 * This file is part of LaTeXila.
 *
 * Copyright © 2011 Sébastien Wilmet
 *
 * LaTeXila is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * LaTeXila is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with LaTeXila.  If not, see <http://www.gnu.org/licenses/>.
 */

using Gtk;

public enum StructType
{
    PART = 0,
    CHAPTER,
    SECTION,
    SUBSECTION,
    SUBSUBSECTION,
    PARAGRAPH,
    SUBPARAGRAPH,
    LABEL,
    INCLUDE,
    TABLE,
    FIGURE,
    TODO,
    FIXME,
    N_TYPES
}

public class Structure : VBox
{
    private unowned MainWindow _main_window;

    private ToggleButton[] _simple_list_buttons = {};
    private VPaned _vpaned;
    private Label _simple_list;
    private TreeView _tree_view;

    private static string[] _icons = null;
    private static string[] _names = null;

    public Structure (MainWindow main_window)
    {
        GLib.Object (spacing: 3);
        _main_window = main_window;

        init_toolbar ();
        init_vpaned ();
        init_simple_list ();
        init_tree_view ();
        show_all ();
        _simple_list.hide ();

        show.connect (connect_parsing);
        hide.connect (disconnect_parsing);
    }

    private void init_toolbar ()
    {
        HBox hbox = new HBox (true, 0);
        pack_start (hbox, false, false);

        // refresh button
        Button refresh_button = Utils.get_toolbar_button (Stock.REFRESH);
        refresh_button.tooltip_text = _("Refresh");
        hbox.pack_start (refresh_button);

        refresh_button.clicked.connect (() =>
        {
            show_document (_main_window.active_document, true);
        });

        // expand all button
        Button expand_button = Utils.get_toolbar_button (Stock.ZOOM_IN);
        expand_button.tooltip_text = _("Expand All");
        hbox.pack_start (expand_button);

        expand_button.clicked.connect (() => _tree_view.expand_all ());

        // collapse all button
        Button collapse_button = Utils.get_toolbar_button (Stock.ZOOM_OUT);
        collapse_button.tooltip_text = _("Collapse All");
        hbox.pack_start (collapse_button);

        collapse_button.clicked.connect (() => _tree_view.collapse_all ());

        // simple list buttons
        ToggleButton toggle_button = create_simple_list_button ({ StructType.LABEL },
            _("Show labels"));
        hbox.pack_start (toggle_button);

        toggle_button = create_simple_list_button ({ StructType.INCLUDE },
            _("Show files included"));
        hbox.pack_start (toggle_button);

        toggle_button = create_simple_list_button ({ StructType.TABLE },
            _("Show tables"));
        hbox.pack_start (toggle_button);

        toggle_button = create_simple_list_button ({ StructType.FIGURE },
            _("Show figures"));
        hbox.pack_start (toggle_button);

        toggle_button = create_simple_list_button ({ StructType.TODO, StructType.FIXME },
            _("Show TODOs and FIXMEs"));
        hbox.pack_start (toggle_button);
    }

    // Only one button can be activated at the same time.
    // If no button is selected, the simple list is hidden.
    // If a button is selected, the simple list contains only items specified by 'types'.
    private ToggleButton? create_simple_list_button (StructType[] types, string tooltip)
    {
        return_val_if_fail (types.length > 0, null);

        ToggleButton button =
            Utils.get_toolbar_toggle_button (get_icon_from_type (types[0]));

        button.tooltip_text = tooltip;

        _simple_list_buttons += button;

        button.clicked.connect (() =>
        {
            if (! button.get_active ())
            {
                _simple_list.hide ();
                return;
            }

            foreach (ToggleButton simple_list_button in _simple_list_buttons)
            {
                if (simple_list_button == button)
                    continue;

                simple_list_button.set_active (false);
            }

            _simple_list.show_all ();
        });

        return button;
    }

    private void init_vpaned ()
    {
        _vpaned = new VPaned ();
        pack_start (_vpaned);

        GLib.Settings settings = new GLib.Settings ("org.gnome.latexila.state.window");
        _vpaned.set_position (settings.get_int ("structure-paned-position"));
    }

    public void save_state ()
    {
        GLib.Settings settings = new GLib.Settings ("org.gnome.latexila.state.window");
        settings.set_int ("structure-paned-position", _vpaned.get_position ());
    }

    private void init_simple_list ()
    {
        _simple_list = new Label ("Simple list");
        _vpaned.add1 (_simple_list);
    }

    private void init_tree_view ()
    {
        _tree_view = new TreeView ();
        _tree_view.headers_visible = false;

        TreeViewColumn column = new TreeViewColumn ();
        _tree_view.append_column (column);

        // icon
        CellRendererPixbuf pixbuf_renderer = new CellRendererPixbuf ();
        column.pack_start (pixbuf_renderer, false);
        column.set_attributes (pixbuf_renderer, "stock-id", StructColumn.PIXBUF, null);

        // name
        CellRendererText text_renderer = new CellRendererText ();
        column.pack_start (text_renderer, true);
        column.set_attributes (text_renderer, "text", StructColumn.TEXT, null);

        // tooltip
        _tree_view.set_tooltip_column (StructColumn.TOOLTIP);

        // selection
        TreeSelection select = _tree_view.get_selection ();
        select.set_mode (SelectionMode.SINGLE);
        select.set_select_function (on_row_selection);

        // with a scrollbar
        Widget sw = Utils.add_scrollbar (_tree_view);
        _vpaned.add2 (sw);
    }

    private bool on_row_selection (TreeSelection selection, TreeModel model,
        TreePath path, bool path_currently_selected)
    {
        TreeIter tree_iter;
        if (! model.get_iter (out tree_iter, path))
            // the row is not selected
            return false;

        TextMark mark;
        model.get (tree_iter, StructColumn.MARK, out mark, -1);

        TextBuffer doc = mark.get_buffer ();
        return_val_if_fail (doc == _main_window.active_document, false);

        // place the cursor so the line is highlighted (by default)
        TextIter text_iter;
        doc.get_iter_at_mark (out text_iter, mark);
        doc.place_cursor (text_iter);
        // scroll to cursor, line at the top
        _main_window.active_view.scroll_to_mark (doc.get_insert (), 0, true, 0, 0);

        // the row is selected
        return true;
    }

    private void show_active_document ()
    {
        show_document (_main_window.active_document);
    }

    private void show_document (Document? doc, bool force_parse = false)
    {
        if (doc == null)
            return;

        _tree_view.set_model (null);
        _tree_view.columns_autosize ();

        DocumentStructure doc_struct = doc.get_structure ();

        if (force_parse)
            doc_struct.parse ();

        doc_struct.parsing_done.connect (() =>
        {
            _tree_view.set_model (doc_struct.get_model ());
            _tree_view.expand_all ();
        });
    }

    public void connect_parsing ()
    {
        _main_window.notify["active-document"].connect (show_active_document);
        show_active_document ();
    }

    public void disconnect_parsing ()
    {
        _main_window.notify["active-document"].disconnect (show_active_document);
    }

    // Here it's the general meaning of "section" (part -> subparagraph).
    // A label for example is not a section.
    public static bool is_section (StructType type)
    {
        return type <= StructType.SUBPARAGRAPH;
    }

    public static string get_icon_from_type (StructType type)
    {
        if (_icons == null)
        {
            _icons = new string[StructType.N_TYPES];
            _icons[StructType.PART]         = "tree_part";
            _icons[StructType.CHAPTER]      = "tree_chapter";
            _icons[StructType.SECTION]      = "tree_section";
            _icons[StructType.SUBSECTION]   = "tree_subsection";
            _icons[StructType.SUBSUBSECTION] = "tree_subsubsection";
            _icons[StructType.PARAGRAPH]    = "tree_paragraph";
            _icons[StructType.SUBPARAGRAPH] = "tree_paragraph";
            _icons[StructType.LABEL]        = "tree_label";
            _icons[StructType.TODO]         = "tree_todo";
            _icons[StructType.FIXME]        = "tree_todo";
            _icons[StructType.TABLE]        = "table";
            _icons[StructType.FIGURE]       = "image";
            _icons[StructType.INCLUDE]      = "tree_include";
        }

        return _icons[type];
    }

    public static string get_type_name (StructType type)
    {
        if (_names == null)
        {
            _names = new string[StructType.N_TYPES];
            _names[StructType.PART]         = _("Part");
            _names[StructType.CHAPTER]      = _("Chapter");
            _names[StructType.SECTION]      = _("Section");
            _names[StructType.SUBSECTION]   = _("Sub-section");
            _names[StructType.SUBSUBSECTION] = _("Sub-sub-section");
            _names[StructType.PARAGRAPH]    = _("Paragraph");
            _names[StructType.SUBPARAGRAPH] = _("Sub-paragraph");
            _names[StructType.LABEL]        = _("Label");
            _names[StructType.TODO]         = "TODO";
            _names[StructType.FIXME]        = "FIXME";
            _names[StructType.TABLE]        = _("Table");
            _names[StructType.FIGURE]       = _("Figure");
            _names[StructType.INCLUDE]      = _("File included");
        }

        return _names[type];
    }
}
