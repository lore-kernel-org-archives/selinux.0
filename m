Subject: Re: getseuserbyname patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
   Karl MacMillan <kmacmillan@tresys.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1128356967.26285.154.camel@moss-spartans.epoch.ncsc.mil>
References: <43398EB2.1050100@redhat.com>
	 <1127925593.25945.130.camel@moss-spartans.epoch.ncsc.mil>
	 <433BEB18.7000703@redhat.com>
	 <1128006623.27495.70.camel@moss-spartans.epoch.ncsc.mil>
	 <433C06F0.3020804@redhat.com>  <433C3C5A.4000104@redhat.com>
	 <1128028887.27495.184.camel@moss-spartans.epoch.ncsc.mil>
	 <1128354729.26285.137.camel@moss-spartans.epoch.ncsc.mil>
	 <1128356967.26285.154.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 06 Oct 2005 09:16:24 -0400
Message-Id: <1128604584.15836.67.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-10-03 at 12:29 -0400, Stephen Smalley wrote:
> Next question is error handling in
> either getseuserbyname() itself or in the caller, given that you are
> converting pam_selinux and the SELinux patches to always call this
> function.  If seusers.conf doesn't exist, getseuserbyname() could simply
> set the *seuser to the linuxuser, set the *level to NULL and return
> success to the caller, so that the caller would then call
> get*_with_level with the Linux user and a NULL level, and that function
> in turn would devolve to the normal get* call with the Linux user.  That
> would provide equivalence to the current behavior if seusers.conf
> doesn't exist on the system.  Downside is that if seusers.conf were
> accidentally "lost", user might end up gaining greater access than
> desired because user_u might be authorized for all categories in the
> kernel policy.  Similar issue exists if seusers.conf exists but contains
> no default entry and no matching entry for the Linux user, as you
> mentioned earlier.  Possibly /etc/selinux/config should specify whether
> user mapping is enabled or disabled explicitly?  Then getseuserbyname
> could use that to determine whether it should just fall back to the
> Linux user and NULL level always, or try accessing seusers.conf.
> Thoughts?

Any thoughts on this issue?  I just added support for the optional
SETLOCALDEFS= definition (defaults to 1, preserving current logic for
setting local users and booleans) in /etc/selinux/config to libselinux
for the new load policy logic, so I could also add support for an
optional REQUIRESEUSERS= definition (defaulting to 0) to it.  Then, if
the definition is set to 1, and /etc/seusers.conf doesn't exist,
getseuserbyname will return an error as it currently does; otherwise, it
will just set *seuser to a copy of the linuxuser and set the level to
NULL so that we end up with no change in behavior when not using
seusers.conf.  Of course, someone will ultimately need to update
system-config-securitylevel to deal with these additional settings.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
