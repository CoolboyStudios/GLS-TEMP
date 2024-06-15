<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>glScanDB - Subscription Manger - sub</title>
        
    </head>
    <body>
        <table style="width: 97%">
            <tr><td>
                <%@ include file="includes/tblLCConMgr.inc" %>
                </td></tr>
        </table>
        
        <script type="text/javascript">
                    
            function funOnLoadAjaxConDtl() {
                var id = $("#TxtCSID").val();
                //alert(id);
                $("#TxtCCSID").val(id); 
                $.getJSON("AjaxActions?req=GETLIST207CD&id="+id , 
                    function(data) {
                        var tr = data.LISTROWS;
                        if (tr === "") {
                            tr = "<tr class=even><td colspan=7>No Record(s).</<td></tr>";
                        }
                        //alert(tr);
                        $("#tblLCConList tbody").html(tr);
                        tfLCCon = setFilterGrid("tblLCConList", tblLCConProps);
                    });
            }
            
            $(document).ready(function() {
                
                funOnLoadAjaxConDtl();
            });
        </script>
    </body>
</html>
