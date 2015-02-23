Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1NG2hMh010620
 for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2015 11:02:43 -0500
Message-ID: <54EB4F05.8010601@tycho.nsa.gov>
Date: Mon, 23 Feb 2015 11:02:13 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Fwd: [PATCH] proc.5:  Fix SELinux /proc/pid/attr/current example.
References: <1424705805-2782-1-git-send-email-sds@tycho.nsa.gov>
In-Reply-To: <1424705805-2782-1-git-send-email-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


FYI.

-------- Forwarded Message --------
Subject: [PATCH] proc.5:  Fix SELinux /proc/pid/attr/current example.
Date: Mon, 23 Feb 2015 10:36:45 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
To: mtk.manpages@gmail.com
CC: linux-man@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>

Since the /proc/pid/attr API was added to the kernel, there have
been a couple of changes to the SELinux handling of /proc/pid/attr/current.
Fix the SELinux /proc/pid/attr/current example text to reflect these
changes and note which kernel versions first included the changes.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 man5/proc.5 | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/man5/proc.5 b/man5/proc.5
index d01a7a9..68772f3 100644
--- a/man5/proc.5
+++ b/man5/proc.5
@@ -101,13 +101,27 @@ This directory is present only if the kernel was
configured with
 The contents of this file represent the current
 security attributes of the process.

-In SELinux, this file is used to get the security context of a process,
-but not to set the security context (a write is always denied),
-since SELinux limits process security transitions to
+In SELinux, this file is used to get the security context of a process.
+Prior to Linux 2.6.11, this file could not be used to set the security
+context (a write was always denied), since SELinux limited process security
+transitions to
 .BR execve (2)
 (see the description of
 .IR /proc/[pid]/attr/exec ,
 below).
+Since Linux 2.6.11, SELinux lifted this restriction and began supporting
+"set" operations via writes to this node if authorized by policy,
+although use of this operation is only suitable for applications that are
+trusted to maintain any desired separation between the old and new security
+contexts.  Prior to Linux 2.6.28, SELinux did not allow threads within a
+multi-threaded process to set their security context via this node
+as it would yield an inconsistency among the security contexts of the
+threads sharing the same memory space.  Since Linux 2.6.28, SELinux lifted
+this restriction and began supporting "set" operations for threads within
+a multi-threaded process if the new security context is bounded by the old
+security context, where the bounded relation is defined in policy and
+guarantees that the new security context has a subset of the permissions
+of the old security context.
 Other security modules may choose to support "set" operations via
 writes to this node.
 .TP
-- 
1.9.3
