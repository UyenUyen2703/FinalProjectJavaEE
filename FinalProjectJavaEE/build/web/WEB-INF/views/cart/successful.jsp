<%-- 
    Document   : successful
    Created on : Jun 12, 2025, 10:17:30 AM
    Author     : uyenm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="success-container" style="text-align: center; padding: 50px; background-color: #f8f9fa;">
    <div class="success-content" style="max-width: 600px; margin: 0 auto; background: white; padding: 40px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
        <div style="color: #28a745; font-size: 4em; margin-bottom: 20px;">
            ✓
        </div>
        
        <h2 style="color: #28a745; margin-bottom: 20px;">Đặt hàng thành công!</h2>
        
        <c:if test="${not empty orderId}">
            <p style="margin-bottom: 20px; font-size: 1.1em;">
                Mã đơn hàng của bạn: <strong style="color: #007bff;">#${orderId}</strong>
            </p>
        </c:if>
        
        <p style="margin-bottom: 30px; color: #6c757d;">
            Cảm ơn bạn đã mua hàng. Chúng tôi sẽ xử lý đơn hàng của bạn trong thời gian sớm nhất.
        </p>
        
        <div style="margin-top: 30px;">
            <a href="<c:url value='/index' />" 
               style="display: inline-block; background-color: #007bff; color: white; padding: 12px 30px; text-decoration: none; border-radius: 5px; margin-right: 10px;">
                Tiếp tục mua hàng
            </a>
            
            <c:if test="${not empty orderId}">
                <a href="<c:url value='/order-history' />" 
                   style="display: inline-block; background-color: #6c757d; color: white; padding: 12px 30px; text-decoration: none; border-radius: 5px;">
                    Xem lịch sử đơn hàng
                </a>
            </c:if>
        </div>
    </div>
</div>