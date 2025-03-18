/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Product {

    // attributes / fields
    private int productID;
    private String productName;
    private Category categoryID;
    private int unitInStock;
    private int unitPrice;
    private int discount;
    private String images;
    
    // constructor
    public Product() {
    }

    public Product(int productID, String productName, Category categoryID, int unitInStock, int unitPrice, int discount, String images) {
        this.productID = productID;
        this.productName = productName;
        this.categoryID = categoryID;
        this.unitInStock = unitInStock;
        this.unitPrice = unitPrice;
        this.discount = discount;
        this.images = images;
    }

    // getters
    public int getProductID() {
        return productID;
    }

    public String getProductName() {
        return productName;
    }

    public Category getCategoryID() {
        return categoryID;
    }

    public int getUnitInStock() {
        return unitInStock;
    }

    public int getUnitPrice() {
        return unitPrice;
    }

    public String getImages() {
        return images;
    }

    public int getDiscount() {
        return discount;
    }
    
    // setters
    public void setProductID(int productID) {
        this.productID = productID;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public void setCategoryID(Category categoryID) {
        this.categoryID = categoryID;
    }

    public void setUnitInStock(int unitInStock) {
        this.unitInStock = unitInStock;
    }

    public void setUnitPrice(int unitPrice) {
        this.unitPrice = unitPrice;
    }
    
    public void setImages(String images) {
        this.images = images;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }
    
        // others
}
