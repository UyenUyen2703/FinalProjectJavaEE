/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessionbeans;

import entities.Product;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author uyenm
 */
@Stateless
public class ProductFacade extends AbstractFacade<Product> {

    @PersistenceContext(unitName = "FinalProjectJavaEEPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ProductFacade() {
        super(Product.class);
    }

    public List<Product> findAllOrderByPriceAsc() {
        return em.createQuery("SELECT p FROM Product p ORDER BY p.price ASC", Product.class)
                .getResultList();
    }

    public List<Product> findAllOrderByPriceDesc() {
        return em.createQuery("SELECT p FROM Product p ORDER BY p.price DESC", Product.class)
                .getResultList();
    }

    public List<Product> searchByNameOrCategory(String keyword) {
        return em.createQuery(
                "SELECT p FROM Product p WHERE LOWER(p.name) LIKE :kw OR LOWER(p.categoryId.name) LIKE :kw",
                Product.class
        )
                .setParameter("kw", "%" + keyword.toLowerCase() + "%")
                .getResultList();
    }

}
