Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6OCFDHa000028
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 08:15:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6OCE1FB025089
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 12:14:01 GMT
Received: from prometheus.epoch.ncsc.mil (prometheus.epoch.ncsc.mil [144.51.25.40])
	by jazzswing.ncsc.mil  with ESMTP id h6OCE1GD025086
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 12:14:01 GMT
Received: from prometheus.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by prometheus.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6OCF5xH014605
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 08:15:05 -0400
Received: (from jwcart2@localhost)
	by prometheus.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h6OCF5Hl014603
	for selinux@tycho.nsa.gov; Thu, 24 Jul 2003 08:15:05 -0400
Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6NLQWHa028095
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 17:26:32 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6NLQVDW001862
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 21:26:31 GMT
Received: from citation.av8.net ([130.105.12.4])
        by jazzband.ncsc.mil  with ESMTP id h6NLQVeN001859 for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 21:26:31 GMT
Date: Wed, 23 Jul 2003 17:24:08 -0400 (EDT)
From: Dean Anderson <dean@av8.com>
To: Russell Coker <russell@coker.com.au>
cc: "Carsten P. Gehrke" <Carsten@rollinghorse.com>, <selinux@tycho.nsa.gov>
Subject: Re: Linuxfromscratch.org
In-Reply-To: <200307231144.38947.russell@coker.com.au>
Message-ID: <Pine.LNX.4.44.0307231702310.22745-100000@vista.av8.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Technically, we can only say we don't know that it is in the GCC builds.
But we also get compilers and operating systems from many places.

The Kernigan hack predated GCC, and the GNU project, which was only
started after Stallmen reverse engineered the password encryption
algorithm, and was barred from ATT source code. It also predates my active
involvement, so I can't say if it actually happened or if it was just
documented as possible. The way it has been passed to me is that it
actually happened, and was distributed--though this was
pre-commercialization/pre SysV.

The only way to check for it would be to decompile code with a tool that
wasn't altered to remove the evidence--note that it is hard to be too
paranoid when you really start to think about the possibilities. It is
tremendously hard to have truly trustworthy tools.

Shared libraries and loadable modules make this even harder today, since
the trusted executable may load untrusted shared libraries, or system
calls may be altered (as some root kits actually do).

I do recall in the OSF/1 B1 secure effort (though memory fades) that if
one had kernel loader privilege, one could subvert all other privileges
and thereby defeat the B1 requirement of separate roles/privileges.  I
recall that it was thought that no system with loadable kernel modules
could ever be B1 secure, unless it was based on a trusted microkernel,
which only loaded additional personality modules which would be unable to
alter certain security functions. (Unix being a personality module).  The
OSF also had a research effort in micro kernels, based on Mach, and had a
working OSF/1 personality for it, but the personality was never shipped.

		--Dean

P.S. It still seems that Russell Coker has some overzealous antispam
measures, which violate the email ethics standards promoted by the EFF.
http://www.eff.org/Spam_cybersquatting_abuse/Spam/position_on_junk_email.html

On Wed, 23 Jul 2003, Russell Coker wrote:

> On Wed, 23 Jul 2003 11:09, Carsten P. Gehrke wrote:
> > Is this true of the GNU C compiler suite as well?  And if so, would it not
> > be possible to remove it from the compiler?  How does it work?  Does it
> > look at the code, or is anything called login.c susceptible?  Why has this
> > not been removed in the open-source code?  How can I check to see if this
> > backdoor exists?
>
> This is not in the current GCC builds, if it ever was.
>
> There are a variety of stories concerning this, some say that it was just
> commented code to illustrate a point, some say that it was in there with full
> nasty capabilities but was removed years ago (>10 years).
>
> There is no need to worry about this particular exploit right now, but there
> are issues with the potential for creating others of the same type.
>
> --
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
