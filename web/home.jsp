<%-- 
    Document   : home
    Created on : Oct 25, 2024, 3:43:12 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.NumberFormat"%>
<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>

<html lang="en">
    <%
        CategoryDAO cd = new CategoryDAO();
        List<Category> listCategory = cd.getCategoryList();
         NumberFormat formatter = NumberFormat.getInstance(new Locale("vi", "VN"));
        
    %>

    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/6.6.2/swiper-bundle.css"
              integrity="sha512-Cnea/COlaB9X7PM3tEBw3GriCbQIAfPLbrK+pKIj8KER/gf7QL0QEK954stZ4rleDyMnEldn42jR8U+fXOHojA=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="css/style.css" />
        <title>Trang chủ</title>
    </head>

    <body>
        <nav class="navbar navbar-expand-lg py-3 fixed-top">
            <div class="container">
                <a href="home.jsp" class="navbar-brand">HNG</a>
                <div class="search">
                    <div class="header_search">
                        <form class="search-bar" action="searchProduct" method="post" role="search">
                            <div class="collection-selector hidden-xs hidden-sm">
                                <div class="search_text">Tất cả</div>
                                <div id="search_info" class="list_search" style="display: none;">
                                    <div class="search_item active" data-coll-id="0">Tất cả</div>
                                    <%
                                        for(int i = 0; i < listCategory.size(); i++){
                                    %>
                                    <div class="search_item" data-coll-id="<%=i + 1%>" title="<%=listCategory.get(i).getCategoryName()%>"><%=listCategory.get(i).getCategoryName()%></div> 
                                    <%
                                        }
                                    %>

                                    <div class="liner_search"></div>
                                </div>
                            </div>
                            <input type="search" value="" placeholder="Tìm sản phẩm bạn mong muốn"
                                   class="input-group-field st-default-search-input search-text" autocomplete="off" required>
                            <span class="input-group-btn">
                                <button class="btn icon-fallback-text">
                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                                    <path
                                        d="M500.3 443.7l-119.7-119.7c27.22-40.41 40.65-90.9 33.46-144.7C401.8 87.79 326.8 13.32 235.2 1.723C99.01-15.51-15.51 99.01 1.724 235.2c11.6 91.64 86.08 166.7 177.6 178.9c53.8 7.189 104.3-6.236 144.7-33.46l119.7 119.7c15.62 15.62 40.95 15.62 56.57 0C515.9 484.7 515.9 459.3 500.3 443.7zM79.1 208c0-70.58 57.42-128 128-128s128 57.42 128 128c0 70.58-57.42 128-128 128S79.1 278.6 79.1 208z" />
                                    </svg>
                                </button>
                            </span>
                        </form>
                    </div>
                </div>
                <div id="login" class="navbar-nav">

                    <%if(session.getAttribute("userAccount") == null){%>
                    <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
                         width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
                    <path fill-rule="evenodd"
                          d="M12 4a4 4 0 1 0 0 8 4 4 0 0 0 0-8Zm-2 9a4 4 0 0 0-4 4v1a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2v-1a4 4 0 0 0-4-4h-4Z"
                          clip-rule="evenodd" />
                    </svg>
                    <a href="login.jsp" class="nav-link">Đăng nhập |</a>
                    <a href="signUp.jsp" class="nav-link">| Đăng ký</a>
                    <%} else {%>
                    <div id="login" class="navbar-nav">
                        <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                             viewBox="0 0 256 256" enable-background="new 0 0 256 256" xml:space="preserve">
                        <metadata> Svg Vector Icons : http://www.onlinewebfonts.com/icon </metadata>
                        <g>
                        <g>
                        <path fill="#000000"
                              d="M128,15.5c62,0,112.5,50.5,112.5,112.5c0,62-50.5,112.5-112.5,112.5C66,240.5,15.5,190,15.5,128C15.5,66,66,15.5,128,15.5 M128,10C62.8,10,10,62.8,10,128c0,65.2,52.8,118,118,118c65.2,0,118-52.8,118-118C246,62.8,193.2,10,128,10L128,10z" />
                        <path fill="#000000"
                              d="M128,134.5c-18.8,0-34.1-15.3-34.1-34.1c0-18.8,15.3-34.1,34.1-34.1c18.8,0,34.1,15.3,34.1,34.1S146.8,134.5,128,134.5z M128,71.8c-15.7,0-28.6,12.8-28.6,28.6s12.8,28.6,28.6,28.6c15.7,0,28.6-12.8,28.6-28.6S143.7,71.8,128,71.8z" />
                        <path fill="#000000"
                              d="M183.3,189.8c-1.5,0-2.8-1.2-2.8-2.8c0-29-23.6-52.5-52.5-52.5c-29,0-52.5,23.6-52.5,52.5c0,1.5-1.2,2.8-2.8,2.8s-2.8-1.2-2.8-2.8c0-32,26.1-58.1,58.1-58.1c32,0,58.1,26.1,58.1,58.1C186.1,188.5,184.8,189.8,183.3,189.8z" />
                        </g>
                        </g>
                        </svg>
                        <div class="user">
                            <a href="accountInfo.jsp" class="nav-link caret-down">${sessionScope.userAccount.userName}</a>

                            <i class="fa fa-caret-down"></i>
                            <ul class="item_small">
                                <li>
                                    <a href="accountInfo.jsp">
                                        Thông tin tài khoản
                                    </a>
                                </li>
                                <c:choose>
                                    <c:when test="${sessionScope.userAccount.role == 'Admin'}">
                                        <li>
                                            <a href="userManage.jsp">
                                                Quản lý người dùng
                                            </a>
                                        </li>
                                        <li>
                                            <a href="./listProduct?categoryID=0">
                                                Quản lý sản phẩm
                                            </a>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li>
                                            <a class="" href="showCart.jsp">
                                                Giỏ hàng
                                                <span class="count_item count_item_pr"><%=new CartDAO().getCartList(((UserAccount) session.getAttribute("userAccount")).getUserID()).size()%></span>
                                            </a>
                                        </li>
                                        <li>
                                            <a class="" href="showOrder.jsp">
                                                Đơn hàng
                                                <span class="count_item count_item_pr"><%=new OrderDAO().getOrderList(((UserAccount) session.getAttribute("userAccount")).getUserID()).size()%></span>
                                            </a>
                                        </li>
                                        <li>
                                            <a class="" href="listPayment.jsp">
                                                Hóa đơn thanh toán
                                            </a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                                <li>
                                    <a class="" href="./logout">
                                        Đăng xuất
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <%}%>
                </div>
            </div>
        </nav>

        <div class="header-menu py-3">
            <div class="container">
                <div class="row">
                    <div class="col-lg-9 col-12 col-menu">
                        <div class="menu-bar d-lg-none d-block">
                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="12" viewBox="0 0 18 12" fill="none">
                            <path d="M6 2V0H18V2H6Z" fill="#FE9614" />
                            <path d="M0 7H18V5H0V7Z" fill="#FE9614" />
                            <path d="M6 12H18V10H6V12Z" fill="#FE9614" />
                            </svg>
                        </div>
                        <nav class="header-nav">
                            <ul class="item_big">
                                <li class="nav-item active">
                                    <a class="a-img" href="#" title="Trang chủ">
                                        Trang chủ
                                    </a>
                                </li>
                                <li class="nav-item ">
                                    <a class="a-img caret-down" href="./listProduct?categoryID=0">
                                        Các loại sản phẩm
                                    </a>
                                    <i class="fa fa-caret-down"></i>
                                    <ul class="item_small">
                                        <li>
                                            <a class="caret-down" href="./listProduct?categoryID=0">
                                                Mẫu mã
                                            </a>
                                            <i class="fa fa-caret-down"></i>
                                            <ul>
                                                <%
                                                for(int i = 0; i < listCategory.size(); i++){
                                                %>
                                                <li>
                                                    <a href="./listProduct?categoryID=<%=i + 1%>" class="a3"><%=listCategory.get(i).getCategoryName()%></a>
                                                </li>
                                                <%
                                                    }
                                                %>
                                            </ul>
                                        </li>
                                        <li>
                                            <a href="searchPrice.jsp">
                                                Tìm kiếm theo giá tiền
                                            </a>
                                        </li>
                                        <li>
                                            <a class="caret-down" href="./productDiscount?discount=-1">
                                                Đang giảm giá
                                            </a>
                                            <i class="fa fa-caret-down"></i>
                                            <ul>
                                                <li>
                                                    <a href="./productDiscount?discount=10" class="a3">10%</a>
                                                </li>
                                                <li>
                                                    <a href="./productDiscount?discount=20" class="a3">20%</a>
                                                </li>
                                                <li>
                                                    <a href="./productDiscount?discount=30" class="a3">30%</a>
                                                </li>
                                                <li>
                                                    <a href="./productDiscount?discount=40" class="a3">40%</a>
                                                </li>
                                                <li>
                                                    <a href="./productDiscount?discount=50" class="a3">50%</a>
                                                </li>
                                            </ul>
                                        </li>
                                    </ul>
                                </li>
                                <li class="nav-item ">
                                    <a class="a-img" href="./bestSeller">
                                        Sản phẩm được mua nhiều
                                    </a>
                                </li>                               
                                <li class="nav-item ">
                                    <a class="a-img" href="contact.jsp">
                                        Liên hệ
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                    <div class="col-lg-3 col-search-cart">
                        <div class="phone_header">

                            <div class="ct-header">
                                <svg xmlns="http://www.w3.org/2000/svg" width="22" height="20" viewBox="0 0 22 20" fill="none">
                                <path
                                    d="M7.0026 1.73991L7.81809 2.39884C9.15027 3.47525 9.3185 5.4399 8.18875 6.72742L8.07556 6.85642C7.26593 7.77912 7.04991 9.14192 7.85868 10.0643C8.63222 10.9465 9.67036 11.7227 11.1784 12.5682C12.3675 13.235 13.8544 12.9186 14.7532 11.8942L14.832 11.8045C15.9034 10.5834 17.7512 10.4249 19.0146 11.4458L19.7715 12.0573C20.8569 12.9344 21.2348 14.4653 20.4545 15.6219C19.7181 16.7134 18.8967 17.5674 17.9272 18.2654C17.3087 18.7107 16.512 18.8096 15.7757 18.6119C8.57753 16.6789 4.223 13.167 1.09904 6.66232C0.827031 6.09593 0.737959 5.44474 0.958532 4.85622C1.42443 3.61316 2.29572 2.56629 3.64249 1.56464C4.64717 0.817412 6.02944 0.953575 7.0026 1.73991Z"
                                    stroke="#1C5B41" stroke-width="1.5" />
                                <path d="M3.32318 2.79199L8.30918 6.82076" stroke="#1C5B41" stroke-width="1.5" />
                                <path d="M17.4891 2.54224L14.8114 5.20087" stroke="#1C5B41" stroke-width="1.5" stroke-linecap="round" />
                                <path d="M18.9584 6.37634L16.9225 7.08326" stroke="#1C5B41" stroke-width="1.5" stroke-linecap="round" />
                                <path d="M12.9167 3.0647L13.6407 1.04166" stroke="#1C5B41" stroke-width="1.5" stroke-linecap="round" />
                                <path d="M14.9571 12.1924L19.9431 16.2211" stroke="#1C5B41" stroke-width="1.5" />
                                </svg>
                                <span>Hotline:</span>
                                <a href="tel:0398810757">0398 810 757</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>




        <div id="myCarousel" class="carousel slide" data-bs-interval="3000" data-bs-ride="carousel">
            <!-- Content of slides -->
            <div class="carousel-inner">
                <div class="carousel-item active bg-img1">
                    <div class="container">

                    </div>
                </div>
                <div class="carousel-item bg-img2">
                    <div class="container">

                    </div>
                </div>
                <div class="carousel-item bg-img3">
                    <div class="container">

                    </div>
                </div>
                <div class="carousel-item bg-img4">
                    <div class="container">

                    </div>
                </div>
                <div class="carousel-item bg-img5">
                    <div class="container">

                    </div>
                </div>
            </div>
            <!-- Indicator -->
            <div class="carousel-indicators">
                <button class="active" type="button" data-bs-target="#myCarousel" data-bs-slide-to="0"></button>
                <button class="" type="button" data-bs-target="#myCarousel" data-bs-slide-to="1"></button>
                <button class="" type="button" data-bs-target="#myCarousel" data-bs-slide-to="2"></button>
                <button class="" type="button" data-bs-target="#myCarousel" data-bs-slide-to="3"></button>
                <button class="" type="button" data-bs-target="#myCarousel" data-bs-slide-to="4"></button>
            </div>

            <!-- Next and prev button -->
            <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon"></span>
                <span class="visually-hidden">Previous</span>
            </button>

            <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>

        <!-- Services -->
        <section class="section_service">
            <div
                class="home-service container swiper-container swiper-container swiper-container-initialized swiper-container-horizontal swiper-container-pointer-events">
                <div class="swiper-wrapper">
                    <div class="swiper-slide" style="width: 262.5px; margin-right: 30px;">
                        <span class="image">
                            <svg fill="#fff" height="60px" width="60px" version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg"
                                 xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 512.01 512.01" xml:space="preserve" stroke="#fff"
                                 stroke-width="0.005120100000000001">

                            <g id="SVGRepo_bgCarrier" stroke-width="0" />

                            <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round" />

                            <g id="SVGRepo_iconCarrier">
                            <g>
                            <g>
                            <path
                                d="M510.025,301.746l-38.11-45.739l38.11-45.739c2.125-2.543,2.577-6.084,1.178-9.079c-1.408-2.995-4.42-4.915-7.731-4.915 H391.403l-7.484-52.403c-0.606-4.207-4.198-7.33-8.448-7.33h-65.178c-10.052-8.38-48.828-40.687-48.828-40.687 c-3.166-2.645-7.757-2.645-10.923,0l-48.828,40.687h-65.178c-4.25,0-7.842,3.123-8.448,7.322l-7.484,52.412H8.538 c-3.311,0-6.323,1.92-7.731,4.915c-1.408,3.004-0.947,6.545,1.178,9.079l38.11,45.739l-38.11,45.739 c-2.125,2.543-2.577,6.084-1.178,9.079c1.408,3.004,4.42,4.915,7.731,4.915h112.068c2.278,15.915,7.492,52.412,7.492,52.412 c0.597,4.207,4.198,7.322,8.439,7.322h65.178l48.828,40.687c1.587,1.323,3.524,1.98,5.461,1.98s3.883-0.657,5.461-1.98 l48.819-40.687c13.261,0,65.203,0.034,65.186,0c4.25,0,7.842-3.123,8.448-7.322c0,0,5.214-36.497,7.492-52.412h112.06 c3.311,0,6.323-1.92,7.731-4.915C512.611,307.821,512.15,304.28,510.025,301.746z M78.785,261.468l31.002,37.205H26.757 l31.002-37.205c2.637-3.166,2.637-7.757,0-10.923L26.757,213.34h83.029l-31.002,37.205 C76.148,253.711,76.148,258.302,78.785,261.468z M347.371,219.373L227.905,338.84c-1.664,1.673-3.849,2.5-6.033,2.5 c-2.185,0-4.369-0.836-6.033-2.5l-59.733-59.733c-3.328-3.328-3.328-8.738,0-12.066l25.6-25.6c3.328-3.328,8.738-3.328,12.066,0 l25.079,25.079c1.664,1.664,4.369,1.664,6.033,0l84.813-84.813c3.328-3.328,8.738-3.328,12.066,0l25.6,25.6 C350.699,210.644,350.699,216.045,347.371,219.373z M402.223,298.674l31.002-37.205c2.637-3.166,2.637-7.757,0-10.923 l-31.002-37.205h83.029l-31.002,37.205c-2.637,3.166-2.637,7.757,0,10.923l31.002,37.205H402.223z" />
                            </g>
                            </g>
                            <g>
                            <g>
                            <path
                                d="M326.26,210.328l-7.501-7.501c-1.664-1.664-4.369-1.664-6.033,0l-84.821,84.813c-3.328,3.328-8.738,3.328-12.066,0 l-25.079-25.079c-1.664-1.664-4.369-1.664-6.033,0l-7.501,7.501c-1.664,1.664-1.664,4.369,0,6.033l41.634,41.634 c1.664,1.664,4.369,1.664,6.033,0L326.26,216.361C327.924,214.697,327.924,211.992,326.26,210.328z" />
                            </g>
                            </g>
                            </g>

                            </svg>
                        </span>
                        <h3>
                            UY TÍN, CHẤT LƯỢNG
                        </h3>
                        <p>
                            Cam kết uy tín, chất lượng bạc chuẩn 925
                        </p>
                    </div>
                    <div class="swiper-slide" style="width: 262.5px; margin-right: 30px;">
                        <span class="image">
                            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="50"
                                 height="50" viewBox="0 0 256 256" xml:space="preserve">

                            <defs>
                            </defs>
                            <g style="stroke: none; stroke-width: 0; stroke-dasharray: none; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 10; fill: none; fill-rule: nonzero; opacity: 1;"
                               transform="translate(1.4065934065934016 1.4065934065934016) scale(2.81 2.81)">
                            <path
                                d="M 45 37.605 c -0.254 0 -0.509 -0.048 -0.749 -0.146 l -16.076 -6.494 c -1.024 -0.414 -1.519 -1.58 -1.105 -2.604 c 0.414 -1.024 1.58 -1.519 2.604 -1.105 L 45 33.448 l 36.253 -14.646 L 45 4.157 L 8.747 18.803 l 11.485 4.64 c 1.024 0.414 1.519 1.58 1.105 2.604 c -0.414 1.025 -1.58 1.52 -2.604 1.105 L 2.659 20.657 c -0.756 -0.306 -1.251 -1.039 -1.251 -1.854 s 0.495 -1.549 1.251 -1.854 L 44.251 0.146 c 0.48 -0.194 1.018 -0.194 1.498 0 l 41.593 16.803 c 0.756 0.306 1.251 1.039 1.251 1.854 s -0.495 1.549 -1.251 1.854 L 45.749 37.46 C 45.509 37.557 45.254 37.605 45 37.605 z"
                                style="stroke: none; stroke-width: 1; stroke-dasharray: none; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 10; fill: #fff; fill-rule: nonzero; opacity: 1;"
                                transform=" matrix(1 0 0 1 0 0) " stroke-linecap="round" />
                            <path
                                d="M 45 90 c -0.393 0 -0.783 -0.116 -1.119 -0.342 C 43.331 89.286 43 88.665 43 88 V 35.605 c 0 -0.815 0.495 -1.549 1.251 -1.854 l 41.593 -16.803 c 0.615 -0.249 1.316 -0.176 1.867 0.196 c 0.552 0.372 0.882 0.993 0.882 1.658 v 52.395 c 0 0.815 -0.495 1.549 -1.251 1.854 L 45.749 89.854 C 45.508 89.952 45.253 90 45 90 z M 47 36.955 v 48.081 l 37.593 -15.187 V 21.768 L 47 36.955 z"
                                style="stroke: none; stroke-width: 1; stroke-dasharray: none; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 10; fill: #fff; fill-rule: nonzero; opacity: 1;"
                                transform=" matrix(1 0 0 1 0 0) " stroke-linecap="round" />
                            <path
                                d="M 45 90 c -0.253 0 -0.508 -0.048 -0.749 -0.146 L 2.659 73.052 c -0.756 -0.306 -1.251 -1.039 -1.251 -1.854 V 18.803 c 0 -0.665 0.331 -1.286 0.882 -1.658 c 0.55 -0.372 1.251 -0.446 1.867 -0.196 l 16.075 6.495 c 1.024 0.414 1.519 1.58 1.105 2.604 c -0.414 1.025 -1.578 1.52 -2.604 1.105 L 5.408 21.768 v 48.081 L 43 85.035 V 36.955 l -14.825 -5.989 c -1.024 -0.414 -1.519 -1.58 -1.105 -2.604 c 0.414 -1.024 1.58 -1.519 2.604 -1.105 l 16.076 6.494 C 46.505 34.057 47 34.79 47 35.605 V 88 c 0 0.665 -0.33 1.286 -0.882 1.658 C 45.783 89.884 45.393 90 45 90 z"
                                style="stroke: none; stroke-width: 1; stroke-dasharray: none; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 10; fill: #fff; fill-rule: nonzero; opacity: 1;"
                                transform=" matrix(1 0 0 1 0 0) " stroke-linecap="round" />
                            <path
                                d="M 28.924 53.036 c -0.253 0 -0.507 -0.048 -0.749 -0.146 l -9.441 -3.813 c -0.756 -0.306 -1.251 -1.039 -1.251 -1.854 V 25.297 c 0 -0.815 0.495 -1.549 1.251 -1.854 L 60.326 6.64 c 0.48 -0.194 1.018 -0.194 1.498 0 l 9.441 3.814 c 0.756 0.306 1.251 1.039 1.251 1.854 s -0.495 1.549 -1.251 1.854 L 30.924 30.46 v 20.576 c 0 0.665 -0.331 1.286 -0.881 1.658 C 29.708 52.92 29.317 53.036 28.924 53.036 z M 21.483 45.874 l 5.441 2.198 v -18.96 c 0 -0.815 0.495 -1.549 1.251 -1.854 l 37.002 -14.948 l -4.103 -1.657 L 21.483 26.646 V 45.874 z"
                                style="stroke: none; stroke-width: 1; stroke-dasharray: none; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 10; fill: #fff; fill-rule: nonzero; opacity: 1;"
                                transform=" matrix(1 0 0 1 0 0) " stroke-linecap="round" />
                            <path
                                d="M 52.372 78.616 c -0.792 0 -1.541 -0.473 -1.855 -1.252 c -0.414 -1.024 0.081 -2.189 1.105 -2.604 l 9.44 -3.813 c 1.025 -0.411 2.19 0.081 2.604 1.105 c 0.414 1.024 -0.081 2.189 -1.105 2.604 l -9.44 3.813 C 52.875 78.568 52.621 78.616 52.372 78.616 z"
                                style="stroke: none; stroke-width: 1; stroke-dasharray: none; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 10; fill: #fff; fill-rule: nonzero; opacity: 1;"
                                transform=" matrix(1 0 0 1 0 0) " stroke-linecap="round" />
                            <path
                                d="M 52.372 71.526 c -0.792 0 -1.541 -0.473 -1.855 -1.252 c -0.414 -1.023 0.081 -2.189 1.105 -2.604 l 9.44 -3.814 c 1.025 -0.411 2.19 0.081 2.604 1.105 c 0.414 1.023 -0.081 2.189 -1.105 2.604 l -9.44 3.814 C 52.875 71.479 52.621 71.526 52.372 71.526 z"
                                style="stroke: none; stroke-width: 1; stroke-dasharray: none; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 10; fill: #fff; fill-rule: nonzero; opacity: 1;"
                                transform=" matrix(1 0 0 1 0 0) " stroke-linecap="round" />
                            <path
                                d="M 52.372 64.436 c -0.792 0 -1.541 -0.473 -1.855 -1.252 c -0.414 -1.024 0.081 -2.189 1.105 -2.604 l 9.44 -3.813 c 1.025 -0.412 2.19 0.081 2.604 1.105 c 0.414 1.024 -0.081 2.189 -1.105 2.604 l -9.44 3.813 C 52.875 64.388 52.621 64.436 52.372 64.436 z"
                                style="stroke: none; stroke-width: 1; stroke-dasharray: none; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 10; fill: #fff; fill-rule: nonzero; opacity: 1;"
                                transform=" matrix(1 0 0 1 0 0) " stroke-linecap="round" />
                            </g>
                            </svg>
                        </span>
                        <h3>
                            ĐÓNG GÓI
                        </h3>
                        <p>
                            Đóng gói sản phẩm đủ và cẩn thận
                        </p>
                    </div>
                    <div class=" swiper-slide" style="width: 262.5px; margin-right: 30px;">
                        <span class="image">
                            <svg version="1.1" fill="#fff" id="Layer_1" width="50" height="50" xmlns="http://www.w3.org/2000/svg"
                                 xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 122.88 121.95"
                                 style="enable-background:new 0 0 122.88 121.95" xml:space="preserve">
                            <g>
                            <path
                                d="M111.47,43.92c-0.79-1.9,0.11-4.09,2.02-4.88c1.9-0.79,4.09,0.11,4.88,2.02c1.48,3.54,2.62,7.23,3.38,11.05 c0.75,3.73,1.14,7.59,1.14,11.54c0,14.96-5.6,28.61-14.82,38.98c-9.32,10.48-22.34,17.6-37.02,19.31c-2.05,0.23-3.9-1.24-4.14-3.29 c-0.23-2.05,1.24-3.9,3.29-4.14c12.79-1.49,24.15-7.7,32.29-16.85c8.04-9.04,12.92-20.95,12.92-34.01c0-3.45-0.34-6.82-0.99-10.08 C113.74,50.2,112.75,46.98,111.47,43.92L111.47,43.92z M85.3,49.56c-0.02,0.12-0.07,0.24-0.13,0.35c-0.08,0.27-0.14,0.58-0.16,0.93 c0,0.03,0,0.07,0,0.1l-1.55,22.7c0.24,0.73,0.56,1.29,0.96,1.65c0.37,0.34,0.84,0.52,1.43,0.54c0.04,0,0.09,0,0.13,0l6.51,0.45l0,0 c0.01,0,0.03,0,0.05,0c1.01,0.12,1.76-0.1,2.29-0.63c0.6-0.6,0.99-1.61,1.2-2.98l0,0l0-0.02l3.38-20.34c0-0.03,0-0.07,0.01-0.1 c0.22-1.15,0.01-1.93-0.53-2.41c-0.63-0.55-1.7-0.84-3.12-0.94c-0.03,0-0.06,0-0.1,0l-7.33-0.5v-0.01 c-1.12-0.08-1.96,0.09-2.49,0.51C85.61,49.04,85.44,49.27,85.3,49.56L85.3,49.56L85.3,49.56z M76.41,74.18 c-0.15-0.16-0.24-0.36-0.28-0.58l-9.17-19.54c-1.03-2.02-2.07-2.14-3.13-1.61c-0.75,0.38-1.55,1.02-2.36,1.66 c-0.49,0.39-0.97,0.77-1.38,1.07l-1.9,1.36l0,0l-0.01,0.01c-1.38,0.96-2.89,1.43-4.3,1.45c-0.93,0.02-1.81-0.16-2.6-0.53 c-0.81-0.37-1.51-0.92-2.01-1.65c-0.54-0.78-0.87-1.75-0.89-2.86c0,0,0.25-0.69,0.3-0.74l6.18-6.4c-1.2-0.1-2.28-0.01-3.3,0.23 c-1.56,0.37-3.04,1.1-4.66,2.06c-0.19,0.13-0.42,0.19-0.66,0.18l-6.58-0.45l-0.85,12.43l-0.52,7.95l3.83,0.26l0,0 c0.37,0.02,0.71,0.24,0.87,0.59l4.19,8.62c0.61,1.26,1.15,2.34,1.87,3.08c0.67,0.7,1.59,1.16,3.04,1.3c0.54,0.05,1.07,0,1.57-0.17 c0.31-0.1,0.62-0.25,0.93-0.45l-2.69-5.97c-0.24-0.53,0-1.15,0.53-1.38c0.53-0.24,1.15,0,1.38,0.53l2.92,6.5 c1.2,0.72,2.32,0.99,3.35,0.85c0.94-0.14,1.85-0.63,2.74-1.48l-4.31-7.91c-0.27-0.5-0.09-1.14,0.42-1.42 c0.5-0.27,1.14-0.09,1.42,0.42l4.54,8.33c0.87,0.43,1.72,0.57,2.55,0.4c0.79-0.16,1.61-0.61,2.44-1.36l-4.01-8.99 c-0.24-0.53,0-1.16,0.53-1.39c0.53-0.24,1.16,0,1.39,0.54l4.16,9.3c0.6,0.4,1.31,0.54,2,0.48c0.61-0.06,1.21-0.28,1.71-0.62 c0.48-0.33,0.88-0.78,1.08-1.3c0.23-0.57,0.26-1.25,0-2.01L76.41,74.18L76.41,74.18L76.41,74.18z M81.66,74.82l-2.79-0.19 c0.3,1.13,0.21,2.17-0.15,3.08c-0.37,0.93-1.03,1.7-1.84,2.26c-0.79,0.54-1.73,0.89-2.71,0.98c-0.95,0.09-1.92-0.06-2.81-0.5 c-1.13,1.03-2.3,1.65-3.48,1.9c-1.19,0.24-2.37,0.09-3.54-0.41c-1.22,1.18-2.53,1.89-3.94,2.09c-1.43,0.21-2.91-0.11-4.45-0.96 c-0.52,0.35-1.06,0.62-1.62,0.81c-0.79,0.27-1.6,0.36-2.44,0.27c-2.01-0.2-3.32-0.88-4.33-1.92c-0.97-0.99-1.58-2.21-2.27-3.63 l-3.92-8.07l-3.45-0.24c-0.27,0.99-0.68,1.19-1.24,1.83c-1.26,1.41-2.35,2.15-4.29,2.04c-2.82-0.16-7.82,0.21-9.44-1.93 c-0.82-1.09-1.31-2.79-1.4-5.26c0-0.03,0-0.06-0.01-0.09L21.31,47.5c-0.17-2.1,0.28-3.55,1.18-4.49c0.91-0.96,2.22-1.33,3.78-1.29 c0.05,0,0.09,0,0.13,0l7.96,0.55v0.01c1.5,0.08,2.78,0.43,3.72,1.13c0.76,0.56,1.27,1.32,1.5,2.32l6.49,0.44 c1.71-0.99,3.29-1.74,5.01-2.16c1.69-0.4,3.48-0.46,5.58-0.06l2.37-2.44c0.04-0.05,0.08-0.09,0.14-0.13 c0.66-0.55,1.39-0.98,2.16-1.32c0.81-0.36,1.67-0.61,2.56-0.78c1.41-0.26,2.88-0.3,4.3-0.18c1.61,0.14,3.16,0.49,4.49,0.93 c2.54,0.86,4.67,2.58,6.73,4.25c0.46,0.37,0.92,0.75,1.47,1.16c0.02,0.01,0.04,0.03,0.06,0.04l3,2.32c0.17-0.21,0.37-0.4,0.59-0.57 c0.96-0.75,2.27-1.06,3.93-0.95v-0.01l7.33,0.5c0.03,0,0.06,0,0.08,0.01c1.88,0.12,3.38,0.57,4.38,1.46 c1.11,0.99,1.57,2.41,1.2,4.37c0,0.02-0.01,0.03-0.01,0.05l-3.38,20.32l0,0c-0.27,1.82-0.86,3.22-1.79,4.15 c-0.99,1-2.3,1.43-3.97,1.24l0,0l-6.51-0.45h-0.01c-1.13-0.02-2.07-0.39-2.83-1.09C82.43,76.33,81.99,75.65,81.66,74.82 L81.66,74.82L81.66,74.82z M29.32,63.25c0.78,0.05,1.37,0.73,1.32,1.52c-0.05,0.78-0.73,1.38-1.52,1.32 c-0.78-0.05-1.37-0.73-1.32-1.51S28.53,63.19,29.32,63.25L29.32,63.25L29.32,63.25z M91.04,67.47c0.78,0.05,1.37,0.73,1.32,1.51 c-0.05,0.78-0.73,1.38-1.52,1.32c-0.78-0.05-1.38-0.73-1.32-1.51C89.57,68.01,90.25,67.42,91.04,67.47L91.04,67.47L91.04,67.47z M36.89,57.7l0.72-10.44c0.04-0.55-0.31-1.24-0.75-1.57c-0.58-0.43-1.48-0.65-2.6-0.71l-7.99-0.54c-0.73-0.05-1.73,0.09-2.26,0.64 c-0.49,0.51-0.72,1.44-0.6,2.91c0,0.03,0,0.06,0,0.09l0.23,18.15l0,0.03c0.07,2.01,0.42,3.32,0.98,4.07 c0.5,0.67,9.01,2.04,10.48,0.38c0.58-0.66,0.92-1.72,1.05-3.12l-0.01,0l0.72-9.91L36.89,57.7L36.89,57.7z M106.95,24.27 l-24.22,4.34l5.02-7.12c-7.65-8.16-16.16-11.09-26.33-8.06C72.2,0.07,86.53,0.05,97.74,7.27L102.85,0L106.95,24.27L106.95,24.27z M39.17,91.43l-5.02,7.12c7.65,8.16,16.16,11.09,26.33,8.06c-10.79,13.35-25.12,13.37-36.33,6.15l-5.12,7.27l-4.09-24.26 L39.17,91.43L39.17,91.43z M12.51,81.54c0.9,1.86,0.12,4.09-1.74,4.98c-1.86,0.9-4.09,0.12-4.98-1.74 c-1.88-3.9-3.34-8.04-4.32-12.38C0.51,68.17,0,63.81,0,59.36C0,44.71,5.38,31.3,14.28,21.01C23.29,10.58,35.91,3.36,50.2,1.28 c2.04-0.29,3.93,1.13,4.22,3.17c0.29,2.04-1.13,3.93-3.17,4.22c-12.46,1.81-23.47,8.11-31.34,17.21 C12.17,34.86,7.48,46.55,7.48,59.36c0,3.95,0.44,7.77,1.26,11.41C9.6,74.52,10.87,78.13,12.51,81.54L12.51,81.54z" />
                            </g>
                            </svg>
                        </span>
                        <h3>
                            HỖ TRỢ ĐỔI HÀNG
                        </h3>
                        <p>
                            Hỗ trợ đổi hàng nếu có lỗi từ nhà sản xuất
                        </p>
                    </div>
                    <div class="swiper-slide" style="width: 262.5px; margin-right: 30px;">
                        <span class="image">
                            <svg fill="#fff" height="50px" width="50px" version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg"
                                 xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 473.806 473.806" xml:space="preserve">
                            <g>
                            <g>
                            <path d="M374.456,293.506c-9.7-10.1-21.4-15.5-33.8-15.5c-12.3,0-24.1,5.3-34.2,15.4l-31.6,31.5c-2.6-1.4-5.2-2.7-7.7-4
                                  c-3.6-1.8-7-3.5-9.9-5.3c-29.6-18.8-56.5-43.3-82.3-75c-12.5-15.8-20.9-29.1-27-42.6c8.2-7.5,15.8-15.3,23.2-22.8
                                  c2.8-2.8,5.6-5.7,8.4-8.5c21-21,21-48.2,0-69.2l-27.3-27.3c-3.1-3.1-6.3-6.3-9.3-9.5c-6-6.2-12.3-12.6-18.8-18.6
                                  c-9.7-9.6-21.3-14.7-33.5-14.7s-24,5.1-34,14.7c-0.1,0.1-0.1,0.1-0.2,0.2l-34,34.3c-12.8,12.8-20.1,28.4-21.7,46.5
                                  c-2.4,29.2,6.2,56.4,12.8,74.2c16.2,43.7,40.4,84.2,76.5,127.6c43.8,52.3,96.5,93.6,156.7,122.7c23,10.9,53.7,23.8,88,26
                                  c2.1,0.1,4.3,0.2,6.3,0.2c23.1,0,42.5-8.3,57.7-24.8c0.1-0.2,0.3-0.3,0.4-0.5c5.2-6.3,11.2-12,17.5-18.1c4.3-4.1,8.7-8.4,13-12.9
                                  c9.9-10.3,15.1-22.3,15.1-34.6c0-12.4-5.3-24.3-15.4-34.3L374.456,293.506z M410.256,398.806
                                  C410.156,398.806,410.156,398.906,410.256,398.806c-3.9,4.2-7.9,8-12.2,12.2c-6.5,6.2-13.1,12.7-19.3,20
                                  c-10.1,10.8-22,15.9-37.6,15.9c-1.5,0-3.1,0-4.6-0.1c-29.7-1.9-57.3-13.5-78-23.4c-56.6-27.4-106.3-66.3-147.6-115.6
                                  c-34.1-41.1-56.9-79.1-72-119.9c-9.3-24.9-12.7-44.3-11.2-62.6c1-11.7,5.5-21.4,13.8-29.7l34.1-34.1c4.9-4.6,10.1-7.1,15.2-7.1
                                  c6.3,0,11.4,3.8,14.6,7c0.1,0.1,0.2,0.2,0.3,0.3c6.1,5.7,11.9,11.6,18,17.9c3.1,3.2,6.3,6.4,9.5,9.7l27.3,27.3
                                  c10.6,10.6,10.6,20.4,0,31c-2.9,2.9-5.7,5.8-8.6,8.6c-8.4,8.6-16.4,16.6-25.1,24.4c-0.2,0.2-0.4,0.3-0.5,0.5
                                  c-8.6,8.6-7,17-5.2,22.7c0.1,0.3,0.2,0.6,0.3,0.9c7.1,17.2,17.1,33.4,32.3,52.7l0.1,0.1c27.6,34,56.7,60.5,88.8,80.8
                                  c4.1,2.6,8.3,4.7,12.3,6.7c3.6,1.8,7,3.5,9.9,5.3c0.4,0.2,0.8,0.5,1.2,0.7c3.4,1.7,6.6,2.5,9.9,2.5c8.3,0,13.5-5.2,15.2-6.9
                                  l34.2-34.2c3.4-3.4,8.8-7.5,15.1-7.5c6.2,0,11.3,3.9,14.4,7.3c0.1,0.1,0.1,0.1,0.2,0.2l55.1,55.1
                                  C420.456,377.706,420.456,388.206,410.256,398.806z" />
                            <path d="M256.056,112.706c26.2,4.4,50,16.8,69,35.8s31.3,42.8,35.8,69c1.1,6.6,6.8,11.2,13.3,11.2c0.8,0,1.5-0.1,2.3-0.2
                                  c7.4-1.2,12.3-8.2,11.1-15.6c-5.4-31.7-20.4-60.6-43.3-83.5s-51.8-37.9-83.5-43.3c-7.4-1.2-14.3,3.7-15.6,11
                                  S248.656,111.506,256.056,112.706z" />
                            <path d="M473.256,209.006c-8.9-52.2-33.5-99.7-71.3-137.5s-85.3-62.4-137.5-71.3c-7.3-1.3-14.2,3.7-15.5,11
                                  c-1.2,7.4,3.7,14.3,11.1,15.6c46.6,7.9,89.1,30,122.9,63.7c33.8,33.8,55.8,76.3,63.7,122.9c1.1,6.6,6.8,11.2,13.3,11.2
                                  c0.8,0,1.5-0.1,2.3-0.2C469.556,223.306,474.556,216.306,473.256,209.006z" />
                            </g>
                            </g>
                            </svg>
                        </span>
                        <h3>
                            LIÊN HỆ TRỰC TIẾP
                        </h3>
                        <p>
                            Nhận hỗ trợ trực tiếp từ shop 24/7
                        </p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Hot products -->
        <section class="section_product_hot module_product">
            <div class="container">
                <div class="wrap_tab_index not-dqtab e-tabs ajax-tab-1" data-section="ajax-tab-1">
                    <div class="row">
                        <div class="col-xl-5 col-lg-4 col-md-6 col-12 block-title">
                            <h2>
                                <span>SẢN PHẨM HOT</span>
                            </h2>
                        </div>
                        <div class="tab_big col-xl-7 col-lg-8 col-md-6 col-12">
                            <div class="tab_ul">
                                <ul class="tabs tabs-title tab-pc tabtitle1 ajax clearfix">
                                    <li class="tab-link tab_cate has-content" data-tab="tab-1">
                                        <span><%=listCategory.get(0).getCategoryName()%></span>
                                    </li>
                                    <%for(int i = 1; i < listCategory.size(); i++){%>
                                    <li class="tab-link tab_cate " data-tab="tab-<%=i+1%>">
                                        <span><%=listCategory.get(i).getCategoryName()%></span>
                                    </li>
                                    <%}%>

                                </ul>
                                <a class="prev button">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="14" viewBox="0 0 12 9" fill="none">
                                    <path d="M4.47107 1L0.999988 4.52892L4.47107 8" stroke="#AAABAB" stroke-miterlimit="10"
                                          stroke-linecap="round" stroke-linejoin="round" />
                                    <path d="M6.49585 4.52905H1.05781" stroke="#AAABAB" stroke-miterlimit="10" stroke-linecap="round"
                                          stroke-linejoin="round" />
                                    <path d="M10.8347 4.52905H8.80992" stroke="#AAABAB" stroke-miterlimit="10" stroke-linecap="round"
                                          stroke-linejoin="round" />
                                    </svg>
                                </a>
                                <a class="next button">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="14" viewBox="0 0 20 14" fill="none">
                                    <path d="M12.4492 1L18.4492 7.09998L12.4492 13.1" fill="#FFF6E8" />
                                    <path d="M12.4492 1L18.4492 7.09998L12.4492 13.1" stroke="#1C5B41" stroke-width="1.5"
                                          stroke-miterlimit="10" stroke-linecap="round" stroke-linejoin="round" />
                                    <path d="M8.94922 7.09998H18.3492" stroke="#1C5B41" stroke-width="1.5" stroke-miterlimit="10"
                                          stroke-linecap="round" stroke-linejoin="round" />
                                    <path d="M1.44922 7.09998H4.94922" stroke="#1C5B41" stroke-width="1.5" stroke-miterlimit="10"
                                          stroke-linecap="round" stroke-linejoin="round" />
                                    </svg>
                                </a>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="tab-1 tab-content current " data-tab="tab-1">
                                <%
                                    ProductDAO pd = new ProductDAO();
                                    List<Product> hostProduct = pd.ListHotProduct(1);
                                %>
                                <div class="swiper_tab swiper-container swiper-carousel ajax-carousel">
                                    <div class="swiper-wrapper">
                                        <%for(Product p: hostProduct){%>
                                        <div class="item swiper-slide">
                                            <div class="item_product_main">
                                                <div class="variants product-action">
                                                    <div class="product-thumbnail">
                                                        <a class="image_thumb scale_hover" href="./productDetail?productID=<%=p.getProductID()%>" title="Áo len nữ">
                                                            <img class="lazyload"
                                                                 src="<%=p.getImages()%>"
                                                                 alt="">
                                                        </a>                                                        
                                                        <div class="action">
                                                            <form action="productDetail" method="get">
                                                                <input type="hidden" name="productID" value="<%=p.getProductID()%>" />
                                                                <button class="btn-cart btn-views add_to_cart " <c:if test="${sessionScope.userAccount.role == 'Admin'}">style="display:none"</c:if>>
                                                                        <svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" viewBox="0 0 19 19"
                                                                             fill="none">
                                                                        <g>
                                                                        <path
                                                                            d="M18.7179 6.86766C18.467 6.55289 18.0906 6.37232 17.6852 6.37232H14.026L12.0418 1.82891C11.9188 1.54721 11.5907 1.41848 11.309 1.54157C11.0272 1.66459 10.8986 1.99274 11.0216 2.27448L12.8112 6.37236H6.18877L7.97837 2.27448C8.10139 1.99274 7.97276 1.66462 7.69103 1.54157C7.40933 1.41848 7.08117 1.54713 6.95816 1.82891L4.97396 6.37236H1.31482C0.909367 6.37236 0.532967 6.55289 0.282071 6.86769C0.0357758 7.17674 -0.0551051 7.57403 0.0327328 7.95782L1.9868 16.493C2.12325 17.089 2.65046 17.5052 3.26889 17.5052H15.7311C16.3495 17.5052 16.8767 17.089 17.0132 16.493L18.9673 7.95778C19.0551 7.574 18.9642 7.1767 18.7179 6.86766ZM15.7311 16.3919H3.26889C3.17437 16.3919 3.09158 16.3299 3.07203 16.2445L1.11796 7.70937C1.10263 7.64239 1.12835 7.59199 1.15269 7.56153C1.17526 7.53318 1.22636 7.48564 1.31482 7.48564H4.48779L4.34198 7.81951C4.21897 8.10125 4.34759 8.42937 4.62932 8.55242C4.70183 8.58411 4.77739 8.59911 4.85179 8.59911C5.06636 8.59911 5.27083 8.47431 5.36219 8.26512L5.7026 7.48571H13.2975L13.6379 8.26512C13.7292 8.47434 13.9337 8.59911 14.1483 8.59911C14.2226 8.59911 14.2982 8.58411 14.3708 8.55242C14.6525 8.42941 14.7811 8.10125 14.6581 7.81951L14.5123 7.48564H17.6853C17.7737 7.48564 17.8248 7.53318 17.8474 7.56153C17.8717 7.59203 17.8974 7.64243 17.8821 7.70933L15.928 16.2445C15.9085 16.3299 15.8256 16.3919 15.7311 16.3919Z"
                                                                            fill="white" />
                                                                        <path
                                                                            d="M6.16016 9.89771C5.85274 9.89771 5.60352 10.1469 5.60352 10.4543V14.5364C5.60352 14.8438 5.85274 15.093 6.16016 15.093C6.46757 15.093 6.7168 14.8438 6.7168 14.5364V10.4543C6.7168 10.1469 6.46761 9.89771 6.16016 9.89771Z"
                                                                            fill="white" />
                                                                        <path
                                                                            d="M9.5 9.89771C9.19259 9.89771 8.94336 10.1469 8.94336 10.4543V14.5364C8.94336 14.8438 9.19259 15.093 9.5 15.093C9.80741 15.093 10.0566 14.8438 10.0566 14.5364V10.4543C10.0566 10.1469 9.80741 9.89771 9.5 9.89771Z"
                                                                            fill="white" />
                                                                        <path
                                                                            d="M12.8398 9.89771C12.5324 9.89771 12.2832 10.1469 12.2832 10.4543V14.5364C12.2832 14.8438 12.5324 15.093 12.8398 15.093C13.1473 15.093 13.3965 14.8438 13.3965 14.5364V10.4543C13.3964 10.1469 13.1473 9.89771 12.8398 9.89771Z"
                                                                            fill="white" />
                                                                        </g>
                                                                        <defs>
                                                                        <clipPath>
                                                                            <rect width="19" height="19" fill="white" />
                                                                        </clipPath>
                                                                        </defs>
                                                                        </svg>
                                                                        Thêm vào giỏ hàng
                                                                    </button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                        <div class="product-info">
                                                            <h3 class="product-name"><a href="./productDetail?productID=<%=p.getProductName()%>"><%=p.getProductName()%></a></h3>
                                                        <div class="price-box">
                                                            <%=formatter.format(p.getUnitPrice() * (100 - p.getDiscount()) / 100)%>₫&nbsp;
                                                            <% if(p.getDiscount() != 0){%>
                                                            <span class="compare-price"><%=formatter.format(p.getUnitPrice())%>₫</span>
                                                            <%}%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <%}%>

                                    </div>
                                </div>
                                <div class="view-more clearfix">
                                    <a href="./listProduct?categoryID=1" title="Xem tất cả">Xem tất cả</a>
                                </div>
                            </div>

                            <%for(int i = 1; i < listCategory.size(); i++) {%>
                            <div class="tab-<%=i+1%> tab-content" data-tab="tab-<%=i+1%>">
                                <%
                                    ProductDAO pDAO = new ProductDAO();
                                    List<Product> hostPrd = pDAO.ListHotProduct(i+1);
                                %>
                                <div class="swiper_tab swiper-container swiper-carousel ajax-carousel">
                                    <div class="swiper-wrapper">
                                        <%for(Product p: hostPrd){%>
                                        <div class="item swiper-slide">
                                            <div class="item_product_main">
                                                <div class="variants product-action">
                                                    <div class="product-thumbnail">
                                                        <a class="image_thumb scale_hover" href="./productDetail?productID=<%=p.getProductID()%>" title="Áo len nữ">
                                                            <img class="lazyload"
                                                                 src="<%=p.getImages()%>"
                                                                 alt="">
                                                        </a>

                                                        <div class="action">
                                                            <form action="productDetail" method="get">
                                                                <input type="hidden" name="productID" value="<%=p.getProductID()%>" />
                                                                <button class="btn-cart btn-views add_to_cart ">
                                                                    <svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" viewBox="0 0 19 19"
                                                                         fill="none">
                                                                    <g>
                                                                    <path
                                                                        d="M18.7179 6.86766C18.467 6.55289 18.0906 6.37232 17.6852 6.37232H14.026L12.0418 1.82891C11.9188 1.54721 11.5907 1.41848 11.309 1.54157C11.0272 1.66459 10.8986 1.99274 11.0216 2.27448L12.8112 6.37236H6.18877L7.97837 2.27448C8.10139 1.99274 7.97276 1.66462 7.69103 1.54157C7.40933 1.41848 7.08117 1.54713 6.95816 1.82891L4.97396 6.37236H1.31482C0.909367 6.37236 0.532967 6.55289 0.282071 6.86769C0.0357758 7.17674 -0.0551051 7.57403 0.0327328 7.95782L1.9868 16.493C2.12325 17.089 2.65046 17.5052 3.26889 17.5052H15.7311C16.3495 17.5052 16.8767 17.089 17.0132 16.493L18.9673 7.95778C19.0551 7.574 18.9642 7.1767 18.7179 6.86766ZM15.7311 16.3919H3.26889C3.17437 16.3919 3.09158 16.3299 3.07203 16.2445L1.11796 7.70937C1.10263 7.64239 1.12835 7.59199 1.15269 7.56153C1.17526 7.53318 1.22636 7.48564 1.31482 7.48564H4.48779L4.34198 7.81951C4.21897 8.10125 4.34759 8.42937 4.62932 8.55242C4.70183 8.58411 4.77739 8.59911 4.85179 8.59911C5.06636 8.59911 5.27083 8.47431 5.36219 8.26512L5.7026 7.48571H13.2975L13.6379 8.26512C13.7292 8.47434 13.9337 8.59911 14.1483 8.59911C14.2226 8.59911 14.2982 8.58411 14.3708 8.55242C14.6525 8.42941 14.7811 8.10125 14.6581 7.81951L14.5123 7.48564H17.6853C17.7737 7.48564 17.8248 7.53318 17.8474 7.56153C17.8717 7.59203 17.8974 7.64243 17.8821 7.70933L15.928 16.2445C15.9085 16.3299 15.8256 16.3919 15.7311 16.3919Z"
                                                                        fill="white" />
                                                                    <path
                                                                        d="M6.16016 9.89771C5.85274 9.89771 5.60352 10.1469 5.60352 10.4543V14.5364C5.60352 14.8438 5.85274 15.093 6.16016 15.093C6.46757 15.093 6.7168 14.8438 6.7168 14.5364V10.4543C6.7168 10.1469 6.46761 9.89771 6.16016 9.89771Z"
                                                                        fill="white" />
                                                                    <path
                                                                        d="M9.5 9.89771C9.19259 9.89771 8.94336 10.1469 8.94336 10.4543V14.5364C8.94336 14.8438 9.19259 15.093 9.5 15.093C9.80741 15.093 10.0566 14.8438 10.0566 14.5364V10.4543C10.0566 10.1469 9.80741 9.89771 9.5 9.89771Z"
                                                                        fill="white" />
                                                                    <path
                                                                        d="M12.8398 9.89771C12.5324 9.89771 12.2832 10.1469 12.2832 10.4543V14.5364C12.2832 14.8438 12.5324 15.093 12.8398 15.093C13.1473 15.093 13.3965 14.8438 13.3965 14.5364V10.4543C13.3964 10.1469 13.1473 9.89771 12.8398 9.89771Z"
                                                                        fill="white" />
                                                                    </g>
                                                                    <defs>
                                                                    <clipPath>
                                                                        <rect width="19" height="19" fill="white" />
                                                                    </clipPath>
                                                                    </defs>
                                                                    </svg>
                                                                    Thêm vào giỏ hàng
                                                                </button>
                                                            </form>
                                                        </div>
                                                    </div>
                                                    <div class="product-info">
                                                        <h3 class="product-name"><a href="./productDetail?productID=<%=p.getProductName()%>"><%=p.getProductName()%></a></h3>
                                                        <div class="price-box">
                                                            <%=formatter.format(p.getUnitPrice() * (100 - p.getDiscount()) / 100)%>₫&nbsp;
                                                            <% if(p.getDiscount() != 0){%>
                                                            <span class="compare-price"><%=formatter.format(p.getUnitPrice())%>₫</span>
                                                            <%}%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <%}%>

                                    </div>
                                </div>
                                <div class="view-more clearfix">
                                    <a href="./listProduct?categoryID=<%=i+1%>" title="Xem tất cả">Xem tất cả</a>
                                </div>
                            </div>
                            <%}%>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <div class="mid-footer">
            <div class="container">
                <div class="row">
                    <div class="col-12 col-md-6 col-lg-5 link-list col-footer">




                        <div class="kk"> <a class="l1" href="https://themes.sapo.vn/demo/template-alena">HNG JEWELRY</a>
                            <p class="shop text">Shop Trang Sức HNG</p>
                        </div>


                        <div class="item">


                            <svg xmlns="http://www.w3.org/2000/svg" width="36" height="36" viewBox="0 0 36 36" fill="none">
                            <rect width="36" height="36" rx="10" fill="#FE9614"></rect>
                            <g clip-path="url(#clip0_8_762)">
                            <path
                                d="M18 8.4707C13.9043 8.4707 10.5883 11.8057 10.5883 15.9249C10.5883 21.1417 14.6216 25.3759 18 27.5295C21.3785 25.3759 25.4118 21.1417 25.4118 15.9249C25.4118 11.8057 22.0957 8.4707 18 8.4707ZM18 19.5108C16.0249 19.5108 14.4345 17.9008 14.4345 15.9249C14.4345 13.9489 16.0353 12.3389 18 12.3389C19.9647 12.3389 21.5656 13.9489 21.5656 15.9249C21.5656 17.9008 19.9751 19.5108 18 19.5108Z"
                                fill="white"></path>
                            </g>
                            <defs>
                            <clipPath id="clip0_8_762">
                                <rect x="10.5883" y="8.4707" width="36" height="36" rx="7.41176" fill="white"></rect>

                            </clipPath>
                            </defs>
                            </svg>
                            <span class="map">Đại học FPT</span>
                            <p></p>
                        </div>
                        <div class="item">
                            <svg xmlns="http://www.w3.org/2000/svg" width="36" height="36" viewBox="0 0 36 36" fill="none">
                            <rect width="36" height="36" rx="10" fill="#FE9614"></rect>
                            <g clip-path="url(#clip0_8_804)">
                            <path
                                d="M18 8.4707C12.7453 8.4707 8.47058 12.7454 8.47058 18.0001C8.47058 23.2548 12.7453 27.5295 18 27.5295C23.2547 27.5295 27.5294 23.2548 27.5294 18.0001C27.5294 12.7454 23.2547 8.4707 18 8.4707ZM22.532 22.9291C22.3772 23.084 22.1739 23.1619 21.9706 23.1619C21.7673 23.1619 21.5639 23.084 21.4092 22.9291L17.4386 18.9586C17.2892 18.8102 17.2059 18.6084 17.2059 18.3972V13.2354C17.2059 12.7963 17.5616 12.4413 18 12.4413C18.4384 12.4413 18.7941 12.7963 18.7941 13.2354V18.0685L22.532 21.8063C22.8425 22.1169 22.8425 22.6187 22.532 22.9291Z"
                                fill="white"></path>
                            </g>
                            <defs>
                            <clipPath id="clip0_8_804">
                                <rect x="8.47058" y="8.4707" width="19.0588" height="19.0588" rx="9.52941" fill="white"></rect>
                            </clipPath>
                            </defs>
                            </svg>
                            <span class="time">Cả ngày</span>
                            <p></p>                            
                        </div>
                        <div class="item tel_item">
                            <svg xmlns="http://www.w3.org/2000/svg" width="36" height="36" viewBox="0 0 36 36" fill="none">
                            <rect width="36" height="36" rx="10" fill="#FE9614"></rect>
                            <path fill-rule="evenodd" clip-rule="evenodd"
                                  d="M15.2144 16.99C15.4027 16.7084 15.5852 16.433 15.7734 16.1514C16.418 15.1844 16.3952 15.4965 15.9502 14.4132C15.5681 13.489 15.1802 12.5709 14.798 11.6467C14.4387 10.7898 14.4786 10.6429 13.4804 10.594C13.1097 10.5695 12.756 10.6246 12.4994 10.7776C11.6552 11.2917 10.8965 12.5709 10.6684 13.6665C9.68161 20.1665 18.0094 27.8784 24.8997 27.5173C25.8694 27.4194 26.7934 26.5686 27.1984 25.5281C27.3239 25.1548 27.4038 24.7631 27.4551 24.3652C27.6205 23.1105 27.5863 23.3737 26.5425 22.8106C25.6983 22.3577 24.8541 21.8987 24.0042 21.4457C23.1943 21.005 23.3825 20.8949 22.8064 21.5804C22.4242 22.0333 22.0478 22.4801 21.6656 22.933C21.1579 23.5328 21.3177 23.5084 20.5818 23.2207C18.3345 22.3516 16.07 20.595 15.0718 18.0549C14.8209 17.4062 14.8494 17.5408 15.2144 16.99Z"
                                  fill="white"></path>
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

                                <a class="yt" href="https://www.youtube.com/" title="Theo dõi trên Youtube">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="41" height="40" viewBox="0 0 41 40" fill="none">
                                    <rect y="0.000488281" width="40.0333" height="39.9917" rx="10" fill="#FE9614"></rect>
                                    <path d="M29.607 16.1986C29.377 15.3406 28.702 14.6636 27.845 14.4326C26.279 14.0026 20.014 13.9956 20.014 13.9956C20.014 13.9956 20.014 13.9956 20.014 13.9956C20.014 13.9956 13.75 13.9886 12.183 14.3996C11.343 14.6286 10.649 15.3206 10.417 16.1776C10.004 17.7435 10 20.991 10 20.9916C10 20.9916 10 20.9916 10 20.9916C10 20.9923 9.99604 24.2558 10.406 25.8056C10.636 26.6626 11.311 27.3396 12.169 27.5706C13.751 28.0006 19.9987 28.0076 19.999 28.0076C19.999 28.0076 19.999 28.0076 19.999 28.0076C19.9993 28.0076 26.264 28.0146 27.83 27.6046C28.686 27.3746 29.364 26.6986 29.597 25.8416C29.9902 24.3551 30.0127 21.3512 30.0139 21.0535C30.014 21.0362 30.014 21.0231 30.0141 21.0057C30.0149 20.7073 30.0126 17.6863 29.607 16.1986ZM20.6108 22.5061C19.4541 23.1708 18.0114 22.3351 18.0125 21.0009V21.0009C18.0136 19.6667 19.458 18.8334 20.6136 19.5003V19.5003C21.7714 20.1685 21.7699 21.8401 20.6108 22.5061V22.5061Z"
                                          fill="white"></path>
                                    </svg>
                                </a>


                                <a class="instagram" href="https://www.instagram.com/?hl=en" title="Theo dõi trên Instagram">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="41" height="40" viewBox="0 0 41 40" fill="none">
                                    <rect x="0.0375977" width="40.0333" height="39.9917" rx="10" fill="#FE9614"></rect>
                                    <path
                                        d="M20.053 14.2183C16.8578 14.2183 14.2694 16.8053 14.2694 19.9959C14.2694 23.1877 16.8578 25.7747 20.053 25.7747C23.2456 25.7747 25.8365 23.1877 25.8365 19.9959C25.8365 16.8053 23.2456 14.2183 20.053 14.2183ZM20.053 23.7501C17.9775 23.7501 16.2948 22.0692 16.2948 19.9971C16.2948 17.9238 17.9775 16.2441 20.053 16.2441C22.1284 16.2441 23.8086 17.9238 23.8086 19.9971C23.8086 22.0692 22.1284 23.7501 20.053 23.7501Z"
                                        fill="white"></path>
                                    <path
                                        d="M26.0667 15.3531C26.8115 15.3531 27.4153 14.7499 27.4153 14.0058C27.4153 13.2618 26.8115 12.6586 26.0667 12.6586C25.3219 12.6586 24.7181 13.2618 24.7181 14.0058C24.7181 14.7499 25.3219 15.3531 26.0667 15.3531Z"
                                        fill="white"></path>
                                    <path d="M30.7293 12.6361C30.1426 11.1252 28.9479 9.93041 27.4354 9.34678C26.5609 9.01809 25.6364 8.84188 24.7006 8.82188C23.4958 8.76939 23.1143 8.75439 20.0592 8.75439C17.0042 8.75439 16.6126 8.75439 15.4179 8.82188C14.4846 8.84063 13.5601 9.01684 12.6856 9.34678C11.1718 9.93041 9.97709 11.1252 9.39161 12.6361C9.06258 13.5109 8.88619 14.4333 8.86742 15.3681C8.81363 16.5703 8.79736 16.9515 8.79736 20.0046C8.79736 23.0565 8.79736 23.4452 8.86742 24.6412C8.88619 25.576 9.06258 26.4983 9.39161 27.3744C9.97834 28.8841 11.1731 30.0789 12.6868 30.6637C13.5576 31.0037 14.4821 31.1961 15.4204 31.2261C16.6251 31.2786 17.0067 31.2949 20.0617 31.2949C23.1168 31.2949 23.5083 31.2949 24.7031 31.2261C25.6376 31.2074 26.5621 31.0299 27.4379 30.7025C28.9504 30.1164 30.1451 28.9228 30.7318 27.4119C31.0609 26.5371 31.2373 25.6148 31.256 24.6799C31.3098 23.4777 31.3261 23.0965 31.3261 20.0434C31.3261 16.9902 31.3261 16.6028 31.256 15.4068C31.2398 14.4595 31.0646 13.5209 30.7293 12.6361ZM29.2056 24.5487C29.1968 25.2686 29.0667 25.9822 28.8165 26.6583C28.4349 27.6418 27.658 28.4192 26.6747 28.7966C26.0054 29.0453 25.2998 29.1753 24.5855 29.1853C23.397 29.2403 23.0617 29.254 20.0142 29.254C16.9642 29.254 16.6526 29.254 15.4416 29.1853C14.7298 29.1765 14.0217 29.0453 13.3537 28.7966C12.3666 28.4204 11.5847 27.6431 11.2031 26.6583C10.9579 25.9909 10.8253 25.2848 10.814 24.5725C10.7602 23.3852 10.7477 23.0503 10.7477 20.0059C10.7477 16.9602 10.7477 16.6491 10.814 15.4381C10.8228 14.7182 10.9529 14.0058 11.2031 13.3297C11.5847 12.3437 12.3666 11.5676 13.3537 11.1902C14.0217 10.9427 14.7298 10.8115 15.4416 10.8015C16.6314 10.7477 16.9654 10.7327 20.0142 10.7327C23.063 10.7327 23.3757 10.7327 24.5855 10.8015C25.2998 10.8102 26.0054 10.9415 26.6747 11.1902C27.658 11.5688 28.4349 12.3462 28.8165 13.3297C29.0617 13.9971 29.1943 14.7032 29.2056 15.4156C29.2594 16.6041 29.2731 16.9377 29.2731 19.9834C29.2731 23.0219 29.2731 23.3539 29.2196 24.5431C29.2195 24.5469 29.2164 24.55 29.2126 24.55H29.2068C29.2061 24.55 29.2056 24.5494 29.2056 24.5487Z"
                                          fill="white"></path>
                                    </svg>
                                </a>


                                <a class="fb" href="https://www.facebook.com/sapowebvietnam/" title="Theo dõi trên Facebook">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="41" height="40" viewBox="0 0 41 40" fill="none">
                                    <rect x="0.0751953" width="40.0333" height="39.9917" rx="10" fill="#FE9614"></rect>
                                    <path d="M23.6002 11.2515L21.1667 11.2476C18.4328 11.2476 16.666 13.0583 16.666 15.861C16.666 17.0358 15.7137 17.9881 14.5389 17.9881H14.2193C14.0079 17.9881 13.8367 18.1593 13.8367 18.3705V21.4525C13.8367 21.6637 14.0081 21.8347 14.2193 21.8347C15.5706 21.8347 16.666 22.9302 16.666 24.2814V29.6114C16.666 29.8226 16.8372 29.9937 17.0487 29.9937H20.241C20.4524 29.9937 20.6236 29.8224 20.6236 29.6114V24.6955C20.6236 23.1155 21.9044 21.8347 23.4844 21.8347C23.6958 21.8347 23.867 21.6637 23.867 21.4525L23.8682 18.3705C23.8682 18.2691 23.8278 18.172 23.7562 18.1002C23.6845 18.0285 23.5869 17.9881 23.4854 17.9881H22.4268C21.4309 17.9881 20.6236 17.1808 20.6236 16.1849C20.6236 15.3183 20.8303 14.8783 21.9605 14.8783L23.5998 14.8777C23.811 14.8777 23.9822 14.7065 23.9822 14.4955V11.6337C23.9822 11.4229 23.8112 11.2518 23.6002 11.2515Z"
                                          fill="white"></path>
                                    </svg>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/js/bootstrap.min.js"
                integrity="sha512-ykZ1QQr0Jy/4ZkvKuqWn4iF3lqPZyij9iRv6sGqLRdTPkY69YX6+7wvVGmsdBbiIfN/8OdsI7HABjvEok6ZopQ=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://bizweb.dktcdn.net/100/455/315/themes/894917/assets/jquery.js?1724746453440"></script>
        <script src="https://bizweb.dktcdn.net/100/455/315/themes/894917/assets/lazy.js?1724746453440"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/6.6.2/swiper-bundle.min.js"
                integrity="sha512-a3I9zMTPjHAZ1m2rzDnyssovP22dGonVjogS4yPVA9jCtupqAm14AN9rX3SbQHpVTTu959VX64azK/HpfsQuig=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="main.js"></script>
        <script src="index.js"></script>

        <script>
            $(document).ready(function ($) {
                awe_lazyloadImage();
            });
            function awe_lazyloadImage() {
                var ll = new LazyLoad({
                    elements_selector: ".lazyload",
                    load_delay: 100,
                    threshold: 0
                });
            }
            window.awe_lazyloadImage = awe_lazyloadImage;
        </script>
        <script>
            var swiper = new Swiper('.home-service', {
                slidesPerView: 4,
                autoplay: false,
                pagination: {
                    el: '.home-service .swiper-pagination',
                    clickable: true,
                },
                navigation: {
                    nextEl: '.home-service .swiper-button-next',
                    prevEl: '.home-service .swiper-button-prev',
                },
                breakpoints: {
                    300: {
                        slidesPerView: 1,
                        spaceBetween: 30
                    },
                    768: {
                        slidesPerView: 3,
                        spaceBetween: 30
                    },
                    1024: {
                        slidesPerView: 4,
                        spaceBetween: 30
                    },
                    1200: {
                        slidesPerView: 4,
                        spaceBetween: 30
                    }
                }
            });
        </script>
    </body>
</html>