package entities;

import entities.OrderHeader;
import entities.Product;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2025-06-24T00:31:01")
@StaticMetamodel(OrderDetail.class)
public class OrderDetail_ { 

    public static volatile SingularAttribute<OrderDetail, Integer> quantity;
    public static volatile SingularAttribute<OrderDetail, OrderHeader> orderHeaderId;
    public static volatile SingularAttribute<OrderDetail, Product> productId;
    public static volatile SingularAttribute<OrderDetail, Double> price;
    public static volatile SingularAttribute<OrderDetail, Integer> id;

}