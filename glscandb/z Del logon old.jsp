<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>glScanDB Login...</title>
        <link type="image/icon" href="images/sysicon.gif" rel="shortcut icon"/>
        <link type="text/css" href="includes/apps.css" rel="stylesheet">
        
        <script type="text/javascript" src="scripts/jquery/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="scripts/AppsUtil.js"></script>
        <script type="text/javascript">
            function funOnLoad() {
                //alert((fnGetHeight() *.55) + "px");
                document.getElementById('setTH').style.height  = (fnGetHeight() *.55) + "px";
                document.getElementById('setBF').style.height  = (fnGetHeight() *.15) + "px";
                document.forms["FrmLogon"].elements["TxtUserName"].focus();
            }
            
            function funClearFields()
            {
                document.forms["FrmLogon"].reset();
                fnFocus("TxtUserName", true);
            }
            
            function funIsValid()
            {
                var user = document.FrmLogon.TxtUserName.value;
                var pwd = document.FrmLogon.TxtPassword.value;
                if(user===""){
                    alert("User Id cannot be blank");
                    document.FrmLogon.TxtUserName.focus();
                }else if(pwd===""){
                    alert("Password cannot be blank");
                    document.FrmLogon.TxtPassword.focus();
                }
                else{
                    
                    /*document.forms["FrmLogon"].submit();
                    return;*/
                    //fnShowLayer("waitLayer");
                    $.get("AjaxActions?req=pwdEncrpt&pwd="+ pwd,
                    function(responseText) { 
                        //fnHideLayer("waitLayer");
                        if (responseText.toString()) {
                            document.FrmLogon.TxtPassword.maxlength = 26;
                            document.FrmLogon.TxtPassword.value = responseText; 
                            document.forms["FrmLogon"].submit();
                        } else {
                            alert(responseText);
                        }
                    }).error(function(xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert("Please inform to Administrator for this error (Login)\n" + err.Message);
                      });
                }
            }
        </script>
    </head>
    <body class="bgImage" onKeyDown="javascript:fnMicrosoftKeyDown();" onLoad="javascript:funOnLoad();">
        <form name="FrmLogon" action="Actions?req=login" method="post" onsubmit="return funIsValid();">
            <table style="width:50%" class="Center" align="center">
                <tr>
                    <td colspan="4" id="setTH" style="vertical-align: middle;" class="Center">
                        <table style="width:40%" align="center">
                            <tr>
                                <td class="bulletin_login Center Center">emScan</td>
                            </tr>
                            <tr>
                                <td class="bulletin_caps Center">Public Notice Archiving v1.0</td>
                            </tr>
                        </table>
                    </td>
                </tr>
                
                <tr>
                    <td style="width:25%" rowspan="2">&nbsp;</td>
                    <td style="width:20%" class="Left">
                        <strong>Login ID</strong>
                    </td>
                    <td style="width:20%" class="Left">
                        <input id="TxtUserName" name="TxtUserName" type="text" maxlength="8"
                               onkeydown="fnKeydownfn(event, 'funIsValid()', 'FrmLogon');" 
                               style="background-color:White;border-color:Black;border-width:1px;border-style:Solid;width:120px;" />   
                    </td>
                    <td style="width:25%" rowspan="2">&nbsp;</td>
                </tr>
                <tr>
                    <td class="Left">
                        <STRONG>Password</STRONG>
                    </td>
                    <td class="Left">
                        <input id="TxtPassword" name="TxtPassword" type="password" maxlength="8"
                               onkeydown="fnKeydownfn(event, 'funIsValid()', 'FrmLogon');" 
                               style="border-color:Black;border-width:1px;border-style:solid;width:120px;" />    
                    </td>
                </tr>
                <tr>
                    <td colspan="4" class="Center">
                        <img class="wspace" src="images/wspacer.jpg"  alt=" ">
                        <input type="button" name="CmdLogon" value="Login" id="cmdLogin" 
                               onclick="javascript:funIsValid();" />
                        <img class="wspace" src="images/wspacer.jpg"  alt=" ">
                        <INPUT type="button" name="CmdReset" value="Reset" id="cmdReset"
                               onclick="javascript:funClearFields();" >
                    </td>
                </tr>
                <tr>
                    <td colspan="4" class="Error Center">
                        <%
                            Object obj = request.getAttribute("msg");
                            if (obj != null) {
                                out.print(obj.toString());
                            }
                            request.setAttribute("msg", null);
                            
                            //request.getSession().invalidate();
                        %>
                    </td>
                </tr>
                <tr><td class="bulletin_copyright Center" colspan="4" id="setBF">
                        Copyright © 2014, Emcredit, All Rights Reserved.
                    </td></tr>
            </table>
        </form>  
    </body>
</html>
