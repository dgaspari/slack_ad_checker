# Slack AD Checker
A Python/Powershell util script for checking to see that everyone in a Slack group has a corresponding email in Active Directory

### Why?

This is a little utility script you could use to remind admins to remove people from slack (basically if you don't wanna pay for full AD sync)

### Install/Setup

Assuming you're on a Windows machine, you'll need something with Powershell and Python installed. For some versions of Windows (just Windows 10 at the moment), you may need to install the Get-ADUser module. See under the setup/ directory.

Here's the source for the module installer:
https://blogs.technet.microsoft.com/ashleymcglone/2016/02/26/install-the-active-directory-powershell-module-on-windows-10/

Once you have that module set up, you can query your current Active Directory domain for users. The Python script is going to invoke the powershell script to check everybody.

Now all you need is a Python environment with the slackclient package installed (pip install slackclient).

You'll need a Slack API token to make queries. You can get one from here: https://api.slack.com/custom-integrations/legacy-tokens

Enter the token in the config file and then you should be all set.

### Usage

For now the script just spits out which emails for slack users don't seem to exist in AD.

### Notes

This is just a quick utility I cooked up.

An even better idea would be to auto-populate/control slack accounts based on AD users. Erik Kalkoken makes some interesting suggestions here:
http://stackoverflow.com/questions/33420052/populate-slack-user-profiles-using-external-directory-data

Here's his info on Slack's undocumented API methods:
https://github.com/ErikKalkoken/slackApiDoc

