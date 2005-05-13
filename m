Subject: Re: Busted by constraints.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <1116012601.3576.183.camel@moss-spartans.epoch.ncsc.mil>
References: <428368FF.2080603@redhat.com>
	 <1115908243.32202.114.camel@moss-spartans.epoch.ncsc.mil>
	 <42836C4C.6010301@redhat.com>
	 <1115996428.3576.47.camel@moss-spartans.epoch.ncsc.mil>
	 <1116012601.3576.183.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 13 May 2005 16:00:55 -0400
Message-Id: <1116014455.3576.186.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-05-13 at 15:30 -0400, Stephen Smalley wrote:
> In creating audit2why, I ran into the known namespace collision between
> libsepol and libselinux; they both define the base set of Flask types,
> with the one set of definitions for security-aware applications running
> on SELinux and the other set of definitions for the binary policy and
> the userspace security server code (the latter is only exported by the
> static libsepol, not the shared library).  I worked around the collision
> temporarily in audit2why.c by not including selinux.h and manually
> defining function prototypes for the functions from libselinux, but I
> think we should eliminate the collision by applying the attached script
> to all *.[chy] files in libsepol and checkpolicy and then applying the
> attached patch to audit2why.  I don't think we want to actually fold the
> types together, as the libsepol definitions need to stay consistent with
> the binary policy format whereas the libselinux ones don't need to be
> fixed size (and in the case of security_id_t we cannot fold them since
> one is an integer and the other is a struct).  Seem reasonable?

Ah, there was one duplicated expression in the sed script, but otherwise
it yielded the expected result, and the resulting libsepol, checkpolicy,
and audit2why all build as expected.  Committed to sourceforge CVS.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
