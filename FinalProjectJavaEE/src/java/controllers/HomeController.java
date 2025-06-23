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
    public ModelAndView index(
            @RequestParam(value = "sort", required = false) String sort,
            @RequestParam(value = "page", required = false, defaultValue = "1") int page,
            @RequestParam(value = "size", required = false, defaultValue = "6") int size,
            @RequestParam(value = "keyword", required = false) String keyword) {
        //khai báo tên view

        mv.addObject("view", "index");

        List<Product> list;

        if (keyword != null && !keyword.trim().isEmpty()) {
            list = pf.searchByNameOrCategory(keyword);
            if ("priceAsc".equals(sort)) {
                list.sort((a, b) -> Double.compare(a.getPrice(), b.getPrice()));
            } else if ("priceDesc".equals(sort)) {
                list.sort((a, b) -> Double.compare(b.getPrice(), a.getPrice()));
            }
        } else {
            if ("priceAsc".equals(sort)) {
                list = pf.findAllOrderByPriceAsc();
            } else if ("priceDesc".equals(sort)) {
                list = pf.findAllOrderByPriceDesc();
            } else {
                list = pf.findAll();
            }
        }

        int totalItems = list.size();//tính tổng số dòng
        int totalPages = (int) Math.ceil((double) totalItems / size);

        int fromIndex = (page - 1) * size;
        int toIndex = Math.min(fromIndex + size, totalItems);
        List<Product> paginatedList = list.subList(fromIndex, toIndex);

        mv.addObject("list", paginatedList);
        mv.addObject("currentPage", page);
        mv.addObject("totalPages", totalPages);
        mv.addObject("sort", sort);
        mv.addObject("keyword", keyword);

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
}
