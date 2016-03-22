<%-- 
    Document   : register
    Created on : Mar 22, 2016, 7:34:42 PM
    Author     : User
--%>

<%@page import="edu.pitt.is1017.spaceinvaders.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        
        <%
        String first = "";
        String last = "";
        String email = "";
        String password = "";
        String confirm = "";
        User user;
        if(request.getParameter("btnSubmit") != null){
            //First
            if(request.getParameter("txtFirst") != null){
               if(request.getParameter("txtFirst") != ""){
                   first = request.getParameter("txtFirst");
               }
            }
            //Last
            if(request.getParameter("txtLast") != null){
               if(request.getParameter("txtLast") != ""){
                   last = request.getParameter("txtLast");
               }
            }
            //Email
            if(request.getParameter("txtEmail") != null){
               if(request.getParameter("txtEmail") != ""){
                   email = request.getParameter("txtEmail");
               }
            }
           //PW 
           if(request.getParameter("txtPassword") != null){
               if(request.getParameter("txtPassword") != ""){
                   password = request.getParameter("txtPassword");
               }
            }
           //Confirm
           if(request.getParameter("txtConfirm") != null){
               if(request.getParameter("txtConfirm") != ""){
                   confirm = request.getParameter("txtConfirm");
               }
            }
           //check for blank and login info
            if(!first.equals("") && !last.equals("") && !email.equals("") && !password.equals("") && !confirm.equals("")){
                if(!password.equals("confirm")){
                    out.println("<script>alert('You did not re-type your password correctly.');</script>");
                }else{
                    //user = new User(last,first,email,password);
                    out.println("<script>alert('You are registered!');</script>");
                    out.println("<script>alert(window.location('index.jsp'));</script>");
                }
                
            }else{
                out.println("<script>alert('Fill in username and password');</script>");
            }
        }
        %>
    </head>
    <body>
        <form id="frm-register" action="index.jsp" method="post">
            <label for="txtUserName">First Name: &nbsp;</label>
            <input type="text" id ="txtFirst" name="txtFirst" value=""></input>
            <br />
            <label for="txtLast"> Last Name: &nbsp; </label>
            <input type="text" id ="txtLast" name="txtLast" value=""></input>
            <br />
            <label for="txtLast"> Email: &nbsp; </label>
            <input type="text" id ="txtEmail" name="txtEmail" value=""></input>
            <br />
            <label for="txtLast">Password: &nbsp; </label>
            <input type="password" id ="txtPassword" name="txtPassword" value=""></input>
            <br />
            <label for="txtLast"> Confirm Password: &nbsp; </label>
            <input type="password" id ="txtConfirm" name="txtConfirm" value=""></input>
            
            <br /><br />&nbsp;
            <input type="submit" id="btnSubmit" name="btnSubmit" value="Register"></input>&nbsp;
            <input type="button" id="btnCancel" name="btnCancel" value="Cancel"
                   onclick="window.location='login.jsp';return true;"></input>
        </form>
    </body>
</html>
