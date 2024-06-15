<% if (session.isNew()){
        request.setAttribute("msg","Session Expired! Please login again...");
        request.getRequestDispatcher("logon.jsp").forward(request, response);            
        return; 
    }
    Object objUsr = session.getAttribute("ObjUser");
    UserCls user = null;
    if (objUsr != null){
        user = (UserCls)objUsr;
    }
    else{
        request.setAttribute("msg","Session Expired! Please login again...");
        response.sendRedirect("logon.jsp");
        return;
    }
%>