Message-ID: <4434DAC4.6090006@seb.ee>
Date: Thu, 06 Apr 2006 12:09:24 +0300
From: Tanel Kokk <tanel.kokk@seb.ee>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Sendmail & SELinux policies
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello

I made SELinux policies for sendmail on CentOS (seemed, that 
target-policy contains somekind of incomplete policy for sendmail)

Mostly it seems work fine. however some times I find selinux audit-logs 
from dmesg:

audit(1144310301.564:2): avc:  denied  { getattr } for  pid=11789 
comm="sendmail" name="null" dev=sda2 ino=293212 
scontext=user_u:system_r:sendmail_t tcontext=system_u:object_r:device_t 
tclass=chr_file
audit(1144310301.564:3): avc:  denied  { ioctl } for  pid=11789 
comm="sendmail" name="null" dev=sda2 ino=293212 
scontext=user_u:system_r:sendmail_t tcontext=system_u:object_r:device_t 
tclass=chr_file

audit2allow get:
allow sendmail_t device_t:chr_file { getattr ioctl };

However I have this line in ./src/policy/domains/program/local.te:
allow sendmail_t device_t:chr_file { read write getattr ioctl };

As I understand I already have allowing policy record for this 
situation. Why I still got this denied messages for sendmail_t?


-- 
Tanel Kokk


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
