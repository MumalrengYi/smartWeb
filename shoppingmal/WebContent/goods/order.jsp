<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
주문서
<hr />
1. 주문 상품<br />
<form action="goodsOrder.gd" method="post">
<table border=1 width="600">
	<tr><td colspan="2">상품정보</td>
		<td>적용 금액</td><td>판매자</td><td>배송비</td></tr>
<c:set var="cartPrice" value="0" />
<c:set var="prodDelFee" value="0" />
<c:set var="prodNums" value="" />
<c:forEach items="${list }" var="dto">
	<tr><td>
			<img src="goods/upload/${dto.goodsDTO.prodImage.split(',')[0] }" width="50" /></td>
		<td>상품명<br />
			${dto.goodsDTO.prodName }&nbsp;&nbsp;&nbsp;&nbsp;
			${dto.cartDTO.cartQty }개/
			${dto.goodsDTO.prodPrice }원</td>
		<td>${dto.cartDTO.cartPrice }</td>
		<td>${dto.goodsDTO.prodSupplyer }</td>
		<td>${dto.goodsDTO.prodDelFee }</td></tr>
<c:set var="cartPrice" value="${cartPrice + dto.cartDTO.cartPrice }" />
<c:set var="prodDelFee" value="${prodDelFee + dto.goodsDTO.prodDelFee }" />
<c:set var="prodNums" value="${prodNums += dto.goodsDTO.prodNum += ',' }" />
</c:forEach>
</table>
<table>
	<tr><td>상품 금액<br />${cartPrice }</td>
		<td>+</td><td>배송비<br />${prodDelFee }</td>
		<td>=</td><td>최종 결제 금액<br />${cartPrice + prodDelFee }
		<input type="hidden" name="purchaseTotPrice" value="${cartPrice + prodDelFee }" />
		<input type="hidden" name="prodNums" value="${prodNums }" /></td></tr>
</table>
<table>
	<tr><td>이름</td>
		<td><input type="text" name="receiverName"></td></tr>
	<tr><td>주소</td>
		<td><input type="text" name="purchaseAddr"></td></tr>
	<tr><td>연락처</td>
		<td><input type="text" name="receiverPhone"></td></tr>
	<tr><td>주문 메세지</td>
		<td><input type="text" name="purchaseRequest"></td></tr>
	<tr><td>결제 방법</td>
		<td>
			<select name="purchaseMethod">
				<option>카드</option>
				<option>카카오 페이</option>
			</select>
		</td></tr>
</table>
<table>
	<tr><td><input type="submit" value="결제" /></td></tr>
</table>
</form>
</body>
</html>