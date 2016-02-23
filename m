Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u1NKOUw1020565
 for <selinux@tycho.nsa.gov>; Tue, 23 Feb 2016 15:24:31 -0500
Received: by mail-pa0-f50.google.com with SMTP id fy10so115710539pac.1
 for <selinux@tycho.nsa.gov>; Tue, 23 Feb 2016 12:24:28 -0800 (PST)
From: Daniel Cashman <dcashman@android.com>
To: selinux@tycho.nsa.gov
Cc: nnk@google.com, jeffv@google.com, sds@tycho.nsa.gov,
 dcashman <dcashman@android.com>
Subject: [PATCH 1/2] libselinux: procattr: return error on invalid pid_t input.
Date: Tue, 23 Feb 2016 12:23:59 -0800
Message-Id: <1456259040-13721-2-git-send-email-dcashman@android.com>
In-Reply-To: <1456259040-13721-1-git-send-email-dcashman@android.com>
References: <1456259040-13721-1-git-send-email-dcashman@android.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: dcashman <dcashman@android.com>

Signed-off-by: Daniel Cashman <dcashman@android.com>
---
 libselinux/src/procattr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
index 527a0a5..c20f003 100644
--- a/libselinux/src/procattr.c
+++ b/libselinux/src/procattr.c
@@ -70,9 +70,9 @@ static int openattr(pid_t pid, const char *attr, int flags)
 	char *path;
 	pid_t tid;
 
-	if (pid > 0)
+	if (pid > 0) {
 		rc = asprintf(&path, "/proc/%d/attr/%s", pid, attr);
-	else {
+	} else if (pid == 0) {
 		rc = asprintf(&path, "/proc/thread-self/attr/%s", attr);
 		if (rc < 0)
 			return -1;
@@ -82,6 +82,9 @@ static int openattr(pid_t pid, const char *attr, int flags)
 		free(path);
 		tid = gettid();
 		rc = asprintf(&path, "/proc/self/task/%d/attr/%s", tid, attr);
+	} else {
+		errno = EINVAL;
+		return -1;
 	}
 	if (rc < 0)
 		return -1;
-- 
2.7.0.rc3.207.g0ac5344
