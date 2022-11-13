<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="javax.servlet.http.HttpSession"%>
<%
	HttpSession hs =request.getSession();
	String sessionNum = (String)hs.getAttribute("mnum");
	System.out.println("세션 회원번호 : "+sessionNum);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/kosSpring/include/css/mainstyle.css">
</head>
<body>
<!-- 상단바와 내용 -->
<div id="sitearea">
	<!-- 상단바 -->
	<header id="topbar">
		<div class="wrapper">
			<!-- 상단바 로고영역(로고, 검색) -->
			<div id="logoarea">
				<!-- 로고 -->
				<div id="toplogo">
					<a href="/kosSpring/index.jsp">
						<!-- 로고이미지 위치 확정되면 변경 -->
						<img src="/kosSpring/include/img/1__(3).png" id="sitelogo">
					</a>
				</div>
				<!-- 검색바 -->
				<div id="searchbar">
					<form>
						<!-- 드롭다운 -->
						<select>
							<option>검색_1</option>
							<option>검색_2</option>
							<option>검색_3</option>
						</select>
						<!-- 텍스트필드 -->
						<div id="searchtext">
							<input type="text">
						</div>
						<!-- 검색버튼 -->
						<input type="submit" value="검색" id="searchbtn">
					</form>
				</div>
			</div>
			<div id="btnarea">
<%
				if(sessionNum!=null&&sessionNum.length()>0){
%>
					<a href="#" class="sitebtn">로그아웃</a>
					<a href="#" class="sitebtn">마이페이지</a>
					<a href="#" class="sitebtn">글쓰기</a>
<%					
				}else{
%>
					<a href="#" class="sitebtn">로그인</a>
					<a href="memForm.k" class="sitebtn">회원가입</a>
<%
				}
%>					
			</div>
		</div>
		<!-- 메뉴 -->
		<div id="naviarea">
			<ul class="wrapper">
				<!-- 메뉴버튼들 -->
				<li>
					<a href="boardForm.k">
						<div class="nav_btn">
							게시판
						</div>
					</a>
				</li>
				<li>
					<a href="#">
						<div class="nav_btn">
							상품
						</div>
					</a>
				</li>
				<li>
					<a href="#">
						<div class="nav_btn">
							키오스크
						</div>
					</a>
				</li>
				<li>
					<a href="#">
						<div class="nav_btn">
							당근마켓
						</div>
					</a>
				</li>
			</ul>
		</div>
	</header>
	<!-- 내용 -->
	<div id="sitecontent">
		<div class="wrapper">
			<div>
				[내용]
			</div>
		</div>
	</div>
</div>

<!-- 하단바 -->
<footer id="footerarea">
	<div class="wrapper">
		<div>
			[하단바]
			<br>아이콘 제작자 :
			<a href="http://www.freepik.com/" title="Freepik">Freepik</a>
			from
			<a href="https://www.flaticon.com/kr/" title="Flaticon"> www.flaticon.com</a>
		</div>
	</div>
</footer>
</body>
</html>