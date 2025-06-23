<%-- 
    Document   : history
    Created on : Jun 23, 2025, 11:38:31 PM
    Author     : uyenm
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/order-history.css"/>

<div class="order-history">
    <h2>Order History</h2>
    <table class="order-table">
        <thead>
            <tr>
                <th>Id</th>
                <th>Product Name</th>
                <th>Status</th>
                <th>Total</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="order" items="${orders}">
                <c:forEach var="item" items="${order.orderDetailList}">
                    <tr>
                        <td>#${order.id}</td>
                        <td>
                            <div class="product-info">
                                <img src="${pageContext.request.contextPath}/imgs/${item.productId.name}.jpg" width="10%" />
                                <span>${item.productId.name}</span>
                            </div>
                        </td>
                        <td>
                            <span class="status">
                                <c:choose>
                                    <c:when test="${order.status == 'New'}">New</c:when>
                                    <c:when test="${order.status == 'Cancelled'}">Cancelled</c:when>
                                    <c:when test="${order.status == 'Delivered'}">Delivered</c:when>
                                    <c:otherwise>${order.status}</c:otherwise>
                                </c:choose>
                            </span>

                        </td>
                        <td>
                            <fmt:formatNumber value="${item.price * item.quantity * 1000}" type="currency" maxFractionDigits="0" />
                        </td>
                    </tr>
                </c:forEach>
            </c:forEach>
        </tbody>
    </table>
</div>

