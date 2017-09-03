Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v83CKOX6026033
 for <selinux@tycho.nsa.gov>; Sun, 3 Sep 2017 08:20:24 -0400
Received: from localhost.localdomain (abo-140-56-69.avi.modulonet.fr
 [85.69.56.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id A5DBB5646D2
 for <selinux@tycho.nsa.gov>; Sun,  3 Sep 2017 14:20:07 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun,  3 Sep 2017 14:19:27 +0200
Message-Id: <20170903121928.24024-5-nicolas.iooss@m4x.org>
In-Reply-To: <20170903121928.24024-1-nicolas.iooss@m4x.org>
References: <20170903121928.24024-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH 5/6] restorecond: check write() and daemon() results
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When compiling restorecond with -Wunused, gcc 4.8.4 (from Ubuntu 14.04)
reports the following warnings:

    restorecond.c: In function ‘main’:
    restorecond.c:208:9: error: ignoring return value of ‘daemon’,
    declared with attribute warn_unused_result [-Werror=unused-result]
       daemon(0, 0);
             ^

    restorecond.c: In function ‘write_pid_file’:
    restorecond.c:106:2: error: ignoring return value of ‘write’,
    declared with attribute warn_unused_result [-Werror=unused-result]
      (void)write(pidfd, val, (unsigned int)len);
      ^

If any of these calls returns an error, it is currently silently
discarded. Add a message in order to warn about such an error.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 restorecond/restorecond.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/restorecond/restorecond.c b/restorecond/restorecond.c
index f379db1e7f8d..6fbbd35dc1b3 100644
--- a/restorecond/restorecond.c
+++ b/restorecond/restorecond.c
@@ -103,7 +103,10 @@ static int write_pid_file(void)
 		pidfile = 0;
 		return 1;
 	}
-	(void)write(pidfd, val, (unsigned int)len);
+	if (write(pidfd, val, (unsigned int)len) != len) {
+		syslog(LOG_ERR, "Unable to write to pidfile (%s)", strerror(errno));
+		return 1;
+	}
 	close(pidfd);
 	return 0;
 }
@@ -204,8 +207,10 @@ int main(int argc, char **argv)
 	watch_file = server_watch_file;
 	read_config(master_fd, watch_file);
 
-	if (!debug_mode)
-		daemon(0, 0);
+	if (!debug_mode) {
+		if (daemon(0, 0) < 0)
+			exitApp("daemon");
+	}
 
 	write_pid_file();
 
-- 
2.14.1
