<table id=tblLCSubList>
    <thead>
        <tr>
            <th>S.No.</th>
            <th>CSID</th>
            <th>Short Name</th>
            <th>Full Name</th>
            <th>Category</th>
            <th>Person</th>
            <th>Mobile</th>
            <th>Phone</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <%
        Object ol = request.getSession().getAttribute("objList");
        HashMap hm = (HashMap) ol;
        ArrayList alKeys = AppUtils.sortHashMap(hm);
        ClientSubCls oCls;
        int sno=0;
        for(int i=0;i<alKeys.size();i++)
        {
            oCls = (ClientSubCls)hm.get(((Integer)alKeys.get(i)));
            sno++;
            out.print("<tr>");
                out.print(AppUtils.genTableCol(sno, "####"));
                out.print(AppUtils.genTableCol(oCls.getCSID(), "####"));
                out.print(AppUtils.genTableCol(oCls.getCSSHORT()));
                out.print(AppUtils.genTableCol(oCls.getCSNAME()));
                out.print(AppUtils.genTableCol(oCls.getCCAT_DESC()));
                out.print(AppUtils.genTableCol(oCls.getCPNAME()));
                out.print(AppUtils.genTableCol(oCls.getCPMOB()));
                out.print(AppUtils.genTableCol(oCls.getCPPHNO()));
                out.print(AppUtils.genTableCol(oCls.getSTATUS_DESC()));
            out.print("<td>");
                out.print("<img class=lnkicon18 title='Edit details' src='images/edit_icon.png' " +
                        "onclick='javascript:funUpdate(" + (oCls.getCSID()) + ");' >");
                out.print("<img class=wspace src='images/wspacer.jpg' alt=' '>");
                out.print("<img class=lnkicon18 title='Remove or delete (" + (oCls.getCSID()) + ")' src='images/delete_icon.gif' " +
                        "onclick='javascript:funRemove(" + (oCls.getCSID()) + ");' >");
            out.print("</td>");
            out.print("</tr>\n");
        }
        if  (sno==0) {
            out.print("<tr><td colspan=10></td></tr>\n");
        }
        %>
    </tbody>
</table>
<script type="text/javascript">
//<![CDATA[
        var tblLCSubProps = {
            col_width: ["5%","0px","10%","25%","10%","10%","10%","10%","10%","10%"],
            col_0: 'none',
            col_1: 'none',
            col_2: 'input',
            col_3: 'input',
            col_4: 'select',
            col_5: 'input',
            col_6: 'input',
            col_7: 'select',
            col_8: 'select',
            col_9: 'none',
            enable_default_theme: true,
			btn_reset: true,
            btn_reset_text: "Clear Filter",
            loader: true,			
            //mark_active_columns: true,  
            loader_html: "<img src=scripts/TableFilter/loader.gif alt=''>" + '<span>Loading...</span>',
            loader_css_class: 'myLoader',
			status_bar: true,
			alternate_rows: true,
			popup_filters: true,
            rows_counter: true,
            rows_counter_text: "Rows: ",
            paging: true, paging_length:13,
            help_instructions:false,
            
            filters_row_index:1,
            display_all_text: "< Show all >",
            grid:true,
            grid_layout: true, grid_width: '100%', grid_height: '300px', grid_enable_cols_resizer: false,
            sort_config: { sort_types: ['number','none','string','string','string','string','string','number','string','none'] },

            //Selection for edit
            selectable: true,
            editable: false,
            ezEditTable_config: {
                default_selection: 'both'
            }
        };
        var tfLCSub = setFilterGrid("tblLCSubList", tblLCSubProps);
    //]]>
</script>