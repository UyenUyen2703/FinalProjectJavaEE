package entities;

import entities.Category;
import entities.OrderDetail;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

<<<<<<< HEAD
@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2025-06-17T13:31:17")
=======
@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2025-06-23T15:35:39")
>>>>>>> 07cf3e193bc98572b835fc60a7fb0d00620a0ee2
@StaticMetamodel(Product.class)
public class Product_ { 

    public static volatile ListAttribute<Product, OrderDetail> orderDetailList;
    public static volatile SingularAttribute<Product, Double> quantity;
    public static volatile SingularAttribute<Product, Double> price;
    public static volatile SingularAttribute<Product, String> name;
    public static volatile SingularAttribute<Product, Integer> id;
    public static volatile SingularAttribute<Product, Category> categoryId;

}