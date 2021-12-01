<%@page import="vo.Member"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <link rel="stylesheet" href="/semi-project/resources/css/style.css" />
    <title>회원 탈퇴</title>
</head>
<body>
<%@ include file="/common/navbar.jsp" %>
<div class="container">    
<%
	MemberDao memberDao = MemberDao.getInstance();
	Member member = memberDao.selectMemberByNo(loginUserInfo.getNo());
%>
	<div class="row">
		<div class="col breadcrumb">
			<ul class="nav">
				<li class="crumb home"><a href="" class="nav-link p-0">HOME</a></li>
				<li class="crumb">마이페이지</li>
				<li class="crumb">마이페이지</li>
				<li class="crumb">마이페이지</li>
			</ul>
		</div>
	</div>
	<div class="row">
		<div class="col p-0 page-title">
			<h1>마이페이지</h1>
		</div>
	</div>
	<div class="row mypage">
		<!-- aside 시작 -->
		<div class="col-2 p-0 aside">
			<span class="aside-title">마이 페이지</span>
			<ul class="nav flex-column p-0">
				<li class=""><a href="../claim/claim-order-main.jsp?memberNo=<%=member.getNo() %>" class="nav-link p-0">마이페이지</a></li>
				<li class=""><a href="" class="nav-link p-0">개인정보 수정</a></li>
				<li class=""><a href="" class="nav-link p-0">비밀번호 변경</a></li>
				<li class=""><a href="../claim/claim-order-main.jsp?memberNo=<%=member.getNo() %>" class="nav-link p-0">주문현황 조회</a></li>
				<li class=""><a href="" class="nav-link p-0">주문 취소</a></li>
				<li class=""><a href="" class="nav-link p-0">회원 탈퇴</a></li>
			</ul>
			<ul class="nav flex-column p-0">
				<li class=""><a href="../shopping-note/my-review.jsp?memberNo=<%=member.getNo() %>" class="nav-link p-0">나의 상품후기</a></li>
				<li class=""><a href="../shopping-note/my-qna.jsp?memberNo=<%=member.getNo() %>" class="nav-link p-0">상품 Q&A</a></li>
			</ul>
		</div>
		<!-- //aside 끝 -->
		<div class="offset-md-1 col-9 p-0">
			<div class="row">
				<div class="col">
					<p class="text-head2">비밀번호 변경</p>
					<form method="get" action="change-pwdform.jsp">
						<div class="register-box">
							<div class="pwd-box">
								<label class="form-label" for="user-password">비밀번호<span>*</span></label>
								<input class="form-control" type="password" name="pwd" id="user-pwd" placeholder="비밀번호를 입력해주세요." />
							</div>
							<div class="pwd-box">
								<label class="form-label" for="pwd-confirm">비밀번호 확인<span>*</span></label>
								<input class="form-control" type="password" name="pwd-confirm" id="pwd-confirm" placeholder="비밀번호를 다시 입력해주세요." />
							</div>
<%
	String error = request.getParameter("error");
	if ("empty-pwd".equals(error)) {
%>
	<script type="text/javascript">
		alert("비밀번호를 입력해주세요.");
	</script>
<%
	} else if ("empty-pwdconfirm".equals(error)) {
%>
	<script type="text/javascript">
		alert("동일한 비밀번호를 다시한번 입력해주세요.");
	</script>
<%
	} else if ("notmatch-pwd".equals(error)) {
%>
	<script type="text/javascript">
		alert("동일한 비밀번호를 다시한번 입력해주세요.");
	</script>
<%
	}
%>
						</div>
						<div class="btn-box text-center">
							<button type="submit" class="btn btn-lg btn-dark">확인</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="/common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>