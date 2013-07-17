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
    smartypants: true,
    breaks: true,
    sanitize: true,
    smartLists: true,
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
    id: 'modal',
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
      this.$('.content').html(this.content());
      return this;
    },
    show: function() {
      dom.shade.show();
      return this.$el.centre().fadeIn('fast');
    }
  });

}).call(this);

(function() {
  var File, FileList;

  File = Backbone.Model.extend({
    defaults: {
      name: ''
    }
  });

  FileList = Backbone.Collection.extend({
    model: File
  });

  cw.Browser = cw.Modal.extend({
    title: 'Open an existing file',
    content: function() {
      return JST.browser({
        entries: this.entries
      });
    },
    entries: [],
    load: function() {
      var _this = this;
      return cw.client.readdir('/', function(error, entries) {
        if (error) {
          console.log(error);
          return;
        }
        _this.entries = entries;
        return _this.render();
      });
    }
  });

}).call(this);

(function() {
  cw.Settings = cw.Modal.extend({
    content: function() {
      return JST.settings();
    },
    title: 'Settings'
  });

}).call(this);

(function() {
  var editor, formatLists, save_message, update;

  editor = ace.edit('editor');

  editor.setTheme('ace/theme/monokai');

  editor.getSession().setMode('ace/mode/markdown');

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

  update = function(delta) {
    var doc, msg, warning, _ref;
    doc = editor.getValue();
    dom.viewer.html(marked(doc));
    formatLists();
    MathJax.Hub.Queue(['Typeset', MathJax.Hub, 'viewer']);
    _ref = save_message(doc), msg = _ref[0], warning = _ref[1];
    dom.save_message.css({
      color: warning ? '#a00' : '#aaa'
    });
    return dom.save_message.text(msg);
  };

  editor.on('change', update);

  cw.editor = editor;

  cw.update = update;

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
    render: function() {
      this.$el.html(JST.toolbar());
      return this;
    },
    connect: function() {
      return cw.auth();
    },
    open: function() {
      if (!cw.browser) {
        cw.browser = new cw.Browser();
      }
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
      if (!cw.settings) {
        cw.settings = new cw.Settings();
      }
      return cw.settings.show();
    }
  });

}).call(this);

(function() {
  $(document).ready(function() {
    var el, elements, toolbar, _i, _len;
    toolbar = new cw.Toolbar();
    toolbar.$el.appendTo('header > .right');
    toolbar.render();
    elements = ['viewer', 'message', 'save-message', 'filename'];
    for (_i = 0, _len = elements.length; _i < _len; _i++) {
      el = elements[_i];
      window.dom[el.replace('-', '_')] = $('#' + el);
    }
    window.dom.window = $(window);
    window.dom.shade = $('.shade');
    $.get('sample.md', function(text) {
      return cw.editor.setValue(text);
    });
    return cw.update();
  });

}).call(this);
