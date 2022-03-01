/**
 * 
 */
package com.rest_api.example.com.rest_api.practice;

import java.math.BigDecimal;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

/**
 * @author syamd
 *
 */
@Entity
public class Book {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@NotEmpty(message = "Please provide a name")
	private String name;

	@NotEmpty(message = "Please provide a author")
	private String author;

	@NotNull(message = "Please provide a price")
	@DecimalMin("1.00")
	private BigDecimal price;

	public Book() {

	}

	public Book(String name, String author, BigDecimal price) {
		this.name = name;
		this.author = author;
		this.price = price;
	}

	@Override
	public int hashCode() {
		return Objects.hash(author, id, name, price);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Book other = (Book) obj;
		return Objects.equals(author, other.author) && Objects.equals(id, other.id) && Objects.equals(name, other.name)
				&& Objects.equals(price, other.price);
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}
}
