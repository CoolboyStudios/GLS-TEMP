<table id=tblHisList>
    <thead>
        <tr>
            <th>S.No.</th>
            <th>User Remarks</th>
            <th>Status</th>
            <th>Date</th>
            <th>User</th>
        </tr>
    </thead>
    <tbody>
        <%
        Object olh = request.getSession().getAttribute("objListHis");
        HashMap lhhm = (HashMap) olh;
        ArrayList alKeys = AppUtils.sortHashMap(lhhm);
        HistoryCls oCls;
        int lhsno=0;
        for(int i=0;i<alKeys.size();i++)
        {
            oCls = (HistoryCls)lhhm.get(((Integer)alKeys.get(i)));
            lhsno++;
            out.print("<tr>");
                out.print(AppUtils.genTableCol(lhsno));
                out.print(AppUtils.genTableCol(((oCls.getREMARKS().isEmpty())?"-":oCls.getREMARKS())));
                out.print(AppUtils.genTableCol(oCls.getSTATUS_DESC()));
                out.print(AppUtils.genTableCol(oCls.getDTUPD(), "dd-MMM-yyyy HH:mm"));
                out.print(AppUtils.genTableCol(oCls.getUSERNAME()));
            out.print("</tr>\n");
        }
        if  (lhsno==0) {
            out.print("<tr><td colspan=5></td></tr>\n");
        }
        %>
    </tbody>
</table>
<script type="text/javascript">
//<![CDATA[
        var tblHisProps = {
            col_width: ["5%","44%","17%","17%","17%"],
            col_0: 'none',
            col_1: 'input',
            col_2: 'none',
            col_3: 'none',
            col_4: 'select',
            enable_default_theme: true,
			btn_reset: true,
            btn_reset_text: "Clear Filter",
            loader: true,			
            loader_html: "<img src=scripts/TableFilter/loader.gif alt=''>" + '<span>Loading...</span>',
            loader_css_class: 'myLoader',
			status_bar: false,
			alternate_rows: true,
			popup_filters: true,
            rows_counter: true,
            rows_counter_text: "Rows: ",
            paging: false, 
            help_instructions: false,
            
            filters_row_index:1,
            display_all_text: "< Show all >",
            grid:true,
            grid_layout: true, grid_width: '100%', grid_height: '150px', grid_enable_cols_resizer: false,
            sort_config: { sort_types: ['number','string','string','dmy', 'string'] }

            //Selection for edit
//            selectable: false,
//			editable: false,
//			ezEditTable_config: {
//				default_selection: 'both'
            //    on_validate_row: function(o, row){
			//		var id = o.Selection.GetActiveRowValues()[0];
			//		var employee = o.Selection.GetActiveRowValues()[1];
			//		alert('You have chosen record: '+ id +'\n'+employee+'\'s employee data');
			//	}
//			}
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
        var tfHisParams = setFilterGrid("tblHisList", tblHisProps);
    //]]>
</script>