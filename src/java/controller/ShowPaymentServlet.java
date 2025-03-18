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
import java.util.*;
import model.*;

/**
 *
 * @author Admin
 */
public class ShowPaymentServlet extends HttpServlet {
   
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
            out.println("<title>Servlet ShowPaymentServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ShowPaymentServlet at " + request.getContextPath () + "</h1>");
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
        // processRequest(request, response); // uncomment when needed
        PrintWriter out = response.getWriter();
        response.setContentType("text/html;charset=UTF-8");
        
        
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
        // processRequest(request, response); // uncomment when needed
        PrintWriter out = response.getWriter();
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession(false);
        
        if(session == null || session.getAttribute("userAccount") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        UserAccount xCurrentUA = (UserAccount) session.getAttribute("userAccount");
        
        String xPaymentMethod = request.getParameter("paymentMethod");
        String xSumPrice = request.getParameter("sumPrice");
        int sumPrice = Integer.parseInt(xSumPrice);
        
        String paymentMethod;
        if (xPaymentMethod.equals("bank")) {
            paymentMethod = "Chuyển khoản";
        } else {
            paymentMethod = "Ship COD";
        }
        
        OrderDAO od = new OrderDAO();
        List<Order> listOrder = od.getOrderList(xCurrentUA.getUserID());
        
        PurchasedDAO pd = new PurchasedDAO();
        pd.insertPurchased(xCurrentUA.getUserID(), listOrder);
        
        for (Order o : listOrder) {
            od.deleteOrder(xCurrentUA.getUserID(), o.getOrderID());
        }
        
        new PaymentDAO().insertPayment(new Payment(xCurrentUA, 0, paymentMethod, null, sumPrice), xCurrentUA.getUserID());
        
        request.setAttribute("listPurchased", pd.getPurchasedList(xCurrentUA.getUserID(), pd.getMaxPurchasedIDByUserID(xCurrentUA.getUserID())));
        request.setAttribute("sumPrice", sumPrice);
        request.setAttribute("paymentMethod", paymentMethod);
        request.getRequestDispatcher("showPayment.jsp").forward(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
