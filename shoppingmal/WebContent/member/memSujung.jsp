<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;                
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
</head>
<body>
<form action="memSujungOk.mem" method="post" name="frm">
 	<table border = 1>
		<tr><td>아이디</td>
			<td>${dto.memId }</td></tr>
		<tr><td>비밀번호</td>
			<td><input type="password" name="memPw" />
				<span>${pwFail }</span></td></tr>
		<tr><td>이름</td>
			<td>${dto.memName }</td></tr>
		<tr><td>우편번호</td>
			<td><input type="text" name="postNumber" id="sample4_postcode" value="${dto.postNumber }"></td></tr>
		<tr><td>주소</td>
			<td><input type="text" name="memAddress" id="sample4_roadAddress" value="${dto.memAddress }" size="50">
				<a href="javascript:sample4_execDaumPostcode();">주소 검색</a></td></tr>
		<tr><td>상세 주소</td>
			<td><input type="text" name="detailAdd" value="${dto.detailAdd }"></td></tr>
		<tr><td>연락처</td>
			<td><input type="text" name="memPhone" value="${dto.memPhone }"></td></tr>
		<tr><td>이메일</td>
			<td><input type="text" name="memEmail" value="${dto.memEmail }"></td></tr>
		<tr><td>생년월일</td>
			<td><input type="text" name="memBirth" value="${dto.memBirth }"></td></tr>
		<tr><td>성별</td>
			<td><c:if test="${dto.memGender == 'M'}">남자</c:if>
				<c:if test="${dto.memGender == 'F'}">여자</c:if></td></tr>
		<tr><td>계좌번호</td>
			<td><input type="text" name="memAccount" value="${dto.memAccount }"></td></tr>
		<tr><td>이메일 수신 여부</td>
			<td><input type="radio" name="memEmailCk" value="Y"
				<c:if test="${dto.memEmailCk == 'Y'}">checked</c:if>>예
				<input type="radio" name="memEmailCk" value="N"
				<c:if test="${dto.memEmailCk == 'N'}">checked</c:if>>아니요</td></tr>
		<tr><td colspan="2">
			<input type="submit" value="수정" />
			<input type="button" value="수정 취소" onclick="javjascript:history.back();" />
			</td></tr>
	</table>
</form>
</body>
</html>