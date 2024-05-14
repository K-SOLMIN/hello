package com.basicweb.controller;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//서블릿
//클라이언트가 보낸 요청을 받고 해당하는 서비스를 진행하고 응답하는 역할
//클라이언트 요청은 URL주소를 설정해서 보내! -> 각 서블릿은 유일하게 연결된 url주소가 있다.
//내부에서 요청/응답을 처리할 메소드를 재정의해서 사용
// 1. doGet() : 클라이언트가 get방식으로 요청을 보냈을때 실행되는 메소드
// 2. doPost() : 클라이언트가 post방식으로 요청을 보냈을때 실행되는 메소드
public class FirstController extends HttpServlet{
	
	//web.xml에 선언한 서블릿을 등록을 해줘야한다.
	// 1. 서블릿을 등록
	// 2. 서블릿을 실행할 url주소를 등록
	int doCount = 1;
	int postCount = 1;
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse reponse) {
		System.out.println("요청 들어옴(GET)!");
		System.out.println(doCount++);
	}
	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse reponse) {
		System.out.println("요청이 들어옴(POST)!");
		System.out.println(postCount);
	}
}
