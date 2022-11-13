<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member Form</title>

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- 디바이스에 최적화된 크기로 출력됨 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0
     	maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
     	
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
	alert("자바스크립트 블럭  진입 >>> : ");

	$(document).ready(function(){	
		alert("jQuery ready() 함수 진입 >>> : ");
		
		// 회원번호 				
		// 이름 
		
		// 아이디 중복체크 Ajax 비동기 방식  시작  ================================================= 				
		$(document).on("click", "#midbtn", function(){
			alert("kidbtn >>> : ");

			let idCheckURL = "kosIdCheck.k";
			let reqType = "GET";
			let dataParam = { mid: $("#mid").val(), };
			
			$.ajax({
				url: idCheckURL,
				type: reqType,								
				data: dataParam,	            
				success: whenSuccess,
				error: whenError
			});
			
			function whenSuccess(resData){	
				alert("resData >>> : " + resData);
				if ("ID_YES" == resData){
					alert("아이디 사용가능 : ID_YES.");														
					$("#mkid").css('background-color','yellow');	
					$("#mid").attr("readonly", true);
					$("#mpw").focus();	
				}else if ("ID_NO" == resData){
					alert("이미 아이디 사용중 : ID_NO.");
					$("#mid").val('');
					$("#mid").focus();
				};				
			}
			function whenError(e){
				alert("e >>> : " + e.responseText);
			}
		});
		
		// 비밀번호 체크 
		$("#pwCheck").click(function(){
			console.log("pwCheck 함수 진입");
			var pw = $("#mpw").val();
			var pw_r = $("#mpw_r").val();
			alert("pw >>> : " + pw);
			alert("pw_r >>> : " + pw_r);
			if(pw == pw_r) {
				alert("비밀번호가 같습니다.");		
				$("#mgender").focus();						
				return true;
			} else {
				alert("비밀번호가 다릅니다.");
				$("#mpw").val('');
				$("#mpw_r").val('');			
				$("#mpw").focus();							
				return false;
			}
		});
		
		// 성별
		
		// 생년월일
		$("#mbirth").on("input", function(){
			var m = $("#mbirth");
			if (m.val().length > m.maxlength){
				m.valu = m.value.slice(0, m.maxlength);
			}
		});		
        // 월 
        $("#mbirth1").append("<option value=''>월--- </option>");
        for(var i = 1; i <= 12; i++){
        	if (i < 10){ i = '0'+i;}
            $("#mbirth1").append("<option value='"+ i +"'>"+ i + "</option>");
        }
        // 일 
        $("#mbirth2").append("<option value=''>일 ---</option>");
        for(var i = 1; i <= 31; i++){
        	if (i < 10){ i = '0'+i;}
            $("#mbirth2").append("<option value='"+ i +"'>"+ i + "</option>");
        }

		
		// 핸드폰		
		// 전화번호
		
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
			}}); 
		}); 	
		
		// 우편번호
		$("#mzonecode").prop('readonly', true);
		$("#mroadaddr").prop('readonly', true);
		$("#mgibunaddr").prop('readonly', true);		
		$("#zonecode").click(function(){
			console.log("zonecode >>> : ");
			new daum.Postcode({
				oncomplete: function(data) {
				    $("#mzonecode").val(data.zonecode); //5자리 새우편번호 사용
				    $("#mroadaddr").val(data.roadAddress); //도로명 주소
				    $("#mjibunaddr").val(data.jibunAddress); //지번주소			
				}
			}).open();
		});
		
		// 취미		
		// 소개글 		
		// 사진 
		
		// 폼태그 데이터 콘트롤러에 보내기 
		$(document).on("click", "#btn", function(){
			alert("btn 버튼 블럭 진입 >>> : ");			
			console.log("btn >>> : ");	
							
			$('#memForm').attr({
				'action':'memInsert.k',
				'method':'POST',
				'enctype':'multipart/form-data'
			}).submit();
		});		
	});
</script>

<style type="text/css">
	/*
	div {
			margin: 50px 0px 0px 100px;
		}
	.mem{ text-align: center;}
	*/
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
</style> 
</head>
<body>
<h3><font size="4" style="color:Blue;">SPRING MYBATIS 회원가입</font></h3>
<hr>
<div>
<form name="memForm" id="memForm">
<table>
<tr>
	<td colspan="2" align="center">					
		<font size="4" style="color:Blue;">KOSMO 120기</font>					
		<img src="/kosSpring/img/img_mandu/ase.gif" width="25" height="25" alt="image">
	</td>
</tr>
<tr>
<td>회원번호</td>
<td><input type="text" name="mnum" id="mnum" readonly/></td>
 </tr>
<tr>
<td>이름</td>
<td><input type="text" name="mname" id="mname"/></td>
</tr>
<tr>
<td>아이디</td>
<td>
	<input type="text" name="mid" id="mid" placeholder="아이디체크" style="width:100px" />
	<input type="button" name="midbtn" id="midbtn" value="아이디중복확인"  />
</td>
</tr>
<tr>
<td>패스워드</td>
<td>
	<input type="password" name="mpw" id="mpw" style="width:100px" /><br/>
	<input type="password" name="mpw_r" id="mpw_r" placeholder="비밀번호확인" style="width:100px" />
	<input type="button" value="비밀번호확인" id="pwCheck"/><br/>
</td>
</tr>
<tr>
<td>성별</td>
<td> 
	<input type="radio" name="mgender" id="mgender_f" value="F" checked /> 여자
     	<input type="radio" name="mgender" id="mgender_m" value="M" /> 남자
   </td>
</tr>
<tr>
<td>생년월일</td>
<td>		
	<input type="text" name="mbirth" id=mbirth 
	       placeholder="년(4자)" maxlength="4" style="width:50px"/>
	<select name="mbirth1" id="mbirth1"></select>
       <select name="mbirth2" id="mbirth2"></select>
</td>
</tr>
<tr>
<td>핸드폰</td>
<td>
	<select name="mhp" id="mhp">
       	<option value="010">010</option>
       	<option value="011">011</option>
       	<option value="016">016</option>
       	<option value="017">017</option>		        	
        </select>
        - <input type="text" name="mhp1" id="mhp1" size="2"/>
        - <input type="text" name="mhp2" id="mhp2" size="2"/>
</td>
</tr>
<tr>
<td>전화번호</td>
<td>
	<select name="mtel" id="mtel">
       	<option value="02">02</option>
       	<option value="031">031</option>
       	<option value="041">041</option>
       	<option value="051">051</option>
       	<option value="061">061</option>	        			       
        </select>
	- <input type="text" name="mtel1" id="mtel1" size="2"/>
	- <input type="text" name="mtel2" id="mtel2" size="2"/>
</td>
</tr>
<tr>
<td>이메일</td>
<td>		
	<input type="text" name="memail" id=memail style="width:100px" />
	@ <input type="text" name="memail1" id=memail1 style="width:100px" placeholder="직접입력" />
	<select name="memail2" id="memail2" style="width:100px;margin-right:10px">
       	 <option value="1" selected>직접입력</option>
      		 <option value="naver.com">naver.com</option>	       	   
     		 <option value="gmail.com">gmail.com</option>
     		 <option value="daum.net">daum.net</option>	       	   
        </select>
</td>
</tr>
<tr>
	<td class="mem">주소</td>
	<td>
		<input type="text" name="mzonecode" id="mzonecode" placeholder="우편번호" style="width:50px">
		<input type="button" name="zonecode" id="zonecode" value="우편번호 찾기"><br>	 	
		<input type="text" name="mroadaddr" id="mroadaddr" placeholder="도로명주소" style="width:250px"><br>	 	
		<input type="text" name="mroaddetail" id="mroaddetail" placeholder="도로명주소 상세주소" style="width:250px"><br>	 	
		<input type="text" name="mjibunaddr" id="mjibunaddr" placeholder="지번주소" style="width:250px">
	</td>
</tr>	 
<tr>	 
<td>취미</td>
<td> 
	<input type="checkbox" name="mhobby" value="mh1" />알고리즘		      
       <input type="checkbox" name="mhobby" value="mh2" />코딩
       <input type="checkbox" name="mhobby" value="mh3" />분석설계<br>
       <input type="checkbox" name="mhobby" value="mh4" />데이터베이스
       <input type="checkbox" name="mhobby" value="mh5" />스크립트
   </td>
</tr>	 
<tr>
<td>소개글</td>
<td>
	<textarea name="minfo" id="minfo" rows="5" cols="50">내 소개글					
	</textarea>
</td>
</tr>
<tr>
<td>사진</td>
<td> 
	<input type="file" name="mphoto"  /><br>
   </td>
</tr>
<tr>
<td colspan="2"> 			
	<button type="button" id="btn">보내기</button>
	<button type="reset">다시 </button>
</td>				
</tr>
</table>				 		        		     
</form>	
</div>		
</body>
</html>