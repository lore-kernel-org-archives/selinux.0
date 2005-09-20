Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8KKfUNs003113
	for <selinux@tycho.nsa.gov>; Tue, 20 Sep 2005 16:41:30 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8KKbO1Y009597
	for <selinux@tycho.nsa.gov>; Tue, 20 Sep 2005 20:37:24 GMT
Subject: Re: Reference policy status page update
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <4330696E.6070400@redhat.com>
References: <1126650640.18007.41.camel@sgc>  <4330696E.6070400@redhat.com>
Content-Type: text/plain
Date: Tue, 20 Sep 2005 16:41:39 -0400
Message-Id: <1127248899.16809.20.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-20 at 15:56 -0400, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> 
> >I have updated the reference policy status page with a listing of the
> >remaining modules that need to be converted, and note which modules are
> >in the Fedora strict and targeted policies.
> >
> >http://serefpolicy.sourceforge.net/index.php?page=status
> >
[cut]
> >
> Ok, I have begun playing with the reference policy trying to build the 
> modules version.  So far not much luck.
> 
> checkmodule does not like the syntax for "module devices 1.0;"

Can you be more specific about the error, and which module you're
compiling?  At least one other module had a typo calling it devices too.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
