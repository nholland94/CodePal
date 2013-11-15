((root) ->
  CodePal = root.CodePal = (root.CodePal || {})

  Editors = CodePal.Editors = (CodePal.Editors || {})

  escapeStyleEndTag = Editors.escapeStyleEndTag = (str) ->
    # remove any cases of </style>
    escapedString = str.replace(/<\/style>/ig,'')
    return escapedString

  escapeScriptTag = Editors.escapeScriptTag = (str) ->
    # remove any cases of <script> or </script>
    escapedString = str.replace(/<\/?script>/ig,'')
    return escapedString

  escapeJavascript = Editors.escapeJavascript = (str) ->
    escapedString = str.replace(/<\/script>/ig,'')
    return escapedString

  isEnabled = Editors.isEnabled = (str) ->
    return $('#' + str + '-container').find('.editor-checkbox').is(':checked')

  renderOutput = Editors.renderOutput  = ->
    iframe = $('iframe')[0]

    # different browsers give different methods for iframes
    if iframe.contentDocument
      doc = iframe.contentDocument
    else if iframe.contentWindow
      doc = iframe.contentWindow.document
    else if iframe.document
      doc = iframe.document

    # this should never happen
    throw 'Document not initlialized' if doc == null

    # reset doc
    doc.open()
    doc.close()
  
    if isEnabled('css')
      cssString = Editors.cssBox.getValue()
      cssString = '<style>' + cssString + '</style>'
      cssString = escapeStyleEndTag(cssString)
      $('iframe').contents().find('head').append(cssString)

    if isEnabled('html')
      htmlString = Editors.htmlBox.getValue()
      htmlString = escapeScriptTag(htmlString)
      $('iframe').contents().find('body').html(htmlString)
 
    if isEnabled('js')
      # jquery really doesn't like script tags
      # so I am implementing a workaround with no jquery

      # first, get the iframe with jquery and index it
      # this turns it into a regular DOM element

      # document -> html -> head
      head = doc.children[0].children[0]

      jqueryTag = doc.createElement('script')
      jqueryTag.type = 'text/javascript'
      jqueryTag.src = 'http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js'
      head.appendChild(jqueryTag)

      script = doc.createElement('script')
      script.type = 'text/javascript'
      script.text = Editors.jsBox.getValue()
      head.appendChild(script)
     
      ###
      jsString = Editors.jsBox.getValue()
      jsString = '<scr' + 'ipt>' + jsString + '</scr' + 'ipt>'
      jsString = escapeJavascript(jsString)
      $('iframe').contents().find('head').append(jsString)
      ###

  start = Editors.start = ->
    htmlBox = Editors.htmlBox = ace.edit('html-box')
    htmlBox.$el = $('#html-box')
    htmlBox.setTheme('ace/theme/monokai')
    htmlBox.getSession().setMode('ace/mode/html')
    htmlBox.setShowPrintMargin(false)
    htmlBox.setHighlightActiveLine(true)
    htmlBox.setBehavioursEnabled(true)
    htmlBox.getSession().setUseWrapMode(true)

    cssBox = Editors.cssBox = ace.edit('css-box')
    cssBox.$el = $('#css-box')
    cssBox.setTheme('ace/theme/monokai')
    cssBox.getSession().setMode('ace/mode/css')
    cssBox.setShowPrintMargin(false)
    cssBox.setHighlightActiveLine(true)
    cssBox.setBehavioursEnabled(true)
    cssBox.getSession().setUseWrapMode(true)

    jsBox = Editors.jsBox = ace.edit('js-box')
    jsBox.$el = $('#js-box')
    jsBox.setTheme('ace/theme/monokai')
    jsBox.getSession().setMode('ace/mode/javascript')
    jsBox.setShowPrintMargin(false)
    jsBox.setHighlightActiveLine(true)
    jsBox.setBehavioursEnabled(true)
    jsBox.getSession().setUseWrapMode(true)

    $('button').click ->
      renderOutput()
      
    $('.editor-checkbox').click ->
      console.log('got here')
      renderOutput()

    checkAutoFill = ->
      renderOutput() if $('input#autorun').is(':checked')

    htmlBox.getSession().on('change', checkAutoFill)
    cssBox.getSession().on('change', checkAutoFill)
    jsBox.getSession().on('change', checkAutoFill)

    Editors.OptionsMenu.start()

)(this)
