package com.allianz.rcp.apps;

import org.eclipse.swt.SWT;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.ui.part.ViewPart;

public class HelloView extends ViewPart {

	public HelloView() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void createPartControl(Composite parent) {

		parent.setLayout(new GridLayout(1, false));
		Button button = new Button(parent, SWT.PUSH);
		button.setText("Hello View");
	}

	@Override
	public void setFocus() {
		// TODO Auto-generated method stub

	}

}
