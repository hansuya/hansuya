<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%@ page import="org.apache.log4j.LogManager" %>  
<%@ page import="org.apache.log4j.Logger" %>   

<%@page import="a.b.c.com.kos.mem.vo.KosMemberVO"%>  
<%@page import="a.b.c.com.common.EncryptAES"%>   
<%@page import="a.b.c.com.common.CodeUtil"%>

<%@page import="java.util.ArrayList"%>


<% request.setCharacterEncoding("UTF-8");%> 
<%
	Logger logger = LogManager.getLogger(this.getClass());
	logger.info("memSelectAll.jsp >>> : ");
%>

<%
	Object obj = request.getAttribute("listAll");
	if (obj == null) return;
	
	// 검색 조회후 설정된 값 유지용 데이터
	KosMemberVO search_kvo = (KosMemberVO)request.getAttribute("search_kvo");
	String startDate = search_kvo.getStartDate();
	String endDate = search_kvo.getEndDate();	
	String searchFilter = search_kvo.getSearchFilter();
	String keyword = search_kvo.getKeyword();
	
	ArrayList<KosMemberVO> aList = (ArrayList<KosMemberVO>)obj;
	int nCnt = aList.size();
	System.out.println("조회건수 nCnt >>> : " + nCnt);
	
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
	alert("자바스크립트 블럭 진입 >>> : ");

	$(document).ready(function(){	
		alert("jQuery ready() 함수 블럭 진입 >>> : ");
		
		// mnum
		$(document).on("click", "#mnum", function(){
					
			if($(this).prop('checked')){			 
				//$('input[type="checkbox"][name="mnum"]').prop('checked',false);
				$('.mnum').prop('checked',false);
				$(this).prop('checked',true);
			}
		});
			
		// 검색버튼 ================================================================
		$(document).on("click", "#searchBtn", function(){
			alert("searchBtn >>> : ");			
			$("#memFormAll").attr({ "method":"GET"
				                  ,"action":"memSelectAll.k"}).submit();
		});
		
		var searchFilter = "<%=searchFilter%>";
		var keyword = "<%=keyword%>";
		
		if(searchFilter==null || searchFilter=="null" || searchFilter==""){
			$("#searchFilter").val("key1");
		}else{
			$("#searchFilter").val(searchFilter);
		}
		if(keyword==null || keyword=="null" || keyword==""){
			$("#keyword").val("");
		}else{
			$("#keyword").val(keyword);
		}
		
		var startDate = "<%=startDate%>";
		var endDate = "<%=endDate%>";
		
		if(startDate==null || startDate=="null" || startDate==""){
			$("#startDate").val("");
		}else{
			$("#startDate").val(startDate);
		}
		if(endDate==null || endDate=="null" || endDate==""){
			$("#endDate").val("");
		}else{
			$("#endDate").val(endDate);
		}
		
		// datepicker : from ~ to 기간조회
		$("#startDate").datepicker({		
			showOn: "button",    // 달력을 표시할 타이밍 (both: focus or button)
			buttonImage: "/kosSpring/common/img/cal_0.gif", 
			buttonImageOnly : true,            
			buttonText: "날짜선택",             
			dateFormat: "yy-mm-dd",             
			changeMonth: true,                  			
			onClose: function(selectedDate) {    
				$("#enddate").datepicker("option", "minDate", selectedDate);
			}                
		});		
		$("#endDate").datepicker({
			showOn: "button", 
			buttonImage: "/kosSpring/common/img/cal_0.gif", 
			buttonImageOnly : true,
			buttonText: "날짜선택",
			dateFormat: "yy-mm-dd",
			changeMonth: true,			
			onClose: function(selectedDate) {	
				$("#startdate").datepicker("option", "minDate", selectedDate);
			}               
		});				
		// 검색버튼 ================================================================
			
		//  I
		$(document).on("click", "#I", function(){
			//alert("I >>> : ");
			location.href="memForm.k";
		});
		
		// SALL
		$(document).on("click", "#SALL", function(){			
			location.href="memSelectAll.k";		
		});
		
		//  U
		$(document).on("click", "#U", function(){
				
			if ($('.mnum:checked').length == 0){
				alert("수정할 글번호 하나를 선택하세요!!");
				return;
			}
			 $("#memFormAll").attr({ "method":"POST"
				                    ,"action":"memSelect.k"}).submit();
		});
		
		//  D
		$(document).on("click", "#D", function(){
			
			if ($('.mnum:checked').length == 0){
				alert("삭제할 글번호 하나를 선택하세요!!");
				return;
			}
			$("#memFormAll").attr({ "method":"GET"
				                   ,"action":"memDelete.k"}).submit();
		}); 
	});
</script>

<style type="text/css">

	div {		 
		margin: 0 auto; 		
		border:1px solid #6d82f3;
		display:table;
	}			

	td, th {
		 padding: 5px;
	}

	h3 {
		text-align: center;
	}	
	
	table, th, td {
  		border: 1px solid black;
  		text-align: center;
	}
	
	
</style>

</head>
<body>
<h3>MEMBER SELECT ALL</h3>
<hr>
<div>
<form name="memFormAll" id="memFormAll">
<table>
<thead>
<tr>
	<td colspan="10" align="center">
		<h3>회원정보</h3>
		<%= "조회건수 ::: " + nCnt %>
	</td>
</tr>
<!-- 검색 루틴 ================================================================== -->
<tr>
	<td colspan="10" style="text-align:left;">
	<select id="searchFilter" name="searchFilter">
		<option value="key1" selected>전체--------------</option>
		<option value="key2">회원번호</option>
		<option value="key3">이름</option>
		<option value="key4">아이디</option>	
	</select>
	<label for="keyword">검색어</label>
	<input type="text" id="keyword" name="keyword" size="15" placeholder="검색어 입력"><br>
	<input type="text" id="startDate" name="startDate" size="12" placeholder="시작일 "> ~ 
	<input type="text" id="endDate" name="endDate" size="12" placeholder="종료일">
	&nbsp;&nbsp;
	<button type="button" id="searchBtn">검색</button>
	<button type="reset" id="resetsBtn">다시</button>
</td>
<!-- 검색 루틴 ================================================================== -->
<tr>
	<th><input type="checkbox" name="chkAll" id="chkAll"></th>
	<th>회원번호</th>
	<th>이름</th>
	<th>아이디</th>
	<th>성별</th>
	<th>이메일</th>
	<th>우편번호</th>
	<th>주소(도로명)</th>
	<th>수정일</th>
	<th>사진</th>
</tr>
</thead>
<%
	for(int i=0; i<nCnt; i++){
		
		KosMemberVO kvo = (KosMemberVO)aList.get(i);
%>					
<tbody>
<tr>
	<td>
		<input type="checkbox" class="mnum" name="mnum" id="mnum" value=<%= kvo.getMnum() %>>
	</td>		
	<td><%= kvo.getMnum() %> </td>
	<td><%= kvo.getMname() %> </td>
	<td><%= kvo.getMid() %> </td>
	<td><%= CodeUtil.gender(kvo.getMgender()) %> </td>
	<td><%= kvo.getMemail() %> </td>	
	<td><%= kvo.getMzonecode() %> </td>	
	<td style="text-align:left;"><%= kvo.getMroadaddr().concat(kvo.getMroaddetail()) %> </td>	
	<td><%= kvo.getUpdatedate() %> </td>	
	<td><img src="/kosSpring/fileupload/mem/<%= kvo.getMphoto() %>" border="1" width="50" height="50" alt="image"></td>		
</tr>	
<%
	}//end of if
%>						
<tr>
	<td colspan="10" style="text-align:right;">				
		<input type="button" value="글쓰기" id="I">
		<input type="button" value="글목록" id="SALL">
		<input type="button" value="글수정" id="U">
		<input type="button" value="글삭제" id="D">									
	</td>
</tr>	
</tbody>			
</table>
</form>	
</div>		
</body>
</html>