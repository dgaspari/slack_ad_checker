import ConfigParser
import os
from slackclient import SlackClient
import subprocess
import sys
import time

def is_email_in_ad(user_email):
    psxmlgen = subprocess.Popen([r'C:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe',
                                 '-ExecutionPolicy',
                                 'Unrestricted',
                                 './check_user_in_ad.ps1',
                                 user_email], cwd=os.getcwd())
                                 
    result = psxmlgen.wait()
    if result is 1:
        print('This email does not exist in AD: ' + user_email)

# get api token from config file
config_parse = ConfigParser.ConfigParser()
if not os.path.isfile('./slackadchecker_config.ini'):
    print('No config file slackadchecker_config.ini exists. Please create. Exiting now.')
    sys.exit()

config_parse.read('./slackadchecker_config.ini')
slack_token = config_parse.get('slack','apikey')
sc = SlackClient(slack_token)
results = sc.api_call('users.list')
userlist = results.get('members')

for user in userlist:
    if not user.get('is_bot') and not user.get('deleted'):
        useremail = user.get('profile').get('email')
        if useremail is not None:
            #just prints to console if email not there
            is_email_in_ad(useremail)
            time.sleep(3)