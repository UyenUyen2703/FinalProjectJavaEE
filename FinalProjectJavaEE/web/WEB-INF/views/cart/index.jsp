<%-- 
    Document   : index
    Created on : Jun 12, 2025, 10:03:48 AM
    Author     : uyenm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="<c:url value='/css/cart.css' />"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

<div class="cart-container">
    <div class="cart">
        <h2 class="cart-title">Shopping Cart</h2>
        <c:forEach var="item" items="${items}">
            <div class="cart-item">
                <img src="<c:url value='/imgs/${item.product.name}.jpg'/>" class="product-image" alt="${item.product.name}">
                <div class="product-details">
                    <span class="product-category">Product Name: </span>
                    <span class="product-name">${item.product.name}</span>
                    <div class="quantity-control">
                        <a href="update?id=${item.product.id}&quantity=${item.quantity - 1}" class="qty-btn">−</a>
                        <input type="number" name="quantity" value="${item.quantity}" readonly />
                        <a href="update?id=${item.product.id}&quantity=${item.quantity + 1}" class="qty-btn">+</a>
                    </div>
                </div>
                <div class="product-price">
                    <fmt:formatNumber value="${item.product.price *1000}" maxFractionDigits="0"/>₫</div>
                <a href="remove?id=${item.product.id}" class="remove-btn">×</a>
            </div>
        </c:forEach>
        <a href="${pageContext.request.contextPath}/index" class="back-link"><i class="bi bi-arrow-left"></i> Back to store</a>
    </div>

    <div class="summary">
        <h3>Summary</h3>
        <div class="summary-item"><span>Quantity:</span><span>${items.size()}</span></div>
        <div class="summary-item"><span>Total: 
                <fmt:formatNumber value="${total*1000}" type="currency" maxFractionDigits="0"/></span></div>
        <a href="checkout" class="checkout-btn">Checkout</a>
    </div>
</div>
