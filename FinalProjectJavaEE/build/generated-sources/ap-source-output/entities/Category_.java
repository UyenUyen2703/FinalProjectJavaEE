package entities;

import entities.Product;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

<<<<<<< HEAD
@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2025-06-17T13:31:17")
=======
@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2025-06-23T15:35:39")
>>>>>>> 07cf3e193bc98572b835fc60a7fb0d00620a0ee2
@StaticMetamodel(Category.class)
public class Category_ { 

    public static volatile SingularAttribute<Category, String> name;
    public static volatile SingularAttribute<Category, Integer> id;
    public static volatile ListAttribute<Category, Product> productList;

}