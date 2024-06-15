<%-- 
    Document   : home
    Created on : Oct 26, 2012, 5:19:34 AM
    Author     : ...
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.HashMap,java.util.ArrayList"%>
<%@page import="glscandb.AppUtils,glscandb.classes.UserCls"%>
<%@ include file="includes/SessionValid.inc" %>

<%
    String lType = (String)request.getSession().getAttribute("objType");
    if (lType==null) {
        request.setAttribute("msg", "There is a program error(MNU209).<br>Please convey to administator with this error code.");
        request.getRequestDispatcher("logon.jsp").forward(request, response);            
        return;
    }
    if (!lType.startsWith("mnu209")) {
        request.setAttribute("msg", "There is a program error(MNU209).<br>Please convey to administator with this error code.\n" + lType);
        request.getRequestDispatcher("logon.jsp").forward(request, response);            
        return;
    }
    String title = "User Manager";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>glScanDB - User Manger</title>
        <link type="image/icon" href="images/sysicon.gif" rel="shortcut icon"/>
        <style type="text/css">
            @import "includes/apps.css";
            @import "scripts/TableFilter/ezEditTable/ezEditTable.css";
            @import "scripts/jquery/smoothness/jquery-ui.min.css";
            @import "scripts/jquery/smoothness/ui.dropdownchecklist.themeroller.css";
        </style>
        
        <script type="text/javascript" src="scripts/TableFilter/tablefilter_all.js"></script>
        <script type="text/javascript" src="scripts/TableFilter/ezEditTable/ezEditTable.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery-ui.min.js"></script>
        <script type="text/javascript" src="scripts/jquery/ui.dropdownchecklist-1.4-min.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery.autosize-min.js"></script>
        <script type="text/javascript" src="scripts/AppsUtil.js"></script>
        
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
                            <td class="Right">
                                <input type="button" id="btnAdd" value="Add an User" 
                                       onclick="javascript:funAdd();" 
                                       title="Add a new user in the below List">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%@ include file="includes/tblUsers.inc" %>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div id="dataLayer" title="User Details">
            <form name="FrmUsers" id="FrmUsers" method="post">
                <input type="hidden" name="TxtUID" id="TxtUID" value="0">
                <input type="hidden" name="TxtSTATUS" id="TxtSTATUS" value="0">
                <input type="hidden" name="TxtUIDSNO" id="TxtUIDSNO" value="0">
                <input type="hidden" name="TxtSAVEOPT" id="TxtSAVEOPT" value="0">
                <input type="hidden" name="TxtMULTIROLE" id="TxtMULTIROLE" value="">
                <table>
                    <tr>
                        <td id="lblLOGINID">Login ID</td>
                        <td>
                            <input type="text" name="TxtLOGINID" id="TxtLOGINID"
                                   value="" maxlength="10" size="10">  
                        </td>
                    </tr>
                    <tr>
                        <td id="lblSYSROLE">Role</td>
                        <td>
                            <select name="CboSYSROLE" id="CboSYSROLE" onchange="CboSYSROLE_Change();">
                                <option value="0">Select</option>
                            </select> <br>
                            <select name="CboMULTIROLE" id="CboMULTIROLE" multiple="multiple">
                                <option value="R">Requestor</option>
                                <option value="S">Search</option>
                                <option value="T">Translator</option>
                                <option value="V">Verifier</option>
                                <option value="G">Generator</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td id="lblSHORT">Short Name</td>
                        <td>
                            <input type="text" name="TxtSHORT" id="TxtSHORT" 
                                   value="" maxlength="10" size="10">  
                        </td>
                    </tr>
                    <tr>
                        <td id="lblUSERNAME">Full Name</td>
                        <td>
                            <input type="text" name="TxtUSERNAME" id="TxtUSERNAME" 
                                   value="" maxlength="50" size="20">  
                        </td>
                    </tr>
                    <tr>
                        <td id="lblEMAILID">E-Mail ID</td>
                        <td>
                            <input type="text" name="TxtEMAILID" id="TxtEMAILID" 
                                   value="" maxlength="50" size="20">  
                        </td>
                    </tr>
                    <tr>
                        <td id="lblBranch">Branch</td>
                        <td>
                            <select name="CboBRID" id="CboBRID"
                                    style="width:150px">
                                <option value="0">Select</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td id="lblREPTO">Line Manger</td>
                        <td>
                            <select name="CboREPTO" id="CboREPTO"
                                    style="width:150px">
                                <option value="0">Select</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Status</td>
                        <td>
                            <SELECT name="CboSTATUS" id="CboSTATUS" onchange="CboSTATUS_Change();">
                                <option value="A">Active</option>
                                <option value="I">In-active</option>
                                <option value="L">Lock</option>
                            </SELECT>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <!-- Print Param Array -->
        <% out.print(AppUtils.printParamArray(request)); %>
        
        <script type="text/javascript">
            function funAdd()  {
                fnSetText("TxtSAVEOPT", "NEW");
                fnSetText("TxtUID", "0");
                fnSetText("TxtUIDSNO", "0");
                fnSetText("TxtLOGINID", "");
                fnSetText("TxtSHORT", "");
                fnSetText("TxtUSERNAME", "");
                fnSetText("TxtEMAILID", "");
                fnSetCbo("CboSYSROLE", "V");
                fnSetCbo("CboSTATUS", "A");
                fnSetCbo("CboREPTO", "0");
                $("#CboMULTIROLE").dropdownchecklist("destroy");
                fnSetCboMulti("CboMULTIROLE", "");
                //fnShowLayer("dataLayer");
                $( "#dataLayer" ).dialog( "open" );
                funMutiCboInit();
                CboSYSROLE_Change();
            }
            
            function CboSYSROLE_Change() {
                if (($('#CboSYSROLE').val() === "A") &&
                    ($('#TxtSAVEOPT').val() === "UPD")){
                    funCheckNoAlloc("ROL");                    
                }
                if ($('#CboSYSROLE').val() === "O") {
                    $("#CboMULTIROLE").dropdownchecklist('enable');
                } else {
                    fnSetCboMulti("TxtMULTIROLE", "");
                    $("#CboMULTIROLE").dropdownchecklist('disable');
                }
            }
            
            function CboSTATUS_Change() {
                if (($('#CboSTATUS').val() === "I") &&
                    ($('#TxtSAVEOPT').val() === "UPD")) {
                    funCheckNoAlloc("INA");                    
                }
            }
            
            function funUpdate(rid)  {
                var rowidx = rid;
                //alert((tfUsers.GetTableData()[rowidx]).toString());
                fnSetText("TxtSAVEOPT", "UPD");
                fnSetText("TxtUID", tfUsers.GetDataCell(rowidx, 1));
                fnSetText("TxtUIDSNO", rowidx);
                fnSetText("TxtLOGINID", tfUsers.GetDataCell(rowidx, 2));
                fnSetText("TxtSHORT", tfUsers.GetDataCell(rowidx, 3));
                fnSetText("TxtUSERNAME", tfUsers.GetDataCell(rowidx, 4));
                fnSetCbo("CboSYSROLE", tfUsers.GetDataCell(rowidx, 5));
                fnSetCbo("CboBRID", tfUsers.GetDataCell(rowidx, 7));
                fnSetCbo("CboREPTO", tfUsers.GetDataCell(rowidx, 9));
                fnSetCbo("CboSTATUS", tfUsers.GetDataCell(rowidx, 11));
                fnSetText("TxtEMAILID", tfUsers.GetDataCell(rowidx, 13));
                fnSetText("TxtMULTIROLE", tfUsers.GetDataCell(rowidx, 14));
                
                $("#CboMULTIROLE").dropdownchecklist("destroy");
                fnSetCboMulti("CboMULTIROLE", $('#TxtMULTIROLE').val());
                //fnShowLayer("dataLayer");
                $( "#dataLayer" ).dialog( "open" );
                funMutiCboInit();
                CboSYSROLE_Change();
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
                if (!fnValidate("TxtLOGINID", "lblLOGINID", 5)) return false;
                if (!fnValidate("TxtSHORT", "lblSHORT", 3)) return false;
                // check duplicate PARAM key, value
                if (fnGetText("TxtSAVEOPT")==="NEW") {
                    if (!fnCheckDuplicateInTable(tfUsers, 2, fnGetText("TxtUIDSNO"), "TxtLOGINID", "lblLOGINID" )) return false;
                    if (!fnCheckDuplicateInTable(tfUsers, 3, fnGetText("TxtUIDSNO"), "TxtSHORT", "lblSHORT" )) return false;
                }
                if (!fnValidate("TxtUSERNAME", "lblUSERNAME", 5)) return false;
                if (!fnValidateEmail("TxtEMAILID", "lblEMAILID", 5)) return false;
                
                if ($('#CboSYSROLE').val() === "O") {
                    fnSetText("TxtMULTIROLE", $('#CboMULTIROLE').val());  
                    if (!fnValidate("CboMULTIROLE", "role", 5)) return false;
                } 
                else {
                    fnSetText("TxtMULTIROLE", "");                
                }
                return true;
            }
            
            function funSave(){
                //if (!funIsValid()) { return; };
                fnShowLayer("waitLayer");
                document.forms["FrmUsers"].action = "Actions?req=Save209";
                document.forms["FrmUsers"].submit();
            }
            
            function funRemove(pid) {
                fnSetText("TxtUID", pid);
                $("#dialog-del-confirm" ).dialog( "open" );
            }
            
            function funUnLock(pid) {
                var cn = confirm("Do you still want to continue to unlock this User? (press OK)\n\
        \n\
Note:Password will reset to defult one. ", "Ok", "Cancel");
                if (!cn) {
                    return false;
                }
                fnSetText("TxtSAVEOPT", "UUL");
                fnSetText("TxtUID", pid);
                document.forms["FrmUsers"].action = "Actions?req=Save209";
                document.forms["FrmUsers"].submit();
                return;
            }
            
            function funCheckNoAlloc(ptype) {
                $.get("AjaxActions?req=GETUSRALQTY&UID="+$("#TxtUID").val(),
                    function(responseText) { 
                        if (responseText !== "0") 
                        {
                            if (ptype==="DEL") {
                                alert("Please deallocate the pending notice before removing the user.");
                            } else if (ptype==="ROL") {
                                alert("Please deallocate the pending notice before change the role to admin.");
                                $('#CboSYSROLE').val('V');
                            } else {
                                alert("Please deallocate the pending notice before in-active the user.");
                                $('#CboSTATUS').val('A');
                            }
                        } else {
                            if (ptype==="DEL") {
                                fnSetText("TxtSAVEOPT", "DEL");
                                fnSetText("TxtSTATUS", "D");
                                funSave(); 
                            }
                        }                            
                    });
            }
            
            function funMutiCboInit() {
                $("#CboMULTIROLE").dropdownchecklist( { icon: { placement: 'right', toOpen: 'ui-icon-arrowthick-1-s'
                                            , toClose: 'ui-icon-arrowthick-1-n' }
                                            ,zIndex: 999 , maxDropHeight: 90, width: 150 }, 
                                        { textFormatFunction: function(options) {
                                                var selectedOptions = options.filter(":selected");
                                                var countOfSelected = selectedOptions.size();
                                                switch(countOfSelected) {
                                                    case 0: return "<i>Please select<i>";
                                                    case 1: return selectedOptions.text();
                                                    case options.size(): return "<b>All Role Selected</b>";
                                                    default: return countOfSelected + " Roles Selected";
                                                }
                                            } 
                                        } );
            }
            
            fnFillCombo("CboBRID", params, "BR", "");
            fnFillCombo("CboSYSROLE", params, "UR", "");
            //fnFillCombo("CboMULTIROLE", params, "MR", "");
            fnFillCombo("CboREPTO", params, "MGRUSER", "NA0");
        </script>
        
        <!-- confirmation dialogs -->
        <div id="dialog-del-confirm" title="Delete this user?">
            <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
                This user will be deleted and cannot be recovered.<BR>Do you still want to continue?</p>
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
                    height:170, width:350,
                    buttons: {
                        "Delete": function() {
                            $( this ).dialog( "close" );
                            funCheckNoAlloc("DEL");
                        },
                        Cancel: function() {
                            $( this ).dialog( "close" );
                        }
                    }
                });
                
                // for delete/close confirmation dialog
                $( "#dataLayer" ).dialog({
                    modal: true, autoOpen: true, resizable: false,
                    height:345, width:300,
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
                funMutiCboInit();
                $( "#dataLayer" ).dialog("close");
            });
        </script>
        <!-- Alert (message) -->
        <%out.print(AppUtils.printMessage(request));%>
    </body>
</html>
