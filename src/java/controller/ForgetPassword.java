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
public class ForgetPassword extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet changePassword</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet changePassword at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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

        String input = request.getParameter("input");
        String newpwd = request.getParameter("newpwd");
        String renewpwd = request.getParameter("renewpwd");
        
        UserAccountDAO uad = new UserAccountDAO();
        
        if (!renewpwd.equals(newpwd)) {
            request.setAttribute("input", input);
            request.setAttribute("error", "Xác nhận mật khẩu mới không chính xác!");
            request.getRequestDispatcher("forgetPassword.jsp").forward(request, response);
            return;
        }
        
        if (uad.getUserAccountByEmail(input) == null && uad.getUserAccountByAccountName(input) == null) {
            request.setAttribute("error", "Tài khoản không tồn tại! Vui lòng nhập lại!");
            request.getRequestDispatcher("forgetPassword.jsp").forward(request, response);
            return;
        }
        
        if (uad.getUserAccountByAccountName(input) != null && uad.getUserAccountByEmail(input) == null) {
            uad.updatePassword(input, newpwd);
        } else if (uad.getUserAccountByAccountName(input) == null && uad.getUserAccountByEmail(input) != null) {
            uad.updatePassword(uad.getUserAccountByEmail(newpwd).getAccountName(), newpwd);
        }
        
        request.setAttribute("success", "Đổi mật khẩu thành công!");
        request.getRequestDispatcher("forgetPassword.jsp").forward(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

//        private void changePassword(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
//        
//        UserAccountDAO userAccountDAO = new UserAccountDAO();
//    
//        String name = request.getParameter("Username");
//        String password= request.getParameter("Password");
//        
//        UserAccount userAccount = new UserAccount();
//        
//        userAccount = userAccountDAO.getUserAccountByUsername(name);
//        
//        if (userAccount  != null ) {
//            userAccountDAO.updatePassword(name, password);
//            response.sendRedirect("");// login
//           
//        } else {
//            
//            request.setAttribute("error", "Account is not exist, please choose another one !!");
//            request.getRequestDispatcher("").forward(request, response);
//        }
//    }
}
