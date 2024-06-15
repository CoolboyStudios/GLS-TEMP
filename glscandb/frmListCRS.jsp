                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   <%-- 
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
        request.setAttribute("msg", "There is a program error(MNU311S).<br>Please convey to administator with this error code.");
        request.getRequestDispatcher("logon.jsp").forward(request, response);            
        return;
    }
    if (!lType.startsWith("mnu311S")) {
        request.setAttribute("msg", "There is a program error(MNU311S).<br>Please convey to administator with this error code.\n");
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
                            <td class="MainHeading" align="center">Combined Report - Ads Search</td>
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
                                            <td>Customer Name</td>
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
        <div id="dataLayer" title="Combined Report - Search Details">
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
                    <td>Customer/Trade Name</td>
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
            <form name="FrmCRReqSrc" id="FrmCRReqSrc" method="post">
                <table style="width:850px">
                    <input type="hidden" name="TxtCRRID" id="TxtCRRID" value="0">
                    <input type="hidden" name="TxtSNO" id="TxtSNO" value="0">
                    <input type="hidden" name="TxtNID" id="TxtNID" value="0">
                    <tr>
                        <td style="width:20%">Search Value in ARB</td>
                        <td style="width:60%" class="Left">
                            <input type="text" id="TxtASVAL" name="TxtASVAL"
                                    maxlength="250" style="width:90%"></td>
                        <td style="width:20%">
                            <input type="button" id="btnSearch" name="btnSearch" value="Search" onclick="funSearchST();">
                        </td>
                    </tr>
                    <tr><td colspan="3">&nbsp;</td></tr>
                </table>
            </form>
            <div id="divNSRCHList">
                <!--div id="idSRRows" class="error" style="width:100%"></div-->
                <iframe name="jasper" id="jasper" src="" frameborder="0" scrolling="no"
                        style="width:850px;height:350px;overflow:hidden;background-color: #ffffff;"></iframe>

            </div>
        </div>
        <div id="imgLayer" title="Notice details">
            <table style="width:750px">
                <tr>
                    <td style="width:60%" class="Center Top">
                        <div id="img_scroll_div" style="height:400px;overflow:auto;border:1px solid graytext;">
                            <img id="img_zoom" src="images/wspacer.jpg" alt=" " />
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
                    <td style="width:40%" class="Top Justify">
                        <textarea class="lblArabic Justify" id="lblANNOUN" style="width:100%;height:400px;overflow:auto;"></textarea>
                        <!--span id="lblANNOUN" class="lblArabic" style="width:100%;height:100px;overflow:auto;"></span-->
                    </td>
                </tr>
            </table>
        </div>
        
        <!-- Print Param Array -->
        <% out.print(AppUtils.printParamArray(request)); %>
        
        
        <script type="text/javascript">
            // image layer
            function funSrcTblClick(id, img, ann, sv, eann) {
				$( "#imgLayer" ).dialog('open');
                funLoadImg('img_zoom',img); 
                $("#TxtNID").val(id);
                //console.log(id);
                //alert(ann);
                $('#lblANNOUN').html(ann);
                if(sv !== '-') 
                    { funHighlight(sv);}    
                else
                    { 
                        funHighlight($("#TxtASVAL").val().replace("%", ''));
                        funHighlight($("#TxtASVAL").val().replace("%", ' '));
                    }
                
            }
            
            function funLoadImg(imgid, imgurl) {
                //alert(imgid + "-" + imgurl);
                var url = imgurl;    //encodeURIComponent(imgurl);
                $('img[id$='+imgid+']').load(url, function(response, status, xhr) {
                    if (status === "error") {
						console.log(imgurl);
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
                //console.log(text);
                if (text === "") return;
                $('#lblANNOUN').html( $('#lblANNOUN').html().replaceAll(text, '<mark>'+text+'</mark>'));
            }
            
            function funCheckDup() {
                fnShowLayer("waitLayer");
                
                $.ajax({
                    type: 'GET',
                    url: "ajxCRReqSCls?req=mnu311SRCNDUP&RID="+ $('#TxtCRRID').val()
                            +"&SNO=" + $('#TxtSNO').val() +"&NID=" + $('#TxtNID').val(),
                    dataType: 'text',
                    async: true,
                    success: function(data, textStatus, jqXHR) 
                    {
                        fnHideLayer("waitLayer");
                        if (data === "0") 
                        {
                            fnHideLayer("waitLayer");
                            funAttach();
                            return true;
                        } 
                        if (data === "-") 
                        {
                            fnHideLayer("waitLayer");
                            alert("Already this noitce attached to this Request!...\n Press the Review buttion to see all the attached ads.");
                            return false;
                        } 
                        else
                        {
                            fnHideLayer("waitLayer");
                            var cn = confirm(data+"\nAlready this noitce attached to this Request!...\n\n Do you want to continue or cancel?");
                            if (!cn) {
                                return false;
                            } 
                            else {
                                funAttach();
                                return true;
                            }
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
            
            function funAttach() {
                fnShowLayer("waitLayer");
                var formData = $("#FrmCRReqSrc").serializeArray();
                $.ajax({
                    type: 'POST',
                    url: "ajxCRReqSCls?req=mnu311SRCATT",
                    data: formData,
                    dataType: 'text',
                    async: true,
                    success: function(data, textStatus, jqXHR) 
                    {
                        if (data === "Success") {
                            alert("Attached Successfully.");
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
            
            function funDeAttach() {
                
                fnShowLayer("waitLayer");
                var formData = $("#FrmCRReqSrc").serializeArray();
                $.ajax({
                    type: 'POST',
                    url: "ajxCRReqSCls?req=mnu311SRCDEA",
                    data: formData,
                    dataType: 'text',
                    async: true,
                    success: function(data, textStatus, jqXHR) 
                    {
                        if (data === "Success") {
                            alert("De-attached Successfully.");
                            setTimeout(funReviewAtt(), 500);
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
                // set search table as empty   
                funSrcReLoad();
                fnHideLayer("waitLayer");
            }
            
            function funCRSrcGet(pid, psno) {
                fnShowLayer("waitLayer");
                $.get({
                    //type: 'GET',
                    url: "ajxCRReqSCls?req=mnu311SGET&id="+pid +"&sno=" + psno,
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
            
            function funGetSearchLst() {
                var formData = $("#FrmCRReqSrc").serializeArray();
                $.ajax({
                    type: 'POST',
                    url: "ajxCRReqSCls?req=mnu311SRCLIST",
                    data: formData,
                    dataType: 'json',
                    async: true,
                    success: function(data, textStatus, jqXHR) 
                    {
                        funSrcReLoad();
                        fnHideLayer("waitLayer");
                        $( "#btnAttachAds" ).show();
                        $( "#btnDetacheAds" ).hide();
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
            
            function funSearchST() {
                fnShowLayer("waitLayer");
                setTimeout(funGetSearchLst(), 500);
            }
            
            function funReviewAtt() {
                var formData = $("#FrmCRReqSrc").serializeArray();
                $.ajax({
                    type: 'POST',
                    url: "ajxCRReqSCls?req=mnu311SRCREV",
                    data: formData,
                    dataType: 'json',
                    async: true,
                    success: function(data, textStatus, jqXHR) 
                    {
                        funSrcReLoad();
                        fnHideLayer("waitLayer");
                        $( "#btnAttachAds" ).hide();
                        $( "#btnDetacheAds" ).show();
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
                var cn = confirm("Do you still want to Mark as Search Completed? (press OK).", "Ok", "Cancel");
                if (!cn) {
                    return false;
                }
                
                fnShowLayer("waitLayer");
                var formData = $("#FrmCRReqSrc").serializeArray();
                $.ajax({
                    type: 'POST',
                    url: "ajxCRReqSCls?req=mnu311SRCOMP",
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
                    url: "ajxCRReqSCls?req=mnu311SLIST",
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
                        "Review": function() {
                            funReviewAtt();
                            //$( this ).dialog( "close" );
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
                
                $( "#imgLayer" ).dialog({
                    modal: true, autoOpen: true, resizable: false,
                    height:'auto', width:'auto', closeOnEscape: false,
                    buttons: {
                        "Detache": {
                            text: "Detache",
                            id: "btnDetacheAds",
                            click: function() {
                                $( this ).dialog( "close" );
                                funDeAttach();
                            } 
                        },
                        "Attach": {
                            text: "Attach",
                            id: "btnAttachAds",
                            click: function () {
                                $( this ).dialog( "close" );
                                funCheckDup();
                            }
                        },
                        Close: function() {
                            $( this ).dialog( "close" );
                        }
                    }
                });
                
                
                funSrcReLoad();
				$( "#imgLayer" ).dialog('close');
                $( "#dataLayer" ).dialog('close');
                setTimeout(funOnLoad_FillList(), 500);
            });
            
            funfillCbo();
        </script>
        <!-- Alert (message) -->
        <%out.print(AppUtils.printMessage(request));%>
    </body>
</html>
