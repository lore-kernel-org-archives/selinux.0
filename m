Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w59JVBQ4000943
 for <selinux@tycho.nsa.gov>; Sat, 9 Jun 2018 15:31:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC07.oob.disa.mil (Postfix) with SMTP id 4138XB12TZz1wyJT
 for <selinux@tycho.nsa.gov>; Sat,  9 Jun 2018 19:31:06 +0000 (UTC)
Received: from UPBD19PA11.eemsg.mil (unknown [192.168.18.17])
 by UPDCF3IC07.oob.disa.mil (Postfix) with ESMTP id 4138X90nC2z1wyJP
 for <selinux@tycho.nsa.gov>; Sat,  9 Jun 2018 19:31:05 +0000 (UTC)
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 444ED56479C
 for <selinux@tycho.nsa.gov>; Sat,  9 Jun 2018 21:31:03 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat,  9 Jun 2018 21:30:29 +0200
Message-Id: <20180609193031.2728-1-nicolas.iooss@m4x.org>
Subject: [PATCH 1/3] libsepol/tests: read_binary_policy() does not use f.handle
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

f.handle is never set in read_binary_policy() so there is no need to
call sepol_handle_destroy() on it. Moreover clang's static analyzer
warns about an uninitialized argument value in the first call.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/tests/test-downgrade.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/libsepol/tests/test-downgrade.c b/libsepol/tests/test-downgrade.c
index 1ee7ff4c7e7f..50807c1dd6ea 100644
--- a/libsepol/tests/test-downgrade.c
+++ b/libsepol/tests/test-downgrade.c
@@ -210,7 +210,6 @@ int read_binary_policy(const char *path, policydb_t *p)
 	if ((in_fp = fopen(path, "rb")) == NULL) {
 		fprintf(stderr, "Unable to open %s: %s\n", path,
 			strerror(errno));
-		sepol_handle_destroy(f.handle);
 		return -1;
 	}
 
@@ -220,7 +219,6 @@ int read_binary_policy(const char *path, policydb_t *p)
 	f.fp = in_fp;
 	rc = policydb_read(p, &f, 0);
 
-	sepol_handle_destroy(f.handle);
 	fclose(in_fp);
 	return rc;
 }
-- 
2.17.1
