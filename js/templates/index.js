this["JST"] = this["JST"] || {};

this["JST"]["browser"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '<ul class="menu">\n    <li id="save">\n        <i class="icon-save"></i>\n    </li>\n</ul>\n';

}
return __p
};

this["JST"]["file"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '<i class="icon-file icon-large"></i>' +
((__t = ( name )) == null ? '' : __t) +
'\n';

}
return __p
};

this["JST"]["modal"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '<div class="title">\n    <h2 class="left"></h2>\n    <input type="button" class="right close" value="&times;">\n</div>\n\n<div class="clearfix"></div>\n\n<div class="content"></div>\n';

}
return __p
};

this["JST"]["settings"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '<section class="editor">\n    <h3>Editor</h3>\n    <ul>\n        <li>\n            Colour scheme\n            <input list="schemes" id="scheme"/>\n            <datalist id="schemes">\n                  <option value="Monokai">\n                  <option value="Solarized">\n                  <option value="GitHub">\n            </datalist>\n            <span class="description">Colour scheme used for syntax highlighting</span>\n        </li>\n    </ul>\n</section>\n\n<section class="markdown">\n    <h3>Markdown</h3>\n    <ul>\n        <li>\n            <input type="checkbox" id="smartypants">\n            SmartyPants\n            <span class="description">Improves appearance of quotes, dashes and ellipses</span>\n        </li>\n    </ul>\n</section>\n\n<section class="latex">\n    <h3>LaTeX</h3>\n    <ul>\n        <li>\n            Block delimiter\n            <span class="description">Strings used to delimit LaTeX in the document</span>\n            <ul>\n                <li>Start:&nbsp;<input type="text" size="5" id="delim-start"></li>\n                <li>End:&nbsp;<input type="text" size="5" id="delim-end"></li>\n            </ul>\n        </li>\n    </ul>\n</section>\n\n<section class="end">\n    <input type="button" value="Save" class="right" id="save">\n</section>\n';

}
return __p
};

this["JST"]["toolbar"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape;
with (obj) {
__p += '<ul>\n    <li id="dropbox">\n        <i class="icon-folder-close" title="Connect to Dropbox"></i>\n    </li>\n    <li id="open">\n        <i class="icon-file" title="Open an existing document"></i>\n    </li>\n    <li id="save">\n        <i class="icon-save" title="Save your work"></i>\n    </li>\n    <li id="export">\n        <i class="icon-arrow-right" title="Export as PDF"></i>\n    </li>\n    <li id="settings">\n        <i class="icon-cog" title="Settings"></i>\n    </li>\n</ul>\n';

}
return __p
};