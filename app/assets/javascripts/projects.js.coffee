((root) ->
  CodePal = root.CodePal = (root.CodePal || {})

  Index = CodePal.Index = {}

  fillFrame = (iframe, html, css, js) ->
    css = "<style>" + css + "</style>"
    css = CodePal.Editors.escapeStyleEndTag(css)
    $(iframe).contents().find("head").html(css)

    html = CodePal.Editors.escapeScriptTag(html)
    $(iframe).contents().find("body").html(html)
   
    iframe = $('iframe')[0]

    if iframe.contentDocument
      doc = iframe.contentDocument
    else if iframe.contentWindow
      doc = iframe.contentWindow.document
    else if iframe.document
      doc = iframe.document

    throw "Document not initialized" if doc == null
    
    head = doc.children[0].children[0]

    jqueryTag = doc.createElement('scipt')
    jqueryTag.type = 'text/javascript'
    jqueryTag.src = 'http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js'
    head.appendChild(jqueryTag)

    script = doc.createElement('script')
    script.type = 'text/javascript'
    script.text = CodePal.Editors.escapeJavascript(js)
    head.appendChild(script)

  start = Index.start = ->
    root.paceOptions =
      ajax: false

    iframes = $(".project-show")

    _(iframes).each (iframe) ->
      $.ajax
        url: '/api/projects/' + $(iframe).data("project-id") + '/project_files'
        type: 'get'
        success: (data, textStatus, xhr) ->
          html = null
          css = null
          js = null

          _(data).each (boxData) ->
            if boxData.file_type == "html"
              html = boxData.body
            else if boxData.file_type == "css"
              css = boxData.body
            else if boxData.file_type == "js"
              js = boxData.body
            else
              throw "Could not find where the file goes"

          if html == null || css == null || js == null
            throw "Did not process all files"
 
          fillFrame(iframe, data[0].body, data[1].body, data[2].body)
        error:
          fillFrame(iframe, "error", "", "")

)(this)
