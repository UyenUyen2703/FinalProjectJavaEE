<%-- 
    Document   : register
    Created on : Jun 9, 2025, 10:35:55 PM
    Author     : uyenm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="<c:url value='/css/register.css' />"/>

<div class="background">
    <div class="login-box">
        <h2>Register</h2>
        <form method="post" action="/register">
            <div class="input-group">
                <input type="text" name="username" placeholder="Name" required>
                <i class="fas fa-user"></i>
            </div>
            <div class="input-group">
                <input type="email" name="email" placeholder="abc@gmail.com" required>
                <i class="fas fa-envelope"></i>
            </div>
            <div class="input-group">
                <input type="text" name="address" placeholder="Address" required>
                <i class="fas fa-home"></i>
            </div>
            <div class="input-group">
                <input type="number" name="phone" placeholder="Phone" required>
                <i class="fas fa-phone"></i>
            </div>
            <div class="input-group">
                <input type="password" name="password" placeholder="Password" required>
                <i class="fas fa-lock"></i>
            </div>
            <div class="input-group">
                <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
                <i class="fas fa-lock"></i>
            </div>
            <button type="submit" class="login-btn">Register</button>
            <p class="register-link">Already have an account? <a href="<c:url value="/login"/>">Login</a></p>
        </form>
    </div>
</div>