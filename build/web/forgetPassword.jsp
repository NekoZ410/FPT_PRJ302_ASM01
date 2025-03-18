<%-- 
    Document   : change_password
    Created on : Oct 25, 2024, 4:31:24 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Quên mật khẩu</title>
        <link rel="stylesheet" href="css/forgetPassword.css" />
    </head>
    <body>
        <div class="wrapper">
            <h2>Quên mật khẩu</h2>
            <form action="forgetPassword" method="post">
                <div class="input-box">
                    <input type="text" placeholder="Email/ Tên người dùng" name="input" value="${requestScope.input}" required />
                </div>
                <div class="input-box">
                    <input type="password" placeholder="Mật khẩu mới" name="newpwd" value="${requestScope.newpwd}" required />
                </div>
                <div class="input-box">
                    <input type="password" placeholder="Nhập lại mật khẩu mới" name="renewpwd" value="${requestScope.renewpwd}" required />
                </div>

                 <!--------------------------- chỗ bạn note đây nhé  -------------------------->
                <div class="message">
                    <h3 style="color: red">${requestScope.error}</h3>
                    <h3 style="color: green">${requestScope.success}</h3>
                </div>
                <!-- ---------------------------------------------- -------------------------->

                <div class="input-box button">
                    <input type="Submit" value="Đổi mật khẩu ngay" />
                </div>
                <div class="text">
                    <h3>Đã đổi thành công mật khẩu ? <a href="login.jsp">Đăng nhập ngay</a></h3>
                </div>
            </form>
        </div>
    </body>
</html>
