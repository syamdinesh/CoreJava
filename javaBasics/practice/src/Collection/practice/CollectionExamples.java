package Collection.practice;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Logger;

/**
 * @author Syam Dinesh
 */
public class CollectionExamples {
	
	//logger for info
	static Logger logger;

	static {
		logger = Logger.getLogger(CollectionExamples.class.getName());
	}

	private CollectionExamples(int a) {
		logger.info("This is Constructor");
	}

	public static void main(String[] args) {
		List<Integer> arrayList = new ArrayList<Integer>();
		arrayList.add(1);
		arrayList.add(1);
		arrayList.add(4);
		arrayList.add(2);
		System.out.println(arrayList);
		LinkedHashSet<Integer> linkedHashSet = new LinkedHashSet<Integer>(arrayList);
		System.out.println(linkedHashSet);
		
		arrayList.clear();
		arrayList.addAll(linkedHashSet);
		
//		logger.info(arrayList.toString()+" "+arrayList.hashCode());
//		logger.info(arrayList.toString()+" "+arrayList.hashCode());
		
//		logger.info(arrayList+" "+ arrayList.hashCode());
		Collections.sort(arrayList);
//		logger.info(arrayList +" "+ arrayList.hashCode());
		arrayList.set(1, 9);
//		logger.info(arrayList +" "+ arrayList.hashCode());
		arrayList.remove(1);
//		logger.info(arrayList +" "+ arrayList.hashCode());
		
		Set<Integer> set = new HashSet<Integer>();
		set.add(1);logger.info(set.toString()+" "+set.hashCode());
		set.add(3);logger.info(set.toString()+" "+set.hashCode());
		set.add(4);logger.info(set.toString()+" "+set.hashCode());
		set.add(2);logger.info(set.toString()+" "+set.hashCode());
		set.add(6);logger.info(set.toString()+" "+set.hashCode());
		
		
		Set<Integer> hashSet2 = new HashSet<Integer>();
		hashSet2.add(1);hashSet2.add(2);hashSet2.add(0);hashSet2.add(4);
//		System.out.println(hashSet2);
		HashSet<Integer> hashSet = new HashSet<Integer>();
		hashSet.add(12);
		hashSet.add(10);
		hashSet.add(14);
		hashSet.add(9);
		hashSet.add(16);
		
//		System.out.println(hashSet);
		
		Map<Integer, String> map = new HashMap<Integer,String>();
		map.put(1, "Syam");
		map.put(2, "SyamDinesh");
		map.put(3, "SyamDineshBayyana");
		
//		for(Integer i: map.keySet())
//			System.out.println(map.get(i));
		
//		System.out.println(Class.forName(String.class).getName());
		Class forName = null;
		try {
			forName = Class.forName("CollectionExamples");
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			forName.newInstance();
		} catch (InstantiationException | IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    }
	
	public <T> List<T> remove(List<T> list) {
		return list;
	}
}
