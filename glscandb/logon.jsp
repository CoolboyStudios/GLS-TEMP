<%-- 
    Document   : logon
    Created on : Oct 25, 2012, 7:38:02 AM
    Author     : Harshtih
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>glScanDB Login...</title>
        <link type="image/icon" href="images/sysicon.png" rel="shortcut icon"/>
        <link type="text/css" href="includes/apps.css" rel="stylesheet">
        <style>
            div.background
            {
                width:500px;
                height:250px;
                background:url(../images/logo.jpg) center;
                border:1px solid black;
            }
            div.transbox
            {
                width:400px;
                height:180px;
                margin:30px 50px;
                background-color:#ffffff;
                border:1px solid black;
                opacity:0.6;
                filter:alpha(opacity=60); /* For IE8 and earlier */
            }
            div.transbox p
            {
                margin:30px 40px;
                font-weight:bold;
                color:#000000;
            }
            
            #divContainer {
                width:100%; position: relative; 
                text-align:center; top: 15px;
            }
            
            #divLogin {
                width: 55%; margin: 0 auto; height: 180px;
                box-shadow:1px 2px 12px gray;background: #FBFBFB;    border-radius: 5px;
            }
        </style>

        <script type="text/javascript" src="scripts/AppsUtil.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery.min.js"></script>
        <script type="text/javascript">
            function funOnLoad() {
                
                document.getElementById('setTH').style.height  = fnGetHeight() *.30 + "px";
                document.getElementById('setBF').style.height  = fnGetHeight() *.10 + "px";
                document.forms["FrmLogon"].elements["TxtUserName"].focus();
                
                /*document.FrmLogon.TxtUserName.value = "bsk";
                document.FrmLogon.TxtPassword.value = "12345";
                funIsValid();*/
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
                if(user==="")
                {
                    alert("User Id cannot be blank");
                    document.FrmLogon.TxtUserName.focus();
                }
                else if(pwd==="")
                {
                    alert("Password cannot be blank");
                    document.FrmLogon.TxtPassword.focus();
                }

                else{
                    //fnShowLayer("waitLayer");
                    var epwd = encodeURIComponent(pwd);
                    $.get("AjaxActions?req=pwdEncrpt&pwd="+ epwd,
                    function(responseText) { 
                        //fnHideLayer("waitLayer");
                        if (responseText.toString()) {
                            document.FrmLogon.TxtPassword.maxlength = 26;
                            document.FrmLogon.TxtPassword.value = responseText; 
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
        </script>
    </head>
    <body onKeyDown="javascript:fnMicrosoftKeyDown();" onLoad="javascript:funOnLoad();">
        <form name="FrmLogon" action="Actions?req=login" method="post" onsubmit="return funIsValid();">
            <div id="divContainer">
                    <table align="center" style="width:60%">
                        <tr>
                            <td colspan="4" id="setTH" class="Center">
                                <table style="width:40%" align="Center">
                                    <tr>
                                        <td class="Center">
                                            <img src="images/clientlogo.png">
                                        </td>
                                    </tr>
                                    <tr><td>&nbsp;</td></tr>
                                    <tr>
                                        <td class="apps_login Center">glScanDB</td>
                                    </tr>
                                    <tr>
                                        <td class="apps_caps Center">Public Notice Archiving v8.1</td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <div id="divLogin">
                                    <table>
                                        <tr><td colspan="4">&nbsp;</td></tr>
                                        <tr>
                                            <td colspan="3" class="MainHeading">
                                                <!--span style="color:red">UAT</span--> Login...
                                            </td>
                                            <td style="width:35%"
                                        </tr>
                                        <tr><td colspan="4">&nbsp;</td></tr>
                                        <tr>
                                            <td style="width:35%" rowspan="2">&nbsp;</td>
                                            <td style="width:15%" class="BoldCenter">Login ID</td>
                                            <td style="width:15%">
                                                <input id="TxtUserName" name="TxtUserName" type="text" maxlength="8"
                                                       onkeydown="fnKeydownfn(event, 'funIsValid()', 'FrmLogon')" 
                                                       style="background-color:White;border-color:Black;border-width:1px;border-style:Solid;width:120px;" />   
                                            </td>
                                            <td style="width:35%" rowspan="2">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="BoldCenter">Password</td>
                                            <td>
                                                <input id="TxtPassword" name="TxtPassword" type="password" maxlength="8"
                                                       onkeydown="fnKeydownfn(event, 'funIsValid()', 'FrmLogon')" 
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
                                            <td colspan="4" class="Error BoldCenter">
                                                <%
                                                    Object obj = request.getAttribute("msg");
                                                    if (obj != null) {
                                                        out.print(obj.toString());
                                                    }
                                                %>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>

                        <tr><td class="apps_copyright" colspan="4" id="setBF" align="center">
                                Copyright ©2012-2024 Green Lines Company, U.A.E. All Rights Reserved.
                            </td></tr>
                    </table>
                <!--/div>
            </div-->
        </form>  
    </body>
</html>
