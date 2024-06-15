<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>glScanDB - Subscription Manger - sub</title>
        
    </head>
    <body>
        <table style="width: 97%">
            <tr>
                <td>
                    <form name="FrmCUnit" id="FrmCUnit" method="post">
                        Unit Name 
                        <input type=text id="TxtUNAME" name="TxtUNAME" value="">
                        <img src="images/wspacer.jpg" hspace="4" alt=' '>
                        <input type="button" id="btnSave" name="btnSave" value="Add" onclick="funSaveData()">
                        <input type=hidden id="TxtUCSID" name="TxtUCSID" value="0">
                        <input type=hidden id="TxtCSUID" name="TxtCSUID" value="0">
                        <input type=hidden id="TxtCUSAVEOPT" name="TxtCUSAVEOPT" value="NEW">
                    </form>
                </td>
            </tr>
            <tr><td>
                <%@ include file="includes/tblConMgrUnit.inc" %>
                </td></tr>
        </table>
        <!-- confirmation dialogs -->
        <div id="dialog-Rpt-confirm" title="Confirmation?" style="display:none">
             <p id="lblRptCnf"><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
                Do you want to update/delete the unit for the selected row item?</p>
        </div>
        
        <script type="text/javascript">
            
            function funIsValid() {
                if (!fnValidate("TxtUNAME", "Unit Name", 5)) return false;
                return true;
            }
            
            function funSaveData() {
                if (!funIsValid()) { return; };
                funUnitSave();
            }
            
            function funUnitUpdate(csuid, uname) {
                var id = $("#TxtCSID").val();
                $("#TxtCSUID").val(csuid);
                $("#TxtUNAME").val(uname);
                $("#dialog-Rpt-confirm" ).dialog( "open" );
            }
            
            function funUnitUpd() {
                $("#btnSave").val("Update");
                $("#TxtUNAME").focus();
            }
            
            function funUnitDel() {
                $("#TxtUNAME").val("");
                funUnitSave();
            }
            
            function funUnitSave() {
                //alert($("#TxtCUSAVEOPT").val());
                var formData = $("#FrmCUnit").serializeArray();
                $.ajax({
                    type: 'POST',
                    url: "AjaxActions?req=Save207CUNIT",
                    data: formData,
                    dataType: 'text',
                    async: true,
                    success: function(data, textStatus, jqXHR) 
                    {
                        if (data === "success") {
                            $("#btnSave").val("Add");
                            $("#TxtCUNAME").val("");
                            $("#TxtCUSAVEOPT").val("NEW");
                            if (tfUnitCon.HasGrid()) {
                                tfUnitCon.RemoveGrid();
                            }
                            setTimeout(funOnLoadAjaxConDtl(), 500);
                            alert("Saved Successfully.");
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) 
                    {
                        alert(textStatus);
                        window.location="logon.jsp";
                    }
                });
            }
            
            function funOnLoadAjaxConDtl() {
                var id = $("#TxtCSID").val();
                $("#TxtUCSID").val(id); 
                $.getJSON("AjaxActions?req=GETLIST207CU&id="+id , 
                    function(data) {
                        var tr = data.LISTROWS;
                        if (tr === "") {
                            tr = "<tr class=even><td colspan=4>No Record(s).</<td></tr>";
                        }
                        //alert(tr);
                        $("#tblUnitConList tbody").html(tr);
                        tfUnitCon = setFilterGrid("tblUnitConList", tblUnitConProps);
                    });
            }
            
            $(document).ready(function() {
                $( "input[type=button], button" )
                    .button()
                    .click(function( event ) {
                        event.preventDefault();
                    });
                
                // for delete/update confirmation dialog
                $( "#dialog-Rpt-confirm" ).dialog({
                    modal: true, autoOpen: false, resizable: false,
                    height:'auto', width:'auto',
                    buttons: {
                        "Update": function() {
                            $("#TxtCUSAVEOPT").val("UPD");
                            $( this ).dialog( "close" );
                            funUnitUpd();
                        },
                        "Mark as De/Active": function() {
                            $("#TxtCUSAVEOPT").val("INA");
                            $( this ).dialog( "close" );
                            funUnitDel();
                        },
                        "Delete": function() {
                            $("#TxtCUSAVEOPT").val("DEL");
                            $( this ).dialog( "close" );
                            funUnitDel();
                        },
                        "Cancel": function() {
                            $("#TxtUNAME").val("");
                            $("#btnSave").val("Add");
                            $( this ).dialog( "close" );
                        }
                    }
                });

                funOnLoadAjaxConDtl();
            });
        </script>
    </body>
</html>
