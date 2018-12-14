/*
 * This file is part of LaTeXila.
 *
 * Copyright © 2009 Sébastien Wilmet
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

#ifndef PREFS_H
#define PREFS_H

void load_preferences (preferences_t *prefs);
void save_preferences (preferences_t *prefs);
void set_current_font_prefs (preferences_t *prefs);
void cb_preferences (void);

enum style_schemes
{
	COLUMN_STYLE_SCHEME_ID,
	COLUMN_STYLE_SCHEME_DESC,
	N_COLUMNS_STYLE_SCHEMES
};

#endif /* PREFS_H */
