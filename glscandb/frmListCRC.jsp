                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   <%-- 
    Document   : frmListCRM
    Created on : Sep 15, 2017, 10:29:19 AM
    Author     : Harshith
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap,java.util.ArrayList"%>
<%@page import="glscandb.classes.UserCls,glscandb.AppUtils"%>
<%@ include file="includes/SessionValid.inc" %>
<%
    String lType = (String)request.getSession().getAttribute("objType");
    if (lType==null) {
        request.setAttribute("msg", "There is a program error(MNU311C).<br>Please convey to administator with this error code.");
        request.getRequestDispatcher("logon.jsp").forward(request, response);            
        return;
    }
    if (!lType.startsWith("mnu311C")) {
        request.setAttribute("msg", "There is a program error(MNU311C).<br>Please convey to administator with this error code.\n");
        request.getRequestDispatcher("logon.jsp").forward(request, response);            
        return;
    }    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>glScanDB - Combined Report List</title>
        <link type="image/icon" href="images/sysicon.gif" rel="shortcut icon"/>
        <style type="text/css">
            @import "includes/apps.css";
            @import "scripts/TableFilter/ezEditTable/ezEditTable.css";
            @import "scripts/jquery/smoothness/jquery-ui.min.css";
        </style>
        
        <script type="text/javascript" src="scripts/TableFilter/tablefilter_all_min.js"></script>
        <script type="text/javascript" src="scripts/TableFilter/ezEditTable/ezEditTable.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery-ui.min.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery.autosize-min.js"></script>
        <script type="text/javascript" src="scripts/AppsUtil.js"></script>
        
        <script type="text/javascript">
            var wTimer, tfCRR, tfCRCST;
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
                    <table style="width:70%">
                        <tr>
                            <td class="MainHeading" align="center">Combined Report - Generation</td>
                        </tr>
                        <tr><td>&nbsp;</td></tr>
                        <tr>
                            <td class="Center">
                                <form name="FrmSEARCH" id="FrmSEARCH" method="post">
                                    <table>
                                        <tr>
                                            <td>Client</td>
                                            <td>
                                                <select id="CboCSIDmp" name="CboCSIDmp" onchange="funCboCSIDmp_Change();">
                                                    <option value="0">All</option>
                                                </select></td>
                                            <td>Unit</td>
                                            <td>
                                                <select id="CboCSUIDmp" name="CboCSUIDmp">
                                                    <option value="0">All</option>
                                                </select></td>
                                            <td>Requestor</td>
                                            <td><input type="text" id="TxtREQTORmp" name="TxtREQTORmp"
                                                        maxlength="50" size="20"></td>                                           
                                        </tr>
                                        <tr>
                                            <td>Customer Name</td>
                                            <td><input type="text" id="TxtCNAMEmp" name="TxtCNAMEmp"
                                                        maxlength="50" size="20"></td>
                                            <td>Client Ref.</td>
                                            <td><input type="text" id="TxtCREFmp" name="TxtCREFmp"
                                                        maxlength="20" size="20"></td>
                                            <td>Status</td>
                                            <td>
                                                <select id="CboSTATUSmp" name="CboSTATUSmp">
                                                    <option value="0">All</option>
                                                    <option value="R">Requested</option>
                                                    <option value="P">In-progress</option>
                                                    <option value="C">Completed</option>
                                                </select></td>
                                        </tr>
                                        <tr>
                                            <td colspan="4"></td>
                                            <td colspan="2">
                                                <input type="button" id="btnSearch" name="btnSearch" value="Search" onclick="funOnLoad_FillList();">
                                                <img src="images/wspacer.jpg" hspace="4" alt=' '>
                                                <input type="button" id="btnReset" name="btnReset" value="Clear" onclick="funFrmReset('FrmSEARCH');">
                                            </td>
                                        </tr>
                                    </table>
                                </form>
                            </td>
                        </tr>
                        <tr><td>&nbsp;</td></tr>
                        <tr>
                            <td>
                                <div id="ListDIV" style="width:100%;">
                                    <%@ include file="includes/tblCRReqR.inc" %>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <!-- Print Param Array -->
        <% out.print(AppUtils.printParamArray(request)); %>
        
        <!-- Data Layer for Request  -->
        <div id="dataLayer" title="Combined Report Request Details">
            <form name="FrmCRReq" id="FrmCRReq" method="post">
                <input type="hidden" name="CRRLSTLOAD" id="CRRLSTLOAD" value="NO">
                <input type="hidden" name="TxtCRRID" id="TxtCRRID" value="0">
                <input type="hidden" name="TxtCSID" id="TxtCSID" value="0">
                <input type="hidden" name="TxtSTATUS" id="TxtSTATUS" value="0">
                <input type="hidden" name="TxtSAVEOPT" id="TxtSAVEOPT" value="0">
                <table style="width:700px">
                    <tr>
                        <td style="width:20%">Client</td>
                        <td style="width:30%">
                            <select id="CboCSID" name="CboCSID" onchange="funCboCSID_Change();" class="required">
                                <option value="0">Please Select</option>
                            </select></td>
                        <td style="width:20%">Req. No./Status</td>
                        <td style="width:30%"><span id="lblCRRID_ST" name="lblCRRID_ST" ></span></td>
                    </tr>
                    <tr>
                        <td>Unit</td>
                        <td>
                            <select id="CboCSUID" name="CboCSUID" class="required">
                                <option value="0">Please Select</option>
                            </select></td>
                        <td>Req. Date</td>
                        <td><input type="text" id="TxtDTREQ" name="TxtDTREQ" class="required"
                                    maxlength="10" size="10"></td>                                          
                    </tr>
                    <tr>
                        <td>Customer Name</td>
                        <td><input type="text" id="TxtCNAME" name="TxtCNAME" class="required"
                                    maxlength="50" size="20"></td>
                        <td>Client Ref.</td>
                        <td><input type="text" id="TxtCREF" name="TxtCREF"
                                    maxlength="20" size="20"></td>
                    </tr>
                    <tr>
                        <td>Requestor</td>
                        <td><input type="text" id="TxtREQTOR" name="TxtREQTOR" 
                                    maxlength="50" size="20"></td>
                        <td>Remarks</td>
                        <td><input type="text" id="TxtREMARKS" name="TxtREMARKS"
                                    maxlength="250" size="25"></td>
                    <tr>
                        <td>eMail To</td>
                        <td><input type="text" id="TxtRPTTO" name="TxtRPTTO"
                                    maxlength="250" size="25"></td>
                        <td>eMail CC</td>
                        <td><input type="text" id="TxtRPTCC" name="TxtRPTCC"
                                    maxlength="250" size="25"></td>
                    </tr>
                    
                    <tr>
                        <td>Observation/Remarks</td>
                        <td colspan="3">
                            <textarea class="animatedTA" cols="85"
                                    id="TxtRPTREM" name="TxtRPTREM"></textarea>
                        </td>
                    </tr>
                    <tr><td colspan="4">&nbsp;</td></tr>
                    <tr>
                        <td colspan="4" class="Center">
                            <input type="button" id="btnPVIEW" name="btnPVIEW" value="Preview" onclick="funCRReqPreVSAVE();">
                            <img src="images/wspacer.jpg" hspace="4" alt=' '>
                            <input type="button" id="btnGEN" name="btnGEN" value="Generate" onclick="funCRReqGen();">
                            <img src="images/wspacer.jpg" hspace="4" alt=' '>
                            <input type="button" id="btnEMAIL" name="btnEMAIL" value="Send eMail" onclick="funCRReqEmail();">
                            <img src="images/wspacer.jpg" hspace="4" alt=' '>
                            <input type="button" id="btnBKSRC" name="btnBKSRC" value="Back to Search" onclick="funCRReqBKSRC();">
                            <img src="images/wspacer.jpg" hspace="4" alt=' '>
                            <img class="lnkicon16" src="images/pdf_file_icon.png" alt='download report' 
                                 id="imgPDF" onclick="funShowRpt();">
                        </td>
                    </tr>
                    <tr><td colspan="4">&nbsp;</td></tr>
                    </table>
            </form>
            <form name="FrmCRReqST" id="FrmCRReqST" method="post">
                <input type="hidden" name="TxtSTCRRID" id="TxtSTCRRID" value="0">
                <input type="hidden" name="TxtSTSNO" id="TxtSTSNO" value="0">
                <input type="hidden" name="TxtSTSAVEOPT" id="TxtSTSAVEOPT" value="0">
                <table style="width:700px">       
                    <tr>
                        <td style="width:20%">Search Value in ARB</td>
                        <td style="width:30%"><input type="text" id="TxtASVAL" name="TxtASVAL"
                                    maxlength="100" size="25"></td>
                        <td style="width:20%">Search Type</td>
                        <td style="width:30%">
                            <select id="CboSTYPE" name="CboSTYPE">
                                <option value="0">Please Select</option>
                            </select></td>
                    </tr>
                    <tr>
                        <td>Observation/Remarks</td>
                        <td><input type="text" id="TxtSTREMARKS" name="TxtSTREMARKS"
                                    maxlength="100" size="25"></td>
                        <td colspan="2" class="Center">
                            <input type="button" id="btnSTSave" name="btnSTSave" value="Update" onclick="funCRReqSTSAVE();">
                        </td>
                    </tr>
                    <tr><td colspan="4">&nbsp;</td></tr>
                    <tr>
                        <td colspan="4">
                            <div style="width:100%;">
                                <%@ include file="includes/tblCRReqCST.inc" %>
                            </div>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <!-- Report dialogs -->
        <div id="dialogRptPage" title="Combined Notice Report" style="display:none">
            <iframe id="spIframe" name="spIframe" src="" style="width: 700px;height: 500px;border:0;" scrolling="auto"></iframe>
        </div>
        <!-- confirmation dialogs -->
        <div id="dgGenConfirm" title="Generate Report?">
             <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
                Please note you can't change any details after the final report generated.
                <BR>Do you still want to continue?</p>
        </div>
        
        <!-- confirmation dialogs -->
        <div id="dgDelSTConfirm" title="Delete this Search Item?">
             <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
                Do you want to update/delete the unit for the selected row item?</p>
        </div>
        
        <!-- confirmation dialogs -->
        <div id="dgBKSRCConfirm" title="Back to Search?">
             <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
                Do you still want to send back to search stage this request?</p>
        </div>
        
        <script type="text/javascript">
            // data layer
            function funSetJSONValCRR(jsonText) {
                var csuid;
                $.each(jsonText, function() 
                {
                    $.each(this, function(k , v) 
                    {
                        if ($("#"+k).length !== 0) 
                        {
                            if (k.substr(0,3) === "lbl") 
                            {
                                $("#"+k).html(v); 
                            }
                            else
                            {
                                $("#"+k).val(v); 
                            }
                        } 
                        if (k === "CboCSUID") 
                        {
                            csuid = v;
                        }
                    });
                });
                fnHideLayer("waitLayer");
                
                funCboCSID_Change();
                $("#CboCSUID").val(csuid);
                
                fnSetText("TxtSAVEOPT", "UPD");
                $("#TxtSTSAVEOPT").val("NEW");
                $("#TxtSTCRRID").val($("#TxtCRRID").val());
                $("#CRRLSTLOAD").val("NO");
                $( "#dataLayer" ).dialog( "open" );
                $("#TxtRPTREM").autosize({append: "\n"});
                $("#FrmCRReqST").show();
                
                var btnCmp = ($("#TxtSTATUS").val() === "C");
                $("#imgPDF").hide();
                $("#btnSTSave").hide();               
                $("#btnPVIEW").button( "option", "disabled", btnCmp );
                $("#btnGEN").button( "option", "disabled", btnCmp );
                $("#btnBKSRC").button( "option", "disabled", btnCmp );
                $("#btnEMAIL").button( "option", "disabled", !btnCmp );
                if (btnCmp) {
                    $("#imgPDF").show();
                }
                funOnLoad_STFillList();
            }
            
            function funCRReqGet(pid) {
                fnShowLayer("waitLayer");
                $.get({
                    //type: 'GET',
                    url: "ajxCRReqSCls?req=mnu311CGET&id="+pid,
                    dataType: 'json',
                    async: true,
                    success: function(data, textStatus, jqXHR) 
                    {
                        //alert(data + "-:-" + textStatus);
                        funSetJSONValCRR(data);
                    },
                    error: function(jqXHR, textStatus, errorThrown) 
                    {
                        alert(textStatus + "-" + errorThrown);
                        //window.location="logon.jsp";
                        fnHideLayer("waitLayer");
                    }
                });
            }
            
            function funIsValidInput() {
                if (!fnValidate("CboCSID", "Client", 0)) return false;
                if (!fnValidate("CboCSUID", "Unit", 0)) return false;
                if (!fnValidate("TxtCNAME", "Customer Name", 5)) return false;
                if (!fnValidate("TxtDTREQ", "Data of Request", 10)) return false;
                if($("#TxtREQTOR").val() !== "") {
                    if (!fnValidate("TxtREQTOR", "Requestor Name", 3)) return false;
                }
                if($("#TxtRPTTO").val() !== "") {
                    if (!fnValidateEmail("TxtRPTTO", "To Email ID", 8)) return false;
                }
                if($("#TxtRPTCC").val() !== "") {
                    if (!fnValidateEmail("TxtRPTCC", "CC Email ID", 5)) return false;
                }
                return true;
            }
            
            function funCRReqSAVE() {
                if (!funIsValidInput()) return false;
                console.log("test");
                $("#CRRLSTLOAD").val("YES");
                fnShowLayer("waitLayer");
                //alert($("#TxtCUSAVEOPT").val());
                var formData = $("#FrmCRReq").serializeArray();
                //alert(formData);
                $.ajax({
                    type: 'POST',
                    url: "ajxCRReqSCls?req=mnu311CSAVE",
                    data: formData,
                    dataType: 'text',
                    async: true,
                    success: function(data, textStatus, jqXHR) 
                    {
                        if (data !== "0") {
                            $("#TxtCRRID").val(data);
                            fnHideLayer("waitLayer");
                            $('#TxtCNAME').focus();
                            if($("#TxtSAVEOPT").val() === "NEW") {
                                $("#TxtSAVEOPT").val("UPD");
                                $("#FrmCRReqST").show();
                            }
                            alert("Saved Successfully.");
                            $('#spIframe').attr('src', 'RptActions?t=pdf&RPTNO='+$("#TxtCRRID").val());
                            $('#dialogRptPage').dialog('open');
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) 
                    {
                        fnHideLayer("waitLayer");
                        alert(textStatus);
                        //window.location="logon.jsp";
                    }
                });
            }
            
            function funCRReqPreVSAVE() {
                fnSetText("TxtSAVEOPT", "GEN");
                $("#CRRLSTLOAD").val("YES");
                funCRReqSAVE();
                //$(".ui-dialog-content").dialog("close");
                //$( "#dataLayer" ).dialog( "close" );
                //$("#btnSearch").trigger('click');
            }
            
            function funCRReqGenConf() {
                fnShowLayer("waitLayer");
                //var formData = $("#FrmCRTrn").serializeArray();
                $.ajax({
                    type: 'POST',
                    url: "ajxCRReqSCls?req=mnu311CCNF&id="+$("#TxtCRRID").val(),
                    //data: formData,
                    dataType: 'text',
                    async: true,
                    success: function(data, textStatus, jqXHR) 
                    {
                        if (data === "Success") {
                            $( "#dataLayer" ).dialog( "close" );
                            //alert("Combined Report Request Completed Successfully.");
                            //setTimeout(funOnLoad_FillList(), 500);
                            funShowRpt();
                            fnHideLayer("waitLayer");
                            $("#btnEMAIL").button( "option", "disabled", false );
                        } 
                        fnHideLayer("waitLayer");
                    },
                    error: function(jqXHR, textStatus, errorThrown) 
                    {
                        //$('#ListDIV').hide();
                        alert(textStatus);
                        //window.location="logon.jsp";
                        fnHideLayer("waitLayer");
                    }
                });
            }
            
            function funCRReqGen() {
                $( "#dgGenConfirm" ).dialog( "open" );
            }
            
            function funShowRpt() {
                var fn = "PdfCNRFiles/GLSCNR" + fnPadLeft($("#TxtCRRID").val(), 5)+".pdf";
                $('#spIframe').attr('src', fn);
                $("#dialogRptPage").dialog('open');
            }
            
            function funCRReqEmail() {
                if($("#TxtRPTTO").val()==="") {
                    alert("Sorry, You can't sent email now. Email ids are not updated before generate the report.\n Please download the report and send it from your email id.");
                    return false;
                }
                if (!fnValidate("TxtRPTTO", "To Email ID", 8)) return false;
                if (!fnValidateEmail("TxtRPTTO", "To Email ID", 8)) return false;
                if($("#TxtRPTCC").val() !== "") {
                    if (!fnValidateEmail("TxtRPTCC", "CC Email ID", 5)) return false;
                }
                
                fnShowLayer("waitLayer");
                //var formData = $("#FrmCRTrn").serializeArray();
                $.ajax({
                    type: 'POST',
                    url: "ajxCRReqSCls?req=mnu311CEMAIL&id="+$("#TxtCRRID").val(),
                    //data: formData,
                    dataType: 'text',
                    async: true,
                    success: function(data, textStatus, jqXHR) 
                    {
                        console.log(textStatus);
                        if (data !== "ERROR") {
                           alert("Report mail delivered successfully.");
                        } else {
                            alert("Report mail not delivered due to error.");
                        }
                        fnHideLayer("waitLayer");
                    },
                    error: function(jqXHR, textStatus, errorThrown) 
                    {
                        console.log(textStatus);
                        //$('#ListDIV').hide();
                        alert(textStatus);
                        //window.location="logon.jsp";
                        fnHideLayer("waitLayer");
                    }
                });
            }
            
            function funCRReqSTUpd(crrsno,st,rem,aval) {
                $("#TxtSTSNO").val(crrsno);
                $("#CboSTYPE").val(st);
                $("#TxtSTREMARKS").val(rem);
                $("#TxtASVAL").val(aval);
                $('#CboSTYPE').prop('disabled', true);
                $('#TxtASVAL').prop('disabled', true);
                $("#TxtSTSAVEOPT").val("UPD");
                $("#btnSTSave").show();
                //$( "#dgDelSTConfirm" ).dialog('open');
            }
             
            function funCRReqSTSAVE() {
                fnShowLayer("waitLayer");
                $('#CboSTYPE').prop('disabled', false);
                var formData = $("#FrmCRReqST").serializeArray();
                //alert(formData);
                $.ajax({
                    type: 'POST',
                    url: "ajxCRReqSCls?req=mnu311CSTSAVE",
                    data: formData,
                    dataType: 'text',
                    async: true,
                    success: function(data, textStatus, jqXHR) 
                    {
                        if (data !== "0") {
                            $("#TxtSTSNO").val(data);
                            fnHideLayer("waitLayer");
                            $("#btnSTSave").hide();
                            $('#TxtASVAL').focus();
                            $("#CRRLSTLOAD").val("YES");
                            //if($("#TxtSTSAVEOPT").val() === "NEW") {$("#TxtSTSAVEOPT").val("UPD");}
                            funOnLoad_STFillList();
                            alert("Saved Successfully.");
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) 
                    {
                        fnHideLayer("waitLayer");
                        alert(textStatus);
                        //window.location="logon.jsp";
                    }
                });
            }
            
            function funCRReqSTSAVEDel() {
                fnSetText("TxtSTSAVEOPT", "DEL");
                fnShowLayer("waitLayer");
                funCRReqSTSAVE();
                funOnLoad_STFillList();
                $("#TxtSTCRRID").val($("#TxtCRRID").val());
                $("#CboSTYPE").val("0");
                $("#TxtESVAL").val("");
                $("#TxtASVAL").val("");
            }
            
            function funOnLoad_STFillList() {
                $("#TxtSTCRRID").val($("#TxtCRRID").val());
                fnShowLayer("waitLayer");
                
                $.ajax({
                    type: 'GET',
                    url: "ajxCRReqSCls?req=mnu311CSTLIST&id=" + $("#TxtCRRID").val(),
                    dataType: 'json',
                    async: true,
                    success: function(data, textStatus, jqXHR) 
                    {
                        var tr = data.LISTROWS;
                        if (tr === "") {
                            tr = "<tr class=even><td colspan=9>No Record(s).</<td></tr>";
                        }
                        //alert(tr);
                        fnHideLayer("waitLayer");
                        //$('#ListDIV').show();
                        if (tfCRCST !== undefined) {
                            if (tfCRCST.HasGrid()) {
                                tfCRCST.RemoveGrid();
                            }
                        }
                        $("#tblCRCSTList tbody").html(tr);
                        tfCRCST = setFilterGrid("tblCRCSTList", tblCRCSTProps);
                        
                    },
                    error: function(jqXHR, textStatus, errorThrown) 
                    {
                        //$('#ListDIV').hide();
                        alert(textStatus);
                        //window.location="logon.jsp";
                        fnHideLayer("waitLayer");
                    }
                });
            }
            
            function funCRReqBKSRC_Save() {
                fnShowLayer("waitLayer");
                //var formData = $("#FrmCRTrn").serializeArray();
                $.ajax({
                    type: 'POST',
                    url: "ajxCRReqSCls?req=mnu311BKSRC&id="+$("#TxtCRRID").val(),
                    //data: formData,
                    dataType: 'text',
                    async: true,
                    success: function(data, textStatus, jqXHR) 
                    {
                        if (data === "Success") {
                            $( "#dataLayer" ).dialog( "close" );
                            setTimeout(funOnLoad_FillList(), 500);
                            fnHideLayer("waitLayer");
                        } 
                    },
                    error: function(jqXHR, textStatus, errorThrown) 
                    {
                        //$('#ListDIV').hide();
                        alert(textStatus);
                        //window.location="logon.jsp";
                        fnHideLayer("waitLayer");
                    }
                });
            }
            function funCRReqBKSRC() {
                $( "#dgBKSRCConfirm" ).dialog( "open" );
            }
            
            // main page
            function funfillCbo(){
                fnFillCombo("CboCSIDmp", params, "CL", "0A");
                fnFillCombo("CboCSID", params, "CL", "S");
                fnFillCombo("CboSTYPE", params, "ST", "S");
            }
            
            function funCboCSID_Change() {
                fnFillCombo("CboCSUID", params, "CSID" + $("#CboCSID").val(), "S");
            }
            
            function funCboCSIDmp_Change() {
                fnFillCombo("CboCSUIDmp", params, "CSID" + $("#CboCSIDmp").val(), "0A");
            }
            
            function funOnLoad_FillList() {
                var formData = $("#FrmSEARCH").serializeArray();
                fnShowLayer("waitLayer");
                
                $.ajax({
                    type: 'POST',
                    url: "ajxCRReqSCls?req=mnu311CLIST",
                    data: formData,
                    dataType: 'json',
                    async: true,
                    success: function(data, textStatus, jqXHR) 
                    {
                        var tr = data.LISTROWS;
                        if (tr === "") {
                            tr = "<tr class=even><td colspan=8>No Record(s).</<td></tr>";
                        }
                        //$('#ListDIV').show();
                        fnHideLayer("waitLayer");
                        if (tfCRR !== undefined) {
                            if (tfCRR.HasGrid()) {
                                tfCRR.RemoveGrid();
                            }
                        }
                        $("#tblCRRList tbody").html(tr);
                        tfCRR = setFilterGrid("tblCRRList", tblCRRProps);
                        
                    },
                    error: function(jqXHR, textStatus, errorThrown) 
                    {
                        //$('#ListDIV').hide();
                        alert(textStatus);
                        window.location="logon.jsp";
                        fnHideLayer("waitLayer");
                    }
                });
            }
            
            function funFrmReset(pfrm) {
                if (pfrm === "FrmCRReq") {
                    $("#FrmCRReq").trigger('reset');
                    $("#TxtCRRID").val("0");
                    $("#TxtSTCRRID").val("0");
                    $("#TxtSTSNO").val("0");
                    $("#TxtSTSAVEOPT").val("NEW");
                    $("#TxtSAVEOPT").val("NEW");
                    funCboCSID_Change();
                } 
                else {
                    $("#FrmSEARCH").trigger('reset');
                    funCboCSIDmp_Change();
                }
            }
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
                $.datepicker.setDefaults({
                        showOn: 'both', dateFormat: "dd-mm-yy", 
                        showButtonPanel: true, closeText: "Close",
                        numberOfMonths: 1, changeMonth: false,
                        constrainInput: true, buttonImageOnly: true,
                        buttonImage: 'images/calendar.gif'});     
                $("#TxtDTREQ").datepicker({
                    changeMonth: true,
                    changeYear: false,
                    numberOfMonths: 1,
                    maxDate:"-0d"
                });
                
                $( "#dataLayer" ).dialog({
                    modal: true, autoOpen: true, resizable: false,
                    height:'auto', width:'auto', closeOnEscape: false,
                    buttons: {
                        Close: function() {
                            $( this ).dialog( "close" );
                            if ($("#CRRLSTLOAD").val() === "YES") {
                                setTimeout(funOnLoad_FillList(), 500);
                            }
                        }
                    }
                });
                

                $("#dialogRptPage").dialog({
                    modal: true, autoOpen: false, resizable: false,
                    height:'auto', width:'auto',
                    open: function () {
                      //autoResizeIF('myListIframe');  
                    },
                    close: function(event, ui){
                        $('#spIframe').attr('src','');
                    }
                });
        
                // for delete/close confirmation dialog
                $( "#dgDelSTConfirm" ).dialog({
                    modal: true, autoOpen: false, resizable: false,
                    height:170, width:350,
                    buttons: {
                        "Update": function() {
                            $( this ).dialog( "close" );
                            $("#TxtSTSAVEOPT").val("UPD");
                            $("#btnSTSave").show();
                        },
                        Cancel: function() {
                            $( this ).dialog( "close" );
                        }
                    }
                });
                
                $( "#dgGenConfirm" ).dialog({
                    modal: true, autoOpen: false, resizable: false,
                    height:170, width:350,
                    buttons: {
                        "Generate": function() {
                            $("#CRRLSTLOAD").val("YES");
                            $( this ).dialog( "close" );
                            setTimeout(funCRReqGenConf(), 500);
                        },
                        Cancel: function() {
                            $( this ).dialog( "close" );
                        }
                    }
                });
                
                $( "#dgBKSRCConfirm" ).dialog({
                    modal: true, autoOpen: false, resizable: false,
                    height:170, width:350,
                    buttons: {
                        "Send it Back": function() {
                            $("#CRRLSTLOAD").val("YES");
                            $( this ).dialog( "close" );
                            setTimeout(funCRReqBKSRC_Save(), 500);
                        },
                        Cancel: function() {
                            $( this ).dialog( "close" );
                        }
                    }
                });
                
                $("#TxtRPTREM").autosize({append: "\n"});
                
                $( "#dataLayer" ).dialog('close');
                setTimeout(funOnLoad_FillList(), 500);
            });
            
            funfillCbo();
        </script>
        <!-- Alert (message) -->
        <%out.print(AppUtils.printMessage(request));%>
    </body>
</html>
