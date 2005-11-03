Subject: Re: [PATCH] libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jonathan Kim <jkim@TrustedCS.com>
Cc: SELinux@tycho.nsa.gov, Chad Hanson <chanson@TrustedCS.com>
In-Reply-To: <1131050021.23420.153.camel@moss-spartans.epoch.ncsc.mil>
References: <36282A1733C57546BE392885C0618592D975CA@chaos.tcs.tcs-sec.com>
	 <1131048615.23420.142.camel@moss-spartans.epoch.ncsc.mil>
	 <1131050021.23420.153.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 15:47:44 -0500
Message-Id: <1131050864.23420.165.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-11-03 at 15:33 -0500, Stephen Smalley wrote:
> Just to note:  I'm not opposed to the patch per se (although it might be
> better to treat this as an error condition rather than falling through
> to the base user definitions, as they may give wider access then you
> want since multiple Linux users may be mapped to a single SELinux user),
> but I'm unclear about why one would use an empty level in this manner in
> seusers versus just omitting the entry for the user altogether if you
> want the fallback behavior.

The other point to keep in mind here is that there are plans to create
management utilities for seusers (via libsemanage) and that those
utilities are going to be instrumented for audit as part of the
LSPP/RBAC effort, whereas local.users is largely unused except by
SELinux developers even now and is even less likely to be used going
forward now that seusers exists.  The expectation is that the base
policy (module) will contain the base set of SELinux user identities
(which will correspond to distinct role sets defined in the policy and
typically be authorized for the full range), and seusers will handle
mapping each Linux user to a role set (aka SELinux user identity) and to
an authorized range.  The user ranges in the SELinux policy will then be
largely unused (typically just the full range), as seusers will be what
governs the clearance/high assigned to the user session based on the
Linux user.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
