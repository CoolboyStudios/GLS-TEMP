<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap,java.util.ArrayList"%>
<%@page import="glscan.classes.UserCls,glscan.AppUtils,glscan.classes.CWatchCls"%>
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
        <table id=tblWSearchList>
                <tr>
                    <th>WID</th>
                    <th class="center">Status<br>الحالة</th>
                    <th class="center">Number of Ads<br>عدد الإعلانات</th>
                    <th class="center">Trade License/ Passport/Case No.<br>رقم الرخصة التجارية/جواز السفر/البلاغ</th>
                    <th class="center">Name of Individual/Entity<br>إسم الشخص/الشركة</th>
                    <th class="center">Subscriber Ref. No.<br>الرقم المرجعي للمشترك</th>
                </tr>
                <%
                    Object olh = request.getSession().getAttribute("objList");
                    HashMap lhhm = (HashMap) olh;
                    ArrayList alKeys = AppUtils.sortHashMap(lhhm);
                    CWatchCls oCls;
                    int lhsno=0;
                    String fname;
                    for(int i=0;i<alKeys.size();i++)
                    {
                        oCls = (CWatchCls)lhhm.get(((Integer)alKeys.get(i)));
                        lhsno++;
                        out.print("<tr>");
                            out.print(AppUtils.genTableCol(oCls.getCWID(), "#######" ));
                            out.print(AppUtils.genTableCol(oCls.getSTATUS(), AppUtils.FormatAlign.right));
                            out.print("<td valign=top align=Center>");
                                if (oCls.getWLINOADS()!=0) {
                                    out.print("<a style='color:blue' href='#' onclick='javascript:parent.funListWLN(" + oCls.getCWID() + ");' >");
                                    out.print(oCls.getWLINOADS() + "</a>");
                                } else {
                                    out.print("-");
                                }
                            out.print("</td>");                            
                            out.print(AppUtils.genTableCol(oCls.getPPTLNO(), AppUtils.FormatAlign.right));
                            out.print(AppUtils.genTableCol(oCls.getANAME(), AppUtils.FormatAlign.right));
                            out.print(AppUtils.genTableCol(oCls.getREFNO(), AppUtils.FormatAlign.right));
                        out.print("</tr>\n");
                    }
                    if  (lhsno==0) {
                        out.print("<tr class=odd><td colspan=6>No Record(s) found.</<td></tr>\n");
                    }
                %>
        </table>
    </body>
    <script type="text/javascript">
        //<![CDATA[
            var tblWSRCLProps = {
                col_width: ["0px","70px","50px","170px","190px", "125px"],
                col_0: 'none', col_1: 'select', col_2: 'none',col_3: 'input',col_4: 'input',col_5: 'input',
                enable_default_theme: true, btn_reset: false, btn_reset_text: "Clear Filter", 
                base_path:'scripts/TableFilter/',
                loader_html: "<img src='scripts/TableFilter/loader.gif' alt=''>" + '<span>Loading...</span>',
                loader: true, loader_css_class: 'myLoader',
                status_bar: false, alternate_rows: true, popup_filters: true,
                rows_counter: true, rows_counter_text: "Displayed rows: ",
                paging: true, paging_length:10, help_instructions:false,
                filters_row_index:1, display_all_text: "< Show all >",

                grid:true, grid_layout: true, grid_width:'690px',grid_height: '260px', grid_enable_cols_resizer: false,
                sort_config: { sort_types: ['number','string','number','string','string','string'] },
                //Selection for edit
                selectable: true, editable: false,
                ezEditTable_config: {default_selection: 'both',
                    selected_row_css: 'ezSlcRow',
                    on_validate_row: function(o, row){
                        var id = o.Selection.GetActiveRowValues()[0];
                        var vals = o.Selection.GetActiveRowValues();
                        parent.funWLUpdate(id, vals);
                        
                        //alert('You have chosen record: '+ id );
                    }
                }
            };
        //]]>
        var tfList = setFilterGrid("tblWSearchList", tblWSRCLProps);;
    </script>
</html>
