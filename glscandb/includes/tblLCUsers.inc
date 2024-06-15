<table id=tblCLUsrList>
    <thead>
        <tr>
            <th>S.No.</th>
            <th>UID</th>
            <th>Login ID</th>
            <th>User Name</th>
            <th>CLID</th>
            <th>Subscriber</th>
            <th>Sub. Expired on</th>
            <th>StatusCODE</th>
            <th>Status</th>
            <th>EMAILID</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <%
        Object ol = request.getSession().getAttribute("objList");
        HashMap hm = (HashMap) ol;
        ArrayList alKeys = AppUtils.sortHashMap(hm);
        CSUserCls oCls = new CSUserCls();
        int sno=0;
        for(int i=0;i<alKeys.size();i++)
        {
            oCls = (CSUserCls)hm.get(((Integer)alKeys.get(i)));
            sno++;
            out.print("<tr>");
                out.print(AppUtils.genTableCol(sno, "####"));
                out.print(AppUtils.genTableCol(oCls.getCUID(), "####"));
                out.print(AppUtils.genTableCol(oCls.getLOGINID()));
                out.print(AppUtils.genTableCol(oCls.getCUNAME()));
                out.print(AppUtils.genTableCol(oCls.getCSID()));
                out.print(AppUtils.genTableCol(oCls.getCSID_DESC()));
                out.print(AppUtils.genTableCol(oCls.getDTCSEXP(), "dd-MMM-yyyy"));
                out.print(AppUtils.genTableCol(oCls.getSTATUS()));
                out.print(AppUtils.genTableCol(oCls.getSTATUS_DESC()));
                out.print(AppUtils.genTableCol(oCls.getCUEMAIL()));
            out.print("<td>");
                out.print("<img class=lnkicon18 title='Edit user details' src='images/edit_icon.png' " +
                        "onclick='javascript:funUpdate(" + (oCls.getCUID()) + ");' >");
                out.print("<img class=wspace src='images/wspacer.jpg' alt=' '>");
                out.print("<img class=lnkicon18 title='Unlock (" + (oCls.getCUID()) + ")' src='images/unlock.png' " +
                        "onclick='javascript:funUnLock(" + (oCls.getCUID()) + ");' >");
                out.print("<img class=wspace src='images/wspacer.jpg' alt=' '>");
                out.print("<img class=lnkicon18 title='Reset (" + (oCls.getCUID()) + ")' src='images/key.png' " +
                        "onclick='javascript:funResetPWD(" + (oCls.getCUID()) + ");' >");
                out.print("<img class=wspace src='images/wspacer.jpg' alt=' '>");
                out.print("<img class=lnkicon18 title='Mark as in-active (" + (oCls.getCUID()) + ")' src='images/ina_user_icon.jpg' " +
                        "onclick='javascript:funInActive(" + (oCls.getCUID()) + ");' >");
                out.print("<img class=wspace src='images/wspacer.jpg' alt=' '>");
                out.print("<img class=lnkicon18 title='Remove (" + (oCls.getCUID()) + ")' src='images/delete_icon.gif' " +
                        "onclick='javascript:funRemove(" + (oCls.getCUID()) + ");' >");
            out.print("</td>");
            out.print("</tr>\n");
        }
        if  (sno==0) {
            out.print("<tr><td colspan=11></td></tr>\n");
        }
        %>
    </tbody>
</table>
<script type="text/javascript">
//<![CDATA[
        var tblProps = {
            col_width: ["5%","0px","12%","20%","0px","15%","12%","0px","15%","0px","15%"],
            col_0: 'none',
            col_1: 'none',
            col_2: 'input',
            col_3: 'input',
            col_4: 'none',
            col_5: 'select',
            col_6: 'input',
            col_7: 'none',
            col_8: 'select',
            col_9: 'none',
            col_10: 'none',
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
            sort_config: { sort_types: ['number','none','string','string','none','string','dmy','none','string','none','none'] },

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
        var tfUsers = setFilterGrid("tblCLUsrList", tblProps);
    //]]>


</script>
