<%-- 
    Document   : home
    Created on : Oct 26, 2012, 5:19:34 AM
    Author     : ...
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.HashMap,java.util.ArrayList"%>
<%@page import="glscandb.AppUtils" %>
<%@page import="glscandb.classes.UserCls"%>
<%@ include file="includes/SessionValid.inc" %>
<%
    String lType = (String)request.getSession().getAttribute("objType");
    if (lType==null) {
        request.setAttribute("msg", "There is a program error(RPT400).<br>Please convey to administator with this error code.");
        request.getRequestDispatcher("logon.jsp").forward(request, response);            
        return;
    }
    if (!lType.startsWith("rpt4")) {
        request.setAttribute("msg", "There is a program error(RPT400).<br>Please convey to administator with this error code.\n" + lType);
        request.getRequestDispatcher("logon.jsp").forward(request, response);            
        return;
    }
    boolean rptFilter = false;
    String rptHeader="";
    if (lType.equals("rpt401")) {
        rptHeader="Upload Details";
    } else if (lType.equals("rpt402")) {
        rptHeader="Pending Allocation Details";
    } else if (lType.equals("rpt403")) {
        rptHeader="Allocation Details";
    } else if (lType.equals("rpt4041")) {
        rptHeader="Pending Job (New) - User wise";
    } else if (lType.equals("rpt4042")) {
        rptHeader="Pending Notice for Verification";
    } else if (lType.equals("rpt4043")) {
        rptHeader="Pending Notice to fix Data Error";
    } else if (lType.startsWith("rpt405")) {
        if (lType.endsWith("BR")) rptHeader = "Params - Branches";
        else if (lType.endsWith("NP")) rptHeader ="Params - Newspapers";
        else if (lType.endsWith("NT")) rptHeader ="Params - Notice Types";
    } else if (lType.equals("rpt406")) {
        rptHeader="Bulletin Summary";
    } else if (lType.equals("rpt4071")) {
        rptHeader="Productivity - Detail Userwise";
    } else if (lType.equals("rpt4072")) {
        rptHeader="Productivity - Summary Userwise";
    } else if (lType.equals("rpt4073")) {
        rptHeader="Productivity - News Paperwise";
    } else if (lType.equals("rpt4081")) {
        rptHeader="Subscription register";
    } else if (lType.equals("rpt4082")) {
        rptHeader="Subscribers - User Register";
    } else if (lType.equals("rpt4083")) {
        rptHeader="Subscribers - User access log";
    } else if (lType.equals("rpt4084")) {
        rptHeader="Subscribers - Watch list summary user wise";
    } else if (lType.equals("rpt40851")) {
        rptHeader="Report Generation - Subscriber Month wise'";
    } else if (lType.equals("rpt40852")) {
        rptHeader="Report Generation - User Date wise";
    } else if (lType.equals("rpt40853")) {
        rptHeader="Report Generation Details";
    } else if (lType.equals("rpt411")) {
        rptHeader="Combined Notice Report - Requst List";
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>glScanDB - Report Viewer</title>
        <link type="image/icon" href="images/sysicon.gif" rel="shortcut icon"/>
        <style type="text/css">
            @import "includes/apps.css";
            @import "scripts/jquery/smoothness/jquery-ui.min.css";
        </style>
        
        <script type="text/javascript" src="scripts/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery-ui.min.js"></script>
        <script type="text/javascript" src="scripts/AppsUtil.js"></script>
        <script type="text/javascript">
            var wTimer;
            wTimer = self.setInterval(function () {fnCheckPageFullyLoaded('waitLayer', wTimer);}, 1000);
        </script>
        <script type="text/javascript">
            $(document).ready(function() {
                // date picker                
                $.datepicker.setDefaults({
                        showOn: 'both', 
                        showButtonPanel: true,
                        closeText: "Close",
                        numberOfMonths: 1,
                        changeMonth: true,
                        dateFormat: "dd-mm-yy",                         
                        constrainInput: true,
                        buttonImageOnly: true,
                        buttonImage: 'images/calendar.gif'}
                );
                $( "#TxtDTF" ).datepicker({
                    minDate:"-2y",
                    maxDate:"-0d",
                    changeMonth: true, changeYear: true,
                    numberOfMonths: 1,
                    onClose: function( selectedDate ) {
                        $( "#TxtDTT" ).datepicker( "option", "minDate", selectedDate );
                    }
                });
                $( "#TxtDTT" ).datepicker({
                    maxDate:"+0d",
                    changeMonth: true, changeYear: true, 
                    numberOfMonths: 1,
                    onClose: function( selectedDate ) {
                        $( "#TxtDTF" ).datepicker( "option", "maxDate", selectedDate );
                    }
                });
            });
            </script>
        <!-- Print Param Array -->
        <% out.print(AppUtils.printParamArray(request)); %>
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
                    <table style="width:75%">
                        <tr>
                            <td class="MainHeading" colspan="3">
                                <%=rptHeader%></td>                            
                        </tr>
                        <tr><td colspan="3">&nbsp;</td></tr>
                        <tr>
                            <td style="width:24%;vertical-align:top">
                                <table>
                                    <tr>
                                        <td class="SubHeading">
                                            Filter
                                        </td>
                                    </tr>
                                    <tr><td>&nbsp;</td></tr>
                                    <tr>
                                        <td>
                                            <% if ( lType.equals("rpt400") ) { rptFilter = true; %> <!--  add 18-05-2015 -->
                                                <table>
                                                    <tr>
                                                        <td>For the Date</td>
                                                        <td>
                                                            <input type="text" id="TxtDTF" name="TxtDTF"
                                                                   value="<%out.print(AppUtils.formatDate(AppUtils.getDate(-30), AppUtils.FormatDate.ddMMyyyy));%>"
                                                                   size="10">
                                                        </td>
                                                    </tr>
                                                </table>
                                            <%}%>
                                            <% if ( lType.equals("rpt401") || lType.equals("rpt403")
                                                    || lType.startsWith("rpt4085") 
                                                    || lType.equals("rpt4083")
                                                    || lType.startsWith("rpt407")
                                                    || lType.startsWith("rpt411") ) { 
                                                rptFilter = true; 
                                            %>
                                                <table>
                                                    <tr>
                                                        <td>From</td>
                                                        <td>
                                                            <input type="text" id="TxtDTF" name="TxtDTF"
                                                                   value="<%out.print(AppUtils.formatDate(AppUtils.getDate(-30), AppUtils.FormatDate.ddMMyyyy));%>"
                                                                   size="10">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>To</td>
                                                        <td>
                                                            <input type="text" id="TxtDTT" name="TxtDTT"
                                                                   value="<%out.print(AppUtils.formatDate(AppUtils.getDate(0), AppUtils.FormatDate.ddMMyyyy));%>"
                                                                   size="10">
                                                        </td>
                                                    </tr>
                                                </table>
                                            <%} %>
                                            <% if ( lType.equals("rpt403") || lType.equals("rpt4041")
                                                    || lType.equals("rpt4043") 
                                                    || lType.equals("rpt4071")
                                                    || lType.equals("rpt4072") ) { rptFilter = true; %>
                                                <table>
                                                    <tr>
                                                        <td>User</td>
                                                        <td>
                                                            <SELECT name="CborptUIDS" id="CborptUIDS">
                                                                <option value="0">Select</option>
                                                            </SELECT>
                                                            <script type="text/javascript">
                                                                fnFillCombo("CborptUIDS", params, "UIDS", "A");
                                                            </script>
                                                        </td>
                                                    </tr>
                                                </table>
                                            <%}%>
                                            <% if ( lType.startsWith("rpt4073") ) { rptFilter = true; %>
                                                <table>
                                                    <tr>
                                                        <td>News paper</td>
                                                        <td>
                                                            <SELECT name="CborptNPIDS" id="CborptNPIDS">
                                                                <option value="0">Select</option>
                                                            </SELECT>
                                                            <script type="text/javascript">
                                                                fnFillCombo("CborptNPIDS", params, "NP", "A");
                                                            </script>
                                                        </td>
                                                    </tr>
                                                </table>
                                            <%}%>
                                            <% if (!rptFilter) {%>
                                                No Filter Option.
                                            <%}%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input type="button" value="Download in xls"
                                                    onclick="javascript:funRefresh('<%=lType%>', 'xls');" 
                                                    title="Refresh and download the report in Excel">
                                            <% if (rptFilter) {%>
                                                <input type="button" value="Flter & Refresh"
                                                        onclick="javascript:funRefresh('<%=lType%>', 'pdf');" 
                                                        title="Refresh report based on the Paramerters">
                                            <%} %>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>&nbsp;</td>
                            <td style="width:75%;">
                                <div id="JasperDIV" style="width:100%;">
                                    <iframe name="jasper" id="jasper" src="" 
                                            style="width: 100%;height: 100%;background-color: #ffffff;"></iframe>
                                    <iframe name="jasper" id="jasperDN" src="" 
                                            style="width: 0%;height:0px;background-color: #ffffff;"></iframe>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <script type="text/javascript">
            $(document).ready(function() {
                $(function() {
                    $( "input[type=button], button" )
                        .button()
                        .click(function( event ) {
                            event.preventDefault();
                        });
                });
                
                document.getElementById("JasperDIV").style.height = (fnGetHeight()*0.65) + 'px';
                 //$("#JasperDIV").style.height = (fnGetHeight()*0.65) + 'px';
                document.getElementById("jasper").src= "RptActions?t=pdf";
            });
            
            function funRefresh(param, type) {
                var src = "RptActions?t=pdf";
                // add 18-05-2015
                if ( (param==="rpt400")) {
                    src += "&DTF=" + $("#TxtDTF").val();
                }
                ///////////////////////
                if ( (param==="rpt401") || (param==="rpt403") 
                        || (param==="rpt4071") || (param==="rpt4072")
                        || (param==="rpt40851") || (param==="rpt40852") || (param==="rpt40853")
                        || (param==="rpt4083")
                        || (param==="rpt4073")
                        || (param==="rpt411") ) {
                    src += "&DTF=" + $("#TxtDTF").val();
                    src += "&DTT=" + $("#TxtDTT").val();
                }
                if ((param==="rpt403") || (param==="rpt4041")
                    || (param==="rpt4043") || (param==="rpt4071") || (param==="rpt4072") ){
                    src += "&UID=" + $("#CborptUIDS").val();
                }
                if ((param==="rpt4073")){
                     src += "&NPID=" + $("#CborptNPIDS").val();
                }
                 //alert(src);
                var f = document.getElementById('jasper');
                f.src = src;
                if (type==="xls") {
                    src = src.replace("pdf", "xls");
                    document.getElementById('jasperDN').src = src;
                }
            }
        </script>
        <!-- Alert (message) -->
        <div id="LastElement"></div>
    </body>
</html>
