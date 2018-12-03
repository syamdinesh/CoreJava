import org.eclipse.swt.SWT;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
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
public class MyLoginForm {
	
public static void main(String args[]) {
	Display display=new Display();
	Shell shell =new Shell(display);
	shell.setText("Login Form");
	shell.setLayout(new GridLayout(2,false));
	
	Label userlabel=new Label(shell,SWT.FILL);
	userlabel.setText("username");
	
	Text usernameTf=new Text(shell,SWT.SINGLE);
	usernameTf.setTextLimit(30);
	
	Label pswdlb=new Label(shell,SWT.FILL);
	pswdlb.setText("Password");
	
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
	submit.setText("Submit");
	Button reset = new Button(buttoncomposite, SWT.PUSH);
	reset.setText("Reset");
	Button exit = new Button(buttoncomposite, SWT.PUSH);
	exit.setText("Exit");

	
	
	submit.addSelectionListener(new SelectionAdapter() {
		@Override
		public void widgetSelected(SelectionEvent arg0) {
			String username = usernameTf.getText().trim();
			String passwrd = passwordtf.getText().trim();
			
			if(username.length()==0) {
				System.out.println(username);
				MessageBox messageBox = new MessageBox(shell,SWT.OK| SWT.ICON_WARNING|SWT.CANCEL);
				messageBox.setMessage("username is manadatory");
				messageBox.setText("Username is required");
				messageBox.open();
			}
			else if(passwrd.length()==0) {
				System.out.println(passwrd);
				MessageBox messageBox = new MessageBox(shell,SWT.OK| SWT.ICON_WARNING|SWT.CANCEL);
				messageBox.setMessage("Password is manadatory");
				messageBox.setText("Password is required");
				messageBox.open();
			}
			else {
				MessageBox messageBox = new MessageBox(shell,SWT.OK| SWT.ICON_INFORMATION|SWT.CANCEL);
				messageBox.setMessage("Credentials entered for :"+ username);
				messageBox.setText("Information");
				messageBox.open();
			}
		}
	});
	reset.addSelectionListener(new SelectionAdapter() {
		@Override
		public void widgetSelected(SelectionEvent arg0) {
			usernameTf.setText("");
			passwordtf.setText("");
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
	shell.open();
	while(!shell.isDisposed()){
		if(!display.readAndDispatch())
			display.sleep();
	}
	display.dispose();
}
}

