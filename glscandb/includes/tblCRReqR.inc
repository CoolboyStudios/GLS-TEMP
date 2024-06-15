<table id="tblCRRList">
    <thead>
        <tr>
            <th>S.No</th>
            <th>Req.No</th>
            <th>Client Ref</th>
            <th>Cust. Name</th>
            <th>Requstor</th>
            <th>Unit</th>
            <th>Date of Req.</th>
            <th>Status</th>
        </tr>
    </thead>
    <tbody>
        <tr><td colspan=8></<td></tr>
        <tr><td colspan=8>No Record(s).</<td></tr>
    </tbody>
</table>
<script type="text/javascript">
//<![CDATA[
        var tblCRRProps = {
            col_width: ["5%", "10%", "11%", "20%", "15%", "7%", "15%", "15%"],
            col_0: 'none',
            col_5: 'select',
            col_7: 'select',
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
            paging: true, paging_length:6,
            help_instructions:false,
            
            filters_row_index:1,
            display_all_text: "< Show all >",
            grid:true,
            grid_layout: true, grid_width: '100%', grid_height: '150px', grid_enable_cols_resizer: false,
            sort_config: { sort_types: ['number','number','string','string','string','dmy','string'] },

            //Selection for edit
            selectable: true,
            editable: false,
            ezEditTable_config: {
                default_selection: 'both',
                selected_row_css: 'ezSlcRow',
                on_validate_row: function(o, row){
                    var id = o.Selection.GetActiveRowValues()[0];
                    var crrid = o.Selection.GetActiveRowValues()[1];
                    if (id !== "No Record(s).") {
                        //var un = o.Selection.GetActiveRowValues()[2];
                        funCRReqGet(crrid);
                        //alert('You have chosen record: '+ id +'\n'+crrid+'\ req no');
                    }
                }
            }
        };
        //tfCRR = setFilterGrid("tblCRRList", tblCRRProps);
    //]]>

</script>