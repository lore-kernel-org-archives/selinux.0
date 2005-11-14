Subject: Re: rawhide targeted vs. refpolicy rpm
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux-dev@tresys.com, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4378B88B.6040003@redhat.com>
References: <BF9A263D.7FFA%csellers@tresys.com>
	 <4374BDEC.4050600@redhat.com> <200511111717.16542.csellers@tresys.com>
	 <200511141041.49643.csellers@tresys.com>
	 <1131983537.5415.137.camel@moss-spartans.epoch.ncsc.mil>
	 <4378B88B.6040003@redhat.com>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 11:51:31 -0500
Message-Id: <1131987091.5415.180.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-11-14 at 11:17 -0500, Daniel J Walsh wrote:
> policycoreutils patch to genhomedircon to use libsemanage to read 
> seusers file.

A couple of concerns about upstreaming this patch as is:
1) Compatibility.  In addition to dropping compatibility with the older
usage of genhomedircon from FC3, the patch also doesn't provide any
backward compatibility for the older system.users/local.users-based
generation, and requires that the new seusers file be present.  Is that
ok?  I suppose that genhomedircon is somewhat of an SELinux-internal
helper at this point (only used by other core SELinux components like
the policy Makefile and libsemanage), so as long as people don't try to
install the latest policycoreutils on earlier systems without also
updating their policy to a corresponding version, they shouldn't have a
problem.

2) Targeted policy specialization.  defaultrole() has a hack for
targeted policy to remap system_r to user_r as the default role for a
user when system_r is returned by semanage, and getUsers() has a
targeted policy-specific hack to handle the root entry in seusers when
not using semanage.  The latter will break anyone with strict policy
that isn't converted to using semanage.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
