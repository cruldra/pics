Add-Type -AssemblyName System.Windows.Forms

# ��������
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Java�����������ù���'
$form.Size = New-Object System.Drawing.Size(300, 150)
$form.StartPosition = 'CenterScreen'

# ������ǩ
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10, 20)
$label.Size = New-Object System.Drawing.Size(280, 20)
$label.Text = '������Java��װ·��:'
$form.Controls.Add($label)

# �����ı������
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10, 40)
$textBox.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($textBox)

# ����ȷ����ť
$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(10, 70)
$okButton.Size = New-Object System.Drawing.Size(75, 23)
$okButton.Text = 'ȷ��'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$form.Topmost = $true

# ��ʾ����
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $javaPath = $textBox.Text
    # ����JAVA_HOME��������
    [Environment]::SetEnvironmentVariable('JAVA_HOME', $javaPath, [EnvironmentVariableTarget]::Machine)

    # ����CLASSPATH��������
    $classpath = ".;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar;"
    [Environment]::SetEnvironmentVariable('CLASSPATH', $classpath, [EnvironmentVariableTarget]::Machine)

    # ��Path��������׷��Java��binĿ¼
    $path = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine)
    $newPath = $path + ";%JAVA_HOME%\bin;%JAVA_HOME%\jre\bin;"
    [Environment]::SetEnvironmentVariable('Path', $newPath, [EnvironmentVariableTarget]::Machine)

    [System.Windows.Forms.MessageBox]::Show('Java��������������ɡ�', '�ɹ�', [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
}