/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import entities.Product;
import java.util.List;
import javax.ejb.EJB;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import sessionbeans.ProductFacade;

/**
 *
 * @author uyenm
 */
@Controller

public class HomeController {

    ModelAndView mv = new ModelAndView("layout", "folder", "product");
    @EJB(mappedName = "java:global/FinalProjectJavaEE/ProductFacade")
    private ProductFacade pf;

    @RequestMapping({"", "index"})
    public ModelAndView index(@RequestParam(value = "sort", required = false) String sort) {
        //khai báo tên view
        mv.addObject("view", "index");
        //đọc table product
        List<Product> list;
        if ("priceAsc".equals(sort)) {
            list = pf.findAllOrderByPriceAsc();
        } else if ("priceDesc".equals(sort)) {
            list = pf.findAllOrderByPriceDesc();
        } else {
            list = pf.findAll();
        }
        //truyển list vào
        mv.addObject("list", list);
        return mv;
    }

    @RequestMapping("detail")
    public ModelAndView detail(int id) {
        ModelAndView mv = new ModelAndView("layout", "folder", "product");
        mv.addObject("view", "detail");
        Product p = pf.find(id);
        mv.addObject("laptop", p);
        return mv;
    }

    @RequestMapping("login")
    public ModelAndView login() {
        ModelAndView mav = new ModelAndView("layout","folder","auth");
        mav.addObject("view", "login");
        mav.addObject("isAuthPage", true);
        return mav;
    }

    @RequestMapping("register")
    public ModelAndView register() {
        ModelAndView mav = new ModelAndView("layout","folder", "auth");
        mav.addObject("view", "register");
        mav.addObject("isAuthPage", true);
        return mav;
    }

}
