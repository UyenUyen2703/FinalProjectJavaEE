/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

/**
 *
 * @author uyenm
 */
import entities.Cart;
import entities.Product;
import sessionbeans.ProductFacade;
import javax.ejb.EJB;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CartController {

    @EJB(mappedName = "java:global/FinalProjectJavaEE/ProductFacade")
    private ProductFacade pf;

    @ModelAttribute("cart")
    public Cart createCart(HttpSession session) {
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    @RequestMapping("/add")
    public String addToCart(@RequestParam int id, @RequestParam(defaultValue = "1") int quantity,
            @ModelAttribute("cart") Cart cart) {
        Product p = pf.find(id);
        if (p != null) {
            cart.addItem(p, quantity);
        }
        return "redirect:/index";
    }

//    @RequestMapping("/add")
//    public ModelAndView addToCart(@RequestParam int id, @RequestParam(defaultValue = "1") int quantity,
//            @ModelAttribute("cart") Cart cart) {
//        Product p = pf.find(id);
//        if (p != null) {
//            cart.addItem(p, quantity);
//        }
//
//        ModelAndView mv = new ModelAndView("layout", "folder", "product");
//        mv.addObject("products", pf.findAll());
//        mv.addObject("totalItems", cart.getTotalQuantity());
//        mv.addObject("view", "index");
//        return mv;
//    }
    @RequestMapping("/view-cart")
    public ModelAndView viewCart(@ModelAttribute("cart") Cart cart) {
        ModelAndView mv = new ModelAndView("layout", "folder", "cart");
        mv.addObject("view", "index");
        mv.addObject("items", cart.getItems());
        mv.addObject("total", cart.getTotal());
        return mv;
    }

    @RequestMapping("/update")
    public ModelAndView updateItem(@RequestParam int id, @RequestParam int quantity,
            @ModelAttribute("cart") Cart cart) {
        cart.updateItem(id, quantity);
        ModelAndView mv = new ModelAndView("layout", "folder", "cart");
        mv.addObject("view", "index");
        mv.addObject("items", cart.getItems());
        mv.addObject("total", cart.getTotal());
        return mv;
    }

    @RequestMapping("/remove")
    public ModelAndView removeItem(@RequestParam int id, @ModelAttribute("cart") Cart cart) {
        cart.removeItem(id);
        ModelAndView mv = new ModelAndView("layout", "folder", "cart");
        mv.addObject("view", "index");
        mv.addObject("items", cart.getItems());
        mv.addObject("total", cart.getTotal());
        return mv;
    }

    @RequestMapping("/checkout")
    public String checkout(@ModelAttribute("cart") Cart cart, HttpSession session) {
        Object user = session.getAttribute("account");
        if (user == null) {
            return "redirect:/login";
        }

        cart.clear();
        return "redirect:/success";
    }

    @RequestMapping("/success")
    public ModelAndView success() {
        return new ModelAndView("layout", "folder", "cart")
                .addObject("view", "successful");
    }
}
