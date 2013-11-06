$(document).ready ->
  htmlBox = ace.edit("html-box")
  htmlBox.setTheme("ace/theme/monokai")
  htmlBox.getSession().setMode("ace/mode/html")
  htmlBox.setShowPrintMargin(false)
  htmlBox.setHighlightActiveLine(true)
  htmlBox.setBehavioursEnabled(true)
  htmlBox.getSession().setUseWrapMode(true)

  cssBox = ace.edit("css-box")
  cssBox.setTheme("ace/theme/monokai")
  cssBox.getSession().setMode("ace/mode/css")
  cssBox.setShowPrintMargin(false)
  cssBox.setHighlightActiveLine(true)
  cssBox.setBehavioursEnabled(true)
  cssBox.getSession().setUseWrapMode(true)

  escapeStyleEndTag = (str) ->
    # remove any cases of </style> so there can be no script injections
    return str

  escapeScriptTag = (str) ->
    # remove any cases of <script> or </script>
    return str

  renderOutput = ->
    cssString = cssBox.getValue()
    cssString = "<style>" + cssString + "</style>"
    cssString = escapeStyleEndTag(cssString)
    $("iframe").contents().find("head").html(cssString)

    htmlString = htmlBox.getValue()
    htmlString = escapeScriptTag(htmlString)
    $("iframe").contents().find("body").html(htmlString)

  $("button").click ->
    renderOutput()

  checkAutoFill = ->
    renderOutput() if $('input#autorun').is(':checked')

  # add events to code boxes

  htmlBox.getSession().on("change", checkAutoFill)
  cssBox.getSession().on("change", checkAutoFill)

  # retrieve bootstrapped project id

  projectId = $('div#data').data("project-id")  

  # fill code boxes with the project file data
  # for now, I assume they come in order
  # this needs to be fixed somehow

  $.ajax
    url: '/api/projects/' + projectId + '/project_files'
    type: 'get'
    success: (data, textStatus, xhr) ->
      htmlBox.setValue(data[0].body, -1)
      cssBox.setValue(data[1].body, -1)
      renderOutput()

  # add save to navbar
  saveButton = $('<button class="workspace-save" type="button">Save</button>')

  CodePal.Navbar.addOption(saveButton) 

  saveButton.click ->
    $.ajax
      data:
        files:
          html: htmlBox.getValue()
          css: cssBox.getValue()
      dataType: 'json'
      url: '/api/projects/' + projectId + '/project_files/save'
      type: 'post'
      success: (data, textStatus, xhr) ->
        CodePal.Lib.sendAlert("successfully saved", "success")
        console.log(data)
      error: (xhr, textStatus, errorThrown) ->
        CodePal.Lib.sendAlert("failed to save", "error")
