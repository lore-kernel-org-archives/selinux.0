Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA5CYAXZ002709
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 07:34:12 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA5CYBKf018199
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 12:34:11 GMT
Subject: Re: Updated SELinux Release
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Manoj Srivastava <manoj.srivastava@stdc.com>, selinux@tycho.nsa.gov,
   debian-devel@lists.debian.org
In-Reply-To: <1099627566.25416.6.camel@nexus.verbum.private>
References: <1099496380.1213.111.camel@moss-spartans.epoch.ncsc.mil>
	 <Pine.LNX.4.58.0411031908500.12297@d10systems.homelinux.com>
	 <1099534538.3875.6.camel@nexus.verbum.private>
	 <87k6t2qepg.fsf@glaurung.internal.golden-gryphon.com>
	 <20041104131544.GC5461@lkcl.net>
	 <1099627566.25416.6.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1099657758.6373.8.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 05 Nov 2004 07:29:18 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-11-04 at 23:06, Colin Walters wrote:
> Why don't we just run say EROS (http://www.eros-
> os.org/) instead?  A: Because what makes SELinux interesting is that it
> can run all of our legacy software.  By not shipping it on everywhere,
> we're not tapping that ability.

Some of us might argue that the EROS security model is inadequate...
See DTMach/DTOS/Flask papers and reports for discussion of why
capability-based models leave something to be desired.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
