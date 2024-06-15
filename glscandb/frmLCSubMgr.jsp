<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.HashMap,java.util.ArrayList"%>
<%@page import="glscandb.AppUtils,glscandb.classes.UserCls,glscandb.classes.ClientSubCls"%>
<%@ include file="includes/SessionValid.inc" %>

<%
    String lType = (String)request.getSession().getAttribute("objType");
    if (lType==null) {
        request.setAttribute("msg", "There is a program error(MNU207).<br>Please convey to administator with this error code.");
        request.getRequestDispatcher("logon.jsp").forward(request, response);            
        return;
    }
    if (!lType.startsWith("mnu207")) {
        request.setAttribute("msg", "There is a program error(MNU207).<br>Please convey to administator with this error code.\n" + lType);
        request.getRequestDispatcher("logon.jsp").forward(request, response);            
        return;
    }
    String title = "Client - Subscription Manager";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>glScanDB - Subscription Manger</title>
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
        <script type="text/javascript" src="scripts/AppsUtil.js"></script>
        
        <script type="text/javascript">
            var tfLCCon;
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
                <td align="center">
                    <table style="width:80%">
                        <tr>
                            <td class="MainHeading">
                                <%=title%>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="Right">
                                <input type="button" id="btnAdd" value="Add a Subscription" 
                                       onclick="javascript:funAdd();" 
                                       title="Add a new Client in the below List">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%@ include file="includes/tblLCSubMgr.inc" %>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div id="dataLayer" title="Subscriber Details">
            <form name="FrmLCSub" id="FrmLCSub" method="post">
                <input type="hidden" name="TxtCSID" id="TxtCSID" value="0">
                <input type="hidden" name="TxtSTATUS" id="TxtSTATUS" value="0">
                <input type="hidden" name="TxtSAVEOPT" id="TxtSAVEOPT" value="0">
                <table>
                    <tr>
                        <td class="SubHeading" colspan="4">Subscriber</td>
                    </tr>
                    <tr>
                        <td>Full Name<span class="bold" style="color: orange">*</span></td>
                        <td>
                            <input type="text" id="TxtCSNAME" name="TxtCSNAME"
                                   maxlength="150" size="20">
                        </td>
                        <td>Short Name<span class="bold" style="color: orange">*</span></td>
                        <td>
                            <input type="text" id="TxtCSSHORT" name="TxtCSSHORT" 
                                   maxlength="15" size="12">
                        </td>
                    </tr>
                    <tr>
                        <td class="Top" rowspan="2">Address</td>
                        <td class="Top" rowspan="2">
                            <textarea id="TxtADDRESS" name="TxtADDRESS" rows="3" cols="20"></textarea> 
                        </td>
                        <td>Category</td>
                        <td>
                             <SELECT id="CboCCAT" name="CboCCAT">
                                <option value="98">Bank</option>
                                <option value="97">Finance</option>
                                <option value="99">Others</option>
                            </SELECT>
                        </td>
                    </tr>
                    <tr>
                        <td>Status</td>
                        <td><SELECT id="CboSTATUS" name="CboSTATUS">
                                <option value="A">ACTIVE</option>
                                <option value="I">IN-ACTIVE</option>
                                <option value="B">SUSPEND</option>
                            </SELECT></td>
                    </tr>
                    <tr>
                        <td class="SubHeading" colspan="4">Point of Contact</td>
                    </tr>
                    <tr>
                        <td>Person Name<span class="bold" style="color: orange">*</span></td>
                        <td><input type="text" id="TxtCPNAME" name="TxtCPNAME"
                                   maxlength="50" size="20"></td>
                    </tr>
                    <tr>
                        <td>Email Id<span class="bold" style="color: orange">*</span></td>
                        <td>
                            <input type="text" id="TxtCPEMAIL" name="TxtCPEMAIL"
                                   maxlength="150" size="20"></td>
                        <td>Mobile No</td>
                        <td>
                            <input type="text" id="TxtCPMOB" name="TxtCPMOB"
                                   maxlength="50" size="12"></td>
                    </tr>
                    <tr>
                        <td>Title</td>
                        <td>
                            <input type="text" id="TxtCPTITLE" name="TxtCPTITLE"
                                   maxlength="50" size="20"></td>
                        <td>Phone No</td>
                        <td><input type="text" id="TxtCPPHNO" name="TxtCPPHNO"
                                   maxlength="50" size="12"></td>
                    </tr>
                    <tr>
                        <td>Dept. Name</td>
                        <td>
                            <input type="text" id="TxtCPDUNIT" name="TxtCPDUNIT"
                                   maxlength="50" size="20"></td>
                        <td>Fax No</td>
                        <td>
                            <input type="text" id="TxtCPFAXNO" name="TxtCPFAXNO"
                                   maxlength="50" size="12"></td>
                    </tr>
                    <tr>
                        <td class="SubHeading" colspan="4">Contract Details</td>
                    </tr>
                    <tr>
                        <td>Users</td>
                        <td>
                            <select id="CboLNOUSR" name="CboLNOUSR" onchange="funCboLimit('NOUSR', 'CU');">
                                <option value="0">limited</option>
                                <option value="-1">Unlimited</option>
                            </select>
                            <input type="text" id="TxtNOUSR" name="TxtNOUSR" 
                                   onkeypress="fnMaskInputTo(this, 5, 0, false);"
                                   onblur="funChgUsrLmt();"
                                   maxlength="7" size="7"></td>
                        <td>Starting From</td>
                        <td><input type="text" id="TxtDTCFROM" name="TxtDTCFROM" readonly
                                   maxlength="10" size="10"></td>
                    </tr>
                    <tr>
                        <td>Reports</td>
                        <td>
                            <select id="CboLNORPT" name="CboLNORPT" onchange="funCboLimit('NORPT', 'CR');">
                                <option value="0">limited</option>
                                <option value="-1">Unlimited</option>
                            </select>
                            <input type="text" id="TxtNORPT" name="TxtNORPT" 
                                   onkeypress="fnMaskInputTo(this, 5, 0, false);"
                                   maxlength="7" size="7"></td>
                        <td>Expiry on</td>
                        <td><input type="text" id="TxtDTCEXP" name="TxtDTCEXP" readonly
                                   maxlength="10" size="10"></td>
                    </tr>
                    <tr>
                        <td>Watch list</td>
                        <td><select id="CboLNOWLST" name="CboLNOWLST" onchange="funCboLimit('NOWLST', 'CW');">
                                <option value="0">limited</option>
                                <option value="-1">Unlimited</option>
                                <option value="-2">No Watch list</option>
                            </select>
                            <input type="text" id="TxtNOWLST" name="TxtNOWLST" 
                                   onkeypress="fnMaskInputTo(this, 5, 0, false);"
                                   maxlength="5" size="5"></td>
                        <td></td>
                        <td class="Right">
                            <input id="btnUnits" type=button value="Units" onclick="funUnits();">
                            <img src="images/wspacer.jpg" hspace="4" alt=' '>
                            <input id="btnHistory" type=button value="History" onclick="funContracts();">
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <script type="text/javascript">
            function funAdd()  {
                $("#FrmLCSub").trigger("reset");
                fnSetText("TxtSAVEOPT", "NEW");
                fnSetText("TxtCSID", "0");
                fnSetCbo("CboCCAT", "1");
                fnSetCbo("CboSTATUS", "A");
                $("#TxtDTCFROM").datepicker('setDate', (new Date()));
                $("#TxtDTCEXP").datepicker('setDate', (new Date()));
                $("#btnHistory").hide();
                $("#btnUnits").hide();
                funCboLimit('NOUSR', '');
                funCboLimit('NORPT', '');
                funCboLimit('NOWLST', '');
                $( "#dataLayer" ).dialog( "open" );
            }
            
            function funUpdate(csid)  {
                fnSetText("TxtSAVEOPT", "UPD");
                fnSetText("TxtCSID", csid);
                // fetch the data from db
                $.get("AjaxActions?req=GETCSIDDTL&id="+csid,
                    function(responseText) { 
                        if (responseText !== "{}") {
                            funSetJSONVal(responseText);
                            $("#btnHistory").show();
                            $("#btnUnits").show();
                            $( "#dataLayer" ).dialog( "open" );
                            $('#TxtCSNAME').focus();
                            tfLCSub.ezEditTable.Selection.ClearSelections();
                        }
                    })
                    .error(function(xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert("Please inform to Administrator for this error (MNU207)\n" + err.Message);
                    });
                
            }
            
            function funSetJSONVal(jsontext) {
                var data = JSON.parse(jsontext);
                var items = Object.keys(data);
                items.forEach(function(item) {
                    if ($("#"+item).length !== 0) {
                        if (item.substr(0,3) === "lbl") {
                            $("#"+item).html(data[item]); 
                        }
                        else{
                            $("#"+item).val(data[item]); 
                        }
                    }
                });
                //alert(data.CboSTATUS);
                if ((data.CboSTATUS === "V") || (data.CboSTATUS === "F")) { $('#CboSTATUS').val("A"); }
                funCboLimit('NOUSR', '');
                funCboLimit('NORPT', '');
                funCboLimit('NOWLST', '');
            }
            
            function funSetUsrLmtUPD(v) {
                $.get("AjaxActions?req=CSMGRANOUSR&CSID="+v,
                    function(responseText) {
                        if (responseText !== "0") {
                            $("#TxtNOUSR").val(responseText);
                        }
                    }
                ).error(function(xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    alert("Please inform to Administrator for this error (MNU207-CSMGRANOUSR)\n" + err.Message);
                  });
            }
            function funChgUsrLmt() {
                var v = fnGetText("TxtCSID");
                if ((v === "") || (fnGetText("TxtSAVEOPT")==="NEW")) return;
                //fnShowLayer("waitLayer");
                $.get("AjaxActions?req=CSMGRANOUSR&CSID="+v,
                    function(responseText) {
                        if (responseText !== "0") {
                            var anurs = parseInt(responseText);
                            var nurs = parseInt(fnGetText("TxtNOUSR"));
                            if (anurs > nurs) {
                                alert("No of active users in the system are "+anurs+".\nPlease deactivate the users to update the contract.");
                                $("#TxtNOUSR").val(anurs);
                            }
                            //fnSetCbo("CboCSID", "");
                        }
                    }
                ).error(function(xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    alert("Please inform to Administrator for this error (MNU207-CSMGRANOUSR)\n" + err.Message);
                  });
            }
            
            function funCboLimit(ctln, fr) {
                if ($("#CboL"+ctln).val() === "0") {
                    if ((fnGetText("TxtSAVEOPT")==="UPD") && (fr==='CU')) {
                        funSetUsrLmtUPD($("#TxtCSID").val());
                        //alert("WARNING !...\nThe access will be granted to limited users on FILO. The remaining will be revoked.");
                    }
                    if ((fnGetText("TxtSAVEOPT")==="UPD") && (fr==='CW')) {
                        alert("WARNING !...\nAll the watch list will be revoked.");
                    }
                    $("#Txt"+ctln).removeAttr("readonly");
                } 
                else {
                    $("#Txt"+ctln).val("");
                    $("#Txt"+ctln).attr("readonly", "readonly");
                }
            }
            
            function funIsValid(){
                if (!fnValidate("TxtCSSHORT", "Short Name", 3)) return false;
                if (!fnValidate("TxtCSNAME", "Fulll Name", 5)) return false;
                // check duplicate PARAM key, value
                if (fnGetText("TxtSAVEOPT")==="NEW") {
                    //if (!fnCheckDuplicateInTable(tfLCSub, 2, fnGetText("TxtCSIDSNO"), "TxtCSHORT", "lblCSHORT" )) return false;
                    //if (!fnCheckDuplicateInTable(tfLCSub, 3, fnGetText("TxtCSIDSNO"), "TxtCNAME", "lblCNAME" )) return false;
                }
                if (!fnValidate("TxtCPNAME", "Person Name", 5)) return false;
                if (!fnValidate("TxtCPEMAIL", "Email Id", 8)) return false;
                if (!fnValidateEmail("TxtCPEMAIL", "Email Id", 8)) return false;
                //if (!fnValidate("TxtCPMOB", "lblNOUSER", 1)) return false;
                
                if ($("#CboLNOUSR").val() === "0") {
                    if (!fnValidateNo("TxtNOUSR", "No of Users")) return false;
                } else {
                    $("#TxtNOUSR").val($("#CboLNOUSR").val());
                }
                if ($("#CboLNORPT").val() === "0") {
                    if (!fnValidateNo("TxtNORPT", "No of Reports")) return false;
                } else {
                    $("#TxtNORPT").val($("#CboLNORPT").val());
                }
                if ($("#CboLNOWLST").val() === "0") {
                    if (!fnValidateNo("TxtNOWLST", "No of Watches")) return false;
                } else {
                    $("#TxtNOWLST").val($("#CboLNOWLST").val());
                }
                return true;
            }
            
            function funSave(){
                fnShowLayer("waitLayer");
                
                document.forms["FrmLCSub"].action = "Actions?req=Save207";
                document.forms["FrmLCSub"].submit();
            }
            
            function funRemove(pid) {
                fnSetText("TxtCSID", pid);
                $("#dialog-del-confirm" ).dialog( "open" );
            }
            
            function funContracts() {
                $("#TxtCSID").val();
                var t = $("#TxtCSNAME").val();//tfLCSub.GetDataCell(rowidx, 3);
                if ($("#dataCDLayer").length === 0) {
                    var dialogOptions = {
                        "title" : 'Contract History for ' + t,
                        "width" : '700px',
                        "height" : 'auto',
                        "modal" : true,
                        position: { my: "center center", at: "center center", of: window },
                        "resizable" : true,
                        "draggable" : false,
                        "close" : function(){ $(this).remove(); }
                    };
                    $("<div id='dataCDLayer' />").dialog(dialogOptions)
                            .load("frmLCSubMgr_sp.jsp");
                }
            }
            
            function funUnits() {
                $("#TxtCSID").val();
                var t = $("#TxtCSNAME").val();//tfLCSub.GetDataCell(rowidx, 3);
                if ($("#dataCDLayer").length === 0) {
                    var dialogOptions = {
                        "title" : 'Unit/Department for ' + t,
                        "width" : '500px',
                        "height" : 'auto',
                        "modal" : true,
                        position: { my: "center center", at: "center center", of: window },
                        "resizable" : true,
                        "draggable" : false,
                        "close" : function(){ $(this).remove(); }
                    };
                    $("<div id='dataCDLayer' />").dialog(dialogOptions)
                            .load("frmLCSubMgr_unit.jsp");
                }
            }
        </script>
        
        <!-- confirmation dialogs -->
        <div id="dialog-del-confirm" title="Delete this user?">
            <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
                This subscriber will be deleted and cannot be recovered.<BR>Do you still want to continue?</p>
        </div>
        
        <!-- Page Ready events -->
        <div id="LastElement"></div>
        <script type="text/javascript">
            $(document).ready(function() {
                $( "input[type=button], button" )
                    .button()
                    .click(function( event ) {
                        event.preventDefault();
                    });
                
                // for delete/close confirmation dialog
                $( "#dialog-del-confirm" ).dialog({
                    modal: true, autoOpen: false, resizable: false,
                    height:170, width:350,
                    buttons: {
                        "Delete": function() {
                            $( this ).dialog( "close" );
                            fnSetText("TxtSAVEOPT", "DEL");
                            fnSetText("TxtSTATUS", "D");
                            funSave();
                        },
                        Cancel: function() {
                            $( this ).dialog( "close" );
                        }
                    }
                });
                
                $( "#dataLayer" ).dialog({
                    modal: true, autoOpen: false, resizable: false,
                    height:'auto', width:'auto',
                    buttons: {
                        "Save": function() {
                            if (!funIsValid()) { return; };
                            $( this ).dialog( "close" );
                            funSave();
                        },
                        Cancel: function() {
                            $( this ).dialog( "close" );
                        }
                    }
                });
                
                $.datepicker.setDefaults({
                    showOn: 'both', dateFormat: "dd-mm-yy", 
                    showButtonPanel: true, closeText: "Close",
                    numberOfMonths: 1, changeMonth: true, changeYear:true,
                    constrainInput: true, buttonImageOnly: true,
                    buttonImage: 'images/calendar.gif'});
                $( "#TxtDTCFROM" ).datepicker({
                    defaultDate: "-1d",
                    onClose: function( selectedDate ) {
                        $( "#TxtDTCEXP" ).datepicker( "option", "minDate", selectedDate );
                    }
                });
                $( "#TxtDTCEXP" ).datepicker({
                    defaultDate: "+0d",
                    onClose: function( selectedDate ) {
                        $( "#TxtDTCFROM" ).datepicker( "option", "maxDate", selectedDate );
                    }
                });
                
            });
        </script>
        <!-- Alert (message) -->
        <%out.print(AppUtils.printMessage(request));%>
    </body>
</html>
