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
import model.*;
import java.util.*;

/**
 *
 * @author Admin
 */
public class OrderDirectly extends HttpServlet {

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
            out.println("<title>Servlet OrderServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderServlet at " + request.getContextPath() + "</h1>");
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
        // processRequest(request, response); // uncomment when needed
        PrintWriter out = response.getWriter();
        response.setContentType("text/html;charset=UTF-8");

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
        // processRequest(request, response); // uncomment when needed
        PrintWriter out = response.getWriter();
        response.setContentType("text/html;charset=UTF-8");

        String xQuantity = request.getParameter("quantity");
        String xProductID = request.getParameter("productID");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userAccount") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        UserAccount xCurrentUA = (UserAccount) session.getAttribute("userAccount");
        int quantity = Integer.parseInt(xQuantity);
        int productID = Integer.parseInt(xProductID);

        ProductDAO pd = new ProductDAO();
        Product p = pd.getProductByID(productID);
        
        Cart c = new CartDAO().getCartByUserIDAndProductID(xCurrentUA.getUserID(), productID);

        OrderDAO od = new OrderDAO();
        if (quantity  > (pd.getProductByID(productID).getUnitInStock() - c.getQuantity())) {
            request.setAttribute("product", new ProductDAO().getProductByID(productID));
            request.setAttribute("error", "Số lượng hàng quá lớn! Không thể xử lý.");
            request.getRequestDispatcher("productDetail.jsp").forward(request, response);
            return;
        }
        Order o = od.getOrderByUserIDAndProductID(xCurrentUA.getUserID(), productID);
        int sumPrice = (o.getQuantity() + quantity)  * (p.getUnitPrice() * (100 - p.getDiscount()) / 100);

        if (sumPrice >= 1000000) {
            od.insertOrder(new Order(0, xCurrentUA, p, quantity, null, null, 50000));
            od.freeShip(xCurrentUA.getUserID(), p.getProductID());
        } else {
            od.insertOrder(new Order(0, xCurrentUA, p, quantity, null, null, 50000));
        }

        request.setAttribute("listOrder", od.getOrderList(xCurrentUA.getUserID()));
        request.getRequestDispatcher("showOrder.jsp").forward(request, response);
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
