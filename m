Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v43KwoOJ018687
 for <selinux@tycho.nsa.gov>; Wed, 3 May 2017 16:58:52 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id F14DD5648B1
 for <selinux@tycho.nsa.gov>; Wed,  3 May 2017 22:58:49 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] libsepol: silence false-positive -Wwrite-strings warning
Date: Wed,  3 May 2017 22:58:02 +0200
Message-Id: <20170503205802.19751-2-nicolas.iooss@m4x.org>
In-Reply-To: <20170503205802.19751-1-nicolas.iooss@m4x.org>
References: <20170503205802.19751-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When compiling with -Wwrite-strings, the compiler complains about
calling strs_add with a const char* value for a char* parameter
(DEFAULT_OBJECT is defined to "object_r"). Silence this warning by
casting the literal string to char*.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/kernel_to_cil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index e873ac3a1981..3a1c0be76f45 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -2369,7 +2369,7 @@ static int write_user_decl_rules_to_cil(FILE *out, struct policydb *pdb)
 				goto exit;
 			}
 
-			rc = strs_add(role_strs, DEFAULT_OBJECT);
+			rc = strs_add(role_strs, (char *)DEFAULT_OBJECT);
 			if (rc != 0) {
 				strs_destroy(&role_strs);
 				goto exit;
-- 
2.12.2
