<%-- 
    Document   : detail
    Created on : Jun 9, 2025, 10:01:28 PM
    Author     : uyenm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
<link rel="stylesheet" href="<c:url value='/css/detail.css' />"/>

<div class="container my-5">
    <div class="row">
        <div class="col-md-6">
            <img src="<c:url value='/imgs/${laptop.name}.jpg' />" alt="${laptop.name}" class="img-fluid rounded "/>
        </div>

        <div class="col-md-6">
            <h2>${laptop.name}</h2>
            <p class="text-muted">Category: ${laptop.categoryId.name}</p>
            <h4 class="text-danger">
                Price:
                <fmt:formatNumber value="${laptop.price * 1000}" type="currency" maxFractionDigits="0"/> đ
            </h4>
            <!--<p>Tồn kho: <fmt:formatNumber value="${laptop.quantity}" type="number"/></p>-->
            <form action="add-to-cart" method="post" class="mt-4">
                <input type="hidden" name="id" value="${laptop.id}">
                <button type="submit" class="btn btn-primary btn-lg">
                    <i class="bi bi-cart3"></i> Add to cart
                </button>
            </form>
        </div>
    </div>

</div>