Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0IDlWIi019675
	for <selinux@tycho.nsa.gov>; Tue, 18 Jan 2005 08:47:32 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0IDjY9K019695
	for <selinux@tycho.nsa.gov>; Tue, 18 Jan 2005 13:45:34 GMT
Subject: Re: Java and SELinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Albretch Mueller <lbrtchx@hotmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <BAY101-F18255CE2DCD9B803428707B48D0@phx.gbl>
References: <BAY101-F18255CE2DCD9B803428707B48D0@phx.gbl>
Content-Type: text/plain
Message-Id: <1106055488.18274.65.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 18 Jan 2005 08:38:08 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-01-16 at 13:15, Albretch Mueller wrote:
> I have been reading about SELinux, how to design a Trusted Computing Base 
> (TCB) with it and the difficulties of setting up an OS-based ruled based 
> security framework to control 'virtual machines' which basically take much 
> of the responsibilities of a TCB off the Operating System.
> 
> I am more of an application developer kind of guy, but contrary to people's 
> opinions I think you can indeed make SELinux and the JVM dance together 
> pretty nicely, even better than regular OS-based applications since you 
> would be instead of one, actually two walls by:
> 
> 1._ actually using java security policies within the JVM
> 
> 2._ constraining all native calls from the JVM to the actual OS through 
> SELinux
> 
> I find this straightforward and doable with much difficulty or . . . what is 
> it I am missing here?

The SELinux/Flask architecture refers to this notion as userspace object
managers (or userspace policy enforcers), where an entity like the JVM
would need to be modified to apply labeling and access controls on its
abstractions that are not directly visible to the OS, providing
finer-grained control, while still using the OS controls to provide
coarse-grained protection.  A few programs have been modified to act as
userspace object managers on SELinux, including dbus-daemon and X.

Note that the Flux research group at Univ. of Utah has some prior work
on introducing access controls into the JVM, including concepts from the
Flask architecture (drawn from the earlier prototype in the Fluke
microkernel, not SELinux).  See http://www.cs.utah.edu/flux/janos/.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
