Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBFEmHMA021342
	for <selinux@tycho.nsa.gov>; Thu, 15 Dec 2005 09:48:18 -0500 (EST)
Subject: Separating role changes from su/sudo (Was: Re: [redhat-lspp]
	Reviewing the sudo patch.)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux-dev@tresys.com, selinux@tycho.nsa.gov,
   Chad Hanson <chanson@TrustedCS.com>,
   Darrel Goeddel <DGoeddel@TrustedCS.com>, Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <43A092E9.40306@redhat.com>
References: <36282A1733C57546BE392885C0618592F1AF9F@chaos.tcs.tcs-sec.com>
	 <43A092E9.40306@redhat.com>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 09:54:50 -0500
Message-Id: <1134658490.3421.427.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-12-14 at 16:47 -0500, Daniel J Walsh wrote:
> Chad Hanson wrote:
> > Hi Dan,
> >
> > We believe the security range should stay the same as calling process. This
> > is something we would like for su as well. If we could remove the
> > pam_selinux from su so that the selinux identity, role, type stay the same
> > across su. I think we discussed with Stephen awhile back in a meeting and
> > this change would go back to original selinux implementation of su/pam.
> >
> > -Chad
> >   
> So if we back out the patch out of su and sudo, we end up with
> unconfined_t staying as unconfined_t for targeted, will still transition 
> if a unconfined transition would happen.
> 
> And strict and MLS requiring a newrole before calling to have anything 
> work correctly?
> 
> So I guess we can remove the patches, since they were originally added 
> to make strict policy livable.
> 
> Does this sound reasonable to you Stephen?

I've moved discussion to the main selinux list since this seems to be of
general SELinux relevance rather than just LSPP.

>From a security POV, separating SELinux security context changes from su
as in the original SELinux would be beneficial, although even then
SELinux user identity is no longer being used in the original sense (per
Linux user) and accountability is now addressed separately by the audit
loginuid, so we are mostly talking about separating role and level
changes from su here.  In strict policy then, we need to go back to the
earlier policy for su, which transitioned from xxx_t to xxx_su_t upon
running su to gain the necessary privileges for perform the
authentication and uid change, and then transition back to xxx_t when
invoking the user shell, so that they end up back in the original
domain, and xxx_su_t no longer needs to be able to transition to any
user domain other than xxx_t (i.e. no potential for escalation from
user_su_t to sysadm_t).

>From a user perspective, this would mean that users under strict policy
must once again run newrole -r sysadm_r first and then su to gain full
administrative privileges.  Likewise, they would have to newrole to an
appropriate role prior to running sudo.  Program domain transitions from
xxx_sudo_t could be allowed to permit invocation via sudo without
allowing direct transition from xxx_t, if we aren't using sesh there, so
that the user couldn't directly run the program in its domain without
going through sudo.

Not sure how you would handle userhelper/consolehelper, particularly
from the desktop.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
