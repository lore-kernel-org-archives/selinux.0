Message-ID: <3C44712E.2020807@pcez.com>
Date: Tue, 15 Jan 2002 10:13:02 -0800
From: Shaun Savage <savages@pcez.com>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: newrole logging
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

HI
I am adding auditing to the policy.   One of the things I want to audit 
is when ever any on executes a newrole.  I added a line

auditallow {user_t sysadm_t } newrole_exec_t: file execute;

this create two entries in the messages file

a "execute" and "read execute"

The information in the log is not enough.  I want "time, who, 
old_context, new_context, result"
Should I just add a syslog routine into newrole, or is there a way to 
doit via the selinux auditallow?

I would also like to log the exit from newrole.

?? idea ??
A new pam module could be written to log the role changes.  maybe using 
the session pam.

2> I would also like to log mounts, remounts, and umounts.  i added

auditallow {initrc_t sysadm_t user_t} fs_type:filesystem mount;
auditallow {initrc_t sysadm_t user_t} fs_type:filesystem remount;
auditallow {initrc_t sysadm_t user_t} fs_type:filesystem umount;

But it does not like the umount one, any help??

Shaun
 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
