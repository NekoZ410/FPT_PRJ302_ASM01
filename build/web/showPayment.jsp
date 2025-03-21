<%-- 
    Document   : checkOut
    Created on : Oct 29, 2024, 10:40:32 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.NumberFormat"%>
<%
    int sumPrice = (Integer) request.getAttribute("sumPrice");    
    List<Purchased> listPurchased = (List) request.getAttribute("listPurchased");    
    NumberFormat formatter = NumberFormat.getInstance(new Locale("vi", "VN"));
    
    String paymentMethod = (String) request.getAttribute("paymentMethod");
%>
<!DOCTYPE html>
<html lang="vi" class="h-100">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8" />

        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
            />
        <!-- Custom css - Các file css do chúng ta tự viết -->
        <link rel="stylesheet" href="css/checkOut.css" type="text/css" />
        <title>Xuất hóa đơn</title>
    </head>

    <body>
        <main role="main">
            <!-- Block content - Đục lỗ trên giao diện bố cục chung, đặt tên là `content` -->

            <div class="background">
                <div class="container mt-4">

                    <form class="needs-validation" action="showPayment" method="post">
                        <div class="py-5 text-center">
                            <i class="fa fa-credit-card fa-4x" aria-hidden="true"></i>
                            <h2>Thanh toán thành công</h2>

                        </div>

                        <div class="row">                                    
                            <div >
                                <h4 class="mb-3">Thông tin đơn hàng</h4>

                                <ul class="list-group mb-3">
                                    <% for (Purchased p : listPurchased){ %>
                                    <li class="list-group-item d-flex justify-content-between lh-condensed" >
                                        <div>
                                            <h6 class="my-0"><%=p.getProductID().getProductName()%></h6>
                                            <small class="text-muted"><%=formatter.format(p.getProductID().getUnitPrice() * (100 - p.getProductID().getDiscount()) / 100)%>₫ x <%=p.getQuantity()%></small>
                                        </div>
                                        <span class="text-muted"><%=formatter.format((p.getProductID().getUnitPrice() * (100 - p.getProductID().getDiscount()) / 100) * p.getQuantity())%>₫</span>
                                    </li>
                                    <% } %>

                                    <li class="list-group-item d-flex justify-content-between">
                                        <span>Tổng thành tiền: </span>
                                        <strong><%=formatter.format(sumPrice)%>₫</strong>
                                    </li>
                                </ul>

                                <h4 class="mb-3">Thông tin khách hàng</h4>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="kh_ten">Họ tên</label>
                                        <input type="text" class="form-control" name="userName" id="kh_ten" value="${sessionScope.userAccount.userName}" readonly="" />
                                    </div>

                                    <div class="col-md-12">
                                        <label for="kh_gioitinh">Tên tài khoản</label>
                                        <input type="text" class="form-control" name="accountName" id="kh_gioitinh" value="${sessionScope.userAccount.accountName}" readonly="" />
                                    </div>

                                    <div class="col-md-12">
                                        <label for="kh_email">Email</label>
                                        <input type="text" class="form-control" name="email" id="kh_email" value="${sessionScope.userAccount.email}" readonly="" />
                                    </div>

                                    <div class="col-md-12">
                                        <label for="kh_email">Phương thức thanh toán</label>
                                        <input type="text" class="form-control" name="email" id="kh_email" value="<%=paymentMethod%>" readonly="" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>

                    <div class="back-to-home" style="margin-top: 10px; text-align: center">
                        <button class="btn btn-primary btn-lg btn-block" style="color: white" type="submit" name="btnDatHang" onclick="goToHome()">Về trang chủ</button>
                        <script>
                            function goToHome() {
                                window.location.href = "home.jsp";
                            }
                        </script>
                    </div>

                </div>
            </div>
            <!-- End block content -->
        </main>

        <!-- footer -->
        <div class="mid-footer">
            <div class="container">
                <div class="row">
                    <div class="col-12 col-md-6 col-lg-5 link-list col-footer">
                        <div class="kk">
                            <a class="l1" href="https://themes.sapp.vn/demo/template-alena"
                               >HNG JEWELRY</a
                            >
                            <p class="shop text">Shop Trang Sức HNG</p>
                        </div>

                        <div class="item">
                            <svg
                                xmlns="http://www.w3.org/2000/svg"
                                width="36"
                                height="36"
                                viewBox="0 0 36 36"
                                fill="none"
                                >
                            <rect width="36" height="36" rx="10" fill="#FE9614"></rect>
                            <g clip-path="url(#clip0_8_762)">
                            <path
                                d="M18 8.4707C13.9043 8.4707 10.5883 11.8057 10.5883 15.9249C10.5883 21.1417 14.6216 25.3759 18 27.5295C21.3785 25.3759 25.4118 21.1417 25.4118 15.9249C25.4118 11.8057 22.0957 8.4707 18 8.4707ZM18 19.5108C16.0249 19.5108 14.4345 17.9008 14.4345 15.9249C14.4345 13.9489 16.0353 12.3389 18 12.3389C19.9647 12.3389 21.5656 13.9489 21.5656 15.9249C21.5656 17.9008 19.9751 19.5108 18 19.5108Z"
                                fill="white"
                                ></path>
                            </g>
                            <defs>
                            <clipPath id="clip0_8_762">
                                <rect
                                    x="10.5883"
                                    y="8.4707"
                                    width="36"
                                    height="36"
                                    rx="7.41176"
                                    fill="white"
                                    ></rect>
                            </clipPath>
                            </defs>
                            </svg>
                            <span class="map">Đại học FPT</span>
                            <p></p>
                        </div>
                        <div class="item">
                            <svg
                                xmlns="http://www.w3.org/2000/svg"
                                width="36"
                                height="36"
                                viewBox="0 0 36 36"
                                fill="none"
                                >
                            <rect width="36" height="36" rx="10" fill="#FE9614"></rect>
                            <g clip-path="url(#clip0_8_804)">
                            <path
                                d="M18 8.4707C12.7453 8.4707 8.47058 12.7454 8.47058 18.0001C8.47058 23.2548 12.7453 27.5295 18 27.5295C23.2547 27.5295 27.5294 23.2548 27.5294 18.0001C27.5294 12.7454 23.2547 8.4707 18 8.4707ZM22.532 22.9291C22.3772 23.084 22.1739 23.1619 21.9706 23.1619C21.7673 23.1619 21.5639 23.084 21.4092 22.9291L17.4386 18.9586C17.2892 18.8102 17.2059 18.6084 17.2059 18.3972V13.2354C17.2059 12.7963 17.5616 12.4413 18 12.4413C18.4384 12.4413 18.7941 12.7963 18.7941 13.2354V18.0685L22.532 21.8063C22.8425 22.1169 22.8425 22.6187 22.532 22.9291Z"
                                fill="white"
                                ></path>
                            </g>
                            <defs>
                            <clipPath id="clip0_8_804">
                                <rect
                                    x="8.47058"
                                    y="8.4707"
                                    width="19.0588"
                                    height="19.0588"
                                    rx="9.52941"
                                    fill="white"
                                    ></rect>
                            </clipPath>
                            </defs>
                            </svg>
                            <span class="time">Cả ngày</span>
                            <p></p>
                        </div>
                        <div class="item tel_item">
                            <svg
                                xmlns="http://www.w3.org/2000/svg"
                                width="36"
                                height="36"
                                viewBox="0 0 36 36"
                                fill="none"
                                >
                            <rect width="36" height="36" rx="10" fill="#FE9614"></rect>
                            <path
                                fill-rule="evenodd"
                                clip-rule="evenodd"
                                d="M15.2144 16.99C15.4027 16.7084 15.5852 16.433 15.7734 16.1514C16.418 15.1844 16.3952 15.4965 15.9502 14.4132C15.5681 13.489 15.1802 12.5709 14.798 11.6467C14.4387 10.7898 14.4786 10.6429 13.4804 10.594C13.1097 10.5695 12.756 10.6246 12.4994 10.7776C11.6552 11.2917 10.8965 12.5709 10.6684 13.6665C9.68161 20.1665 18.0094 27.8784 24.8997 27.5173C25.8694 27.4194 26.7934 26.5686 27.1984 25.5281C27.3239 25.1548 27.4038 24.7631 27.4551 24.3652C27.6205 23.1105 27.5863 23.3737 26.5425 22.8106C25.6983 22.3577 24.8541 21.8987 24.0042 21.4457C23.1943 21.005 23.3825 20.8949 22.8064 21.5804C22.4242 22.0333 22.0478 22.4801 21.6656 22.933C21.1579 23.5328 21.3177 23.5084 20.5818 23.2207C18.3345 22.3516 16.07 20.595 15.0718 18.0549C14.8209 17.4062 14.8494 17.5408 15.2144 16.99Z"
                                fill="white"
                                ></path>
                            </svg>
                            <span>Hotline: </span>
                            <a class="tel" href="tel:0398810757">0398 810 757</a>
                        </div>
                    </div>
                    <div class="col-12 col-md-6 col-lg-2 link-list col-footer truongdzai">
                        <h4 class="title-menu">
                            Về chúng tôi
                            <!-- <span class="Collapsible__Plus"></span> -->
                        </h4>
                        <div class="list-menu hidden-mobile">
                            <a href="home.jsp" title="Trang chủ">Trang chủ</a>

                            <a href="./listProduct?categoryID=0">Các loại sản phẩm</a>

                            <a href="./bestSeller">Sản phẩm được mua nhiều</a>

                            <a href="contact.jsp" title="Liên hệ">Liên hệ</a>
                        </div>
                    </div>
                    <div class="col-12 col-md-6 col-lg-3 link-list col-footer hoangdzai">
                        <h4 class="title-menu">
                            Hỗ trợ khách hàng
                            <!-- <span class="Collapsible__Plus"></span> -->
                        </h4>
                        <div class="list-menu hidden-mobile">
                            <a href="home.jsp" title="Trang chủ">Trang chủ</a>

                            <a href="./listProduct?categoryID=0">Các loại sản phẩm</a>
                            <a href="./bestSeller">Sản phẩm được mua nhiều</a>

                            <a href="contact.jsp" title="Liên hệ">Liên hệ</a>
                        </div>
                    </div>
                    <div class="col-12 col-md-6 col-lg-2 link-list col-footer hieudzai">
                        <div class="social-footer">
                            <h4 class="title-menu">
                                Dịch vụ
                                <!-- <span class="Collapsible__Plus"></span> -->
                            </h4>
                            <div class="list-menu hidden-mobile">
                                <a href="home.jsp" title="Trang chủ">Trang chủ</a>

                                <a href="./listProduct?categoryID=0">Các loại sản phẩm</a>

                                <a href="./bestSeller">Sản phẩm được mua nhiều</a>

                                <a href="contact.jsp" title="Liên hệ">Liên hệ</a>
                            </div>
                            <div class="link-social">
                                <a
                                    class="yt"
                                    href="https://www.youtube.com/"
                                    title="Theo dõi trên Youtube"
                                    >
                                    <svg
                                        xmlns="http://www.w3.org/2000/svg"
                                        width="41"
                                        height="40"
                                        viewBox="0 0 41 40"
                                        fill="none"
                                        >
                                    <rect
                                        y="0.000488281"
                                        width="40.0333"
                                        height="39.9917"
                                        rx="10"
                                        fill="#FE9614"
                                        ></rect>
                                    <path
                                        d="M29.607 16.1986C29.377 15.3406 28.702 14.6636 27.845 14.4326C26.279 14.0026 20.014 13.9956 20.014 13.9956C20.014 13.9956 20.014 13.9956 20.014 13.9956C20.014 13.9956 13.75 13.9886 12.183 14.3996C11.343 14.6286 10.649 15.3206 10.417 16.1776C10.004 17.7435 10 20.991 10 20.9916C10 20.9916 10 20.9916 10 20.9916C10 20.9923 9.99604 24.2558 10.406 25.8056C10.636 26.6626 11.311 27.3396 12.169 27.5706C13.751 28.0006 19.9987 28.0076 19.999 28.0076C19.999 28.0076 19.999 28.0076 19.999 28.0076C19.9993 28.0076 26.264 28.0146 27.83 27.6046C28.686 27.3746 29.364 26.6986 29.597 25.8416C29.9902 24.3551 30.0127 21.3512 30.0139 21.0535C30.014 21.0362 30.014 21.0231 30.0141 21.0057C30.0149 20.7073 30.0126 17.6863 29.607 16.1986ZM20.6108 22.5061C19.4541 23.1708 18.0114 22.3351 18.0125 21.0009V21.0009C18.0136 19.6667 19.458 18.8334 20.6136 19.5003V19.5003C21.7714 20.1685 21.7699 21.8401 20.6108 22.5061V22.5061Z"
                                        fill="white"
                                        ></path>
                                    </svg>
                                </a>

                                <a
                                    class="instagram"
                                    href="https://www.instagram.com/?hl=en"
                                    title="Theo dõi trên Instagram"
                                    >
                                    <svg
                                        xmlns="http://www.w3.org/2000/svg"
                                        width="41"
                                        height="40"
                                        viewBox="0 0 41 40"
                                        fill="none"
                                        >
                                    <rect
                                        x="0.0375977"
                                        width="40.0333"
                                        height="39.9917"
                                        rx="10"
                                        fill="#FE9614"
                                        ></rect>
                                    <path
                                        d="M20.053 14.2183C16.8578 14.2183 14.2694 16.8053 14.2694 19.9959C14.2694 23.1877 16.8578 25.7747 20.053 25.7747C23.2456 25.7747 25.8365 23.1877 25.8365 19.9959C25.8365 16.8053 23.2456 14.2183 20.053 14.2183ZM20.053 23.7501C17.9775 23.7501 16.2948 22.0692 16.2948 19.9971C16.2948 17.9238 17.9775 16.2441 20.053 16.2441C22.1284 16.2441 23.8086 17.9238 23.8086 19.9971C23.8086 22.0692 22.1284 23.7501 20.053 23.7501Z"
                                        fill="white"
                                        ></path>
                                    <path
                                        d="M26.0667 15.3531C26.8115 15.3531 27.4153 14.7499 27.4153 14.0058C27.4153 13.2618 26.8115 12.6586 26.0667 12.6586C25.3219 12.6586 24.7181 13.2618 24.7181 14.0058C24.7181 14.7499 25.3219 15.3531 26.0667 15.3531Z"
                                        fill="white"
                                        ></path>
                                    <path
                                        d="M30.7293 12.6361C30.1426 11.1252 28.9479 9.93041 27.4354 9.34678C26.5609 9.01809 25.6364 8.84188 24.7006 8.82188C23.4958 8.76939 23.1143 8.75439 20.0592 8.75439C17.0042 8.75439 16.6126 8.75439 15.4179 8.82188C14.4846 8.84063 13.5601 9.01684 12.6856 9.34678C11.1718 9.93041 9.97709 11.1252 9.39161 12.6361C9.06258 13.5109 8.88619 14.4333 8.86742 15.3681C8.81363 16.5703 8.79736 16.9515 8.79736 20.0046C8.79736 23.0565 8.79736 23.4452 8.86742 24.6412C8.88619 25.576 9.06258 26.4983 9.39161 27.3744C9.97834 28.8841 11.1731 30.0789 12.6868 30.6637C13.5576 31.0037 14.4821 31.1961 15.4204 31.2261C16.6251 31.2786 17.0067 31.2949 20.0617 31.2949C23.1168 31.2949 23.5083 31.2949 24.7031 31.2261C25.6376 31.2074 26.5621 31.0299 27.4379 30.7025C28.9504 30.1164 30.1451 28.9228 30.7318 27.4119C31.0609 26.5371 31.2373 25.6148 31.256 24.6799C31.3098 23.4777 31.3261 23.0965 31.3261 20.0434C31.3261 16.9902 31.3261 16.6028 31.256 15.4068C31.2398 14.4595 31.0646 13.5209 30.7293 12.6361ZM29.2056 24.5487C29.1968 25.2686 29.0667 25.9822 28.8165 26.6583C28.4349 27.6418 27.658 28.4192 26.6747 28.7966C26.0054 29.0453 25.2998 29.1753 24.5855 29.1853C23.397 29.2403 23.0617 29.254 20.0142 29.254C16.9642 29.254 16.6526 29.254 15.4416 29.1853C14.7298 29.1765 14.0217 29.0453 13.3537 28.7966C12.3666 28.4204 11.5847 27.6431 11.2031 26.6583C10.9579 25.9909 10.8253 25.2848 10.814 24.5725C10.7602 23.3852 10.7477 23.0503 10.7477 20.0059C10.7477 16.9602 10.7477 16.6491 10.814 15.4381C10.8228 14.7182 10.9529 14.0058 11.2031 13.3297C11.5847 12.3437 12.3666 11.5676 13.3537 11.1902C14.0217 10.9427 14.7298 10.8115 15.4416 10.8015C16.6314 10.7477 16.9654 10.7327 20.0142 10.7327C23.063 10.7327 23.3757 10.7327 24.5855 10.8015C25.2998 10.8102 26.0054 10.9415 26.6747 11.1902C27.658 11.5688 28.4349 12.3462 28.8165 13.3297C29.0617 13.9971 29.1943 14.7032 29.2056 15.4156C29.2594 16.6041 29.2731 16.9377 29.2731 19.9834C29.2731 23.0219 29.2731 23.3539 29.2196 24.5431C29.2195 24.5469 29.2164 24.55 29.2126 24.55H29.2068C29.2061 24.55 29.2056 24.5494 29.2056 24.5487Z"
                                        fill="white"
                                        ></path>
                                    </svg>
                                </a>

                                <a
                                    class="fb"
                                    href="https://www.facebook.com/sapowebvietnam/"
                                    title="Theo dõi trên Facebook"
                                    >
                                    <svg
                                        xmlns="http://www.w3.org/2000/svg"
                                        width="41"
                                        height="40"
                                        viewBox="0 0 41 40"
                                        fill="none"
                                        >
                                    <rect
                                        x="0.0751953"
                                        width="40.0333"
                                        height="39.9917"
                                        rx="10"
                                        fill="#FE9614"
                                        ></rect>
                                    <path
                                        d="M23.6002 11.2515L21.1667 11.2476C18.4328 11.2476 16.666 13.0583 16.666 15.861C16.666 17.0358 15.7137 17.9881 14.5389 17.9881H14.2193C14.0079 17.9881 13.8367 18.1593 13.8367 18.3705V21.4525C13.8367 21.6637 14.0081 21.8347 14.2193 21.8347C15.5706 21.8347 16.666 22.9302 16.666 24.2814V29.6114C16.666 29.8226 16.8372 29.9937 17.0487 29.9937H20.241C20.4524 29.9937 20.6236 29.8224 20.6236 29.6114V24.6955C20.6236 23.1155 21.9044 21.8347 23.4844 21.8347C23.6958 21.8347 23.867 21.6637 23.867 21.4525L23.8682 18.3705C23.8682 18.2691 23.8278 18.172 23.7562 18.1002C23.6845 18.0285 23.5869 17.9881 23.4854 17.9881H22.4268C21.4309 17.9881 20.6236 17.1808 20.6236 16.1849C20.6236 15.3183 20.8303 14.8783 21.9605 14.8783L23.5998 14.8777C23.811 14.8777 23.9822 14.7065 23.9822 14.4955V11.6337C23.9822 11.4229 23.8112 11.2518 23.6002 11.2515Z"
                                        fill="white"
                                        ></path>
                                    </svg>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end footer -->

        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="../vendor/jquery/jquery.min.js"></script>
        <script src="../vendor/popperjs/popper.min.js"></script>
        <script src="../vendor/bootstrap/js/bootstrap.min.js"></script>

        <!-- Custom script - Các file js do mình tự viết -->
        <script src="../assets/js/app.js"></script>
    </body>
</html>

