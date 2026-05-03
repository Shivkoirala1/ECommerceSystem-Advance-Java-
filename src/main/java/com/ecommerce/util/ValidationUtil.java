package com.ecommerce.util;

public class ValidationUtil {

    public static boolean isValidEmail(String email) {
        return email != null && email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$");
    }

    public static boolean isValidPhone(String phone) {
        return phone != null && phone.matches("^[0-9]{10}$");
    }

    public static boolean isValidName(String name) {
        return name != null && !name.trim().isEmpty() && name.matches("^[a-zA-Z\\s]+$");
    }

    public static boolean isValidPassword(String password) {
        return password != null && password.matches("^(?=.*[A-Z])(?=.*\\d).{6,}$");
    }

    public static boolean isValidUsername(String username) {
        return username != null && username.matches("^[a-zA-Z0-9_]{4,20}$");
    }

    public static boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }
}
