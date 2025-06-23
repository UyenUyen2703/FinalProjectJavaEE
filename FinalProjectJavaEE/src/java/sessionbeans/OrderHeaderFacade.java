/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessionbeans;

import entities.Customer;
import entities.OrderHeader;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

/**
 *
 * @author uyenm
 */
@Stateless
public class OrderHeaderFacade extends AbstractFacade<OrderHeader> {

    @PersistenceContext(unitName = "FinalProjectJavaEEPU")
    private EntityManager em;

    @Override
    public EntityManager getEntityManager() {
        return em;
    }

    public OrderHeaderFacade() {
        super(OrderHeader.class);
    }

    public void createAndFlush(OrderHeader orderHeader) {
        create(orderHeader); // gọi phương thức create sẵn có
        getEntityManager().flush(); // đảm bảo sinh ID
    }

    public List<OrderHeader> findByCustomer(Customer customer) {
        TypedQuery<OrderHeader> query = em.createQuery(
            "SELECT o FROM OrderHeader o WHERE o.customerId = :customer ORDER BY o.date DESC",
            OrderHeader.class
        );
        query.setParameter("customer", customer);
        return query.getResultList();
    }

}
