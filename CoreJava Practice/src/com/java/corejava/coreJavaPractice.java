/**
 * 
 */
package com.java.corejava;

import java.io.File;
import java.io.IOException;

/**
 * @author syamd
 *
 */
public class coreJavaPractice {

	public static void main(String[] args) throws Exception {
//		Scanner scanner = new Scanner(System.in);
//		int noOfTestCases = scanner.nextInt();
//		int sizeOfArray = scanner.nextInt();
//		int noOfElementsAndNoOfRotations = scanner.nextInt();
//		int i = 0;
//		int[] arr = new int[sizeOfArray];
//		while (i < sizeOfArray) {
//			arr[i] = scanner.nextInt();
//			++i;
//		}
//		System.out.println(Arrays.toString(arr));
//		System.out.println(Arrays.toString(leftArrayRotate(arr, noOfElementsAndNoOfRotations, noOfTestCases)));
//		scanner.close();

//		Path photos = Paths.get("C:\\Users\\syamd\\OneDrive\\Desktop\\tem");
//		System.out.print(photos);
//		System.out.println();
//		System.out.println(new FileInputStream("C:\\Users\\syamd\\OneDrive\\Desktop\\tem"));

//		File folder = new File("C:\\Users\\syamd\\OneDrive\\Desktop\\tem");
//		File folder1 = new File("C:\\Users\\syamd\\OneDrive\\Pictures\\2021-07-21");
//		String[] listOfPhotos = folder.list();
//
//		for (String file : listOfPhotos) {
//			String[] listFiles1 = folder1.list();
//			for (String file1 : listFiles1) {
//				BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(new FileInputStream("C:\\Users\\syamd\\OneDrive\\Desktop\\tem")));
//				bufferedReader.
//				new InputStreamReader(new FileInputStream("C:\\Users\\syamd\\OneDrive\\Desktop\\tem"))
//				.equals(new InputStreamReader(
//						new FileInputStream("C:\\Users\\syamd\\OneDrive\\Pictures\\2021-07-21")))
//				if (file.getBytes().equals(file1.getBytes()))
//					System.out.println(file + " & " + file1 + " are equal");
//			}
//		}
//		System.out.println("Nothing found");

//		LinkedList<Integer> linkedList = (LinkedList<Integer>) Arrays.asList(1, 2, 3, 4, 5);

//		Path path = Paths.get("C:\\Users\\syamd\\OneDrive\\Desktop\\NewFile.txt");
//		try (BufferedWriter newBufferedWriter = Files.newBufferedWriter(path, StandardCharsets.UTF_8)) {
//			newBufferedWriter.write("Hello World!");
//		} catch (IOException e) {
//			e.printStackTrace();
//		}

		filePathConstruction();

	}

	// File path Construction
	public static void filePathConstruction() {

		try {
			String filename = "newFile.txt";
			String workingDirectory = System.getProperty("user.dir");
			String absoluteFilePath = "";

			// absoluteFilePath = workingDirectory + System.getProperty("file.separator") +
			// filename;
			absoluteFilePath = workingDirectory + File.separator + filename;
			System.out.println("Final filepath : " + absoluteFilePath);
			File file = new File(absoluteFilePath);

			if (file.createNewFile()) {
				System.out.println("File is created!");
			} else {
				System.out.println("File is already existed!");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static int[] leftArrayRotate(int[] arr, int noOfRotation, int noOfTestCases) {
		for (int k = 0; k < noOfTestCases; k++) {
			for (int i = 0; i < noOfRotation; i++) {
				int temp1 = 0, temp2 = arr[0];
				int length = arr.length;
				for (int j = 0; j < length; j++) {
					if (j != length - 1) {
						temp1 = temp2;
						temp2 = arr[j + 1];
						arr[j + 1] = temp1;
					} else
						arr[0] = temp2;
				}
			}
		}
		return arr;
	}
}
