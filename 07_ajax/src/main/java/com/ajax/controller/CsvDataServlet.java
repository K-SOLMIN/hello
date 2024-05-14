package com.ajax.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ajax.model.dto.Actor;

/**
 * Servlet implementation class CsvDataServlet
 */
@WebServlet("/jquery/csvdata.do")
public class CsvDataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CsvDataServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Actor> actors = new ArrayList<Actor>();
		
		actors.add(new Actor("박보검","0104435241","parkBogum.jpg"));
		actors.add(new Actor("멧데이먼","01011232223","mattDamon.jpg"));
		actors.add(new Actor("쥴리아로버츠","01055843213","juliaRoberts.jpg"));
		
		String csv = "";
		for(int i = 0; i < actors.size(); i++) {
			if(i != 0) csv += "\n";
			csv += actors.get(i);
		}
		
		response.setContentType("text/csv;charset=utf-8");
		response.getWriter().print(csv);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
