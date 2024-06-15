<div id="banner-slide" style="margin:0 auto;">
<ul class="bjqs">
    <%
        Object odl = request.getSession().getAttribute("objDocList");
        HashMap hm = (HashMap) odl;
        ArrayList aldKeys = AppUtils.sortHashMap(hm);
        UploadCls oUpld = new UploadCls();
        int ldsno=0; String ifname, lblStr, btnStr;
        String jscript="";
        for(int i=0;i<aldKeys.size();i++)
        {
            ldsno++;
            oUpld = (UploadCls)hm.get(((Integer)aldKeys.get(i)));
            
            ifname = "Uploads/" + oUpld.getIFOLDER() + "/" + oUpld.getIFNAME();
            lblStr = "Pg#:" + oUpld.getPGNO() + " Status:" + oUpld.getSTATUS_DESC();
            
            btnStr = "";            
            if ((oUpld.getSTATUS().equals("U") || oUpld.getSTATUS().equals("S")||oUpld.getSTATUS().equals("T")) && (oUpld.getADNOE()==0)) {
                btnStr = " <img src=images/wspacer.jpg hspace=4> ";
                btnStr = btnStr + " <img src=images/delete_icon.gif alt=Remove title=\"Remove\" class=lnkicon18 onclick=funRemove("+ oUpld.getUPID() + ");> ";
            }
            
            if ((oUpld.getSTATUS().equals("U") || oUpld.getSTATUS().equals("S")||oUpld.getSTATUS().equals("T") || oUpld.getSTATUS().equals("A")) && (oUpld.getNTID() == 0)) {
                if (oUpld.getADNO() > 1) {
                    btnStr = btnStr + " <img src=images/wspacer.jpg hspace=4> ";
                    btnStr = btnStr + "<input id=\"TxtADNO_" + oUpld.getUPID() + "\" type=text size=3 title=\"No Group Ads\" value=" + oUpld.getADNO() + ">";
                }
                btnStr = btnStr + "<img src=images/wspacer.jpg hspace=4>";
                btnStr = btnStr + "<select class=arabic id=\"CboNTID_" + oUpld.getUPID() + 
                            "\"><option></option></select>";
                btnStr = btnStr + "<input id=\"btnNTID_" + oUpld.getUPID() + "\" type=button title=\"Update the type\" value=Save onclick=onchange=funChangeNTID("+ oUpld.getUPID() + ");";
                jscript = jscript + "fnFillCombo('CboNTID_" + oUpld.getUPID() + "', params, 'NT', 'UAS');";
            } else {
                btnStr = btnStr + "<img src=images/wspacer.jpg hspace=4>" + oUpld.getNTID_DESC() ;
            }
            out.print("<li><img class=imgZoom src='"+ ifname +"' title='"+ oUpld.getIFNAME() + " (" +  lblStr +") " + btnStr + " '></li>");
        }
        
        if (ldsno == 1) {
            out.print("<li><img src='images/wspacer.jpg' title='only one image'></li>"); 
        }
        if (ldsno > 1) {
            out.print("<li id=liremove><img src='images/wspacer.jpg' title='The End'></li>"); 
        }
        if (ldsno != 0) {
            out.print("\n<script type=\"text/javascript\">\n");
                out.print("$(document).ready(function() {\n");
                out.print("fnSetCbo('CboNPID', '" + oUpld.getNPID() + "');");
                out.print("fnSetCbo('CboNTID', '" + oUpld.getNTID() + "');");
                out.print("fnSetText('TxtDTREL', '" + AppUtils.formatDate(oUpld.getDTREL(), AppUtils.FormatDate.ddMMyyyy) + "');");
                out.print("fnSetText('TxtRELNO', '" + oUpld.getNPRNO() + "');");
                out.print("fnSetText('TxtPGNO', '" + oUpld.getPGNO() + "');");
                out.print("fnSetCbo('CboADNO', '" + (oUpld.getADNO()>1?"M":"S") + "');");
                out.print("funCboADNO_Change();");
                out.print("fnSetText('TxtADNO', '" + oUpld.getADNO() + "');");
                //out.print(jscript);
                out.print("\n});");
            out.print("</script>\n");
        }
    %>
</ul>
</div>