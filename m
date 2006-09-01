Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k81HV2WA016698
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 13:31:02 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k81HUNlZ007966
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 17:30:23 GMT
Subject: Re: Latest updates
From: Eric Paris <eparis@parisplace.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1157125888.3199.157.camel@sgc.columbia.tresys.com>
References: <44F7358E.4010101@redhat.com>
	 <1157125888.3199.157.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 13:32:35 -0400
Message-Id: <1157131955.3195.114.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-01 at 11:51 -0400, Christopher J. PeBenito wrote:

> > gfs supports xattr
> 
> IIRC, last time the question was if this was widely avaiable?

I'm not sure what your question is not did I see what dan's change was.
But at this time gfs2 has selinux xtarrs.  gfs(1) does not ship in any
form with xattr support (although patches were done they will never be
put into play).  Since gfs(1) is not upstream we should continue to
treat it as we always have but all gfs2 filesystems should be able to
support xattrs

> > /usr/lib/ia32el/ia32x_loader needs to run unconfined_execmem_t if we 
> > have any hope of turning off allow_execmem
> 
> Out of curiosity, what is this program?

it is the interpreter that allows ia32 programs to run on the intel
itanium processors (ia64)  It dynamically takes the x86 program and
interprets it into ia64 instructions on the fly.  So it makes sense that
it needs to execute the memory of the instructions it just wrote.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
