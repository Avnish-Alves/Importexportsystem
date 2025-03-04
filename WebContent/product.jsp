<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List, Pojo.Product"%>

<%
	// Get port_id from session
Integer portId = (Integer) session.getAttribute("port_id");
if (portId == null) {
	response.sendRedirect("login.jsp");
	return;
}

// Retrieve product list from request
List<Product> products = (List<Product>) request.getAttribute("productList");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Consumer Dashboard</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
body {
	background-color: #ffffff;
	font-family: 'Poppins', sans-serif;
	display: flex;
	flex-direction: column;
	min-height: 100vh;
}

.container {
	margin-top: 30px;
	flex-grow: 1;
}

.navbar {
	background-color: #1d3557;
	padding: 15px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.navbar-brand, .navbar-nav .nav-link {
	color: white;
	font-weight: bold;
}

.sidebar {
	height: 100vh;
	width: 270px;
	position: fixed;
	top: 0;
	left: -270px;
	background-color: #457b9d;
	padding-top: 20px;
	transition: 0.4s;
	z-index: 1000;
}

.sidebar.active {
	left: 0;
}

.sidebar a {
	padding: 15px;
	display: block;
	color: white;
	text-decoration: none;
	font-size: 18px;
	transition: 0.3s;
}

.sidebar a:hover {
	background-color: #a8dadc;
}

.close-btn {
	position: absolute;
	top: 10px;
	right: 15px;
	font-size: 24px;
	cursor: pointer;
	color: white;
}

.card {
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s ease;
	background: #fff;
}

.card:hover {
	transform: scale(1.05);
}

.btn-primary {
	background-color: #e63946;
	border: none;
}

.btn-primary:hover {
	background-color: #d62828;
}

footer {
	background-color: #1d3557;
	color: white;
	padding: 20px;
	text-align: center;
	margin-top: auto;
}

.toggle-btn {
	border: none;
	background: none;
	color: white;
	font-size: 24px;
	cursor: pointer;
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark">
		<button class="toggle-btn" onclick="toggleSidebar()">
			<i class="fas fa-bars"></i>
		</button>
		<a class="navbar-brand ms-5" href="index.jsp">PortCommerce</a>
		<li class="nav-item">
                <a class="nav-link" href="logout.jsp" style="color: #ff6b6b;">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </li>
	</nav>

	<div class="sidebar" id="sidebar">
		<span class="close-btn" onclick="toggleSidebar()">&times;</span> <a
			href="index.jsp">Home</a> <a href="viewProducts">Products</a> <a
			href="cart.jsp">My Cart</a> <a href="order_confirmation.jsp">My
			Orders</a> <a href="viewReportedIssues">Reported products</a> <a
			href="Profile.jsp">My Profile</a>
	</div>

	<div class="container">
		<h2 class="text-center mb-4">Available Products</h2>

		<%
			if (products == null) {
		%>
		<p class="text-center text-danger">❌ productList is NULL!</p>
		<%
			} else if (products.isEmpty()) {
		%>
		<p class="text-center text-warning">❌ No available products.</p>
		<%
			} else {
		%>
		<div class="row">
			<%
				for (Product product : products) {
			%>
			<div class="col-md-4">
				<div class="card p-3 my-3">
					<h5><%=product.getProductName()%></h5>
					<p>
						<strong>Price:</strong> ₹<%=product.getPrice()%></p>
					<p>
						<strong>Quantity:</strong>
						<%=product.getQuantity()%></p>
					<form action="CartController" method="post">
						<input type="hidden" name="port_id" value="<%=portId%>">
						<input type="hidden" name="product_id"
							value="<%=product.getProductId()%>"> <input
							type="hidden" name="quantity" value="1">
						<button type="submit" class="btn btn-primary" name="action"
							value="add">Add to Cart</button>
					</form>
				</div>
			</div>
			<%
				}
			%>
		</div>
		<%
			}
		%>
	</div>

	<script>
		function toggleSidebar() {
			document.getElementById("sidebar").classList.toggle("active");
		}
	</script>

	<footer class="fixed-bottom">
		<p>&copy; 2025 PortCommerce. All rights reserved.</p>
	</footer>
</body>
</html>