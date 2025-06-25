<%-- 
    Document   : create
    Created on : Jun 24, 2025, 5:43:30 PM
    Author     : uyenm
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<h2>Thêm sản phẩm</h2>

<form action="<c:url value='/admin/create'/>" method="post" enctype="multipart/form-data">
    Tên sản phẩm: <input type="text" name="name"/><br/>
    Giá: <input type="number" step="0.01" name="price"/><br/>
    Số lượng: <input type="number" name="quantity"/><br/>
    Hình ảnh: <input type="file" name="image"/><br/>
    Danh mục:
    <select name="categoryId">
        <c:forEach var="cate" items="${categories}">
            <option value="${cate.id}">${cate.name}</option>
        </c:forEach>
    </select><br/>

    <input type="submit" value="Thêm"/>
</form>
