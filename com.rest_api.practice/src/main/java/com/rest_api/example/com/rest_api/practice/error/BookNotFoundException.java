/**
 * 
 */
package com.rest_api.example.com.rest_api.practice.error;

/**
 * @author syamd
 *
 */
public class BookNotFoundException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = -9123369249390044340L;

	/**
	 * 
	 */
	public BookNotFoundException(Long id) {
		super("Book ID not Found:- " + id);
	}

}
