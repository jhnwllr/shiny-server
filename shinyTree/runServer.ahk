#d::

winactivate Administrator: Command Prompt
sleep 500
Send ^C ; send command to quit running the server
sleep 500
Send ^C ; send command to quit running the server
sleep 500
Send ^C ; send command to quit running the server
Send Rscript C:/Users/Owner/Desktop/shinyTree/run.r
sleep 500
Send {Enter}
settitlematchmode 2
winactivate, Google Chrome
sleep 500
Send {F5}
sleep 500
winactivate, Notepad++
sleep 500



