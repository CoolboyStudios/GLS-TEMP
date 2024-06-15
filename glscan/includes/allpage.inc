<!-- Loader Div -->
<div id="shadow" class="opaqueLayer"> </div>
<div id="waitLayer" class="questionLayer">
        <br><br><br>
        Please wait...<br>
        <br>
        <img src="images/loader_roller.gif" alt="Loding/Processing..">
</div>
<div style="position: absolute;top: 0;width: 765px;border-bottom: 4px solid #61AB00;">
    <div>
        <table>
            <tr>
                <td>
                    <img src="./images/glc_logo.png"></td>
                </td>
            </tr>
        </table>
    </div>
    <div style="position: relative;bottom: 0;width: 100%;">
        <table style="width:100%">
            <tr>
                <td style="width:80%">
                    <div id="sysMenu"></div>
                </td>
                <td class="labels right" style="width:20%">
                    <%if (user != null) { out.print(user.getCUNAME()); } %>
                    <input type=hidden id='TxtWMNUST' value='<%if (user != null) { out.print(user.getWLSTALOW()); } %>'>
                </td>
            </tr>
        </table>
    </div>
</div>
<div id="divPgFooter" style="position: fixed;bottom: 0;width: 765px;">
    <table class="pagefooter">
        <tr>    
            <td class="copyright">&copy; Copyright2012-2023, Green Lines, All rights reserved.</td>
            <td>
                <a href="javascript:fnShowSubPage('tc')" class="hand">Terms &AMP; Conditions</a>&nbsp;|&nbsp;
                <a href="javascript:fnShowSubPage('con')" class="hand">Contact us</a>
            </td>
        </tr>
    </table>
</div>
<div id="dialogSubPage" title="Loading..." style="display:none">
    <iframe id="spIframe" name="spIframe" src="" style="width: 650px;height: 300px;border:0;" scrolling="auto"></iframe>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        $("#dialogSubPage").dialog({
            modal: true, autoOpen: false, resizable: false,
            height:'auto', width:'auto',
            open: function () {
              //autoResizeIF('myListIframe');  
            },
            close: function(event, ui){
                $('#spIframe').attr('src','');
            }
        });
        // load menu
        <%if (user != null) {%>
            $("#sysMenu").load("includes/menu.inc");
            <%if (true) {%>
                //disableMenuItem('mnuWatch');
            <%}%>
        <%}%>
    });

    function funMnuWatch() {
        if ($("#TxtWMNUST").val() == "N") {
            alert("Sorry, Watch list facility not yet activated for you. \n\nPlease contact administrator if you already subscribed otherwise subscribe now.");
        } 
        else {
            window.location.href = 'actions?req=mnu300';
        }
    }
</script>