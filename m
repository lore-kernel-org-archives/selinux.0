Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4CKFwL5019700
 for <selinux@tycho.nsa.gov>; Fri, 12 May 2017 16:15:59 -0400
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id B81A05646B4
 for <selinux@tycho.nsa.gov>; Fri, 12 May 2017 22:15:53 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] libsepol/cil: do not use an uninitialized value in
 __cil_fqn_qualify_blocks
Date: Fri, 12 May 2017 22:13:56 +0200
Message-Id: <20170512201357.4091-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In __cil_fqn_qualify_blocks(), when newlen >= CIL_MAX_NAME_LENGTH,
cil_tree_log() is called with child_args.node as argument but this value
has not been initialized yet. Use local variable node instead, which is
initialized early enough in the function.

This issue has been found using clang's static analyzer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_fqn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_fqn.c b/libsepol/cil/src/cil_fqn.c
index dad13474c823..717358a24eb7 100644
--- a/libsepol/cil/src/cil_fqn.c
+++ b/libsepol/cil/src/cil_fqn.c
@@ -121,7 +121,7 @@ static int __cil_fqn_qualify_blocks(__attribute__((unused)) hashtab_key_t k, has
 
 exit:
 	if (rc != SEPOL_OK) {
-		cil_tree_log(child_args.node, CIL_ERR,"Problem qualifying names in block");
+		cil_tree_log(node, CIL_ERR,"Problem qualifying names in block");
 	}
 
 	return rc;
-- 
2.12.2
