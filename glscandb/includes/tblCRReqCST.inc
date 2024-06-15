<table id="tblCRCSTList">
    <thead>
        <tr>
            <th>S.No</th>
            <th>SNO</th>
            <th>STYPE</th>
            <th>Search Type</th>
            <th>Status</th>
            <th>No.Ads</th>
            <th>Observation</th>
            <th>Value in English</th>
            <th>Value in Arabic</th>
        </tr>
    </thead>
    <tbody>
        <tr><td colspan=9></<td></tr>
        <tr><td colspan=9>No Record(s).</<td></tr>
    </tbody>
</table>
<script type="text/javascript">
//<![CDATA[
        var tblCRCSTProps = {
            col_width: ["40px", "0%", "0%", "80px", "80px", "40px", "80px", "80px", "80px"],
            col_0: 'none', col_1: 'none', col_2: 'none',
            col_3: 'none', col_4: 'none', col_5: 'none',
            col_6: 'none', col_7: 'none', col_8: 'none',
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
            sort_config: { sort_types: ['number','none','none','string','number','string','string','string'] },

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
                    var rem = o.Selection.GetActiveRowValues()[6];
                    var aval = o.Selection.GetActiveRowValues()[8];
                    if (id !== "No Record(s).") {
                        //var un = o.Selection.GetActiveRowValues()[2];
                        funCRReqSTUpd(crrsno,st,rem,aval);
                        //alert('You have chosen record: '+ id +'\n'+crrid+'\ req no');
                    }
                }
            }
        };
        tfCRCST = setFilterGrid("tblCRCSTList", tblCRCSTProps);
    //]]>

</script>