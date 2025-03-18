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
import java.util.ArrayList;
import java.util.List;
import model.*;

/**
 *
 * @author Admin
 */
public class SearchPriceServlet extends HttpServlet {

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
            out.println("<title>Servlet SearchPriceServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchPriceServlet at " + request.getContextPath() + "</h1>");
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

        String xPriceValue = request.getParameter("price-box");
        if (xPriceValue == null) {
            request.setAttribute("err", "Hãy chọn mức giá!");
            request.getRequestDispatcher("searchPrice.jsp").forward(request, response);
        }
//        out.print(xPriceValue);
//        request.getRequestDispatcher("searchPrice.jsp").include(request, response);
//        return;
        int priceValue = Integer.parseInt(xPriceValue);

        ProductDAO pd = new ProductDAO();
        List<Product> lp = pd.getAllProducts();

        List<Product> result = new ArrayList<Product>();
        String chosenPrice = "";
        switch (priceValue) {
            case 1:
                for (Product p : lp) {
                    if (((p.getUnitPrice() * (100 - p.getDiscount())) / 100) <= 500000) {
                        result.add(p);
                    }
                }
                chosenPrice = "Dưới 500.000₫";
                break;
                
            case 2:
                for (Product p : lp) {
                    if (((p.getUnitPrice() * (100 - p.getDiscount())) / 100) > 500000 && ((p.getUnitPrice() * (100 - p.getDiscount())) / 100) <= 750000) {
                        result.add(p);
                    }
                }
                chosenPrice = "500.000₫ - 750.000₫";
                break;
                
            case 3:
                for (Product p : lp) {
                    if (((p.getUnitPrice() * (100 - p.getDiscount())) / 100) > 750000 && ((p.getUnitPrice() * (100 - p.getDiscount())) / 100) <= 1000000) {
                        result.add(p);
                    }
                }
                chosenPrice = "750.000₫ - 1.000.000₫";                
                break;
                
            default:
                for (Product p : lp) {
                    if (((p.getUnitPrice() * (100 - p.getDiscount())) / 100) > 1000000) {
                        result.add(p);
                    }
                }
                chosenPrice = "Trên 1.000.000₫"; 
        }
        
        request.setAttribute("chosenPrice", chosenPrice);
        request.setAttribute("listProduct", result);
        request.getRequestDispatcher("searchPrice.jsp").forward(request, response);
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
