Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h59CLuI4013063
	for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2003 08:21:56 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h59CLitV004042
	for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2003 12:21:44 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h59CLial004039 for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2003 12:21:44 GMT
Subject: Re: A vulnerability in SELinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: jack@rapturesecurity.com, selinux@tycho.nsa.gov
In-Reply-To: <200306071914.10635.russell@coker.com.au>
References: <1054916729.1057.213.camel@moss-huskers.epoch.ncsc.mil>
	 <1054974401.13760.29.camel@bubbles.eatflamingdeath.org>
	 <200306071914.10635.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1055161264.1068.24.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 09 Jun 2003 08:21:05 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-06-07 at 05:14, Russell Coker wrote:
> On Sat, 7 Jun 2003 18:26, Jack wrote:
> > From the limited research Ive been able to put into this
> > Ive found that changing glibc/sysdeps/generic/enbl-secure.c
> > to
> >
> >  __libc_enable_secure = (__geteuid () != __getuid ()
> >
> >                           || __getegid () != __getgid ()
> >                           || getsecsid() != getosecsid());
> 
> That looks like the right code.  The question is what is the right way of 
> integrating it into a distribution.
> 
> I don't want to maintain my own version of libc6 for SE Linux support if I can 
> avoid it.
> 
> I can't in good conscience ask the Debian libc6 maintainers to include the 
> above code at this time as the 2.6.0 transition will change the getsecsid() 
> system call and cause problems.
> 
> I could potentially write some library code to perform the 2.6.x getsecsid() 
> and then use the 2.4.x version on x86 and ARM platforms if the 2.6.x version 
> fails.  But that seems ugly.
> 
> On the debian-devel mailing list I have raised the suggestion of having an 
> option for libc6 to load a shared object for such checks (which could be used 
> for many things other than SE Linux).  However nothing productive has 
> resulted.

A certain individual has privately suggested that the kernel pass a flag
via the auxiliary table that is put on the initial stack indicating
whether libc should enable its secure mode, just as it presently passes
the uid and gid information on the stack for use in the existing test.
Note that the above code for the uid/gid tests typically never calls the
get[ug]id syscalls; it can pull it off the initial stack provided by the
kernel.  See the AT_* definitions in include/linux/elf.h and the
corresponding code in fs/binfmt_elf.c.  That would avoid the 2.4 vs. 2.6
API issue, and would also allow other security modules to implement
their own logic as they see fit.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
