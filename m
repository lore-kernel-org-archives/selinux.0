From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: use /proc/thread-self when available
Date: Mon, 13 Jul 2015 09:09:18 -0400
Message-Id: <1436792958-16436-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, eparis@redhat.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Linux 3.16 introduced a /proc/thread-self symlink that can be used
to reference the proc files of the current thread without needing to
use gettid(2).  Use this symlink when it exists, falling back to
using gettid(2) when it does not.  This is generally beneficial, but
was specifically motivated by https://github.com/systemd/systemd/issues/475.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/procattr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
index f990350..e444571 100644
--- a/libselinux/src/procattr.c
+++ b/libselinux/src/procattr.c
@@ -95,6 +95,12 @@ static int openattr(pid_t pid, const char *attr, int flags)
 	if (pid > 0)
 		rc = asprintf(&path, "/proc/%d/attr/%s", pid, attr);
 	else {
+		rc = asprintf(&path, "/proc/thread-self/attr/%s", attr);
+		if (rc < 0)
+			return -1;
+		fd = open(path, flags | O_CLOEXEC);
+		if (fd >= 0 || errno != ENOENT)
+			goto out;
 		if (!tid)
 			tid = gettid();
 		rc = asprintf(&path, "/proc/self/task/%d/attr/%s", tid, attr);
@@ -103,6 +109,7 @@ static int openattr(pid_t pid, const char *attr, int flags)
 		return -1;
 
 	fd = open(path, flags | O_CLOEXEC);
+out:
 	free(path);
 	return fd;
 }
-- 
2.1.0
