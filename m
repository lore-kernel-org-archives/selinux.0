Received: from moss-spartans.epoch.ncsc.mil (moss-spartans [144.51.25.121])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j87GS5Ob000236
	for <selinux@tycho.nsa.gov>; Wed, 7 Sep 2005 12:28:05 -0400 (EDT)
Subject: Updated SELinux Release
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
In-Reply-To: <1119466630.13181.175.camel@moss-spartans.epoch.ncsc.mil>
References: <1110402140.6299.22.camel@moss-spartans.epoch.ncsc.mil>
	 <1119466630.13181.175.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 07 Sep 2005 12:23:21 -0400
Message-Id: <1126110201.14896.80.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

An updated SELinux release is available from the NSA SELinux web site;
see http://www.nsa.gov/selinux/news.cfm#R050907.

This SELinux release is based on Linux 2.6.13.  The 2.6.13 kernel
includes the execstack and execheap permission checks contributed by
Lorenzo and the support for default labeling of the MLS field by James
Morris.  The SELinux kernel patch for 2.6.13 includes support for atomic
security labeling of new inodes (for ext2, ext3, tmpfs only at present),
a generic VFS fallback for getting and setting security attributes on
filesystems that do not natively support EAs, and memory optimizations
for the policy's avtab.  Several of these changes have already been
upstreamed into Linus' git tree while others remain pending in the -mm
patchset.

In userspace, a number of enhancements to the libraries and utilities
have been merged.  These enhancements include the support for the new
binary policy version with the optimized avtab, a number of improvements
in abstraction and organization within libsepol by Ivan Gyurdiev, the
loadable policy module support by Tresys Technology (affecting libsepol,
checkpolicy, policycoreutils and adding libsemanage), and the context
translation support in libselinux based on work by Trusted Computer
Solutions and Red Hat.  Numerous bug fixes have also been merged, many
submitted by Serge Hallyn of IBM based on bugs discovered using the
Coverity tool.

With regard to the new binary policy version, checkpolicy -c 19 can be
used to generate the prior binary policy version for kernels that do not
yet have the necessary support.  As usual, both the SELinux module and
checkpolicy/libsepol provide backward compatibility for older binary
policy versions.

With regard to the policy module support, selinux-doc/README.MODULES has
some basic documentation of the module support, but further
documentation and man pages will be needed.  Note that libsemanage is
currently only available as a static library and limited to managing
policy modules (due to its origins as libsemod); it will be expanded in
the future to provide a more complete policy management API and to
provide a shared library with a stable API/ABI.

In this release, we have also stopped carrying copies of setools, slat,
and polgen on nsa.gov itself, but continue to provide links to the
respective Tresys Technology and MITRE SELinux sites where the latest
versions can always be obtained.  This avoids having stale copies around
on nsa.gov and ensures that people always acquire the latest version.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
