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
                <option value="">--Sort --</option>
                <option value="priceAsc" ${param.sort == 'priceAsc' ? 'selected' : ''}>Price increasing</option>
                <option value="priceDesc" ${param.sort == 'priceDesc' ? 'selected' : ''}>Price decreasing</option>
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
                            Price: <span class="price"><fmt:formatNumber value="${laptop.price * 1000}" type="currency" maxFractionDigits="0"/></span><br>
                            <!--Tồn kho: <fmt:formatNumber value="${laptop.quantity}" type="number"/><br>-->
                            Category Name: ${laptop.categoryId.name}
                        </p>
                    </div>
                    <div class="btn-cart">
                        <form action="${pageContext.request.contextPath}/add" method="get" class="text-center">
                            <input type="hidden" name="id" value="${laptop.id}" />
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-cart3"></i> Add to cart
                            </button>
                        </form>
                    </div>


                </div>
            </div>
        </c:forEach>
    </div>
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center mt-4">

            <c:if test="${currentPage > 1}">
                <li class="page-item">
                    <c:url var="firstPageUrl" value="/index">
                        <c:param name="page" value="1" />
                        <c:param name="size" value="6" />
                        <c:if test="${sort != null}">
                            <c:param name="sort" value="${sort}" />
                        </c:if>
                    </c:url>
                    <a class="page-link" href="${firstPageUrl}">First</a>
                </li>
            </c:if>

            <c:forEach var="i" begin="1" end="${totalPages}">
                <li class="page-item ${i == currentPage ? 'active' : ''}">
                    <c:url var="pageUrl" value="/index">
                        <c:param name="page" value="${i}" />
                        <c:param name="size" value="6" />
                        <c:if test="${sort != null}">
                            <c:param name="sort" value="${sort}" />
                        </c:if>
                    </c:url>
                    <a class="page-link" href="${pageUrl}">${i}</a>
                </li>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <li class="page-item">
                    <c:url var="lastPageUrl" value="/index">
                        <c:param name="page" value="${totalPages}" />
                        <c:param name="size" value="6" />
                        <c:if test="${sort != null}">
                            <c:param name="sort" value="${sort}" />
                        </c:if>
                    </c:url>
                    <a class="page-link" href="${lastPageUrl}">Last</a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>
