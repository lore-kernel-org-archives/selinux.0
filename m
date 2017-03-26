Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2QGNHCN007737
 for <selinux@tycho.nsa.gov>; Sun, 26 Mar 2017 12:23:17 -0400
Received: by mail-wr0-f194.google.com with SMTP id u1so6095027wra.3
 for <selinux@tycho.nsa.gov>; Sun, 26 Mar 2017 09:23:04 -0700 (PDT)
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: [PATCH 1/3] policycoreutils/setfiles: stdout messages don't need
 program prefix
Date: Sun, 26 Mar 2017 17:22:43 +0100
Message-Id: <20170326162245.21135-1-alan.christopher.jenkins@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I suggested that if you run a command for its informational output (by
passing  `-v`), you don't expect it to be prefixed with the program name.
Prefixing is used for error messages, so you can tell where your shell
script blew up :).  If a script is running a command for its informational
output, it's usually the script's responsibility to make sure it's in
context, e.g. providing headers if there are multiple sections of output.

Removing the program name from setfiles/restorecon output is particularly
useful because it generates very long lines.  But also, it actually helps
highlight where there are error messages - the prefix will make them
stand out visually.

Signed-off-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
---
 policycoreutils/setfiles/setfiles.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 6f69c90..83e0b2a 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -142,9 +142,15 @@ static int __attribute__ ((format(printf, 2, 3)))
 log_callback(int type, const char *fmt, ...)
 {
 	int rc;
-	FILE *out = (type == SELINUX_INFO) ? stdout : stderr;
+	FILE *out;
 	va_list ap;
-	fprintf(out, "%s: ", r_opts.progname);
+
+	if (type == SELINUX_INFO) {
+		out = stdout;
+	} else {
+		out = stderr;
+		fprintf(out, "%s: ", r_opts.progname);
+	}
 	va_start(ap, fmt);
 	rc = vfprintf(out, fmt, ap);
 	va_end(ap);
-- 
2.9.3
