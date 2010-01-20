/*
 * This file is part of LaTeXila.
 *
 * Copyright © 2009, 2010 Sébastien Wilmet
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

#ifndef CALLBACKS_H
#define CALLBACKS_H

void cb_open (void);
void cb_save (void);
void cb_save_as (void);
void cb_close (void);
void cb_close_tab (GtkWidget *widget, GtkWidget *child);
void cb_quit (void);
void cb_undo (void);
void cb_redo (void);
void cb_cut (void);
void cb_copy (void);
void cb_paste (void);
void cb_delete (void);
void cb_select_all (void);
void cb_zoom_in (void);
void cb_zoom_out (void);
void cb_zoom_reset (void);
void cb_find (void);
void cb_close_find (GtkWidget *widget, gpointer user_data);
void cb_find_entry (GtkEntry *entry, gpointer user_data);
void cb_find_next (GtkWidget *widget, gpointer user_data);
void cb_find_previous (GtkWidget *widget, gpointer user_data);
void cb_close_replace (GtkWidget *widget, gpointer user_data);
void cb_replace_find (GtkWidget *widget, gpointer user_data);
void cb_replace_replace (GtkWidget *widget, gpointer user_data);
void cb_replace_replace_all (GtkWidget *widget, gpointer user_data);
void cb_replace (void);
void cb_go_to_line (void);
void cb_close_go_to_line (GtkWidget *widget, gpointer user_data);
void cb_go_to_line_entry (GtkEntry *entry, gpointer user_data);
void cb_latex (void);
void cb_pdflatex (void);
void cb_view_dvi (void);
void cb_view_pdf (void);
void cb_view_ps (void);
void cb_dvi_to_pdf (void);
void cb_dvi_to_ps (void);
void cb_bibtex (void);
void cb_makeindex (void);
void cb_clean_up_build_files (void);
void cb_stop_execution (void);
void cb_tools_comment (void);
void cb_tools_uncomment (void);
void cb_tools_indent (void);
void cb_tools_unindent (void);
void cb_documents_save_all (void);
void cb_documents_close_all (void);
void cb_documents_previous (void);
void cb_documents_next (void);
void cb_help_latex_reference (void);
void cb_about_dialog (void);
void cb_text_changed (GtkWidget *widget, gpointer user_data);
void cb_cursor_moved (GtkTextBuffer *text_buffer, GtkTextIter *location,
		GtkTextMark *mark, gpointer user_data);
void cb_page_change (GtkNotebook *notebook, GtkNotebookPage *page,
		guint page_num, gpointer user_data);
void cb_page_reordered (GtkNotebook *notebook, GtkWidget *child, guint page_num,
		gpointer user_data);
gboolean cb_delete_event (GtkWidget *widget, GdkEvent *event,
		gpointer user_data);
void cb_recent_item_activated (GtkRecentAction *action, gpointer user_data);
void cb_show_side_pane (GtkToggleAction *toggle_action, gpointer user_data);
void cb_show_edit_toolbar (GtkToggleAction *toggle_action, gpointer user_data);

void open_new_document_without_uri (const gchar *filename);
void open_new_document (const gchar *filename, const gchar *uri);
void change_font_source_view (void);
void create_document_in_new_tab (const gchar *path, const gchar *text,
		const gchar *title);

#endif /* CALLBACKS_H */
