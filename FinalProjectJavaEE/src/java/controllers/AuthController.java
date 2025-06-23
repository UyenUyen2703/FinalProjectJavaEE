/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import entities.Account;
import entities.Product;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.http.HttpSession;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import sessionbeans.AccountFacade;

/**
 *
 * @author uyenm
 */
@Controller
public class AuthController {

    ModelAndView mv = new ModelAndView("layout", "folder", "auth");
    @EJB(mappedName = "java:global/FinalProjectJavaEE/AccountFacade")
    private AccountFacade af;

    private ModelAndView getAuthErrorView(String page, String errorMessage) {
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("folder", "auth");
        mv.addObject("view", page);
        mv.addObject("isAuthPage", true);
        mv.addObject("error", errorMessage);
        return mv;
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView showLoginForm() {
        ModelAndView mav = new ModelAndView("layout", "folder", "auth");
        mav.addObject("view", "login");
        mav.addObject("isAuthPage", true);
        return mav;
    }

    @RequestMapping("/login")
    public ModelAndView login(
            @RequestParam String email,
            @RequestParam String password,
            HttpSession session) {
        Account account = af.findByEmailAndPassword(email, password);
        ModelAndView mv = new ModelAndView();

        if (account == null) {
            mv.setViewName("login");
            mv.addObject("error", "Invalid email or password");
            System.out.println("controllers.AuthController.login()");
            return mv;
        }
        session.setAttribute("account", account);
        if (email.endsWith("@admin.com")) {
            session.setAttribute("role", "admin");
            mv.addObject("folder", "admin");
            mv.addObject("view", "index");
            mv.setViewName("layout");
        } else if (email.endsWith("@gmail.com")) {
            session.setAttribute("role", "user");
            mv.setViewName("redirect:/index");
        } else {
            mv.setViewName("login");
            mv.addObject("error", "Email domain not supported");
        }
        return mv;
    }

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public ModelAndView showRegisterForm() {
        ModelAndView mav = new ModelAndView("layout", "folder", "auth");
        mav.addObject("view", "register");
        mav.addObject("isAuthPage", true);
        return mav;
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public ModelAndView register(
            @RequestParam String username,
            @RequestParam String email,
            @RequestParam String password,
            @RequestParam String confirmPassword) {

        ModelAndView mv = new ModelAndView("layout", "folder", "auth");

        try {
            // Kiểm tra xác nhận mật khẩu
            if (!password.equals(confirmPassword)) {
                return getAuthErrorView("register", "Mật khẩu xác nhận không khớp.");
            }
            // Kiểm tra trùng tên đăng nhập
            if (af.findByUsername(username) != null) {
                return getAuthErrorView("register", "Tên đăng nhập đã tồn tại.");
            }
            // Kiểm tra trùng email
            if (af.findByEmail(email) != null) {
                return getAuthErrorView("register", "Email đã được sử dụng.");
            }
            Account acc = new Account();
            acc.setUsername(username);
            acc.setEmail(email);
            acc.setPassword(password);

            if (email.endsWith("@admin.com")) {
                acc.setRole("admin");
            } else {
                acc.setRole("user");
            }

            af.create(acc);
            mv.addObject("message", "Register successful!");
            mv.setViewName("redirect:/login");

        } catch (ConstraintViolationException ex) {
            for (ConstraintViolation<?> v : ex.getConstraintViolations()) {
                System.out.println("Field: " + v.getPropertyPath() + ", Message: " + v.getMessage());
            }
            mv.addObject("error", "Register failed due to invalid input.");
            mv.addObject("view", "register");
        } catch (Exception e) {
            e.printStackTrace();
            mv.addObject("error", "An unexpected error occurred.");
            mv.addObject("view", "register");
        }
        return mv;
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

}
