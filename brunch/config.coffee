# See http://brunch.readthedocs.org/en/latest/config.html for documentation.

exports.config =
  paths:
    public: "../www"
    compass: "config/compass.js"

  files:
    javascripts:
      joinTo:
        "js/app.js": /^app/
        "js/vendor.js": /^vendor/
        "test/js/test.js": /^test(\/|\\)(?!vendor)/
        "test/js/test-vendor.js": /^test(\/|\\)(?=vendor)/
      order:
        before: [
          "vendor/js/zepto.js"
          "vendor/js/futures.js"
          "vendor/js/zepto.ajax.js"
          "vendor/js/zepto.event.js"
          "vendor/js/zepto.touch.js"
          "vendor/js/lodash.underscore-1.1.1.min.js"
          "vendor/js/backbone-1.0.0.js"
        ]

    stylesheets:
      joinTo:
        # Only compile the application's stylesheet
        # leaving compilation to the import rules
        "css/app.css": /\.sass/

    templates:
      defaultExtension: "jade"
      joinTo: "js/app.js"

  framework: "backbone"
