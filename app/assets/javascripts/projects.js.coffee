((root) ->
  CodePal = root.CodePal = (root.CodePal || {})

  Index = CodePal.Index = {}

  fillFrame = (iframe, html, css, js) ->
    css = "<style>" + css + "</style>"
    css = CodePal.Editors.escapeStyleEndTag(css)
    $(iframe).contents().find("head").html(css)

    html = CodePal.Editors.escapeScriptTag(html)
    $(iframe).contents().find("body").html(html)

    # do some bullshit with javascript

  start = Index.start = ->
    root.paceOptions =
      ajax: false

    iframes = $(".project-show")

    _(iframes).each (iframe) ->
      $.ajax
        url: '/api/projects/' + $(iframe).data("project-id") + '/project_files'
        type: 'get'
        success: (data, textStatus, xhr) ->
          fillFrame(iframe, data[0].body, data[1].body, data[2].body)
        error:
          fillFrame(iframe, "error", "", "")

)(this)
