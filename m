Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9KCmJrT006438
	for <selinux@tycho.nsa.gov>; Wed, 20 Oct 2004 08:48:19 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9KCl4ui008709
	for <selinux@tycho.nsa.gov>; Wed, 20 Oct 2004 12:47:05 GMT
Subject: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris Wright <chrisw@osdl.org>
Cc: James Morris <jmorris@redhat.com>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   lsm <linux-security-module@wirex.com>, SELinux ML <selinux@tycho.nsa.gov>,
   Crispin Cowan <crispin@immunix.com>
In-Reply-To: <1098275010.672.41.camel@moss-spartans.epoch.ncsc.mil>
References: <1098217020.29525.183.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.44.0410191635070.30036-100000@thoron.boston.redhat.com>
	 <20041019140947.G2357@build.pdx.osdl.net>
	 <1098275010.672.41.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1098276275.672.44.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 20 Oct 2004 08:44:35 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-10-20 at 08:23, Stephen Smalley wrote:
> - Add a separate post hook to setscheduler after locks are dropped, and
> do all auditing from it.  Likely requires changing existing setscheduler
> hook to return some state to pass along to the post hook for auditing in
> addition to the error code itself.

And this would presumably mean moving the entire set of security checks
into the setscheduler hook, so that we could handle the capable() check
similarly, i.e. we would use a special non-auditing form of capable
within the setscheduler hook, and then return state to be passed to the
post hook for audit generation.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
