package com.ecommerce.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * Authentication Filter — redirects unauthenticated users to login page.
 * Applied to all protected routes.
 */
@WebFilter(urlPatterns = {"/admin/*", "/customer/*", "/cart", "/cart/*", "/order/*"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest  request  = (HttpServletRequest)  req;
        HttpServletResponse response = (HttpServletResponse) res;

        HttpSession session = request.getSession(false);
        boolean loggedIn    = (session != null && session.getAttribute("user") != null);

        if (!loggedIn) {
            response.sendRedirect(request.getContextPath() + "/login?error=Please+login+first");
            return;
        }
        chain.doFilter(req, res);
    }
}
