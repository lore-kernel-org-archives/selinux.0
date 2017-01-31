From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: do not rely on non-POSIX behavior for write()
Date: Tue, 31 Jan 2017 16:28:30 -0500
Message-Id: <1485898110-24536-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The libselinux set{exec,fscreate,keycreate,sockcreate}con() functions
can be passed a NULL argument to reset to the default policy behavior.
Internally, this is implemented by calling write() with a 0 count
on the corresponding /proc/pid/attr file, and the kernel handles such
calls by clearing the corresponding attribute.  However, POSIX says that
a write() with a 0 count will return 0 without causing any other effect.
Change the libselinux implementation to first try writing a pair
of NUL bytes to the /proc/pid/attr file, which is also handled
by the kernel by clearing the corresponding attribute (for all kernels
>= 2.6.12), and only falling back to performing a write() with a 0 count
if this fails (for kernels < 2.6.12).  A pair of NUL bytes is written
rather than a single NUL byte to ensure that this is handled correctly
even on kernels that were checking the wrong byte (buf[1] instead
of buf[0]).

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/procattr.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
index 8cd59af..c8792f2 100644
--- a/libselinux/src/procattr.c
+++ b/libselinux/src/procattr.c
@@ -247,9 +247,14 @@ static int setprocattrcon_raw(const char * context,
 			ret = write(fd, context2, strlen(context2) + 1);
 		} while (ret < 0 && errno == EINTR);
 	} else {
+		char buf[2];
+
+		buf[0] = buf[1] = '\0';
 		do {
-			ret = write(fd, NULL, 0);	/* clear */
+			ret = write(fd, buf, 2);	/* clear */
 		} while (ret < 0 && errno == EINTR);
+		if (ret < 0 && errno == EINVAL)
+			ret = write(fd, NULL, 0);	/* clear */
 	}
 out:
 	errno_hold = errno;
-- 
2.7.4
