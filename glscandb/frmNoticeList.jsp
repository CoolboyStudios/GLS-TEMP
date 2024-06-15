<%-- 
    Document   : home
    Created on : May 2, 2013, 8:19:34 PM
    Author     : ...
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.HashMap,java.util.ArrayList"%>
<%@page import="glscandb.AppUtils,glscandb.classes.UserCls,glscandb.classes.NoticeCls,glscandb.classes.MyPendCls"%>
<%@ include file="includes/SessionValid.inc" %>
<%
    String lType = (String)request.getSession().getAttribute("objType");
    if (lType==null) {
        request.setAttribute("msg", "There is a program error(MNU302).<br>Please convey to administator with this error code.");
        request.getRequestDispatcher("logon.jsp").forward(request, response);            
        return;
    }
    if (!lType.startsWith("mnu302")) {
        request.setAttribute("msg", "There is a program error(MNU302).<br>Please convey to administator with this error code.\n" + lType);
        request.getRequestDispatcher("logon.jsp").forward(request, response);            
        return;
    }
    
    String title = "";
    if (lType.startsWith("mnu302MP")) 
        title = "My pendings - المهام المتبقية";
    else
        title = "Notice Search - بحث";
%> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>glScanDB - Pending List</title>
        <link type="image/icon" href="images/sysicon.gif" rel="shortcut icon"/>
        <style type="text/css">
            @import "includes/apps.css";
            @import "scripts/TableFilter/ezEditTable/ezEditTable.css";
            @import "scripts/jquery/smoothness/jquery-ui.min.css";
            @import "scripts/jquery/zoomer/fancybox.css";
        </style>
        
        <script type="text/javascript" src="scripts/TableFilter/tablefilter_all_min.js"></script>
        <script type="text/javascript" src="scripts/TableFilter/ezEditTable/ezEditTable.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery-ui.min.js"></script>
        <script type="text/javascript" src="scripts/AppsUtil.js"></script>
        
        <script type="text/javascript" src="scripts/jquery/zoomer/axzoomer-min.js"></script>
        <script type="text/javascript" src="scripts/jquery/zoomer/fancybox-min.js"></script>
        <script type="text/javascript" src="scripts/jquery/zoomer/mousewheel-min.js"></script>        
        
        <script type="text/javascript">
            var wTimer;
            wTimer = self.setInterval(function () {fnCheckPageFullyLoaded('waitLayer', wTimer);}, 1000);
        </script>
    </head>
    <body>
        <table>
            <tr>
                <td>
                    <%@ include file="includes/pgtop.inc" %>
                </td>
            </tr>
            <tr>
                <td align="Center">
                    <table style="width:<%=((lType.startsWith("mnu302MP"))?"70%":"90%")%>">
                        <tr>
                            <td class="MainHeading" align="center"><%=title%></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        <tr <%if (lType.startsWith("mnu302M")) out.print("style='display:none'"); %>>
                            <td>
                                <form name="FrmNList" id="FrmNList" method="post">
                                    <table>
                                        <tr>
                                            <td class="Right">
                                                <select class="arabic" 
                                                    id="CboSTATUS" name="CboSTATUS">
                                                    <option value="0">جميع - All</option>
                                                    <option value="A">التحقق منها - Verified</option>
                                                    <option value="I">غير كامل - Incomplete</option>
                                                    <option value="E">غلطة - Data Error</option>
                                                </select>
                                            </td>
                                            <td class="Right">
                                                <input class="arabic" type="text"
                                                    id="TxtDTRELT" name="TxtDTRELT"
                                                    size="10">
                                                to
                                                <input class="arabic" type="text"
                                                    id="TxtDTRELF" name="TxtDTRELF"
                                                    size="10"> 
                                                from
                                            </td>
                                            <td class="Right arabic">التاريخ</td>
                                            <td class="Right">
                                                <select class="arabic" 
                                                    id="CboNPID" name="CboNPID"
                                                    style="width:90%">
                                                    <option></option>
                                                </select>
                                            </td>
                                            <td class="Right arabic">الجريدة</td>
                                        </tr>
                                        <tr>
                                            <td class="Right">
                                                Seq.No.<input class="" type="text"
                                                    id="TxtSEQNO" name="TxtSEQNO"
                                                    style="width:90px">
                                            </td>
                                            <td class="Right Top arabic">
                                                <input class="arabic" type="text"
                                                    id="TxtSEARCH" name="TxtSEARCH"
                                                    style="width:65%"> 
                                            </td>
                                            <td class="Right Top arabic">بحث فى المحتوى</td>
                                            <td class="Right">
                                                <select class="arabic" 
                                                    id="CboNTID" name="CboNTID"
                                                    style="width:90%">
                                                    <option></option>
                                                </select>
                                            </td>
                                            <td class="Right arabic">نوع الاعلان</td>
                                        </tr>
                                        <tr>
                                            <td class="Right">
                                                <input type="button" id="btnSearch" value="Search - بحث" 
                                                    onclick="javascript:funSearch();" 
                                                    title="Search Notice">
                                            </td>
                                            <td class="Right">
                                                <input class="arabic" type="text"
                                                    id="TxtDTUPDT" name="TxtDTUPDT"
                                                    size="10">
                                                to
                                                <input class="arabic" type="text"
                                                    id="TxtDTUPDF" name="TxtDTUPDF"
                                                    size="10"> 
                                                from
                                            </td>
                                            <td class="Right arabic">الإدخال</td>
                                            <td class="Right">
                                                <select class="arabic" 
                                                    id="CboUID" name="CboUID"
                                                    style="width:90%">
                                                    <option></option>
                                                </select>
                                            </td>
                                            <td class="Right">Entry User</td>
                                        </tr>
                                    </table>
                                </form>
                            </td>
                        </tr>
                        <tr>
                            <td>                                
                                <%if (lType.startsWith("mnu302MP")) { %>
                                    <%@ include file="includes/tblMyPend.inc" %>
                                <%} else {%>
                                    <%@ include file="includes/tblSearch.inc" %>
                                <%}%>
                            </td>
                        </tr>
                        <tr>
                            <td class="Right" style="color: blue">                                
                                <%if (lType.startsWith("mnu302MP")) { %>
                                Total Pending: <span class="BoldRight" id="lblNOPEND"></span>
                                <%}%>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
                            
        <!-- Print Param Array -->
        <% out.print(AppUtils.printParamArray(request)); %>
        
        <script type="text/javascript">
            function funSearch() {
                fnShowLayer("waitLayer");
                document.forms["FrmNList"].action = "Actions?req=mnu302SRC";
                document.forms["FrmNList"].submit();
                return;
            }
            
            function funUpdate(pnid, pupid, mod)  {
                fnShowLayer("waitLayer");
                //alert(pnid);
                if (pnid === 0) {
                    document.forms["FrmNList"].action = "Actions?req=mnu301F&id="+pupid;
                } else if (mod === "V") 
                {
                    document.forms["FrmNList"].action = "Actions?req=mnu301V&id="+pnid;
                } 
                else if (mod === "E") 
                {
                    document.forms["FrmNList"].action = "Actions?req=mnu301U&id="+pnid;
                }
                document.forms["FrmNList"].submit();
                return;
            }
            
            function funfillCbo(){
                fnFillCombo("CboNPID", params, "NP", "UAS");
                fnFillCombo("CboNTID", params, "NT", "UAS");
                fnFillCombo("CboUID", params, "UIDS", "A");
            }
            
            <%
        
                if (!lType.startsWith("mnu302MP")) {
                    out.print("funfillCbo();");
                } else {
                    int no = (Integer)request.getSession().getAttribute("objListIV");
                    out.print("$('#lblNOPEND').text("+no+");");
                }
            %>
        </script>
        
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
                $("a#single_image").fancybox({
                    onComplete:function()
                    {
                        $('#fancybox-img').axzoomer({
                            'width': '800',
                            'zoomIn': 'scripts/jquery/zoomer/zoom-in.png',
                            'zoomOut': 'scripts/jquery/zoomer/zoom-out.png'});
                    }
                });
                
                $.datepicker.setDefaults({
                        showOn: 'both', dateFormat: "dd-mm-yy", isRTL: true,
                        showButtonPanel: true, closeText: "Close",
                        numberOfMonths: 1, changeMonth: true,
                        constrainInput: true, buttonImageOnly: true,
                        maxDate:"-0d",
                        buttonImage: 'images/calendar.gif'});     
                $("#TxtDTRELF").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    numberOfMonths: 1,
                    onClose: function( selectedDate ) {
                        $( "#TxtDTRELT" ).datepicker( "option", "minDate", selectedDate );
                    }
                });
                $("#TxtDTRELT").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    numberOfMonths: 1,
                    onClose: function( selectedDate ) {
                        $( "#TxtDTRELF" ).datepicker( "option", "maxDate", selectedDate );
                    }
                });
                $("#TxtDTUPDF").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    numberOfMonths: 1,
                    onClose: function( selectedDate ) {
                        $( "#TxtDTUPDT" ).datepicker( "option", "minDate", selectedDate );
                    }
                });
                $("#TxtDTUPDT").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    numberOfMonths: 1,
                    onClose: function( selectedDate ) {
                        $( "#TxtDTUPDF" ).datepicker( "option", "maxDate", selectedDate );
                    }
                });
            });
        </script>
        <!-- Alert (message) -->
        <%out.print(AppUtils.printMessage(request));%>
    </body>
</html>
