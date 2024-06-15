<table id=tblList>
    <thead>
        <tr>
            <th>S.No.</th>
            <th>UID</th>
            <th>Login ID</th>
            <th>Short Name</th>
            <th>Full Name</th>
            <th>BBSROLE</th>
            <th>Role</th>
            <th>BRID</th>
            <th>Branch</th>
            <th>REPTO</th>
            <th>Line Manager</th>
            <th>StatusCODE</th>
            <th>Status</th>
            <th>EMAILID</th>
            <th>MULTIROLE</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <%
        Object ol = request.getSession().getAttribute("objList");
        HashMap hm = (HashMap) ol;
        ArrayList alKeys = AppUtils.sortHashMap(hm);
        UserCls oCls;
        int sno=0;
        for(int i=0;i<alKeys.size();i++)
        {
            oCls = (UserCls)hm.get(((Integer)alKeys.get(i)));
            sno++;
            out.print("<tr>");
                out.print(AppUtils.genTableCol(sno, "####"));
                out.print(AppUtils.genTableCol(oCls.getUID(), "####"));
                out.print(AppUtils.genTableCol(oCls.getLOGINID()));
                out.print(AppUtils.genTableCol(oCls.getSHORT()));
                out.print(AppUtils.genTableCol(oCls.getUSERNAME()));
                out.print(AppUtils.genTableCol(oCls.getSYSROLE()));
                out.print(AppUtils.genTableCol(oCls.getROLE_DESC()));
                out.print(AppUtils.genTableCol(oCls.getBRID()));
                out.print(AppUtils.genTableCol(oCls.getBRID_DESC()));
                out.print(AppUtils.genTableCol(oCls.getREPTO()));
                out.print(AppUtils.genTableCol(oCls.getREPTO_DESC()));
                out.print(AppUtils.genTableCol(oCls.getSTATUS()));
                out.print(AppUtils.genTableCol(oCls.getSTATUS_DESC()));
                out.print(AppUtils.genTableCol(oCls.getEMAILID()));
                out.print(AppUtils.genTableCol(oCls.getMULTIROLE()));
            out.print("<td>");
                out.print("<img class=lnkicon18 title='Edit user details' src='images/edit_icon.png' " +
                        "onclick='javascript:funUpdate(" + (sno) + ");' >");
                out.print("<img class=wspace src='images/wspacer.jpg' alt=' '>");
                out.print("<img class=lnkicon18 title='Unlock or Reset Password (" + (oCls.getUID()) + ")' src='images/unlock.png' " +
                        "onclick='javascript:funUnLock(" + (oCls.getUID()) + ");' >");
                out.print("<img class=wspace src='images/wspacer.jpg' alt=' '>");
                out.print("<img class=lnkicon18 title='Remove or delete user (" + (oCls.getUID()) + ")' src='images/delete_icon.gif' " +
                        "onclick='javascript:funRemove(" + (oCls.getUID()) + ");' >");
            out.print("</td>");
            out.print("</tr>\n");
        }
        if  (sno==0) {
            out.print("<tr><td colspan=9></td></tr>\n");
        }
        %>
    </tbody>
</table>
<script type="text/javascript">
//<![CDATA[
        var tblProps = {
            col_width: ["4%","0px","8%","10%","20%","0px","12%","0px","12%","0px","12%","0px","8%","0px","0px","8%"],
            col_0: 'none',
            col_1: 'none',
            col_2: 'input',
            col_3: 'input',
            col_4: 'input',
            col_5: 'none',
            col_6: 'select',
            col_7: 'none',
            col_8: 'select',
            col_9: 'none',
            col_10: 'select',
            col_11: 'none',
            col_12: 'select',
            col_13: 'none',
            col_14: 'none',
            col_15: 'none',
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
            sort_config: { sort_types: ['number','none','string','string','string','none','string','none','string','none','none','string','none'] },

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
        var tfUsers = setFilterGrid("tblList", tblProps);
    //]]>
</script>