Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7QBALOb023419
	for <selinux@tycho.nsa.gov>; Fri, 26 Aug 2005 07:10:22 -0400 (EDT)
Subject: Re: selinux stacked ops
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris Wright <chrisw@osdl.org>
Cc: James Morris <jmorris@namei.org>, linux-security-module@wirex.com,
   selinux@tycho.nsa.gov
In-Reply-To: <20050825221732.GR7991@shell0.pdx.osdl.net>
References: <20050825221732.GR7991@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 07:08:05 -0400
Message-Id: <1125054485.5812.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-08-25 at 15:17 -0700, Chris Wright wrote:
> These are no-ops in dummy or capabilities, but don't represent the rest
> of the hooks, or the rest in a single object area (i.e. task or inode).
> Looks like (from discussion in early May) they were added to help stack
> with grsec and something else?

Yes, they were added at the request of various people who wanted to
stack digsig, owlsm, or custom LSMs.  Not clear that they are important
anymore given the generic LSM stacking support.

> Would it make more sense to directly use cap_* as library functions,
> and drop the whole ad-hoc internal stacking?

Yes, if dummy is going to be killed entirely (as per the recently posted
patches), then it makes sense to hardwire to using the cap_ functions.
But I recall there are some issues with regard to properly falling back
to just capabilities upon a runtime disable of SELinux - I'll look at
your patch.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
