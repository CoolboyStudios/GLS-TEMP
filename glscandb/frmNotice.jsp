<%-- 
    Document   : home
    Created on : Oct 26, 2012, 5:19:34 AM
    Author     : ...
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap,java.util.ArrayList"%>
<%@page import="glscandb.classes.UserCls,glscandb.classes.NoticeCls,glscandb.AppUtils"%>
<%@ include file="includes/SessionValid.inc" %>
<%
    String lType = (String)request.getSession().getAttribute("objType");
    if (lType==null) {
        request.setAttribute("msg", "There is a program error(MNU301).<br>Please convey to administator with this error code.");
        request.getRequestDispatcher("logon.jsp").forward(request, response);            
        return;
    }
    if (!lType.startsWith("mnu301")) {
        request.setAttribute("msg", "There is a program error(MNU301).<br>Please convey to administator with this error code.\n" + lType);
        request.getRequestDispatcher("logon.jsp").forward(request, response);            
        return;
    }
    UserCls oUser = user;
    
    String mod = (lType.startsWith("mnu301N") ? "NEW" : "UPD");
    mod = (lType.startsWith("mnu301F") ? "FNEW" : mod);
    mod = (lType.startsWith("mnu301V") ? "VIEW" : mod);
    
    NoticeCls oNotice = new NoticeCls();
    Object ol = request.getSession().getAttribute("objList");
    if ((ol != null) && (!mod.equals("FNEW")) ){
        oNotice = (NoticeCls) ol;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>glScanDB - Notice</title>
        <link type="image/icon" href="images/sysicon.gif" rel="shortcut icon"/>
        <style type="text/css">
            @import "includes/apps.css";
            @import "scripts/jquery/smoothness/jquery-ui.min.css";
            @import "scripts/jquery/zoomer/fancybox.css";
        </style>
        
        <script type="text/javascript" src="scripts/TableFilter/tablefilter_all_min.js"></script>
        <script type="text/javascript" src="scripts/TableFilter/ezEditTable/ezEditTable.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery-ui.min.js"></script>
        
        
        <script type="text/javascript" src="scripts/jquery/jquery.autosize-min.js"></script>
        <script type="text/javascript" src="scripts/jquery/zoomer/axzoomer-min.js"></script>
        <script type="text/javascript" src="scripts/jquery/zoomer/fancybox-min.js"></script>
        <script type="text/javascript" src="scripts/jquery/zoomer/mousewheel-min.js"></script>
        
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
                <td class="MainHeading">
                    Notice Details
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table style="width:100%">
                        <tr>
                            <td width="60%" class="Center Top">
                                <div id="img_scroll_div" style="height:400px;overflow:auto;border:1px solid graytext;">
                                    <img id="img_zoom" src="images/wspacer.jpg" alt="">
                                </div>
                                <div class="Right">
                                    <span id="lblADNO" class="Error"></span>&nbsp;
                                    <span id="lblIFNAME" class="Error"></span>&nbsp;
                                    <input type="hidden" id="imgUpload" name="imgUpload">
                                    <!--img id="imgUpload" class="lnkicon24" src="images/upload_icon.png" alt=' '  
                                         title="Upload image"-->
                                    <img src="images/wspacer.jpg" hspace="4" alt=' '>
                                    <a id='pgImg' href='images/wspacer.jpg'><img class="lnkicon24"
                                            src='images/view_icon.png' alt='Full Page' title="Full Page"></a>
                                    <img src="images/wspacer.jpg" hspace="4" alt=' '>
                                    <img id="zoomInbutt" class="lnkicon24"
                                         title="Zoom in"
                                         src="images/zoom-in.png" alt="ZoomIn">
                                    <img src="images/wspacer.jpg" hspace="4" alt=' '>
                                    <img id="zoomOutbutt" class="lnkicon24"
                                         title="Zoom out"
                                         src="images/zoom-out.png" alt="ZoomOut">
                                    <img src="images/wspacer.jpg" hspace="4" alt=' '>
                                    <img id="zoomRbutt" class="lnkicon24"
                                         title="Zoom reset"
                                         src="images/undo.png" alt="ZoomOut">
                                </div>
                            </td>
                            <td class="Top">
                                <form name="FrmNotice" id="FrmNotice" method="post">
                                    <table>
                                        <tr>
                                            <td class="Right">
                                                <span id="lblStatus" class="arabic BoldRight">New</span>:الحالة
                                            </td>
                                            <td class="Right">
                                                <span id="lblNID" class="arabic BoldRight"></span>: إشعار رقم
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="Right" width="65%">
                                                <input type="hidden" id="TxtNID" name="TxtNID">
                                                <input type="hidden" id="TxtADMULTI" name="TxtADMULTI">
                                                <input type="hidden" id="TxtSTATUS" name="TxtSTATUS">
                                                <input type="hidden" id="TxtSAVEOPT" name="TxtSAVEOPT">
                                                <input type="hidden" id="TxtTEXTSEQ" name="TxtTEXTSEQ">
                                                <input class="arabic" type="text"
                                                       id="TxtDTREL" name="TxtDTREL"
                                                       size="10">
                                            </td>
                                            <td class="Right arabic" width="35%">التاريخ</td>
                                        </tr>
                                        <tr>
                                            <td class="Right">
                                                <select class="arabic" 
                                                        id="CboNPID" name="CboNPID"
                                                        style="width:90%">
                                                    <option></option>
                                                </select>
                                            </td>
                                            <td class="Right arabic">الجريدة</td>
                                        </tr>
                                        <tr>
                                            <td class="Right" colspan="2">
                                                <table>
                                                    <tr>
                                                        <td class="Right">
                                                            <input class="arabic" type="text" 
                                                                   id="TxtNPRNO" name="TxtNPRNO"
                                                                   size="10" maxlength="20">
                                                        </td>
                                                        <td class="Right arabic">العدد</td>
                                                        <td class="Right">
                                                            <input class="arabic" type="text" 
                                                                   id="TxtSEQNO" name="TxtSEQNO" readonly
                                                                   size="3">
                                                        </td>
                                                        <td class="Right arabic">تسلسل</td>
                                                        <td class="Right">
                                                            <input class="arabic" type="text" 
                                                                   id="TxtPGNO" name="TxtPGNO"
                                                                   size="3">
                                                        </td>
                                                        <td class="Right arabic">صفحة</td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="Right">
                                                <select class="arabic" 
                                                        onchange="funSetLable(this.value);"
                                                        id="CboNTID" name="CboNTID"
                                                        style="width:90%">
                                                    <option></option>
                                                </select>
                                            </td>
                                            <td class="Right arabic">نوع الاعلان</td>
                                        </tr>
                                        <%@ include file="includes/Notice.inc" %>
                                        <tr>
                                            <td class="Right">
                                                <textarea class="arabic animatedTA" 
                                                          id="TxtANNOUN" name="TxtANNOUN"
                                                          cols="49"><%if (!mod.contains("NEW")) {out.print(oNotice.getANNOUN());} %></textarea>
                                            </td>
                                            <td class="Right Top arabic">نص الاعلان</td>
                                        </tr>
                                        <tr><td colspan="2">&nbsp;</td></tr>
                                        <tr>
                                            <td class="Right">
                                                <select class="arabic" 
                                                        onchange="funChangeStatus('<%=oUser.getSYSROLE()%>');" 
                                                        id="CboSTATUS" name="CboSTATUS"
                                                        style="width:90%">
                                                    <option value="I">غير كامل - Update</option>
                                                    <option value="E">غلطة - Data Error</option>
                                                    <option value="A">التحقق منها - Verified</option>
                                                </select>
                                            </td>
                                            <td class="Right arabic">
                                                الحالة
                                            </td>
                                        </tr>
                                         <tr>
                                            <td class="Center" colspan="2">
                                                <input type="button" id="btnSAVE" value="Save - حفظ" 
                                                    onclick="javascript:funSave('<%out.print(user.getSYSROLE());%>');" 
                                                    title="Save information">
                                                <input type="button" id="btnDEL" value="Remove - حذف" 
                                                        onclick="javascript:funRemove();" 
                                                        title="Remove information">
                                                <input type="button" id="btnNXT" value="Next - التالي" 
                                                    onclick="javascript:funAddNext('<%out.print(user.getSYSROLE());%>');" 
                                                    title="Next new notice entry">
                                                <%if (mod.equals("VIEW")) { %>
                                                    <input type="button" id="btnMYP" value="Search -  بحث"
                                                        onclick="javascript:funSearch('S');" 
                                                        title="Back to list">
                                                <%} else {%>
                                                    <input type="button" id="btnMYP" value="My Pending - وظيفتي ريثما" 
                                                        onclick="javascript:funSearch('P');" 
                                                        title="Back to list">
                                                <%}%>
                                            </td>
                                        </tr>
                                        <tr id="trUSER">
                                            <td>
                                                Entered by :<span id="lblMaker" class="arabic BoldRight">-</span> 
                                            </td>
                                            <td>
                                                Checked by :<span id="lblCheck" class="arabic BoldRight">-</span>
                                            </td>
                                        </tr>
                                    </table>
                                </form>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        
        <!-- confirmation dialogs -->
        <div id="dialog-del-confirm" title="Delete this user?">
            <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
                This notice will be deleted and cannot be recovered.<BR>Do you still want to continue?</p>
        </div>
        <!-- Print Param Array -->
        <% out.print(AppUtils.printParamArray(request)); %>
        
        <script type="text/javascript">
            /*function funAdd()  {
                $("textarea").val("");
                fnSetText("TxtSEQNO", "");
                var flen = fnGetText("TxtTEXTSEQ");
                var ids = "";
                for(var i=1;i<=flen;i++){
                    if (i<10) ids = "0"; else ids = "";
                    ids = ids + (i);
                    fnSetText("TxtTEXT"+ids, "");
                }
                fnSetText("TxtSAVEOPT", "NEW");
                fnFocus("TxtTEXTSEQ", false);
            }*/
            function funChangeStatus(role) {
                if (role === "M") {
                    if ($("#CboSTATUS").val() !== "I") {
                        alert("Invalid STATUS selection.");
                        $("#CboSTATUS").val("I");
                        $("#CboSTATUS").focus();
                        return false;
                    }
                } 
                if (role === "C") {
                    if (($("#CboSTATUS").val() === "A") && 
                        ($("#TxtSAVEOPT").val() === "NEW")) {
                        alert("Invalid STATUS selection.");
                        $("#CboSTATUS").val("I");
                        $("#CboSTATUS").focus();
                        return false;
                    }
                }
                return true;
            }
            
            function funBtnED(param) {
                $( "input[type=button]").attr("disabled", "disabled");
                if ((param === "NEW") || (param === "FNEW") || (param === "UPD")) {
                    $("#btnSAVE").removeAttr('disabled');
                    $("#btnMYP").removeAttr('disabled');
                }
                if ((param === "UPD")) {
                    $("#btnDEL").removeAttr('disabled');
                    $("#btnNXT").removeAttr('disabled');
                    //"My Pending - وظيفتي ريثما"
                    $("#btnMYP").removeAttr('disabled');
                }
                if ((param === "VIEW")) {
                    //$( "input[type=button]").css('display', 'hidden');
                    //$("#btnMYP").css('display', 'block');
                    $("#btnMYP").removeAttr('disabled');
                }
                
                if (param==="NEW") {
                    $("#trUSER").css('display', 'hidden');
                }
            }
            
            function funAddNext(prole) {
                fnShowLayer("waitLayer");
                if (prole === "C")  {
                    document.forms["FrmNotice"].action = "Actions?req=mnu301FV&id=";
                } 
                else {
                    document.forms["FrmNotice"].action = "Actions?req=mnu301F&id=";
                }
                document.forms["FrmNotice"].submit();
            }
            
            function funAddNextOLD() {
                $.get("AjaxActions?req=GETNXTNOTICE",
                    function(responseText) { 
                        if (responseText !== "{}") {
                            funSetJSONVal(responseText);
                            $("textarea").val("");
                            var flen = fnGetText("TxtTEXTSEQ");
                            var ids = "";
                            for(var i=1;i<=flen;i++){
                                if (i<10) ids = "0"; else ids = "";
                                ids = ids + (i);
                                fnSetText("TxtTEXT"+ids, "");
                            }
                            fnSetText("TxtSAVEOPT", "NEW");
                            $('#CboNTID').focus();
                        } 
                        else if (responseText === "{}") {
                            $("#btnNext").attr("disabled", "disabled");
                            alert("No more pending for new entry.");
                        } 
                        else {
                            alert(responseText);
                        }
                    });
            }
            
            function funIsValid(){
                if (!fnValidate("TxtDTREL", "Date of Release", 0)) return false;
                if (!fnValidate("CboNTID", "Notice Type", 2)) return false;
                if (!fnValidate("TxtNPRNO", "Release number", 0)) return false;
                if (!fnValidate("TxtPGNO", "Page number", 0)) return false;
                var seq = $("#TxtTEXTSEQ").val();
                var str = "";
                var ids = "";
                for(var i=1; i<=seq;i++){
                    if (i<10) ids = "0"; else ids = "";
                    ids = ids + (i);
                    if ($("#TxtTEXT"+ids).val() === ""){
                        str = str + $("#lblTEXT"+ids).text() + "\n";
                    }
                    if ($("#TxtANNOUN").val() === ""){
                        str = str + "نص الاعلان\n";
                    }
                }
                if (str !== "") {
                    var cn = confirm("The following mentionsed information are missing. \nDo you still want to continue to save the infomation? (press OK) \n\n" + str, "Ok", "Cancel");
                    if (!cn) {
                        return false;
                    }
                }
                return true;
            }
            
            function funSave(pRole){
                if (fnGetText("TxtSAVEOPT") !== "DEL") {
                    if (!funIsValid()) { return; };
                    if (!funChangeStatus(pRole)) { return; };
                    fnSetText("TxtSTATUS", fnGetText("CboSTATUS"));
                }
                fnShowLayer("waitLayer");
                document.forms["FrmNotice"].action = "Actions?req=Save301";
                document.forms["FrmNotice"].submit();
            }
            
            function funRemove() {
                //fnSetText("TxtUID", pid);
                $("#dialog-del-confirm" ).dialog( "open" );
            }
            
            function funSearch(param){
                fnShowLayer("waitLayer");
                if (param === "S") {
                    document.forms["FrmNotice"].action = "Actions?req=mnu302SL";
                } else {
                    document.forms["FrmNotice"].action = "Actions?req=mnu302MP";
                }
                document.forms["FrmNotice"].submit();
            }
            
            function funLoadImg(imgid, imgurl) {
                //alert(imgid + "-" + imgurl);
				//console.log(imgurl);
                var url = imgurl;//encodeURIComponent(imgurl);
                url = url.replace(" ", "%20");
                url = url.replace("(", "%28");
                url = url.replace(")", "%29");
				//console.log(url);
                
                $('img[id$='+imgid+']').load(url, function(response, status, xhr) {
                    if (status === "error") {
                        $(this).attr('src', 'images/wspacer.jpg');
                    } 
                    else {
                        $(this).attr('src', url); 
                    }
                });
            }
            
            function funGetMutiANNOUN(upid) {
                $.get("AjaxActions?req=GETMULANNOUN&UPID="+upid,
                    function(responseText) { 
                        if (responseText !== "") 
                        {
                            $('#TxtANNOUN').val(responseText);
                            //$( "#TxtANNOUN").autosize({append: "\n"});
                        }
                    });
            }
            
            function funSetJSONVal(jsontext) {
                var data = JSON.parse(jsontext);
                $('#CboNPID').val(data.NPID );
                $('#TxtDTREL').val(data.DTREL);
                $('#TxtSEQNO').val(data.UPID);
                $('#TxtNPRNO').val(data.NPRNO);
                $('#TxtPGNO').val(data.PGNO);
                // ADDED 28FEB14
                $('#TxtADMULTI').val(data.ADMULTI);
                if (data.ADMULTI === "M") {
                    funGetMutiANNOUN(data.UPID);
                    $('#lblADNO').text(data.EADNO + "/"+ data.ADNO);
                }
                else {
                    $('#TxtANNOUN').val(data.OCR_TEXT);
                    $('#lblADNO').text("");
                }
                if ((data.IFOLDER !== "") && (data.IFNAME !== ""))  
                {
                    funLoadImg('img_zoom', 'Uploads/'+data.IFOLDER + '/'+data.IFNAME);
                    //$('#img_zoom').attr('src', 'Uploads/'+data.IFOLDER + '/'+data.IFNAME);
                    $('#lblIFNAME').text(data.IFNAME);
                } 
                else {
                    $('#lblIFNAME').text("");
                }
                if ((data.IFOLDER !== "") && (data.IPGFNAME !== ""))  {
                    funLoadImg('pgImg', 'Uploads/'+data.IFOLDER + '/'+data.IPGFNAME);
                    //$('#pgImg').attr('href', 'Uploads/'+data.IFOLDER + '/'+data.IPGFNAME);
                }
                $('#lblStatus').text('New');
                
                
                $('#lblNID').text('NA');
                $('#CboNTID').val(0);
                $('#CboNTID').val(data.NTID);
                $("#CboSTATUS").val("I");
                $("#CboSTATUS").attr("disabled", "disabled");
                $("#imgUpload").css({opacity:'0.5',cursor:'default'}).unbind('click');
                funSetLable(data.NTID);
            }
            
            function funUploadImg(){
                var nid = $('#lblNID').text();
                if (!(fnValidate("CboNPID", "Please select a Newspaper.", 3))) return false;
                if (!fnValidate("TxtDTREL", "Date of Release", 0)) return false;
                if (!fnValidate("TxtNPRNO", "Release No", 1)) return false;
                if (!fnValidate("TxtPGNO", "Page No", 1)) return false;
                var npid = fnGetText("CboNPID");
                var rno = fnGetText("TxtNPRNO");
                var pno = fnGetText("TxtPGNO");
                var dtr = fnGetText("TxtDTREL");
                var dt = dtr.substr(6,4) + dtr.substr(3,2) + dtr.substr(0,2);
                var ntid = fnGetText("CboNTID");
                var pp = "UPID=" + nid + "&NPID=" + npid + "&NTID=" + ntid + "&DTREL=" + dt + "&RELNO=" +rno + "&PGNO=" + pno;
                x = window.open("fileUploadS.jsp?"+pp ,"dataitem","width=470,height=250,resizable=no,modal,dialog,status=1"); 
            }
            
            fnFillCombo("CboNPID", params, "NP", "");
            fnFillCombo("CboNTID", params, "NT", "UAS");
            
            // assign values to the Cbo & Txt
            <%
                if (mod.contains("FNEW")) {
                    out.print("fnSetText('TxtSAVEOPT', 'NEW');");
                    out.print("fnSetCbo('CboSTATUS', 'I');");
                    out.print("$('#imgUpload').css({opacity:'0.5',cursor:'default'}).unbind('click');");
                   // out.print("$('#lblMaker').text('" + oUser.getSHORT()+ "');");
                }
                else if (!mod.equals("NEW")) {
                    out.print("fnSetText('TxtSAVEOPT', 'UPD');");
                    out.print("$('#lblStatus').text('" + oNotice.getSTATUS_DESC() + "');");
                    out.print("$('#lblNID').text('" + oNotice.getNID() + "');");
                    out.print("fnSetText('TxtNID', '" + oNotice.getNID() + "');");
                    out.print("fnSetText('TxtSTATUS', '" + oNotice.getSTATUS()+ "');");
                    out.print("fnSetText('TxtADMULTI', '" + oNotice.getADMULTI()+ "');");
                    out.print("fnSetCbo('CboSTATUS', '" + oNotice.getSTATUS()+ "');");
                    out.print("fnSetCbo('CboNPID', '" + oNotice.getNPID() + "');");
                    out.print("fnSetCbo('CboNTID', '" + oNotice.getNTID() + "');");
                    out.print("fnSetText('TxtDTREL','" + AppUtils.formatDate(oNotice.getDTREL(), AppUtils.FormatDate.ddMMyyyy) + "');");
                    out.print("fnSetText('TxtNPRNO', '" + oNotice.getNPRNO() + "');");
                    out.print("fnSetText('TxtPGNO', '" + oNotice.getPGNO() + "');");
                    out.print("fnSetText('TxtSEQNO', '" + oNotice.getSEQNO() + "');");
                    
                    out.print("funSetLable(" + oNotice.getNTID() + ");");
                    String ids,txt;
                    for(int i=1; i<=15; i++) {
                        txt = oNotice.getTextSNO(i);
                        if (txt != null) {
                            ids = ((i<10)?"0":"") + i;
                            out.print("fnSetText('TxtTEXT"+ids+"', '" + txt + "');");
                        }
                    }
                    String fname = "Uploads/" + oNotice.getIFOLDER() + "/" + oNotice.getIFNAME();
                    //out.print("$('#img_zoom').attr('src', '"+ fname + "');");
                    out.print("funLoadImg('img_zoom', '" + fname + "');");
                    if (!oNotice.getIPGFNAME().isEmpty()) {
                        fname = "Uploads/" + oNotice.getIFOLDER() + "/" + oNotice.getIPGFNAME();
                        //out.print("$('#pgImg').attr('href', '" + fname + "');");
                        out.print("funLoadImg('pgImg', '" + fname + "');");
                    } 
                    out.print("$('#lblMaker').text('" + oNotice.getMAKE_DESC() + "');");
                    out.print("$('#lblCheck').text('" + oNotice.getCHCK_DESC() + "');");
                    if (mod.equals("VIEW")) {
                        out.print("$('#imgUpload').css({opacity:'0.5',cursor:'default'}).unbind('click');");
                        out.print("fnSetText('TxtSAVEOPT', '"+ mod +"');");
                    } else {
                        out.print("$('#imgUpload').css({cursor:'pointer'}).bind('click', function() {funUploadImg();});"); 
                    }
                }
            %>
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
                
                // for Date Picket  
                $.datepicker.setDefaults({
                        showOn: 'button', dateFormat: "dd-mm-yy", isRTL: true,
                        showButtonPanel: true, closeText: "Close",
                        numberOfMonths: 1, changeMonth: true,
                        constrainInput: true, buttonImageOnly: true,
                        buttonImage: 'images/calendar.gif'});     
                $("#TxtDTREL").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    maxDate:"-0d",
                    numberOfMonths: 1
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
                $( "#TxtANNOUN").autosize({append: "\n"});
                
                $('#img_zoom').axzoomer({
                    'maxZoom':4,
                    'toolbar': false,
                    'mousewheel':true,
                    'zoomOut': $('#zoomOutbutt'),
                    'zoomIn': $('#zoomInbutt'),
                    'reset': $('#zoomRbutt'),
                    'showControls': false
                });
                $('#img_zoom').width($('#img_scroll_div').width()-20);
                
                $("a#pgImg").fancybox({
                    onComplete:function()
                    {
                        $('#fancybox-img').axzoomer({
                            'zoomIn': 'scripts/jquery/zoomer/zoom-in.png',
                            'zoomOut': 'scripts/jquery/zoomer/zoom-out.png'});
                    }
                });
                
                var scroll = 0; var marginTop = 20;
                $(window).scroll(function () {
                    marginTop = ($(document).scrollTop() - scroll) + marginTop;
                    scroll = $(document).scrollTop();

                    $("#img_scroll_div").animate({"marginTop": marginTop+"px"}, {duration:500,queue:false} );
                });  
                
                <% 
                if (mod.equals("FNEW")) {
                     out.print("funSetJSONVal('" + ol.toString() + "');");
                     out.print("$('#CboNTID').focus();");
                } 
                out.print("funBtnED('" + mod + "');");
                %>
            });
        </script>
        
        <!-- Alert (message) -->
        <%out.print(AppUtils.printMessage(request));%>
    </body>
</html>
