$POSHTHEME = "jonnychipz"

(@(&"$env:LOCALAPPDATA/Programs/oh-my-posh/bin/oh-my-posh.exe" init pwsh --config="$env:LOCALAPPDATA\Programs\oh-my-posh\themes\$POSHTHEME.omp.json" --print) -join "`n") | Invoke-Expression

Import-Module Terminal-Icons

Set-Alias -Name "rdns" -Value "Resolve-DnsName"

Set-Variable -Name userAgent -Scope Global -Value $([Microsoft.PowerShell.Commands.PSUserAgent]::Chrome)
# $PSDefaultParameterValues = @{"Invoke-WebRequest:UserAgent"=$userAgent;"Invoke-RestMethod:UserAgent"=$userAgent}

Set-Item -Path function:\kali -Value {
    if ((Get-Service vmms).Status -ne "Running"){Start-Service vmms}
    if ((Get-VM kali).State -ne "Running"){Start-VM kali}
    Remove-Variable kali -ea 0 -Scope Global
    while ($ip -notmatch "^1((7|9)2|0)"){
        Write-Host "`r$ip" -NoNewline
        Set-Variable ip -Scope Global -Value $(Get-VM kali|Get-VMNetworkAdapter).IPAddresses[0]
    }
    Write-Host $ip -NoNewline
    # Start-Process PowerShell -ArgumentList "-WindowStyle Minimized -Command ssh dandelion@$kali `"tar czvf /tmp/dandelion.tgz /home/dandelion/`";scp dandelion@$kali`:/tmp/dandelion.tgz `"D:\Backups\$(get-date -Format 'yyyyMMddHHmmss')_dandelion_kali.tgz`";ssh dandelion@$kali `"rm /tmp/dandelion.tgz`""
    Set-Variable kali -Scope Global -Value "dandelion@$ip"
    ssh $kali
}

function ilak {
    if ((Get-VM kali).State -eq "Running"){Stop-VM kali}
    if ((Get-Service vmms).Status -eq "Running"){Stop-Service vmms}
}

Invoke-RestMethod -Uri https://wttr.in/
