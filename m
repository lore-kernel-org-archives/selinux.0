Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA3FhJXZ015419
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 10:43:19 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA3Ffw4w016570
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 15:41:58 GMT
Received: from [144.51.25.121] (moss-spartans [144.51.25.121])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA3FhU1H020143
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 10:43:30 -0500 (EST)
Subject: Updated SELinux Release
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1099496380.1213.111.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 03 Nov 2004 10:39:40 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

An updated SELinux release is available from the NSA SELinux web site;
see http://www.nsa.gov/selinux/news.cfm#R041102.  This release is based
on Linux 2.6.9, but the current SELinux patch for the kernel includes a
number of changes made after 2.6.9 was released, including the xattr
code consolidation, the send_sigurg mediation, the setscheduler deadlock
fix, the locking fixes for the sidtab and netif table, and the AVC
scalability work.  The checkpolicy policy compiler has been updated to
preserve port context ordering in order to allow sensible use of port
ranges, and this facility is now used by the example policy to map all
otherwise unspecified reserved ports to a distinct type that can be
tightly controlled.  Numerous improvements to libselinux,
policycoreutils, and policy have been merged.  An updated version of
setools from Tresys has been merged.  Updated userland patches and SRPMS
have been merged from the Fedora Core 3 development tree.

This release includes the first public release of a new tool by MITRE,
polgen, which attempts to generate policy for an application based on
patterns in its behavior.  polgen works by running a program under a
modified strace that supplements the normal trace output with security
context information, applying a set of filters to the enhanced trace
output, and running the filtered trace data through a pattern recognizer
that identifies common patterns and proposes suitable policy based on
these patterns.  A complete worked example is provided to help
illustrate the use of the tool, see the documentation available under
the doc subdirectory of the polgen source tree.  Please experiment with
this tool and provide feedback to help shape its future development.

I'd like to propose a couple of changes for future SELinux releases for
discussion:

1) I'd like to revive the proposal I originally made in 
http://marc.theaimsgroup.com/?l=selinux&m=107669747828428&w=2, i.e. drop
patched userland packages from the upstream SELinux releases and simply
refer people to the appropriate sites for the various distros (as is
already done in the selinux-doc README).  Maintenance of the SELinux
userland patches has been handled entirely by others for quite some
time, and I don't see any valid reason for us to continue carrying them
on the NSA site.  We only carry a small subset of the patched userland
packages on our site anyway (compared to the far more extensive set in
Fedora), and our site will always lag behind the latest versions
available for the various distros.  If a reference set is desired, it
could always be placed on the sourceforge site, although I think that a
review should be done of the complete set of patched packages in Fedora
to see whether any other packages should be included in the reference
set (and note that in some cases, SELinux modifications have been
directly integrated into the Fedora source tree and are not carried as
separate patches anymore).

2) I'd like to do away with the complete prepatched kernel tarball and
full userland tarball, and only distribute a kernel patch and the
individual component tarballs for checkpolicy, libsepol, libselinux,
policycoreutils, etc.  The prepatched kernel tarball doesn't seem very
useful to me, as most people likely want to combine the SELinux kernel
patch with other patches and prebuilt kernel packages with SELinux
support are available for the various distros now.  The full userland
tarball seems redundant to me, and packagers of SELinux are using the
individual component tarballs anyway.  Any objections to dropping these
two tarballs?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
