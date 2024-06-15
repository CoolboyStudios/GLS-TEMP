<table id=tblList>
    <thead>
        <tr>
            <th>S.No.</th>
            <th>PID</th>
            <th>Code</th>
            <th>Value</th>
            <th>StatusCODE</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <%
        Object ol = request.getSession().getAttribute("objList");
        HashMap hm = (HashMap) ol;
        ArrayList alKeys = AppUtils.sortHashMap(hm);
        ParamCls oCls;
        int sno=0;
        for(int i=0;i<alKeys.size();i++)
        {
            oCls = (ParamCls)hm.get(((Integer)alKeys.get(i)));
            sno++;
            out.print("<tr>");
                out.print(AppUtils.genTableCol(sno, "####"));
                out.print(AppUtils.genTableCol(oCls.getPID() , "####"));
                out.print(AppUtils.genTableCol(oCls.getPKEY()));
                out.print(AppUtils.genTableCol(oCls.getPVALUE()));
                out.print(AppUtils.genTableCol(oCls.getSTATUS()));
                out.print(AppUtils.genTableCol(oCls.getSTATUS_DESC()));
            out.print("<td>");
                out.print("<img class=lnkicon18 title='Edit' src='images/edit_icon.png' " +
                        "onclick='javascript:funUpdate(" + (sno) + ");' >");
                out.print("<img class=wspace src='images/wspacer.jpg' alt=' '>");
                out.print("<img class=lnkicon18 title='Remove (" + (oCls.getPID()) + ")' src='images/delete_icon.gif' " +
                        "onclick='javascript:funRemove(" + (oCls.getPID()) + ");' >");
            out.print("</td>");
            out.print("</tr>\n");
        }
        if  (sno==0) {
            out.print("<tr><td colspan=7></td></tr>\n");
        }
        %>
    </tbody>
</table>
<script type="text/javascript">
//<![CDATA[
        var tblProps = {
            col_width: ["5%","0px","20%","55%","0px","20%","10%"],
            col_0: 'none',
            col_1: 'none',
            col_4: 'none',
            col_5: 'select',
            col_6: 'none',
            enable_default_theme: true,
			btn_reset: true,
            btn_reset_text: "Clear Filter",
            loader: true,			
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
            sort_config: { sort_types: ['number','string','string','string', 'none'] },

            //Selection for edit
            selectable: true,
            editable: false,
            ezEditTable_config: {
				default_selection: 'both'
            }
        };
        var tfParams = setFilterGrid("tblList", tblProps);
    //]]>
</script>