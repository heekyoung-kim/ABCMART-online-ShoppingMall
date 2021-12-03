<%@page import="dao.OrderDao"%>
<%@page import="vo.Order"%>
<%@page import="java.util.List"%>
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
    <title>주문/배송현황 조회</title>
</head>
<body>
<%@ include file="/common/navbar.jsp" %>
<%
int memberNo = loginUserInfo.getNo();
	MemberDao memberDao = MemberDao.getInstance();
	OrderDao orderDao = OrderDao.getInstance();
	
	Member member = memberDao.selectMemberByNo(memberNo);
	String claimCancel = request.getParameter("claimCancel");
	if ("canceled".equals(claimCancel)) {
%>
<script type="text/javascript">
	alert("주문이 취소되었습니다.");
</script>
<%
	}
%>
<div class="container">    
	<div class="row">
		<div class="col breadcrumb">
			<ul class="nav">
				<li class="crumb home"><a href="/semi-project/main.jsp" class="nav-link p-0">HOME</a></li>
				<li class="crumb">마이페이지</li>
				<li class="crumb">쇼핑내역</li>
				<li class="crumb">주문/배송현황 조회</li>
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
				<li class=""><a href="../main.jsp" class="nav-link p-0">마이페이지</a></li>
				<li class=""><a href="" class="nav-link p-0">개인정보 수정</a></li>
				<li class=""><a href="" class="nav-link p-0">비밀번호 변경</a></li>
				<li class=""><a href="../claim/claim-order-main.jsp?memberNo=<%=member.getNo() %>" class="nav-link p-0">주문현황 조회</a></li>
				<li class=""><a href="../claim/cancel-main.jsp" class="nav-link p-0">주문 취소</a></li>
				<li class=""><a href="../info/leaveform.jsp" class="nav-link p-0">회원 탈퇴</a></li>
			</ul>
			<ul class="nav flex-column p-0">
				<li class=""><a href="../shopping-note/my-review.jsp?memberNo=<%=member.getNo() %>" class="nav-link p-0">나의 상품후기</a></li>
				<li class=""><a href="../shopping-note/my-qna.jsp?memberNo=<%=member.getNo() %>" class="nav-link p-0">상품 Q&A</a></li>
			</ul>
		</div>
		<!-- //aside 끝 -->
		<div class="offset-md-1 col-9 p-0">
			<div class="card member-box p-0">
				<div class="row g-0">
					<div class="col-2 p-0">
						<span class="icon-grade"></span>
					</div>
					<div class="col-6 p-0 middle-box">
						<p><%=member.getName() %> 님은 <strong>통합멤버십 회원</strong>입니다.</p>
						<span class="member-info">MEMBERSHIP <span class="member-number"><%=member.getNo() %></span></span> 
						<span class="member-info">멤버십 회원 가입일 <span class="member-number"><%=member.getRegisteredDate() %></span></span> 
					</div>
					<div class="col-4 p-0 right-box">
						<span class="text-center"><img src="" alt="" />포인트</span>
						<span class="point"><%=member.getPct() %><span class="unit">p</span></span>
					</div>
				</div>
			</div>
			<div class="buy-list mb-3">
				<p>취소 현황 조회</p>
<%
	List<Order> canceledOrder = orderDao.selectCanceledOrderByMemberNo(memberNo);
	if (canceledOrder.isEmpty()) {
%>
			<div class="order-list-box p-5">
				<p class="text-center order-font">취소 내역이 존재하지 않습니다.</p>
			</div>
<% 
	} else {
		for (Order order : canceledOrder) {
%>
				<div class="order-list-box mb-3">
					<div class="row mb-1">
						<div class="col mt-2">
							<span style="font-weight: bold;">주문번호</span>
							<a href="claim-order-detail.jsp?orderNo=<%=order.getNo() %>" style="color:black;"><span><%=order.getNo() %></span></a>
						</div>
						<div class="col mt-2">
							<span style="font-weight: bold;">취소일시</span>
							<span style="font-weight: bold;"><%=order.getCanceledDate() %></span>
						</div>
						<div class="col text-end mt-2">
							<span style="font-weight: bold;"><%=order.getStatus() %></span>
						</div>
						<div class="col text-end mt-2">
							<span style="font-weight: bold;">취소금액</span>
							<span style="color:red; font-weight: bold;"><%=order.getTotalPrice() %>원</span>
						</div>
					</div>
				</div>
<%
		}
	}
%>
			</div>
		</div>
	</div>
</div>
<%@ include file="/common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>