<%-- 
    Document   : pwdpdf
    Created on : Jul 26, 2022, 9:34:01 PM
    Author     : sivak
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.File,java.io.IOException,java.util.*,java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
Contents <br>
<% File f = new File("D:\\Apps\\glscandb\\PdfPwdFiles\\"); // current directory
session = request.getSession(true);

Calendar calendar = Calendar.getInstance();
calendar.add(Calendar.DAY_OF_MONTH, -1);
Date lastDate = calendar.getTime();
    
File[] files = f.listFiles();
 for (File file : files) { 
    if (file.isDirectory()) {  
        //System.out.print("directory:");
    } else {
        String filePath = f.getAbsolutePath() + File.separator + file;;
        File f1 = new File(filePath);
        Date date2 = new Date(f1.lastModified());
        
        long diffInMillies = date2.getTime() - lastDate.getTime();
        long diffInDays = java.util.concurrent.TimeUnit.DAYS.convert(diffInMillies,java.util.concurrent.TimeUnit.MILLISECONDS);
        String url = response.encodeURL("/PdfPwdFiles/"+file.getName());
        //if(Math.abs(diffInDays) <= 7){
            // do your stuff here...
        %>
        <a href="<%=url%>"><%=file.getName()%></a><br>

        <%//}  
    } 
} 

 %>
</body>
</html>