Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j17HAl53021396
	for <selinux@tycho.nsa.gov>; Mon, 7 Feb 2005 12:10:48 -0500 (EST)
Subject: RE: Best way to label a filesystem for another system
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Villalovos, John L" <john.l.villalovos@intel.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <60C14C611F1DDD4198D53F2F43D8CA3B0365B114@orsmsx410>
References: <60C14C611F1DDD4198D53F2F43D8CA3B0365B114@orsmsx410>
Content-Type: text/plain
Message-Id: <1107795846.11907.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 07 Feb 2005 12:04:06 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-02-04 at 17:18, Villalovos, John L wrote:
> So is there an option or anything to have setfiles not use the currently
> running policy to verify things?  Can you specify different files for it
> to use to verify information?

setfiles -c /path/to/binarypolicy /path/to/filecontexts will validate a
given file contexts configuration against a given binary policy (and
this is done upon a make policy to check it during policy builds), but
the -c option only performs validation of the file_contexts, not
relabeling of anything on the filesystem.  Even if setfiles were changed
to proceed to relabeling after validation for the -c option, the kernel
would prevent setfiles from setting the security.selinux extended
attribute to a value that it cannot interpret (e.g. not defined in the
policy).

> Can I just disable SE Linux on the host system before I run setfiles and
> then enable it afterwards?  Is that even possible?  I know I can turn
> off the enforcement but can I turn off SE Linux being enabled from a
> command line tool or do I need to actually reboot and disable it?

SELinux can only be disabled prior to initial policy load, and cannot be
enabled after a disable (because it will stop tracking kernel objects at
that point, and you will thus have kernel objects with no security
structures if you later try to re-enable).  Enforcing mode can be
changed at runtime via /selinux/enforce but that isn't sufficient here,
as even permissive mode won't let you set an invalid security context as
an extended attribute; the kernel still wants to be able to interpret
the security context and map it to an internal representation.  There
are two forms of disabling; you can boot with selinux=0, or you can
write a 1 to /selinux/disable prior to initial policy load.  /sbin/init
will do the latter for you if you set SELINUX=disabled in
/etc/selinux/config and reboot.

> I hope these aren't stupid questions.

No, quite reasonable, but given the nature of MAC, you can't just apply
a different policy to a different part of the filesystem.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
