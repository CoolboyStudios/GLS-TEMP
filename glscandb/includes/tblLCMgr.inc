<table id=tblLCList>
    <thead>
        <tr>
            <th>S.No.</th>
            <th>CLID</th>
            <th>Short Name</th>
            <th>Full Name</th>
            <th>LTYPE</th>
            <th>License</th>
            <th>Start Date</th>
            <th>End Date</th>
            <th>No Users</th>
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
        ClientLicCls oCls;
        int sno=0;
        for(int i=0;i<alKeys.size();i++)
        {
            oCls = (ClientLicCls)hm.get(((Integer)alKeys.get(i)));
            sno++;
            out.print("<tr>");
                out.print(AppUtils.genTableCol(sno, "####"));
                out.print(AppUtils.genTableCol(oCls.getCLID(), "####"));
                out.print(AppUtils.genTableCol(oCls.getCSHORT()));
                out.print(AppUtils.genTableCol(oCls.getCNAME()));
                out.print(AppUtils.genTableCol(oCls.getLTYPE()));
                out.print(AppUtils.genTableCol(oCls.getLTYPE_DESC()));
                out.print(AppUtils.genTableCol(oCls.getDTSTART(), "dd-MM-yyyy"));
                out.print(AppUtils.genTableCol(oCls.getDTEND(), "dd-MM-yyyy"));
                out.print(AppUtils.genTableCol(oCls.getNOUSER()));
                out.print(AppUtils.genTableCol(oCls.getSTATUS()));
                out.print(AppUtils.genTableCol(oCls.getSTATUS_DESC()));
            out.print("<td>");
                out.print("<img class=lnkicon18 title='Edit user details' src='images/edit_icon.png' " +
                        "onclick='javascript:funUpdate(" + (sno) + ");' >");
                out.print("<img class=wspace src='images/wspacer.jpg' alt=' '>");
                out.print("<img class=lnkicon18 title='Remove or delete user (" + (oCls.getCLID()) + ")' src='images/delete_icon.gif' " +
                        "onclick='javascript:funRemove(" + (oCls.getCLID()) + ");' >");
            out.print("</td>");
            out.print("</tr>\n");
        }
        if  (sno==0) {
            out.print("<tr><td colspan=12></td></tr>\n");
        }
        %>
    </tbody>
</table>
<script type="text/javascript">
//<![CDATA[
        var tblProps = {
            col_width: ["5%","0px","10%","25%","0px","10%","10%","10%","10%","0px","10%","10%"],
            col_0: 'none',
            col_1: 'none',
            col_2: 'input',
            col_3: 'input',
            col_4: 'none',
            col_5: 'select',
            col_6: 'input',
            col_7: 'input',
            col_8: 'select',
            col_9: 'none',
            col_10: 'select',
            col_11: 'none',
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
            sort_config: { sort_types: ['number','none','string','string','none','string','dmy','dmy','number','none','string','none'] },

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
        var tfUsers = setFilterGrid("tblLCList", tblProps);
    //]]>
</script>