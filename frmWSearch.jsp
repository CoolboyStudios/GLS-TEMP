<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="glscan.classes.UserCls"%>
<%@ include file="includes/SessionValid.inc" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>glScan - Watch List</title>
        <link type="text/css" rel="stylesheet" href="scripts/AppStyle.css">
        <link type="text/css" rel="stylesheet" href="scripts/jquery/smoothness/jquery-ui.min.css">
        <script type="text/javascript" src="scripts/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery-ui.min.js"></script>
        <script type="text/javascript" src="scripts/TableFilter/tablefilter_all.js"></script>
        <script type="text/javascript" src="scripts/AppsUtil.js"></script>
        <script type="text/javascript">
            var wTimer;
            wTimer = self.setInterval(function () {fnCheckPageFullyLoaded('waitLayer', wTimer);}, 500);
        </script>
    </head>
    <body>
        <div class="DivBody">
            <table style="width: 95%">
                <tr>
                    <td>
                        <table style="width: 95%">
                            <tr>
                                <td class="pgTitle" style="width:30%">Watch List</td>
                                <td class="center"  style="width:45%">&nbsp;</td>
                                <td class="pgTitle right" style="width:25%"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr><td>&nbsp;</td></tr>
                <tr>
                    <td>
                        <form name="FrmWSEARCH" id="FrmWSEARCH" method="post">
                            <table style="width: 95%">
                                <tr>
                                    <td class="lables">Subscriber Ref. No.</td>
                                    <td class="center">
                                        <input class="lablesAR" type="text" dir="rtl"
                                            id="TxtREFNO" name="TxtREFNO" maxlength="25"
                                            style="width:95%">
                                    </td>
                                    <td class="lablesAR right">الرقم المرجعي للمشترك</td>
                                </tr>
                                <tr>
                                    <td class="lables" style="width:30%">Name of Individual/Entity</td>
                                    <td class="center"  style="width:40%">
                                        <input class="lablesAR" type="text" dir="rtl"
                                            id="TxtANAME" name="TxtANAME" maxlength="25"
                                            style="width:95%"></td>
                                    <td class="lablesAR right" style="width:30%">إسم الشخص/الشركة</td>
                                </tr>
                                <tr>
                                    <td class="lables">Trade License/Passport/Case No.</td>
                                    <td class="center">
                                        <input class="lablesAR" type="text" dir="rtl"
                                            id="TxtPPTLNO" name="TxtPPTLNO" maxlength="25"
                                            style="width:95%">
                                    </td>
                                    <td class="lablesAR right">رقم الرخصة التجارية/جواز السفر/البلاغ</td>
                                </tr>
                                <tr>
                                    <td class="lables">Status</td>
                                    <td class="center">
                                        <SELECT name="CboSTATUS" id="CboSTATUS">
                                            <option value="A" selected>Active - فعال</option>
                                            <option value="I">Inactive - غير فعال</option>
                                        </SELECT>
                                    </td>
                                    <td class="lablesAR right">الحالة</td>
                                </tr>
                                <tr><td colspan="3" >&nbsp;</td></tr>
                                <tr>
                                    <td colspan="3" class="center">
                                        <input type="button" id="btnSearch" value="Search - بحث" 
                                            onclick="javascript:funSearch();" 
                                            title="Search Notice">
                                        <img src="images/wspacer.jpg" hspace="4" alt=' '>
                                        <input type="button" id="btnReset" value="Clear - حذف" 
                                            onclick="javascript:funReset();" 
                                            title="Reset">
                                        <img src="images/wspacer.jpg" hspace="4" alt=' '>
                                        <input type="button" id="btnAdd" value="Add - اضافة" 
                                            onclick="javascript:funAddWItem();" 
                                            title="Add new watch Item">
                                        <input type="hidden" id="TxtNID" name="TxtNID" value="0">
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </td>
                </tr>
                <tr><td>&nbsp;</td></tr>
                <tr>
                    <td>
                        <div id="divNSRCHList" title="Search Result">
                            <div id="idSRRows" class="error" style="width:100%"></div>
                            <iframe name="jasper" id="jasper" src="" frameborder="0" scrolling="no"
                                    style="width: 100%;height:350px;overflow:hidden;background-color: #ffffff;"></iframe>
                            
                        </div>
                    </td>
                </tr>
                <tr><td>&nbsp;</td></tr>
                <tr>
                    </td>
                    <td class="error">
                        <%
                            Object obj = request.getAttribute("msg");
                            if (obj != null) {
                                out.print(obj.toString());
                            }
                            request.setAttribute("msg", null);
                        %>
                </tr>
                <tr><td>&nbsp;</td></tr>
                <tr>
                    <td>
                        <div id="divNWLIList" title="Watch list Notices">
                            <div id="idWLRows" class="error" style="width:100%"></div>
                            <iframe name="jasperWL" id="jasperWL" src="" frameborder="0" scrolling="no"
                                    style="width: 100%;height:350px;overflow:hidden;background-color: #ffffff;"></iframe>
                            
                        </div>
                    </td>
                </tr>
                <tr><td>&nbsp;</td></tr>
            </table>
        </div>
        
                
        <!-- Watch - dialogs -->
        <div id="dialog-Watch" title="Watch Item">
            <form name="FrmWLEDIT" id="FrmWLEDIT" method="post">
                <input type="hidden" id="TxtCWID" name="TxtCWID" value="0">
                <input type="hidden" id="TxtCSID" name="TxtCSID" value="<%out.print(user.getCSID());%>">
                <input type="hidden" id="TxtCUID" name="TxtCUID" value="<%out.print(user.getCUID());%>">
                <input type="hidden" name="TxtSTATUS" id="TxtSTATUS" value="0">
                <input type="hidden" name="TxtWLSAVEOPT" id="TxtWLSAVEOPT" value="0">
                <input type="hidden" id="TxtWLENOTE" name="TxtWLENOTE" value="">
                <table>
                    <tr>
                        <td class="lables">Subscriber Ref. No.</td>
                        <td class="center">
                            <input class="lablesAR" type="text" dir="rtl"
                                 id="TxtWLEREFNO" name="TxtWLEREFNO" maxlength="25"
                                style="width:95%">
                        </td>
                        <td class="lablesAR right">الرقم المرجعي للمشترك</td>
                    </tr>
                    <tr>
                        <td class="lables" style="width:30%">Name of Individual/Entity</td>
                        <td class="center"  style="width:40%">
                            <input class="lablesAR" type="text" dir="rtl"
                                id="TxtWLEANAME" name="TxtWLEANAME" maxlength="150"
                                style="width:95%"></td>
                            
                        <td class="lablesAR right" style="width:30%">إسم الشخص/الشركة</td>
                    </tr>
                    <tr>
                        <td class="lables">Trade License/Passport/Case No.</td>
                        <td class="center">
                            <input class="lablesAR" type="text" dir="rtl"
                                id="TxtWLEPPTLNO" name="TxtWLEPPTLNO" maxlength="150"
                                style="width:95%">
                        </td>
                        <td class="lablesAR right">رقم الرخصة التجارية/جواز السفر/البلاغ</td>
                    </tr>
                    <!--tr>
                        <td class="lables">Remarks</td>
                        <td class="center">
                            <input class="lablesAR" type="text" dir="rtl"
                                 id="TxtWLENOTE" name="TxtWLENOTE" maxlength="250"
                                style="width:95%">
                        </td>
                        <td class="lablesAR right">ملاحظات</td>
                    </tr-->
                    <tr>
                        <td class="lables">Status</td>
                        <td class="center">
                            <SELECT name="CboWLSTATUS" id="CboWLSTATUS" onchange="funChgSTATUS()">
                                <option value="A">Active - فعال</option>
                                <option value="I">Inactive - غير فعال</option>
                                <option value="D">Remove - ازالة</option>
                            </SELECT>
                        </td>
                        <td class="lablesAR right">الحالة</td>
                    </tr>
                </table>
            </form>
        </div>
        <!-- confirmation dialogs -->
        <div id="dialog-Rpt-confirm" title="Confirmation?">
             <p id="lblRptCnf"><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
                Do you want to generate the Notice report for the selected row item or mark as mismatch?</p>
        </div>
        <%@ include file="includes/allpage.inc" %>
        <div id="LastElement"></div>
    </body>
    <script type="text/javascript">
        
        function funReport(param) {
            //alert(param);
            $("#TxtNID").val(param);
            $.get("ajax?req=NRPTBALNO",
                function(responseText) { 
                    //fnHideLayer("waitLayer");
                    var bal = parseInt(responseText);
                    if (bal <= 0) {
                      alert("Sorry, Report limit reached.");  
                    } 
                    else if (bal <= 10) {
                       //alert("Report limit nearing. " + bal + " more entries allowed.");  
                       $("#lblRptCnf").prepend("Report limit nearing. " + bal + " more reports allowed.<br><br>");
                       $("#dialog-Rpt-confirm" ).dialog( "open" );
                    } 
                    else {
                        $("#dialog-Rpt-confirm" ).dialog( "open" );
                    }
                }
            ).error(function(xhr, status, error) {
                var err = eval("(" + xhr.responseText + ")");
                alert("Please inform to Administrator for this error (NRPTBALNO)\n" + err.Message);
            });
        }
        
        function funGReport() {
            fnShowLayer("waitLayer");
            //alert("ok:-"+$("#TxtCWID").val());
            var p = "NID=" + $("#TxtNID").val(); //$("#FrmWSEARCH").serializeArray();
            p = p + "&CWID=" + $("#TxtCWID").val();
            //alert(p);
            var url = "ajax?req=NCWLIPRN&" + p;
            
            $.ajax({type: 'POST', url: url, 
                dataType: 'text', async: false,
                success: function(data, textStatus, jqXHR) {
                    //alert(data);
                    $('#spIframe').css('width', '700px');
                    $('#spIframe').css('height', '500px');
                    $('#spIframe').attr('src', 'reports?t=pdf&RPT=NSRPTPRN&RPTNO='+data);
                    $('#dialogSubPage').dialog('option', 'title', 'Notice Report');
                    fnHideLayer("waitLayer");
                    $('#dialogSubPage').dialog('open');
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    alert( "Request failed: " + textStatus );
                    fnHideLayer("waitLayer");
                }
            });
        }
        
        function funMarkUMatch() {
            fnShowLayer("waitLayer");
            //alert("ok:-"+$("#TxtCWID").val());
            var p = "NID=" + $("#TxtNID").val(); //$("#FrmWSEARCH").serializeArray();
            p = p + "&CWID=" + $("#TxtCWID").val();
            //alert(p);
            var url = "ajax?req=WLNMISMAT&" + p;
            
            $.ajax({type: 'POST', url: url, 
                dataType: 'text', async: false,
                success: function(data, textStatus, jqXHR) {
                    if (data === "success") {
                        alert("Marked Successfully as mismatch.");
                    }
                    fnHideLayer("waitLayer");
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    alert( "Request failed (WLNMISMAT): " + textStatus );
                    fnHideLayer("waitLayer");
                }
            });
        }
        
        function funListWLN(pcwid) {
            $("#TxtCWID").val(pcwid);
            var url = "ajax?req=NCWLIOLST&CWID="+pcwid;
            
            $.ajax({type: 'POST', url: url, 
                dataType: 'text', async: false,
                success: function(data, textStatus, jqXHR) {
                    $("#idWLRows").html("Result is "+data +" record(s).");
                    //document.getElementById('jasper').src = 'frmSrcList.jsp';
                    // replace the above code due to not refresh
                    if ($("#jasperWL").attr("src") === "") {
                            $("#jasperWL").attr("src", "frmSrcList.jsp");
                    } 
                    else {
                            $('#jasperWL')[0].contentWindow.location.reload(true);
                    }
                    $("#divNWLIList").dialog('open');
                    fnHideLayer("waitLayer");
                    //$('#btnSearch').prop('disabled', true);
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    alert( " Request failed (NCWLIOLST): " + textStatus );
                    fnHideLayer("waitLayer");
                }
            });
        }
        
        function funWLUpdate(param, arr) {
            $("#FrmWLEDIT").trigger('reset');
            //alert(arr[1].substr(0,1));
            $("#TxtCWID").val(param);
            fnSetText("TxtWLSAVEOPT", "UPD");
            fnSetCbo('CboWLSTATUS' , arr[1].substr(0,1));
            $("#TxtSTATUS").val(arr[1].substr(0,1));
            $("#TxtWLEPPTLNO").val(arr[3]);
            $("#TxtWLEANAME").val(arr[4]);
            $("#TxtWLEREFNO").val(arr[5]);
            $('#dialog-Watch').dialog('open');
        }
        
        function funACall() {
            var formData = $("#FrmWSEARCH").serializeArray();
            var url = "ajax?req=WSRCHLST";
            $.ajax({type: 'POST', url: url, data: formData,
                dataType: 'text', async: false,
                success: function(data, textStatus, jqXHR) {
                    $("#idSRRows").html("Search Result is "+data +" record(s).");
					//document.getElementById('jasper').src = 'frmWSrcList.jsp';
					// replace the above code due to not refresh
					if ($("#jasper").attr("src") === "") {
						$("#jasper").attr("src", "frmWSrcList.jsp");
					} 
                                        else {
						$('#jasper')[0].contentWindow.location.reload(true);
					}
                    //$("#divNSRCHList").dialog('open');
                    fnHideLayer("waitLayer");
                    //$('#btnSearch').prop('disabled', true);
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    alert( "Request failed: " + textStatus );
                    fnHideLayer("waitLayer");
                }
            });
        }
        
        function funSearch() {
            fnShowLayer("waitLayer");
            setTimeout(function() {funACall();}, 10);
        }
        
        function funReset() {
            //$('#btnSearch').prop('disabled', false);
            $('#FrmWSEARCH').trigger('reset');
            $( "#TxtDTRELF" ).datepicker( "option", "minDate", "01-01-2012" );
            $( "#TxtDTRELF" ).datepicker( "option", "maxDate", "-0d" );
            $( "#TxtDTRELT" ).datepicker( "option", "minDate", "01-01-2012" );
            $( "#TxtDTRELT" ).datepicker( "option", "maxDate", "-0d" );
            //$("#divNSRCHList").hide();
        }
        
        function funOpenWItemDiv() {
            $("#FrmWLEDIT").trigger('reset');
            fnSetText("TxtWLSAVEOPT", "NEW");
            fnSetText("TxtCWID", "0");
            $('#dialog-Watch').dialog('open');
        }
        
        function funAddWItem(){
            var v = fnGetText("TxtCUID");
            if (v === "") return;
            $.get("ajax?req=WLADDBALNO&CUID="+v,
                function(responseText) { 
                    //fnHideLayer("waitLayer");
                    var bal = parseInt(responseText);
                    if (bal === 0) {
                      alert("Sorry, Watch list limit reached.");  
                    } 
                    else if (bal <= 5) {
                       alert("Watch list limit nearing. " + bal + " more entries allowed.");  
                       funOpenWItemDiv();
                    } 
                    else {
                        funOpenWItemDiv();
                    }
                }
            ).error(function(xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    alert("Please inform to Administrator for this error (WLADDBALNO)\n" + err.Message);
                  });
        }
        
        function funIsValidWLI() {
            if (($("#TxtWLEREFNO").val()==="") ) {
                alert("Please provide the Subscriber Ref. number for watch list.");
                return false;
            }
            if (($("#TxtWLEREFNO").val().length <= 3) && ($("#TxtWLEREFNO").val()!=="")) {
                alert("Please provide the valide Subscriber Ref. number for watch list. (min length is 5 char)");
                return false;
            }
            if (($("#TxtWLEPPTLNO").val()==="") && ($("#TxtWLEANAME").val()==="")) {
                alert("Please provide name or TL/PP/Case number to add the watch list.");
                return false;
            }
            if (($("#TxtWLEANAME").val().length <= 5) && ($("#TxtWLEANAME").val()!=="")) {
                alert("Please provide the valide name for watch list. (min length is 5 char)");
                return false;
            }
            if (($("#TxtWLEPPTLNO").val().length <= 5) && ($("#TxtWLEPPTLNO").val()!=="")) {
                alert("Please provide the valide TL/PP/Case no for watch list. (min length is 5 char)");
                return false;
            }
            /*if ($("#TxtWLENOTE").val().length > 235) {
                alert("Sorry, your exceed the max length of 250 char. Please reduce the remarks.");
                return false;
            }*/
            return true;
        }
        
        function funSaveWItems(){
            fnShowLayer("waitLayer");
            setTimeout(function() {funSaveWItem();}, 10);
        }
        
        function funSaveWItem() {
            //alert("Ok-save");
            //return;
            var formData = $("#FrmWLEDIT").serializeArray();
            var url = "ajax?req=WLSTSAVE";
            
            $.ajax({type: 'POST', url: url, data: formData,
                dataType: 'text', async: false,
                success: function(data, textStatus, jqXHR) {
                    fnHideLayer("waitLayer");
                    funSearch();
                    alert( "Record saved Successfully.");
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    alert( "Request failed: " + textStatus );
                    fnHideLayer("waitLayer");
                }
            });
        }
        
        function funChgSTATUS() {
            if (($("#TxtSTATUS").val() === "A")) {
                var cn = confirm("Do you still want to continue to mark as 'Inactive/Remove' this record? (press OK) ", "Ok", "Cancel");
                if (!cn) {
                    $('#CboWLSTATUS').val("A");
                    return false;
                }
            } 
            
            if (($("#TxtSTATUS").val() !== "A") && ($('#CboWLSTATUS').val() === "A")) {
                $.get("ajax?req=WLADDBALNO&CUID="+$("#TxtCUID").val(),
                    function(responseText) { 
                        //fnHideLayer("waitLayer");
                        var bal = parseInt(responseText);
                        if (bal === 0) {
                          alert("Sorry, Watch list limit reached.");  
                          fnSetCbo('CboWLSTATUS' , $("#TxtSTATUS").val());
                        } 
                        else if (bal <= 5) {
                           alert("Watch list limit nearing. " + bal + " more entries allowed.");  
                        }
                    }
                ).error(function(xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert("Please inform to Administrator for this error (WLADDBALNO)\n" + err.Message);
                      });
            }
            
        }
        
        $(document).ready(function() {
            
            $( "input[type=button], button" )
                .button()
                .click(function( event ) {
                    event.preventDefault();
                });
            // for delete/close confirmation dialog
            $( "#dialog-Rpt-confirm" ).dialog({
                modal: true, autoOpen: false, resizable: false,
                height:'auto', width:'auto',
                buttons: {
                    "Generate Report": function() {
                        $( this ).dialog( "close" );
                        funGReport();
                    },
                    "Mark as mismatch": function() {
                        $( this ).dialog( "close" );
                        funMarkUMatch();
                    },                    
                    "Cancel": function() {
                        $( this ).dialog( "close" );
                    }
                }
            });
            $( "#dialog-Watch" ).dialog({
                modal: true, autoOpen: false, resizable: false,
               height:'auto', width:'auto',
                buttons: {
                    "Save": function() {
                        if (!funIsValidWLI()) return;
                        $( this ).dialog( "close" );
                        funSaveWItems();
                    },
                    "Cancel": function() {
                        $( this ).dialog( "close" );
                    }
                }
            });
            
            $( "#divNWLIList" ).dialog({
                modal: true, autoOpen: false, resizable: false,
                height:'410', width:'910'
            });
            
            //$("#divNSRCHList").hide();
            funSearch();
        });
    </script>
</html>
