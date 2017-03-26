Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2QGNHCP007737
 for <selinux@tycho.nsa.gov>; Sun, 26 Mar 2017 12:23:20 -0400
Received: by mail-wr0-f193.google.com with SMTP id w43so3230619wrb.1
 for <selinux@tycho.nsa.gov>; Sun, 26 Mar 2017 09:23:11 -0700 (PDT)
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: [PATCH 2/3] policycoreutils/setfiles: don't scramble stdout and
 stderr together
Date: Sun, 26 Mar 2017 17:22:44 +0100
Message-Id: <20170326162245.21135-2-alan.christopher.jenkins@gmail.com>
In-Reply-To: <20170326162245.21135-1-alan.christopher.jenkins@gmail.com>
References: <20170326162245.21135-1-alan.christopher.jenkins@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

https://bugzilla.redhat.com/show_bug.cgi?id=1435894

When output to a non-tty (as caused by the implementation of fixfiles),
stdout is fully buffered.  stdout should be flushed before writes to
stderr.

See e.g. https://news.ycombinator.com/item?id=1271015

Signed-off-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
---
 policycoreutils/setfiles/setfiles.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 83e0b2a..bc83c27 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -149,6 +149,7 @@ log_callback(int type, const char *fmt, ...)
 		out = stdout;
 	} else {
 		out = stderr;
+		fflush(stdout);
 		fprintf(out, "%s: ", r_opts.progname);
 	}
 	va_start(ap, fmt);
-- 
2.9.3
