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
import jakarta.servlet.http.HttpSession;
import model.UserAccount;
import model.UserAccountDAO;

/**
 *
 * @author ASUS
 */
public class ChangePassword extends HttpServlet {

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
            out.println("<title>Servlet ChangePassInfo</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePassInfo at " + request.getContextPath() + "</h1>");
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

        String oldPassword = request.getParameter("oldPassword");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        HttpSession session = request.getSession(false);
        
        if(session == null || session.getAttribute("userAccount") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        UserAccount ua = (UserAccount) session.getAttribute("userAccount");

        if (!oldPassword.equals(ua.getPassword())) {
            request.setAttribute("error", "Mật khẩu không đúng! Vui lòng nhập lại!");
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
            return;
        }

        if (oldPassword.equals(password)) {
            request.setAttribute("error", "Mật khẩu mới giống với mật khẩu cũ! Vui lòng nhập lại!");
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Xác nhận mật khẩu không đúng! Vui lòng nhập lại!");
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
            return;
        }

        UserAccountDAO uad = new UserAccountDAO();
        uad.updatePassword(ua.getAccountName(), password);
        
        session.invalidate();
        session = request.getSession(true);
        session.setAttribute("userAccount", uad.getUserAccountByAccountName(ua.getAccountName()));
        request.setAttribute("success", "Đổi mật khẩu thành công!");
        request.getRequestDispatcher("changePassword.jsp").forward(request, response);
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
