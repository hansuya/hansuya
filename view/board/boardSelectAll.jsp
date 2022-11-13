<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="a.b.c.com.kos.board.vo.KosBoardVO" %> 
<%@ page import="a.b.c.com.common.CodeUtil" %> 
<%@ page import="java.util.List" %> 

<%@ page import=" org.apache.log4j.LogManager" %>
<%@ page import="org.apache.log4j.Logger" %>

<% request.setCharacterEncoding("UTF-8");%> 
<%	
	Logger logger = LogManager.getLogger(this.getClass());
	logger.info("kosBoardSelectAll.jsp 페이지 >>> : ");
	
	//페이징 변수 세팅
	int pageSize = 0;
	int groupSize = 0;
	int curPage = 0;
	int totalCount = 0;

	Object objPaging = request.getAttribute("pagingKBVO");
	KosBoardVO pagingKBVO = (KosBoardVO)objPaging;
	
	Object obj = request.getAttribute("listAll");
	List<KosBoardVO> list = (List<KosBoardVO>)obj;
	
	int nCnt = list.size();
	String nCntS = ":::: 전체 조회 건수  " + nCnt + " 건";	
%>     

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
  
<script type="text/javascript" src="/kosmoSpring/js/common.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<script type="text/javascript">
	alert("자바스크립트 블럭 진입 >>> : ");
	
	$(document).ready(function(){
		alert("jQuery ready() 함수 블럭 진입 >>> : ");
		
		// bnum 체크박스 체크 확인하기
		$(document).on("click", "#bnum", function(){				
			
			if($(this).prop('checked')){			 			
				$('.bnum').prop('checked',false);
				$(this).prop('checked',true);
			}
		});
		
		//  I
		$(document).on("click", "#insertBtn", function(){
			location.href="boardForm.k";
		});
		
		// SALL
		$(document).on("click", "#selectAllBtn", function(){		
			$("#boardList").attr({"method":"GET", "action":"boardSelectAll.k"}).submit();		
		});
				
		//  S
		$(document).on("click", "#selectBtn", function(){	
			if ($('.bnum:checked').length == 0){
				alert("글번호 하나를 선택하세요!!");
				return;
			}
			$("#boardList").attr({ "method":"GET","action":"boardSelect.k"}).submit();
		});		
		
		//  글 내용보기 
		$(document).on("click", "#contentsBtn", function(){	
			if ($('.bnum:checked').length == 0){
				alert("글번호 하나를 선택하세요!!");
				return;
			}
			$("#boardList").attr({ "method":"GET","action":"boardSelectContents.k"}).submit();
		});		
			
		
		//  D
		$(document).on("click", "#deletetBtn", function(){	
			if ($('.bnum:checked').length == 0){
				alert("삭제할 글번호 하나를 선택하세요!!");
				return;
			}
			$("#boardList").attr({ "method":"GET","action":"boardSelect.k"}).submit();
		});		
	});	

</script>
<style type="text/css">
	/*
	div {		 
		margin: 0 auto; 		
		border:1px solid #6d82f3;
		display:table;
	}			
	*/
	td, th {
		 /*padding: 5px;*/
		 text-align: center;
	}

	h3 {
		text-align: center;
	}	
	/*
	table, th, td {
  		border: 1px solid black;
  		text-align: center;
	}
	*/
	
</style>
</head>
<body>
<h3>게시판 글 목록</h3>
<hr>
<div class="container">
<form name="boardList" id="boardList">
<table class="table table-bordered table-sm">
<thead>
<tr>
	<td colspan="7" style="text-align:center">
		<h3>게시판</h3>
		<%= nCntS %>
	</td>
</tr>
<tr>
	<th><input type="checkbox" name="chkAll" id="chkAll"></th>	
	<th>글번호</th>	
	<th>글제목</th>
	<th>이름</th>	
	<th>사진</th>
	<th>날짜</th>
	<th>조회수</th>
</tr>
</thead>
<%

for(int i=0; i<nCnt; i++){		
	KosBoardVO _kbvo = list.get(i);	
	
	// 페이징 세팅
	pageSize = Integer.parseInt(pagingKBVO.getPageSize());
	groupSize = Integer.parseInt(pagingKBVO.getGroupSize());
	curPage = Integer.parseInt(pagingKBVO.getCurPage());
	totalCount = Integer.parseInt(_kbvo.getTotalCount());
%>
<tbody>
<tr>
	<td style="width:5%">
		<input type="checkbox" id="bnum" name="bnum" class="bnum" value=<%= _kbvo.getBnum() %> >
	</td>			
	<td style="width:10%"><%= _kbvo.getBnum() %> </td>
	<td style="text-align:left;"><%= _kbvo.getBsubject() %> </td>
	<td style="width:10%"><%= _kbvo.getBname() %> </td>	
	<td style="width:10%"><img src="/kosSpring/fileupload/board/<%= _kbvo.getBfile() %> " border="1" width="25" height="25" alt="image"></td>
	<td style="width:10%"><%= _kbvo.getUpdatedate() %></td>
	<td style="width:8%"><%= _kbvo.getBhit() %></td>				
</tr>	
<%
}//end of for
%>	
<tr>
	<td colspan="7">
		<jsp:include page="boardPaging.jsp" flush="true">
			<jsp:param name="url" value="boardSelectAll.k"/>
			<jsp:param name="str" value=""/>
			<jsp:param name="pageSize" value="<%=pageSize%>"/>
			<jsp:param name="groupSize" value="<%=groupSize%>"/>
			<jsp:param name="curPage" value="<%=curPage%>"/>
			<jsp:param name="totalCount" value="<%=totalCount%>"/>
		</jsp:include>
	</td>
</tr>				
<tr>
	<td colspan="7" style="text-align:right;">				
		<button type="button" class="btn btn-danger" id="insertBtn">글쓰기</button>
		<button type="button" class="btn btn-primary" id="selectAllBtn">글목록</button>
		<button type="button" class="btn btn-success btn-sm" id="contentsBtn">글내용보기</button>		
		<button type="button" class="btn btn-warning btn-sm" id="selectBtn">글수정</button>		
		<button type="button" class="btn btn-dark" id="deletetBtn">글삭제</button> 									
	</td>
</tr>	
</tbody>	
</table>
</form>	
</div>
</body>
</html>