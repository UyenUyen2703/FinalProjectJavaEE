<%-- 
    Document   : update
    Created on : Jun 24, 2025, 5:43:37 PM
    Author     : uyenm
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2>Chỉnh sửa sản phẩm</h2>

<form method="post" action="/FinalProjectJavaEE/admin/edit" enctype="multipart/form-data">
    <input type="hidden" name="id" value="${product.id}" />

    <div class="form-group">
        <label>Tên sản phẩm:</label>
        <input type="text" name="name" class="form-control" value="${product.name}" required />
    </div>

    <div class="form-group">
        <label>Giá:</label>
        <input type="number" name="price" class="form-control" step="0.01" value="${product.price}" required />
    </div>

    <div class="form-group">
        <label>Số lượng:</label>
        <input type="number" name="quantity" class="form-control" value="${product.quantity.intValue()}" required />
    </div>

    <div class="form-group">
        <label>Danh mục:</label>
        <select name="categoryId" class="form-control" required>
            <c:forEach var="cat" items="${categories}">
                <option value="${cat.id}" ${product.categoryId.id == cat.id ? 'selected' : ''}>
                    ${cat.name}
                </option>
            </c:forEach>
        </select>
    </div>

    <div class="form-group">
        <label>Hình ảnh:</label>
        <input type="file" name="image" class="form-control" />
        <br/>
        <img src="<c:url value="/imgs/${product.name}.jpg"/>" width="100" />
    </div>

    <div class="form-group mt-3">
        <button type="submit" class="btn btn-success">Cập nhật</button>
        <a href="${pageContext.request.contextPath}/admin" class="btn btn-secondary">Quay lại</a>
    </div>
</form>

