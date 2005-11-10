Subject: Re: [PATCH] SELinux - canonicalize getxattr() (fwd)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chad Sellers <csellers@tresys.com>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
   SELinux-dev@tresys.com, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1131636784.19626.58.camel@moss-spartans.epoch.ncsc.mil>
References: <Pine.LNX.4.63.0509141014520.7898@excalibur.intercode>
	 <200511091630.53757.csellers@tresys.com>
	 <1131635584.19626.43.camel@moss-spartans.epoch.ncsc.mil>
	 <200511101022.12631.csellers@tresys.com>
	 <1131636784.19626.58.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 10:45:40 -0500
Message-Id: <1131637540.19626.69.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-11-10 at 10:33 -0500, Stephen Smalley wrote:
> I'm doing the following:
> - updating to the latest rawhide targeted policy first (or rolling back
> to it from prior attempted install of the refpolicy),

And also updating to latest rawhide libse* and policycoreutils packages.

> - running fixfiles restorecon to ensure that files are labeled
> consistently with that policy (should already be handled upon the
> update, but just wanted to be sure),
> - running rpm -Uvh on the new policy rpm, redirecting stdout and stderr
> to a log file.
> 
> The restorecon is still running, but so far I have the following output
> excluding the lib_t->shlib_t noise:
> $ grep -v 'lib_t.*shlib_t' log

Ok, rpm finished running, and there was no further output from
restorecon.  But there is also no installed policy on the system
(outside of the sandbox).  Hmmm...did rpm remove the installed files
because they are no longer owned by the policy package itself, whereas
they used to be?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
