<table id=tblMyPend>
    <thead>
        <tr>
            <th>S.No.</th>
            <th>Seq No</th>
            <th>Newspaper</th>
            <th>Type</th>
            <th>Date</th>
            <th>Rel.No</th>
            <th>Status</th>
            <th>Maker</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <%
        Object olh = request.getSession().getAttribute("objList");
        HashMap lhhm = (HashMap) olh;
        ArrayList alKeys = AppUtils.sortHashMap(lhhm);
        MyPendCls oCls;
        int lhsno=0; String fname;
        for(int i=0;i<alKeys.size();i++)
        {
            oCls = (MyPendCls)lhhm.get(((Integer)alKeys.get(i)));
            lhsno++;
            out.print("<tr>");
                out.print(AppUtils.genTableCol(lhsno, "####"));
                out.print(AppUtils.genTableCol(oCls.getUPID(), "####"));
                out.print(AppUtils.genTableCol(oCls.getNPID_DESC()));
                out.print(AppUtils.genTableCol(oCls.getNTID_DESC()));
                out.print(AppUtils.genTableCol(AppUtils.formatDate(oCls.getDTREL(), AppUtils.FormatDate.ddMMyyyy)));
                out.print(AppUtils.genTableCol(oCls.getNPRNO()));
                out.print(AppUtils.genTableCol(oCls.getSTATUS_DESC()));
                out.print(AppUtils.genTableCol(oCls.getMAKE_DESC()));
                out.print("<td>");
                    fname = "Uploads/" + oCls.getIFOLDER() + "/" + oCls.getIFNAME();
                    out.print("<a id='single_image' href='" + fname + "' title='Notice Image'> <img class=lnkicon18 src='images/notice_icon.png' alt=''/></a>");
                    out.print("<img hspace='4' src='images/wspacer.jpg' >");
                    out.print("<img class=lnkicon18 title='New/Edit' src='images/edit_icon.png' " +
                            "onclick='javascript:funUpdate(" + oCls.getNID() + "," + oCls.getUPID() + ", \"E\");' >");
                out.print("</td>");
            out.print("</tr>\n");
        }
        if  (lhsno==0) {
            out.print("<tr><td colspan=8></td></tr>\n");
        }
        %>
    </tbody>
</table>
<script type="text/javascript">
//<![CDATA[
        var tblProps = {
            col_width: ["6%","8%","16%","16%","10%","10%","16%","10%","8%"],
            col_0: 'none',
            col_2: 'select',
            col_6: 'select',
            col_7: 'none',
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
            sort_config: { sort_types: ['number','number','string','string','dmy','string','string','string', 'none'] },

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
        var tfParams = setFilterGrid("tblMyPend", tblProps);
    //]]>
</script>