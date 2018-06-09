Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w59JVBQ5000943
 for <selinux@tycho.nsa.gov>; Sat, 9 Jun 2018 15:31:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC16.oob.disa.mil (Postfix) with SMTP id 4138XB5XvBz2Vp8W
 for <selinux@tycho.nsa.gov>; Sat,  9 Jun 2018 19:31:06 +0000 (UTC)
Received: from UPBD19PA06.eemsg.mil (unknown [192.168.18.7])
 by UPDCF3IC16.oob.disa.mil (Postfix) with ESMTP id 4138XB4kQ4z2Vp8T
 for <selinux@tycho.nsa.gov>; Sat,  9 Jun 2018 19:31:06 +0000 (UTC)
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 76C1C56479C
 for <selinux@tycho.nsa.gov>; Sat,  9 Jun 2018 21:31:05 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat,  9 Jun 2018 21:30:30 +0200
Message-Id: <20180609193031.2728-2-nicolas.iooss@m4x.org>
In-Reply-To: <20180609193031.2728-1-nicolas.iooss@m4x.org>
References: <20180609193031.2728-1-nicolas.iooss@m4x.org>
Subject: [PATCH 2/3] libsepol/tests: fix use of unitialized variable
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When write_binary_policy() fails to open the binary policy, it calls
sepol_handle_destroy(f.handle) but structure f has not been initialized
at this point. Use variable handle instead.

This issue has been found using clang's static analyzer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/tests/test-downgrade.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/tests/test-downgrade.c b/libsepol/tests/test-downgrade.c
index 50807c1dd6ea..963f3fabedc7 100644
--- a/libsepol/tests/test-downgrade.c
+++ b/libsepol/tests/test-downgrade.c
@@ -254,7 +254,7 @@ int write_binary_policy(const char *path, policydb_t *p)
 	if ((out_fp = fopen(path, "w" )) == NULL) {
 		fprintf(stderr, "Unable to open %s: %s\n", path,
 			strerror(errno));
-		sepol_handle_destroy(f.handle);
+		sepol_handle_destroy(handle);
 		return -1;
 	}
 
-- 
2.17.1
