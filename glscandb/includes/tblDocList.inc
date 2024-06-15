<table id=tblDocList>
    <thead>
        <tr>
            <th>S.No.</th>
            <th>Document Name</th>
            <th>Size</th>
            <th>Uploaded On</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <%
        Object odl = request.getSession().getAttribute("objDocList");
        HashMap hm = (HashMap) odl;
        ArrayList aldKeys = AppUtils.sortHashMap(hm);
        DocsLstCls oDCls;
        int ldsno=0;
        for(int i=0;i<aldKeys.size();i++)
        {
            oDCls = (DocsLstCls)hm.get(((Integer)aldKeys.get(i)));
            ldsno++;
            out.print("<tr>");
                out.print(AppUtils.genTableCol(ldsno));
                out.print(AppUtils.genTableCol(oDCls.getFNAME()));
                out.print(AppUtils.genTableCol(oDCls.getFSIZE()));
                out.print(AppUtils.genTableCol(oDCls.getUPDDATE()));
            out.print("<td>");
                if (oDCls.getCPID() != -1) {
                    out.print("<img class=lnkicon18 title='view' src='images/view_icon.png' " +
                            "onclick='javascript:funViewFile(\"UID_" + oDCls.getSNO() + "/" + (oDCls.getFNAME()) + "\");' >");
                    out.print("<img class=wspace src='images/wspacer.jpg' alt=' '>"); 
                    out.print("<img class=lnkicon18 title='download' src='images/down_icon.png' " +
                        "onclick='javascript:funDownFile(\"UID_" + oDCls.getSNO() + "/" + (oDCls.getFNAME()) + "\");' >");
                } else {
                    out.print("<img class=lnkicon18 title='Edit' src='images/down_icon.png' " +
                        "onclick='javascript:funDownFile(\"" + (oDCls.getFNAME()) + "\", \"" + (oDCls.getDOCTYPE()) + "\");' >");
                }
            out.print("</td>");
            out.print("</tr>\n");
        }
        if  (ldsno==0) {
            out.print("<tr><td colspan=5></td></tr>\n");
        }
        %>
    </tbody>
</table>
<script type="text/javascript">
//<![CDATA[
        var tblDocProps = {
            col_width: ["8%","50%","12%","20%","10%"],
            col_0: 'none',
            col_1: 'input',
            col_2: 'none',
            col_3: 'input',
            col_4: 'none',
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
            paging: false,
            help_instructions:false,
            
            filters_row_index:1,
            display_all_text: "< Show all >",
            grid:true,
            grid_layout: true, grid_width: '100%', grid_height: '80px', grid_enable_cols_resizer: false,
            sort_config: { sort_types: ['number','string','none','string','none'] },

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
        var tfDocParams = setFilterGrid("tblDocList", tblDocProps);
    //]]>
</script>