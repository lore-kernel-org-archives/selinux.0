Subject: Re: rawhide targeted vs. refpolicy rpm
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1131996746.5415.234.camel@moss-spartans.epoch.ncsc.mil>
References: <BF9A263D.7FFA%csellers@tresys.com>
	 <4374BDEC.4050600@redhat.com> <200511111717.16542.csellers@tresys.com>
	 <200511141041.49643.csellers@tresys.com>
	 <1131983537.5415.137.camel@moss-spartans.epoch.ncsc.mil>
	 <4378B88B.6040003@redhat.com>
	 <1131987091.5415.180.camel@moss-spartans.epoch.ncsc.mil>
	 <4378D636.3090408@redhat.com>
	 <1131996746.5415.234.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 08:23:04 -0500
Message-Id: <1132060984.5415.336.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-11-14 at 14:32 -0500, Stephen Smalley wrote:
> Yes, but the current workaround doesn't generalize; it assumes root
> defaults to user_r in the non-managed case, which isn't true under
> strict policy.  Options would seem to be:
> - Drop support for non-managed systems from genhomedircon altogether, or
> - Have genhomedircon fall back to looking for system.users if the system
> is not managed, and use that to determine the default role for root.

I see that you chose the latter option in the latest version of the
genhomedircon patch, which I've merged as of policycoreutils 1.27.28.
We still need to resolve the default role problem in semanage/sepol (at
which point we should be able to remove the current hack from
genhomedircon).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
