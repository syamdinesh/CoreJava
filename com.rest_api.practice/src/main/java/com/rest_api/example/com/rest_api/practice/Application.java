package com.rest_api.example.com.rest_api.practice;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Application /** implements CommandLineRunner */
{

	private static final Logger log = LoggerFactory.getLogger(Application.class);

	@Autowired
	private BookRepository bookRepository;

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}

//	@Bean
//	CommandLineRunner initDatabase(BookRepository repository) {
//		return args -> {
//			repository.save(new Book("A Guide to the Bodhisattva Way of Life", "Santideva", new BigDecimal("15.41")));
//			repository.save(new Book("The Life-Changing Magic of Tidying Up", "Marie Kondo", new BigDecimal("9.69")));
//			repository.save(new Book("Refactoring: Improving the Design of Existing Code", "Martin Fowler",
//					new BigDecimal("47.99")));
//		};
//	}

//	@Override
//	public void run(String... args) throws Exception {
//		log.info("Starting application.....");
//
//		bookRepository.save(new Book("7 Habits of Effective people", "Syam", new BigDecimal("9.69")));
//		bookRepository.save(new Book("7 Habits of Effective people-1", "Dinesh", new BigDecimal("10.69")));
//		bookRepository.save(new Book("7 Habits of Effective people-2", "Bayyana", new BigDecimal("20.69")));
//
//		System.out.println("\n findaAll()");
//		bookRepository.findAll().forEach(x -> System.out.println(x));
//
//		System.out.println("\n findById(1L)");
//		bookRepository.findById(1l).ifPresent(x -> System.out.println(x));
//
//		System.out.println("\n findByName('Author')");
//		bookRepository.findByName("Bayyana").forEach(x -> System.out.println(x));
//	}
}
