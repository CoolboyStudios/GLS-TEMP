<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap,java.util.ArrayList"%>
<%@page import="glscandb.classes.UserCls,glscandb.AppUtils,glscandb.classes.NoticeSrcCls"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link type="text/css" rel="stylesheet" href="includes/apps.css">
        <link type="text/css" rel="stylesheet" href="scripts/jquery/smoothness/jquery-ui.min.css">
        <script type="text/javascript" src="scripts/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery-ui.min.js"></script>
        <script type="text/javascript" src="scripts/TableFilter/tablefilter_all.js"></script>
        <script type="text/javascript" src="scripts/AppsUtil.js"></script>
        
    </head>
    <body>
        <table id=tblCRSrcList>
                <tr>
                    <th>NID</th>
                    <th class="center">Notice Text<br> نص الإشعار</th>
                    <th class="center">TL/PP/Case No.<br>رقم الرخصة التجارية/جواز السفر/البلاغ</th>
                    <th class="center">Name of Individual/Entity<br> إسم الشخص/الشركة</th>
                    <th class="center">Date of Publication<br> تاريخ النشر</th>
                    <th class="center">Type of Notice<br> نوع الإشعار</th>
                    <th class="center">Newspaper<br> الصحيفة</th>
                    <th>Ann</th>
                    <th>Img</th>
                    <th>ASVAL</th>
                    <th>EAnn</th>
                </tr>
                <%
                    Object olh = request.getSession().getAttribute("objList");
                    HashMap lhhm = (HashMap) olh;
                    ArrayList alKeys = AppUtils.sortHashMap(lhhm);
                    NoticeSrcCls oCls;
                    int lhsno=0;
                    String fname;
                    for(int i=0;i<alKeys.size();i++)
                    {
                        oCls = (NoticeSrcCls)lhhm.get(((Integer)alKeys.get(i)));
                        lhsno++;
                        out.print("<tr>");
                            out.print(AppUtils.genTableCol(oCls.getNID(), "#######" ));
                            out.print(AppUtils.genTableCol(oCls.getANNOUN(), AppUtils.FormatAlign.right));
                            out.print(AppUtils.genTableCol(oCls.getCPPTLNO(), AppUtils.FormatAlign.right));
                            out.print(AppUtils.genTableCol(oCls.getCNAME(), AppUtils.FormatAlign.right));
                            out.print(AppUtils.genTableCol(oCls.getDTREL(), AppUtils.FormatAlign.right));
                            out.print(AppUtils.genTableCol(oCls.getNTID_DESC(), AppUtils.FormatAlign.right));
                            out.print(AppUtils.genTableCol(oCls.getNPID_DESC(), AppUtils.FormatAlign.right));
                            out.print("<td><span style='display:none'>");
                                out.print(oCls.getFANNOUN());
                            out.print("</span></td>");
                            out.print(AppUtils.genTableCol(oCls.getSTATUS(), AppUtils.FormatAlign.right));
                            out.print(AppUtils.genTableCol(oCls.getSTATUS_DESC(), AppUtils.FormatAlign.right));
                            out.print("<td><span style='display:none'>");
                                out.print(oCls.getEANNOUN());
                            out.print("</span></td>");
                        out.print("</tr>\n");
                    }
                    if  (lhsno==0) {
                        out.print("<tr><td></td> <td></td><td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td></tr>\n");
                        out.print("<tr><td></td> <td>No Record(s).</td><td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td></tr>\n");
                    }
                %>
        </table>
    </body>
    <script type="text/javascript">
        //<![CDATA[
            var tblCRSrcProps = {
                col_width: ["0px","200px","150px","150px","90px","75px","75px", "0px", "0px", "0px", "0px"],
                col_0: 'none', col_1: 'none', col_2: 'none',col_3: 'none',
                col_4: 'none', col_5: 'none',col_6: 'none',col_7: 'none',col_8: 'none',col_9: 'none',col_10: 'none',
                enable_default_theme: true, btn_reset: false, btn_reset_text: "Clear Filter", 
                base_path:'scripts/TableFilter/',
                loader_html: "<img src='scripts/TableFilter/loader.gif' alt=''>" + '<span>Loading...</span>',
                loader: true, loader_css_class: 'myLoader',
                status_bar: false, alternate_rows: true, popup_filters: true,
                rows_counter: true, rows_counter_text: "Displayed rows: ",
                paging: true, paging_length:10, help_instructions:false,
                filters_row_index:1, display_all_text: "< Show all >",

                grid:true, grid_layout: true, grid_width:'840px',grid_height: '240px', grid_enable_cols_resizer: false,
                sort_config: { sort_types: ['number','string','string','string','dmy','string','string'] },
                //Selection for edit
                selectable: true, editable: false,
                ezEditTable_config: {default_selection: 'both',
                    selected_row_css: 'ezSlcRow',
                    on_validate_row: function(o, row){
                        var id = o.Selection.GetActiveRowValues()[0];
                        var img = o.Selection.GetActiveRowValues()[8];
                        var ann = o.Selection.GetActiveRowValues()[7];
                        //alert(ann);
                        var sv = o.Selection.GetActiveRowValues()[9];
                        var eann = o.Selection.GetActiveRowValues()[10];
                        if ((id !== "No Record(s).") && (id !== "-")) {

                            //funCRSrcGet(crrid, sno);
                            //alert('You have chosen record: '+ id );
                            //img = 'Uploads/NPID_103/20131013/3-2-12412p9.jpg.jpg';
                            parent.funSrcTblClick(id, img, ann, sv, eann);
                        }
                    }
                }
            };
        //]]>
        var tfCRSrc = setFilterGrid("tblCRSrcList", tblCRSrcProps);;
    </script>
</html>
