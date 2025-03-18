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
public class CategoryDAO extends MyDAO {

    public List<Category> getCategoryList() {
        List<Category> l = new ArrayList<Category>();
        xSql = "select * from Categories";
        
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();

            int xCategoryID;
            String xCategoryName;
            String xDescription;
            Category x;

            while (rs.next()) {
                xCategoryID = rs.getInt("CategoryID");
                xCategoryName = rs.getString("CategoryName");
                xDescription = rs.getString("Description");

                x = new Category(xCategoryID, xCategoryName, xDescription);
                l.add(x);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (l);
    }

    public Category getCategoryByID(int CategoryID) {
        String xCategoryName;
        String xDescription;
        Category x = new Category();
        xSql = "select * from Categories where CategoryID = ?";
        
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, CategoryID);
            
            rs = ps.executeQuery();
            if (rs.next()) {
                xCategoryName = rs.getString("CategoryName");
                xDescription = rs.getString("Description");

                x = new Category(CategoryID, xCategoryName, xDescription);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (x);
    }
    
    public void insertCategory(Category x) {
        xSql = "insert into Categories (CategoryID, CategoryName, Description) values (?, ?, ?)";

        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, x.getCategoryID());
            ps.setString(2, x.getCategoryName());
            ps.setString(3, x.getDescription());

            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteCategory(int CategoryID) {
        xSql = "delete from Categories where CategoryID = ?";
        
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, CategoryID);
            
            ps.executeUpdate();
            //con.commit();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateCategory(int CategoryID, Category x) {
        xSql = "update Categories set CategoryName = ?, Description = ? where CategoryID = ?";
        
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, x.getCategoryName());
            ps.setString(2, x.getDescription());
            
            ps.setInt(3, x.getCategoryID());
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
