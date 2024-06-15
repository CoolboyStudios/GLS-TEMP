<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="glscandb.AppUtils,glscandb.classes.UserCls"%>
<%@ include file="includes/SessionValid.inc" %>
<%
    String lType = (String)request.getSession().getAttribute("objType");
    if (lType==null) {
        request.setAttribute("msg", "There is a program error(MNU800).<br>Please convey to administator with this error code.");
        request.getRequestDispatcher("logon.jsp").forward(request, response);            
        return;
    }
    if (!lType.startsWith("mnu800")) {
        request.setAttribute("msg", "There is a program error(MNU800).<br>Please convey to administator with this error code.\n" + lType);
        request.getRequestDispatcher("logon.jsp").forward(request, response);            
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>glScanDB- Change Password</title>
        <link type="image/icon" href="images/sysicon.gif" rel="shortcut icon"/>
        <style type="text/css">
            @import "includes/apps.css";
            @import "scripts/jquery/smoothness/jquery-ui.min.css";
        </style>
        
        <script type="text/javascript" src="scripts/TableFilter/tablefilter_all_min.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery-ui.min.js"></script>
        <script type="text/javascript" src="scripts/AppsUtil.js"></script>
        
        <script type="text/javascript">
            var wTimer;
            wTimer = self.setInterval(function () {fnCheckPageFullyLoaded('waitLayer', wTimer);}, 1000);
        </script>
    </head>
    <body>
        <table width="100%">
            <tr>
                <td>
                    <%@ include file="includes/pgtop.inc" %>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <table id="tblHome" style="width:30%">
                        <tr>
                            <td class=MainHeading align=center>
                                Change Password
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td align=center>
                                <form name="FrmChgPwd" action="Actions?req=SaveCPwd" method="post">
                                    <table id="tblfrm" width="30%">
                                        <tr>
                                            <td class="BoldLeft" width="45%">Current Password</td>
                                            <td width="10%"></td>
                                            <td class="Left" width="45%">
                                                <input name="TxtOldPWD" type="hidden" id="TxtOldPWD" value="<%out.print(user.getPWD());%>">
                                                <input name="TxtCurPWD" type="password" 
                                                       size="8" maxlength="8" id="TxtCurPWD"></td>
                                        </tr>
                                        <tr>
                                            <td class="BoldLeft">New Password</td>
                                            <td></td>
                                            <td class="Left">
                                                <input name="TxtNewPWD" type="password" 
                                                       size="8" maxlength="8" id="TxtNewPWD">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="BoldLeft">Confirm New Password</td>
                                            <td></td>
                                            <td class="Left">
                                                <input name="TxtConPWD" type="password" 
                                                       size="8" maxlength="8" id="TxtConPWD"></td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" align="center">
                                                <input type="Button" 
                                                       name="btnChange" value="Change" 
                                                       onclick="javascript:funIsValid();">
                                                <img class="wspace" src="images\wspacer.jpg" >
                                                <input type="Button"  
                                                       value="Clear" 
                                                       onclick="javascript:funClearData();">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" class="Error">
                                                <span id="error" >
                                                <%
                                                    Object obj = request.getAttribute("msg");
                                                    if (obj != null) {
                                                        out.print(obj.toString());
                                                    }
                                                %>
                                                </span>
                                            </td>
                                        </tr>
                                    </table>
                                </form>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <script type="text/javascript">
            function funClearData() {
                document.FrmChgPwd.TxtCurPWD.value = "";
                document.FrmChgPwd.TxtNewPWD.value = "";
                document.FrmChgPwd.TxtConPWD.value = "";
                document.FrmChgPwd.TxtCurPWD.focus();
            }

            function funIsValid(){
                var oldp = document.FrmChgPwd.TxtOldPWD.value;
                var curp = document.FrmChgPwd.TxtCurPWD.value;
                var newp = document.FrmChgPwd.TxtNewPWD.value;
                var newc = document.FrmChgPwd.TxtConPWD.value;
                //alert(oldp);
                if(curp===""){
                    alert("Current password cannot be blank");
                    document.FrmChgPwd.TxtCurPWD.focus();
                    return;
                }
                if(newp===""){
                    alert("New password cannot be blank");
                    document.FrmChgPwd.TxtNewPWD.focus();
                    return;
                }
                //newp = trim(newp, "");
                if(newp.length < 5){
                    alert("New password cannot be less then 5 charecter length.");
                    document.FrmChgPwd.TxtNewPWD.focus();
                    return;
                }
                if(newc===""){
                    alert("Confirm New password cannot be blank");
                    document.FrmChgPwd.TxtConPWD.focus();
                    return;
                }
                //newc = trim(newc, "");
                if (newp!==newc){
                    alert("The password you typed do not match. Please type the new password.");
                    document.FrmChgPwd.TxtConPWD.value="";
                    document.FrmChgPwd.TxtNewPWD.value="";
                    document.FrmChgPwd.TxtNewPWD.focus();
                    return;
                }
                
                if (curp===newp){
                    alert("The password you typed match with the current password. Please type the new password.");
                    document.FrmChgPwd.TxtConPWD.value="";
                    document.FrmChgPwd.TxtNewPWD.value="";
                    document.FrmChgPwd.TxtNewPWD.focus();
                    return;
                }
                
                /*if (curp!==oldp){
                    alert("Invalid Valid current password. Please reenter it.");
                    document.FrmChgPwd.TxtCurPWD.value="";
                    document.FrmChgPwd.TxtCurPWD.focus();
                    return;
                }
                document.forms["FrmChgPwd"].submit();
                return;*/
                
                // encrypt curp
                $.get("AjaxActions?req=pwdEncrpt&pwd="+ curp,
                    function(responseText) { 
                        //fnHideLayer("waitLayer");
                        if (responseText.toString()) {
                            var curp1 = document.FrmChgPwd.TxtOldPWD.value;
                            //alert(responseText);
                            if (curp1 !== responseText){
                                alert("Invalid Valid current password. Please reenter it.");
                                document.FrmChgPwd.TxtCurPWD.value="";
                                document.FrmChgPwd.TxtCurPWD.focus();
                                return;
                            }
                            document.FrmChgPwd.TxtCurPWD.maxlength = 26;
                            document.FrmChgPwd.TxtCurPWD.value = responseText; 
                        } else {
                            alert(responseText);
                        }
                    }).error(function(xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert("Please inform to Administrator for this error (Change pwd 1)\n" + err.Message);
                      });
                //encrypt newp
                $.get("AjaxActions?req=pwdEncrpt&pwd="+ newp,
                    function(responseText) { 
                        //fnHideLayer("waitLayer");
                        if (responseText.toString()) {
                            document.FrmChgPwd.TxtNewPWD.maxlength = 26;
                            document.FrmChgPwd.TxtNewPWD.value = responseText; 
                            document.FrmChgPwd.TxtConPWD.maxlength = 26;
                            document.FrmChgPwd.TxtConPWD.value = responseText;
                document.forms["FrmChgPwd"].submit();
                        } else {
                            alert(responseText);
            }
                    }).error(function(xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert("Please inform to Administrator for this error (Change pwd 2)\n" + err.Message);
                      });
        
                
            }
        
            $(document).ready(function() {
                // for GUI jquery button assingment
               $(function() {
                   $( "input[type=button], button" )
                       .button()
                       .click(function( event ) {
                           event.preventDefault();
                       });
               });
               
               <% String pcm = (String)request.getSession().getAttribute("objParam");
                if (pcm.equals("MUST")) { %>
                    //$("#mnu100").addClass("ui-state-disabled");
                    $("#error").html("Your Password was expired, please change it now.");
               <%}%>
            });
            
        </script>
        <!-- Alert (message) -->
        <div id="LastElement"></div>
        <%out.print(AppUtils.printMessage(request));%>
    </body>
</html>
