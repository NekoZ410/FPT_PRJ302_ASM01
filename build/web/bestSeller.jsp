<%-- 
    Document   : BestSeller
    Created on : 26 thg 10, 2024, 20:49:01
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.NumberFormat"%>
<%@taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<%
    CategoryDAO cd = new CategoryDAO();
    List<Category> listCategory = cd.getCategoryList();
    
    List<Product> listProduct = (List) request.getAttribute("listProduct");
    
    NumberFormat formatter = NumberFormat.getInstance(new Locale("vi", "VN"));
%>
<html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="css/breadcrumb.css" />
        <link rel="stylesheet" href="css/searchProduct.css" />
        <title>Sản phẩm được mua nhiều</title>
    </head>

    <body>
        <nav class="navbar navbar-expand-lg py-3 fixed-top">
            <div class="container">
                <a href="home.jsp" class="navbar-brand">HNG</a>
                <div class="search">
                    <div class="header_search">
                        <form class="search-bar" action="/searchProduct" method="get" role="search">
                            <div class="collection-selector hidden-xs hidden-sm">
                                <div class="search_text">Tất cả</div>
                                <div id="search_info" class="list_search" style="display: none;">
                                    <div class="search_item active" data-coll-id="0">Tất cả</div>
                                    <%
                                        for(int i = 0; i < listCategory.size(); i++){
                                    %>
                                    <div class="search_item" data-coll-id="<%=i + 1%>"><%=listCategory.get(i).getCategoryName()%></div> 
                                    <%
                                        }
                                    %>
                                    <div class="liner_search"></div>
                                </div>
                            </div>
                            <input type="search" name="query" value="" placeholder="Tìm sản phẩm bạn mong muốn"
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
                                <li class="nav-item">
                                    <a class="a-img" href="home.jsp">
                                        Trang chủ
                                    </a>
                                </li>
                                <li class="nav-item">
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
                                <li class="nav-item active">
                                    <a class="a-img" href="#">
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
                                <a href="tel:0398 810 757">0398 810 757</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <section class="bread-crumb">
            <div class="container">
                <ul class="breadcrumb">
                    <li class="home">
                        <a href="home.jsp"><span>Trang chủ</span></a>
                        <span class="mr_lr">&nbsp;<svg aria-hidden="true" focusable="false" data-prefix="fas"
                                                       data-icon="chevron-right" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512"
                                                       class="svg-inline--fa fa-chevron-right fa-w-10">
                            <path fill="currentColor"
                                  d="M285.476 272.971L91.132 467.314c-9.373 9.373-24.569 9.373-33.941 0l-22.667-22.667c-9.357-9.357-9.375-24.522-.04-33.901L188.505 256 34.484 101.255c-9.335-9.379-9.317-24.544.04-33.901l22.667-22.667c9.373-9.373 24.569-9.373 33.941 0L285.475 239.03c9.373 9.372 9.373 24.568.001 33.941z"
                                  class=""></path>
                            </svg>&nbsp;</span>
                    </li>

                    <li><strong><span> Các mặt hàng được mua nhiều (<%=listProduct.size()%> mặt hàng)</span></strong></li>

                </ul>
            </div>
        </section>

        <section class="signup search-main wrap_background background_white clearfix">
            <div class="container">
                <div class="category-products">
                    <div class="products-view-grid">
                        <div class="row">

                            <%for(int i = 0; i < listProduct.size(); i++){%>
                            <div class="col-6 col-md-4 col-lg-3">
                                <div class="item_product_main">

                                    <div class="variants product-action">
                                        <div class="product-thumbnail">
                                            <a class="image_thumb scale_hover" href="./productDetailproductID=<%=listProduct.get(i).getProductID()%>" style="height: 255px;">
                                                <img class="lazyload loaded"
                                                     src="<%=listProduct.get(i).getImages()%>"
                                                     data-was-processed="true">
                                            </a>

                                            <div class="action">
                                                <form action="productDetail" method="get">
                                                    <input type="hidden" name="productID" value="<%=listProduct.get(i).getProductID()%>" />
                                                    <button class="btn-cart btn-views add_to_cart " <c:if test="${sessionScope.userAccount.role == 'Admin'}">style="display:none"</c:if>>
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" viewBox="0 0 19 19" fill="none">
                                                        <g>
                                                        <path
                                                            d="M18.7179 6.86766C18.467 6.55289 18.0906 6.37232 17.6852 6.37232H14.026L12.0418 1.82891C11.9188 1.54721 11.5907 1.41848 11.309 1.54157C11.0272 1.66459 10.8986 1.99274 11.0216 2.27448L12.8112 6.37236H6.18877L7.97837 2.27448C8.10139 1.99274 7.97276 1.66462 7.69103 1.54157C7.40933 1.41848 7.08117 1.54713 6.95816 1.82891L4.97396 6.37236H1.31482C0.909367 6.37236 0.532967 6.55289 0.282071 6.86769C0.0357758 7.17674 -0.0551051 7.57403 0.0327328 7.95782L1.9868 16.493C2.12325 17.089 2.65046 17.5052 3.26889 17.5052H15.7311C16.3495 17.5052 16.8767 17.089 17.0132 16.493L18.9673 7.95778C19.0551 7.574 18.9642 7.1767 18.7179 6.86766ZM15.7311 16.3919H3.26889C3.17437 16.3919 3.09158 16.3299 3.07203 16.2445L1.11796 7.70937C1.10263 7.64239 1.12835 7.59199 1.15269 7.56153C1.17526 7.53318 1.22636 7.48564 1.31482 7.48564H4.48779L4.34198 7.81951C4.21897 8.10125 4.34759 8.42937 4.62932 8.55242C4.70183 8.58411 4.77739 8.59911 4.85179 8.59911C5.06636 8.59911 5.27083 8.47431 5.36219 8.26512L5.7026 7.48571H13.2975L13.6379 8.26512C13.7292 8.47434 13.9337 8.59911 14.1483 8.59911C14.2226 8.59911 14.2982 8.58411 14.3708 8.55242C14.6525 8.42941 14.7811 8.10125 14.6581 7.81951L14.5123 7.48564H17.6853C17.7737 7.48564 17.8248 7.53318 17.8474 7.56153C17.8717 7.59203 17.8974 7.64243 17.8821 7.70933L15.928 16.2445C15.9085 16.3299 15.8256 16.3919 15.7311 16.3919Z"
                                                            fill="white"></path>
                                                        <path
                                                            d="M6.16016 9.89771C5.85274 9.89771 5.60352 10.1469 5.60352 10.4543V14.5364C5.60352 14.8438 5.85274 15.093 6.16016 15.093C6.46757 15.093 6.7168 14.8438 6.7168 14.5364V10.4543C6.7168 10.1469 6.46761 9.89771 6.16016 9.89771Z"
                                                            fill="white"></path>
                                                        <path
                                                            d="M9.5 9.89771C9.19259 9.89771 8.94336 10.1469 8.94336 10.4543V14.5364C8.94336 14.8438 9.19259 15.093 9.5 15.093C9.80741 15.093 10.0566 14.8438 10.0566 14.5364V10.4543C10.0566 10.1469 9.80741 9.89771 9.5 9.89771Z"
                                                            fill="white"></path>
                                                        <path
                                                            d="M12.8398 9.89771C12.5324 9.89771 12.2832 10.1469 12.2832 10.4543V14.5364C12.2832 14.8438 12.5324 15.093 12.8398 15.093C13.1473 15.093 13.3965 14.8438 13.3965 14.5364V10.4543C13.3964 10.1469 13.1473 9.89771 12.8398 9.89771Z"
                                                            fill="white"></path>
                                                        </g>
                                                        <defs>
                                                        <clipPath>
                                                            <rect width="19" height="19" fill="white"></rect>
                                                        </clipPath>
                                                        </defs>
                                                        </svg>
                                                        Thêm vào giỏ hàng
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                        <div class="product-info">
                                            <h3 class="product-name"><a href="/ao-len-nu" title="<%=listProduct.get(i).getProductName()%>"><%=listProduct.get(i).getProductName()%></a></h3>
                                            <div class="price-box">
                                                <%=formatter.format(((listProduct.get(i).getUnitPrice()) * (100 - listProduct.get(i).getDiscount())) / 100)%>₫&nbsp;
                                                <% if(listProduct.get(i).getDiscount() != 0){%>
                                                <span class="compare-price"><%=formatter.format(listProduct.get(i).getUnitPrice())%>₫</span>
                                                <%}%>
                                            </div>
                                        </div>
                                    </div>
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

        <script src="https://bizweb.dktcdn.net/100/455/315/themes/894917/assets/jquery.js?1724746453440"></script>
        <script src="main.js"></script>
    </body>

</html>

