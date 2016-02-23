Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u1NKOUw5020565
 for <selinux@tycho.nsa.gov>; Tue, 23 Feb 2016 15:24:36 -0500
Received: by mail-pa0-f44.google.com with SMTP id yy13so115792925pab.3
 for <selinux@tycho.nsa.gov>; Tue, 23 Feb 2016 12:24:31 -0800 (PST)
From: Daniel Cashman <dcashman@android.com>
To: selinux@tycho.nsa.gov
Cc: nnk@google.com, jeffv@google.com, sds@tycho.nsa.gov,
 dcashman <dcashman@android.com>
Subject: [PATCH 2/2] libselinux: procattr: return einval for <= 0 pid args.
Date: Tue, 23 Feb 2016 12:24:00 -0800
Message-Id: <1456259040-13721-3-git-send-email-dcashman@android.com>
In-Reply-To: <1456259040-13721-2-git-send-email-dcashman@android.com>
References: <1456259040-13721-1-git-send-email-dcashman@android.com>
 <1456259040-13721-2-git-send-email-dcashman@android.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: dcashman <dcashman@android.com>

getpidcon documentation does not specify that a pid of 0 refers to the
current process, and getcon exists specifically to provide this
functionality, and getpidcon(getpid()) would provide it as well.
Disallow pid values <= 0 that may lead to unintended behavior in
userspace object managers.

Signed-off-by: Daniel Cashman <dcashman@android.com>
---
 libselinux/src/procattr.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
index c20f003..eee4612 100644
--- a/libselinux/src/procattr.c
+++ b/libselinux/src/procattr.c
@@ -306,11 +306,21 @@ static int setprocattrcon(const char * context,
 #define getpidattr_def(fn, attr) \
 	int get##fn##_raw(pid_t pid, char **c)	\
 	{ \
-		return getprocattrcon_raw(c, pid, #attr); \
+		if (pid <= 0) { \
+			errno = EINVAL; \
+			return -1; \
+		} else { \
+			return getprocattrcon_raw(c, pid, #attr); \
+		} \
 	} \
 	int get##fn(pid_t pid, char **c)	\
 	{ \
-		return getprocattrcon(c, pid, #attr); \
+		if (pid <= 0) { \
+			errno = EINVAL; \
+			return -1; \
+		} else { \
+			return getprocattrcon(c, pid, #attr); \
+		} \
 	}
 
 all_selfattr_def(con, current)
-- 
2.7.0.rc3.207.g0ac5344
