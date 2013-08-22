define ['jquery'], ->
    $(".hello").each ->
        $wrap = $ this
        $form = $wrap.find "form"
        $input = $wrap.find "input"
        $label = $wrap.find "label"
        $form.on "submit", ->
            $label.text($input.val())
            return false
