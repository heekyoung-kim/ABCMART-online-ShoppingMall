
<%@page import="dto.OrderDetailDto"%>
<%@page import="java.util.List"%>
<%@page import="vo.Order"%>
<%@page import="dao.OrderDao"%>
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
<div class="container">    
<%

	int orderNo = Integer.parseInt(request.getParameter("orderNo"));

	int memberNo = loginUserInfo.getNo();
	MemberDao memberDao = MemberDao.getInstance();
	Member member = memberDao.selectMemberByNo(memberNo);
	
	OrderDao orderDao = OrderDao.getInstance();
	Order order = orderDao.selectOrderDetailByOrderNo(orderNo);
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
				<li class=""><a href="../main.jsp" class="nav-link p-0">마이페이지</a></li>
				<li class=""><a href="" class="nav-link p-0">개인정보 수정</a></li>
				<li class=""><a href="" class="nav-link p-0">비밀번호 변경</a></li>
				<li class=""><a href="../mypage/claim/claim-order-main.jsp?memberNo=<%=member.getNo() %>" class="nav-link p-0">주문현황 조회</a></li>
				<li class=""><a href="" class="nav-link p-0">주문 취소</a></li>
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
			<div class="order-list">
				<p>주문/배송 상세</p>
				<div class="row border p-3">
					<div class="col mt-1">
						<span>주문번호</span>
						<span><%=order.getNo() %></span>
					</div>
					<div class="col mt-1">
						<span><%=order.getStatus() %></span>
					</div>
					<div class="col text-end mt-1">
						<button type="button" class=" btn-dark btn-sm">전체주문취소</button>
					</div>
				</div>
			</div>
			<div class="order-list">
				<p>주문정보</p>
				<div class="order-list-box">
					<div class="row">
						<div class="col-2 mt-2">
							<span style="margin-left:5px;">ABC_MART 상품</span>
						</div>
						<div class="col text-end mt-2">
							<span style="margin-right:5px;">무료배송</span>
						</div>
					</div>
					<hr>
<%
	List<OrderDetailDto> orderDetails = orderDao.selectOrderDetailsByOrderNo(orderNo);
	for (OrderDetailDto orderDetail : orderDetails) {
%>
					<div class="row p-2">
						<div class="col-6">
							<img class="order-img me-2" src="../../resources/images/products/<%=orderDetail.getPhoto()%>">
							<div>
								<div>
									<span><%=orderDetail.getBrand() %></span>
								</div>
								<div>
									<span><%=orderDetail.getProductName() %></span>
								</div>
								<div>
									<span><%=orderDetail.getSize() %> / <%=orderDetail.getAmount() %>개</span>
								</div>
							</div>
						</div>
<%
	if (orderDetail.getDisPrice() > 0) {
%>						<div class="col mt-3">
							<div class="text-center">
								<span  style="text-decoration:line-through;"><%=orderDetail.getPrice() %>원</span>
							</div>
							<div class="text-center">
								<span style="color: red; font-weight: bold; font-size: 17px;"><%=orderDetail.getDisPrice() %>원</span>
							</div>
						</div>
<%
	} else {
%>
						<div class="col mt-4 text-end">
							<span><%=orderDetail.getPrice() %>원</span>
						</div>
<%		
	}
%>
						<div class="col mt-4 text-end">
							<span style="font-weight: bold;"><%=order.getStatus() %></span>
						</div>
						<!-- 
							리뷰 작성 상태가 Y면 버튼 상태 disabled로 만들기 
							N이면 reviewform으로 이동
						-->
						<div class="col mt-3 text-end mt-1">
							<button type="button" class="btn btn-dark btn-sm">리뷰 작성</button>
						</div>
					</div>
<%
	}
%>
					
				</div>
				<div class="order-list">
				<p>주문자 정보</p>
					<div class="order-list-box p-3">
						<div class="row mb-3 mt-3 order-font">
							<div class="col-2">
								<span style="font-weight: bold;">이름</span>
							</div>
							<div class="col">
								<span><%=member.getName() %></span>
							</div>
						</div>
						<div class="row mb-3 order-font">
							<div class="col-2">
								<span style="font-weight: bold;">휴대폰 번호</span>
							</div>
							<div class="col">
								<span><%=member.getTel() %></span>
							</div>
						</div>
						<div class="row mb-3 order-font">
							<div class="col-2">
								<span style="font-weight: bold;">이메일 주소</span>
							</div>
							<div class="col">
								<span><%=member.getEmail() %></span>
							</div>
						</div>
						<div class="row mb-3 order-font">
							<div class="col-2">
								<span style="font-weight: bold;">배송 주소</span>
							</div>
							<div class="col">
								<span><%=member.getAddress() %></span>
							</div>
						</div>
					</div>
				</div>
				<div class="order-list">
					<p>결제 정보</p>
					<div class="order-list-box p-3">
						<div class="row">
							<div class="col-2">
								<span style="margin-left:5px;">총 결제금액</span>
							</div>
							<div class="col text-end">
								<span style="margin-right:5px; color:red; font-weight: bold;"><%=order.getTotalPrice() %>원</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="/common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>