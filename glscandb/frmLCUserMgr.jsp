<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.HashMap,java.util.ArrayList"%>
<%@page import="glscandb.AppUtils,glscandb.classes.UserCls,glscandb.classes.CSUserCls"%>
<%@ include file="includes/SessionValid.inc" %>

<%
    String lType = (String)request.getSession().getAttribute("objType");
    if (lType==null) {
        request.setAttribute("msg", "There is a program error(MNU208).<br>Please convey to administator with this error code.");
        request.getRequestDispatcher("logon.jsp").forward(request, response);            
        return;
    }
    if (!lType.startsWith("mnu208")) {
        request.setAttribute("msg", "There is a program error(MNU208).<br>Please convey to administator with this error code.\n" + lType);
        request.getRequestDispatcher("logon.jsp").forward(request, response);            
        return;
    }
    String title = "Client - User Manager";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>glScanDB - Subscriber User Manger</title>
        <link type="image/icon" href="images/sysicon.gif" rel="shortcut icon"/>
        <style type="text/css">
            @import "includes/apps.css";
            @import "scripts/jquery/smoothness/jquery-ui.min.css";
        </style>
        
        <script type="text/javascript" src="scripts/TableFilter/tablefilter_all_min.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery-ui.min.js"></script>
        <script type="text/javascript" src="scripts/AppsUtil.js"></script>
        
        <!-- Print Param Array -->
        <% out.print(AppUtils.printParamArray(request)); %>
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
                            <td>
                                <table>
                                    <tr>
                                        <td> Subscriber 
                                            <SELECT name="CboMCSID" id="CboMCSID">
                                                <option value="0">Select</option>
                                            </SELECT>
                                        </td>
                                        <td class="Right">
                                            <input type="button" id="btnAdd" value="Add an User" 
                                                onclick="javascript:funAdd();" 
                                                title="Add a new user in the below List">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%@ include file="includes/tblLCUsers.inc" %>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div id="dataLayer" title="Client - User Details">
            <form name="FrmCLUsers" id="FrmCLUsers" method="post">
                <input type="hidden" name="TxtCUID" id="TxtCUID" value="0">
                <input type="hidden" name="TxtSTATUS" id="TxtSTATUS" value="0">
                <input type="hidden" name="TxtCUIDEX" id="TxtCUIDEX" value="0">
                <input type="hidden" name="TxtSAVEOPT" id="TxtSAVEOPT" value="0">
                <table>
                    <tr>
                        <td id="lblSYSROLE">Subscriber<span class="bold" style="color: orange">*</span></td>
                        <td>
                            <SELECT name="CboCSID" id="CboCSID">
                                <option value="0">Select</option>
                            </SELECT>
                        </td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td id="lblCUNAME">Full Name<span class="bold" style="color: orange">*</span></td>
                        <td>
                            <input type="text" name="TxtCUNAME" id="TxtCUNAME" 
                                   value="" maxlength="50" size="20">  
                        </td>
                        <td id="lblLOGINID">Login ID<span class="bold" style="color: orange">*</span></td>
                        <td>
                            <input type="text" name="TxtLOGINID" id="TxtLOGINID"
                                   onblur="funValidLoginID();"
                                   value="" maxlength="10" size="10">
                            <input type="hidden" name="TxtCUPWD" id="TxtCUPWD" 
                                   value="" size="10" readonly>
                        </td>
                    </tr>
                    <tr>
                        <td id="lblCUTITLE">Title</td>
                        <td>
                            <input type="text" name="TxtCUTITLE" id="TxtCUTITLE" 
                                   value="" maxlength="50" size="20">  
                        </td>
                        <td id="lblCUEMAIL">E-Mail ID<span class="bold" style="color: orange">*</span></td>
                        <td>
                            <input type="text" name="TxtCUEMAIL" id="TxtCUEMAIL" 
                                   value="" maxlength="50" size="20">  
                        </td>
                    </tr>
                    <tr>
                        <td id="lblCUDUNIT">Dept./Unit Name</td>
                        <td>
                            <input type="text" name="TxtCUDUNIT" id="TxtCUDUNIT" 
                                   value="" maxlength="50" size="20">  
                        </td>
                        <td id="lblCUPHNO">Telephone</td>
                        <td>
                            <input type="text" name="TxtCUPHNO" id="TxtCUPHNO" onkeypress="fnMaskInputTo(this, 9,0, false);"
                                   value="" maxlength="50" size="20">  
                        </td>
                    </tr>
                    <tr>
                        <td id="lblCUMOB">Mobile No</td>
                        <td>
                            <input type="text" name="TxtCUMOB" id="TxtCUMOB" onkeypress="fnMaskInputTo(this, 10,0, false);"
                                   value="" maxlength="50" size="20">  
                        </td>
                        <td>Status<span class="bold" style="color: orange">*</span></td>
                        <td>
                            <SELECT name="CboSTATUS" id="CboSTATUS" onchange="funChgSTATUS()">
                                <option value="A">Active</option>
                                <option value="I">In-active</option>
                                <option value="L">Lock</option>
                                <option value="B">Block</option>
                            </SELECT>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Watch list</td>
                        <td>
                            <SELECT name="CboWLSTALOW" id="CboWLSTALOW" onchange="funCboWLSTALOW('CW');">
                                <option value="N">Not Allowed</option>
                                <option value="A">Allowed</option>                                
                            </SELECT>
                        </td>
                        <td>No of Watch list</td>
                        <td>
                            <input type="hidden" name="TxtNOWLSTCUR" id="TxtNOWLSTCUR">
                            <input type="text" name="TxtNOWLST" id="TxtNOWLST" 
                                   title="0 means shared and limit to subscrition"
                                   onkeypress="fnMaskInputTo(this, 5, 0, false);"
                                   onblur="funCheckNoWLST();"
                                   value="0" size="5">
                        </td>
                    </tr>
                </table>
            </form>
        </div>

        
        <script type="text/javascript">
            function funSetJSONVal(jsontext) {
                //CSID, LOGINID, CUNAME, CUTITLE, CUDUNIT, CUMOB, CUPHNO, CUEMAIL, WLSTALOW, NOWLST
                var data = JSON.parse(jsontext);
                $('#CboCSID').val(data.CSID);
                $('#CboMCSID').val(data.CSID);
                $('#TxtLOGINID').val(data.LOGINID);
                $('#TxtCUNAME').val(data.CUNAME);
                $('#TxtCUTITLE').val(data.CUTITLE);
                $('#TxtCUDUNIT').val(data.CUDUNIT);
                $('#TxtCUMOB').val(data.CUMOB);
                $('#TxtCUEMAIL').val(data.CUEMAIL);
                $('#TxtCUPHNO').val(data.CUPHNO);
                $('#CboWLSTALOW').val(data.WLSTALOW);
                $('#TxtNOWLST').val(data.NOWLST);
                $('#TxtNOWLSTCUR').val(data.NOWLST);
                $('#TxtSTATUS').val(data.STATUS);
                $('#CboSTATUS').val(data.STATUS);
                $("#CboWLSTALOW").prop("disabled", (data.WLSTALOW==="N"));
                funCboWLSTALOW('');
                funCheckWLST(data.CSID);
                $('#CboCSID').prop("disabled", true);
            }
            
            function funChangeMCSID() {
                fnShowLayer("waitLayer");
                document.forms["FrmCLUsers"].action = "Actions?req=mnu208&CSID="+$('#CboMCSID').val();
                document.forms["FrmCLUsers"].submit();
            }
            
            function funCheckWLST(v) {
                //alert(v);
                $.get("AjaxActions?req=CUMGRWLSTC&CSID="+v,
                    function(responseText) { 
                        //fnHideLayer("waitLayer");
                        if (responseText === "-2") {
                            //alert("No of user license exceeded. Please check and try again.");
                            $("#CboWLSTALOW").prop("disabled", true);
                            $("#CboWLSTALOW").val("N");
                            funCboWLSTALOW('');                            
                        } 
                        else {
                            $("#CboWLSTALOW").prop("disabled", false);
                        }
                    }
                ).error(function(xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    alert("Please inform to Administrator for this error (MNU208-CUMGRRLNO)\n" + err.Message);
                  });
            }
            
            function funCheckNoWLST() {
                var v = fnGetText("CboCSID");
                if (v === "") return;
                $.get("AjaxActions?req=CUMGRNOWLSTG&CSID="+v,
                    function(responseText) { 
                        //fnHideLayer("waitLayer");
                        if (responseText === "-2") {
                            $("#CboWLSTALOW").val("N");
                            alert("Sorry, Watch list not licensed.");
                            $("#TxtNOWLST").val("0");
                        } 
                        else if (responseText !== "99999") {
                            var nwll = parseInt(responseText);
                            var nowl = parseInt($("#TxtNOWLSTCUR").val());
                            var nnwl = parseInt($("#TxtNOWLST").val());
                            if (nwll < (nnwl-nowl)) {
                                alert(responseText + " no of watch list allowed.");
                                $("#TxtNOWLST").val(nowl);
                            }
                        }  
                    }
                ).error(function(xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    alert("Please inform to Administrator for this error (MNU208-CUMGRRLNO)\n" + err.Message);
                  });
            }
            
            function funCheckUsrLmt(v, fr) {
                //fnShowLayer("waitLayer");
                $.get("AjaxActions?req=CUMGRBNOUSR&CSID="+v,
                    function(responseText) { 
                        //fnHideLayer("waitLayer");
                        if (responseText === "") {
                            alert("No active contract for the selected subscriber. Please try again later.");
                            fnSetCbo("CboCSID", "");
                        }
                        else if (responseText === "0") {
                            alert("No of user license exceeded. Please check and try again.");
                            if (fr === 'CS') { 
                                fnSetCbo("CboCSID", "");
                                funCheckWLST(v);
                            }
                            if (fr === 'ST') {
                                $('#CboSTATUS').val($("#TxtSTATUS").val());
                                $('#CboSTATUS').focus();
                            }
                        }
                        
                    }
                ).error(function(xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    alert("Please inform to Administrator for this error (MNU208-CUMGRRLNO)\n" + err.Message);
                  });
            }
            
            function funChgSTATUS() {
                var v = fnGetText("CboCSID");
                if (v === "") return;
                if (($('#CboSTATUS').val() === "A") && ($("#TxtSTATUS").val() !== "A")) {
                    funCheckUsrLmt(v, 'ST');
                }
            }
            
            function funChangeCSID() {
                var v = fnGetText("CboCSID");
                if (v === "") return;
                funCheckUsrLmt(v, 'CS');
                funCheckWLST(v);
            }
            
            function funCboWLSTALOW(fr) {
                if ($("#CboWLSTALOW").val() === "A") {
                    $("#TxtNOWLST").removeAttr("readonly");
                    //funCheckWLST($("#CboCSID").val());
                } 
                else {
                    $("#TxtNOWLST").val("");
                    $("#TxtNOWLST").attr("readonly", "readonly");
                    if ((fnGetText("TxtSAVEOPT")==="UPD") && (fr==='CW')) {
                        alert("WARNING !...\nAll the watch list will be revoked.");
                    }
                }
            }
            
            function funAdd()  {
                $("#FrmCLUsers").trigger('reset');
                fnSetText("TxtSAVEOPT", "NEW");
                $('#CboCSID').change(function() {
                    funChangeCSID();
                });
                fnSetText("TxtCUID", "0");
                fnSetText("TxtCUIDSNO", "0");
                fnSetText("TxtNOWLST", "0");
                funCboWLSTALOW();
                $('#CboCSID').prop("disabled", false);
                $('#TxtLOGINID').prop('readonly', false);
                $("#CboWLSTALOW").prop("disabled", false);
                $( "#dataLayer" ).dialog( "open" );
            }
            
            function funUpdate(uid)  {
                $("#FrmCLUsers").trigger('reset');
                //alert((tfUsers.GetTableData()[rowidx]).toString());
                fnSetText("TxtSAVEOPT", "UPD");
                $('#TxtLOGINID').prop('readonly', true);
                $('#TxtCUID').val(uid);
                // fetch the data from db
                $.get("AjaxActions?req=GETCUIDDTL&id="+uid,
                    function(responseText) { 
                        if (responseText !== "{}") {
                            funSetJSONVal(responseText);
                            $( "#dataLayer" ).dialog( "open" );
                            $('#TxtLOGINID').focus();
                        }
                    })
                    .error(function(xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert("Please inform to Administrator for this error (MNU208)\n" + err.Message);
                    });
            }
            
            function funValidLoginID() {
                if ($("#TxtSAVEOPT").val()==="UPD") return true;
                //alert("ok");
                if (!fnValidate("TxtLOGINID", "Login ID", 5)) return false;
                var lid = $('#TxtLOGINID').val();
                //if (funValidateLoginID(lid)) {
                //    alert("Please enter the valid login ID.");
                //    return false;
                //}
                //Someone already has that username. Try another?
                $.get("AjaxActions?req=CHKVLID&LID="+lid,
                    function(responseText) { 
                        if (responseText !== "0") {
                           alert("Someone already has that username. Try another?");
                           $('#TxtLOGINID').focus();
                        }
                    })
                    .error(function(xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert("Please inform to Administrator for this error (MNU205-MgrCStatus)\n" + err.Message);
                    });
            }
            
            function funValidateLoginID(pval) {
                var numaric = pval;
                var alphaa0 = numaric.charAt(0);
                var hh0 = alphaa.charCodeAt(0);
                if (!((hh > 64 && hh<91) || (hh > 96 && hh<123))) {
                    return false;
                }

                for(var j=1; j<numaric.length; j++)
                {
                      var alphaa = numaric.charAt(j);
                      var hh = alphaa.charCodeAt(0);
                      if((hh > 47 && hh<58) || (hh > 64 && hh<91) || (hh > 96 && hh<123))
                      {
                      }
                      else{
                         return false;
                      }
                }
                return true;
            }

            function funIsValid(){
                if (fnGetText("TxtSAVEOPT")==="NEW") {
                    if (!fnValidate("CboCSID", "Subscriber")) return false;
                    if (fnGetText("TxtCUPWD") === "") funRandPwd();
                }
                if (!fnValidate("TxtCUNAME", "User Name", 5)) return false;
                //if (!fnValidate("TxtLOGINID", "Login ID", 5)) return false;
                if (!fnValidate("TxtCUEMAIL", "Email ID", 5)) return false;
                if (!fnValidateEmail("TxtCUEMAIL", "Email ID", 5)) return false;
                //if (!fnValidate("TxtCUPHNO", "Phone Number", 5)) return false;
                $("#CboWLSTALOW").prop("disabled", false);
                return true;
            }
            
            function funSave(){
                //if (!funIsValid()) { return; };
                fnShowLayer("waitLayer");
                $('#CboCSID').prop("disabled", false);
                document.forms["FrmCLUsers"].action = "Actions?req=Save208&CSID="+$('#CboMCSID').val();
                document.forms["FrmCLUsers"].submit();
            }
            
            function funInActive(pid) {
                fnSetText("TxtCUID", pid);
                $("#dialog-ina-confirm" ).dialog( "open" );
            }
            
            function funRemove(pid) {
                fnSetText("TxtCUID", pid);
                $("#dialog-del-confirm" ).dialog( "open" );
            }
            
            function funUnLock(pid) {
                //var uanme = $("#TxtCUNAME").val();
                var cn = confirm("Do you still want to continue to unlock this user? (press OK) ", "Ok", "Cancel");
                if (!cn) {
                    return false;
                }
                
                $.get("AjaxActions?req=CUUNLOCK&id="+pid,
                    function(responseText) { 
                        if (responseText !== "0") {
                           alert("Unlocked sucessfully. Please inform to login with old password.");
                           location.reload();
                        }
                    })
                    .error(function(xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert("Please inform to Administrator for this error (MNU205-UNLOCK)\n" + err.Message);
                    });
            }
            
            function funResetPWD(pid) {
                fnShowLayer("waitLayer");
                $("#TxtSAVEOPT").val("PWR");
                $("#TxtCUID").val(pid);
                funRandPwd();
                document.forms["FrmCLUsers"].action = "Actions?req=Save208&CSID="+$('#CboMCSID').val();
                document.forms["FrmCLUsers"].submit();
            }
            
            function funRandPwd()
            {
                var text = "";
                // first char
                var possible = "ABCDEFGHIJKLMNPQRSTUVWXYZ";
                text += possible.charAt(Math.floor(Math.random() * possible.length));
                // Second char
                var possible = "abcdefghijklmnpqrstuvwxyz";
                text += possible.charAt(Math.floor(Math.random() * possible.length));
                // next 4 char
                possible = "ABCDEFGHIJKLMNPQRSTUVWXYZabcdefghijklmnpqrstuvwxyz";
                for( var i=0; i < 4; i++ )
                    text += possible.charAt(Math.floor(Math.random() * possible.length));
                // next 4 char
                possible = "123456789";
                for( var i=0; i < 4; i++ )
                    text += possible.charAt(Math.floor(Math.random() * possible.length));
                //return text;
                fnSetText("TxtCUPWD", text);
            }
            
        </script>
        
        <!-- confirmation dialogs -->
        <div id="dialog-del-confirm" title="Delete this user?">
            <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
                This user will be deleted and cannot be recovered.<BR>Do you still want to continue?</p>
        </div>
        <div id="dialog-ina-confirm" title="Disable this user?">
            <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
                This user access will be revoked.<BR>Do you still want to continue?</p>
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
               
                // for delete/close confirmation dialog
                $( "#dialog-del-confirm" ).dialog({
                    modal: true, autoOpen: false, resizable: false,
                    height:'auto', width:'auto',
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
                $( "#dialog-ina-confirm" ).dialog({
                    modal: true, autoOpen: false, resizable: false,
                    height:'auto', width:'auto',
                    buttons: {
                        "Disable": function() {
                            $( this ).dialog( "close" );
                            fnSetText("TxtSAVEOPT", "INA");
                            fnSetText("TxtSTATUS", "I");
                            funSave();
                        },
                        Cancel: function() {
                            $( this ).dialog( "close" );
                        }
                    }
                });
                
                // for delete/close confirmation dialog
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
                
                $('#CboMCSID').change(function() {
                    funChangeMCSID();
                });
                
                fnFillCombo("CboCSID", params, "CL", "S");
                fnFillCombo("CboMCSID", params, "CL", "S");
            });
        </script>
        <!-- Alert (message) -->
        <%out.print(AppUtils.printMessage(request));%>
    </body>
</html>
