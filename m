Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7AHMCrT004614
	for <selinux@tycho.nsa.gov>; Tue, 10 Aug 2004 13:22:12 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7AHMBlU008383
	for <selinux@tycho.nsa.gov>; Tue, 10 Aug 2004 17:22:11 GMT
Subject: Re: Now that SELinux supports booleans should we replace
	tunableswith booleans?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Timothy Wood <timothy@diyab.net>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, selinux-dev@tresys.com
In-Reply-To: <41190079.9020206@diyab.net>
References: <200408101429.i7AET6Sf010692@gotham.columbia.tresys.com>
	 <41190079.9020206@diyab.net>
Content-Type: text/plain
Message-Id: <1092158438.6094.84.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 10 Aug 2004 13:20:38 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-08-10 at 13:06, Timothy Wood wrote:
> Why not add an option to load_policy that would force loading of boolean
> values from the policy.  If you specify that option load_policy modifies
> the current boolean values to the policy defaults.  If you do not
> specify the option load_policy does not touch current boolean values.
> 
> You could do the same thing with a tunable and have load_policy check
> for the tunable value.

The latest version of load_policy in the sourceforge CVS tree defaults
to preserving the current boolean settings set under /selinux/booleans,
but has a '-b' option to instead set the booleans to the boot-time
boolean defaults defined by /etc/selinux/$SELINUXTYPE/booleans (or
optionally another specified file).  We could add another option as you
suggest, although in that case, load_policy doesn't have to modify
anything - it just loads the binary policy unmodified, and the kernel
will automatically reset the booleans to the compile-time policy
defaults.  It is only the case where we want to preserve the current
boolean settings or the boot-time boolean defaults that we need to
modify the in-memory policy prior to loading.  Tunables aren't
applicable here, as they are purely a policy source construct (actually
a preprocessor construct), and aren't visible to load_policy in any way.

It would be easy to add such an option, but I'm not clear if that is
what one would want.  If you truly want to force a reset to the
compile-time policy defaults, you could just remove
/etc/selinux/$SELINUXTYPE/booleans prior to calling load_policy -b.  If
you don't remove the booleans file, then it is going to reset back to
the boot-time configuration upon next boot, which is likely not what you
want if your goal is to force use of the compile-time defaults.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
