Message-ID: <3C45CA77.8060609@pcez.com>
Date: Wed, 16 Jan 2002 10:46:15 -0800
From: Shaun Savage <savages@pcez.com>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: trace call path
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

HI

I have a problem with running iptables (using ipchains.te) from the 
command line, context root:sysadm_r:sysadm_t.  I get no "denied" in the 
log. I am baffled.

I put an "auditallow sysadm_t ipchains_exec_t:file execute; in the 
ipchains.te, I see the execute.

the "auditallow sysadm_t ipchains_t:process transition;"  I don't see that.

on the command line is see "permission denied"

I have also added "role sysadm_t types { ipchains_t}; " 
 ,"domain_auto_trans(sysadm_t,ipchains_exec_t,ipchains_t)"


So I want to learn some debug ideas.  How do you trace the calls through 
selinux?  Or what is the execution flow?

Shaun



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
