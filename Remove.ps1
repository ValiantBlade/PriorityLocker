#Requires -RunAsAdministrator

#Imported Libraries
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

#.NET window formatting
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Data Entry Form'
$form.Size = New-Object System.Drawing.Size(450,200)
$form.StartPosition = 'CenterScreen'
$errorForm = New-Object System.Windows.Forms.Form
$errorForm.Text = 'Data Entry Form'
$errorForm.Size = New-Object System.Drawing.Size(300,200)
$errorForm.StartPosition = 'CenterScreen'

#OK button formatting
$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(150,120)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = 'OK'
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$errorOKButton = New-Object System.Windows.Forms.Button
$errorOKButton.Location = New-Object System.Drawing.Point(110,120)
$errorOKButton.Size = New-Object System.Drawing.Size(75,23)
$errorOKButton.Text = 'OK'
$errorOKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK

#Cancel button formatting
$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(225,120)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = 'Cancel'
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel

#Text formatting
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(440,20)
$label.Text = 'Enter the name of the EXE file you want to stop automatically running at high priority'
$errorLabel = New-Object System.Windows.Forms.Label
$errorLabel.Location = New-Object System.Drawing.Point(10,20)
$errorLabel.Size = New-Object System.Drawing.Size(200,20)
$errorLabel.Text = 'EXE name is not a valid EXE name'

#Text box formatting
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,60)
$textBox.Size = New-Object System.Drawing.Size(410,20)

#Setting the form controls to actually be the formatted buttons and text box.
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)
$form.Controls.Add($label)
$form.Controls.Add($textBox)
$form.Topmost = $true
$form.Add_Shown({$textBox.Select()})
$errorForm.AcceptButton = $errorOKButton
$errorForm.Controls.Add($errorOKButton)
$errorForm.Controls.Add($errorLabel)
$errorForm.Topmost = $true
$errorForm.Add_Shown({$errorOKButton.Select()})

#Displays my form
$result = $form.ShowDialog()

#Passes text from text box into a variable
if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    #Checks if the information from the text box is a valid EXE name
    if ($textBox.Text -like "*.exe") {
        #Deletes the registry key
        $exeName = $textBox.Text
        Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\$exeName" -Recurse
    }
    else {
        #Shows an error
        $errorForm.ShowDialog()
    }   
}