requirejs.config
    paths:
      "jquery": "lib/jquery-1.10.2"
      "backbone": "lib/backbone"
      "underscore": "lib/underscore"
    shim:
      "backbone":
        deps: ["underscore", "jquery"]
