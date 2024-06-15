<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.HashMap,java.util.ArrayList"%>
<%@page import="glscandb.classes.UserCls,glscandb.AppUtils,glscandb.classes.UploadCls"%>
<%@ include file="includes/SessionValid.inc" %>
<%
     String lType = (String)request.getSession().getAttribute("objType");
    if (lType==null) {
        request.setAttribute("msg", "There is a program error(MNU303).<br>Please convey to administator with this error code.");
        request.getRequestDispatcher("logon.jsp").forward(request, response);            
        return;
    }
    if (!lType.startsWith("mnu303")) {
        request.setAttribute("msg", "There is a program error(MNU303).<br>Please convey to administator with this error code.\n" + lType);
        request.getRequestDispatcher("logon.jsp").forward(request, response);            
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>glScanDB - Notice Upload</title>
        <link type="image/icon" href="images/sysicon.gif" rel="shortcut icon"/>
        <style type="text/css">
            @import "includes/apps.css";
            @import "scripts/TableFilter/ezEditTable/ezEditTable.css";
            @import "scripts/jquery/smoothness/jquery-ui.min.css";
            @import "scripts/jquery/ImgSlid/bjqs.css";
        </style>
        
        <script type="text/javascript" src="scripts/TableFilter/tablefilter_all_min.js"></script>
        <script type="text/javascript" src="scripts/TableFilter/ezEditTable/ezEditTable.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery-ui.min.js"></script>
        <script type="text/javascript" src="scripts/AppsUtil.js"></script>
        <script type="text/javascript" src="scripts/jquery/ImgSlid/bjqs-1.3.min.js"></script>
        
        <script type="text/javascript">
            var wTimer;
            wTimer = self.setInterval(function () {fnCheckPageFullyLoaded('waitLayer', wTimer);}, 1000);
        </script>
    </head>
    <body>
        <!-- Print Param Array -->
        <% out.print(AppUtils.printParamArray(request)); %>
        
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
                            <td class="MainHeading" align="center">Image Upload - صورة تحميل</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td  width="74%" valign="top">
                                            <%@ include file="includes/imgSlidList.inc" %>
                                        </td>
                                        <td width="1%">&nbsp;</td>
                                        <td style="vertical-align: text-top" width="25%" >
                                            <table style="width:auto;margin-top:0">
                                                <tr>
                                                    <td class="Right">
                                                        <select class="arabic" 
                                                            id="CboNPID" name="CboNPID"
                                                            style="width:90%">
                                                            <option></option>
                                                        </select>
                                                    </td>
                                                    <td class="arabic Right">الجريدة</td>
                                                </tr>
                                                <tr>
                                                    <td class="Right">
                                                        <select class="arabic" 
                                                            id="CboNTID" name="CboNTID"
                                                            style="width:90%" onchange="funCboNTID_Change();">
                                                            <option></option>
                                                        </select>
                                                    </td>
                                                    <td class="arabic Right">Type</td>
                                                </tr>
                                                <tr>
                                                    <td class="Right">
                                                        <input class="arabic" type="text"
                                                                id="TxtDTREL" name="TxtDTREL"
                                                                size="10">
                                                    </td>
                                                    <td class="arabic Right">التاريخ</td>
                                                </tr>
                                                <tr>
                                                    <td class="Right">
                                                        <input class="arabic" type="text"
                                                            id="TxtRELNO" name="TxtRELNO"
                                                            size="10">
                                                    </td>
                                                    <td class="arabic Right">العدد</td>
                                                </tr>
                                                <tr>
                                                    <td class="Right">
                                                        <input class="arabic" type="text"
                                                                id="TxtPGNO" name="TxtPGNO"
                                                                size="3">
                                                    </td>
                                                    <td class="arabic Right">صفحة</td>
                                                </tr>
                                                <tr>
                                                    <td class="Right">
                                                        <input type="text" size="3"
                                                               id="TxtADNO" name="TxtADNO">
                                                        <select class="arabic" 
                                                            id="CboADNO" name="CboADNO"
                                                            onchange="javascript:funCboADNO_Change();"
                                                            style="width:60%">
                                                            <option value="S">Single</option>
                                                            <option value="M">Group</option>
                                                        </select>
                                                    </td>
                                                    <td class="arabic Right">Ad Type</td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="Center" colspan="2">
                                                        <input type="button" id="btnPGUpload" value="صفحة التحميل" 
                                                            onclick="javascript:funPGUpload();" 
                                                            title="Upload Page images">
                                                        <img src="images/wspacer.jpg" class="wspace" alt="">
                                                        <input type="button" id="btnUpload" value="تحميل شريحة" 
                                                            onclick="javascript: funUpload();" 
                                                            title="Upload sliced images">
                                                        <img src="images/wspacer.jpg" class="wspace" alt="">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="Center" colspan="2">
                                                        <input type="button" id="btnList" value="قائمة" 
                                                            title="List the Uploaded images">
                                                        <img src="images/wspacer.jpg" class="wspace" alt="">
                                                        <input type="button" id="btnRemove" value="حذف" 
                                                            onclick="javascript:funRemoveImgs();" 
                                                            title="Remove the Uploaded images">
                                                        <img src="images/wspacer.jpg" class="wspace" alt="">
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                 </td>
            </tr>
        </table>    
        
        <script type="text/javascript">
            function funRemove(param) {
                if (!isValid()) return;
                var npid = fnGetText("CboNPID");
                var dtr = fnGetText("TxtDTREL");
                var pno = fnGetText("TxtPGNO");
                var dt = dtr.substr(6,4) + dtr.substr(3,2) + dtr.substr(0,2);
                var adno = 1;
                if (fnGetText("CboADNO") === "M") 
                {
                    adno = fnGetText("TxtADNO");
                }
                
                var cn = confirm("Do you still want to continue to remove this item from the list? (press OK)", "Ok", "Cancel");
                if (!cn) {
                    return false;
                }
                
                var pp = "NPID=" + npid + "&PGNO=" + pno + "&DTREL=" + dt
                    + "&ADNO=" + adno + "&UPID="+param;
            
                var st = $.get("AjaxActions?req=DELUPLOADIMG&" + pp,
                    function(responseText) { 
                        if (responseText === "DELETED") {
                            location.reload();
                        } else {
                            alert(responseText);
                        }
                });
            }
            
            function isValid() {
                if (!(fnValidate("CboNPID", "Please select a Newspaper.", 3))) return false;
                if (!fnValidate("TxtDTREL", "Date of Release", 0)) return false;
                if (!fnValidate("TxtPGNO", "Page No", 1)) return false;
                if (fnGetText("CboADNO") === "M") {
                    if ($("#TxtADNO").val() <= 1) {
                        alert("Please enter the valid No of Group Ads.");
                        return false;
                    }
                }
                return true;
            }
            
            function funPGUpload() {
                if (!isValid()) return;
                var npid = fnGetText("CboNPID");
                var rno = fnGetText("TxtRELNO");
                var pno = fnGetText("TxtPGNO");
                var dtr = fnGetText("TxtDTREL");
                var dt = dtr.substr(6,4) + dtr.substr(3,2) + dtr.substr(0,2);
                var adno = 1;
                if (fnGetText("CboADNO") === "M") 
                {
                    adno = fnGetText("TxtADNO");
                }
                //x = window.open("swfUploadS.jsp?NPID="+npid + "&DTREL="+dt+ "&RELNO=PGFILE&PGNO="+pno,"dataitem","width=470,height=250,resizable=no,modal,dialog,status=1");
                x = window.open("fileUploadS.jsp?NPID="+npid + "&DTREL="+dt+ "&RELNO=PGFILE&PGNO="+pno+"&ADNO=" + adno,"dataitem","width=470,height=250,resizable=no,modal,dialog,status=1");
            }
            
            function funUpload() {
                if (!isValid()) return;
                var npid = fnGetText("CboNPID");
                var pno = fnGetText("TxtPGNO");
                var dtr = fnGetText("TxtDTREL");
                var adno = 1;
                if (fnGetText("CboADNO") === "M") 
                {
                    adno = fnGetText("TxtADNO");
                }
                var dt = dtr.substr(6,4) + dtr.substr(3,2) + dtr.substr(0,2);
                var pp = "NPID=" + npid + "&PGNO=" + pno + "&DTREL=" + dt+ "&ADNO=" + adno;
                $.get("AjaxActions?req=CHKUPLOAD&"+pp,
                    function(responseText) { 
                        if (responseText === "Avaliable") 
                        {
                            $("#dialog-available-confirm" ).dialog( "open" );
                        } 
                        else {
                            funSWFUpload();
                        }
                });
            }
            
            function funSWFUpload() {
                if (!fnValidate("TxtRELNO", "Release No", 1)) return false;
                var npid = fnGetText("CboNPID");
                var rno = fnGetText("TxtRELNO");
                var pno = fnGetText("TxtPGNO");
                var dtr = fnGetText("TxtDTREL");
                var dt = dtr.substr(6,4) + dtr.substr(3,2) + dtr.substr(0,2);
                var ntid = fnGetText("CboNTID");
                var adno = 1;
                if (fnGetText("CboADNO") === "M") 
                {
                    adno = fnGetText("TxtADNO");
                }
                
                var pp = "NPID=" + npid + "&NTID=" + ntid + "&DTREL=" + dt 
                        + "&RELNO=" +rno + "&PGNO=" + pno 
                        + "&ADNO=" + adno;
                //x = window.open("swfUploadM.jsp?"+pp ,"dataitem","width=470,height=250,resizable=no,modal,dialog,status=1");
                x = window.open("fileUploadM.jsp?"+pp ,"dataitem","width=470,height=250,resizable=no,modal,dialog,status=1");
            }
            
            function funRemoveImgs() {
                if (!isValid()) return;
                var npid = fnGetText("CboNPID");
                var pno = fnGetText("TxtPGNO");
                var adno = 1;
                if (fnGetText("CboADNO") === "M") 
                {
                    adno = fnGetText("TxtADNO");
                }
                var dtr = fnGetText("TxtDTREL");
                var dt = dtr.substr(6,4) + dtr.substr(3,2) + dtr.substr(0,2);
                var pp = "NPID=" + npid + "&PGNO=" + pno + "&DTREL=" + dt
                    + "&ADNO=" + adno;
                var st = $.get("AjaxActions?req=CHKUPLOADDEL&" + pp,
                    function(responseText) { 
                        if (responseText === "No") {
                            $("#dialog-del-not-confirm" ).dialog( "open" );
                        } 
                        else {
                            $("#dialog-del-confirm" ).dialog( "open" );
                        }
                });
            }
            
            function funChangeNTID(pupid) {
                if (!isValid()) return;
                var npid = fnGetText("CboNPID");
                var dtr = fnGetText("TxtDTREL");
                var pno = fnGetText("TxtPGNO");
                var adno = 1;
                if ( $("#TxtADNO_"+pupid).length !== 0) 
                {
                    adno = fnGetText("TxtADNO_"+pupid);
                }
                var dt = dtr.substr(6,4) + dtr.substr(3,2) + dtr.substr(0,2);
                var ntid = fnGetText("CboNTID_"+pupid);
                var pp = "UPID=" + pupid + "&NPID=" + npid + "&NTID=" + ntid 
                        + "&PGNO=" + pno + "&DTREL=" + dt+ "&ADNO=" + adno;
                //alert(pp);
                var st = $.get("AjaxActions?req=UPDNTID&"+pp,
                    function(responseText) { 
                        if (responseText === "UPDATED") {
                            alert("Updated Successfully.");
                            $("#CboNTID_"+pupid).attr("disabled", "disabled");
                            $("#btnNTID_"+pupid).attr("disabled", "disabled");
                        } else {
                            alert(responseText);
                        }
                });
            }
            
            function funCboADNO_Change() {
                if (fnGetText("CboADNO") === "M") {
                    $("#TxtADNO").val("");
                    $("#TxtADNO").prop("readonly", false);
                    $("#TxtADNO").focus();
                } else {
                    $("#TxtADNO").val("1");
                    $("#TxtADNO").prop("readonly", true);
                }
            }
            
            function funCboNTID_Change() {
                var ntid = fnGetText("CboNTID");
                if (ntid === "0") {
                    $("#TxtPGNO").val("20");
                } else {
                    $("#TxtPGNO").val(ntid-50);
                }
            }
            $("#TxtPGNO").val("20");
            fnFillCombo("CboNPID", params, "NP", "UAS");
            fnFillCombo("CboNTID", params, "NT", "UAS");
        </script>
        
        <!-- confirmation dialogs -->
        <div id="dialog-available-confirm" title="Alert for upload">
             <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
                Already uploaded.<BR>Do you still want to continue?</p>
        </div>
        <div id="dialog-del-not-confirm" title="Alert for upload">
             <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
                Delete the uploaded images not possible due to some of the notice data are captured.</p>
        </div>
        <div id="dialog-del-confirm" title="Delete confirmaton...">
             <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
                Delete the uploaded images?<BR>Do you still want to continue?</p>
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
                
                // for Date Picket 
                $.datepicker.setDefaults({
                        showOn: 'both', dateFormat: "dd-mm-yy", isRTL: true,
                        showButtonPanel: true, closeText: "Close",
                        numberOfMonths: 1, changeMonth: true,
                        constrainInput: true, buttonImageOnly: true,
                        buttonImage: 'images/calendar.gif'});     
                $("#TxtDTREL").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    numberOfMonths: 1,
                    maxDate:"-0d"
                });
                //$("ul[class=bjqs]> li[id=liremove]").remove();
                $('#banner-slide').bjqs({
                    animtype      : 'slide',
                    height        : 370,
                    width         : 620,
                    responsive    : true,
                    randomstart   : false,
                    automatic     : false,
                    nexttext      : "<img src='scripts/jquery/ImgSlid/next.png' alt='Next'>",
                    prevtext      : "<img src='scripts/jquery/ImgSlid/prev.png' alt='Prev'>"
                });
                
                $('#btnList').click(function(event) {  
                    if (!isValid()) return;
                    var npid = fnGetText("CboNPID");
                    var dtr = fnGetText("TxtDTREL");
                    var pno = fnGetText("TxtPGNO");
                    var adno = 1;
                    if (fnGetText("CboADNO") === "M") 
                    {
                        adno = fnGetText("TxtADNO");
                    }
                    var dt = dtr.substr(6,4) + dtr.substr(3,2) + dtr.substr(0,2);
                    var ntid = fnGetText("CboNTID");
                    var pp = "NPID=" + npid + "&NTID=" + ntid + "&DTREL=" + dt 
                            + "&PGNO=" + pno+ "&ADNO=" + adno;
                    $.get("AjaxActions?req=ImgList&" + pp,
                        function(responseText) { 
                            if (responseText === "REFRESH") {
                                location.reload();
                            }
                            else if (responseText === "HIDEIMG") {
                                $('#btnRemove').button("disable");
                                $('#banner-slide').css("display", "none");
                                alert("There is No Images.");
                            }
                    });
                });
                
                // for confirmation dialog
                $( "#dialog-available-confirm" ).dialog({
                    modal: true, autoOpen: false, resizable: false,
                    height:'auto', width:'auto',
                    buttons: {
                        "Continue": function() {
                            $( this ).dialog( "close" );
                            funSWFUpload();
                        },
                        Cancel: function() {
                            $( this ).dialog( "close" );
                        }
                    }
                });
                
                $( "#dialog-del-not-confirm" ).dialog({
                    modal: true, autoOpen: false, resizable: false,
                    height:'auto', width:'auto',
                    buttons: {
                        "Ok": function() {
                            $( this ).dialog( "close" );   
                        }
                    }
                });
                
                $( "#dialog-del-confirm" ).dialog({
                    modal: true, autoOpen: false, resizable: false,
                    height:'auto', width:'auto',
                    buttons: {
                        "Delete": function() {
                            $( this ).dialog( "close" );
                            var npid = fnGetText("CboNPID");
                            var dtr = fnGetText("TxtDTREL");
                            var pno = fnGetText("TxtPGNO");
                            var adno = 1;
                            if (fnGetText("CboADNO") === "M") 
                            {
                                adno = fnGetText("TxtADNO");
                            }
                            var dt = dtr.substr(6,4) + dtr.substr(3,2) + dtr.substr(0,2);
                            $.get("AjaxActions?req=DELUPLOAD&NPID=" + npid + "&PGNO="+pno + "&ADNO="+adno+ "&DTREL="+dt,
                                function(responseText) { 
                                    if (responseText === "DELETED") {
                                        location.reload();
                                    } else {
                                        alert(responseText);
                                    }
                            });
                        },
                        Cancel: function() {
                            $( this ).dialog( "close" );
                        }
                    }
                });
                <%if (odl == null) {%>
                    funCboADNO_Change();
                    $('#btnRemove').attr("disabled", "disabled");//.button("disable");
                <%} else {
                    out.print(jscript);
                }%>
            });
        </script>
        <!-- Alert (message) -->
        <%out.print(AppUtils.printMessage(request));%>
    </body>
</html>
