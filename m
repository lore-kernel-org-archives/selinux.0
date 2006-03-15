Received: from moss-spartans.epoch.ncsc.mil (moss-spartans [144.51.25.121])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2FKsCJG000832
	for <selinux@tycho.nsa.gov>; Wed, 15 Mar 2006 15:54:12 -0500
Subject: ANN:  Updated SELinux Release
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 15 Mar 2006 15:59:14 -0500
Message-Id: <1142456354.4933.121.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

An updated SELinux release is available from the NSA SELinux web site;
see:
http://www.nsa.gov/selinux/news.cfm#R060315

This release is based on Linux 2.6.16-rc6, which already includes a
number of changes to SELinux that have been upstreamed, such as the
ptrace bug fix, an inode security structure memory leak, the IPSEC hooks
for implicit packet labeling, an XFS workaround to restore support for
labeling of new inodes, and several cleanups.  The SELinux patch for
2.6.16-rc6 includes several minor fixes and cleanups that will likely go
into 2.6.17; most of these changes are already in -mm.  The patch does
not include other enhancements such as the peersec work that is already
queued in the netdev tree for 2.6.17.

In userspace, a number of enhancements and fixes to the libraries and
utilities have been merged.  The enhancements include audit
functionality for newrole and semanage, support for manipulation of
active booleans, ports, nodes, and file contexts via libsemanage,
support for including seusers and users_extra information in policy
packages, and support for optionals in the base policy module.  Role
dominance support has also been fixed in checkpolicy.  A number of
optimizations to the libraries and to the file labeling utilities
(setfiles, restorecon) have been merged.

The example policy has been archived to the historical versions page and
is no longer being maintained.  It has been superseded by the reference
policy project.

The Implementing SELinux as a Linux Security Module technical report has
been updated a little to reflect some of the more recent changes to
SELinux, but no major content has been added.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
