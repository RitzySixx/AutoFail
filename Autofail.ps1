# Clear the console
Clear-Host

# Banner Function
function Show-Banner {
    Write-Host "==================== Auto Fail Check ===================="
}

# Show Banner
Show-Banner
Write-Host "Checking AutoFails..."
Write-Host

# Separator line
Write-Host "--------------------------------------------------"

# Check PowerShell history
$PSHistoryCount = (Get-PSReadLineOption).MaximumHistoryCount
if ($PSHistoryCount -eq 0) {
    Write-Host "PowerShell history: " -ForegroundColor Red "Disabled."
} else {
    Write-Host "PowerShell history: " -ForegroundColor Green "Enabled."
}

# Separator line
Write-Host "--------------------------------------------------"

# Check CMD access
$cmdAccessReg = Get-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\System" -ErrorAction SilentlyContinue
if ($null -eq $cmdAccessReg -or $cmdAccessReg.DisableCMD -ne 1) {
    Write-Host "CMD access: " -ForegroundColor Green "Enabled."
} else {
    Write-Host "CMD access: " -ForegroundColor Red "Disabled."
}

# Separator line
Write-Host "--------------------------------------------------"

# Check Task Manager access
$taskManagerReg = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -ErrorAction SilentlyContinue
if ($null -eq $taskManagerReg -or $taskManagerReg.DisableTaskMgr -ne 1) {
    Write-Host "Task Manager: " -ForegroundColor Green "Enabled."
} else {
    Write-Host "Task Manager: " -ForegroundColor Red "Disabled."
}

# Separator line
Write-Host "--------------------------------------------------"

# Check Prefetch Status
$prefetchReg = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" -ErrorAction SilentlyContinue
if ($null -eq $prefetchReg) {
    Write-Host "Prefetch: " -ForegroundColor Red "Not configured."
} else {
    switch ($prefetchReg.EnablePrefetcher) {
        0 { Write-Host "Prefetch: " -ForegroundColor Red "Disabled." }
        1 { Write-Host "Prefetch: " -ForegroundColor Yellow "Application launch prefetch is enabled but boot prefetch is disabled." }
        2 { Write-Host "Prefetch: " -ForegroundColor Yellow "Boot prefetch is enabled but application launch prefetch is disabled." }
        3 { Write-Host "Prefetch: " -ForegroundColor Green "Both application and boot prefetch are enabled." }
    }
}

# Separator line
Write-Host "--------------------------------------------------"

# Check Recent File History
$recentDocsReg = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -ErrorAction SilentlyContinue
if ($null -eq $recentDocsReg -or $recentDocsReg.NoRecentDocsHistory -ne 1) {
    Write-Host "Recent File History: " -ForegroundColor Green "Enabled."
} else {
    Write-Host "Recent File History: " -ForegroundColor Red "Disabled."
}

# Separator line
Write-Host "--------------------------------------------------"
Read-Host