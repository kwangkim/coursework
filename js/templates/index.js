this["JST"] = this["JST"] || {};

this["JST"]["browser"] = function(obj) {
obj || (obj = {});
var __t, __p = '', __e = _.escape, __j = Array.prototype.join;
function print() { __p += __j.call(arguments, '') }
with (obj) {
__p += '<ul>\n    ';
 _.each(entries, function(entry) { ;
__p += '\n        <li>' +
((__t = ( entry )) == null ? '' : __t) +
'</li>\n    ';
 }); ;
__p += '\n</ul>\n';

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
__p += '<h2>Settings</h2>\n\n<h3>Theme</h3>\n\n<h3>Markdown</h3>\n<ul>\n    <li>\n        SmartyPants\n        <span class="description">Improves appearance of quotes, dashes and ellipses</span>\n        <input type="tick">\n    </li>\n</ul>\n';

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