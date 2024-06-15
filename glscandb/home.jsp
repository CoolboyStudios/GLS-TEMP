<%-- 
    Document   : home
    Created on : Oct 26, 2012, 5:19:34 AM
    Author     : ...
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap,java.util.ArrayList"%>
<%@page import="glscandb.classes.UserCls,glscandb.AppUtils"%>
<%@ include file="includes/SessionValid.inc" %>
<%
    String lType = (String)request.getSession().getAttribute("objType");
    if (lType==null) {
        request.setAttribute("msg", "There is a program error(MNU100).<br>Please convey to administator with this error code.");
        request.getRequestDispatcher("logon.jsp").forward(request, response);            
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>glScanDB Home</title>
        <link type="image/icon" href="images/sysicon.gif" rel="shortcut icon"/>
        <style type="text/css">
            @import "includes/apps.css";
            @import "scripts/jquery/smoothness/jquery-ui.min.css";
            #accordion-resizer {
		padding: 10px;
		width: 350px;
		height: 220px;
	}
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
                <td class="Center">
                    
                </td>
            </tr>
        </table>
                
        
        <div id="mpActionLayer" title="Alert">
            <span class="Error" style="font-size: 16px">
                glScanDB System maintenance and improvements activity completed successfully.
                <br></br>
                Thanks for your support.
            </span>
            <p>&nbsp;</p>
            <span class="Error" style="font-size: 16px">
            أكملت صيانة نظام نشرة والتحسينات النشاط بنجاح. 
            <br><br>
                 شكرا لدعمكم.</span>
            <span class="Error" style="font-size: 16px">
                glScanDB System will not available from 4.00am to 9.00am (GMT) on 22-March-2014 due to maintenance and improvements activity.
                <br>
                Sorry for the inconvenience.
            </span>
            <p>&nbsp;</p>
            <span class="Error" style="font-size: 16px">
                لا سوف تتوفر 4:00 حتي 09:00 (بتوقيت جرينتش) يوم 22 مارس عام 2014 بسبب الصيانة والنشاط تحسينات نظام النشرة.
            <br>
            آسف للإزعاج.
            </span>
        </div>
        <!-- Page Ready events -->
        <div id="LastElement"></div>
        
        <script type="text/javascript">
            $(document).ready(function() {
                // for GUI jquery button assingment
                $(function() {
                    $( "input[type=button], button" )
                        .button()
                        .click(function( event ) {
                            event.preventDefault();
                        });
                });
                
                var expireDate = new Date(2014, 07, 05, 23, 59, 00);
                var todayDate = new Date();
                //alert(expireDate);
                $("#mpActionLayer" ).dialog({
                    modal: false, autoOpen: (todayDate < expireDate), resizable: false,
                    height:'auto', width:'400'
                });
                
            });
        </script>
        <!-- Alert (message) -->
        <%out.print(AppUtils.printMessage(request));%>
    </body>
</html>
