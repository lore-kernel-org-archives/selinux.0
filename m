Message-ID: <3C5024BD.6050303@pcez.com>
Date: Thu, 24 Jan 2002 07:14:05 -0800
From: Shaun Savage <savages@pcez.com>
MIME-Version: 1.0
To: Justin Smith <jsmith@mcs.drexel.edu>
CC: SELinux@tycho.nsa.gov
Subject: Re: Shutdown issues
References: <1011880927.1377.9.camel@jsmith.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

There are two ways to fix this problem,
Easy:
	just toggle out of enforcing mode sometime during shutdown.
Hard:
	 move the shutdown of the syslog to later and try to capture the 
messages, then fix it.  Or you can via sysadm role shut down just the 
services.  The problem here is sysadm_t != initrc_t.  you have to do a 
runs as.  Also even with enforcing off you get messages.

Shaun


Justin Smith wrote:

> I am using Redhat 7.2 with the current version of SELinux (2.4.17
> kernel) and have noticed some "issues" (sorry to introduce Microsoftese)
> involving shutdown:
> 
> There are a number of access denied messages in shutdown that are hard
> to catch because they don't appear on the message log (since the system
> is shutting down).
> 
> In some cases, software (postgres and ipchains, for instance) is not
> properly shut down due to these denials. 
> 
> I don't know whether this is related, but I get a kernel panic when
> shutting down in enforcing mode. It's hard to note the details of this
> problem because the system succeeds in shutting down anyway (so the
> messages disappear from the screen). I just recall the phrase 'kernel
> panic' appearing briefly. This is only a problem for my home computer
> since it shut it down after every use.
> 
> In general, I solve all of these problems by using a shutdown script
> that puts the system in permissive mode just before shutdown (this is
> not a security problem since it's hard to hack a system that is shutting
> down...)
> 




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
