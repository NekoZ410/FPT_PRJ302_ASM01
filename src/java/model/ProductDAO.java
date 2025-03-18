/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.*;

/**
 *
 * @author Admin
 */
public class ProductDAO extends MyDAO {

    public List<Product> getAllProducts() {
        List<Product> l = new ArrayList<Product>();
        xSql = "select * from Products";

        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();

            int xProductID;
            String xProductName;
            Category xCategoryID;
            int xUnitInStock;
            int xUnitPrice;
            int xDiscount;
            String xImages;
            Product x;

            while (rs.next()) {
                xProductID = rs.getInt("ProductID");
                xProductName = rs.getString("ProductName");
                CategoryDAO cd = new CategoryDAO();
                xCategoryID = cd.getCategoryByID(rs.getInt("CategoryID"));
                xUnitPrice = rs.getInt("UnitPrice");
                xUnitInStock = rs.getInt("UnitsInStock");
                xDiscount = rs.getInt("Discount");
                xImages = rs.getString("Images");

                x = new Product(xProductID, xProductName, xCategoryID, xUnitInStock, xUnitPrice, xDiscount, xImages);
                l.add(x);
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (l);
    }

    public List<Product> getProductListByCategoryID(int categoryID) {
        List<Product> l = new ArrayList<Product>();
        xSql = "select * from Products where CategoryID = ?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, categoryID);
            rs = ps.executeQuery();

            int xProductID;
            String xProductName;
            CategoryDAO cd = new CategoryDAO();
            Category xCategoryID = cd.getCategoryByID(categoryID);
            int xUnitInStock;
            int xUnitPrice;
            int xDiscount;
            String xImages;
            Product x;

            while (rs.next()) {
                xProductID = rs.getInt("ProductID");
                xProductName = rs.getString("ProductName");
                xUnitInStock = rs.getInt("UnitsInStock");
                xUnitPrice = rs.getInt("UnitPrice");
                xDiscount = rs.getInt("Discount");
                xImages = rs.getString("Images");

                x = new Product(xProductID, xProductName, xCategoryID, xUnitInStock, xUnitPrice, xDiscount, xImages);
                l.add(x);
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (l);
    }

    public Product getProductByID(int productID) {
        String xProductName;
        Category xCategoryID;
        int xUnitInStock;
        int xUnitPrice;
        int xDiscount;
        String xImages;
        Product x = new Product();
        xSql = "select * from Products where ProductID = ?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, productID);
            rs = ps.executeQuery();
            if (rs.next()) {
                xProductName = rs.getString("ProductName");
                CategoryDAO cd = new CategoryDAO();
                xCategoryID = cd.getCategoryByID(rs.getInt("CategoryID"));
                xUnitInStock = rs.getInt("UnitsInStock");
                xUnitPrice = rs.getInt("UnitPrice");
                xDiscount = rs.getInt("Discount");
                xImages = rs.getString("Images");

                x = new Product(productID, xProductName, xCategoryID, xUnitInStock, xUnitPrice, xDiscount, xImages);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (x);
    }

    public List<Product> getProductByName(String productName) {
        List<Product> l = new ArrayList<>();
        xSql = "select * from Products where ProductName like ?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, "%" + productName + "%");
            rs = ps.executeQuery();

            int xProductID;
            Category xCategoryID;
            String xProductName;
            int xUnitInStock;
            int xUnitPrice;
            int xDiscount;
            String xImages;
            Product x;
            CategoryDAO cd = new CategoryDAO();
            while (rs.next()) {
                xProductID = rs.getInt("ProductID");
                xProductName = rs.getString("ProductName");
                xCategoryID = cd.getCategoryByID(rs.getInt("CategoryID"));
                xUnitInStock = rs.getInt("UnitsInStock");
                xUnitPrice = rs.getInt("UnitPrice");
                xDiscount = rs.getInt("Discount");
                xImages = rs.getString("Images");

                x = new Product(xProductID, xProductName, xCategoryID, xUnitInStock, xUnitPrice, xDiscount, xImages);
                l.add(x);
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (l);
    }

    public List<Product> getProductByNameCategoryID(int categoryID, String productName) {
        List<Product> l = new ArrayList<>();
        xSql = "select * from Products where CategoryID = " + categoryID + " and ProductName like ?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, "%" + productName + "%");

            rs = ps.executeQuery();

            int xProductID;
            Category xCategoryID;
            String xProductName;
            int xUnitInStock;
            int xUnitPrice;
            int xDiscount;
            String xImages;
            Product x;

            while (rs.next()) {
                xProductID = rs.getInt("ProductID");
                xProductName = rs.getString("ProductName");
                CategoryDAO cd = new CategoryDAO();
                xCategoryID = cd.getCategoryByID(categoryID);
                xUnitInStock = rs.getInt("UnitsInStock");
                xUnitPrice = rs.getInt("UnitPrice");
                xDiscount = rs.getInt("Discount");
                xImages = rs.getString("Images");

                x = new Product(xProductID, xProductName, xCategoryID, xUnitInStock, xUnitPrice, xDiscount, xImages);
                l.add(x);
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (l);
    }

    public List<Product> getProductDiscount(int discount) {
        List<Product> l = new ArrayList<>();
        if (discount < 0) {
            xSql = "select * from Products where NOT(Discount = 0)";
        } else {
            xSql = "select * from Products where Discount = "+ discount;
        }
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();

            int xProductID;
            Category xCategoryID;
            String xProductName;
            int xUnitInStock;
            int xUnitPrice;
            int xDiscount;
            String xImages;
            Product x;

            while (rs.next()) {
                xProductID = rs.getInt("ProductID");
                xProductName = rs.getString("ProductName");
                CategoryDAO cd = new CategoryDAO();
                xCategoryID = cd.getCategoryByID(rs.getInt("CategoryID"));
                xUnitInStock = rs.getInt("UnitsInStock");
                xUnitPrice = rs.getInt("UnitPrice");
                xDiscount = rs.getInt("Discount");
                xImages = rs.getString("Images");

                x = new Product(xProductID, xProductName, xCategoryID, xUnitInStock, xUnitPrice, xDiscount, xImages);
                l.add(x);
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (l);
    }
    
    public List<Product> ListHotProduct(int categoryID) {
        List<Product> lh = new ArrayList<>();
     
            xSql = "select * from Products where (UnitPrice*(100 - Discount)) / 100 < 800000 and CategoryID = ? ";
        
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, categoryID);
            rs = ps.executeQuery();
            int xProductID;
            Category xCategoryID;
            String xProductName;
            int xUnitInStock;
            int xUnitPrice;
            int xDiscount;
            String xImages;
            Product x;

            while (rs.next()) {
                xProductID = rs.getInt("ProductID");
                xProductName = rs.getString("ProductName");
                
                CategoryDAO cd = new CategoryDAO();
                
                xCategoryID = cd.getCategoryByID(rs.getInt("CategoryID"));
                xUnitInStock = rs.getInt("UnitsInStock");
                xUnitPrice = rs.getInt("UnitPrice");
                xDiscount = rs.getInt("Discount");
                xImages = rs.getString("Images");

                x = new Product(xProductID, xProductName, xCategoryID, xUnitInStock, xUnitPrice, xDiscount, xImages);
                lh.add(x);
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (lh);
    }
    
    public List<Product> BestSeller() {
        List<Product> list = new ArrayList<>();

        xSql = "SELECT TOP 10 \n"
                + "    p.ProductID,\n"
                + "    p.ProductName,\n"
                + "    SUM(pr.Quantity) AS TotalSold\n"
                + "FROM \n"
                + "    Products p\n"
                + "JOIN \n"
                + "    Purchased pr ON p.ProductID = pr.ProductID\n"
                + "GROUP BY \n"
                + "    p.ProductID, p.ProductName";
        try {
            ps = con.prepareStatement(xSql);

            rs = ps.executeQuery();
            int xProductID;
            String xProductName;
            Product x;
            ProductDAO pd = new ProductDAO();
            while (rs.next()) {
                xProductID = rs.getInt("ProductID");
                x = pd.getProductByID(xProductID);
                xProductName= rs.getString("ProductName");
                list.add(x);
            }

            rs.close();
            ps.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void insertProduct(Product x) {
        xSql = "insert into Products (ProductID, ProductName, CategoryID, UnitsInStock, UnitPrice, Discount, Images) values (?, ?, ?, ?, ?, ?, ?)";

        int categoryID = x.getCategoryID().getCategoryID();

        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, x.getProductID());
            ps.setString(2, x.getProductName());
            ps.setInt(3, categoryID);
            ps.setInt(4, x.getUnitInStock());
            ps.setInt(5, x.getUnitPrice());
            ps.setInt(6, x.getDiscount());
            ps.setString(7, x.getImages());

            ps.executeUpdate();

            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteProduct(int ProductID) {
        xSql = "delete from Products where ProductID = ?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, ProductID);
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateProduct(Product x) {
        xSql = "update Products set UnitsInStock = ?, UnitPrice = ?, Discount = ? where ProductID = ?";

        int categoryID = x.getCategoryID().getCategoryID();

        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, x.getUnitInStock());
            ps.setInt(2, x.getUnitPrice());
            ps.setInt(3, x.getDiscount());

            ps.setInt(4, x.getProductID());
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
