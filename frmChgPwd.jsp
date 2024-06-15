<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="glscan.classes.UserCls"%>
<%@ include file="includes/SessionValid.inc" %>
<%
    String lType = (String)request.getSession().getAttribute("objType");
    if (lType==null) {
        request.setAttribute("msg", "There is a program error(MNU800).<br>Please convey to administator with this error code.");
        request.getRequestDispatcher("login.jsp").forward(request, response);            
        return;
    }
    if (!lType.startsWith("mnu800")) {
        request.setAttribute("msg", "There is a program error(MNU800).<br>Please convey to administator with this error code.\n" + lType);
        request.getRequestDispatcher("login.jsp").forward(request, response);            
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>glScan - Change Password</title>
        <link type="text/css" rel="stylesheet" href="scripts/AppStyle.css">
        <link type="text/css" rel="stylesheet" href="scripts/jquery/smoothness/jquery-ui.min.css">
        <script type="text/javascript" src="scripts/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery-ui.min.js"></script>
        <script type="text/javascript" src="scripts/AppsUtil.js"></script>
        <script type="text/javascript">
            var wTimer;
            wTimer = self.setInterval(function () {
                fnCheckPageFullyLoaded('waitLayer', wTimer);
                <%if (lType.equals("mnu800C"))  {%>
                    $('#menu').hide();
                    $('#btnLogout').show();
                <%} else {%>
                    $('#btnLogout').hide();
                <%}%>
            }, 500);
        </script>
    </head>
    <body>
        <div class="DivBody">
            <form id="FrmChgPwd" name="FrmChgPwd" action="actions?req=Save800" method="post">
                <table style="width:100%">
                    <tr>
                        <td class="pgTitle" colspan="2">Change Password</td>
                    </tr>
                    <tr>
                        <td class="lables" colspan="2">
                            Fields marked with <span class="bold" style="color: orange">*</span> are required.
                        </td>
                    </tr>
                    <tr><td colspan="2">&nbsp;</td></tr>
                    <tr><td colspan="2">&nbsp;</td></tr>
                    <tr>
                        <td class="lables" style="width:25%">Current Password
                            <span class="bold" style="color: orange">*</span>
                        </td>
                        <td class="textbox">
                            <input name="TxtOldPWD" type="hidden" id="TxtOldPWD" value="<%out.print(user.getCUPWD());%>">
                            <input type="password" id="TxtCurPWD" name="TxtCurPWD" maxlength="15" tabindex="1">
                        </td>
                    </tr>
                    <tr>
                        <td class="lables">New Password
                            <span class="bold" style="color: orange">*</span>
                        </td>
                        <td class="textbox">
                            <input type="password" id ="TxtNewPWD" name="TxtNewPWD" maxlength="15">
                        </td>
                    </tr>
                    <tr>
                        <td class="lables">Confirm New Password
                            <span class="bold" style="color: orange">*</span>
                        </td>
                        <td class="textbox">
                            <input type="password" id ="TxtConPWD" name="TxtConPWD" maxlength="15">
                        </td>
                    </tr>
                    <tr><td colspan="2">&nbsp;</td></tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>
                            <input type="button" value="Change Password" onclick="funIsValid();">
                            <img src="images/wspacer.jpg" hspace="4" alt=' '>
                            <input id="btnLogout" type="button" value="Logout" onclick="funLogout();">
                        </td>
                    </tr>
                    <tr><td colspan="2">&nbsp;</td></tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td class="error">
                            <%
                                Object obj = request.getAttribute("msg");
                                if (obj != null) {
                                    out.print(obj.toString());
                                }
                                request.setAttribute("msg", null);
                            %>
                        </td>
                    </tr>
                    <tr><td colspan="2">&nbsp;</td></tr>
                    <tr>
                        <td class="lables" colspan="2">
                            <b>Note:</b> Password should contain at least 7 characters.<br>
                            Password should not be the same as the User ID.<br>
                            Password should contain at least 3 of the following 4 character groups:<br>
                            [A-Z],[a-z],[0-9],one of the following non-alphabet characters !%$# <br>
                            New password should be different than the 5 previous passwords.
                        </td>
                    </tr>
                    
                </table>
            </form>
        </div>
        <%@ include file="includes/allpage.inc" %>
        <div id="LastElement"></div>
    </body>
    <script type="text/javascript">
        function funLogout() {
            $('#FrmChgPwd').attr('action', 'actions?req=mnu900');
            $('#FrmChgPwd').submit();
        }
        
        function funIsValid() {
            var curp = $("#TxtCurPWD").val();
            var newp = $("#TxtNewPWD").val();
            var newc = $("#TxtConPWD").val();
            
            if (!fnValidPwd(newp, "New")) {
                return false;
            }
            if (!fnValidPwd(newc, "Confirm")) {
                return false;
            }
            if (curp === newp){
                alert("New password should be different than your previous passwords. Please try again.");
                $("#TxtNewPWD").focus();
                return false;
            }
            // Current is 
            if (newp !== newc){
                alert("The new password and confirm password are not match. Please try again.");
                $("#TxtNewPWD").focus();
                return false;
            }
            // encrypt curp
            var epwd = encodeURIComponent(curp);
            $.get("ajax?req=pwdEncrpt&pwd=" + epwd,
                function(responseText) { 
                    if (responseText.toString()) {
                        var oldp = $("#TxtOldPWD").val();
                        if (oldp !== responseText){
                            alert("Current password is invalid. Please re-enter it.");
                            $("#TxtCurPWD").val().focus();
                            return false;
                        }
                        $("#TxtCurPWD").prop('maxLength', 26);
                        $("#TxtCurPWD").val(responseText);
                        funEnNewPwd();
                    } 
                    else {
                        alert(responseText);
                    }
                })
                        .error(function(xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    alert("Please inform to Administrator for this error (Change pwd 1)\n" + err.Message);
                  });
            
        }
        
        function funEnNewPwd() {
            var newp = $("#TxtNewPWD").val();
            //encrypt newp
            var epwd = encodeURIComponent(newp);
            $.get("ajax?req=pwdEncrpt&pwd=" + epwd,
                function(responseText) { 
                    //fnHideLayer("waitLayer");
                    if (responseText.toString()) {
                        $("#TxtNewPWD").prop('maxLength', 26);
                        $("#TxtNewPWD").val(responseText); 
                        $("#TxtConPWD").prop('maxLength', 26);
                        $("#TxtConPWD").val(responseText);
                        document.forms["FrmChgPwd"].submit();
                    } 
                    else {
                        alert(responseText);
                    }
                })
                        .error(function(xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    alert("Please inform to Administrator for this error (Change pwd 2)\n" + err.Message);
                  });
        }
        
        $(document).ready(function() {
            $( "input[type=button], button" )
                .button()
                .click(function( event ) {
                    event.preventDefault();
                });
        });
    </script>
</html>
