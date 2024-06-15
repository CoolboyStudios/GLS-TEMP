<%-- 
    Document   : home
    Created on : Oct 26, 2012, 5:19:34 AM
    Author     : ...
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.HashMap,java.util.ArrayList"%>
<%@page import="glscandb.AppUtils,glscandb.classes.UserCls,glscandb.classes.ParamCls"%>
<%@ include file="includes/SessionValid.inc" %>
<%
    String lType = (String)request.getSession().getAttribute("objType");
    if (lType==null) {
        request.setAttribute("msg", "There is a program error(MNU201).<br>Please convey to administator with this error code.");
        request.getRequestDispatcher("logon.jsp").forward(request, response);            
        return;
    }
    if (!lType.startsWith("mnu201")) {
        request.setAttribute("msg", "There is a program error(MNU201).<br>Please convey to administator with this error code.\n" + lType);
        request.getRequestDispatcher("logon.jsp").forward(request, response);            
        return;
    }
    String title = "";
    if (lType.endsWith("BR")) title = "Branches";
    else if (lType.endsWith("CO")) title ="Country";
    else if (lType.endsWith("NP")) title ="Newspapers";
    else if (lType.endsWith("NT")) title ="Notice Type";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>glScanDB - Params</title>
        <link type="image/icon" href="images/sysicon.gif" rel="shortcut icon"/>
        <style type="text/css">
            @import "includes/apps.css";
            @import "scripts/TableFilter/ezEditTable/ezEditTable.css";
            @import "scripts/jquery/smoothness/jquery-ui.min.css";
        </style>
        
        <script type="text/javascript" src="scripts/TableFilter/tablefilter_all.js"></script>
        <script type="text/javascript" src="scripts/TableFilter/ezEditTable/ezEditTable.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery-ui.min.js"></script>
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
                    <table style="width:70%">
                        <tr>
                            <td class="MainHeading">
                                Parameter - <%=title%>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="Right">
                                <input type="button" id="btnAdd" value="Add a Param" 
                                       onclick="javascript:funAdd();" 
                                       title="Add a new record in the Param List">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%@ include file="includes/tblParams.inc" %>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        
        <div id="dataLayer" title="Parameter - <%=title%>">
            <form name="FrmParams" id="FrmParams" method="post">
                <input type="hidden" name="TxtPTYPE" id="TxtPTYPE" value="<%out.print(lType.substring(lType.length()-2));%>">
                <input type="hidden" name="TxtPID" id="TxtPID" value="0">
                <input type="hidden" name="TxtPIDSNO" id="TxtPIDSNO" value="0">
                <input type="hidden" name="TxtSAVEOPT" id="TxtSAVEOPT" value="0">
                <table>
                    <tr>
                        <td id="lblPKEY"><%=title%> Code</td>
                        <td>
                            <input type="text" name="TxtPKEY" id="TxtPKEY"
                                   value="" maxlength="5" size="5">  
                        </td>
                    </tr>
                    <tr>
                        <td id="lblPVALUE"><%=title%> Name</td>
                        <td>
                            <input type="text" name="TxtPVALUE" id="TxtPVALUE" 
                                   value="" maxlength="50" size="30">  
                        </td>
                    </tr>
                    <tr>
                        <td>Status</td>
                        <td>
                            <SELECT name="CboSTATUS" id="CboSTATUS">
                                <option value="A">Active</option>
                                <option value="I">In-active</option>
                            </SELECT>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        
                        
        <script type="text/javascript">
            function funAdd()  {
                if (fnGetText("TxtPTYPE")==="NT") {
                    alert("Please contact system administrator to configure new bulletin type.");
                    return;
                }
                fnSetText("TxtSAVEOPT", "NEW");
                fnSetText("TxtPIDSNO", "0");
                fnSetText("TxtPKEY", "");
                fnSetText("TxtPVALUE", "");
                fnSetCbo("CboSTATUS", "A");                
                //fnShowLayer("dataLayer");
                $( "#dataLayer" ).dialog( "open" );
            }
            
            function funUpdate(rid)  {
                var rowidx = rid; //-1;
                //alert((tfParams.GetTableData()[rowidx]).toString());
                fnSetText("TxtSAVEOPT", "UPD");
                fnSetText("TxtPID", tfParams.GetDataCell(rowidx, 1));
                fnSetText("TxtPIDSNO", rowidx);
                fnSetText("TxtPKEY", tfParams.GetDataCell(rowidx, 2));
                fnSetText("TxtPVALUE", tfParams.GetDataCell(rowidx, 3));
                fnSetCbo("CboSTATUS", tfParams.GetDataCell(rowidx, 4));
                //fnShowLayer("dataLayer");
                $( "#dataLayer" ).dialog( "open" );
            }
            
            function funIsValid(){
                if (!fnValidate("TxtPKEY", "lblPKEY", 0)) return false;
                if (!fnValidate("TxtPVALUE", "lblPVALUE", 3)) return false;
                // check duplicate PARAM key, value
                if (!fnCheckDuplicateInTable(tfParams, 2, fnGetText("TxtPIDSNO"), "TxtPKEY", "lblPKEY" )) return false;
                if (!fnCheckDuplicateInTable(tfParams, 3, fnGetText("TxtPIDSNO"), "TxtPVALUE", "lblPVALUE" )) return false;
                return true;
            }
            
            function funSave(){
                if (!funIsValid()) { return; };
                fnShowLayer("waitLayer");
                document.forms["FrmParams"].action = "Actions?req=Save201";
                document.forms["FrmParams"].submit();
            }
            
            function funRemove(pid) {
                fnSetText("TxtPID", pid);
                $("#dialog-del-confirm" ).dialog( "open" );
            }            
        </script>
        
        <!-- confirmation dialogs -->
        <div id="dialog-del-confirm" title="Delete this user?">
             <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
                This <%=title%> will be deleted and cannot be recovered.<BR>Do you still want to continue?</p>
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
                            fnSetText("TxtSAVEOPT", "DEL");
                            fnSetText("TxtSTATUS", "D");
                            fnShowLayer("waitLayer");
                            document.forms["FrmParams"].action = "Actions?req=Save201";
                            document.forms["FrmParams"].submit();
                        },
                        Cancel: function() {
                            $( this ).dialog( "close" );
                        }
                    }
                });
                
                // for delete/close confirmation dialog
                $( "#dataLayer" ).dialog({
                    modal: true, autoOpen: false, resizable: false,
                    height:200, width:380,
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
                
            });
        </script>
        <!-- Alert (message) -->
        <%out.print(AppUtils.printMessage(request));%>
    </body>
</html>
