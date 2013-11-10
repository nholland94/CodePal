((root) ->
  CodePal = root.CodePal = (root.CodePal || {})

  Editors = CodePal.Editors = (CodePal.Editors || {})

  escapeStyleEndTag = (str) ->
    # remove any cases of </style>
    escapedString = str.replace(/<\/style>/ig,"")
    return escapedString

  escapeScriptTag = (str) ->
    # remove any cases of <script> or </script>
    escapedString = str.replace(/<\/?script>/ig,"")
    return escapedString

  isEnabled = Editors.isEnabled = (str) ->
    return $('#' + str + '-container').find('.editor-checkbox').is(':checked')

  renderOutput = Editors.renderOutput  = ->
    if isEnabled('css')
      cssString = Editors.cssBox.getValue()
      cssString = "<style>" + cssString + "</style>"
      cssString = escapeStyleEndTag(cssString)
      $("iframe").contents().find("head").html(cssString)
    else
      $("iframe").contents().find("head").html("")

    if isEnabled('html')
      htmlString = Editors.htmlBox.getValue()
      htmlString = escapeScriptTag(htmlString)
      $("iframe").contents().find("body").html(htmlString)
    else
      $("iframe").contents().find("body").html("")
 
  start = Editors.start = ->
    htmlBox = Editors.htmlBox = ace.edit("html-box")
    htmlBox.$el = $("#html-box")
    htmlBox.setTheme("ace/theme/monokai")
    htmlBox.getSession().setMode("ace/mode/html")
    htmlBox.setShowPrintMargin(false)
    htmlBox.setHighlightActiveLine(true)
    htmlBox.setBehavioursEnabled(true)
    htmlBox.getSession().setUseWrapMode(true)

    cssBox = Editors.cssBox = ace.edit("css-box")
    cssBox.$el = $("#css-box")
    cssBox.setTheme("ace/theme/monokai")
    cssBox.getSession().setMode("ace/mode/css")
    cssBox.setShowPrintMargin(false)
    cssBox.setHighlightActiveLine(true)
    cssBox.setBehavioursEnabled(true)
    cssBox.getSession().setUseWrapMode(true)

    $("button").click ->
      renderOutput()
      
    $(".editor-checkbox").click ->
      console.log("got here")
      renderOutput()

    checkAutoFill = ->
      renderOutput() if $('input#autorun').is(':checked')

    htmlBox.getSession().on("change", checkAutoFill)
    cssBox.getSession().on("change", checkAutoFill)

    Editors.OptionsMenu.start()

)(this)
