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
import java.util.*;
import model.*;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ASUS
 */
public class AddCartServlet extends HttpServlet {
   
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
            out.println("<title>Servlet AddCartServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddCartServlet at " + request.getContextPath () + "</h1>");
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
        
        String xProductId = request.getParameter("productID");
        HttpSession session = request.getSession(false);
        
        if(session == null || session.getAttribute("userAccount") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        UserAccount xCurrentUA = (UserAccount) session.getAttribute("userAccount");
        String xQuantity = request.getParameter("quantity");
        
        int productID = Integer.parseInt(xProductId);
        int quantity = Integer.parseInt(xQuantity);
        
        if(quantity < 0){
            request.setAttribute("error", "Số lượng không hợp lệ!");
            request.getRequestDispatcher("productDetail.jsp").forward(request, response);
            return;
        }
        
        ProductDAO pd = new ProductDAO();
        CartDAO cd = new CartDAO();
        if((quantity + cd.getCartByUserIDAndProductID(xCurrentUA.getUserID(), productID).getQuantity()) > pd.getProductByID(productID).getUnitInStock()){
            request.setAttribute("product", new ProductDAO().getProductByID(productID));
            request.setAttribute("error", "Số lượng hàng quá lớn! Không thể xử lý.");
            request.getRequestDispatcher("productDetail.jsp").forward(request, response);
            return;
        }
        
        Cart c = new Cart(xCurrentUA, 0, new ProductDAO().getProductByID(productID), quantity);
        new CartDAO().insertCart(c);
        
        request.setAttribute("listCart", new CartDAO().getCartList(xCurrentUA.getUserID()));
        request.getRequestDispatcher("showCart.jsp").forward(request, response);
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
