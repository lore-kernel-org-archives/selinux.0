Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j04FkUIi024894
	for <selinux@tycho.nsa.gov>; Tue, 4 Jan 2005 10:46:30 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j04FkWA9001484
	for <selinux@tycho.nsa.gov>; Tue, 4 Jan 2005 15:46:33 GMT
Subject: Re: modules needed to be compiled in for selinux to work
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Richard Troth <rtroth@bmc.com>
Cc: Russell Coker <russell@coker.com.au>,
   Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <Pine.LNX.4.53.0501040908010.4737@rmt-desk.bmc.com>
References: <200501050204.03428.russell@coker.com.au>
	 <Pine.LNX.4.53.0501040908010.4737@rmt-desk.bmc.com>
Content-Type: text/plain
Message-Id: <1104853085.20724.28.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 04 Jan 2005 10:38:06 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-01-04 at 10:11, Richard Troth wrote:
> On Tue, 4 Jan 2005, Russell Coker wrote:
> > SE Linux has not worked correctly when compiled as a module
> > since at least mid 2001.
> 
> Okay,  that answers the question I was going to ask Stephen.
> (I've never tried,  so I did not know that Debian's "=m" would fail.)

To be precise, the SELinux configuration option was changed from
'tristate' (i.e. y/n/m) to 'bool' (i.e. y/n) in Sep 2002.
That was part of an overhaul of SELinux based on feedback from certain
kernel developers, who told us that trying to support SELinux as a
loadable module made no sense and made it very difficult to analyze the
code.  This change allowed significant simplification of the SELinux
code.  So 'm' hasn't been an option for quite some time.

> >        I don't believe that there are any plans to try and change this.
> 
> Why?

Any security subsystem worth having is necessarily tightly coupled to
the core kernel, and needs to start performing at least basic setup very
early during kernel initialization (to track all kernel objects and
ensure that they are all properly labeled for access control).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
