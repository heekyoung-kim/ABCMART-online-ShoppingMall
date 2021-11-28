<%@page import="java.util.List"%>
<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@page import="vo.Pagination"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
 	 <link rel="stylesheet" href="resources/css/style.css" />
    <title></title>
</head>
<style>
.title {font-family:'Montserrat', Noto Sans KR; font-weight:500; color:black; font-size:50px; text-align:center; }
a{text-decoration:none; color:black;}


</style>
<body>
<%@ include file = "common/navbar.jsp" %>
<div class="container">
<%
//요청파라미터에서 pageNo값을 조회한다.
	// 요청파라미터에 pageNo값이 존재하지 않으면 Pagination객체에서 1페이지로 설정한다.
//	String pageNo = request.getParameter("pageNo");

	// 제품 정보 관련 기능을 제공하는 ProductDao객체를 획득한다.
	ProductDao productDao = ProductDao.getInstance();


	List<Product> productList = productDao.selectProductsOnSale(1, 60);


	
	
	// 페이징 처리 필요한 값을 계산하는 Paginatition객체를 생성한다.
//	Pagination pagination = new Pagination(pageNo, totalRecords);
	
	// 현재 페이지번호에 해당하는 게시글 목록을 조회한다.
//	List<Board> boardList = boardDao.getBoardList(pagination.getBegin(), pagination.getEnd());
%>
    

    <div class="title mt-5 mb-5 p-5 ">
    	SALE EVENT
    </div>
   	<nav class="navbar navbar-expand-lg navbar-ligth ">
	<div class="container">
		<div class="collapse navbar-collapse " id="navbar-1">
			<ul class="navbar-nav" >
				<li class="nav-item" >
					<select class=" border-0 text-center mx-3" onchange="searchProducts()">
						<option value="">브랜드 전체</option>
						<option>아디다스</option>
						<option>퓨마</option>
						<option>휠라</option>
					</select>
				</li>	
				<li class="nav-item " >
					<select class="border-0 text-center" onchange="searchProducts()">
						<option>남녀공용</option>
						<option>남자</option>
						<option>여자</option>
					</select>
				</li>	
				<li class="nav-item " >
					<select class="border-0  text-center" onchange="searchProducts()">
						<option>신상품순</option>
						<option>낮은가격순</option>
						<option>높은가격순</option>
						<option>베스트상품순</option>
					</select>
				</li>
			</ul>
		</div>
	</div>
</nav>
<hr>
<div class="row row-cols-4 g-3 mb-5 mx-auto">
<%
 for(Product product : productList) {
%>
	<div class="col-3">
    	<div class="card h-100 border-white rounded-0">
	 		<a href="detail.jsp?no=<%=product.getNo() %>">
      			<img src="resources/images/products/<%=product.getPhoto() %>" class="card-img-top" alt="...">
      <div class="card-body">
        <h6 class="card-title"><strong><%=product.getBrand() %></strong></h6>
        <p class="card-text"><%=product.getName() %></p>
<%
	if (product.getDisPrice() > 0) {
%>
      	  <div class="d-flex justify-content-between">
	        <span class="col card-text p-1 p"><%=product.getPrice() %> 원</span>
	        <span class="col card-text  p-1 dp"><%=product.getDisPrice() %> 원</span>
      	  </div>
<%
	} else {
%>
	<div class="text-end">
	        	<span class="col card-text  p-1 dp"><%=product.getPrice() %> 원</span>
      	  </div>
<%
	}
%>
      </div>
	 </a>
    </div>
  </div>
<%
 }
%>
</div>
</div>
<%@ include file ="common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>