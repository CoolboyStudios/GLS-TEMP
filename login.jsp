<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="glscan.classes.UserCls"%>
<% UserCls user = null; %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>glScan - login...</title>
        <link type="text/css" rel="stylesheet" href="scripts/AppStyle.css">
        <link type="text/css" rel="stylesheet" href="scripts/jquery/smoothness/jquery-ui.min.css">
        <script type="text/javascript" src="scripts/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery-ui.min.js"></script>
        <script type="text/javascript" src="scripts/AppsUtil.js"></script>
        <script type="text/javascript">
            var wTimer;
            wTimer = self.setInterval(function () {fnCheckPageFullyLoaded('waitLayer', wTimer);}, 500);
        </script>
    </head>
    <body>
        <div class="DivBody">
            <table style="width:100%">
                <tr>
                    <td style="width:35%">&nbsp;</td>
                    <td>
                        <form name="FrmLogon" action="actions?req=login" method="post" onsubmit="return funIsValid();">
                            <table style="width:100%">
                                <tr>
                                    <td class="pgTitle" colspan="3">glScan Login</td>
                                    <td rowspan="8" style="width:15%">&nbsp;</td>
                                </tr>
                                <tr><td rowspan="6" style="width:15%">&nbsp;</td>
                                    <td colspan="2">&nbsp;</td></tr>
                                <tr>
                                    <td class="lables">User ID</td>
                                    <td class="textbox">
                                        <input type="text" id="TxtLOGINID" name="TxtLOGINID"
                                            tabindex="1" maxlength="20"
                                            onkeydown="fnKeydownfn(event, 'funIsValid()', 'FrmLogon');">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="lables">Password</td>
                                    <td class="textbox">
                                        <input type="password" id ="TxtCUPWD" name="TxtCUPWD" maxlength="15"
                                            onkeydown="fnKeydownfn(event, 'funIsValid()', 'FrmLogon');">
                                    </td>
                                </tr>
                                <tr><td colspan="2">&nbsp;</td></tr>
                                <tr>
                                    <td class="right" colspan="2">
                                        <input type="button" value="Login" onclick="funIsValid();">
                                    </td>
                                </tr>
                                <tr><td colspan="2">&nbsp;</td></tr>
                                <tr>
                                    <td class="error" colspan="3">
                                        <%
                                            Object obj = request.getAttribute("msg");
                                            if (obj != null) {
                                                out.print(obj.toString());
                                            }
                                            request.setAttribute("msg", null);
                                        %>&nbsp;
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </td>
                </tr>
            </table>
        </div>
        <%@ include file="includes/allpage.inc" %>
        <div id="LastElement"></div>
    </body>
    <script type="text/javascript">
        function funIsValid()
        {
            var user = $("#TxtLOGINID").val();
            var pwd = $("#TxtCUPWD").val();
            if(user===""){
                alert("User Id cannot be blank");
                $("#TxtLOGINID").focus();
            }else if(pwd===""){
                alert("Password cannot be blank");
                $("#TxtCUPWD").focus();
            }
            else{
                if ($("#TxtLOGINID").val()!=="bsk") {
                    if (!fnValidPwd(pwd, "")) {
                        return false;
                    }
                }
                var epwd = encodeURIComponent(pwd);
                $.get("ajax?req=pwdEncrpt&pwd=" + epwd,
                function(responseText) { 
                    if (responseText.toString()) {
                        $("#TxtCUPWD").prop('maxLength', 26);
                        $("#TxtCUPWD").val(responseText); 
                        document.forms["FrmLogon"].submit();
                    } 
                    else {
                        alert(responseText);
                    }
                })
                        .error(function(xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    alert("Please inform to Administrator for this error (Login)\n" + err.Message);
                  });
            }
        }
        
        $(document).ready(function() {
            $( "input[type=button], button" )
                .button()
                .click(function( event ) {
                    event.preventDefault();
                });
            $('#TxtLOGINID').focus();
        });
    </script>
</html>
