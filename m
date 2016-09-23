From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: [PATCH] libselinux: kill logging check for selinux_enabled()
Date: Fri, 23 Sep 2016 12:24:10 -0700
Message-Id: <1474658650-10685-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

Drop the check for selinux_enabled() on logging. The
caller can silence the logs by setting the logging
callback and discarding the messages.

Change-Id: Ia6769ef7ad8cc2144ad2bb73e5bf7c76ebfe487b
Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/callbacks.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/libselinux/src/callbacks.c b/libselinux/src/callbacks.c
index cdf7b63..c3cf98b 100644
--- a/libselinux/src/callbacks.c
+++ b/libselinux/src/callbacks.c
@@ -16,7 +16,6 @@ default_selinux_log(int type __attribute__((unused)), const char *fmt, ...)
 {
 	int rc;
 	va_list ap;
-	if (is_selinux_enabled() == 0) return 0;
 	va_start(ap, fmt);
 	rc = vfprintf(stderr, fmt, ap);
 	va_end(ap);
-- 
1.9.1
