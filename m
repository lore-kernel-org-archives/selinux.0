Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i79KDCrT028350
	for <selinux@tycho.nsa.gov>; Mon, 9 Aug 2004 16:13:12 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i79KDBIn008374
	for <selinux@tycho.nsa.gov>; Mon, 9 Aug 2004 20:13:11 GMT
Subject: Re: Now that SELinux supports booleans should we replace
	tunableswith booleans?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>,
   Daniel J Walsh <dwalsh@redhat.com>, selinux-dev@tresys.com
In-Reply-To: <1091809200.8590.96.camel@moss-spartans.epoch.ncsc.mil>
References: <200404141453.i3EEr2Jx015745@gotham.columbia.tresys.com>
	 <1091472796.23449.248.camel@moss-spartans.epoch.ncsc.mil>
	 <1091709011.11061.44.camel@moss-spartans.epoch.ncsc.mil>
	 <1091709228.11061.47.camel@moss-spartans.epoch.ncsc.mil>
	 <002201c47bce$22783840$0102a8c0@DESKTOP>
	 <1091809200.8590.96.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1092082317.29199.205.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 09 Aug 2004 16:11:57 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-08-06 at 12:20, Stephen Smalley wrote:
> Yes, it shouldn't be difficult to create a genpolbools utility similar
> to the recently created genpolusers utility.  However, I think that Dan
> would want the functionality available as a library function that
> operates entirely in-memory rather than on files, so that load_policy
> can directly invoke it on the mmap'd policy file to rewrite the binary
> policy in memory based on the separate saved boolean settings prior to
> loading it into the kernel.

This has now been implemented in the sourceforge CVS tree; the
checkpolicy core logic has been moved into a libsepol library, a
sepol_genbools() function for rewriting a binary policy in memory for
new boolean definitions has been added to libsepol, and load_policy has
been changed to use this function prior to reloading the policy.  A
separate genpolbools utility that performs the same transformation but
with files as input and output has also been added to the checkpolicy
tree.

> Under the proposed scheme, reboots and policy reloads would set the
> booleans to the values saved in /etc/selinux/$SELINUXTYPE/booleans
> (defaulting to the compile-time defaults if there was no value saved in
> that file for a given boolean).  Admins would edit that file (directly
> or using a tool) if they wanted the boolean setting to persist; if they
> only want a temporary change that will be reverted by a reboot or policy
> reload, then they would use setsebool to make that temporary change.

Karl has suggested that while /sbin/init should use this technique for
preserving booleans across reboots, /usr/sbin/load_policy should just
get the current boolean settings from selinuxfs and use them for policy
reloads, so that booleans do not change upon a policy reload by
default.  This is to ensure that booleans that represent system state
are not perturbed by policy reloads.  What do others think?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
