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
            <table style="width: 100%">
                <tr><td colspan="2">&nbsp;</td></tr>
                <tr><td colspan="2">&nbsp;</td></tr>
                <tr>
                   <td class="pgTitle center" colspan="2">
                        Logout from glSCan
                    </td>
                </tr>
                <tr><td colspan="2">&nbsp;</td></tr>
                <tr><td colspan="2">&nbsp;</td></tr>
                <tr>
                    <td class="lables center" colspan="2">
                        You are successfully logout from our glScan system.<br> 
                        Please click <a href="index.jsp" class="hand">here</a> to login again.
                    </td>
                </tr>
            </table>
        </div>
        <%@ include file="includes/allpage.inc" %>
        <div id="LastElement"></div>
    </body>
</html>
