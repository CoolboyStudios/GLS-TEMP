<table id="tblUnitConList">
    <thead>
        <tr>
            <th>S.No</th>
            <th>CSUID</th>
            <th>Unit/Department</th>
            <th>Status</th>
        </tr>
    </thead>
    <tbody>
        <tr  class=odd><td colspan=4></<td></tr>
        <tr  class=even><td colspan=4>No Record(s).</<td></tr>
    </tbody>
</table>
<script type="text/javascript">
//<![CDATA[
        var tblUnitConProps = {
            col_width: ["10%", "0%", "65%", "15%"],
            col_0: 'none',
            col_1: 'none',
            col_2: 'none',
            col_3: 'select',
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
            paging: false, paging_length:6,
            help_instructions:false,
            
            filters_row_index:1,
            display_all_text: "< Show all >",
            grid:true,
            grid_layout: true, grid_width: '100%', grid_height: '120px', grid_enable_cols_resizer: false,
            sort_config: { sort_types: ['number', 'none','string','string'] },

            //Selection for edit
            selectable: true,
            editable: false,
            ezEditTable_config: {
                default_selection: 'both',
                selected_row_css: 'ezSlcRow',
                on_validate_row: function(o, row){
                    var id = o.Selection.GetActiveRowValues()[0];
                    var csuid = o.Selection.GetActiveRowValues()[1];
                    var un = o.Selection.GetActiveRowValues()[2];
                    funUnitUpdate(csuid, un);
                    //alert('You have chosen record: '+ id +'\n'+caseid+'\ case data');
                }
            }
        };
        var tfUnitCon; //setFilterGrid("tblUnitConList", tblUnitConProps);
    //]]>

</script>