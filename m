Subject: Re: dynamic context transitions from kernel space
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Fedor Sakharov <teo.montekki@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <49E5BB6A.5090505@gmail.com>
References: <49E5BB6A.5090505@gmail.com>
Content-Type: text/plain
Date: Wed, 15 Apr 2009 08:59:17 -0400
Message-Id: <1239800357.27560.32.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-04-15 at 14:48 +0400, Fedor Sakharov wrote:
> Hello,
> 
> Is it possible to somehow use the setcon() from the kernel space? Or is 
> there any other way of changing the current context of the process from 
> kernel? I need this for building a module that would monitor the 
> execution of app and switch it's rights depending on the current branch 
> of code being executed.

setcon(3) is a libselinux function that just writes the context string
to /proc/self/attr/current.  Within the kernel, the proc filesystem
invokes the security_setprocattr() LSM hook interface, which then calls
selinux_setprocattr() if SELinux is enabled.

I doubt you want to just call security_setprocattr() though.  You may
wish to look at the example of cachefiles and how it overrides
credentials.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
