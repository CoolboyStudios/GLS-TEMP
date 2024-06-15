<table id=tblAllocP>
    <thead>
        <tr>
            <th>S.No.</th>
            <th>UID</th>
            <th>User Name</th>
            <th>Role</th>
            <th>Branch</th>
            <th>In Queue</th>
            <th></th>
            <th>Assign Qty</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td class=Right>Total</td>
            <td id="lblTotal"></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <%
        Object ol = request.getSession().getAttribute("objList");
        HashMap hm = (HashMap) ol;
        ArrayList alKeys = AppUtils.sortHashMap(hm);
        AllocPCls oCls = null;
        int sno=0;
        for(int i=0;i<alKeys.size();i++)
        {
            oCls = (AllocPCls)hm.get(((Integer)alKeys.get(i)));
            sno++;
            out.print("<tr>");
                out.print(AppUtils.genTableCol(sno));
                out.print(AppUtils.genTableCol(oCls.getUID(), "####"));
                out.print(AppUtils.genTableCol(oCls.getUID_DESC()));
                out.print(AppUtils.genTableCol(oCls.getROLE_DESC()));
                out.print(AppUtils.genTableCol(oCls.getBRID_DESC()));
                out.print(AppUtils.genTableCol("<span id='lblINQUEUE" + oCls.getUID() + "' class=center>" + oCls.getPENDNOS() + "</span>" ));
                out.print("<td>");
                    out.print("<input type=button value='deallocate all' "+ 
                                    "onclick=\"javascript:funDeAlloctUID("+ oCls.getUID() + ");\" >");
                out.print("</td>");
                out.print("<td class=Right>");
                    out.print("<input type=text size=3 id='TxtANO"+ oCls.getUID() +"' maskInputTo(this, 3, 0, false);>");
                out.print("</td>");
                out.print("<td>");
                    out.print("<input type=button value=assign  onclick=\"javascript:funAlloctUID("+ oCls.getUID() + ");\" >");
                out.print("</td>");
            out.print("</tr>\n");
        }
        if  (sno==0) {
            out.print("<tr><td colspan=9></td></tr>\n");
        } else {
            out.print("\n<script type='text/javascript'>");
            //out.print("$('#lblNEEDALOC').text('"+ oCls.getNEEDALOC() + "');");
            out.print("</script>\n");
        }
        %>
    </tbody>
</table>
<script type="text/javascript">
//<![CDATA[
        var totRowIndex = tf_Tag(tf_Id('tblAllocP'), "tr").length;
        var tblProps = {
            col_width: ["10%","0px","22%","12%","12%","10%","12%","10%","12%"],
            col_0: 'none',
            col_1: 'none',
            col_2: 'none',
            col_3: 'none',
            col_4: 'none',
            col_5: 'none',
            col_6: 'none',
            col_7: 'none',
            col_8: 'none',
            enable_default_theme: true,
			btn_reset: false,
            btn_reset_text: "Clear Filter",
            loader: true,			
            loader_html: "<img src=scripts/TableFilter/loader.gif alt=''>" + '<span>Loading...</span>',
            loader_css_class: 'myLoader',
			status_bar: false,
			alternate_rows: true,
			popup_filters: false,
            rows_counter: false,
            rows_counter_text: "Rows: ",
            paging: false, paging_length:13,
            help_instructions: false,
            col_operation: {
                id: ["lblTotal"],
                col: [5],
                operation: ["sum"],
                write_method: ["innerHTML"],
                exclude_row: [1],
                decimal_precision: [0]
            },
    
            filters_row_index:1,
            display_all_text: "< Show all >",
            grid:true,
            grid_layout: true, grid_width: '100%', grid_height: '250px', grid_enable_cols_resizer: false,
            //sort_config: { sort_types: ['number','none','string','string','string','none','string','none','string','none','none','string','none'] },

            //Selection for edit
            selectable: true,
			editable: false,
			ezEditTable_config: {
				default_selection: 'both'
            //    on_validate_row: function(o, row){
			//		var id = o.Selection.GetActiveRowValues()[0];
			//		var employee = o.Selection.GetActiveRowValues()[1];
			//		alert('You have chosen record: '+ id +'\n'+employee+'\'s employee data');
			//	}
			}
            //Column resize feature
			//extensions: { 	
			//				name:['ColumnsResizer'], 
			//				src:['TableFilter/TFExt_ColsResizer.js'], 
			//				description:['Columns Resizing'], 
			//				initialize:[function(o){o.SetColsResizer();}]
			//			},
			//col_resizer_all_cells: false
            /*** Extensions manager ***/
            //extensions: { 
            //    /*** Columns Visibility Manager extension load ***/	
            //    name:['ColsVisibility'], 
            //   src:['TableFilter/TF_Ext_ColsVisibility/TFExt_ColsVisibility.js'], 
            //    description:['Columns visibility manager'], 
            //    initialize:[function(o){o.SetColsVisibility();}] 
            //},
            //showHide_cols_manager: false
        };
        var tfUsers = setFilterGrid("tblAllocP", tblProps);
    //]]>

</script>