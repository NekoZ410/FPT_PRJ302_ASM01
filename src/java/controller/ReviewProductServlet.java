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

/**
 *
 * @author ASUS
 */
public class ReviewProductServlet extends HttpServlet {

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
            out.println("<title>Servlet ReviewProduct</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReviewProduct at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        String xProductID = request.getParameter("productID");
        int productID = Integer.parseInt(xProductID);
        if (request.getParameter("rating") == null) {
            
            request.setAttribute("error", "Bạn chưa đánh giá sản phẩm!");
            request.setAttribute("productID", new ProductDAO().getProductByID(productID));
            request.getRequestDispatcher("reviewProduct.jsp").forward(request, response);
        }
        String xRating = request.getParameter("rating");

        int rating = Integer.parseInt(xRating);

        String xComment;
        if (request.getParameter("comment") == null) {
            xComment = null;
        } else {
            xComment = request.getParameter("comment");
        }

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userAccount") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        UserAccount ua = (UserAccount) session.getAttribute("userAccount");

        Review r = new Review(new ProductDAO().getProductByID(productID), 0, ua, rating, xComment, null);
        new ReviewDAO().insertReview(r);
        
        request.setAttribute("product", new ProductDAO().getProductByID(productID));
        request.getRequestDispatcher("productDetail.jsp").forward(request, response);
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
