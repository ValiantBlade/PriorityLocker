#Requires -RunAsAdministrator

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Data Entry Form'
$form.Size = New-Object System.Drawing.Size(450,200)
$form.StartPosition = 'CenterScreen'

$errorForm = New-Object System.Windows.Forms.Form
$errorForm.Text = 'Data Entry Form'
$errorForm.Size = New-Object System.Drawing.Size(300,200)
$errorForm.StartPosition = 'CenterScreen'

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

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(225,120)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = 'Cancel'
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(440,20)
$label.Text = 'Enter the name of the EXE file you want to always run at high priority'

$errorLabel = New-Object System.Windows.Forms.Label
$errorLabel.Location = New-Object System.Drawing.Point(10,20)
$errorLabel.Size = New-Object System.Drawing.Size(200,20)
$errorLabel.Text = 'EXE name is not a valid EXE name'

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,60)
$textBox.Size = New-Object System.Drawing.Size(410,20)

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

$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    if ($textBox.Text -like "*.exe") {
        $exeName = $textBox.Text
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\$exeName"
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\$exeName\PerfOptions"
        New-ItemProperty -Name CPUPriorityClass -PropertyType DWORD -Value 3 -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\$exeName\PerfOptions"
    }
    else {
        $errorForm.ShowDialog()
    }   
}