<!-- Loader Div -->
<div id="shadow" class="ui-widget-overlay ui-front"> </div>
<div id="waitLayer" class="questionLayer">
        <br><br><br>
        Please wait...<br>
        <br>
        <img src="images/loader_roller.gif" alt="Loding/Processing..">
</div>

<table width="100%" border=0>
    <tr>
        <td class=Top>
            <img src="images/clientlogo.png" alt="logo" title="Logo image">
        </td>
        <td align="right">
            <table>
                <tr>
                    <td rowspan=3 class="Right">&nbsp;
                        <!-- img src="images/icon_emscandb.jpg" alt="logo" title="bulletin" style="width:60px;height:40px" -->
                    </td>
                    <td class="apps_login" align="right" width="30%">
                        glScanDB
                    </td>
                </tr>
                <tr>
                    <td class="apps_caps" align="right">
                        Public Notice Archiving v8.1
                    </td>
                </tr>
                <tr>
                    <td class=Right>
                        <% out.print(user.getUSERNAME()); %>
                        <img class=wspace src="images/wspacer.jpg" alt="">
                        <% out.print(glscandb.AppUtils.formatDate(null,glscandb.AppUtils.FormatDate.ddMMMyyyy));%> 
                        <span id="servertime"> <% out.print(glscandb.AppUtils.formatDate(null,glscandb.AppUtils.FormatDate.HHmmss));%></span>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
	<tr><td colspan=2><br><br></td></tr>							
</table>

<!-- menu script itself. you should not modify this file -->
<script language="JavaScript" src="scripts/menu.js"></script>
<!-- items structure. menu hierarchy and links are stored there -->
<script language="JavaScript" src="scripts/menu_items.js"></script>
<!-- files with geometry and styles structures -->
<script language="JavaScript" src="scripts/menu_tpl.js"></script>
<script type="text/javascript">
    <%if (user.getSYSROLE().equals("A")) { %>
        new menu (MENU_ITEMS_ADMIN, MENU_TPL);
    <%} else if (user.getSYSROLE().equals("H")) { %>
        new menu (MENU_ITEMS_SADMIN, MENU_TPL);
    <%} else if (user.getSYSROLE().equals("M")) { %>
        new menu (MENU_ITEMS_ROLE_MC, MENU_TPL);
    <%} else if (user.getSYSROLE().equals("C")) { %>
        new menu (MENU_ITEMS_ROLE_MC, MENU_TPL);
    <%} else if (user.getSYSROLE().equals("S")) { %>
        new menu (MENU_ITEMS_ROLE_S, MENU_TPL);
    <%} else if (user.getSYSROLE().equals("O")) { %>
        new menu (MENU_ITEMS_MR, MENU_TPL);
    <%} else { %>
        new menu (MENU_ITEMS_VIEW, MENU_TPL);
    <%}%>
</script>

<script type="text/javascript">
var serverdate=new Date()

function padlength(what){
    var output=(what.toString().length==1)? "0"+what : what
    return output
}

function displaytime(){
    serverdate.setSeconds(serverdate.getSeconds()+1)
    var timestring=padlength(serverdate.getHours())+":"+padlength(serverdate.getMinutes())+":"+padlength(serverdate.getSeconds())
    document.getElementById("servertime").innerHTML=" "+timestring
}

window.onload=function(){
    setInterval("displaytime()", 1000)
}
</script>
