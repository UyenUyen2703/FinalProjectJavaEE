package controllers;

import entities.Account;
import entities.Cart;
import entities.Customer;
import entities.OrderDetail;
import entities.OrderHeader;
import entities.Product;
import java.net.URLEncoder;
import models.CartItem;
import sessionbeans.CustomerFacade;
import sessionbeans.OrderDetailFacade;
import sessionbeans.OrderHeaderFacade;
import sessionbeans.ProductFacade;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.ejb.EJB;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CartController {

    private static final Logger LOGGER = Logger.getLogger(CartController.class.getName());

    @EJB(mappedName = "java:global/FinalProjectJavaEE/ProductFacade")
    private ProductFacade pf;

    @EJB(mappedName = "java:global/FinalProjectJavaEE/CustomerFacade")
    private CustomerFacade cf;

    @EJB(mappedName = "java:global/FinalProjectJavaEE/OrderHeaderFacade")
    private OrderHeaderFacade ohf;

    @EJB(mappedName = "java:global/FinalProjectJavaEE/OrderDetailFacade")
    private OrderDetailFacade odf;

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
        try {
            Product p = pf.find(id);
            if (p != null) {
                cart.addItem(p, quantity);
                LOGGER.info("Added product " + p.getName() + " to cart");
            } else {
                LOGGER.warning("Product with id " + id + " not found");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error adding product to cart", e);
        }
        return "redirect:/index";
    }

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
    }@RequestMapping("/checkout")
public String checkout(@ModelAttribute("cart") Cart cart, HttpSession session) {
    Account account = (Account) session.getAttribute("account");
    if (account == null) return "redirect:/login";

    if (cart.getItems().isEmpty()) return "redirect:/view-cart?error=empty_cart";

    try {
        Customer customer = findOrCreateCustomer(account);

        OrderHeader orderHeader = new OrderHeader();
        orderHeader.setDate(new Date());
        orderHeader.setStatus("New");
        orderHeader.setCustomerId(customer);

        List<OrderDetail> details = new ArrayList<>();
        for (CartItem item : cart.getItems()) {
            Product product = pf.find(item.getProduct().getId());
            if (product == null) throw new RuntimeException("Product not found");

            OrderDetail detail = new OrderDetail();
            detail.setOrderHeaderId(orderHeader);
            detail.setProductId(product);
            detail.setQuantity(item.getQuantity());
            detail.setPrice(product.getPrice());
            details.add(detail);
        }

        orderHeader.setOrderDetailList(details);

        ohf.createAndFlush(orderHeader);

        session.setAttribute("lastOrderId", orderHeader.getId());
        cart.clear();
        return "redirect:/success";

    } catch (Exception e) {
        LOGGER.log(Level.SEVERE, "Checkout failed", e);
        String errorMsg = (e.getMessage() != null) ? e.getMessage()
                : (e.getCause() != null) ? e.getCause().toString() : "Unknown error";
        try {
            return "redirect:/view-cart?error=checkout_failed&message=" + URLEncoder.encode(errorMsg, "UTF-8");
        } catch (Exception ex) {
            return "redirect:/view-cart?error=checkout_failed&message=encode_error";
        }
    }
}




    private Customer findOrCreateCustomer(Account account) {
        try {
            LOGGER.info("Looking for customer with email: " + account.getEmail());
            Customer customer = cf.findByEmail(account.getEmail());

            if (customer == null) {
                LOGGER.info("Customer not found, creating new one");

                customer = new Customer();
                customer.setName(account.getUsername());
                customer.setEmail(account.getEmail());
                customer.setPhone("");
                customer.setAddress("");
                customer.setShipToAddress("");

                cf.create(customer);
            } else {
                LOGGER.info("Existing customer found with ID: " + customer.getId());
            }

            return customer;

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error finding or creating customer", e);
            throw new RuntimeException("Failed to find or create customer", e);
        }
    }

    @RequestMapping("/success")
    public ModelAndView success(HttpSession session) {
        Integer orderId = (Integer) session.getAttribute("lastOrderId");
        ModelAndView mv = new ModelAndView("layout", "folder", "cart");
        mv.addObject("view", "successful");
        if (orderId != null) {
            mv.addObject("orderId", orderId);
            session.removeAttribute("lastOrderId");
        }
        return mv;
    }
}
