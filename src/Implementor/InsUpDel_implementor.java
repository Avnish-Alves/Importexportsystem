package Implementor;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import Db.GetConnection;
import Pojo.InsUpDel_Pojo;
import Interface.InsUpDel_interface;

public class InsUpDel_implementor implements InsUpDel_interface {

	@Override
	public void add_products(InsUpDel_Pojo pojo) {
		String sql = "INSERT INTO products (product_name, quantity, price, seller_id) VALUES (?, ?, ?, ?)";
		try (Connection connection = GetConnection.getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
			preparedStatement.setString(1, pojo.getProductName());
			preparedStatement.setInt(2, pojo.getQuantity());
			preparedStatement.setDouble(3, pojo.getPrice());
			preparedStatement.setInt(4, pojo.getSellerId());
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void update_products(InsUpDel_Pojo pojo) {
		String sql = "UPDATE products SET product_name = ?, quantity = ?, price = ? WHERE product_id = ?";
		try (Connection connection = GetConnection.getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
			preparedStatement.setString(1, pojo.getProductName());
			preparedStatement.setInt(2, pojo.getQuantity());
			preparedStatement.setDouble(3, pojo.getPrice());
			preparedStatement.setInt(4, pojo.getProductId());
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void delete_products(InsUpDel_Pojo pojo) {
		String sql = "DELETE FROM products WHERE product_id = ?";
		try (Connection connection = GetConnection.getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
			preparedStatement.setInt(1, pojo.getProductId());
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<InsUpDel_Pojo> getProductsBySeller(int sellerID) {
		List<InsUpDel_Pojo> productList = new ArrayList<>();
		String query = "SELECT product_id, product_name, quantity, price FROM products WHERE seller_id = ?";
		try (Connection conn = GetConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
			ps.setInt(1, sellerID);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				InsUpDel_Pojo product = new InsUpDel_Pojo();
				product.setProductId(rs.getInt("product_id"));
				product.setProductName(rs.getString("product_name"));
				product.setQuantity(rs.getInt("quantity"));
				product.setPrice(rs.getDouble("price"));
				productList.add(product);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return productList;
	}
}