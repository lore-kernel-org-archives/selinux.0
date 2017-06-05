Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v55Bm9tM030659
 for <selinux@tycho.nsa.gov>; Mon, 5 Jun 2017 07:48:09 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id CECF656469B
 for <selinux@tycho.nsa.gov>; Mon,  5 Jun 2017 13:48:03 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] libsepol/cil: call cil_reset_context() when context is
 not NULL
Date: Mon,  5 Jun 2017 13:47:41 +0200
Message-Id: <20170605114741.12279-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

cil_reset_context() dereferences its argument, which is thus expected
not to be NULL. The if statement in cil_reset_ibpkeycon() verified the
opposite condition. Fix this.

This issue has been found using clang's static analyzer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_reset_ast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
index 73034a97956b..dd047c8e0409 100644
--- a/libsepol/cil/src/cil_reset_ast.c
+++ b/libsepol/cil/src/cil_reset_ast.c
@@ -290,7 +290,7 @@ static void cil_reset_filecon(struct cil_filecon *filecon)
 
 static void cil_reset_ibpkeycon(struct cil_ibpkeycon *ibpkeycon)
 {
-	if (!ibpkeycon->context)
+	if (ibpkeycon->context)
 		cil_reset_context(ibpkeycon->context);
 }
 
-- 
2.13.0
