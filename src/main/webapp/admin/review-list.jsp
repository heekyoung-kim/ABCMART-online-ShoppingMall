<%@page import="dto.ReviewDetailDto"%>
<%@page import="dao.ReviewDao"%>
<%@page import="dto.QnADetailDto"%>
<%@page import="dao.QnaDao"%>
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
   <link rel="stylesheet" href="../resources/css/style.css" />
    <title></title>
<style>
#complete {color: white;  padding: 4px 8px;  border:none; background-color : rgb(57, 209, 146); }
#answer {color: white;  padding: 4px 8px; border:none; background-color : rgb(126, 181, 245); }

</style>

</head>
<body>
<%@ include file="admin-common.jsp" %>

<% 
QnaDao qnaDao = QnaDao.getInstance();

List<QnADetailDto> qnaDetailList = qnaDao.selectAllQnADetail(1, 20);


%>
<div class="container">    
	<div class="row">
		<div class="col breadcrumb">
			<ul class="nav">
				<li class="crumb home"><a href="" class="nav-link p-0">HOME</a></li>
				<li class="crumb">관리자페이지</li>
				<li class="crumb">관리자페이지</li>
			</ul>
		</div>
	</div>
	<div class="row">
		<div class="col p-0 page-title">
			<h1>관리자페이지</h1>
		</div>
	</div>
	<div class="row mypage">
		<!-- aside 시작 -->
		<div class="col-2 p-0 aside">
			<span class="aside-title">관리자 페이지</span>
			<ul class="nav flex-column p-0">
			<li class=""><a href="member-list.jsp" class="nav-link p-0">회원목록 조회</a></li>
				<li class=""><a href="member-left-list.jsp" class="nav-link p-0">탈퇴회원 목록 조회</a></li>
				<li class=""><a href="product-list.jsp" class="nav-link p-0">전체 상품 조회</a></li>
				<li class=""><a href="registerform.jsp" class="nav-link p-0">신규 상품 등록</a></li>
				<li class=""><a href="stock-management.jsp" class="nav-link p-0">재고 관리</a></li>
				<li class=""><a href="order-list.jsp" class="nav-link p-0">주문 관리</a></li>
				<li class=""><a href="qna-list.jsp" class="nav-link p-0">QnA 목록</a></li>
				<li class=""><a href="review-list.jsp" class="nav-link p-0">리뷰 목록</a></li>	</ul>
		</div>	
		<div class="col-9">
			<h4>REVIEW 목록</h4>
			<div class="qna-list">
				<div class="order-list-box">
					<div class="row">
<%
	ReviewDao reviewDao = ReviewDao.getInstance();
	List<ReviewDetailDto> reviewDetails = reviewDao.getReviewList(1, 3);
	if (reviewDetails.isEmpty()) {
%>
						<div class="p-5">
							<p class="text-center order-font">작성된 상품 후기가 없습니다.</p>
						</div>
<%
	} else {
		
%>
						<div class="col mt-2">
							<span style="margin-left:5px;">총 <%=reviewDetails.size() %>건의 상품 후기가 있습니다.</span>
						</div>
					</div>
					<hr>
	<% 
			for (ReviewDetailDto detail : reviewDetails) {
	%>
					<div class="row">
			            <div>
			                <div class="accordion accordion-flush" id="faqlist">
			                    <div class="accordion-item">
			                   	    <div class="row p-2">
										<div class="col-3">
											<img class="order-img me-2" src="/semi-project/resources/images/products/<%=detail.getPhoto()%>">
											<div>
												<div>
													<span><strong>상품명</strong></span>
												</div>
												<div>
													<span><%=detail.getProductName() %></span>
												</div>
											</div>
										</div>
										<div class="col mt-4 text-end">
											<span><%=detail.getId() %></span>
										</div>
										<div class="col mt-4 text-end">
											<span style="font-weight: bold;"><%=detail.getReviewDate() %></span>
										</div>
										<div class="col mt-3 text-end">
										<h2 class="accordion-header" id="faq-heading-<%=detail.getReviewNo()%>">
				                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq-content-<%=detail.getReviewNo()%>">
				                            </button>
			                        	</h2>
										</div>
									</div>
			                        <div id="faq-content-<%=detail.getReviewNo()%>" class="accordion-collapse collapse" data-bs-parent="#faqlist">
			                            <div class="accordion-body">
			                                <strong>review : </strong><%=detail.getContent() %>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			            </div>
		        	</div>
		        	<hr>
				
<%
		}
	}
%>
				
			</div>
		</div>
	</div>	
</div>
<%@ include file="../common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>