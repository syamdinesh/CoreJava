/**
 * 
 */
package com.rest_api.example.com.rest_api.practice;

import java.util.List;
import java.util.Map;

import javax.validation.Valid;
import javax.validation.constraints.Min;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.rest_api.example.com.rest_api.practice.error.BookNotFoundException;
import com.rest_api.example.com.rest_api.practice.error.BookUnSupportedFieldPatchException;

/**
 * @author syamd
 */
@RestController
@Validated
public class BookController {

	@Autowired
	private BookRepository bookRepository;

	@GetMapping("/books")
	List<Book> findAll() {
		return (List<Book>) bookRepository.findAll();
	}

	@ResponseStatus(HttpStatus.CREATED)
	@PostMapping("/books")
	Book newBook(@Valid @RequestBody Book newBook) {
		return bookRepository.save(newBook);
	}

	@GetMapping("/books/{id}")
	Book findOne(@PathVariable @Min(1) Long id) {
		return bookRepository.findById(id).orElseThrow(() -> new BookNotFoundException(id));
	}

	@PutMapping("/books/{id}")
	Book saveOrUpdate(@RequestBody Book newBook, @PathVariable Long id) {
		return bookRepository.findById(id).map(x -> {
			x.setName(newBook.getName());
			x.setAuthor(newBook.getAuthor());
			x.setPrice(newBook.getPrice());
			return bookRepository.save(x);
		}).orElseGet(() -> {
			newBook.setId(id);
			return bookRepository.save(newBook);
		});
	}

	@PatchMapping("/books/{id}")
	Book patch(@RequestBody Map<String, String> update, @PathVariable Long id) {
		return bookRepository.findById(id).map(x -> {
			String author = update.get("author");
			if (author != " ") {
				x.setAuthor(author);
				return bookRepository.save(x);
			} else {
				throw new BookUnSupportedFieldPatchException(update.keySet());
			}
		}).orElseGet(() -> {
			throw new BookNotFoundException(id);
		});
	}

	@DeleteMapping("/books/{id}")
	void delete(@PathVariable Long id) {
		bookRepository.deleteById(id);
	}
}
