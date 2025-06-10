<%-- 
    Document   : index
    Created on : Jun 3, 2025, 1:27:59 PM
    Author     : uyenm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
<link rel="stylesheet" href="<c:url value='/css/home.css' />"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

<div class="container my-4">
    <div class="mb-3">
        <form method="get" action="<c:url value='/index' />">
            <select name="sort" onchange="this.form.submit()" class="form-select w-auto d-inline-block">
                <option value="">-- Sắp xếp --</option>
                <option value="priceAsc" ${param.sort == 'priceAsc' ? 'selected' : ''}>Giá tăng dần</option>
                <option value="priceDesc" ${param.sort == 'priceDesc' ? 'selected' : ''}>Giá giảm dần</option>
            </select>
        </form>

    </div>

    <div class="row g-4">
        <c:forEach var="laptop" items="${list}">
            <div class="col-md-4">
                <div class="card h-100">
                    <a href="<c:url value='/detail?id=${laptop.id}'/>"><img src="<c:url value='/imgs/${laptop.name}.jpg'/>" class="card-img-top" alt="${laptop.name}"></a>
                    <div class="card-body">
                        <h5 class="card-title">${laptop.name}</h5>
                        <p class="card-text">
                            Giá: <span class="price"><fmt:formatNumber value="${laptop.price * 1000}" type="currency" maxFractionDigits="0"/></span><br>
                            <!--Tồn kho: <fmt:formatNumber value="${laptop.quantity}" type="number"/><br>-->
                            Danh mục: ${laptop.categoryId.name}
                        </p>
                    </div>
                    <div class="card-footer text-center bg-transparent border-0" >
                        <a href="add-to-cart?id=${laptop.id}" class="btn btn-primary" >
                            <i class="bi bi-cart3"></i> Add to cart
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
