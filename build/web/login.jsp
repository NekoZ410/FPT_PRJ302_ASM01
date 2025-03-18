<%-- 
    Document   : login
    Created on : Oct 25, 2024, 4:29:21 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Document</title>
        <link rel="stylesheet" href="css/login.css" />
    </head>
    <body>
        <section>
            <div class="login-box">
                <form action="login" method="post">
                    <h2>Đăng Nhập</h2>
                    <div class="input-box">
                        <span class="icon">
                            <ion-icon name="person-outline"></ion-icon>
                        </span>
                        <input type="text" name="accountName" value="${requestScope.accountName}" required />
                        <label> Tên tài khoản </label>
                    </div>

                    <div class="input-box">
                        <span class="icon"><ion-icon name="lock-closed"></ion-icon></span>
                        <input type="password" name="pwd" value="${requestScope.pwd}" required />
                        <label> Mật khẩu </label>
                    </div>

                    <div class="remember-forgot">
                        <label> <input type="checkbox" /> Ghi nhớ đăng nhập</label>
                        <a href="forgetPassword.jsp">Quên mật khẩu</a>
                    </div>
                    <div class="error">
                        <h3 style="color: red;">${requestScope.error}</h3>
                    </div>
                    <button type="submit">Đăng nhập</button>
                    <div class="register-link">
                        <p>Chưa có tài khoản? <a href="signUp.jsp" style="text-decoration: underline">Đăng kí ngay!</a></p>
                    </div>
                </form>
            </div>
        </section>
        <script
            type="module"
            src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"
        ></script>
        <script
            nomodule
            src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"
        ></script>
    </body>
</html>

