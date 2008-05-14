Subject: Re: [PATCH] selinux:  fix sleeping allocation in
	security_context_to_sid (Was: + selinux-dopey-hack.patch added to -mm tree)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <20080514110650.add0aa7d.akpm@linux-foundation.org>
References: <200805130810.m4D8ACbM032389@imap1.linux-foundation.org>
	 <1210688804.6206.141.camel@moss-spartans.epoch.ncsc.mil>
	 <20080513092150.c819e1fc.akpm@linux-foundation.org>
	 <1210698106.6206.188.camel@moss-spartans.epoch.ncsc.mil>
	 <20080513114018.5bfa7fb0.akpm@linux-foundation.org>
	 <1210774363.6206.344.camel@moss-spartans.epoch.ncsc.mil>
	 <1210775635.6206.354.camel@moss-spartans.epoch.ncsc.mil>
	 <20080514110650.add0aa7d.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Wed, 14 May 2008 14:55:10 -0400
Message-Id: <1210791310.28282.53.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-05-14 at 11:06 -0700, Andrew Morton wrote:
> On Wed, 14 May 2008 10:33:55 -0400 Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > Fix a sleeping function called from invalid context bug by moving allocation
> > to the callers prior to taking the policy rdlock.
> 
> Looks good to me, from a quick peek.  If it passes testing please
> submit for 2.6.26 (if 2.6.26 needs it, which I think it does)..

AFAIK, it is only applicable to James' for-akpm branch, where a prior
patch targeted 2.6.27 introduced the bug in the first place.  So
shouldn't affect 2.6.26 at all.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
