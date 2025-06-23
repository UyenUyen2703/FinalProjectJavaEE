package sessionbeans;

import entities.Customer;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;

@Stateless
public class CustomerFacade extends AbstractFacade<Customer> {
    
    private static final Logger LOGGER = Logger.getLogger(CustomerFacade.class.getName());

    @PersistenceContext(unitName = "FinalProjectJavaEEPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CustomerFacade() {
        super(Customer.class);
    }
    
    public Customer findByEmail(String email) {
        try {
            LOGGER.info("Searching for customer with email: " + email);
            return em.createQuery("SELECT c FROM Customer c WHERE c.email = :email", Customer.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NoResultException e) {
            LOGGER.info("No customer found with email: " + email);
            return null;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error finding customer by email: " + email, e);
            LOGGER.log(Level.SEVERE, "Database error in findByEmail: " + e.getClass().getName() + " - " + e.getMessage(), e);
throw new RuntimeException("Failed to find customer: " + e.getClass().getSimpleName() + " - " + e.getMessage(), e);

        }
    }
    public void createAndFlush(Customer customer) {
    create(customer);
    getEntityManager().flush();
}

    
    @Override
    public void create(Customer entity) {
        try {
            LOGGER.info("Creating new customer: " + entity.getEmail());
            
            // Validate required fields
            if (entity.getName() == null || entity.getName().trim().isEmpty()) {
                throw new IllegalArgumentException("Customer name cannot be null or empty");
            }
            if (entity.getEmail() == null || entity.getEmail().trim().isEmpty()) {
                throw new IllegalArgumentException("Customer email cannot be null or empty");
            }
            
            // Set default values for optional fields
            if (entity.getPhone() == null) {
                entity.setPhone("");
            }
            if (entity.getAddress() == null) {
                entity.setAddress("");
            }
            if (entity.getShipToAddress() == null) {
                entity.setShipToAddress("");
            }
            
            super.create(entity);
            LOGGER.info("Customer created successfully with ID: " + entity.getId());
            
        } catch (PersistenceException e) {
            LOGGER.log(Level.SEVERE, "Persistence error creating customer", e);
            
            // Check for specific constraint violations
            if (e.getMessage().contains("Duplicate entry") || 
                e.getMessage().contains("UNIQUE constraint")) {
                throw new RuntimeException("Customer with this email already exists", e);
            }
            
            throw new RuntimeException("Failed to create customer due to database error", e);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error creating customer", e);
            throw new RuntimeException("Failed to create customer", e);
        }
    }
}