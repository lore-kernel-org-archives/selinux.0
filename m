Date: Wed, 14 May 2003 16:06:16 -0400 (EDT)
From: <selinux@netgps.net>
To: <SELinux@tycho.nsa.gov>
Subject: Process Transition
Message-ID: <Pine.LNX.4.33.0305141431210.16852-100000@GPS1.NETPGS.NET>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am having an issue with policy configuration.  On a default install of 
redhat, I compiled and installed the selinux kernel and associated tools.  
I've probably spent about 5 hours familiarizing myself with the policy 
language and the logic of type enforcement.  I browsed through the archive 
for a bit, and didn't find a clear solution to my issue.

Upon booting the LSM kernel in permissive mode, I get many access denied 
messages as the init process runs (as well as some other processes that 
run at boot).  I am sure that once I have an understanding as to why one 
of these occur, I should be able to rectify the remaining problems, so I 
will post the first denied process transition.

avc:  denied  { transition } for  pid=1 comm=swapper path=/sbin/init /
dev=08 :01 ino=229436 scontext=system_u:system_r:kernel_t /
tcontext=system_u:system_r:init_t tclass=process

I have the following line in the policy.conf (post make install-src 
install, of course):

allow kernel_t init_t:process transition;

In Frank Mayer's post about domain transitions,

http://www.nsa.gov/selinux/list-archive/3984.html

he states that program entry and program execute rules are also required.  
I have the following rules:

allow init_t init_exec_t:file entrypoint;
allow init_t init_exec_t:file { read getattr lock execute ioctl };

Obviously, what I have is not sufficient (or perhaps wrong/irrelevant).  
What else is required to allow the transition to occur?  I realize this a 
developer's list, not a help-me spam list, but I haven't found any 
other good sources.  

Please advise me if this is inappropriate and where else I might look
for some assistance.

Much thanks,

Jared


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
