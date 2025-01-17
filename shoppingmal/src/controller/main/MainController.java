package controller.main;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.goods.GoodsListAction;
import controller.goods.GoodsModifyAction;


public class MainController extends HttpServlet 
	implements Servlet{
	public void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());
		/// uri = /shopping/index.html
		///       0123456789
		/// context = /shopping
		///           123456789
		if(command.equals("/main.sm")) {
			GoodsListAction action = new GoodsListAction();
			action.goodsList(request);
			RequestDispatcher dispatcher = request.getRequestDispatcher("main/home.jsp");
			dispatcher.forward(request, response);
		} else if(command.equals("/login.sm")) {
			LoginAction action = new LoginAction();
			action.login(request);
			response.sendRedirect("main.sm");
		} else if(command.equals("/logout.sm")) {
			HttpSession session = request.getSession();
			session.invalidate();
			response.sendRedirect("main.sm");
		} 
	}

	@Override
	protected void doGet(HttpServletRequest req, 
			HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req,resp);
	}
}