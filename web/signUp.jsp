<%-- 
    Document   : signup
    Created on : Oct 25, 2024, 4:28:29 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Đăng ký tài khoản</title>
        <link rel="stylesheet" href="css/signup.css" />
    </head>
    <body>
        <div class="wrapper">
            <h2>Đăng Ký</h2>
            <form action="signUp" method="post">
                <div class="input-box">
                    <input type="text" placeholder="Họ và tên" name="userName" value="${requestScope.userName}" required/>
                </div>
                <div class="input-box">
                    <input type="email" placeholder="Email" name="email" value="${requestScope.email}" required/>
                </div>
                <div class="input-box">
                    <input type="text" placeholder="Tên tài khoản" name="accountName" value="${requestScope.accountName}" required />
                </div>
                <div class="input-box">
                    <input type="password" placeholder="Mật khẩu" name="pwd" value="${requestScope.pwd}" required />
                </div>
                <div class="input-box">
                    <input type="password" placeholder="Nhập lại mật khẩu" name="repwd" value="${requestScope.repwd}" required />
                </div>
                <div class="policy">
                    <input type="checkbox"  class="click" onclick='deRequire("click")' required/>
                    <h3>Chấp nhận điều khoản và điều kiện</h3>
                </div>
                <div class="error">
                    <h3 style="color: red;">${requestScope.error}</h3>
                </div>
                <div class="input-box button">
                    <input type="submit" value="Đăng ký ngay"/>
                </div>

                <div class="text">
                    <h3>Đã có tài khoản? <a href="login.jsp">Đăng nhập ngay!</a></h3>
                </div>
                <div class="text">
                    <h3><a href="home.jsp">Về Trang chủ</a></h3>
                </div>

            </form>
        </div>
        <script>
            function deRequireCb(elClass) {
                el = document.getElementsByClassName(elClass);

                var atLeastOneChecked = false;
                for (i = 0; i < el.length; i++) {
                    if (el[i].checked === true) {
                        atLeastOneChecked = true;
                    }
                }

                if (atLeastOneChecked === true) {
                    for (i = 0; i < el.length; i++) {
                        el[i].required = false;
                    }
                } else {
                    for (i = 0; i < el.length; i++) {
                        el[i].required = true;
                    }
                }
            }
        </script>
    </body>
</html>
