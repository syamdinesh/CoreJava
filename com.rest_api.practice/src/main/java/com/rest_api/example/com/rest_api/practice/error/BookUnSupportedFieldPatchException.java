/**
 * 
 */
package com.rest_api.example.com.rest_api.practice.error;

import java.util.Set;

/**
 * @author syamd
 *
 */
public class BookUnSupportedFieldPatchException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 
	 */
	public BookUnSupportedFieldPatchException(Set<String> keys) {
		super("Field " + keys.toString() + " update is not allow.");
	}
}
