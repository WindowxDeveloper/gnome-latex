/*
 * This file is part of LaTeXila.
 *
 * Copyright © 2010-2011, 2017 Sébastien Wilmet
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

public class LatexMenu : Gtk.ActionGroup
{
    private const Gtk.ActionEntry[] latex_action_entries =
    {
        // LaTeX

        { "Latex", null, "_LaTeX" },

        // LaTeX: Sectioning

        { "Sectioning", "sectioning", N_("_Sectioning") },
        { "SectioningPart", null, "\\_part", null,
            N_("Part") },
        { "SectioningChapter", null, "\\_chapter", null,
            N_("Chapter") },
        { "SectioningSection", null, "\\_section", null,
            N_("Section") },
        { "SectioningSubsection", null, "\\s_ubsection", null,
            N_("Sub-section") },
        { "SectioningSubsubsection", null, "\\su_bsubsection", null,
            N_("Sub-sub-section") },
        { "SectioningParagraph", null, "\\p_aragraph", null,
            N_("Paragraph") },
        { "SectioningSubparagraph", null, "\\subpa_ragraph", null,
            N_("Sub-paragraph") },

        // LaTeX: References

        { "References", "references", N_("_References") },
        { "ReferencesLabel", null, "\\_label", null,
            N_("Label") },
        { "ReferencesRef", null, "\\_ref", null,
            N_("Reference to a label") },
        { "ReferencesPageref", null, "\\_pageref", null,
            N_("Page reference to a label") },
        { "ReferencesIndex", null, "\\_index", null,
            N_("Add a word to the index") },
        { "ReferencesFootnote", null, "\\_footnote", null,
            N_("Footnote") },
        { "ReferencesCite", null, "\\_cite", null,
            N_("Reference to a bibliography item") },

        // LaTeX: Environments

        { "Environments", "format-justify-center", "_Environments" },
        { "EnvCenter", "format-justify-center", "\\begin{_center}", null,
            N_("Center - \\begin{center}") },
        { "EnvLeft", "format-justify-left", "\\begin{flush_left}", null,
            N_("Align Left - \\begin{flushleft}") },
        { "EnvRight", "format-justify-right", "\\begin{flush_right}", null,
            N_("Align Right - \\begin{flushright}") },
        { "EnvFigure", "image-x-generic", "\\begin{_figure}", null,
            N_("Figure - \\begin{figure}") },
        { "EnvTable", "table", "\\begin{_table}", null,
            N_("Table - \\begin{table}") },
        { "EnvQuote", null, "\\begin{_quote}", null,
            N_("Quote - \\begin{quote}") },
        { "EnvQuotation", null, "\\begin{qu_otation}", null,
            N_("Quotation - \\begin{quotation}") },
        { "EnvVerse", null, "\\begin{_verse}", null,
            N_("Verse - \\begin{verse}") },
        { "EnvVerbatim", null, "\\begin{ver_batim}", null,
            N_("Verbatim - \\begin{verbatim}") },
        { "EnvMinipage", null, "\\begin{_minipage}", null,
            N_("Minipage - \\begin{minipage}") },
        { "EnvTitlepage", null, "\\begin{titlepage}", null,
            N_("Title page - \\begin{titlepage}") },

        // LaTeX: list environments

        { "ListEnvironments", "list-itemize", N_("_List Environments") },
        { "ListEnvItemize", "list-itemize", "\\begin{_itemize}", null,
            N_("Bulleted List - \\begin{itemize}") },
        { "ListEnvEnumerate", "list-enumerate", "\\begin{_enumerate}", null,
            N_("Enumeration - \\begin{enumerate}") },
        { "ListEnvDescription", "list-description", "\\begin{_description}", null,
            N_("Description - \\begin{description}") },
        { "ListEnvList", null, "\\begin{_list}", null,
            N_("Custom list - \\begin{list}") },
        { "ListEnvItem", "list-item", "\\i_tem", "<Alt><Shift>H",
            N_("List item - \\item") },

        // LaTeX: character sizes

        { "CharacterSize", "character-size", N_("_Characters Sizes") },
        { "CharacterSizeTiny", null, "_tiny", null, "tiny" },
        { "CharacterSizeScriptsize", null, "_scriptsize", null, "scriptsize" },
        { "CharacterSizeFootnotesize", null, "_footnotesize", null, "footnotesize" },
        { "CharacterSizeSmall", null, "s_mall", null, "small" },
        { "CharacterSizeNormalsize", null, "_normalsize", null, "normalsize" },
        { "CharacterSizelarge", null, "_large", null, "large" },
        { "CharacterSizeLarge", null, "L_arge", null, "Large" },
        { "CharacterSizeLARGE", null, "LA_RGE", null, "LARGE" },
        { "CharacterSizehuge", null, "_huge", null, "huge" },
        { "CharacterSizeHuge", null, "H_uge", null, "Huge" },

        // LaTeX: font styles

        { "FontStyles", "bold", N_("_Font Styles") },
        { "Bold", "bold", "\\text_bf", "<Control>B",
            N_("Bold - \\textbf") },
        { "Italic", "italic", "\\text_it", "<Control>I",
            N_("Italic - \\textit") },
        { "Typewriter", "typewriter", "\\text_tt", "<Alt><Shift>T",
            N_("Typewriter - \\texttt") },
        { "Slanted", "slanted", "\\text_sl", "<Alt><Shift>S",
            N_("Slanted - \\textsl") },
        { "SmallCaps", "small_caps", "\\texts_c", "<Alt><Shift>C",
            N_("Small Capitals - \\textsc") },
        { "SansSerif", "sans_serif", "\\texts_f", null,
            N_("Sans Serif - \\textsf") },
        { "Emph", null, "\\_emph", "<Control>E",
            N_("Emphasized - \\emph") },
        { "Underline", "underline", "\\_underline", "<Control>U",
            N_("Underline - \\underline") },

        { "FontFamily", null, N_("_Font Family") },
        { "FontFamilyRoman", "roman", "\\_rmfamily", null,
            N_("Roman - \\rmfamily") },
        { "FontFamilySansSerif", "sans_serif", "\\_sffamily", null,
            N_("Sans Serif - \\sffamily") },
        { "FontFamilyMonospace", "typewriter", "\\_ttfamily", null,
            N_("Monospace - \\ttfamily") },

        { "FontSeries", null, N_("F_ont Series") },
        { "FontSeriesMedium", "roman", "\\_mdseries", null,
            N_("Medium - \\mdseries") },
        { "FontSeriesBold", "bold", "\\_bfseries", null,
            N_("Bold - \\bfseries") },

        { "FontShape", null, N_("Fo_nt Shape") },
        { "FontShapeUpright", "roman", "\\_upshape", null,
            N_("Upright - \\upshape") },
        { "FontShapeItalic", "italic", "\\_itshape", null,
            N_("Italic - \\itshape") },
        { "FontShapeSlanted", "slanted", "\\_slshape", null,
            N_("Slanted - \\slshape") },
        { "FontShapeSmallCaps", "small_caps", "\\s_cshape", null,
            N_("Small Capitals - \\scshape") },

        // LaTeX: Tabular

        { "Tabular", "table", N_("_Tabular") },
        { "TabularTabbing", null, "\\begin{ta_bbing}", null,
            N_("Tabbing - \\begin{tabbing}") },
        { "TabularTabular", null, "\\begin{_tabular}", null,
            N_("Tabular - \\begin{tabular}") },
        { "TabularMulticolumn", null, "\\_multicolumn", null,
            N_("Multicolumn - \\multicolumn") },
        { "TabularHline", null, "\\_hline", null,
            N_("Horizontal line - \\hline") },
        { "TabularVline", null, "\\_vline", null,
            N_("Vertical line - \\vline") },
        { "TabularCline", null, "\\_cline", null,
            N_("Horizontal line (columns specified) - \\cline") },

        // LaTeX: Presentation

        { "Presentation", "x-office-presentation", "_Presentation" },
        { "PresentationFrame", null, "\\begin{frame}", null,
            N_("Frame - \\begin{frame}"), on_present_frame },
        { "PresentationBlock", null, "\\begin{block}", null,
            N_("Block - \\begin{block}"), on_present_block },
        { "PresentationColumns", null, "\\begin{columns}", null,
            N_("Two columns - \\begin{columns}"), on_present_columns },

        // LaTeX: Spacing

        { "Spacing", null, N_("_Spacing") },
        { "SpacingNewLine", null, N_("New _Line"), null,
            N_("New Line - \\\\") },
        { "SpacingNewPage", null, "\\new_page", null,
            N_("New page - \\newpage") },
        { "SpacingLineBreak", null, "\\l_inebreak", null,
            N_("Line break - \\linebreak") },
        { "SpacingPageBreak", null, "\\p_agebreak", null,
            N_("Page break - \\pagebreak") },
        { "SpacingBigSkip", null, "\\_bigskip", null,
            N_("Big skip - \\bigskip") },
        { "SpacingMedSkip", null, "\\_medskip", null,
            N_("Medium skip - \\medskip") },
        { "SpacingHSpace", null, "\\_hspace", null,
            N_("Horizontal space - \\hspace") },
        { "SpacingVSpace", null, "\\_vspace", null,
            N_("Vertical space - \\vspace") },
        { "SpacingNoIndent", null, "\\_noindent", null,
            N_("No paragraph indentation - \\noindent") },

        // LaTeX: International accents

        { "Accents", null, N_("International _Accents") },
        { "Accent0", "accent0", "\\'", null, N_("Acute accent - \\'") },
        { "Accent1", "accent1", "\\`", null, N_("Grave accent - \\`") },
        { "Accent2", "accent2", "\\^", null, N_("Circumflex accent - \\^") },
        { "Accent3", "accent3", "\\\"", null, N_("Trema - \\\"") },
        { "Accent4", "accent4", "\\~", null, N_("Tilde - \\~") },
        { "Accent5", "accent5", "\\=", null, N_("Macron - \\=") },
        { "Accent6", "accent6", "\\.", null, N_("Dot above - \\.") },
        { "Accent7", "accent7", "\\v", null, N_("Caron - \\v") },
        { "Accent8", "accent8", "\\u", null, N_("Breve - \\u") },
        { "Accent9", "accent9", "\\H", null,
            N_("Double acute accent - \\H") },
        { "Accent10", "accent10", "\\c", null, N_("Cedilla - \\c") },
        { "Accent11", "accent11", "\\k", null, N_("Ogonek - \\k") },
        { "Accent12", "accent12", "\\d", null, N_("Dot below - \\d") },
        { "Accent13", "accent13", "\\b", null, N_("Macron below - \\b") },
        { "Accent14", "accent14", "\\r", null, N_("Ring - \\r") },
        { "Accent15", "accent15", "\\t", null, N_("Tie - \\t") },

        // LaTeX: Others

        { "LatexMisc", null, N_("_Misc") },
        { "LatexDocumentClass", null, "\\_documentclass", null,
            N_("Document class - \\documentclass"), on_documentclass },
        { "LatexUsepackage", null, "\\_usepackage", null,
            N_("Use package - \\usepackage"), on_usepackage },
        { "LatexAMS", null, N_("_AMS packages"), null,
            N_("AMS packages"), on_ams_packages },
        { "LatexAuthor", null, "\\au_thor", null, N_("Author - \\author"), on_author },
        { "LatexTitle", null, "\\t_itle", null, N_("Title - \\title"), on_title },
        { "LatexBeginDocument", null, "\\begin{d_ocument}", null,
            N_("Content of the document - \\begin{document}"), on_begin_document },
        { "LatexMakeTitle", null, "\\_maketitle", null,
            N_("Make title - \\maketitle"), on_maketitle },
        { "LatexTableOfContents", null, "\\tableof_contents", null,
            N_("Table of contents - \\tableofcontents"), on_tableofcontents },
        { "LatexAbstract", null, "\\begin{abst_ract}", null,
            N_("Abstract - \\begin{abstract}"), on_abstract },
        { "LatexIncludeGraphics", null, "\\include_graphics", null,
            N_("Include an image (graphicx package) - \\includegraphics"),
            on_include_graphics },
        { "LatexInput", null, "\\_input", null,
            N_("Include a file - \\input"), on_input },

        // Math

        { "Math", null, N_("_Math") },

        // Math Environments

        { "MathEnvironments", null, N_("_Math Environments") },
        { "MathEnvNormal", null, N_("_Mathematical Environment - $...$"),
            "<Alt><Shift>M", N_("Mathematical Environment - $...$"), on_math_env_normal },
        { "MathEnvCentered", null, N_("_Centered Formula - \\[...\\]"),
            "<Alt><Shift>E", N_("Centered Formula - \\[...\\]"), on_math_env_centered },
        { "MathEnvNumbered", null,
            N_("_Numbered Equation - \\begin{equation}"), null,
            N_("Numbered Equation - \\begin{equation}"), on_math_env_numbered },
        { "MathEnvArray", null, N_("_Array of Equations - \\begin{align*}"), null,
            N_("Array of Equations - \\begin{align*}"), on_math_env_array },
        { "MathEnvNumberedArray", null,
            N_("Numbered Array of _Equations - \\begin{align}"), null,
            N_("Numbered Array of Equations - \\begin{align}"),
            on_math_env_numbered_array },

        { "MathSuperscript", "math-superscript", N_("_Superscript - ^{}"), null,
            N_("Superscript - ^{}"), on_math_superscript },
        { "MathSubscript", "math-subscript", N_("Su_bscript - __{}"), null,
            N_("Subscript - _{}"), on_math_subscript },
        { "MathFrac", "math-frac", N_("_Fraction - \\frac{}{}"), "<Alt><Shift>F",
            N_("Fraction - \\frac{}{}"), on_math_frac },
        { "MathSquareRoot", "math-square-root", N_("Square _Root - \\sqrt{}"), null,
            N_("Square Root - \\sqrt{}"), on_math_square_root },
        { "MathNthRoot", "math-nth-root", N_("_N-th Root - \\sqrt[]{}"), null,
            N_("N-th Root - \\sqrt[]{}"), on_math_nth_root },

        // Math functions

        { "MathFunctions", null, N_("Math _Functions") },
        { "MathFuncArccos", null, "\\arccos", null, null, on_math_func_arccos },
        { "MathFuncArcsin", null, "\\arcsin", null, null, on_math_func_arcsin },
        { "MathFuncArctan", null, "\\arctan", null, null, on_math_func_arctan },
        { "MathFuncCos", null, "\\cos", null, null, on_math_func_cos },
        { "MathFuncCosh", null, "\\cosh", null, null, on_math_func_cosh },
        { "MathFuncCot", null, "\\cot", null, null, on_math_func_cot },
        { "MathFuncCoth", null, "\\coth", null, null, on_math_func_coth },
        { "MathFuncCsc", null, "\\csc", null, null, on_math_func_csc },
        { "MathFuncDeg", null, "\\deg", null, null, on_math_func_deg },
        { "MathFuncDet", null, "\\det", null, null, on_math_func_det },
        { "MathFuncDim", null, "\\dim", null, null, on_math_func_dim },
        { "MathFuncExp", null, "\\exp", null, null, on_math_func_exp },
        { "MathFuncGcd", null, "\\gcd", null, null, on_math_func_gcd },
        { "MathFuncHom", null, "\\hom", null, null, on_math_func_hom },
        { "MathFuncInf", null, "\\inf", null, null, on_math_func_inf },
        { "MathFuncKer", null, "\\ker", null, null, on_math_func_ker },
        { "MathFuncLg", null, "\\lg", null, null, on_math_func_lg },
        { "MathFuncLim", null, "\\lim", null, null, on_math_func_lim },
        { "MathFuncLiminf", null, "\\liminf", null, null, on_math_func_liminf },
        { "MathFuncLimsup", null, "\\limsup", null, null, on_math_func_limsup },
        { "MathFuncLn", null, "\\ln", null, null, on_math_func_ln },
        { "MathFuncLog", null, "\\log", null, null, on_math_func_log },
        { "MathFuncMax", null, "\\max", null, null, on_math_func_max },
        { "MathFuncMin", null, "\\min", null, null, on_math_func_min },
        { "MathFuncSec", null, "\\sec", null, null, on_math_func_sec },
        { "MathFuncSin", null, "\\sin", null, null, on_math_func_sin },
        { "MathFuncSinh", null, "\\sinh", null, null, on_math_func_sinh },
        { "MathFuncSup", null, "\\sup", null, null, on_math_func_sup },
        { "MathFuncTan", null, "\\tan", null, null, on_math_func_tan },
        { "MathFuncTanh", null, "\\tanh", null, null, on_math_func_tanh },

        // Math Font Styles

        { "MathFontStyles", null, N_("Math Font _Styles") },
        { "MathFSrm", "roman", "\\math_rm", null,
            N_("Roman - \\mathrm"), on_math_font_style_rm },
        { "MathFSit", "italic", "\\math_it", null,
            N_("Italic - \\mathit"), on_math_font_style_it },
        { "MathFSbf", "bold", "\\math_bf", null,
            N_("Bold - \\mathbf"), on_math_font_style_bf },
        { "MathFSsf", "sans_serif", "\\math_sf", null,
            N_("Sans Serif - \\mathsf"), on_math_font_style_sf },
        { "MathFStt", "typewriter", "\\math_tt", null,
            N_("Typewriter - \\mathtt"), on_math_font_style_tt },
        { "MathFScal", "mathcal", "\\math_cal", null,
            N_("Calligraphic - \\mathcal"), on_math_font_style_cal },
        { "MathFSbb", "blackboard", "\\_mathbb", null,
            N_("Blackboard (uppercase only)  - \\mathbb (amsfonts package)"),
            on_math_font_style_bb },
        { "MathFSfrak", "mathfrak", "\\math_frak", null,
            N_("Euler Fraktur - \\mathfrak (amsfonts package)"),
            on_math_font_style_frak },

        // Math Accents

        { "MathAccents", null, N_("Math _Accents") },
        { "MathAccentAcute", "mathaccent0", "\\_acute", null,
            null, on_math_accent_acute },
        { "MathAccentGrave", "mathaccent1", "\\_grave", null,
        null, on_math_accent_grave },
        { "MathAccentTilde", "mathaccent2", "\\_tilde", null,
            null, on_math_accent_tilde },
        { "MathAccentBar", "mathaccent3", "\\_bar", null, null, on_math_accent_bar },
        { "MathAccentVec", "mathaccent4", "\\_vec", null, null, on_math_accent_vec },
        { "MathAccentHat", "mathaccent5", "\\_hat", null, null, on_math_accent_hat },
        { "MathAccentCheck", "mathaccent6", "\\_check", null,
            null, on_math_accent_check },
        { "MathAccentBreve", "mathaccent7", "\\b_reve", null,
            null, on_math_accent_breve },
        { "MathAccentDot", "mathaccent8", "\\_dot", null, null, on_math_accent_dot },
        { "MathAccentDdot", "mathaccent9", "\\dd_ot", null, null, on_math_accent_ddot },
        { "MathAccentRing", "mathaccent10", "\\_mathring", null,
            null, on_math_accent_ring },

        // Math Spaces

        { "MathSpaces", null, N_("Math _Spaces") },
        { "MathSpaceSmall", null, N_("_Small"), null,
            N_("Small - \\,"), on_math_space_small },
        { "MathSpaceMedium", null, N_("_Medium"), null,
            N_("Medium - \\:"), on_math_space_medium },
        { "MathSpaceLarge", null, N_("_Large"), null,
            N_("Large - \\;"), on_math_space_large },
        { "MathSpaceQuad", null, "\\_quad", null, null, on_math_space_quad },
        { "MathSpaceQquad", null, "\\qqu_ad", null, null, on_math_space_qquad },

        // Math: Left Delimiters

        { "MathLeftDelimiters", "delimiters-left", N_("_Left Delimiters") },
        { "MathLeftDelimiter1", null, N_("left ("), null,
            null, on_math_left_delimiter_1 },
        { "MathLeftDelimiter2", null, N_("left ["), null,
            null, on_math_left_delimiter_2 },
        { "MathLeftDelimiter3", null, N_("left { "), null,
            null, on_math_left_delimiter_3 },
        { "MathLeftDelimiter4", null, N_("left <"), null,
            null, on_math_left_delimiter_4 },
        { "MathLeftDelimiter5", null, N_("left )"), null,
            null, on_math_left_delimiter_5 },
        { "MathLeftDelimiter6", null, N_("left ]"), null,
            null, on_math_left_delimiter_6 },
        { "MathLeftDelimiter7", null, N_("left  }"), null,
            null, on_math_left_delimiter_7 },
        { "MathLeftDelimiter8", null, N_("left >"), null,
            null, on_math_left_delimiter_8 },
        { "MathLeftDelimiter9", null, N_("left ."), null,
            null, on_math_left_delimiter_9 },

        // Math: Right Delimiters

        { "MathRightDelimiters", "delimiters-right", N_("Right _Delimiters") },
        { "MathRightDelimiter1", null, N_("right )"), null,
            null, on_math_right_delimiter_1 },
        { "MathRightDelimiter2", null, N_("right ]"), null,
            null, on_math_right_delimiter_2 },
        { "MathRightDelimiter3", null, N_("right  }"), null,
            null, on_math_right_delimiter_3 },
        { "MathRightDelimiter4", null, N_("right >"), null,
            null, on_math_right_delimiter_4 },
        { "MathRightDelimiter5", null, N_("right ("), null,
            null, on_math_right_delimiter_5 },
        { "MathRightDelimiter6", null, N_("right ["), null,
            null, on_math_right_delimiter_6 },
        { "MathRightDelimiter7", null, N_("right { "), null,
            null, on_math_right_delimiter_7 },
        { "MathRightDelimiter8", null, N_("right <"), null,
            null, on_math_right_delimiter_8 },
        { "MathRightDelimiter9", null, N_("right ."), null,
            null, on_math_right_delimiter_9 }
    };

    private unowned MainWindow main_window;

    public LatexMenu (MainWindow main_window)
    {
        GLib.Object (name: "LatexActionGroup");
        set_translation_domain (Config.GETTEXT_PACKAGE);

        this.main_window = main_window;

        // menus under toolitems
        Gtk.Action sectioning = get_menu_tool_action ("SectioningToolItem",
            _("Sectioning"), "sectioning");

        Gtk.Action sizes = get_menu_tool_action ("CharacterSizeToolItem",
            _("Characters Sizes"), "character-size");

        Gtk.Action references = get_menu_tool_action ("ReferencesToolItem",
            _("References"), "references");

        Gtk.Action presentation_env = get_menu_tool_action ("PresentationToolItem",
            _("Presentation Environments"), "x-office-presentation");

        Gtk.Action math_env = get_menu_tool_action ("MathEnvironmentsToolItem",
            _("Math Environments"), "math");

        add_actions (latex_action_entries, this);
        add_action (sectioning);
        add_action (sizes);
        add_action (references);
        add_action (presentation_env);
        add_action (math_env);

        /* GActions */

        Latexila.latex_commands_add_actions (main_window);

        // LaTeX: Sectioning
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces::part",
            this, "SectioningPart");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces::chapter",
            this, "SectioningChapter");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces::section",
            this, "SectioningSection");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces::subsection",
            this, "SectioningSubsection");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces::subsubsection",
            this, "SectioningSubsubsection");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces::paragraph",
            this, "SectioningParagraph");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces::subparagraph",
            this, "SectioningSubparagraph");

        // LaTeX: References
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces::label",
            this, "ReferencesLabel");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces::ref",
            this, "ReferencesRef");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces::pageref",
            this, "ReferencesPageref");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces::index",
            this, "ReferencesIndex");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces::footnote",
            this, "ReferencesFootnote");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces::cite",
            this, "ReferencesCite");

        // LaTeX: Environments
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-env-simple::center",
            this, "EnvCenter");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-env-simple::flushleft",
            this, "EnvLeft");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-env-simple::flushright",
            this, "EnvRight");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-env-figure",
            this, "EnvFigure");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-env-table",
            this, "EnvTable");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-env-simple::quote",
            this, "EnvQuote");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-env-simple::quotation",
            this, "EnvQuotation");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-env-simple::verse",
            this, "EnvVerse");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-env-simple::verbatim",
            this, "EnvVerbatim");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-env-simple::minipage",
            this, "EnvMinipage");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-env-simple::titlepage",
            this, "EnvTitlepage");

        // LaTeX: list environments
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-list-env-simple::itemize",
            this, "ListEnvItemize");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-list-env-simple::enumerate",
            this, "ListEnvEnumerate");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-list-env-description",
            this, "ListEnvDescription");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-list-env-list",
            this, "ListEnvList");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-without-braces::item",
            this, "ListEnvItem");

        // LaTeX: character sizes
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-char-style::tiny",
            this, "CharacterSizeTiny");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-char-style::scriptsize",
            this, "CharacterSizeScriptsize");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-char-style::footnotesize",
            this, "CharacterSizeFootnotesize");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-char-style::small",
            this, "CharacterSizeSmall");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-char-style::normalsize",
            this, "CharacterSizeNormalsize");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-char-style::large",
            this, "CharacterSizelarge");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-char-style::Large",
            this, "CharacterSizeLarge");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-char-style::LARGE",
            this, "CharacterSizeLARGE");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-char-style::huge",
            this, "CharacterSizehuge");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-char-style::Huge",
            this, "CharacterSizeHuge");

        // LaTeX: font styles
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces::textbf",
            this, "Bold");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces::textit",
            this, "Italic");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces::texttt",
            this, "Typewriter");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces::textsl",
            this, "Slanted");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces::textsc",
            this, "SmallCaps");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces::textsf",
            this, "SansSerif");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces::emph",
            this, "Emph");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces::underline",
            this, "Underline");

        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-char-style::rmfamily",
            this, "FontFamilyRoman");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-char-style::sffamily",
            this, "FontFamilySansSerif");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-char-style::ttfamily",
            this, "FontFamilyMonospace");

        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-char-style::mdseries",
            this, "FontSeriesMedium");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-char-style::bfseries",
            this, "FontSeriesBold");

        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-char-style::upshape",
            this, "FontShapeUpright");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-char-style::itshape",
            this, "FontShapeItalic");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-char-style::slshape",
            this, "FontShapeSlanted");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-char-style::scshape",
            this, "FontShapeSmallCaps");

        // LaTeX: Tabular
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-env-simple::tabbing",
            this, "TabularTabbing");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-tabular-tabular",
            this, "TabularTabular");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-tabular-multicolumn",
            this, "TabularMulticolumn");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-without-braces::hline",
            this, "TabularHline");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-without-braces::vline",
            this, "TabularVline");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-tabular-cline",
            this, "TabularCline");

        // LaTeX: Spacing
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-spacing-new-line",
            this, "SpacingNewLine");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-newline::newpage",
            this, "SpacingNewPage");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-newline::linebreak",
            this, "SpacingLineBreak");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-newline::pagebreak",
            this, "SpacingPageBreak");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-without-braces::bigskip",
            this, "SpacingBigSkip");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-without-braces::medskip",
            this, "SpacingMedSkip");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces::hspace",
            this, "SpacingHSpace");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces::vspace",
            this, "SpacingVSpace");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-without-braces::noindent",
            this, "SpacingNoIndent");

        // LaTeX: International accents
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces('\\'')",
            this, "Accent0");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces('`')",
            this, "Accent1");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces('^')",
            this, "Accent2");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces('\"')",
            this, "Accent3");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces('~')",
            this, "Accent4");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces('=')",
            this, "Accent5");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces('.')",
            this, "Accent6");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces('v')",
            this, "Accent7");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces('u')",
            this, "Accent8");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces('H')",
            this, "Accent9");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces('c')",
            this, "Accent10");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces('k')",
            this, "Accent11");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces('d')",
            this, "Accent12");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces('b')",
            this, "Accent13");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces('r')",
            this, "Accent14");
        Amtk.utils_bind_g_action_to_gtk_action (main_window, "latex-command-with-braces('t')",
            this, "Accent15");
    }

    private Gtk.Action get_menu_tool_action (string name, string? label, string? icon_name)
    {
        Gtk.Action action = new MenuToolAction (name, label, label, icon_name);
        Activatable menu_tool_button = (Activatable) new MenuToolButton (null, null);
        menu_tool_button.set_related_action (action);
        return action;
    }

    private void text_buffer_insert (string text_before, string text_after,
        string? text_if_no_selection = null)
    {
        Tepl.ApplicationWindow tepl_window =
            Tepl.ApplicationWindow.get_from_gtk_application_window (main_window);

        Latexila.latex_commands_insert_text (tepl_window, text_before, text_after,
            text_if_no_selection);
    }

    private string get_indentation ()
    {
        return Latexila.view_get_indentation_style (main_window.active_view);
    }

    /* Presentation */

    public void on_present_frame ()
    {
        string indent = get_indentation ();
        string begin_frame = "\\begin{frame}\n"
                           + @"$indent\\frametitle{}\n"
                           + @"$indent\\framesubtitle{}\n";
        string end_frame = "\n\\end{frame}";
        text_buffer_insert (begin_frame, end_frame);
    }

    public void on_present_columns ()
    {
        string indent = get_indentation ();
        string begin_columns = "\\begin{columns}\n"
                             + @"$indent\\begin{column}{.5\\textwidth}\n";
        string end_columns = @"\n$indent\\end{column}\n"
                           + @"$indent\\begin{column}{.5\\textwidth}\n\n"
                           + @"$indent\\end{column}\n"
                           + "\\end{columns}";
        text_buffer_insert (begin_columns, end_columns);
    }

    public void on_present_block ()
    {
        text_buffer_insert ("\\begin{block}{}\n","\n\\end{block}");
    }

    /* Others */

    public void on_documentclass ()
    {
        text_buffer_insert ("\\documentclass{", "}");
    }

    public void on_usepackage ()
    {
        text_buffer_insert ("\\usepackage{", "}");
    }

    public void on_ams_packages ()
    {
        string packages = "\\usepackage{amsmath}\n"
                        + "\\usepackage{amsfonts}\n"
                        + "\\usepackage{amssymb}";
        text_buffer_insert (packages, "");
    }

    public void on_author ()
    {
        text_buffer_insert ("\\author{", "}");
    }

    public void on_title ()
    {
        text_buffer_insert ("\\title{", "}");
    }

    public void on_begin_document ()
    {
        text_buffer_insert ("\\begin{document}\n", "\n\\end{document}");
    }

    public void on_maketitle ()
    {
        text_buffer_insert ("\\maketitle", "");
    }

    public void on_tableofcontents ()
    {
        text_buffer_insert ("\\tableofcontents", "");
    }

    public void on_abstract ()
    {
        text_buffer_insert ("\\begin{abstract}\n", "\n\\end{abstract}");
    }

    public void on_include_graphics ()
    {
        text_buffer_insert ("\\includegraphics{", "}");
    }

    public void on_input ()
    {
        text_buffer_insert ("\\input{", "}");
    }

    /* Math environments */

    public void on_math_env_normal ()
    {
        text_buffer_insert ("$ ", " $");
    }

    public void on_math_env_centered ()
    {
        text_buffer_insert ("\\[ ", " \\]");
    }

    public void on_math_env_numbered ()
    {
        text_buffer_insert ("\\begin{equation}\n", "\n\\end{equation}");
    }

    public void on_math_env_array ()
    {
        text_buffer_insert ("\\begin{align*}\n", "\n\\end{align*}");
    }

    public void on_math_env_numbered_array ()
    {
        text_buffer_insert ("\\begin{align}\n", "\n\\end{align}");
    }

    public void on_math_superscript ()
    {
        text_buffer_insert ("^{", "}");
    }

    public void on_math_subscript ()
    {
        text_buffer_insert ("_{", "}");
    }

    public void on_math_frac ()
    {
        text_buffer_insert ("\\frac{", "}{}");
    }

    public void on_math_square_root ()
    {
        text_buffer_insert ("\\sqrt{", "}");
    }

    public void on_math_nth_root ()
    {
        text_buffer_insert ("\\sqrt[]{", "}");
    }

    /* Math Functions */

    public void on_math_func_arccos ()
    {
        text_buffer_insert ("\\arccos ", "");
    }

    public void on_math_func_arcsin ()
    {
        text_buffer_insert ("\\arcsin ", "");
    }

    public void on_math_func_arctan ()
    {
        text_buffer_insert ("\\arctan ", "");
    }

    public void on_math_func_cos ()
    {
        text_buffer_insert ("\\cos ", "");
    }

    public void on_math_func_cosh ()
    {
        text_buffer_insert ("\\cosh ", "");
    }

    public void on_math_func_cot ()
    {
        text_buffer_insert ("\\cot ", "");
    }

    public void on_math_func_coth ()
    {
        text_buffer_insert ("\\coth ", "");
    }

    public void on_math_func_csc ()
    {
        text_buffer_insert ("\\csc ", "");
    }

    public void on_math_func_deg ()
    {
        text_buffer_insert ("\\deg ", "");
    }

    public void on_math_func_det ()
    {
        text_buffer_insert ("\\det ", "");
    }

    public void on_math_func_dim ()
    {
        text_buffer_insert ("\\dim ", "");
    }

    public void on_math_func_exp ()
    {
        text_buffer_insert ("\\exp ", "");
    }

    public void on_math_func_gcd ()
    {
        text_buffer_insert ("\\gcd ", "");
    }

    public void on_math_func_hom ()
    {
        text_buffer_insert ("\\hom ", "");
    }

    public void on_math_func_inf ()
    {
        text_buffer_insert ("\\inf ", "");
    }

    public void on_math_func_ker ()
    {
        text_buffer_insert ("\\ker ", "");
    }

    public void on_math_func_lg ()
    {
        text_buffer_insert ("\\lg ", "");
    }

    public void on_math_func_lim ()
    {
        text_buffer_insert ("\\lim ", "");
    }

    public void on_math_func_liminf ()
    {
        text_buffer_insert ("\\liminf ", "");
    }

    public void on_math_func_limsup ()
    {
        text_buffer_insert ("\\limsup ", "");
    }

    public void on_math_func_ln ()
    {
        text_buffer_insert ("\\ln ", "");
    }

    public void on_math_func_log ()
    {
        text_buffer_insert ("\\log ", "");
    }

    public void on_math_func_max ()
    {
        text_buffer_insert ("\\max ", "");
    }

    public void on_math_func_min ()
    {
        text_buffer_insert ("\\min ", "");
    }

    public void on_math_func_sec ()
    {
        text_buffer_insert ("\\sec ", "");
    }

    public void on_math_func_sin ()
    {
        text_buffer_insert ("\\sin ", "");
    }

    public void on_math_func_sinh ()
    {
        text_buffer_insert ("\\sinh ", "");
    }

    public void on_math_func_sup ()
    {
        text_buffer_insert ("\\sup ", "");
    }

    public void on_math_func_tan ()
    {
        text_buffer_insert ("\\tan ", "");
    }

    public void on_math_func_tanh ()
    {
        text_buffer_insert ("\\tanh ", "");
    }

    /* Math Font Styles */

    public void on_math_font_style_rm ()
    {
        text_buffer_insert ("\\mathrm{", "}");
    }

    public void on_math_font_style_it ()
    {
        text_buffer_insert ("\\mathit{", "}");
    }

    public void on_math_font_style_bf ()
    {
        text_buffer_insert ("\\mathbf{", "}");
    }

    public void on_math_font_style_sf ()
    {
        text_buffer_insert ("\\mathsf{", "}");
    }

    public void on_math_font_style_tt ()
    {
        text_buffer_insert ("\\mathtt{", "}");
    }

    public void on_math_font_style_cal ()
    {
        text_buffer_insert ("\\mathcal{", "}");
    }

    public void on_math_font_style_bb ()
    {
        text_buffer_insert ("\\mathbb{", "}");
    }

    public void on_math_font_style_frak ()
    {
        text_buffer_insert ("\\mathfrak{", "}");
    }

    /* Math Accents */

    public void on_math_accent_acute ()
    {
        text_buffer_insert ("\\acute{", "}");
    }

    public void on_math_accent_grave ()
    {
        text_buffer_insert ("\\grave{", "}");
    }

    public void on_math_accent_tilde ()
    {
        text_buffer_insert ("\\tilde{", "}");
    }

    public void on_math_accent_bar ()
    {
        text_buffer_insert ("\\bar{", "}");
    }

    public void on_math_accent_vec ()
    {
        text_buffer_insert ("\\vec{", "}");
    }

    public void on_math_accent_hat ()
    {
        text_buffer_insert ("\\hat{", "}");
    }

    public void on_math_accent_check ()
    {
        text_buffer_insert ("\\check{", "}");
    }

    public void on_math_accent_breve ()
    {
        text_buffer_insert ("\\breve{", "}");
    }

    public void on_math_accent_dot ()
    {
        text_buffer_insert ("\\dot{", "}");
    }

    public void on_math_accent_ddot ()
    {
        text_buffer_insert ("\\ddot{", "}");
    }

    public void on_math_accent_ring ()
    {
        text_buffer_insert ("\\mathring{", "}");
    }

    /* Math Spaces */

    public void on_math_space_small ()
    {
        text_buffer_insert ("\\, ", "");
    }

    public void on_math_space_medium ()
    {
        text_buffer_insert ("\\: ", "");
    }

    public void on_math_space_large ()
    {
        text_buffer_insert ("\\; ", "");
    }

    public void on_math_space_quad ()
    {
        text_buffer_insert ("\\quad ", "");
    }

    public void on_math_space_qquad ()
    {
        text_buffer_insert ("\\qquad ", "");
    }

    /* Left Delimiters */

    public void on_math_left_delimiter_1 ()
    {
        text_buffer_insert ("\\left( ", "");
    }

    public void on_math_left_delimiter_2 ()
    {
        text_buffer_insert ("\\left[ ", "");
    }

    public void on_math_left_delimiter_3 ()
    {
        text_buffer_insert ("\\left\\lbrace ", "");
    }

    public void on_math_left_delimiter_4 ()
    {
        text_buffer_insert ("\\left\\langle ", "");
    }

    public void on_math_left_delimiter_5 ()
    {
        text_buffer_insert ("\\left) ", "");
    }

    public void on_math_left_delimiter_6 ()
    {
        text_buffer_insert ("\\left] ", "");
    }

    public void on_math_left_delimiter_7 ()
    {
        text_buffer_insert ("\\left\\rbrace ", "");
    }

    public void on_math_left_delimiter_8 ()
    {
        text_buffer_insert ("\\left\\rangle ", "");
    }

    public void on_math_left_delimiter_9 ()
    {
        text_buffer_insert ("\\left. ", "");
    }

    public void on_math_right_delimiter_1 ()
    {
        text_buffer_insert ("\\right) ", "");
    }

    public void on_math_right_delimiter_2 ()
    {
        text_buffer_insert ("\\right] ", "");
    }

    public void on_math_right_delimiter_3 ()
    {
        text_buffer_insert ("\\right\\rbrace ", "");
    }

    public void on_math_right_delimiter_4 ()
    {
        text_buffer_insert ("\\right\\rangle ", "");
    }

    public void on_math_right_delimiter_5 ()
    {
        text_buffer_insert ("\\right( ", "");
    }

    public void on_math_right_delimiter_6 ()
    {
        text_buffer_insert ("\\right[ ", "");
    }

    public void on_math_right_delimiter_7 ()
    {
        text_buffer_insert ("\\right\\lbrace ", "");
    }

    public void on_math_right_delimiter_8 ()
    {
        text_buffer_insert ("\\right\\langle ", "");
    }

    public void on_math_right_delimiter_9 ()
    {
        text_buffer_insert ("\\right. ", "");
    }
}
