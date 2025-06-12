package entities;

import entities.Customer;
import entities.OrderDetail;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2025-06-12T22:35:37")
@StaticMetamodel(OrderHeader.class)
public class OrderHeader_ { 

    public static volatile SingularAttribute<OrderHeader, Date> date;
    public static volatile ListAttribute<OrderHeader, OrderDetail> orderDetailList;
    public static volatile SingularAttribute<OrderHeader, Customer> customerId;
    public static volatile SingularAttribute<OrderHeader, Integer> id;
    public static volatile SingularAttribute<OrderHeader, String> status;

}