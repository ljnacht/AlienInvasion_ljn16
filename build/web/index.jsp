<%-- 
    Document   : index
    Created on : Mar 17, 2016, 1:37:58 PM
    Author     : User
--%>

<%@page import="edu.pitt.is1017.spaceinvaders.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alien Invasion - Login</title>
    </head>
    <% 
        String username = "";
        String password = "";
        User user;
        if(request.getParameter("btnSubmit") != null){
            //UN
            if(request.getParameter("txtUserName") != null){
               if(request.getParameter("txtUserName") != ""){
                   username = request.getParameter("txtUserName");
               }
            }
           //PW 
           if(request.getParameter("txtPassword") != null){
               if(request.getParameter("txtPassword") != ""){
                   password = request.getParameter("txtPassword");
               }
            }
           //check for blank and login info
            if(!username.equals("") && !password.equals("")){
                //user = new User(username,password);
                
                if(false){
                    out.println("<script>window.location='game.jsp';</script>");
                  
                }else{
                    out.println("<script>alert('Your login information is invalid.');</script>");
                }
            }else{
                out.println("<script>alert('Fill in username and password');</script>");
            }
        }
  
     %>
    <body>
        <form id="frm-login" action="index.jsp" method="post">
            <label for="txtUserName">Username: &nbsp;</label>
            <input type="text" id ="txtUserName" name="txtUserName" value=""></input>
            <br />
            <label for="txtPassword"> Password: &nbsp; </label>
            <input type="password" id ="txtPassword" name="txtPassword" value=""></input>
            <br /><br />&nbsp;
            <input type="submit" id="btnSubmit" name="btnSubmit" value="Login"></input>&nbsp;
            <input type="button" id="btnRegister" name="btnRegister" value="Register"
                   onclick="window.location='register.jsp';return true;"></input>
        </form>
    </body>
</html>
