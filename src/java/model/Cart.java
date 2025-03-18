package model;

public class Cart {
    private UserAccount userID;
    private int cartID;
    private Product productID;
    private int quantity;

    public Cart() {
    }

    public Cart(UserAccount userID, int cartID, Product productID, int quantity) {
        this.userID = userID;
        this.cartID = cartID;
        this.productID = productID;
        this.quantity = quantity;
    }

    public UserAccount getUserID() {
        return userID;
    }

    public int getCartID() {
        return cartID;
    }

    public Product getProductID() {
        return productID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setUserID(UserAccount userID) {
        this.userID = userID;
    }

    public void setCartID(int cartID) {
        this.cartID = cartID;
    }

    public void setProductID(Product productID) {
        this.productID = productID;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    
}
