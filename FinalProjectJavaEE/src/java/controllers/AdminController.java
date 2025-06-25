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
import entities.Category;
import entities.Product;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import sessionbeans.CategoryFacade;
import sessionbeans.ProductFacade;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @EJB(mappedName = "java:global/FinalProjectJavaEE/ProductFacade")
    private ProductFacade productFacade;

    @EJB(mappedName = "java:global/FinalProjectJavaEE/CategoryFacade")
    private CategoryFacade categoryFacade;

    // Danh sách sản phẩm
    @RequestMapping("")
    public ModelAndView index() {
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("folder", "admin");
        mv.addObject("view", "index");
        List<Product> list = productFacade.findAll();
        mv.addObject("list", list);
        return mv;
    }

    // Form thêm sản phẩm
    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public ModelAndView createForm() {
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("folder", "admin");
        mv.addObject("view", "create");
        mv.addObject("categories", categoryFacade.findAll());
        return mv;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String createProduct(
            @RequestParam("name") String name,
            @RequestParam("price") double price,
            @RequestParam("quantity") int quantity,
            @RequestParam("categoryId") int categoryId,
            @RequestParam("image") MultipartFile image,
            HttpServletRequest request) throws IOException {

        try {
            Product product = new Product();
            product.setName(name);
            product.setPrice(price);

            Category category = categoryFacade.find(categoryId);
            if (category != null) {
                product.setCategoryId(category);
            }

            productFacade.create(product);

            if (image != null && !image.isEmpty()) {
                String fileName = product.getName() + ".jpg";
                ServletContext context = request.getServletContext();
                String uploadPath = context.getRealPath("/WEB-INF/images/");

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                Path filePath = Paths.get(uploadPath, fileName);
                Files.write(filePath, image.getBytes());
            }

            return "redirect:/admin";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }

    }

    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public ModelAndView editForm(@RequestParam("id") int id) {
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("folder", "admin");
        mv.addObject("view", "update"); // File JSP là update.jsp
        Product product = productFacade.find(id);
        List<Category> categories = categoryFacade.findAll();

        mv.addObject("product", product);
        mv.addObject("categories", categories);
        return mv;
    }

    @RequestMapping(value = "/edit", method = RequestMethod.POST)
public String editProduct(
        @RequestParam("id") int id,
        @RequestParam("name") String name,
        @RequestParam("price") double price,
        @RequestParam("quantity") int quantity,
        @RequestParam("categoryId") int categoryId,
        @RequestParam(value = "image", required = false) MultipartFile image, // nhận ảnh nếu có
        HttpServletRequest request
) {
    try {
        Product product = productFacade.find(id);
        if (product == null) {
            return "redirect:/admin";
        }

        product.setName(name);
        product.setPrice(price);
        product.setQuantity(quantity);

        Category category = categoryFacade.find(categoryId);
        if (category != null) {
            product.setCategoryId(category);
        }

        // Cập nhật ảnh nếu có ảnh mới
        if (image != null && !image.isEmpty()) {
            String fileName = product.getName() + ".jpg";
            ServletContext context = request.getServletContext();
            String uploadPath = context.getRealPath("/WEB-INF/images/");

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            Path filePath = Paths.get(uploadPath, fileName);
            Files.write(filePath, image.getBytes());
        }

        productFacade.edit(product);
        return "redirect:/admin";
    } catch (Exception e) {
        e.printStackTrace();
        return "error";
    }
}


    @RequestMapping("/delete")
    public String deleteProduct(@RequestParam("id") int id) {
        Product product = productFacade.find(id);
        if (product != null) {
            productFacade.remove(product);
        }
        return "redirect:/admin";
    }
}
