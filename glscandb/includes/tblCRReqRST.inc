<table id="tblCRRSTList">
    <thead>
        <tr>
            <th>S.No</th>
            <th>SNO</th>
            <th>STYPE</th>
            <th>Search Type</th>
            <th>Value in English</th>
            <th>Value in Arabic</th>
            <th>Status</th>
        </tr>
    </thead>
    <tbody>
        <tr  class=odd><td colspan=7></<td></tr>
        <tr  class=even><td colspan=7>No Record(s).</<td></tr>
    </tbody>
</table>
<script type="text/javascript">
//<![CDATA[
        var tblCRRSTProps = {
            col_width: ["40px", "0%", "0%", "100px", "80px", "80px", "80px"],
            col_0: 'none',
            col_1: 'none',
            col_2: 'none',
            col_3: 'none',
            col_4: 'none',
            col_5: 'select',
            enable_default_theme: true,
            btn_reset: false,
            btn_reset_text: "Clear Filter",
            loader: true,		 
            loader_html: "<img src=scripts/TableFilter/loader.gif alt=''>" + '<span>Loading...</span>',
            loader_css_class: 'myLoader',
			status_bar: false,
			alternate_rows: true,
			popup_filters: true,
            rows_counter: false,
            rows_counter_text: "Rows: ",
            paging: false, paging_length:5,
            help_instructions:false,
            
            filters_row_index:1,
            display_all_text: "< Show all >",
            grid:true,
            grid_layout: true, grid_width: '100%', grid_height: '150px', grid_enable_cols_resizer: false,
            sort_config: { sort_types: ['number','none','none','string','string','string'] },

            //Selection for edit
            selectable: true,
            editable: false,
            ezEditTable_config: {
                default_selection: 'both',
                selected_row_css: 'ezSlcRow',
                on_validate_row: function(o, row){
                    var id = o.Selection.GetActiveRowValues()[0];
                    var crrsno = o.Selection.GetActiveRowValues()[1];
                    var st = o.Selection.GetActiveRowValues()[2];
                    var eval = o.Selection.GetActiveRowValues()[4];
                    var aval = o.Selection.GetActiveRowValues()[5];
                    if (id !== "No Record(s).") {
                        //var un = o.Selection.GetActiveRowValues()[2];
                        funCRReqSTUpd(crrsno,st,eval,aval);
                        //alert('You have chosen record: '+ id +'\n'+crrid+'\ req no');
                    }
                }
            }
        };
        tfCRRST = setFilterGrid("tblCRRSTList", tblCRRSTProps);
    //]]>

</script>