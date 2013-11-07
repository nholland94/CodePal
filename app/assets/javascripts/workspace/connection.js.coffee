((root) ->
  CodePal = root.CodePal = (root.CodePal || {})

  Connection = CodePal.Connection = {}

  start = Connection.start = ->
    # retrieve bootstrapped project id

    projectId = $('div#data').data("project-id")

    # fill code boxes with the project file data
    # for now, I assume they come in order
    # this needs to be fixed somehow

    $.ajax
      url: '/api/projects/' + projectId + '/project_files'
      type: 'get'
      success: (data, textStatus, xhr) ->
        CodePal.Editors.htmlBox.setValue(data[0].body, -1)
        CodePal.Editors.cssBox.setValue(data[1].body, -1)
        CodePal.Editors.renderOutput()
     
    # add save to navbar
    saveButton = $('<button class="workspace-save" type="button">Save</button>')

    CodePal.Navbar.addOption(saveButton)

    saveButton.click ->
      $.ajax
        data:
          files:
            html: CodePal.Editors.htmlBox.getValue()
            css: CodePal.Editors.cssBox.getValue()
        dataType: 'json'
        url: '/api/projects/' + projectId + '/project_files/save'
        type: 'post'
        success: (data, textStatus, xhr) ->
          CodePal.Lib.sendAlert("successfully saved", "success")
        error: (xhr, textStatus, errorThrown) ->
          CodePal.Lib.sendAlert("failed to save", "error")
 
)(this)
