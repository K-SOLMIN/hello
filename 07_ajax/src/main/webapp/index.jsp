<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajax 활용</title>
</head>
<body>
   <h2>기본 XMLHttpRequest객체 이용하기</h2>
   <p>
      XMLHttpRequest객체가 제공하는 속성, 함수를 이용해서 ajax통신을 할 수 있다.
      함수/속성(Property) <br>
      onreadystatechange : 요청에대한 상태가 변경될때마다 실행되는 이벤트핸들러 (callback)를 등록하는 속성<br>
      <!-- on은 이벤트 브라우저가 반응해서 실행시킴 -->
      readyState속성 : 요청을 처리하는 상태값을 저장하는 속성(0~4)값을 가짐 * 4가 되면 응답이 완료된 상태 <br>  
      <!-- 브라우저가 0 1 2 3 4 순서대로 응답에 따라 숫자로 표시, 0에서 4가 되면 응답완료 -->
      status속성 : response status code 응답코드를 저장하는 속성 * 200(정상), 404(페이지없음), 500(서버에러), 302(리다이렉션) <br>
      <!-- 상태코드(응답코드) 404, 200, 500 코드 -->
      open("전송방식","전송url") : 요청방식과 요청주소를 설정하는 함수 <br>
      send(["data"]) : 설정한대로 요청을 전송하는 함수 <br>
      <!-- post방식을때 데이터를 쓸수도 있음, get방식일땐 안씀 -->
      <!-- open으로 설정 send로 전송 -->
   </p>
   <button onclick="basicRequest();">ajax기본요청</button> <br>
   <input type="text" id="name">
   <button id="btn">get방식으로 데이터 전송하기</button>
   <br> <br>
   
   <input type="text" id="id">  <br>
   <input type="password" id="pw">
   <button id="sendPw">post방식으로 데이터전송</button>
   
   <div id="result"></div>
   <a href="<%=request.getContextPath()%>/ajax/basicajax.do">동기화 요청</a>
   <script>
   
      //post방식으로 데이터 넘기기
      document.getElementById("sendPw").addEventListener("click",e=>{
         const xmlRequest = new XMLHttpRequest();
         xmlRequest.onload=()=>{
            if(xmlRequest.status==200){
               alert("완료");
            }
         }
         
         xmlRequest.open("post","<%=request.getContextPath()%>/ajax/parametertest.do");
         //데이터를 보내기 위해서 header에 설정을 해야한다.
         xmlRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
         
         const data = document.querySelector("#pw").value;   
         const id = document.querySelector("#id").value;
         //key : value로 넘기기
         xmlRequest.send("pw="+data+"&id="+id);
      });
   
   
      //get방식으로 데이터 넘기기
      document.getElementById("btn").addEventListener("click",e=>{
         const xmlRequest = new XMLHttpRequest();
         xmlRequest.onload=()=>{
            if(xmlRequest.status==200){
               document.querySelector("#result").innerHTML = xmlRequest.responseText;
            }   
         }
         // input 태그 value 를 뽑아서 커리스트림?으로 넘겨서 줄 수 있다. 
         const nameVal = document.querySelector("#name").value;
         xmlRequest.open("get","<%=request.getContextPath()%>/ajax/parametertest.do?name="+nameVal);
         xmlRequest.send();
      });
   
      
      const basicRequest=()=>{
         // 1.XMLHttpRequest객체를 기본생성하기
         //   -   new XMLHttpRequest();
         const request = new XMLHttpRequest();
         // 2. 속성설정
         // onload속성을 이용해도됨.
         request.onreadystatechange=()=>{
            console.log(request.readyState);
            console.log(request.status);
            //요청상태가 변경되면 실행되는 이벤트 핸들러를 등록
            if(request.readyState==4){
               //responseText속성 / responseXML속성   //XML속성은 요즘 사용하지않고, Text로 받아와 처리하는 경우가 많다.
               console.log(request.responseText);
               if(request.status==200){
                  alert("응답완료");
                  document.querySelector("#result").innerHTML = request.responseText;
               }else{
                  alert("에러에러!!!");
               }
            }
         }
         // 3. 요청정보설정 -> 요청방식, 요청URL   <!-- <안에 있는 request는 자바객체> 다른애들은 자바스크립트 함수 -->
         request.open("GET","<%=request.getContextPath()%>/ajax/basicajax.do");
         // 4. 요청전송하기
         request.send();
         
      }
   </script>

   <h3>js가 제공하는 fetch함수를 이용해서 요청처리하기</h3>
   <p>
      fetch("url",{옵션}) 함수 
      promise객체를 반환
      .then((e)=>{})
   </p>
   
   <button id="btn3">fetch()함수이용</button>
   <script>
      document.getElementById("btn3").addEventListener("click",e=>{
         fetch("<%=request.getContextPath()%>/ajax/basicajax.do")
         .then(function(response){
            //응답한 내용을 처리하는 callback함수
            //응답에러처리, 정상처리
               console.log(response)
            // fetch의 response객체에서 응답한 내용을 가져오려면
            // json() : 응답데이터가 JSON방식일때 데이터를 json으로 파싱해주는 함수
            //  content-type : application/json방식일때 사용
            // text() : 문자열 전체 
               return response.text();
            })
            
            //위에 결과(return)을 가지고 아래를 실행시킴
         .then(function(data){
            //응답결과를 페이지에 반영하는 callback함수
            document.getElementById("result").innerHTML = data;
         });   
            //then() 괄호 안에 들어가는 값은 fetch값이 리턴되어 들어간다?
      });
      
   </script>
   <input type="text" id="fetchdata">
   <button onclick="testfetch();">두번째fetch()</button>
   <script>
      const testfetch=()=>{
         const data = document.querySelector("#fetchdata").value;    
         
         fetch("<%=request.getContextPath()%>/ajax/fetchtest.do?data="+data)
         .then(response=>{
            //.ok  는 true   아니면  false 반환함
            if(!response.ok) throw new Error(response.status);
            else return response.json();
         })
         .then(data=>{
            alert(data);
            console.log(data);
            document.getElementById("result").innerHTML ="<h3>"+data[0]+"</h3>";
         }).catch(e=>{
            alert("에러에러 - "+e);
         });
         
      }
   </script>
   
   <h2>post방식으로 데이터 전송하기</h2>
   <p>
      json방식으로 객체를 전달을 많이 함.
   </p>
   <button onclick="postFetch();">post방식 전달</button>
   <script>
      const postFetch=()=>{
         fetch("<%=request.getContextPath()%>/ajax/fetchtest.do",{
            //header에 대한 정보설정, method방식설정, body에 데이터 저장
            headers : {
               //"Content-type":"application/json;charset=utf-8"
               "Content-type":"application/x-www-form-urlencoded;charset=utf-8"
            },
            method:"POST",
            //body:JSON.stringify({test:"testdata"})
            //body:"test=testdata&name=bs"
            body:"data="+JSON.stringify([1,2,3,4])
         })
         .then(response=>response.text())
         .then(data=>{
            console.log(data);
         })
      }
   </script>
   
   <h3>jquery가 제공하는 함수를 이용해서 ajax요청처리하기</h3>
   <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
   <p>
      $.ajax({객체}) : 요청에 대한 상세설정할때 사용, header, 요청content설정 등
      $.get("url",callback()) : get방식으로 간단하게 데이터를 가져올때 사용
      $.post("url",{객체},callback()) : post방식으로 데이터를 저장, 조회할때 사용
   </p>

   <h3>$.ajax()함수이용하기</h3>
   <p>
      매개변수로 객체를 전송 -> property가 정해져있다. <br>
      url : 요청주소 설정하는 속성 String<br>
      [type : 요청방식에 대한 설정하는 속성(GET,POST,PUT,DELETE 등)] -> 생략시 GET String<br>
      [data : 서버에 보낼 데이터작성 object({key:value,key:value})] <br>
      [dataType : 서버응답 데이터타입 설정(text,json,xml)] -> contentType에 따라 자동으로 처리 <br>
      success : 응답성공시 실행할 callback함수(status==200) -> function(data){} <br>
      [error : 응답실패시 실행할 callback함수(status!=200) -> function(request,error){}] <br>
      <!-- 성공하던 실패하던 무조건 실행되야하는 코드 -->
      [complete : 요청이 성공 또는 실패했을때 모두 실행되는 callback함수 설정 -> function(){}] 
   </p>
   <input type="text" id="name2"> <br>
   <input type="number" id="age"> <br>
   <button id="btn4">$.ajax기본요청</button>
   <div id="result2"></div>
   <script>
      $("#btn4").click(e=>{
         $.ajax({
            url:"<%=request.getContextPath()%>/jquery/basicjquery.do",
            //객체 구조를 이루고있다..
            type:"POST",
            data:{"name":$("#name2").val(),"age":$("#age").val()},
            success:function(data){
               console.log(data);
               $("#result2").append("<h3>"+data+"</h3>");
            },
            error: function(request,e){
               console.log(request);
               console.log(e);
            },
            complete: function(){
               console.log("무조건실행");
            }
            //화살표함수 가능 //화살표함수일때는 this가 window임 주의
         });
      });
   </script>
   <h3>$.get() get방식으로 데이터를 요청하기</h3>
   <button id="btn5">$.get이용하기</button>
   <h3>$.post() post방식으로 데이터 요청하기</h3>
   <button id="btn6">$.post() 이용하기</button>
   <div id="result3"></div>
   <script>
	  $("#btn6").click(e => {
		  $.post("<%= request.getContextPath() %>/jquery/basicjquery.do",
				  {name:"김class",age:28})
				  .done(data => {
					  $("#result3").html(data);
				  });
				  /* data => {
					  $("#result3").html(data);
				  }); */
	  });	
	  
      $("#btn5").click(e=>{
         <%-- $.get("<%=request.getContextPath()%>/jquery/basicjquery.do?name=bs&age=19",
               e=>{
                  $("#result3").html(`<h3>\${e}</h3>`);   
               }); --%>
         $.get("<%=request.getContextPath()%>/jquery/basicjquery.do?name=mj&age=32")
         .done(data=>{
            $("#result3").html(`<h2>\${data}</h2>`);
         })
         .fail((r,e)=>{
            console.log(r);
            console.log(e);
         });
      });
   </script>

</body>
</html>