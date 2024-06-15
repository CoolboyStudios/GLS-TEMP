<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@page import="glscandb.classes.UserCls,glscandb.AppUtils"%>
<%@ include file="includes/SessionValid.inc" %>
<%
    String lType = (String)request.getSession().getAttribute("objType");
    if (lType==null) {
        request.setAttribute("msg", "There is a program error(MNU100).<br>Please convey to administator with this error code.");
        request.getRequestDispatcher("logon.jsp").forward(request, response);            
        return;
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ads Check</title>
        <link type="image/icon" href="images/sysicon.gif" rel="shortcut icon"/>
        <style type="text/css">
            @import "includes/apps.css";
            @import "scripts/jquery/smoothness/jquery-ui.min.css";
            #accordion-resizer {
		padding: 10px;
		width: 350px;
		height: 220px;
	}
        </style>
        
        <script type="text/javascript" src="scripts/TableFilter/tablefilter_all_min.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="scripts/jquery/jquery-ui.min.js"></script>
        <script type="text/javascript" src="scripts/AppsUtil.js"></script>
        <script type="text/javascript">
            var wTimer;
            wTimer = self.setInterval(function () {fnCheckPageFullyLoaded('waitLayer', wTimer);}, 1000);
        </script>
    </head>

<body>
    <table width="100%">
            <tr>
                <td>
                    <%@ include file="includes/pgtop.inc" %>
                </td>
            </tr>
            <tr>
                <td class="Center">
                    <form action="frmCheck.jsp">
                        Seq.No: <input type="text" name="TxtSEQNO" id="TxtSEQNO" size="10" value="">
                        Image File Name: <input type="text" name="TxtIFNAME" id="TxtIFNAME" size="10" value="">
                        <input type="submit" value="Check">
                    </form>
                    
                    <table style="width:90%">
                        <thead>
                            <th>SEQ NO</th>
                            <th>S/M</th>
                            <th>Ads#</th>
                            <th>Enter#</th>
                            <th>NID</th>
                            <th>USER</th>
                            <th>Paper</th>
                            <th>Ads Type</th>
                            <th>Rel Date</th>
                            <th>Rel No</th>
                            <th>Page No</th>
                            <th>Status</th>
                        </thead>
                        <% 

                        java.sql.Connection con;
                        java.sql.Statement s;
                        java.sql.ResultSet rs;
                        java.sql.PreparedStatement pst;

                        con=null;
                        s=null;
                        pst=null;
                        rs=null;

                        // Remember to change the next line with your own environment
                        String url= "jdbc:sqlserver://192.168.10.50:1433;databaseName=glScanDBv8;useUnicode=true;characterEncoding=UTF-8;encrypt=true;trustServerCertificate=true ";
                        String id= "sa";
                        String pass = "Glc!981NS@2023";
                        try{

                        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                        con = java.sql.DriverManager.getConnection(url, id, pass);

                        }catch(ClassNotFoundException cnfex){
                        cnfex.printStackTrace();

                        }
                        String seq = request.getParameter("TxtSEQNO");
                        String ifn = request.getParameter("TxtIFNAME");
                        if (seq == null) { seq = ""; }
                        if (ifn == null) { ifn = "ZZZ"; }
                        
                        String sql = "SELECT U.UPID, U.ADMULTI, U.ADNO, U.ADNOE, N.NID, N.MAKE_DESC, ISNULL(N.NPID_DESC, U.NPID_DESC) NPID_DESC, ISNULL(N.NTID_DESC, U.NTID_DESC) NTID_DESC,  U.DTREL, U.NPRNO, U.PGNO, "
                                + " CASE WHEN N.STATUS = 'A' THEN 'COMPLETED' WHEN N.STATUS = 'I' THEN 'FOR VERIFICATION' WHEN N.STATUS = 'E' THEN 'FIX DATA ERROR' END STATUS" 
                                + " FROM VU_UPLOAD_MAS U LEFT OUTER JOIN VU_NOTICE_MAS N ON (U.UPID = N.SEQNO AND N.STATUS <> 'D') "
                                + " WHERE U.UPID in ( ";
                        if (seq.isEmpty())
                                sql += "SELECT UPID FROM VU_UPLOAD_MAS WHERE IFNAME LIKE '%" + ifn.trim() + "%' ";
                        else
                                sql += seq;
                        sql += ") " ;
                        
                        try{
                        s = con.createStatement();
                        rs = s.executeQuery(sql);
                        %>

                        <%
                        while( rs.next() ){
                        %>
                        <tr>
                        <td><%= rs.getString("UPID") %></td>
                        <td><%= rs.getString("ADMULTI") %></td>
                        <td><%= rs.getString("ADNO") %></td>
                        <td><%= rs.getString("ADNOE") %></td>
                        <td><%= rs.getString("NID") %></td>
                        <td><%= rs.getString("MAKE_DESC") %></td>
                        <td><%= rs.getString("NPID_DESC") %></td>
                        <td><%= rs.getString("NTID_DESC") %></td>
                        <td><%= rs.getString("DTREL") %></td>
                        <td><%= rs.getString("NPRNO") %></td>
                        <td><%= rs.getString("PGNO") %></td>
                        <td><%= rs.getString("STATUS") %></td>
                        </tr>

                        <% } %>
                        </table>

                        <%
                        }
                        catch(Exception e){e.printStackTrace();}
                        finally{
                            if(rs!=null) rs.close();
                            if(s!=null) s.close();
                            if(con!=null) con.close();
                        }
                        %>
                    
                </td>
            </tr>
        </table>
        <!-- Page Ready events -->
        <div id="LastElement"></div>
        <script type="text/javascript">
            $(document).ready(function() {
                // for GUI jquery button assingment
                $(function() {
                    $( "input[type=button], button" )
                        .button()
                        .click(function( event ) {
                            event.preventDefault();
                        });
                });
            });
        </script>
</body>
</html>