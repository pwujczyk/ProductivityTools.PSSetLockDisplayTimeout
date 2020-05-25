<!--Category:C#,Powershell--> 
 <p align="right">
      <a href="https://www.powershellgallery.com/packages/ProductivityTools.PSSetLockDisplayTimeout/"><img src="Images/Header/Powershell_border_40px.png" /></a>
    <a href="http://www.productivitytools.tech/SetLockDisplayTimeout/"><img src="Images/Header/ProductivityTools_green_40px_2.png" /><a> 
    <a href="https://github.com/pwujczyk/ProductivityTools.PSSetLockDisplayTimeout/"><img src="Images/Header/Github_border_40px.png" /></a>
</p>
<p align="center">
    <a href="http://productivitytools.tech/">
        <img src="Images/Header/LogoTitle_green_500px.png" />
    </a>
</p>


# SetLockDisplayTimeout

Module sets up the inactivity time after which lock screen will show up.

<!--more-->

**Console lock display off timeout** option is used by administrators to improve security. Unfortunately very often they are setting this value to some small value like 1 minute. 

To block users to changing value option is often hidden.

Module adds option again to the interface and sets value to given one. 

<!--og-image-->
![PowerOptions](Images/PowerOptions.png)

### Parameters:
 - Minutes - sets amount of minutes to set up in the option

### Switchers
- Battery -sets the **On battery** option
- PluggedIn - sets the **Plugged in** option

### Example of usage:

```Powershell
Set-LockDisplayTimeout -Minutes 1 -Verbose
``` 

![PowerOptions](Images/Example.png)
