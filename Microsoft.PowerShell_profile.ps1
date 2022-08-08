Import-Module oh-my-posh
Set-PoshPrompt -Theme paradox

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
