<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="glscan.classes.UserCls"%>
<%@ include file="includes/SessionValid.inc" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>glScan - Notice Search</title>
        <link type="text/css" rel="stylesheet" href="scripts/AppStyle.css">
        <link type="text/css" rel="stylesheet" href="scripts/jquery/smoothness/jquery-ui.min.css">
        <script type="text/javascript" src="scripts/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery-ui.min.js"></script>
        <script type="text/javascript" src="scripts/TableFilter/tablefilter_all.js"></script>
        <script type="text/javascript" src="scripts/AppsUtil.js"></script>
        <script type="text/javascript">
            var wTimer;
            wTimer = setInterval(function () {fnCheckPageFullyLoaded('waitLayer', wTimer);}, 500);
        </script>
    </head>
    <body>
        <div class="DivBody">
            <table style="width: 95%">
                <tr>
                    <td>
                        <table style="width: 95%">
                            <tr>
                                <td class="pgTitle" style="width:30%">Notice Search</td>
                                <td class="center"  style="width:45%">&nbsp;</td>
                                <td class="pgTitle right" style="width:25%">البحث عن الإشعار</td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr><td>&nbsp;</td></tr>
                <!--tr>
                    <td class="lables"><b>Note:</b></td>
                </tr>
                <tr><td>&nbsp;</td></tr-->
                <tr>
                    <td>
                        <form name="FrmSEARCH" id="FrmSEARCH" method="post">
                            <table style="width: 95%">
                                <tr>
                                    <td class="lables" style="width:30%">Name of Individual/Entity</td>
                                    <td class="center"  style="width:40%">
                                        <input class="lablesAR" type="text" dir="rtl"
                                            id="TxtNAME" name="TxtNAME" maxlength="250"
                                            style="width:95%"></td>
                                    <td class="lablesAR right" style="width:30%">إسم الشخص/الشركة</td>
                                </tr>
                                <tr>
                                    <td class="lables">Trade License/Passport/Case No.</td>
                                    <td class="center">
                                        <input class="lablesAR" type="text" dir="rtl"
                                            id="TxtPPTL" name="TxtPPTL" maxlength="25"
                                            style="width:95%">
                                    </td>
                                    <td class="lablesAR right">رقم الرخصة التجارية/جواز السفر/البلاغ</td>
                                </tr>
                                <tr>
                                    <td class="lables">Search Literal String</td>
                                    <td class="center">
                                        <input class="lablesAR" type="text" dir="rtl"
                                            id="TxtSEARCH" name="TxtSEARCH" maxlength="250"
                                            style="width:95%">
                                    </td>
                                    <td class="lablesAR right">البحث الحرفي</td>
                                </tr>
                                <tbody id="tblMOREROWS">
                                    <tr>
                                        <td class="lables">Type of Notice/Advertisement</td>
                                        <td class="center">
                                            <select class="lablesAR" dir="rtl"
                                                id="CboNTID" name="CboNTID" 
                                                style="width:95%">
                                                <option></option>
                                            </select>
                                        </td>
                                        <td class="lablesAR right">نوع الإشعار/الإعلان</td>
                                    </tr>
                                    <tr>
                                        <td class="lables">Newspaper</td>
                                        <td class="center">
                                            <select class="lablesAR" dir="rtl"
                                                id="CboNPID" name="CboNPID"
                                                style="width:95%">
                                                <option></option>
                                            </select>
                                        </td>
                                        <td class="lablesAR right">الصحيفة</td>
                                    </tr>
                                    <tr> <!--style="display: none "-->
                                        <td class="lables">Date of Publication</td>
                                        <td class="center">
                                            <table class="center">
                                                <tr>
                                                <td class="lables">From</td>
                                                <td>
                                                    <input class="lablesAR" type="text" dir="rtl"
                                                        id="TxtDTRELF" name="TxtDTRELF" readonly size="9">
                                                </td>
                                                <td class="lablesAR">من</td>
                                                <td>&nbsp;</td>
                                                <td class="lables">To</td>
                                                <td>
                                                    <input class="lablesAR" type="text" dir="rtl"
                                                        id="TxtDTRELT" name="TxtDTRELT" readonly size="9">
                                                </td>
                                                <td class="lablesAR">إلى</td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="lablesAR right">تاريخ النشر</td>
                                    </tr>
                                </tbody>
                                <tr>
                                    <td></td>
                                    <td class="center">
                                        <input type="button" id="btnSearch" value="Search - بحث" 
                                            onclick="funSearch()" 
                                            title="Search Notice">
                                        <img src="images/wspacer.jpg" hspace="4" alt=' '>
                                        <input type="button" id="btnReset" value="Clear - حذف" 
                                            onclick="funReset()" 
                                            title="Reset">
                                        <input type="hidden" id="TxtNID" name="TxtNID" value="0">
                                    </td>
                                    <td></td>
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
                    <td class="error">
                        <%
                            Object obj = request.getAttribute("msg");
                            if (obj != null) {
                                out.print(obj.toString());
                            }
                            request.setAttribute("msg", null);
                        %>
                </tr>
            </table>
        </div>
        <!-- confirmation dialogs -->
        <div id="dialog-Rpt-confirm" title="Confirmation?">
             <p id="lblRptCnf"><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
                Do you want to generate the Notice report for the selected row item?</p>
        </div>
        <%@ include file="includes/allpage.inc" %>
        <div id="LastElement"></div>
    
    <script type="text/javascript">
        function funReport(param) {
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
            //alert("ok:-"+$("#TxtNID").val());
            var formData = $("#FrmSEARCH").serializeArray();
            var url = "ajax?req=NSRPTPRN";
            
            $.ajax({type: 'POST', url: url, data: formData,
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
        
        function funACall() {
            var formData = $("#FrmSEARCH").serializeArray();
            var url = "ajax?req=NSRCHOLST";
            
            $.ajax({type: 'POST', url: url, data: formData,
                dataType: 'text', async: false,
                success: function(data, textStatus, jqXHR) {
                    $("#idSRRows").html("Search Result is "+data +" record(s).");
					//document.getElementById('jasper').src = 'frmSrcList.jsp';
					// replace the above code due to not refresh
					if ($("#jasper").attr("src") === "") {
						$("#jasper").attr("src", "frmSrcList.jsp");
					} 
                                        else {
						$('#jasper')[0].contentWindow.location.reload(true);
					}
                    $("#divNSRCHList").dialog('open');
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
            setTimeout(function() {funACall();}, 10);;
        }
        
        function funReset() {
            //$('#btnSearch').prop('disabled', false);
            $('#FrmSEARCH').trigger('reset');
            $( "#TxtDTRELF" ).datepicker( "option", "minDate", "01-01-2012" );
            $( "#TxtDTRELF" ).datepicker( "option", "maxDate", "-0d" );
            //$( "#TxtDTRELF" ).datepicker( "setDate", new Date().getDate()-(365*3));
            $( "#TxtDTRELT" ).datepicker( "option", "minDate", "01-01-2012" );
            $( "#TxtDTRELT" ).datepicker( "option", "maxDate", "-0d" );
            //$("#divNSRCHList").hide();
        }
        
        function funLoadParams() {
            $.get("ajax?req=NSRCHPARAM",
                function(responseText) {
                    var obj = JSON.parse(responseText); 
                    var ppts = new Array(); 
                    var i=0;
                    for(var x in obj){ 
                        ppts[i++] = obj[x]; 
                    };
                    fnClearCbo("CboNPID");
                    fnClearCbo("CboNTID");
                    fnFillCombo("CboNPID", ppts, "NP", "UAS");
                    fnFillCombo("CboNTID", ppts, "NT", "UAS");
                    fnShowSubPage('a2ed');
                }
            ).error(function(xhr, status, error) {
                var err = eval("(" + xhr.responseText + ")");
                alert("Please inform to Administrator for this error (NSRCHPARAM)\n" + err.Message);
              });
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
                    "Yes": function() {
                        $( this ).dialog( "close" );
                        funGReport();
                    },
                    "No": function() {
                        $( this ).dialog( "close" );
                    }
                }
            });
            $( "#divNSRCHList" ).dialog({
                modal: true, autoOpen: false, resizable: false,
                height:'410', width:'910'
            });
            
            
            $.datepicker.setDefaults({
                dateFormat: "dd-mm-yy", isRTL: true,
                showButtonPanel: true, closeText: "Close",
                numberOfMonths: 1, changeMonth: true,
                constrainInput: true, buttonImageOnly: false});     
            $("#TxtDTRELF").datepicker({
                changeMonth: true,
                changeYear: true,
                numberOfMonths: 1, maxDate:"0d", minDate:"01-01-2012",
                onClose: function( selectedDate ) {
                    if (selectedDate !== "") {
                        $( "#TxtDTRELT" ).datepicker( "option", "minDate", selectedDate );
                    }
                }
            });
            $("#TxtDTRELT").datepicker({
                changeMonth: true,
                changeYear: true,
                numberOfMonths: 1, maxDate:"0d", minDate:"01-01-2012",
                onClose: function( selectedDate ) {
                    if (selectedDate !== "") {
                        $( "#TxtDTRELF" ).datepicker( "option", "maxDate", selectedDate );
                    }   
                }
            });
            $("#divNSRCHList").hide();
            funLoadParams();

        });
    </script>
    </body>
</html>
