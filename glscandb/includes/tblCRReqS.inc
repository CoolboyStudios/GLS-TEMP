<table id="tblCRSList">
    <thead>
        <tr>
            <th>S.No</th>
            <th>Req.No</th>
            <th>SNO</th>
            <th>Unit</th>
            <th>Ref.</th>
            <th>Cust. Name</th>
            <th>Date of Req.</th>
            <th>Search Type</th>
            <th>Search Value</th>
            <th>Requestor</th>
        </tr>
    </thead>
    <tbody>
        <tr><td colspan=10></<td></tr>
        <tr><td colspan=10>No Record(s).</<td></tr>
    </tbody>
</table>
<script type="text/javascript">
//<![CDATA[
        var tblCRSProps = {
            col_width: ["5%", "5%", "0px", "10%", "10%", "18%", "10%", "15%", "10%", "15%"],
            col_0: 'none', col_1: 'none', col_2: 'none', col_3: 'select',
            col_6: 'none', col_7: 'select',
            col_8: 'none', col_9: 'select',
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
            //on_change: false, btn: true, enter_key: false,
            
            filters_row_index: 1,
            display_all_text: "< Show all >",
            grid:true,
            grid_layout: true, grid_width: '100%', grid_height: '150px', grid_enable_cols_resizer: false,
            sort_config: { sort_types: ['number','number', 'none', 'string','string','string','dmy','string', 'string', 'string'] },

            //Selection for edit
            selectable: true,
            editable: false,
            ezEditTable_config: {
                default_selection: 'both',
                selected_row_css: 'ezSlcRow',
                on_validate_row: function(o, row){
                    if(!$('#TxtEANNOUN').is(':focus')) {
                        var id = o.Selection.GetActiveRowValues()[0];
                        var crrid = o.Selection.GetActiveRowValues()[1];
                        var sno = o.Selection.GetActiveRowValues()[2];
                        if (id !== "No Record(s).") {
                            //var un = o.Selection.GetActiveRowValues()[2];
                            funCRSrcGet(crrid, sno);
                            //alert('You have chosen record: '+ id +'\n'+crrid+'\ req no');
                        }
                    }
                }
            }
        };
        //tfCRR = setFilterGrid("tblCRSList", tblCRSProps);
    //]]>
</script>