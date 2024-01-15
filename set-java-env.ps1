Add-Type -AssemblyName System.Windows.Forms

# 创建窗体
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Java环境变量配置工具'
$form.Size = New-Object System.Drawing.Size(300, 150)
$form.StartPosition = 'CenterScreen'

# 创建标签
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10, 20)
$label.Size = New-Object System.Drawing.Size(280, 20)
$label.Text = '请输入Java安装路径:'
$form.Controls.Add($label)

# 创建文本输入框
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10, 40)
$textBox.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($textBox)

# 创建确定按钮
$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(10, 70)
$okButton.Size = New-Object System.Drawing.Size(75, 23)
$okButton.Text = '确定'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$form.Topmost = $true

# 显示窗体
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $javaPath = $textBox.Text
    # 创建JAVA_HOME环境变量
    [Environment]::SetEnvironmentVariable('JAVA_HOME', $javaPath, [EnvironmentVariableTarget]::Machine)

    # 创建CLASSPATH环境变量
    $classpath = ".;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar;"
    [Environment]::SetEnvironmentVariable('CLASSPATH', $classpath, [EnvironmentVariableTarget]::Machine)

    # 在Path变量后面追加Java的bin目录
    $path = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine)
    $newPath = $path + ";%JAVA_HOME%\bin;%JAVA_HOME%\jre\bin;"
    [Environment]::SetEnvironmentVariable('Path', $newPath, [EnvironmentVariableTarget]::Machine)

    [System.Windows.Forms.MessageBox]::Show('Java环境变量配置完成。', '成功', [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
}