/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessionbeans;

import entities.OrderHeader;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

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

    
}
