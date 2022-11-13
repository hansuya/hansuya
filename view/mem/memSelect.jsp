<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="org.apache.log4j.LogManager" %>  
<%@ page import="org.apache.log4j.Logger" %>    
    
<%@ page import="a.b.c.com.kos.mem.vo.KosMemberVO" %> 
<%@ page import="a.b.c.com.common.CodeUtil" %> 
<%@page import="a.b.c.com.common.EncryptAES"%>   
<%@ page import="java.util.List" %>

<% request.setCharacterEncoding("UTF-8");%> 
<%
	Logger logger = LogManager.getLogger(this.getClass());
	logger.info("memSelect.jsp >>> : ");
%>
<%	
	Object obj = request.getAttribute("listS");
	if (obj == null) return;

	List<KosMemberVO> list = (List<KosMemberVO>)obj;	
	int nCnt = list.size();
	
	String mpw = "";
	String mbirth = "";
	String mbirth0 = "";
	String mbirth1 = "";
	String mbirth2 = "";
	String mhp = "";
	String mhp0 = "";
	String mhp1 = "";
	String mhp2 = "";
	String mtel = "";
	String mtel0 = "";
	String mtel1 = "";
	String mtel2 = "";
	String memail = "";	
	String memails[] = null;
	String mhobby = "";
	
	KosMemberVO _kvo = null;	
	_kvo = list.get(0);

	// 패스워드 
	EncryptAES ase = EncryptAES.getInstance();
	mpw = ase.aesDecode(_kvo.getMpw());
	logger.info("mpw >>> : " + mpw);	
	
	// 생년월일 
	mbirth = CodeUtil.birth(_kvo.getMbirth());
	String birth[] = mbirth.split("-");
	mbirth0 = birth[0];
	mbirth1 = birth[1];
	mbirth2 = birth[2];
	
	// 핸드폰
	mhp = CodeUtil.hp(_kvo.getMhp());
	String hp[] = mhp.split("-");
	mhp0 = hp[0];
	mhp1 = hp[1];
	mhp2 = hp[2];
	
	// 전화번호 
	mtel = CodeUtil.tel(_kvo.getMtel());
	String tel[] = mtel.split("-");
	mtel0 = tel[0];
	mtel1 = tel[1];
	mtel2 = tel[2];
	
	// 이메일
	memail = _kvo.getMemail();
	memails = memail.split("@");
	
	// 취미 
	mhobby = _kvo.getMhobby();
		
%> 

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">

	$(document).ready(function(){	
		
		// 이메일 
		$('#memail2').change(function(){	
			$("#memail2 option:selected").each(function () {
				if($(this).val()== '1'){ //직접입력일 경우 
						var aa = $("#memail1").val();						
						$("#memail1").val(''); //값 초기화 
						$("#memail1").attr("readonly",false); //활성화 				
				}else{ //직접입력이 아닐경우 
						$("#memail1").val($(this).text()); //선택값 입력 
						$("#memail1").attr("readonly",true); //비활성화 
				}
			}); 
		}); 	
		
		// 우편번호	
		$("#zonecode").click(function(){
			console.log("zonecode >>> : ");
			new daum.Postcode({
				oncomplete: function(data) {
				    $("#mzonecode").val(data.zonecode); 		//5자리 새우편번호 사용
				    $("#mroadaddr").val(data.roadAddress); 		//도로명 주소
				    $("#mroaddetail").val(''); 					// 도로명 상세주소
				    $("#mjibunaddr").val(data.jibunAddress); 	//지번주소			
				}
			}).open();
		});
		
		// 취미들
		var mhobbys = '<%= mhobby %>';
		mhobbys = mhobbys.split(',');
		console.log("mhobbys >>> : " + mhobbys);
	
		for (var i=0; i < mhobbys.length; i++){
			let mhobby = mhobbys[i]
			console.log(mhobby);				
			
			$(".mhobby").each(function(){
				if($(this).val() == mhobby){
					$(this).prop("checked", true);
				}
			});
		}	
	});

	//  updateBtn
	$(document).on("click", "#updateBtn", function(){
		//alert("U >>> : ");		
		$("#memUpdateForm").attr({ "method":"GET"
			                      ,"action":"memUpdate.k"}).submit();
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
	}
	.photo {
		border:1px solid red;		
		width: 180px;
		height: 180px;		
		display: block;
		/*
			margin-reft: auto;
			margin-rigth; auto;
		*/		
		border-radius: 50%;
	}
	
	.tt {
		color: red;
	}
</style>
</head>
<body>
<script>

</script>
<h3>회원정보</h3>
<hr>
<div>
<form name="memUpdateForm" id="memUpdateForm">	
<table>
<tr>
	<td colspan="3" align="center">					
		<font size="4" style="color:blue;">수정 && 삭제</font>					
		<img src="/kosSpring/img/img_mandu/ase.gif" width="25" height="25" alt="image">
	</td>
</tr>
<tr>
	<td>회원번호</td>
	<td>
		<input type="text" name="mnum" id="mnum" value="<%= _kvo.getMnum() %>" readonly/>
	</td>
	<td rowspan="5"> 
		<img class="photo" src="/kosSpring/fileupload/mem/<%= _kvo.getMphoto() %>" alt="image">
    </td>
</tr>
<tr>
	<td>이름</td>
	<td><input type="text" name="mname" id="mname" value="<%= _kvo.getMname() %>" readonly/></td>
 </tr>
 <tr>
	<td>아이디</td>
	<td>
		<input type="text" name="mid" id="mid" placeholder="아이디체크" style="width:100px" value="<%= _kvo.getMid() %>" readonly />		
	</td>
 </tr>
 <tr>
	<td>패스워드</td>
	<td>
		<input type="password" name="mpw" id="mpw" style="width:100px" value="<%= mpw %>" readonly /><br/>
	</td>
 </tr>
 <tr>
	<td>성별</td>
	<td> 
		<input type="radio" name="mgender" id="mgender_f" value="F" checked onclick="return(false);" /> 여자
      	<input type="radio" name="mgender" id="mgender_m" value="M" onclick="return(false);" /> 남자
    </td>
 </tr>
 <tr>
	<td>생년월일</td>
	<td  colspan="2">		
		<input type="text" name="mbirth" id=mbirth placeholder="년(4자)" value="<%= mbirth0 %>" maxlength="4" style="width:50px" readonly />
		<input type="text" name="mbirth1" id="mbirth1" value="<%= mbirth1 %>" style="width:20px" readonly >
        <input type="text" name="mbirth2" id="mbirth2" value="<%= mbirth2 %>" style="width:20px" readonly >
	</td>
 </tr>
 <tr>
	<td class="tt">핸드폰</td>
	<td colspan="2">
		<select name="mhp" id="mhp" style="width:50px;">
        	<option value="010">010</option>
        	<option value="011">011</option>
        	<option value="016">016</option>
        	<option value="017">017</option>		        	
         </select>
         - <input type="text" name="mhp1" id="mhp1" value="<%= mhp1 %>" maxlength="4" style="width:50px;"/>
         - <input type="text" name="mhp2" id="mhp2" value="<%= mhp2 %>" maxlength="4" style="width:50px;"/>
	</td>
 </tr>
 <tr>
	<td class="tt">전화번호</td>
	<td colspan="2">
		<select name="mtel" id="mtel">
        	<option value="02">02</option>
        	<option value="031">031</option>
        	<option value="041">041</option>
        	<option value="051">051</option>
        	<option value="061">061</option>	        			       
         </select>
		- <input type="text" name="mtel1" id="mtel1" value="<%= mtel1 %>" style="width:50px;"/>
		- <input type="text" name="mtel2" id="mtel2" value="<%= mtel2 %>" style="width:50px;"/>
	</td>
 </tr>
 <tr>
	<td class="tt">이메일</td>
	<td colspan="2">		
		<input type="text" name="memail" id=memail style="width:100px" value="<%= memails[0] %>" />
		@ <input type="text" name="memail1" id=memail1 style="width:100px" value="<%= memails[1] %>" placeholder="직접입력" />
		<select name="memail2" id="memail2" style="width:100px;margin-right:10px">
        	 <option value="1" selected>직접입력</option>
       		 <option value="naver.com">naver.com</option>	       	   
      		 <option value="gmail.com">gmail.com</option>
      		 <option value="daum.net">daum.net</option>	       	   
         </select>
	</td>
 </tr>
 <tr>
 	<td class="tt">주소</td>
 	<td colspan="2">
 		<input type="text" name="mzonecode" id="mzonecode" 
 			placeholder="우편번호" style="width:50px" value="<%= _kvo.getMzonecode() %>">
 		<input type="button" name="zonecode" id="zonecode" value="우편번호 찾기"><br>	 	
 		<input type="text" name="mroadaddr" id="mroadaddr" 
 			placeholder="도로명주소" style="width:300px" value="<%= _kvo.getMroadaddr() %>"><br>	 	
 		<input type="text" name="mroaddetail" id="mroaddetail" 
 			placeholder="도로명주소 상세주소" style="width:300px" value="<%= _kvo.getMroaddetail() %>"><br>	 	
 		<input type="text" name="mjibunaddr" id="mjibunaddr" 
 			placeholder="지번주소" style="width:300px" value="<%= _kvo.getMjibunaddr() %>">
 	</td>
 </tr>	 
 <tr>
	<td class="tt">취미</td>
	<td colspan="2"> 
		<input type="checkbox" class="mhobby" name="mhobby" value="mh1" />알고리즘		      
        <input type="checkbox" class="mhobby" name="mhobby" value="mh2" />코딩
        <input type="checkbox" class="mhobby" name="mhobby" value="mh3" />분석설계<br>
        <input type="checkbox" class="mhobby" name="mhobby" value="mh4" />데이터베이스
        <input type="checkbox" class="mhobby" name="mhobby" value="mh5" />스크립트
    </td>
 </tr>	 
 <tr>
	<td class="tt">소개글</td>
	<td  colspan="2"s>
		<textarea name="minfo" id="minfo" rows="5" cols="50"><%= _kvo.getMinfo() %>				
		</textarea>
	</td>
 </tr>
 <tr>
	<td colspan="3"> 			
		<button type="button" id="updateBtn">수정</button>
		<button type="reset">다시 </button>
	</td>				
 </tr>
 </table>				 		        		     
</form>	
</div>		
</body>
</html>