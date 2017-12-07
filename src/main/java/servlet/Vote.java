package servlet;

import redistools.SetOperations;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/vote")
public class Vote extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String entryName = request.getParameter("entryName");
        HttpSession s = request.getSession();

        SetOperations so = (SetOperations) s.getAttribute("setoper");
        so.incrementScore(entryName);

        response.sendRedirect("index.jsp");
    }
}