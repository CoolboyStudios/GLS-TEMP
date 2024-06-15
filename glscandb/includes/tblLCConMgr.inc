<table id="tblLCConList">
    <thead>
        <tr>
            <th>S.No</th>
            <th>Starting</th>
            <th>Expiry on</th>
            <th>Users</th>
            <th>Reports</th>
            <th>Watch list</th>
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
        var tblLCConProps = {
            col_width: ["8%", "15%", "15%", "15%", "15%", "15%", "17%"],
            col_0: 'none',
            col_1: 'none',
            col_2: 'none',
            col_3: 'none',
            col_4: 'none',
            col_5: 'none',
            col_6: 'select',
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
            sort_config: { sort_types: ['number','number','dmy','dmy','number','number','number'] },

            //Selection for edit
            selectable: true,
            editable: false,
            ezEditTable_config: {
                default_selection: 'both'
            }
        };
        var tfLCCon; //setFilterGrid("tblLCConList", tblLCConProps);
    //]]>

</script>