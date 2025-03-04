<%@ page import="java.util.List"%>
<%@ page import="Pojo.InsUpDel_Pojo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	Integer sellerId = (Integer) session.getAttribute("seller_id");
if (sellerId == null) {
	response.sendRedirect("login.jsp");
	return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Seller Dashboard</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>

/* Navbar Styling */
.navbar {
	background-color: #1d3557;
	padding: 15px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.navbar-brand, .navbar-nav .nav-link {
	color: white;
	font-weight: bold;
	margin: 0 15px;
}

.navbar-toggler {
	background-color: white;
}

/* Sidebar Styling */
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
	box-shadow: 2px 0 5px rgba(0, 0, 0, 0.2);
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

.sidebar.active {
	left: 0;
}

.close-btn {
	position: absolute;
	top: 10px;
	right: 15px;
	font-size: 24px;
	cursor: pointer;
	color: white;
}

body {
	background-color: #f4f7fc;
	font-family: 'Arial', sans-serif;
}

.container {
	margin-top: 20px;
}

.table th {
	background-color: #1abc9c;
	color: white;
	text-align: center;
	padding: 12px;
}

.table-hover tbody tr:hover {
	background-color: rgba(26, 188, 156, 0.1);
}

.card {
	border-radius: 12px;
	overflow: hidden;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	max-width: 800px;
	margin: 20px auto;
	padding: 20px;
	background-color: #ffffff;
}

.form-control {
	border-radius: 8px;
}

.btn {
	padding: 10px;
	font-size: 16px;
	border-radius: 8px;
}

footer {
	background-color: #1d3557;
	color: white;
	text-align: center;
	padding: 10px;
	position: fixed;
	bottom: 0;
	width: 100%;
}
</style>
</head>
<body>
	<!-- Navbar -->
	<nav class="navbar navbar-expand-lg navbar-dark">
		<button class="toggle-btn" onclick="toggleSidebar()">
			<i class="fas fa-bars"></i>
		</button>
		<a class="navbar-brand ms-5" href="SellerInsUpDel.jsp">PortCommerce</a>
		<li class="nav-item"><a class="nav-link" href="logout.jsp"
			style="color: #ff6b6b;"> <i class="fas fa-sign-out-alt"></i>
				Logout
		</a></li>
	</nav>

	<!-- Sidebar -->
	<div class="sidebar" id="sidebar">
		<span class="close-btn" onclick="toggleSidebar()">&times;</span> <a
			href="SellerReportController">Report</a> <a
			href="ConsumerViewOrder.jsp">Orders</a>
	</div>

	<div class="container">
		<h2 class="text-center">Seller Product Management</h2>

		<div class="card">
			<div class="card-header bg-info text-white">View Products</div>
			<div class="card-body">
				<form action="InsUpDel_Controller" method="get">
					<input type="hidden" name="action" value="view">
					<button type="submit" class="btn btn-info">View Products</button>
				</form>
				<%
					List<InsUpDel_Pojo> products = (List<InsUpDel_Pojo>) request.getAttribute("products");
				%>
				<%
					if (products != null && !products.isEmpty()) {
				%>
				<table class="table table-hover table-striped table-bordered mt-4">
					<thead>
						<tr>
							<th>Product ID</th>
							<th>Product Name</th>
							<th>Price</th>
							<th>Quantity</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						<%
							for (InsUpDel_Pojo product : products) {
						%>
						<tr>
							<td><%=product.getProductId()%></td>
							<td><%=product.getProductName()%></td>
							<td>$<%=product.getPrice()%></td>
							<td><%=product.getQuantity()%></td>
							<td>
								<form action="SellerInsUpDel.jsp" method="post"
									style="display: inline;">
									<input type="hidden" name="showUpdateForm" value="true">
									<input type="hidden" name="productID"
										value="<%=product.getProductId()%>"> <input
										type="hidden" name="productName"
										value="<%=product.getProductName()%>"> <input
										type="hidden" name="price" value="<%=product.getPrice()%>">
									<input type="hidden" name="quantity"
										value="<%=product.getQuantity()%>">
									<button type="submit" class="btn btn-primary">Update</button>
								</form>

								<form action="InsUpDel_Controller" method="post"
									style="display: inline;">
									<input type="hidden" name="action" value="delete"> <input
										type="hidden" name="productID"
										value="<%=product.getProductId()%>">
									<button type="submit" class="btn btn-danger"
										onclick="return confirm('Are you sure you want to delete this product?')">Delete</button>
								</form>
							</td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
				<%
					} else {
				%>
				<p class="text-center mt-4">No products found.</p>
				<%
					}
				%>
			</div>
		</div>

		<%
			boolean showUpdateForm = "true".equals(request.getParameter("showUpdateForm"));
		%>
		<%
			if (showUpdateForm) {
		%>
		<div class="card mt-4">
			<div class="card-header bg-warning text-white">Update Product</div>
			<div class="card-body">
				<form action="InsUpDel_Controller" method="post">
					<input type="hidden" name="action" value="update"> <input
						type="hidden" name="productID"
						value="<%=request.getParameter("productID")%>">
					<div class="mb-3">
						<label class="form-label">Product Name</label>
						<p class="form-control-plaintext"><%=request.getParameter("productName")%></p>
						<input type="hidden" name="newName"
							value="<%=request.getParameter("productName")%>">
					</div>


					<div class="mb-3">
						<label class="form-label">Price</label> <input type="number"
							name="newPrice" class="form-control"
							value="<%=request.getParameter("price")%>" required min="1">
					</div>
					<div class="mb-3">
						<label class="form-label">Quantity</label> <input type="number"
							name="newQuantity" class="form-control"
							value="<%=request.getParameter("quantity")%>" required min="1">
					</div>
					<button type="submit" class="btn btn-primary">Update
						Product</button>
				</form>
			</div>
		</div>
		<%
			}
		%>
	</div>
	<div class="text-center mt-4">
		<form action="SellerInsUpDel.jsp" method="post">
			<input type="hidden" name="showAddForm" value="true">
			<button type="submit" class="btn btn-success">Add Product</button>
		</form>
	</div>

	<%
		boolean showAddForm = "true".equals(request.getParameter("showAddForm"));
	%>
	<%
		if (showAddForm) {
	%>
	<div class="card mt-4">
		<div class="card-header bg-success text-white">Add Product</div>
		<div class="card-body">
			<form action="InsUpDel_Controller" method="post">
				<input type="hidden" name="action" value="add">
				<div class="mb-3">
					<label class="form-label">Product Name</label> <input type="text"
						name="productName" class="form-control" required>
				</div>
				<div class="mb-3">
					<label class="form-label">Price</label> <input type="number"
						name="price" class="form-control" required min="1">
				</div>
				<div class="mb-3">
					<label class="form-label">Quantity</label> <input type="number"
						name="quantity" class="form-control" required min="1">
				</div>
				<button type="submit" class="btn btn-primary">Add Product</button>
			</form>
		</div>
	</div>
	<%
		}
	%>
	</div>
	<!-- Footer -->
	<footer class="fixed-bottom">
		<p>&copy; 2025 PortCommerce. All rights reserved.</p>
	</footer>

	<script>
		function toggleSidebar() {
			document.getElementById("sidebar").classList.toggle("active");
			document.getElementById("main-content").classList.toggle("shifted");
		}
	</script>
</body>
</html>