/*
 * This file is part of LaTeXila.
 *
 * Copyright © 2010-2012 Sébastien Wilmet
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

public class GotoLine : Grid
{
    private unowned MainWindow main_window;
    private ErrorEntry entry;

    public GotoLine (MainWindow main_window)
    {
        orientation = Orientation.HORIZONTAL;
        set_column_spacing (3);
        this.main_window = main_window;

        Button close_button = new Button ();
        add (close_button);
        close_button.set_relief (ReliefStyle.NONE);
        Image img = new Image.from_stock (Stock.CLOSE, IconSize.MENU);
        close_button.add (img);
        close_button.clicked.connect (() => hide ());

        Label label = new Label (_("Go to Line:"));
        label.margin_left = 2;
        label.margin_right = 2;
        add (label);

        entry = new ErrorEntry ();
        add (entry);
        Icon icon = new ThemedIcon.with_default_fallbacks ("go-jump-symbolic");
        entry.set_icon_from_gicon (EntryIconPosition.SECONDARY, icon);
        entry.set_icon_activatable (EntryIconPosition.SECONDARY, true);
        entry.set_tooltip_text (_("Line you want to move the cursor to"));
        entry.set_size_request (100, -1);
        entry.activate.connect (() => hide ());
        entry.icon_press.connect (() => hide ());
        entry.changed.connect (on_changed);
    }

    public new void show ()
    {
        entry.text = "";
        show_all ();
        entry.grab_focus ();
    }

    private void on_changed ()
    {
        if (entry.text_length == 0)
        {
            entry.error = false;
            return;
        }

        string text = entry.get_text ();

        // check if all characters are digits
        for (int i = 0 ; i < text.length ; i++)
        {
            unichar c = text[i];
            if (! c.isdigit ())
            {
                entry.error = true;
                return;
            }
        }

        int line = int.parse (text);
        entry.error = ! main_window.active_document.goto_line (--line);
        main_window.active_view.scroll_to_cursor ();
    }
}

public class SearchAndReplace : GLib.Object
{
    private unowned MainWindow _main_window;

    private Grid _main_grid;
    private Grid _replace_grid;

    private Arrow _arrow;

    private SearchEntry _entry_find;
    private SearchEntry _entry_replace;

    private SourceSearchSettings _search_settings;
    private SourceSearchContext? _search_context = null;

    private enum Mode
    {
        SEARCH,
        SEARCH_AND_REPLACE
    }

    private Mode get_mode ()
    {
        return _arrow.arrow_type == ArrowType.UP ? Mode.SEARCH_AND_REPLACE : Mode.SEARCH;
    }

    public SearchAndReplace (MainWindow main_window)
    {
        _main_window = main_window;

        _search_settings = new SourceSearchSettings ();
        _search_settings.set_wrap_around (true);

        _main_grid = new Grid ();
        _main_grid.set_column_spacing (3);
        _main_grid.set_row_spacing (3);

        /* Arrow */
        Button button_arrow = new Button ();
        _arrow = new Arrow (ArrowType.DOWN, ShadowType.OUT);
        button_arrow.add (_arrow);
        _main_grid.attach (button_arrow, 0, 0, 1, 1);

        /* Find entry */
        Grid find_grid = new Grid ();
        find_grid.set_orientation (Orientation.HORIZONTAL);
        find_grid.set_column_spacing (2);
        _main_grid.attach (find_grid, 1, 0, 1, 1);

        init_find_entry ();
        find_grid.add (_entry_find);

        /* Buttons at the right of the find entry */
        Button button_previous = get_button (Stock.GO_UP);
        Button button_next = get_button (Stock.GO_DOWN);
        Button button_close = get_button (Stock.CLOSE);

        find_grid.add (button_previous);
        find_grid.add (button_next);
        find_grid.add (button_close);

        button_previous.sensitive = false;
        button_next.sensitive = false;

        /* Replace entry */
        _replace_grid = new Grid ();
        _replace_grid.set_orientation (Orientation.HORIZONTAL);
        _replace_grid.set_column_spacing (2);
        _main_grid.attach (_replace_grid, 1, 1, 1, 1);

        _entry_replace = new SearchEntry ();
        _entry_replace.set_tooltip_text (_("Replace with"));
        _entry_replace.can_focus = true;
        _entry_replace.set_width_chars (25);
        _entry_replace.primary_icon_gicon = null;
        _replace_grid.add (_entry_replace);

        /* Buttons at the right of the replace entry */
        Button button_replace = get_button (Stock.FIND_AND_REPLACE);
        button_replace.set_tooltip_text (_("Replace"));

        // replace all: image + label
        Button button_replace_all = new Button ();
        button_replace_all.set_tooltip_text (_("Replace All"));
        button_replace_all.set_relief (ReliefStyle.NONE);
        Grid replace_all_grid = new Grid ();
        replace_all_grid.set_orientation (Orientation.HORIZONTAL);
        replace_all_grid.set_column_spacing (8);

        Image image = new Image.from_stock (Stock.FIND_AND_REPLACE, IconSize.MENU);
        replace_all_grid.add (image);

        Label label = new Label (_("All"));
        replace_all_grid.add (label);
        button_replace_all.add (replace_all_grid);

        _replace_grid.add (button_replace);
        _replace_grid.add (button_replace_all);

        button_replace.sensitive = false;
        button_replace_all.sensitive = false;

        /* signal handlers */

        button_arrow.clicked.connect (() =>
        {
            // search and replace -> search
            if (get_mode () == Mode.SEARCH_AND_REPLACE)
            {
                _arrow.arrow_type = ArrowType.DOWN;
                _replace_grid.hide ();
            }

            // search -> search and replace
            else
            {
                _arrow.arrow_type = ArrowType.UP;
                _replace_grid.show ();
            }
        });

        button_close.clicked.connect (hide);

        button_previous.clicked.connect (() =>
        {
            if (_search_context == null)
                return;

            TextIter iter;
            TextIter match_start;
            TextIter match_end;

            Document doc = _search_context.get_buffer () as Document;
            doc.get_selection_bounds (out iter, null);

            if (_search_context.backward (iter, out match_start, out match_end))
            {
                doc.select_range (match_start, match_end);
                doc.tab.view.scroll_to_cursor ();
            }
        });

        button_next.clicked.connect (search_forward);
        _entry_find.activate.connect (search_forward);

        _entry_find.changed.connect (() =>
        {
            bool sensitive = _entry_find.text_length > 0;
            button_previous.sensitive = sensitive;
            button_next.sensitive = sensitive;
            button_replace.sensitive = sensitive;
            button_replace_all.sensitive = sensitive;
        });

        button_replace.clicked.connect (replace);
        _entry_replace.activate.connect (replace);

        button_replace_all.clicked.connect (() =>
        {
            if (_search_context != null)
            {
                try
                {
                    _search_context.replace_all (_entry_replace.text, -1);
                }
                catch (Error e)
                {
                    /* Do nothing. An error can occur only for a regex search. */
                }
            }
        });

        _entry_find.key_press_event.connect ((event) =>
        {
            switch (event.keyval)
            {
                case Gdk.Key.Tab:
                    // TAB in find => go to replace
                    show_search_and_replace ();
                    _entry_replace.grab_focus ();
                    return true;

                case Gdk.Key.Escape:
                    hide ();
                    return true;

                default:
                    // propagate the event further
                    return false;
            }
        });

        _main_grid.hide ();
    }

    private void init_find_entry ()
    {
        _entry_find = new SearchEntry ();
        _entry_find.primary_icon_gicon =
            new ThemedIcon.with_default_fallbacks ("document-properties-symbolic");
        _entry_find.primary_icon_activatable = true;
        _entry_find.primary_icon_sensitive = true;
        _entry_find.set_tooltip_text (_("Search for"));
        _entry_find.can_focus = true;
        _entry_find.set_width_chars (25);

        _entry_find.bind_property ("text", _search_settings, "search-text",
            BindingFlags.DEFAULT);

        /* Options menu */
        Gtk.Menu menu = new Gtk.Menu ();

        CheckMenuItem check_case_sensitive =
            new CheckMenuItem.with_label (_("Case sensitive"));

        CheckMenuItem check_entire_word =
            new CheckMenuItem.with_label (_("Entire words only"));

        menu.append (check_case_sensitive);
        menu.append (check_entire_word);
        menu.show_all ();

        check_case_sensitive.bind_property ("active",
            _search_settings, "case-sensitive",
            BindingFlags.DEFAULT);

        check_entire_word.bind_property ("active",
            _search_settings, "at-word-boundaries",
            BindingFlags.DEFAULT);

        _entry_find.icon_press.connect ((icon_pos, event) =>
        {
            if (icon_pos == EntryIconPosition.PRIMARY)
                menu.popup (null, null, null, event.button.button, event.button.time);
        });
    }

    private Button get_button (string stock_id)
    {
        Button button = new Button ();
        Image image = new Image.from_stock (stock_id, IconSize.MENU);
        button.add (image);
        button.set_relief (ReliefStyle.NONE);
        return button;
    }

    public Widget get_widget ()
    {
        return _main_grid;
    }

    public void show_search ()
    {
        _arrow.arrow_type = ArrowType.DOWN;
        show ();
        _replace_grid.hide ();
    }

    public void show_search_and_replace ()
    {
        _arrow.arrow_type = ArrowType.UP;
        show ();
    }

    private void show ()
    {
        return_if_fail (_main_window.active_tab != null);

        _main_grid.show_all ();
        _entry_find.grab_focus ();

        // if text is selected in the active document, and if this text contains no \n,
        // search this text
        Document doc = _main_window.active_document;
        if (doc.get_selection_type () == SelectionType.ONE_LINE)
        {
            TextIter start, end;
            doc.get_selection_bounds (out start, out end);
            _entry_find.text = doc.get_text (start, end, false);
        }

        _main_window.notify["active-document"].connect (connect_active_document);
        connect_active_document ();
    }

    public void hide ()
    {
        _main_window.notify["active-document"].disconnect (connect_active_document);
        _search_context = null;

        _main_grid.hide ();

        if (_main_window.active_view != null)
            _main_window.active_view.grab_focus ();
    }

    private void connect_active_document ()
    {
        if (_main_window.active_document == null)
        {
            _search_context = null;
        }
        else
        {
            _search_context = new SourceSearchContext (_main_window.active_document,
                _search_settings);

            bool readonly = _main_window.active_document.readonly;
            _replace_grid.set_sensitive (! readonly);
        }
    }

    private void search_forward ()
    {
        if (_search_context == null)
            return;

        TextIter iter;
        TextIter match_start;
        TextIter match_end;

        Document doc = _search_context.get_buffer () as Document;
        doc.get_selection_bounds (null, out iter);

        if (_search_context.forward (iter, out match_start, out match_end))
        {
            doc.select_range (match_start, match_end);
            doc.tab.view.scroll_to_cursor ();
        }
    }

    private void replace ()
    {
        if (_search_context == null)
            return;

        TextIter match_start;
        TextIter match_end;
        SourceBuffer buffer = _search_context.get_buffer ();
        buffer.get_selection_bounds (out match_start, out match_end);

        try
        {
            _search_context.replace (match_start, match_end, _entry_replace.text, -1);
        }
        catch (Error e)
        {
            /* Do nothing. An error can occur only for a regex search. */
        }

        search_forward ();
    }
}
