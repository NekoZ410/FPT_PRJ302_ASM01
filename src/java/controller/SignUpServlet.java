/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.UserAccount;
import model.UserAccountDAO;

/**
 *
 * @author ACER
 */
public class SignUpServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet registerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet registerServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        UserAccountDAO uad = new UserAccountDAO();

        String userName = request.getParameter("userName");
        String email = request.getParameter("email");
        String accountName = request.getParameter("accountName");
        String pwd = request.getParameter("pwd");
        String repwd = request.getParameter("repwd");

        if (uad.getUserAccountByEmail(email) != null) {
            request.setAttribute("userName", userName);
            request.setAttribute("email", email);
            request.setAttribute("accountName", accountName);
            request.setAttribute("pwd", pwd);
            request.setAttribute("repwd", repwd);
            request.setAttribute("error", "Email đã tồn tại! Vui lòng nhập lại!");
            request.getRequestDispatcher("signUp.jsp").forward(request, response);
            return;
        }

        if (accountName.length() < 4) {
            request.setAttribute("userName", userName);
            request.setAttribute("email", email);
            request.setAttribute("accountName", accountName);
            request.setAttribute("pwd", pwd);
            request.setAttribute("repwd", repwd);
            request.setAttribute("error", "Tên tài khoản phải tối thiểu 4 ký tự!");
            request.getRequestDispatcher("signUp.jsp").forward(request, response);
            return;
        }

        if (!pwd.equals(repwd)) {
            request.setAttribute("userName", userName);
            request.setAttribute("email", email);
            request.setAttribute("accountName", accountName);
            request.setAttribute("pwd", pwd);
            request.setAttribute("repwd", repwd);
            request.setAttribute("error", "Mật khẩu không khớp! Vui lòng nhập lại");
            request.getRequestDispatcher("signUp.jsp").forward(request, response);
            return;
        }

        if (uad.getUserAccountByAccountName(accountName) == null) {
            uad.insertUserAccount(accountName, userName, pwd, email);
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("userName", userName);
            request.setAttribute("email", email);
            request.setAttribute("accountName", accountName);
            request.setAttribute("pwd", pwd);
            request.setAttribute("repwd", repwd);
            request.setAttribute("error", "Tên tài khoản đã tồn tại! Vui lòng nhập lại!");
            request.getRequestDispatcher("signUp.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
