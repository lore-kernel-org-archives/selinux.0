Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBAHB9Ii021663
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 12:11:10 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBAH9Wwg008984
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 17:09:32 GMT
Subject: Re: Single home directory type for all roles.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
   SE Linux list <selinux@tycho.nsa.gov>
In-Reply-To: <200412101700.iBAH06eq019975@turing-police.cc.vt.edu>
References: <20041210161940.57421.qmail@web50204.mail.yahoo.com>
	 <200412101700.iBAH06eq019975@turing-police.cc.vt.edu>
Content-Type: text/plain
Message-Id: <1102698383.1628.144.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 10 Dec 2004 12:06:23 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-12-10 at 12:00, Valdis.Kletnieks@vt.edu wrote:
> Why am I making a point about this?  Because we're presumably working on
> something that will be in the *mainline* kernel, and have support in the
> default .ISO images shipped by vendors - and I don't know of any Unix vendor
> who's shipped this stuff in their *mainline* product.
> 
> And *that* is uncharted territory indeed.  VMS is probably the closest thing to
> Unix/Linux that actually used stuff like SYS$WHATEVER inside a filename to get
> a similar effect to moldy directories *and* carry it through all the way for
> the base system...

My view on this is that we need to build a mechanism that leverages the
existing per-process namespace and bind mount support in Linux.  If
implementing it in userspace using only those existing kernel
mechanisms, the basic idea would be something like:

1) login-style programs would consult a configuration file that
specifies the list of candidate directories for polyinstantiation (e.g.
/tmp, $HOME),
2) The programs would then invoke security_compute_member() (the SELinux
interface for selecting a member of a polyinstantiated object) between
the user context and the top-level directory context for each of these
directories,
3) If security_compute_member() returns a different context than the
context on the top-level directory, then this indicates that
polyinstantiation of that directory is specified by the policy.  In that
case, the program would lookup or create the member subdirectory with
the returned member context, using a function of the member context as
the name of the member subdirectory (e.g. a hash of it).
4) If any polyinstantiation was indicated, then the program would clone
a child with a separate namespace rather than just using fork for
creating the child.
5) For each directory for which polyinstantiation was indicated the
child would bind mount the original directory under a different name to
allow referencing by security-aware applications that need to access
multiple members (if allowed by policy), then bind mount the member
subdirectory over the original directory location.
6) The child process can then exec the user shell, which will operate in
the new namespace.

Some thought would have to be given into how to handle programs like
su/newrole/newlevel, where you then need to re-bind to a different
member.  Since the original directory will be accessible under a
different name (e.g. /tmp -> /.tmp) if allowed by policy, it should be
possible to have them perform such re-binding.

This will also have implication for other software that presently
assumes a global namespace, e.g. autofs/automount won't work properly in
an environment where most user sessions have their own namespace.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
