import org.eclipse.swt.SWT;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.layout.FormAttachment;
import org.eclipse.swt.layout.FormData;
import org.eclipse.swt.layout.FormLayout;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.layout.RowLayout;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.MessageBox;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Text;

public class MyNewFormLayout {
	
public static void main(String args[]) {
	Display display=new Display();
	Shell shell =new Shell(display);
	shell.setText("Login Form");
	shell.setLayout(new FormLayout());
	
	Label userlabel=new Label(shell,SWT.FILL);
	userlabel.setText("username");
        FormData data1 = new FormData();
        data1.left = new FormAttachment(0, 0);
        data1.top = new FormAttachment(0, 0);
        userlabel.setLayoutData(data1);

	
	Text usernameTf=new Text(shell,SWT.SINGLE);
	usernameTf.setTextLimit(30);
	FormData data2 = new FormData();
    data2.left = new FormAttachment(userlabel, 10);
    usernameTf.setLayoutData(data2);
	
	
	Label pswdlb=new Label(shell,SWT.FILL);
	pswdlb.setText("Password");
	FormData data3 = new FormData();
	  data3.bottom = new FormAttachment(userlabel, 30);
      //data1.top = new FormAttachment(0, 0);
      pswdlb.setLayoutData(data3);
	
	Text passwordtf =new Text(shell,SWT.SINGLE);
	passwordtf.setTextLimit(30);
	passwordtf.setEchoChar('*');
	FormData data4 = new FormData();
	  data4.bottom = new FormAttachment(usernameTf, 
			  
			  0);
	  data4.right = new FormAttachment(pswdlb, 10);
		passwordtf.setLayoutData(data4);
	
//	Composite buttoncomposite = new Composite(shell, SWT.DEFAULT);
//	RowLayout rowLayout = new RowLayout();
//	rowLayout.type=SWT.HORIZONTAL;
//	buttoncomposite.setLayout(rowLayout);
//
//	
////	GridData gridData = new GridData();
////	gridData.horizontalSpan=2;
////	buttoncomposite.setLayoutData(gridData);
//	
//	Button submit=new Button(buttoncomposite,SWT.PUSH);
//	submit.setText("Submit");
//	Button reset = new Button(buttoncomposite, SWT.PUSH);
//	reset.setText("Reset");
//	Button exit = new Button(buttoncomposite, SWT.PUSH);
//	exit.setText("Exit");
//
//	
//	
//	submit.addSelectionListener(new SelectionAdapter() {
//		@Override
//		public void widgetSelected(SelectionEvent arg0) {
//			String username = usernameTf.getText().trim();
//			String passwrd = passwordtf.getText().trim();
//			
//			if(username.length()==0) {
//				System.out.println(username);
//				MessageBox messageBox = new MessageBox(shell,SWT.OK| SWT.ICON_WARNING|SWT.CANCEL);
//				messageBox.setMessage("username is manadatory");
//				messageBox.setText("Username is required");
//				messageBox.open();
//			}
//			else if(passwrd.length()==0) {
//				System.out.println(passwrd);
//				MessageBox messageBox = new MessageBox(shell,SWT.OK| SWT.ICON_WARNING|SWT.CANCEL);
//				messageBox.setMessage("Password is manadatory");
//				messageBox.setText("Password is required");
//				messageBox.open();
//			}
//			else {
//				MessageBox messageBox = new MessageBox(shell,SWT.OK| SWT.ICON_INFORMATION|SWT.CANCEL);
//				messageBox.setMessage("Credentials entered for :"+ username);
//				messageBox.setText("Information");
//				messageBox.open();
//			}
//		}
//	});
//	reset.addSelectionListener(new SelectionAdapter() {
//		@Override
//		public void widgetSelected(SelectionEvent arg0) {
//			usernameTf.setText("");
//			passwordtf.setText("");
//		}
//		
//	});
//	exit.addSelectionListener(new SelectionAdapter() {
//		@Override
//		public void widgetSelected(SelectionEvent arg0) {
//			shell.dispose();
//			System.exit(0);
//		}
//	});
//	
	
	shell.pack();
	shell.open();
	while(!shell.isDisposed()){
		if(!display.readAndDispatch())
			display.sleep();
	}
	display.dispose();
}
}

