<%@page import="vo.Pagination2"%>
<%@page import="vo.Criteria2"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.apache.commons.lang3.math.NumberUtils"%>
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
   <style>
 #member-container .style{padding:2px 0 !important; text-align:center;}
 #member-container th.style{padding:6px 0 !important;}
 #member-container .select-box{margin-left:auto; width:120px;}
 #member-container .select-box select{padding:0 10px;}
   
   </style>
    <title></title>
</head>
<body>
<%@ include file="admin-common.jsp" %>

<% 

MemberDao memberDao = MemberDao.getInstance();
int pageNo = NumberUtils.toInt(request.getParameter("page"), 1);
String option = StringUtils.defaultString(request.getParameter("option"), "");
String keyword = StringUtils.defaultString(request.getParameter("keyword"), "");

Criteria2 criteria = new Criteria2();

// 검색옵션과 검색키워드가 모두 있는 경우에만 Criteria객체에 검색옵션과 검색 키워드를 저장한다.
if (!StringUtils.isEmpty(option) && !StringUtils.isEmpty(keyword)) {
	criteria.setOption(option);
	criteria.setKeyword(keyword);
}

int totalRows = memberDao.selectTotalLeftMembersCountByCriteria(criteria);
// 페이징처리에 필요한 정보를 제공하는 Pagination객체를 생성한다.
Pagination2 pagination = new Pagination2(pageNo, totalRows);

// 게시글 리스틀 조회할 때 필요한 조회범위를 Criteria객체에 저장한다.
criteria.setBeginIndex(pagination.getBeginIndex());
criteria.setEndIndex(pagination.getEndIndex());


List<Member> memberList = memberDao.selectAllLeftMembers(criteria);


%>
<div class="container" id="member-container">    
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
				<li class=""><a href="review-list.jsp" class="nav-link p-0">리뷰 목록</a></li>
				</ul>
		</div>	
		<div class="col-9">
		<div class="row mb-3">
			<div class="col">
			<div><h4>탈퇴 회원 목록</h4></div>
			<div>
			<form id="form-search" class="row" method="get" action="member-list.jsp">
					<input type="hidden" id="page-field" name="page" value="<%=pageNo%>">
					<div class="col-4" style="height: 31px; line-height: 31px;">
						총 <strong><%=totalRows %></strong> 명의 탈퇴한 회원이 있습니다.
					</div>			
					<div class="col-4">
						<div class="input-group select-box">
							<select class="form-select" id="search-option" name="option"
								style="height: 31px; font-size: 14px;">
								<option value="id" <%="id".equals(option) ? "selected" : ""%>>아이디</option>
								<option value="name" <%="name".equals(option) ? "selected" : ""%>>이름</option>
								<option value="tel" <%="tel".equals(option) ? "selected" : ""%>>전화번호</option>
								<option value="email" <%="email".equals(option) ? "selected" : ""%>>이메일</option>
							</select>
						</div>
					</div>
					<div class="col-3">
						<div class="input-group">
							<input type="text" class="form-control" id="search-keyword" name="keyword" value="<%=StringUtils.isBlank(keyword) ? "" : keyword%>"	placeholder="검색어를 입력하세요"
							style="height: 31px; font-size: 14px;">
						</div>
					</div>
					<div class="col-1">
						<div class="input-group justify-content-end">
							<button class="btn btn-sm btn-outline-dark" type="button" id="btn-search" onclick="searchBoards(1)">검색</button>
						</div>
					</div>
				</form>
			</div>
			</div>
			</div>
		
				<table class="table table-hover table-striped">
		<colgroup>
			<col width="5%">
			<col width="7%">
			<col width="10%">
			<col width="10%">
			<col width="10%">
			<col width="5%">
			<col width="10%">
		</colgroup>
		<thead>
			<tr>
				<th class="style">번호</th>
				<th class="style">ID</th>
				<th class="style">이름</th>
				<th class="style">연락처</th>
				<th class="style">이메일</th>
				<th class="style">포인트</th>
				<th class="style">가입일</th>
			</tr>
		</thead>
		<tbody>
			<% 
	for (Member member : memberList) {
%>	
			<tr>
				<td class="style"><%=member.getNo() %></td>		
				<td class="style"><%=member.getId() %></td>		
				<td class="style"><a href="member-detail.jsp?no=<%=member.getNo()%>"><%=member.getName() %></td>
				<td class="style"><%=member.getTel() %></td>
				<td class="style"><%=member.getEmail() %></td>
				<td class="style"><%=member.getPct() %></td>
				<td class="style"><%=member.getRegisteredDate() %></td>
			</tr>
<% 
	}
%>			
		</tbody>
		</table>
		
		<div class="row mt-3 mb-3">
		<div class="col-6 offset-3">
			<nav>
				<ul class="pagination justify-content-center">
					<!-- 
						Pagination객체가 제공하는 isExistPrev()는 이전 블록이 존재하는 경우 true를 반환한다.
						Pagination객체가 제공하는 getPrevPage()는 이전 블록의 마지막 페이지값을 반환한다.
					 -->
					<li class="page-item <%=!pagination.isExistPrev() ? "disabled" : "" %>">
					<a href="" class="page-link" onclick="moveToPage(event, <%=pagination.getPrev()%>)" >이전</a>
					</li>
<%
	// Pagination 객체로부터 해당 페이지 블록의 시작 페이지번호와 끝 페이지번호만큼 페이지내비게이션 정보를 표시한다.
	for (int num = pagination.getBegin(); num <= pagination.getEnd(); num++) {
%>					
						<li class="page-item <%=num == pagination.getPage() ? "active" : ""%>">
						<a href="" class="page-link" onclick="moveToPage(event, <%=num%>)"><%=num%></a>
					</li>
<%
	}
%>					
					<!-- 
						Pagination객체가 제공하는 isExistNext()는 다음 블록이 존재하는 경우 true를 반환한다.
						Pagination객체가 제공하는 getNexPage()는 다음 블록의 첫 페이지값을 반환한다.
					 -->
					<li class="page-item <%=!pagination.isExistNext() ? "disabled" : "" %>">
					<a href="" class="page-link" onclick="moveToPage(event, <%=pagination.getNext()%>)">다음</a></li>
				</ul>
			</nav>
		</div>
	</div>
		</div>	
	</div>
</div>

<%@ include file="../common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">

//페이지번호를 클릭했을 때 실행되는 함수
function moveToPage(event, page) {
	event.preventDefault();	// a태그에서 onclick이벤트가 발생하면 href에 정의된 주소로 이동하는 기본동작이 일어나지 않게 함.
	searchBoards(page);
}

//검색버튼을 클릭했을 때 실행되는 함수
function searchBoards(page) {
	document.getElementById("page-field").value = page;
	var form = document.getElementById("form-search");
	form.submit();
}  </script>

</body>
</html>