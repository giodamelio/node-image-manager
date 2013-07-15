/*
 *
 *  jQuery truncateLines by Gary Hepting - https://github.com/ghepting/truncateLines
 *  
 *  Open source under the MIT License. 
 *
 *  Copyright © 2013 Gary Hepting. All rights reserved.
 *
*/


(function() {
  var TruncatedLines;

  TruncatedLines = (function() {
    function TruncatedLines(el) {
      this.el = el;
      $(this.el).attr('data-text', $(this.el).text());
      this.words = $(this.el).attr('data-text').trim().split(" ");
      this.lines = parseInt($(this.el).attr('data-truncate'));
      this.truncate();
      this.adjustOnResize();
    }

    TruncatedLines.prototype.truncate = function() {
      this.reset();
      this.measure();
      return this.setContent();
    };

    TruncatedLines.prototype.reset = function() {
      return $(this.el).text($(this.el).attr('data-text')).css('max-height', 'none').attr('data-truncated', 'false');
    };

    TruncatedLines.prototype.measure = function() {
      var i;
      this.empty();
      $(this.el).html(".");
      i = 1;
      while (i++ < this.lines) {
        $(this.el).append("<br>.");
      }
      this.maxLinesHeight = $(this.el).outerHeight();
      return this.empty();
    };

    TruncatedLines.prototype.empty = function() {
      return $(this.el).html("");
    };

    TruncatedLines.prototype.setContent = function() {
      var i, j, _results;
      i = 0;
      _results = [];
      while (i++ < this.words.length) {
        $(this.el).append(" " + this.words[i]);
        if ($(this.el).outerHeight() > this.maxLinesHeight) {
          i = this.words.length;
          this.finalWords = $(this.el).text().trim().split(" ");
          this.finalWords.pop();
          this.finalWords[this.finalWords.length - 1] = this.finalWords[this.finalWords.length - 1].replace(/[\.,-\/#!$%\^&\*;:{}=\-_`~()]$/, '');
          $(this.el).html("");
          j = 0;
          while (j < this.finalWords.length) {
            $(this.el).append(" " + this.finalWords[j]);
            j++;
          }
          $(this.el).css('max-height', this.maxLinesHeight + 'px');
          $(this.el).attr('data-truncated', 'true');
        }
        _results.push(i++);
      }
      return _results;
    };

    TruncatedLines.prototype.adjustOnResize = function() {
      var _this = this;
      return $(window).on('resize', function() {
        return _this.truncate();
      });
    };

    return TruncatedLines;

  })();

  (function($) {
    var truncateInitialized;
    truncateInitialized = false;
    return $.fn.truncateLines = function() {
      if (!truncateInitialized) {
        $('head').append('<style type="text/css"> [data-truncated="true"] { overflow: hidden; } [data-truncated="true"]:after { content: "..."; position: absolute; } </style>');
      }
      return this.each(function() {
        return new TruncatedLines(this);
      });
    };
  })(jQuery);

  $("[data-truncate]").truncateLines();

}).call(this);
