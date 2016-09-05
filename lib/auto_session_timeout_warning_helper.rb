module AutoSessionTimeoutWarningHelper
  def auto_session_timeout_js(options={})
    frequency = options[:frequency] || 60
    timeout = options[:timeout] || 60
    start = options[:start] || 60
    warning = options[:warning] || 20
    code = <<JS
if(typeof(jQuery) != 'undefined'){
  $("#logout_dialog").dialog({
    modal: true,
    bgiframe: true,
    width: 500,
    height: 180,
    autoOpen: false,
    dialogClass: "no-close"
  });

  $(".logout_dialog").click(function (e) {
    e.preventDefault();

    $("#logout_dialog").dialog('option', 'buttons', {
      "Continue": function () {
        window.location.reload();
      }
    });

    $("#logout_dialog").dialog("open");

  });

  function PeriodicalQuery() {
    $.ajax({
      url: '/active',
      success: function(data) {
        if(new Date(data.timeout).getTime() < (new Date().getTime() + #{warning} * 1000)){
          showDialog();
        }
        if(data.live == false){
          window.location.href = '/timeout';
        }
      }
    });
    setTimeout(PeriodicalQuery, (#{frequency} * 1000));
  }
  setTimeout(PeriodicalQuery, (#{start} * 1000));

  function showDialog(){
    $('.logout_dialog').trigger('click');
  }
}
JS
    javascript_tag(code)
  end

  # Generates viewport-covering dialog HTML with message in center
  #   options={} are output to HTML. Be CAREFUL about XSS/CSRF!
  def auto_session_warning_tag(options={})
    default_message = "You are about to be logged out due to inactivity.<br/><br/>Please click &lsquo;Continue&rsquo; to stay logged in."
    html_message = options[:message] || default_message
    warning_title = options[:title] || "Logout Warning"
    warning_classes = !!(options[:classes]) ? ' class="' + options[:classes] + '"' : ''

    # Marked .html_safe -- Passed strings are output directly to HTML!
    "<div id='logout_dialog' title='#{warning_title}' style='display:none;'#{warning_classes}>
      #{html_message}
    </div>
    <div class='logout_dialog'></div>".html_safe
  end
end

ActionView::Base.send :include, AutoSessionTimeoutWarningHelper
