Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i97JuIrT017107
	for <selinux@tycho.nsa.gov>; Thu, 7 Oct 2004 15:56:18 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i97JuHov011752
	for <selinux@tycho.nsa.gov>; Thu, 7 Oct 2004 19:56:17 GMT
Subject: Re: libsepol+mls compile failure
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1097178086.13339.214.camel@moss-spartans.epoch.ncsc.mil>
References: <1097111576.31497.6.camel@chris.pebenito.net>
	 <1097178086.13339.214.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1097178811.13339.219.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 07 Oct 2004 15:53:32 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-10-07 at 15:41, Stephen Smalley wrote:
> On Wed, 2004-10-06 at 21:12, Chris PeBenito wrote:
> > I was going to try out MLS, but I get the following compile failure in
> > libsepol:
> > 
> > mls.c: In function `mls_compute_av':
> > mls.c:36: error: `policydb' undeclared (first use in this function)
> > mls.c:36: error: (Each undeclared identifier is reported only once
> > mls.c:36: error: for each function it appears in.)
> > mls.c: In function `mls_compute_context_len':
> > mls.c:84: error: `policydb' undeclared (first use in this function)
> > mls.c: In function `mls_sid_to_context':
> > mls.c:114: error: `policydb' undeclared (first use in this function)
> > mls.c: In function `mls_context_to_sid':
> > mls.c:230: error: `policydb' undeclared (first use in this function)

And trivial patch for checkpolicy Makefile, also only compile-tested.

Index: checkpolicy/Makefile
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/Makefile,v
retrieving revision 1.24
diff -u -r1.24 Makefile
--- checkpolicy/Makefile	14 Sep 2004 12:18:07 -0000	1.24
+++ checkpolicy/Makefile	7 Oct 2004 19:51:10 -0000
@@ -12,10 +12,8 @@
 
 ifeq ($(MLS),y)
 OPTIONS = -DCONFIG_SECURITY_SELINUX_MLS
-OBJS = mls.o
 else
 OPTIONS =
-OBJS =
 endif
 
 CFLAGS = -g $(OPTIONS) -Wall -O2 -pipe

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
