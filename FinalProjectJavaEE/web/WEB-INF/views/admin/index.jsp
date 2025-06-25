<%-- 
    Document   : index
    Created on : Jun 12, 2025, 12:53:46 PM
    Author     : uyenm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="<c:url value='/css/admin.css' />"/>

<h1>Admin - Product Management</h1>

<div style="margin-bottom: 20px;">
    <a href="<c:url value='/admin/create' />" class="btn-add">Thêm Sản Phẩm</a>
</div>

<table class="admin-table">
    <thead>
        <tr>
            <th>Id</th>
            <th>Tên sản phẩm</th>
            <th>Giá</th>
            <th>Số lượng</th>
            <th>Danh mục</th>
            <th>Tùy chọn</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="product" items="${list}">
            <tr>
                <td>${product.id}</td>
                <td>${product.name}</td>
                <td><fmt:formatNumber value="${product.price}" type="currency" currencySymbol="đ"/></td>
                <td><fmt:formatNumber value="${product.quantity}" type="number" maxFractionDigits="0"/></td>
                <td>${product.categoryId.name}</td>
                <td>
                    <a href="<c:url value='/admin/edit?id=${product.id}' />">Sửa</a> |
                    <a href="<c:url value='/admin/delete?id=${product.id}' />"
                       onclick="return confirm('Xóa sản phẩm này?');">Xóa</a>
                </td>

            </tr>
        </c:forEach>
    </tbody>
</table>
