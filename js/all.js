(function() {
  window.dom = {};

  window.cw = {};

  (function($) {
    return $.fn.centre = function() {
      this.css({
        left: (dom.window.width() - this.width()) / 2
      });
      return this;
    };
  })(jQuery);

  window.alert = function(text) {
    return dom.message.text(text).centre().fadeIn('fast').delay(2000).fadeOut('slow');
  };

  marked.setOptions({
    sanitize: true,
    highlight: function(code, lang) {
      return hljs.highlightAuto(code).value;
    }
  });

}).call(this);

(function() {
  var auth, client, key;

  client = new Dropbox.Client({
    key: 'vmtobv6ojlapzfg',
    sandbox: true
  });

  auth = function() {
    if (client.isAuthenticated()) {
      alert('Already connected to Dropbox.');
      return;
    }
    client.authDriver(new Dropbox.AuthDriver.Redirect({
      rememberUser: true
    }));
    return client.authenticate(function(error, authed_client) {
      if (error) {
        alert("Error: could not connect to Dropbox.");
        console.log(error);
        return;
      }
      return authed_client.getUserInfo(function(error, info) {
        return console.log(info.name);
      });
    });
  };

  for (key in localStorage) {
    if (key.indexOf('dropbox-auth') !== -1) {
      auth();
      break;
    }
  }

  cw.client = client;

  cw.auth = auth;

}).call(this);

(function() {
  cw.Modal = Backbone.View.extend({
    className: 'modal',
    events: {
      'click .close': 'close'
    },
    title: 'default',
    content: function() {
      return '';
    },
    load: function() {},
    template: JST.modal(),
    initialize: function() {
      this.load();
      this.$el.appendTo('body');
      return this.render();
    },
    close: function() {
      this.$el.fadeOut('fast');
      return dom.shade.hide();
    },
    render: function() {
      this.$el.html(this.template);
      this.$('h2').text(this.title);
      return this;
    },
    show: function() {
      dom.shade.show();
      this.load();
      return this.$el.centre().fadeIn('fast');
    }
  });

}).call(this);

(function() {
  var File;

  File = Backbone.Model.extend({
    defaults: {
      name: 'file',
      extension: '.md'
    },
    fullname: function() {
      return "" + (this.get('name')) + "." + (this.get('extension'));
    },
    initialize: function() {
      var parts;
      parts = this.get('fullname').split('.');
      this.set('name', parts[0]);
      return this.set('extension', parts[1]);
    }
  });

  cw.FileList = Backbone.Collection.extend({
    model: File
  });

  cw.FileView = Backbone.View.extend({
    tagName: 'li',
    events: {
      'click i': 'open'
    },
    render: function() {
      this.$el.html(JST.file(this.model.attributes));
      return this;
    },
    open: function() {
      return cw.client.readFile(this.model.fullname(), function(error, data) {
        if (error) {
          console.log(error);
          return;
        }
        cw.editor.setValue(data);
        return cw.browser.close();
      });
    }
  });

  cw.FileListView = Backbone.View.extend({
    tagName: 'ul',
    className: 'filelist',
    initialize: function(entries) {
      this.collection = new cw.FileList(entries);
      return this.render();
    },
    render: function() {
      var _this = this;
      this.$el.empty();
      _.each(this.collection.models, (function(file) {
        var view;
        view = new cw.FileView({
          model: file
        });
        return _this.$el.append(view.render().el);
      }), this);
      return this;
    }
  });

}).call(this);

(function() {
  cw.Browser = cw.Modal.extend({
    title: 'Open an existing file',
    tagName: 'div',
    id: 'browser',
    render: function() {
      cw.Modal.prototype.render.call(this);
      this.$('.content').append(JST.browser()).append(new cw.FileListView(this.entries).el);
      return this;
    },
    entries: [],
    load: function() {
      var _this = this;
      return cw.client.readdir('/', function(error, entries) {
        var e;
        if (error) {
          console.log(error);
          return;
        }
        _this.entries = (function() {
          var _i, _len, _results;
          _results = [];
          for (_i = 0, _len = entries.length; _i < _len; _i++) {
            e = entries[_i];
            _results.push({
              fullname: e
            });
          }
          return _results;
        })();
        return _this.render();
      });
    }
  });

  cw.browser = new cw.Browser();

}).call(this);

(function() {
  cw.Settings = Backbone.DeepModel.extend({
    defaults: {
      editor: {
        color_scheme: 'monokai'
      },
      markdown: {
        smartypants: true,
        breaks: true,
        smartLists: true
      },
      latex: {
        delimiters: {
          start: '$',
          end: '$'
        }
      }
    },
    initialize: function() {
      this.bind('change:markdown.*', this.set_markdown);
      return this.bind('change:latex.*', this.set_latex);
    },
    set_markdown: function() {
      marked.setOptions(this.get('markdown'));
      return cw.update();
    },
    set_latex: function() {
      var delims;
      delims = this.get('latex.delimiters');
      return MathJax.Hub.Config({
        tex2jax: {
          inlineMath: [[delims.start, delims.end], ['\\(', '\\)']]
        }
      });
    }
  });

  cw.SettingsView = cw.Modal.extend({
    id: 'settings',
    title: 'Settings',
    model: cw.Settings,
    save: function() {
      return this.model.set({
        'editor.color_scheme': this.$('#scheme').val(),
        'markdown.smartypants': this.$('#smartypants').prop('checked'),
        'latex.delimiters.start': this.$('#delim-start').val(),
        'latex.delimiters.end': this.$('#delim-end').val()
      });
    },
    initialize: function() {
      var events;
      cw.Modal.prototype.initialize.call(this);
      events = {
        'click #save': 'save'
      };
      this.events = _.extend(this.events, events);
      this.$('#scheme').val(this.model.get('editor').color_scheme);
      this.$('#smartypants').prop('checked', this.model.get('markdown').smartypants);
      this.$('#delim-start').val(this.model.get('latex').delimiters.start);
      return this.$('#delim-end').val(this.model.get('latex').delimiters.end);
    },
    render: function() {
      cw.Modal.prototype.render.call(this);
      return this.$('.content').html(JST.settings());
    }
  });

  cw.settings = new cw.SettingsView({
    model: new cw.Settings()
  });

}).call(this);

(function() {
  var $e, $h, $r, $v, $w, delay, formatLists, half_min, half_rw, header_height, height, min_width, panel, pos, ratio, resizer_width, save_message, session, throttled, twice_vp, viewer_padding, width, _i, _len, _ref,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  $w = $(window);

  $e = $('#editor');

  $v = $('#viewer');

  $h = $('header');

  $r = $('#resizer');

  cw.editor = ace.edit('editor');

  cw.editor.setTheme('ace/theme/monokai');

  session = cw.editor.getSession();

  session.setMode('ace/mode/markdown');

  session.setUseWrapMode(true);

  min_width = 250;

  half_min = min_width / 2;

  resizer_width = 10;

  half_rw = resizer_width / 2;

  viewer_padding = 30;

  twice_vp = viewer_padding * 2;

  header_height = 50;

  ratio = 0.5;

  $r.draggable({
    axis: 'x',
    cursorAt: {
      left: half_rw
    },
    containment: 'document',
    drag: function(e) {
      var height, pos, width;
      width = $w.width();
      height = $w.height();
      if (e.clientX < min_width || e.clientX > width - min_width) {
        return false;
      }
      pos = {
        top: header_height,
        left: e.clientX - half_rw
      };
      $e.width(pos.left);
      $v.width(width - pos.left - 60).height(height).offset(pos);
      return cw.editor.resize(false);
    }
  });

  formatLists = function() {
    return dom.viewer.find('ol').each(function() {
      var level, t, type;
      t = $(this);
      level = t.parents().filter('ol, ul').length;
      type = ['1', 'a', 'i'][level % 3];
      return t.attr({
        type: type
      });
    });
  };

  save_message = function(doc) {
    var connect_msg, connective, is_connected, is_named, name_msg, warning;
    if (doc === '') {
      return ['', false];
    } else {
      is_connected = cw.client.isAuthenticated();
      is_named = dom.filename.val() !== '';
      if (is_connected && is_named) {
        return ["All changes saved to Dropbox", false];
      } else {
        warning = true;
        connect_msg = is_connected ? '' : "connect to Dropbox";
        name_msg = is_named ? '' : "name this document";
        connective = !is_connected && !is_named ? ' and ' : '';
        return ["Warning: changes are not being saved. Please " + connect_msg + connective + name_msg + " to save your work.", true];
      }
    }
  };

  cw.update = function(delta) {
    var doc, msg, warning, _ref;
    doc = cw.editor.getValue();
    dom.viewer.html(marked(doc));
    formatLists();
    MathJax.Hub.Queue(['Typeset', MathJax.Hub, 'viewer']);
    localStorage.currentDoc = JSON.stringify({
      name: dom.filename.val(),
      contents: doc
    });
    _ref = save_message(doc), msg = _ref[0], warning = _ref[1];
    dom.save_message.css({
      color: warning ? '#a00' : '#aaa'
    });
    return dom.save_message.text(msg);
  };

  $e.on('dragenter', function() {
    return false;
  });

  $e.on('dragexit', function() {
    return false;
  });

  $e.on('dragover', function() {
    return false;
  });

  $e.on('drop', function(event) {
    var extension, file, name, parts, reader, valid;
    console.log(event);
    file = event.originalEvent.dataTransfer.files[0];
    if (file != null) {
      parts = file.name.split('.');
      extension = parts.pop();
      valid = ['md', 'tex'];
      if (__indexOf.call(valid, extension) >= 0) {
        reader = new FileReader();
        name = parts.join('.');
        reader.onload = function(event) {
          cw.editor.setValue(event.target.result);
          return dom.filename.val(name);
        };
        reader.readAsText(file);
      } else {
        alert("Invalid file extension: " + extension);
      }
    }
    return false;
  });

  delay = 1000;

  throttled = _.throttle(cw.update, delay);

  cw.editor.on('change', throttled);

  width = Math.max($w.width() * ratio, min_width);

  height = $w.height();

  _ref = [$e, $v];
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    panel = _ref[_i];
    panel.width(width).height(height);
  }

  pos = {
    top: header_height,
    left: width
  };

  $r.offset(pos).height(height);

  $v.offset(pos);

}).call(this);

(function() {
  cw.Toolbar = Backbone.View.extend({
    tagName: 'nav',
    events: {
      'click #dropbox': 'connect',
      'click #open': 'open',
      'click #save': 'save',
      'click #export': 'export',
      'click #settings': 'settings'
    },
    initialize: function() {
      this.render();
      return this.$el.appendTo('header > .right');
    },
    render: function() {
      this.$el.html(JST.toolbar());
      return this;
    },
    connect: function() {
      return cw.auth();
    },
    open: function() {
      return cw.browser.show();
    },
    save: function() {
      var filename;
      if (cw.client == null) {
        alert('Please connect to Dropbox to save documents.');
        return;
      }
      filename = dom.filename.val();
      if (!filename) {
        alert('Please name this document before saving.');
        return;
      }
      filename += '.md';
      return cw.client.writeFile(filename, cw.editor.getValue(), function(error, stat) {
        if (error) {
          alert('Error: could not save file.');
          console.log(error);
          return;
        }
        return alert("File saved as " + filename + ".");
      });
    },
    settings: function() {
      return cw.settings.show();
    }
  });

  cw.toolbar = new cw.Toolbar();

}).call(this);

(function() {
  $(document).ready(function() {
    var doc, el, elements, restore, _i, _len;
    elements = ['viewer', 'message', 'save-message', 'filename'];
    for (_i = 0, _len = elements.length; _i < _len; _i++) {
      el = elements[_i];
      window.dom[el.replace('-', '_')] = $('#' + el);
    }
    window.dom.window = $(window);
    window.dom.shade = $('.shade');
    restore = function() {
      var e;
      if (!(window.localStorage && localStorage.currentDoc)) {
        return null;
      }
      try {
        return JSON.parse(localStorage.currentDoc);
      } catch (_error) {
        e = _error;
        return null;
      }
    };
    doc = restore();
    if (doc) {
      cw.editor.setValue(doc.contents);
      dom.filename.val(doc.name);
    } else {
      $.get('sample.md', function(text) {
        return cw.editor.setValue(text);
      });
    }
    cw.settings.model.trigger('change:markdown.* change:latex.*');
    return cw.update();
  });

}).call(this);
