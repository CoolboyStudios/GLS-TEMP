<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap,java.util.ArrayList"%>
<%@page import="glscandb.classes.UserCls,glscandb.classes.AllocPCls,glscandb.AppUtils"%>
<%@ include file="includes/SessionValid.inc" %>
<%
     String lType = (String)request.getSession().getAttribute("objType");
    if (lType==null) {
        request.setAttribute("msg", "There is a program error(MNU304).<br>Please convey to administator with this error code.");
        request.getRequestDispatcher("logon.jsp").forward(request, response);            
        return;
    }
    if (!lType.startsWith("mnu304")) {
        request.setAttribute("msg", "There is a program error(MNU304).<br>Please convey to administator with this error code.\n" + lType);
        request.getRequestDispatcher("logon.jsp").forward(request, response);            
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>glScanDB - Allocation</title>
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
                <td align="Center">
                    <table style="width:70%">
                        <tr>
                            <td class="MainHeading" align="center">Work Allocation - توزيع العمل</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td >
                                <table>
                                    <tr>
                                        <td class="Right" style="width:50%">
                                            <div id="tdNPID" style="display: none">
                                                <select class="arabic" style="width:60%"
                                                        id="CboNPID" name="CboNPID" 
                                                        onchange="javascript:funFetchNT();">
                                                    <option></option>
                                                </select> الجريدة</div>
                                        </td>
                                        <td  class="Right">
                                            <input class="arabic" type="text"
                                                id="TxtDTRELT" name="TxtDTRELT"
                                                size="10"> To 
                                            <input class="arabic" type="text"
                                                id="TxtDTRELF" name="TxtDTRELF"
                                                size="10"> 
                                            تاريخ من
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="Right">
                                            <div id="tdNTID" style="display: none">
                                                <select class="arabic" style="width:60%"
                                                    id="CboNTID" name="CboNTID"
                                                    onchange="javascript:funSetPendQ();">
                                                    <option></option>
                                                </select>
                                                نوع الاعلان</div>
                                        </td>
                                        <td class="Right">
                                            <input type="button" id="btnDTFetch" 
                                                   value="Fetch" 
                                                onclick="javascript:funFetchNP();" 
                                                title="Fetch News Page with pending counts">
                                            <img class="wspace" src="images/wspacer.jpg" alt=" ">
                                            <img class="wspace" src="images/wspacer.jpg" alt=" ">
                                            <select class="arabic" 
                                                    id="CboADNO" name="CboADNO">
                                                    <option value="ST">Single Line - Typing</option>
                                                    <option value="SS">Single Line - Splitting(OCR)</option>
                                                    <option value="MT">Multi-Line Typing</option>
                                                </select>إعلانات النوع
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                        </tr><tr>
                            <td class="BoldRight arabic">
                                بانتظار إلى تخصيص : <span id="lblNEEDALOC">0</span>
                            </td>
                        </tr>
                        <tr>
                            <td class="Center">
                                <%@ include file="includes/tblAllocP.inc" %>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <i><b>Note:</b>In queue allocation numbers are combined of Single and Group ads.</i>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <!-- Print Param Array -->
        <% out.print(AppUtils.printParamArray(request)); %>
        
        <script type="text/javascript">
            function funSetPendQ() {
                var npT;
                if ($("#CboNTID").val() === "0") {
                    var npT = $("#CboNPID option:selected").text(); 
                } else {
                    var npT = $("#CboNTID option:selected").text(); 
                }
                var l = npT.indexOf(")") - npT.indexOf("(") - 1;
                var na = npT.substr(npT.indexOf("(")+1, l);
                $('#lblNEEDALOC').text(na);
            }
            
            function funFetchNP() {
                $("#tdNPID").css("display", "block");
                $("#tdNTID").css("display", "block");
                var dt = $("#TxtDTRELF").val();
                var dtf = dt.substr(6,4) + dt.substr(3,2) + dt.substr(0,2);
                var dt = $("#TxtDTRELT").val();
                var dtt = dt.substr(6,4) + dt.substr(3,2) + dt.substr(0,2);
                var sm = $("#CboADNO").val();
                fnShowLayer("waitLayer");
                $.get("JAllocSCls?req=GPLISTDT&DTF="+dtf + "&DTT="+dtt + "&ADMULTI="+sm,
                    function(responseText) { 
                        fnHideLayer("waitLayer");
                        var obj = JSON.parse(responseText); 
                        var pps = new Array(); 
                        var i=0;
                        for(var x in obj){ 
                            pps[i++] = obj[x]; //alert(x + ':' + obj[x]) 
                        };
                        fnClearCbo("CboNTID");
                        fnClearCbo("CboNPID");
                        fnFillCombo("CboNPID", pps, "NP", "UAS");
                        fnFillCombo("CboNTID", pps, "NT", "UAS");
                        $('#lblNEEDALOC').text("0");
                    }
                ).error(function(xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    alert("Please inform to Administrator for this error (MNU304-GETLISTDT)\n" + err.Message);
                  });
            }
            
            function funFetchNT() {
                var np = $("#CboNPID").val();
                if (np === "0") {
                    funFetchNP();
                    return;
                }
                var dt = $("#TxtDTRELF").val();
                var dtf = dt.substr(6,4) + dt.substr(3,2) + dt.substr(0,2);
                var dt = $("#TxtDTRELT").val();
                var dtt = dt.substr(6,4) + dt.substr(3,2) + dt.substr(0,2);
                var npT = $("#CboNPID option:selected").text();
                var l = npT.indexOf(")") - npT.indexOf("(") - 1;
                var na = npT.substr(npT.indexOf("(")+1, l);
                $('#lblNEEDALOC').text(na);
                var sm = $("#CboADNO").val();
                
                fnShowLayer("waitLayer");
                $.get("JAllocSCls?req=GPLISTNP&DTF="+dtf + "&DTT="+dtt + "&ADMULTI="+sm+ "&NPID="+np,
                    function(responseText) { 
                        fnHideLayer("waitLayer");
                        var obj = JSON.parse(responseText); 
                        var ppts = new Array(); 
                        var i=0;
                        for(var x in obj){ 
                            ppts[i++] = obj[x]; //alert(x + ':' + obj[x]) 
                        };
                        fnClearCbo("CboNTID");
                        fnFillCombo("CboNTID", ppts, "NT", "UAS");
                    }
                ).error(function(xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    alert("Please inform to Administrator for this error (MNU304-GETLISTDT)\n" + err.Message);
                  });
            }
            
            function funAlloctUID(puid) {
                // check with the total pendings
                if (!fnValidate("TxtANO"+puid, "Allocation Quantity", 1)) return false;
                
                var naloc = parseInt( $('#lblNEEDALOC').text() );
                var auid = parseInt( $('#TxtANO'+puid).val() );
                if (auid==="NaN"){
                    alert("Please enter the valid allocation quantity.");
                    return false;
                }
                if (auid>naloc){
                    alert("Please enter the valid allocation quantity.\n It should not exceed the pending allocation.");
                    return false;
                }
                fnShowLayer("waitLayer");
                
                var npid = fnGetText("CboNPID");
                var ntid = fnGetText("CboNTID");
                var dtfr = fnGetText("TxtDTRELF");
                var dtf = dtfr.substr(6,4) + dtfr.substr(3,2) + dtfr.substr(0,2);
                var dttr = fnGetText("TxtDTRELT");
                var dtt = dttr.substr(6,4) + dttr.substr(3,2) + dttr.substr(0,2);
                var sm = $("#CboADNO").val();
                var pp = "&NPID=" + npid + "&NTID=" + ntid + "&DTF=" + dtf + "&DTT=" +dtt
                    + "&ADMULTI="+sm;
                //alert(pp);
                $.get("JAllocSCls?req=Save304A&UID="+puid + "&ANO="+auid + pp,
                    function(responseText) { 
                        fnHideLayer("waitLayer");
                        if ((responseText.toString()).startsWith("UIDQUEUE")) {
                            var lv = responseText;//.split(",");
                            //$('#lblNEEDALOC').text( lv[0].replace("NEEDALOC:", "") );
                            $('#lblINQUEUE'+puid).text( lv.replace("UIDQUEUE:", "") );
                            $('#TxtANO'+puid).val("");
                            alert("Allocated Successfully.");
                            funFetchNP();
                        }
                }).error(function(xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    alert("Please inform to Administrator for this error (MNU304-ALLOCTUID)\n" + err.Message);
                  });
            }
            
            function funDeAlloctUID(puid) {
                var auid = parseInt( $('#lblINQUEUE'+puid).val() );
                if (auid === "NaN"){
                    alert("There is no pending item for this user.");
                    return false;
                }
                var cn = confirm("Please ensure that this user is logout from system and not working with any new entry.\nDo you still want to continue to deallocate pending item from this user? (press OK)", "Ok", "Cancel");
                if (!cn) {
                    return false;
                }
                
                fnShowLayer("waitLayer");
                $.get("JAllocSCls?req=Save304D&UID="+puid ,
                    function(responseText) { 
                         fnHideLayer("waitLayer");
                         if ((responseText.toString()).startsWith("UIDQUEUE")) {
                            var lv = responseText; //.split(",");
                            //$('#lblNEEDALOC').text( lv[0].replace("NEEDALOC:", "") );
                            $('#lblINQUEUE'+puid).text( lv.replace("UIDQUEUE:", "") );
                            alert("Deallocated Successfully.");
                        } else {
                            alert(responseText);
                        }
                }).error(function(xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    alert("Please inform to Administrator for this error (MNU304-DEALLOCTUID)\n" + err.Message);
                  });
            }
            
        </script>
        
        <!-- Page Ready events -->
        <div id="LastElement"></div>
        
        <script type="text/javascript">
            $(document).ready(function() {
                // for GUI jquery button assingment
                /*$(function() {
                    
                        .click(function( event ) {
                            event.preventDefault();
                        });
                });*/
                $( "input[type=button], button" ).button();
                // for Date Picket 
                $.datepicker.setDefaults({
                        showOn: 'both', dateFormat: "dd-mm-yy", isRTL: true,
                        showButtonPanel: true, closeText: "Close",
                        numberOfMonths: 1, changeMonth: true,
                        constrainInput: true, buttonImageOnly: true,
                        buttonImage: 'images/calendar.gif'});     
                $("#TxtDTRELF").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    numberOfMonths: 1,
                    maxDate:"-0d",
                    onClose: function( selectedDate ) {
                        $( "#TxtDTRELT" ).datepicker( "option", "minDate", selectedDate );
                    }
                });
                $("#TxtDTRELT").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    numberOfMonths: 1, maxDate:"-0d",
                    onClose: function( selectedDate ) {
                        $( "#TxtDTRELF" ).datepicker( "option", "maxDate", selectedDate );
                    }
                });
                $('#TxtDTRELF').change(function() { 
                    $('#lblNEEDALOC').text(0);
                    fnClearCbo("CboNTID");
                    fnClearCbo("CboNPID");
                });
                $('#TxtDTRELT').change(function() { 
                    $('#lblNEEDALOC').text(0);
                    fnClearCbo("CboNTID");
                    fnClearCbo("CboNPID");                    
                });
                $('#CboADNO').change(function() { 
                    $('#lblNEEDALOC').text(0);
                    fnClearCbo("CboNTID");
                    fnClearCbo("CboNPID");
                });
            });
        </script>
        <!-- Alert (message) -->
        <%out.print(AppUtils.printMessage(request));%>
    </body>
</html>
