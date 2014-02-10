(function() {
  define(['jquery'], function() {
    return $(".hello").each(function() {
      var $form, $input, $label, $wrap;
      $wrap = $(this);
      $form = $wrap.find("form");
      $input = $wrap.find("input");
      $label = $wrap.find("label");
      return $form.on("submit", function() {
        $label.text($input.val());
        return false;
      });
    });
  });

}).call(this);
