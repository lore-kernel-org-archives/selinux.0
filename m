Subject: Updated SELinux Release
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 09 Mar 2005 16:02:20 -0500
Message-Id: <1110402140.6299.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

An updated SELinux release is available from the NSA SELinux web site;
see http://www.nsa.gov/selinux/news.cfm#R050309. 

This release is based on Linux 2.6.11.  The SELinux kernel patch for
2.6.11 includes enhanced MLS support, changes to the execute-related
permission checking for legacy binaries, and an extension to the
/proc/pid/attr API to allow use by scripts.  Enhanced MLS support has
been merged into the userspace libraries and tools.  The libraries and
tools have been modified to allow local customization of file contexts
and users without requiring policy sources, and to preserve certain
types that are marked as being customizable upon relabels.  A helper
for running init scripts under a pty from run_init was merged.
setfiles was rewritten to use the matchpathcon library function.  The
technical reports in the selinux-doc package were updated to reflect
the current SELinux code.  The contributors page was updated.
Numerous patches for the userspace libraries, tools, and policy were
merged.  Updated versions of setools, slat, and polgen were added.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
