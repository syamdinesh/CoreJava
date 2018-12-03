
package allianzhello.parts;

import java.util.Arrays;
import java.util.List;

import javax.annotation.PostConstruct;

import org.eclipse.jface.dialogs.MessageDialog;
import org.eclipse.jface.viewers.ArrayContentProvider;
import org.eclipse.jface.viewers.ComboViewer;
import org.eclipse.swt.SWT;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Combo;
import org.eclipse.swt.layout.GridData;

public class MyHellopart {

	@PostConstruct
	public void postConstruct(Composite parent) {
		parent.setLayout(new GridLayout(2,false));
		Button button = new Button(parent, SWT.PUSH);
		button.setText("Say Hello");
		new Label(parent, SWT.NONE);
		new Label(parent, SWT.NONE);
		new Label(parent, SWT.NONE);
		new Label(parent, SWT.NONE);
		new Label(parent, SWT.NONE);
		new Label(parent, SWT.NONE);
		
		new Label(parent, SWT.NONE);
		
		Combo combo = new Combo(parent, SWT.NONE);
		combo.setLayoutData(new GridData(SWT.FILL, SWT.CENTER, true, false, 1, 1));
		ComboViewer comboviewer=new ComboViewer(combo);
		comboviewer.setContentProvider(ArrayContentProvider.getInstance());
		comboviewer.setInput(createInitialDataModel());


		combo.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				//
				
			}
		});
		
		button.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
MessageDialog.openInformation(parent.getShell(), "My Hello", "Allianz My Hello");
			}
		});
		
	}
	private List<String> createInitialDataModel() {
		return Arrays.asList("Sample item 1", "Sample item 2", "Sample item 3", "Sample item 4", "Sample item 5");
	}


}