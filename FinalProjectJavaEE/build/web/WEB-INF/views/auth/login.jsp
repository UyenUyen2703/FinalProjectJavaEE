<%-- 
    Document   : login
    Created on : Jun 9, 2025, 4:10:48 PM
    Author     : uyenm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="<c:url value='/css/login.css' />"/>

<div class="background">
    <div class="login-box">
        <h2>Login</h2>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <form method="post" action="<c:url value='/login' />">
            <div class="input-group">
                <input type="email" name="email" placeholder="Email" required>
                <i class="fas fa-user"></i>
            </div>
            <div class="input-group">
                <input type="password" name="password" placeholder="Password" required>
                <i class="fas fa-lock"></i>
            </div>
            <div class="options">
                <label><input type="checkbox" name="remember">Remember me</label>
                <a href="#">Forgot password?</a>
            </div>
            <button type="submit" class="login-btn">Login</button>
            <p class="register-link">Don't have an account? <a href="<c:url value="/register"/>">Register</a></p>
        </form>

    </div>
</div>