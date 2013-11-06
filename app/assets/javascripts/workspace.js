$(document).ready(function() { 
  var htmlBox = ace.edit("html-box");
  htmlBox.setTheme("ace/theme/monokai");
  htmlBox.getSession().setMode("ace/mode/html");
  htmlBox.setShowPrintMargin(false);
  htmlBox.setHighlightActiveLine(true);
  htmlBox.setBehavioursEnabled(true);
  htmlBox.getSession().setUseWrapMode(true);

  var cssBox = ace.edit("css-box");
  cssBox.setTheme("ace/theme/monokai");
  cssBox.getSession().setMode("ace/mode/css");
  cssBox.setShowPrintMargin(false);
  cssBox.setHighlightActiveLine(true);
  cssBox.setBehavioursEnabled(true);
  cssBox.getSession().setUseWrapMode(true);

  var escapeStyleEndTag = function(str) {
    // remove any cases of </style> so there can be no script injections
    return str;
  };

  var escapeScriptTag = function(str) {
    // remove any cases of <script> or </script>
    return str;
  };

  var renderOutput = function() {
    var cssString = cssBox.getValue();
    cssString = "<style>" + cssString + "</style>";
    cssString = escapeStyleEndTag(cssString);
    $("iframe").contents().find("head").html(cssString);

    var htmlString = htmlBox.getValue();
    htmlString = escapeScriptTag(htmlString);
    $("iframe").contents().find("body").html(htmlString);
  };

  $("button").click(function(e) {
    renderOutput();
  });

  var checkAutoFill = function(e) {
    if($("input#autorun").is(":checked")) {
      renderOutput();
    }
  };

  htmlBox.getSession().on("change", checkAutoFill);
  cssBox.getSession().on("change", checkAutoFill); 

  //add save to navbar
  //will be replaced with some backbonr/ajax later


  //CodePal.Navbar.addOption();
});
