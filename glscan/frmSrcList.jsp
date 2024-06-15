<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap,java.util.ArrayList"%>
<%@page import="glscan.classes.UserCls,glscan.AppUtils,glscan.classes.NoticeCls"%>
<%@ include file="includes/SessionValid.inc" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link type="text/css" rel="stylesheet" href="scripts/AppStyle.css">
        <link type="text/css" rel="stylesheet" href="scripts/jquery/smoothness/jquery-ui.min.css">
        <script type="text/javascript" src="scripts/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery-ui.min.js"></script>
        <script type="text/javascript" src="scripts/TableFilter/tablefilter_all.js"></script>
        <script type="text/javascript" src="scripts/AppsUtil.js"></script>
        
    </head>
    <body>
        <table id=tblSearchList>
                <tr>
                    <th></th>
                    <th class="center">Notice Text<br> نص الإشعار</th>
                    <th class="center">Trade License/ Passport/Case No.<br>رقم الرخصة التجارية/جواز السفر/البلاغ</th>
                    <th class="center">Name of Individual/Entity<br> إسم الشخص/الشركة</th>
                    <th class="center">Date of Publication<br> تاريخ النشر</th>
                    <th class="center">Type of Notice<br> نوع الإشعار</th>
                    <th class="center">Newspaper<br> الصحيفة</th>
                </tr>
                <%
                    Object olh = request.getSession().getAttribute("objList");
                    HashMap lhhm = (HashMap) olh;
                    ArrayList alKeys = AppUtils.sortHashMap(lhhm);
                    NoticeCls oCls;
                    int lhsno=0;
                    String fname;
                    for(int i=0;i<alKeys.size();i++)
                    {
                        oCls = (NoticeCls)lhhm.get(((Integer)alKeys.get(i)));
                        lhsno++;
                        
                        out.print("<tr>");
                            out.print(AppUtils.genTableCol(oCls.getNID(), "#######" ));
                            out.print(AppUtils.genTableCol(oCls.getANNOUN(), AppUtils.FormatAlign.right));
                            out.print(AppUtils.genTableCol(oCls.getCPPTLNO(), AppUtils.FormatAlign.right));
                            out.print(AppUtils.genTableCol(oCls.getCNAME(), AppUtils.FormatAlign.right));
                            out.print(AppUtils.genTableCol(oCls.getDTREL(), AppUtils.FormatAlign.right));
                            out.print(AppUtils.genTableCol(oCls.getNTID_DESC(), AppUtils.FormatAlign.right));
                            out.print(AppUtils.genTableCol(oCls.getNPID_DESC(), AppUtils.FormatAlign.right));
                        out.print("</tr>\n");
                    }
                    if  (lhsno==0) {
                        out.print("<tr class=odd><td colspan=7>No Record(s) found.</<td></tr>\n");
                    }
                %>
        </table>
    </body>
    <script type="text/javascript">
        //<![CDATA[
            var tblNSRCHProps = {
                col_width: ["0px","350px","150px","200px","90px","75px","75px"],
                col_0: 'none', col_1: 'none', col_2: 'none',col_3: 'none',
                col_4: 'none', col_5: 'none',col_6: 'none',
                enable_default_theme: true, btn_reset: false, btn_reset_text: "Clear Filter", 
                base_path:'scripts/TableFilter/',
                loader_html: "<img src='scripts/TableFilter/loader.gif' alt=''>" + '<span>Loading...</span>',
                loader: true, loader_css_class: 'myLoader',
                status_bar: false, alternate_rows: true, popup_filters: true,
                rows_counter: true, rows_counter_text: "Displayed rows: ",
                paging: false, paging_length:20, help_instructions:false,
                filters_row_index:1, display_all_text: "< Show all >",

                grid:true, grid_layout: true, grid_width:'995px',grid_height: '270px', grid_enable_cols_resizer: false,
                sort_config: { sort_types: ['number','string','string','string','dmy','string','string'] },
                //Selection for edit
                selectable: true, editable: false,
                ezEditTable_config: {default_selection: 'both',
                    selected_row_css: 'ezSlcRow',
                    on_validate_row: function(o, row){
                        var id = o.Selection.GetActiveRowValues()[0];
                        //var caseid = o.Selection.GetActiveRowValues()[1];
                        parent.funReport(id);
                        //alert('You have chosen record: '+ id );
                    }
                }
            };
        //]]>
        var tfList = setFilterGrid("tblSearchList", tblNSRCHProps);
        
    </script>
</html>
