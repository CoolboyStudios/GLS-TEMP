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
        request.setAttribute("msg", "There is a program error(MNU311T).<br>Please convey to administator with this error code.");
        request.getRequestDispatcher("logon.jsp").forward(request, response);            
        return;
    }
    if (!lType.startsWith("mnu311T")) {
        request.setAttribute("msg", "There is a program error(MNU311T).<br>Please convey to administator with this error code.\n");
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
        
        <script type="text/javascript" src="scripts/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery-ui.min.js"></script>
        <script type="text/javascript" src="scripts/TableFilter/tablefilter_all_min.js"></script>
        <script type="text/javascript" src="scripts/TableFilter/ezEditTable/ezEditTable.js"></script>
        <script type="text/javascript" src="scripts/AppsUtil.js"></script>
        
        <script type="text/javascript" src="scripts/jquery/jquery.autosize-min.js"></script>
        <script type="text/javascript" src="scripts/jquery/zoomer/axzoomer-min.js"></script>
        <script type="text/javascript" src="scripts/jquery/zoomer/fancybox-min.js"></script>
        <script type="text/javascript" src="scripts/jquery/zoomer/mousewheel-min.js"></script>
        <script type="text/javascript">
            var wTimer, tfCRS, tfCRSrc;
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
                            <td class="MainHeading" align="center">Combined Report - Ads Translation</td>
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
                                            <td>Customer/Trade Name</td>
                                            <td><input type="text" id="TxtCNAMEmp" name="TxtCNAMEmp"
                                                        maxlength="50" size="20"></td>
                                            <td>Client Ref.</td>
                                            <td><input type="text" id="TxtCREFmp" name="TxtCREFmp"
                                                        maxlength="20" size="20"></td>
                                            <td></td>
                                            <td></td>
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
                                    <%@ include file="includes/tblCRReqS.inc" %>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        
        <!-- Data Layer for Request  -->
        <div id="dataLayer" title="Combined Report - Ads List">
            <table style="width:850px">
                <tr>
                    <td style="width:20%">Client</td>
                    <td style="width:30%"><span id="lblCSID_DESC" name="lblCSID_DESC" ></span></td>
                    <td style="width:20%">Req. No.</td>
                    <td style="width:30%"><span id="lblCRRID" name="lblCRRID" ></span></td>
                </tr>
                <tr>
                    <td>Unit</td>
                    <td><span id="lblCSUID_DESC" name="lblCSUID_DESC" ></span></td>
                    <td>Req. Date</td>
                    <td><span id="lblDTREQ" name="lblDTREQ" ></span></td>                                          
                </tr>
                <tr>
                    <td>Customer Name</td>
                    <td><span id="lblCNAME" name="lblCNAME" ></span></td>
                    <td>Client Ref.</td>
                    <td><span id="lblCREF" name="lblCREF" ></span></td>
                </tr>
                <tr>
                    <td>Search Type</td>
                    <td><span id="lblSTYPE_DESC" name="lblSTYPE_DESC" ></span></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>Search Value in ARB</td>
                    <td><span id="lblASVAL" name="lblASVAL" ></span></td>
                    <td>Search Value in ENG</td>
                    <td><span id="lblESVAL" name="lblESVAL" ></span></td>
                </tr>
            </table>
            <div id="divNSRCHList">
                <!--div id="idSRRows" class="error" style="width:100%"></div-->
                <iframe name="jasper" id="jasper" src="" frameborder="0" scrolling="no"
                        style="width:850px;height:350px;overflow:hidden;background-color: #ffffff;"></iframe>

            </div>
        </div>
        <div id="imgLayer" title="Notice details">
            <table style="width:750px">
                <tr>
                    <td style="width:50%" class="Center Top">
                        <div id="img_scroll_div" style="height:300px;width:360px;overflow:auto;border:1px solid graytext;">
                            <img id="img_zoom" src="images/wspacer.jpg" alt="">
                        </div>
                        <div class="Right">
                            <img id="zoomInbutt" class="lnkicon16" title="Zoom in"
                                 src="images/zoom-in.png" alt="ZoomIn">
                            <img src="images/wspacer.jpg" hspace="4" alt=' '>
                            <img id="zoomOutbutt" class="lnkicon16" title="Zoom out"
                                 src="images/zoom-out.png" alt="ZoomOut">
                            <img src="images/wspacer.jpg" hspace="4" alt=' '>
                            <img id="zoomRbutt" class="lnkicon16" title="Zoom reset"
                                 src="images/undo.png" alt="ZoomReset">
                        </div>
                    </td>
                    <td>&nbsp;</td>
                    <td style="width:48%" class="Top">
                        <textarea class="lblArabic Justify" id="lblANNOUN" style="width:100%;height:400px;overflow:auto;"></textarea>
                        <!--span id="lblANNOUN" class="lblArabic" style="width:100%;height:100px;overflow:auto;"></span-->
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <form name="FrmCRTrn" id="FrmCRTrn" method="post">
                            <table style="width:100%">
                                <input type="hidden" name="TxtCRRID" id="TxtCRRID" value="0">
                                <input type="hidden" name="TxtSNO" id="TxtSNO" value="0">
                                <input type="hidden" name="TxtNID" id="TxtNID" value="0">
                                <tr>
                                    <td>Announcement in English</td>
                                </tr>
                                <tr>
                                    <td class="Left">
                                        <textarea class="animatedTA" cols="120"
                                                id="TxtEANNOUN" name="TxtEANNOUN"></textarea>
                                    </td
                                </tr>
                                
                            </table>
                        </form>
                    </td>
                </tr>
            </table>
        </div>
        
        <!-- Print Param Array -->
        <% out.print(AppUtils.printParamArray(request)); %>
        
        <!-- confirmation dialogs -->
        <div id="dgBKSRCConfirm" title="Back to Search?">
             <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
                Do you still want to send back to search stage this request?</p>
        </div>
        
        <script type="text/javascript">
            // image layer
            function funSrcTblClick(id, img, ann, sv, eann) {
                funLoadImg('img_zoom',img); 
                $("#TxtNID").val(id);
                //console.log(id);
                //alert(ann);
                $('#lblANNOUN').html(ann);
                $("#TxtANNOUN").autosize({append: "\n"});
                $('#TxtEANNOUN').val(eann);
                if(sv !== '-') 
                    { funHighlight(sv);}    
                else
                    { funHighlight($("#TxtASVAL").val());}
                $( "#imgLayer" ).dialog('open');
            }
            
            function funLoadImg(imgid, imgurl) {
                //alert(imgid + "-" + imgurl);
                //console.log(imgurl);
                var url = imgurl;    //encodeURIComponent(imgurl);
                $('img[id$='+imgid+']').load(url, function(response, status, xhr) {
                    if (status === "error") {
                        $(this).attr('src', 'images/wspacer.jpg');
                    } 
                    else {
                        $(this).attr('src', url);
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
                    }
                });
            } 
            
            function funHighlight(text) {
                //return;
                //inputText = document.getElementById("lblANNOUN");
                //var innerHTML = $('#lblANNOUN').html();// inputText.innerHTML;
                console.log(text);
                if (text === "") return;
                $('#lblANNOUN').html( $('#lblANNOUN').html().replaceAll(text, '<mark>'+text+'</mark>'));
            }
            
            function funTrnSave() {
                fnShowLayer("waitLayer");
                var formData = $("#FrmCRTrn").serializeArray();
                $.ajax({
                    type: 'POST',
                    url: "ajxCRReqSCls?req=mnu311TRNUPD",
                    data: formData,
                    dataType: 'text',
                    async: true,
                    success: function(data, textStatus, jqXHR) 
                    {
                        if (data === "Success") {
                            alert("Saved Successfully.");
                            setTimeout(funSrcReLoad(), 500);
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
            
            // data layer
            function funSrcReLoad() {
                if ($("#jasper").attr("src") === "") {
                    $("#jasper").attr("src", "frmListCRS_sp.jsp");
                } 
                else {
                    $('#jasper')[0].contentWindow.location.reload(true);
                }
            }
            
            function funSetJSONValCRS(jsonText) {
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
                    });
                });
                
                $( "#imgLayer" ).dialog( "close" );
                $( "#dataLayer" ).dialog( "open" );
                fnHideLayer("waitLayer");
                // set search table as empty   
                setTimeout(funOnLoad_FillAdsList(), 500);
            }
            
            function funCRSrcGet(pid, psno) {
                fnShowLayer("waitLayer");
                $.get({
                    //type: 'GET',
                    url: "ajxCRReqSCls?req=mnu311TGET&id="+pid +"&sno=" + psno,
                    dataType: 'json',
                    async: true,
                    success: function(data, textStatus, jqXHR) 
                    {
                        //alert(data + "-:-" + textStatus);
                        funSetJSONValCRS(data);
                    },
                    error: function(jqXHR, textStatus, errorThrown) 
                    {
                        alert(textStatus + "-" + errorThrown);
                        //window.location="logon.jsp";
                        fnHideLayer("waitLayer");
                    }
                });
            }
            
            function funOnLoad_FillAdsList() {
                var formData = $("#FrmCRTrn").serializeArray();
                $.ajax({
                    type: 'POST',
                    url: "ajxCRReqSCls?req=mnu311TRNLST",
                    data: formData,
                    dataType: 'json',
                    async: true,
                    success: function(data, textStatus, jqXHR) 
                    {
                        funSrcReLoad();
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
            
            function funMarkComp() {
                var cn = confirm("Do you still want to Mark as Transaltion Completed? (press OK).", "Ok", "Cancel");
                if (!cn) {
                    return false;
                }
                
                fnShowLayer("waitLayer");
                var formData = $("#FrmCRTrn").serializeArray();
                $.ajax({
                    type: 'POST',
                    url: "ajxCRReqSCls?req=mnu311TRCOMP",
                    data: formData,
                    dataType: 'text',
                    async: true,
                    success: function(data, textStatus, jqXHR) 
                    {
                        if (data === "Success") {
                            $( "#dataLayer" ).dialog( "close" );
                            alert("Marked as Completed Successfully.");
                            setTimeout(funOnLoad_FillList(), 500);
                        } 
                        if (data !== "Success") {
                            alert("There are "+data + " Ads are pending to transalate.");
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
                //fnFillCombo("CboSTYPE", params, "ST", "S");
            }
            
            function funCboCSIDmp_Change() {
                fnFillCombo("CboCSUIDmp", params, "CSID" + $("#CboCSIDmp").val(), "0A");
            }
            
            function funOnLoad_FillList() {
                var formData = $("#FrmSEARCH").serializeArray();
                fnShowLayer("waitLayer");
                
                $.ajax({
                    type: 'POST',
                    url: "ajxCRReqSCls?req=mnu311TLIST",
                    data: formData,
                    dataType: 'json',
                    async: true,
                    success: function(data, textStatus, jqXHR) 
                    {
                        var tr = data.LISTROWS;
                        if (tr === "") {
                            tr = "<tr><td colspan=10>No Record(s).</<td></tr>";
                        }
                        //$('#ListDIV').show();
                        fnHideLayer("waitLayer");
                        
                        if (tfCRS !== undefined) {
                            if (tfCRS.HasGrid()) {
                                tfCRS.RemoveGrid();
                            }
                        }
                        
                        $("#tblCRSList tbody").html(tr);
                        tfCRS = setFilterGrid("tblCRSList", tblCRSProps);
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
                    $("#TxtSAVEOPT").val("NEW");
                    $("#TxtSTSAVEOPT").val("NEW");
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
                
                $( "#dataLayer" ).dialog({
                    modal: true, autoOpen: true, resizable: false,
                    height:'auto', width:'auto', closeOnEscape: false,
                    buttons: {
                        "Back to Search": function() {
                            funCRReqBKSRC();
                        },
                        "Completed": function() {
                            funMarkComp();
                        },
                        Close: function() {
                            $( this ).dialog( "close" );
                            /*if ($("#CRSLSTLOAD").val() === "YES") {
                                setTimeout(funOnLoad_FillList(), 500);
                            }*/
                        }
                    }
                });
                $( "#dgBKSRCConfirm" ).dialog({
                    modal: true, autoOpen: false, resizable: false,
                    height:170, width:350,
                    buttons: {
                        "Send it Back": function() {
                            $( this ).dialog( "close" );
                            setTimeout(funCRReqBKSRC_Save(), 500);
                        },
                        Cancel: function() {
                            $( this ).dialog( "close" );
                        }
                    }
                });
                
                $( "#imgLayer" ).dialog({
                    modal: true, autoOpen: false, resizable: false,
                    height:'auto', width:'auto', closeOnEscape: false,
                    buttons: {
                        "Update": {
                            text: "Save",
                            id: "btnSaveAds",
                            click: function() {
                                if ($("#TxtEANNOUN").val().length < 10) {
                                    alert('Please enter the transalation text.');
                                } 
                                else {
                                    funTrnSave(); 
                                }
                            } 
                        },
                        Close: {
                            text: "Close",
                            id: "btnCloseAds",
                            click: function() {
                                $( this ).dialog( "close" );
                            }
                        }
                    }
                });
                
                $("#TxtEANNOUN").autosize({append: "\n"});
                
                funSrcReLoad();
                $( "#dataLayer" ).dialog('close');
                setTimeout(funOnLoad_FillList(), 500);
                
                $("#btnCloseAds").submit( function(e) {
                    e.preventDefault();
                });
            });
            
            funfillCbo();
        </script>
        <!-- Alert (message) -->
        <%out.print(AppUtils.printMessage(request));%>
    </body>
</html>
