((root) ->
  CodePal = root.CodePal = (root.CodePal || {})

  Connection = CodePal.Connection = {}

  getProjectId = Connection.getProjectId = ->
    return $('div#data').data("project-id")

  getStoredValues = Connection.getStoredValues = (callback) ->
    $.ajax
      url: '/api/projects/' + getProjectId() + '/project_files'
      type: 'get'
      success: (data, textStatus, xhr) ->
        CodePal.Editors.htmlBox.setValue(data[0].body, -1)
        CodePal.Editors.cssBox.setValue(data[1].body, -1)
        CodePal.Editors.jsBox.setValue(data[2].body, -1)
        CodePal.Editors.renderOutput()
    callback()
   
  setupSessionButton = Connection.setupSessionButton = ->
    joinButton = $('<a href="workspace/session" class="workspace-join" title="Join a live session"></a>')

    CodePal.Navbar.addOption(joinButton)

    joinButton.html('<img src="/assets/pair.png">')

  setupSaveButton = Connection.setupSaveButton = ->
    # add save to navbar
    # saveButton = $('<a class="workspace-save"><img src="/assets/save.png"></a>')
    # saveButton = $('<button></button>')
    saveButton = $('<a class="workspace-save" title="Save"></a>')

    CodePal.Navbar.addOption(saveButton)

    # saveButton.html('<img src="/assets/home.png">')
    saveButton.html('<img src="/assets/save.png">')

    saveButton.click ->
      $.ajax
        data:
          files:
            html: CodePal.Editors.htmlBox.getValue()
            css: CodePal.Editors.cssBox.getValue()
            js: CodePal.Editors.jsBox.getValue()
        dataType: 'json'
        url: '/api/projects/' + getProjectId() + '/project_files/save'
        type: 'post'
        success: (data, textStatus, xhr) ->
          CodePal.Lib.sendAlert("successfully saved", "success")
        error: (xhr, textStatus, errorThrown) ->
          CodePal.Lib.sendAlert("failed to save", "error")

  start = Connection.start = (getInitial)  ->
    # fill code boxes with the project file data
    # for now, I assume they come in order
    # this needs to be fixed somehow
    if !getInitial
      getStoredValues ->
        setupSaveButton()
    else
      setupSaveButton()
)(this)
