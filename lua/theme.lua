local function hex(color)
	return color and string.format("#%06x", color) or nil
end

local get = function(group)
	local hl = vim.api.nvim_get_hl(0, { name = group })
	return setmetatable({}, {
		__index = function(_, key)
			return hex(hl[key])
		end,
	})
end

local hl = {}

setmetatable(hl, {
	__index = function(_, key)
		return get(key)
	end,
})

local c = {
	-- Core UI & Backgrounds
	bg = hl.Normal.bg,
	fg = hl.Normal.fg,
	nontext = hl.NonText,
	linenr = hl.LineNr.fg,
	matchparen = hl.MatchParen.bg,
	linebg = (hl.CursorLine and hl.CursorLine.bg) or hl.Normal.bg,
	selection = (hl.Visual and hl.Visual.bg) or hl.CursorLine.bg,
	selection_inactive = hl.VisualNOS,
	cursor = hl.Cursor.bg,
	search = hl.Search.bg,
	search_fg = hl.Search.fg,
	incsearch = hl.IncSearch.bg,
	folded = hl.Folded.bg,
	statusline = hl.StatusLine.bg,
	shadow = hl.FloatShadow,
	separator = hl.WinSeparator.fg or hl.VertSplit.fg,
	separator_bg = hl.WinSeparator.bg or hl.VertSplit.bg,

	-- Borders & Floating Windows
	border = (hl.FloatBorder and hl.FloatBorder.fg) or hl.Normal.fg,
	float_bg = (hl.NormalFloat and hl.NormalFloat.bg) or hl.Normal.bg,
	pmenu_bg = hl.Pmenu.bg,
	pmenu_sel = hl.PmenuSel.bg,
	pmenu_sbar = hl.PmenuSbar.bg,
	pmenu_thumb = hl.PmenuThumb.bg,
	tabline_bg = hl.TabLine.bg,
	tabline_sel = hl.TabLineSel.bg,
	tabline_fill = hl.TabLineFill.bg,

	-- Basic Syntax
	comment = hl.Comment.fg,
	string = hl.String.fg,
	keyword = hl.Keyword.fg,
	statement = hl.Statement.fg,
	conditional = hl.Conditional.fg,
	repeat_loop = hl.Repeat.fg,
	label = hl.Label.fg,
	operator = (hl["@operator"] and hl["@operator"].fg) or hl.Operator.fg,
	keyword_func = (hl["@keyword.function"] and hl["@keyword.function"].fg) or hl.Keyword.fg,
	exception = hl.Exception.fg,

	-- Functions & Methods
	func = (hl["@function"] and hl["@function"].fg) or hl.Function.fg,
	func_builtin = (hl["@function.builtin"] and hl["@function.builtin"].fg) or hl.Special.fg,
	func_macro = (hl["@function.macro"] and hl["@function.macro"].fg) or hl.Macro.fg,
	class = hl["@class"].fg or hl.Class.fg,
	method = (hl["@method"] and hl["@method"].fg) or hl.Function.fg,
	method_call = (hl["@method.call"] and hl["@method.call"].fg) or hl.Function.fg,
	constructor = (hl["@constructor"] and hl["@constructor"].fg) or hl.Special.fg,
	parameter = (hl["@parameter"] and hl["@parameter"].fg) or hl.Identifier.fg,
	field = (hl["@field"] and hl["@field"].fg) or hl.Identifier.fg,
	variable = (hl["@property"] and hl["@property"].fg) or hl.Identifier.fg,

	-- Variables & Constants
	variable_builtin = (hl["@variable.builtin"] and hl["@variable.builtin"].fg) or hl.Identifier.fg,
	constant = (hl["@constant"] and hl["@constant"].fg) or hl.Constant.fg,
	const_builtin = (hl["@constant.builtin"] and hl["@constant.builtin"].fg) or hl.Special.fg,
	const_macro = (hl["@constant.macro"] and hl["@constant.macro"].fg) or hl.Define.fg,
	number = (hl["@number"] and hl["@number"].fg) or hl.Number.fg,
	float = (hl["@float"] and hl["@float"].fg) or hl.Float.fg,
	boolean = (hl["@boolean"] and hl["@boolean"].fg) or hl.Boolean.fg,
	character = (hl["@character"] and hl["@character"].fg) or hl.Character.fg,
	namespace = (hl["@namespace"] and hl["@namespace"].fg) or hl.Identifier.fg,
	attribute = (hl["@attribute"] and hl["@attribute"].fg) or hl.Identifier.fg,
	delimiter = hl.Delimiter,

	-- Types & Structure
	type = (hl["@type"] and hl["@type"].fg) or hl.Type.fg,
	type_builtin = (hl["@type.builtin"] and hl["@type.builtin"].fg) or hl.Type.fg,
	type_definition = (hl["@type.definition"] and hl["@type.definition"].fg) or hl.Typedef.fg,
	type_qualifier = (hl["@type.qualifier"] and hl["@type.qualifier"].fg) or hl.Type.fg,
	storageclass = hl["@keyword.storageclass"].fg or hl.StorageClass.fg,
	structure = hl.Structure.fg,
	tag = (hl["@tag"] and hl["@tag"].fg) or hl.Tag.fg,
	tag_attribute = (hl["@tag.attribute"] and hl["@tag.attribute"].fg) or hl.Identifier.fg,
	tag_delimiter = (hl["@tag.delimiter"] and hl["@tag.delimiter"].fg) or hl.Delimiter.fg,
	punctuation = (hl["@punctuation.delimiter"] and hl["@punctuation.delimiter"].fg) or hl.Delimiter.fg,

	-- Special, Diagnostics & Markup
	bracket = (hl["@punctuation.bracket"] and hl["@punctuation.bracket"].fg) or hl.Normal.fg,
	special = hl.Special.fg,
	special_char = hl.SpecialChar.fg,
	signadd = hl.GitSignsAdd or hl.Added,
	signremove = hl.GitSignsDelete or hl.Removed,
	signchange = hl.GitSignsChange or hl.Changed,
	debug = hl.Debug.fg,
	error = hl.ErrorMsg,
	warning = hl.WarningMsg.fg,
	info = (hl.DiagnosticInfo and hl.DiagnosticInfo.fg) or hl.Normal.fg,
	hint = (hl.DiagnosticHint and hl.DiagnosticHint.fg) or hl.Normal.fg,
	todo = hl.Todo.fg,
	note = (hl["@text.note"] and hl["@text.note"].fg) or hl.Special.fg,
}

local name = vim.g.colors_name
local path = vim.fn.stdpath("cache") .. "/" .. name .. ".tmTheme"
local theme = string.format(
	[[
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>author</key>
    <string>Neovim Generated Theme</string>
    <key>name</key>
    <string>%s</string>
    <key>settings</key>
    <array>
    	<dict>
			<key>settings</key>
			<dict>
        <key>background</key>
				<string>%s</string>
        <key>foreground</key>
				<string>%s</string>
				<key>invisibles</key>
				<string>%s</string>
				<key>caret</key>
				<string>%s</string>
				<key>lineHighlight</key>
				<string>%s</string>
				<key>bracketContentsOptions</key>
				<string>underline</string>
				<key>bracketContentsForeground</key>
				<string>%s</string>
				<key>bracketsOptions</key>
				<string>underline</string>
				<key>bracketsForeground</key>
				<string>%s</string>
				<key>tagsOptions</key>
				<string>underline</string>
				<key>tagsForeground</key>
				<string>%s</string>
				<key>findHighlight</key>
				<string>%s</string>
				<key>findHighlightForeground</key>
				<string>%s</string>
				<key>gutter</key>
				<string>%s</string>
				<key>gutterForeground</key>
				<string>%s</string>
				<key>selection</key>
				<string>%s</string>
				<key>selectionBorder</key>
				<string>%s</string>
				<key>inactiveSelection</key>
				<string>%s</string>
				<key>guide</key>
				<string>%s</string>
				<key>activeGuide</key>
				<string>%s</string>
				<key>stackGuide</key>
				<string>%s</string>
				<key>highlight</key>
				<string>%s</string>
				<key>highlightForeground</key>
				<string>%s</string>
				<key>shadow</key>
				<string>%s</string>
				<key>shadowWidth</key>
				<string>1</string>
			</dict>
		</dict>
        <dict>
            <key>name</key>
            <string>Text and source</string>
            <key>scope</key>
            <string>text, source</string>
            <key>settings</key>
            <dict>
                <key>foreground</key>
                <string>%s</string>
            </dict>
        </dict>
        <dict>
			<key>name</key>
			<string>Text</string>
			<key>scope</key>
			<string>variable.parameter.function</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Comments</string>
			<key>scope</key>
			<string>comment, punctuation.definition.comment</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			<!--	<key>fontStyle</key> -->
			<!--	<string>italic</string> -->
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Delimiters</string>
			<key>scope</key>
			<string>none</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Operators</string>
			<key>scope</key>
			<string>keyword.operator</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Keywords</string>
			<key>scope</key>
			<string>keyword</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Variables</string>
			<key>scope</key>
			<string>variable</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Functions</string>
			<key>scope</key>
			<string>entity.name.function, meta.require, support.function.any-method</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Classes</string>
			<key>scope</key>
			<string>support.class, entity.name.class, entity.name.type.class</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Classes</string>
			<key>scope</key>
			<string>meta.class</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Methods</string>
			<key>scope</key>
			<string>keyword.other.special-method</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Storage</string>
			<key>scope</key>
			<string>storage</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Support</string>
			<key>scope</key>
			<string>support.function</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Strings, Inherited Class</string>
			<key>scope</key>
			<string>string, constant.other.symbol, entity.other.inherited-class</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Integers</string>
			<key>scope</key>
			<string>constant.numeric</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Floats</string>
			<key>scope</key>
			<string>none</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Boolean</string>
			<key>scope</key>
			<string>none</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Constants</string>
			<key>scope</key>
			<string>constant</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Tags</string>
			<key>scope</key>
			<string>entity.name.tag</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Attributes</string>
			<key>scope</key>
			<string>entity.other.attribute-name</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Attribute IDs</string>
			<key>scope</key>
			<string>entity.other.attribute-name.id, punctuation.definition.entity</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Selector</string>
			<key>scope</key>
			<string>meta.selector</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Values</string>
			<key>scope</key>
			<string>none</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Headings</string>
			<key>scope</key>
			<string>markup.heading punctuation.definition.heading, entity.name.section</string>
			<key>settings</key>
			<dict>
				<key>fontStyle</key>
				<string></string>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Units</string>
			<key>scope</key>
			<string>keyword.other.unit</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Bold</string>
			<key>scope</key>
			<string>markup.bold, punctuation.definition.bold</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Italic</string>
			<key>scope</key>
			<string>markup.italic, punctuation.definition.italic</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Code</string>
			<key>scope</key>
			<string>markup.raw.inline</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Link Text</string>
			<key>scope</key>
			<string>string.other.link, punctuation.definition.string.end.markdown</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Link Url</string>
			<key>scope</key>
			<string>meta.link</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Lists</string>
			<key>scope</key>
			<string>markup.list</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Quotes</string>
			<key>scope</key>
			<string>markup.quote</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Separator</string>
			<key>scope</key>
			<string>meta.separator</string>
			<key>settings</key>
			<dict>
				<key>background</key>
				<string>%s</string>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Inserted</string>
			<key>scope</key>
			<string>markup.inserted</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Deleted</string>
			<key>scope</key>
			<string>markup.deleted</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Changed</string>
			<key>scope</key>
			<string>markup.changed</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Colors</string>
			<key>scope</key>
			<string>constant.other.color</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Regular Expressions</string>
			<key>scope</key>
			<string>string.regexp</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Escape Characters</string>
			<key>scope</key>
			<string>constant.character.escape</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Embedded</string>
			<key>scope</key>
			<string>punctuation.section.embedded, variable.interpolation</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>%s</string>
			</dict>
		</dict>
  </array>
</dict>
</plist>
]],
	name,
	c.bg,
	c.linenr,
	c.nontext,
	c.cursor,
	c.linebg,
	c.matchparen,
	c.matchparen,
	c.tag,
	c.selection,
	c.search,
	c.linenr,
	c.bg,
	c.selection,
	c.selection,
	c.selection_inactive,
	c.nontext,
	c.nontext,
	c.nontext,
	c.search,
	c.search_fg,
	c.shadow,
	c.fg,
	c.fg,
	c.comment,
	c.delimiter,
	c.operator,
	c.keyword,
	c.variable,
	c.func,
	c.class,
	c.type,
	c.method,
	c.keyword,
	c.func,
	c.string,
	c.number,
	c.float,
	c.boolean,
	c.constant,
	c.tags,
	c.attribute,
	c.tag_attribute,
	c.keyword,
	c.string,
	c.keyword,
	c.number,
	c.punctuation,
	c.conditional,
	c.string,
	c.special,
	c.tag_attribute,
	c.keyword,
	c.string,
	c.separator,
	c.separator_bg,
	c.signadd,
	c.signremove,
	c.signchange,
	c.constant,
	c.constant,
	c.constant,
	c.punctuation
)

vim.fn.writefile(vim.split(theme, "\n"), path)
return path
