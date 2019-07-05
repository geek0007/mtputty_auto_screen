# mtputty_auto_screen
 Updated 3 minutes ago  Frequent disconnect to remote ssh server using mtputty can be handled by this bash script. Simply set you mtputty with this script and on click you will be log into your screen session after ssh log in.
 
 Setps to Install:
 
 1. Log in to you ssh server
 2.Copy script to your login path and chmode +x mtputty_auto_screen.sh
 3.In MtPutty servers->properties->script put /bin/bash        <your_script_path>/mtputty_auto_screen.sh
 4.Add 5 seconds of delay before script runs
 5.save
 
 On next mtputty use, just click on saved server to login to screen one by one 
