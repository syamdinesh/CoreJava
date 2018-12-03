
package allianzhello.parts;

import javax.annotation.PostConstruct;

import org.eclipse.swt.SWT;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.layout.RowLayout;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.MessageBox;
import org.eclipse.swt.widgets.Text;

public class MyLoginForm {

	@PostConstruct
	public void postConstruct(Composite shell) {
//		Display display=new Display();
//		Shell shell =new Shell(display);
//		shell.setText("Login Form");
		shell.getShell().setText(Messages.MyLoginForm_0);
		shell.setLayout(new GridLayout(2,false));
		
		Label userlabel=new Label(shell,SWT.FILL);
		userlabel.setText(Messages.MyLoginForm_1);
		
		Text usernameTf=new Text(shell,SWT.SINGLE);
		usernameTf.setTextLimit(30);
		
		Label pswdlb=new Label(shell,SWT.FILL);
		pswdlb.setText(Messages.MyLoginForm_2);
		
		Text passwordtf =new Text(shell,SWT.SINGLE);
		passwordtf.setTextLimit(30);
		passwordtf.setEchoChar('*');
		
		Composite buttoncomposite = new Composite(shell, SWT.DEFAULT);
		RowLayout rowLayout = new RowLayout();
		rowLayout.type=SWT.HORIZONTAL;
		buttoncomposite.setLayout(rowLayout);

		
		GridData gridData = new GridData();
		gridData.horizontalSpan=2;
		buttoncomposite.setLayoutData(gridData);
		
		Button submit=new Button(buttoncomposite,SWT.PUSH);
		submit.setText(Messages.MyLoginForm_3);
		Button reset = new Button(buttoncomposite, SWT.PUSH);
		reset.setText(Messages.MyLoginForm_4);
		Button exit = new Button(buttoncomposite, SWT.PUSH);
		exit.setText(Messages.MyLoginForm_5);

		
		
		submit.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent arg0) {
				String username = usernameTf.getText().trim();
				String passwrd = passwordtf.getText().trim();
				
				if(username.length()==0) {
					System.out.println(username);
					MessageBox messageBox = new MessageBox(shell.getShell(),SWT.OK| SWT.ICON_WARNING|SWT.CANCEL);
					messageBox.setMessage(Messages.MyLoginForm_6);
					messageBox.setText(Messages.MyLoginForm_7);
					messageBox.open();
				}
				else if(passwrd.length()==0) {
					System.out.println(passwrd);
					MessageBox messageBox = new MessageBox(shell.getShell(),SWT.OK| SWT.ICON_WARNING|SWT.CANCEL);
					messageBox.setMessage(Messages.MyLoginForm_8);
					messageBox.setText(Messages.MyLoginForm_9);
					messageBox.open();
				}
				else {
					MessageBox messageBox = new MessageBox(shell.getShell(),SWT.OK| SWT.ICON_INFORMATION|SWT.CANCEL);
					messageBox.setMessage(Messages.MyLoginForm_10+ username);
					messageBox.setText(Messages.MyLoginForm_11);
					messageBox.open();
				}
			}
		});
		reset.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent arg0) {
				usernameTf.setText(Messages.MyLoginForm_12);
				passwordtf.setText(Messages.MyLoginForm_13);
			}
			
		});
		exit.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent arg0) {
				shell.dispose();
				System.exit(0);
			}
		});
		
		
		shell.pack();
	//	shell.open();
//		while(!shell.isDisposed()){
//			if(!display.readAndDispatch())
//				display.sleep();
//		}
	//}
		
	}

}