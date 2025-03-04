
# Port Commerce Project  

## Project Overview  
Port Commerce is a web-based application designed using the **MVC-2 architecture**. It facilitates product management and order processing, ensuring seamless interaction between users and the system.

## Requirements  

- **Architecture:** MVC-2  
- **View Layer:** JSP  
- **Model Layer:** POJO  
- **Controller Layer:** Servlet (Java)  
- **JDK Version:** 8  
- **Tomcat Version:** 8.5  
- **Database:** MySQL  

## Project Structure  

```
Importexportsystem/
│── src/
│   ├── Controller/
│   ├── Implementor/
│   ├── Interface/
│   ├── Pojo/
│   ├── Db/
│
│── WebContent/
│   ├── index.jsp
│   ├── product.jsp
│   ├── cart.jsp
│   ├── order_confirmation.jsp
│   ├── consumer_dashboard.jsp
│   ├── seller_reported_issues.jsp
│   ├── report_product.jsp
│   ├── Profile.jsp
│
│── WebContent/WEB-INF/
│   ├── web.xml
│   ├── lib/
│
│── pom.xml (If using Maven)
│── README.md
│── .gitignore
```

## Database Schema  
The system uses **MySQL** with the following tables:  

```sql
CREATE TABLE consumer_port (
    port_id INT PRIMARY KEY NOT NULL,
    role VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL
);

CREATE TABLE seller_port (
    port_id INT PRIMARY KEY NOT NULL,
    password VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    role VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    seller_id INT NOT NULL,
    FOREIGN KEY (seller_id) REFERENCES seller_port(port_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,  
    order_date DATE NOT NULL DEFAULT (CURDATE()),
    order_placed BOOLEAN NOT NULL DEFAULT FALSE,
    shipped BOOLEAN NOT NULL DEFAULT FALSE,
    out_for_delivery BOOLEAN NOT NULL DEFAULT FALSE,
    delivered BOOLEAN NOT NULL DEFAULT FALSE,
    quantity INT NOT NULL,
    product_id INT NOT NULL,
    consumer_port_id INT NULL,
    FOREIGN KEY (consumer_port_id) REFERENCES consumer_port(port_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE reported_products (
    report_id INT PRIMARY KEY AUTO_INCREMENT,
    issue_type VARCHAR(50) NOT NULL,
    report_date DATE NOT NULL DEFAULT (CURDATE()),
    solution VARCHAR(255) DEFAULT 'pending',  
    product_id INT NOT NULL,
    consumer_port_id INT NOT NULL,
    FOREIGN KEY (consumer_port_id) REFERENCES consumer_port(port_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
```

## Installation & Setup  

1. **Clone the repository**  
   ```sh
   git clone https://github.com/your-username/port-commerce.git
   cd port-commerce
   ```

2. **Configure Database**  
   - Import the provided MySQL script to create tables.  
   - Update `GetConnection.java` with your database credentials.  

3. **Deploy on Tomcat**  
   - Place the project in the `webapps` directory of Tomcat 8.5.  
   - Start Tomcat and access the app at `http://localhost:8080/port-commerce`.  

4. **Run the Application**  
   - Open a browser and visit `http://localhost:8080/port-commerce`.  

## Features  
✅ User Authentication  
✅ Product Management (Add, Update, Delete)  
✅ Order Management  
✅ Product Reporting System  
✅ MySQL Database Integration  

## Contribution  
Feel free to fork the repository and contribute to improvements! 🚀  

## License  
This project is open-source and available under the **MIT License**.  


