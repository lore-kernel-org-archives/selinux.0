Return-Path: <owner-selinux@tycho.ncsc.mil>
Date: 10 Mar 2002 09:39:40 -0000
Message-ID: <20020310093940.30150.qmail@mailFA9.rediffmail.com>
MIME-Version: 1.0
From: "Samarth  Sharma" <samarth7880@rediffmail.com>
Reply-To: "Samarth  Sharma" <samarth7880@rediffmail.com>
To: SELinux@tycho.nsa.gov
Content-type: text/plain;
	format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ok i need answers to these questions :

1.On login i get the following message :
  [ avc: denied {write} for pid=647 exe=/bin/login
  path=/var/log/wtmp dev=03:07 ino=182350
  scontext=system_u:system_r:local_login_t
  tcontext=system_u:object_r:cron_log_t tclass=file ]
what does this mean and how can i get around it.
  i get similar messages while loading 'atd'.

2.Can u give me a specific example where SElinux is able to solve 
a security flaw in normal Linux

3.i tried loading the selinux kernel on an amd machine.
however the machine keeps rebooting immediately after the lilo 
screen. Linux 7.1 (redhat) runs fine on this machine.

4.how do u add a user to the system. i added a new user in the 
../policy/users file with appropriate context and compiled the 
policy but security context for that user was not initialized.

thanks,
Samarth Sharma

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
