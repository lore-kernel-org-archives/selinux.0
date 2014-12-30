Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sBUN1GEn017186
 for <selinux@tycho.nsa.gov>; Tue, 30 Dec 2014 18:01:16 -0500
Received: by mail-wg0-f45.google.com with SMTP id b13so21302854wgh.4
 for <selinux@tycho.nsa.gov>; Tue, 30 Dec 2014 15:01:14 -0800 (PST)
Received: from eversmanni.localdomain (32.206.133.77.rev.sfr.net.
 [77.133.206.32])
 by mx.google.com with ESMTPSA id hn2sm55493069wjc.5.2014.12.30.15.01.12
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 30 Dec 2014 15:01:13 -0800 (PST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] run_init: fix open_init_pty avaibility check
Date: Wed, 31 Dec 2014 00:00:53 +0100
Message-Id: <1419980453-10431-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

If /usr/sbin/open_init_pty is not found or is not executable,
access("/usr/sbin/open_init_pty", X_OK) returns -1, not zero.

Use "!= 0" like in other places in SELinux userland libraries and tools.
---
 policycoreutils/run_init/run_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/run_init/run_init.c b/policycoreutils/run_init/run_init.c
index 129db730a9c2..4bc32b1cbdb7 100644
--- a/policycoreutils/run_init/run_init.c
+++ b/policycoreutils/run_init/run_init.c
@@ -406,7 +406,7 @@ int main(int argc, char *argv[])
 			new_context);
 		exit(-1);
 	}
-	if (! access("/usr/sbin/open_init_pty", X_OK)) {
+	if (access("/usr/sbin/open_init_pty", X_OK) != 0) {
 		if (execvp(argv[1], argv + 1)) {
 			perror("execvp");
 			exit(-1);
-- 
2.2.1
