Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h41JbaI4012399
	for <selinux@tycho.nsa.gov>; Thu, 1 May 2003 15:37:36 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h41JbPVf000292
	for <selinux@tycho.nsa.gov>; Thu, 1 May 2003 19:37:25 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h41JbP4D000289
	for <selinux@tycho.nsa.gov>; Thu, 1 May 2003 19:37:25 GMT
Subject: [RFC] SELinux security module
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: lkml <linux-kernel@vger.kernel.org>, lsm <linux-security-module@wirex.com>,
   Greg Kroah-Hartman <greg@kroah.com>, Chris Wright <chris@wirex.com>,
   Christoph Hellwig <hch@infradead.org>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1051817849.1377.372.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 01 May 2003 15:37:30 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Although there are still a number of patches that need to be merged
before the SELinux module can be merged, I'd like to go ahead and invite
comments on the SELinux security module now so that we can work on
improving it in parallel.  An updated set of patches against 2.5.68 and
an archive with some corresponding userland components is available
under http://www.nsa.gov/selinux/lk.  The SELinux module is contained in
http://www.nsa.gov/selinux/lk/A07selinux.patch.gz.  It depends on the
following other patches in that directory that are being submitted
separately:

A01proc.patch.gz - process attribute API
A02lsmxattr.patch.gz - changes to the LSM xattr hooks
A03dinstantiate.patch.gz - changes to the LSM d_instantiate hook
A04ext2xattr.patch.gz - xattr handler for ext2
A05ext3xattr.patch.gz - xattr handler for ext3
A06init.patch.gz - early initialization for security modules (by Chris
Wright)
libfs.patch.gz - changes to libfs by Al Viro that have already been
merged into -bk

All of the above patches except for libfs.patch.gz are contained in the
2.5.68-selinux1.patch.gz patch.  Some userland components are contained
in the selinux-2.5.tgz archive.  

The basic layout of the SELinux module code under security/selinux is as
follows:
1) include/linux/flask/*.h - These headers define the interfaces
between the components of SELinux, i.e. the security server (policy
engine), access vector cache, and persistent label mapping, as well as
some basic types and constants for the architecture.  We can likely move
these headers up to the top level security/selinux directory; their
current placement is an artifact of the original SELinux kernel patch
(pre-LSM), where we directly added them to the existing kernel include
hierarchy and the SELinux components were not all together in a single
subtree as they are now.  When we transitioned to LSM, we simply
relocated the headers within the SELinux module subtree, but kept the
include/linux/flask hierarchy.

2) hooks.c - These are the security hook functions that manage the
security information for kernel objects and enforce the access controls.
This file is likely to be of the greatest interest to people.
I expect the handling of proc and the genfs stuff to be supplanted
by xattr handlers in the various pseudo filesystem types.

3) avc.c - the access vector cache, a cache of access decisions.  The
hook functions in hooks.c invoke the AVC interface
(include/linux/flask/avc.h) to obtain access decisions.

4) ss/*.[ch] - the security server (policy engine).  The AVC invokes the
security interface (include/linux/flask/security.h) to compute access
decisions on a cache miss, and the hook functions invoke the security
interface to obtain other kinds of security decisions, such as labeling
decisions.  The security server can also call the AVC
(include/linux/flask/avc_ss.h) to manage the cache for policy changes or
dynamic policies.  This is merely one possible security server; the
architecture allows for others to be dropped in behind the security
interface without affecting the rest of the SELinux code, and the
interface is designed to provide general support for security policies.

5) selinuxfs.c - the security policy API, reimplemented via a pseudo fs
like nfsd.  This is the API exported to SELinux applications by the
security server for obtaining policy decisions and loading policy
configurations.  Naturally, the actual API is encapsulated by a library,
see selinux-2.5/libselinux in selinux-2.5.tgz.  Note that this API does
not deal with providing userspace access to process or file security
labels; that is handled by the separate /proc/pid/attr API and xattr
API, also encapsulated by libselinux for SELinux applications.

6) psid.c - the persistent label mapping.  This provided a mechanism for
storing file security labels on conventional filesystems using some
mapping files (inode->psid, psid->context) prior to our transition to
using xattr.  The hook functions can call the psid API
(include/linux/flask/psid.h) to setup or release the mapping and to get
and set file security labels.  At present, the hook functions fall back
to the persistent label mapping if xattr isn't supported or the
attribute hasn't been assigned to the filesystem (e.g. initial boot of
new SELinux kernel after using old SELinux kernel).  I was inclined to
keeping this component around for conventional filesystem types that
don't provide xattrs, but I'm not sure that it is worthwhile to do so
unless we can provide a transparent redirection of xattr calls to it for
filesystems that don't provide native xattr support.

Documentation of SELinux can be found at
http://www.nsa.gov/selinux/docs.html.  That documentation does not
reflect the changes to the API and implementation that we have been
making in preparing for submission to mainline 2.5 (and is in fact
out-of-date anyway with regard to the implementation), but is useful in
terms of understanding the architecture and design. Some background
information about SELinux is available from
http://www.nsa.gov/selinux/background.html.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
