<%-- 
    Document   : layout
    Created on : May 27, 2025, 3:03:07 PM
    Author     : uyenm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
        <link rel="stylesheet" href="<c:url value='/css/layout.css' />"/>
        <title>Laptop Store</title>
    </head>
    <body>
        <div class="container-fluid">
            <c:if test="${isAuthPage != true}">
                <div class="row">
                    <div class="col-sm-12 d-flex justify-content-between align-items-center flex-wrap" style="background-color: #ffe5ec; border-bottom: 2px solid #fa7070;">
                        <div class="header-brand">
                            <a href="<c:url value='/'/>">
                                <img src="<c:url value='/imgs/logo.png'/>" class="logo" alt="logo">
                            </a>
                            <h1>Laptop Store</h1>
                        </div>

                        <form method="get" action="<c:url value='/index' />" class="search-textbox">
                            <i class="fa fa-search"></i>
                            <input type="text" name="keyword" value="${param.keyword}" placeholder="Search..." />
                        </form>

                        <nav>
                            <a href="<c:url value="/"/>">Home</a>
                            <a href="<c:url value="/register"/>">Register</a>
                            <a href="<c:url value="/login"/>">Login</a>
                            <a href="<c:url value="/view-cart"/>" class="btn-cart" >
                                <c:set var="cart" value="${sessionScope.cart}" />
                                <span><i class="bi bi-cart3"></i>${cart != null ? cart.totalQuantity : 0}</span>
                            </a>
                        </nav>
                    </div>
                </div>
            </c:if>

            <div class="row">
                <div class="col-sm-12" style="padding: 0">
                    <!-- View -->
                    <jsp:include page="/WEB-INF/views/${folder}/${view}.jsp"/>
                </div>
            </div>

            <c:if test="${isAuthPage != true}">
                <div class="row">
                    <div class="col-sm-12">
                        <!-- Footer -->
                        <hr/>
                        <p>&copy; 2025 Cửa Hàng Laptop. All rights reserved.</p>
                    </div>
                </div>
            </c:if>

        </div>
    </body>
</html>

