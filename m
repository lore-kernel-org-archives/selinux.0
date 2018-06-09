Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w59JVdEc000969
 for <selinux@tycho.nsa.gov>; Sat, 9 Jun 2018 15:31:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC16.oob.disa.mil (Postfix) with SMTP id 4138Xn5mtwz2Vp8c
 for <selinux@tycho.nsa.gov>; Sat,  9 Jun 2018 19:31:37 +0000 (UTC)
Received: from UPBD19PA11.eemsg.mil (unknown [192.168.18.17])
 by UPDCF3IC16.oob.disa.mil (Postfix) with ESMTP id 4138Xn3z2Sz2Vp8Y
 for <selinux@tycho.nsa.gov>; Sat,  9 Jun 2018 19:31:37 +0000 (UTC)
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 66A7A56479C
 for <selinux@tycho.nsa.gov>; Sat,  9 Jun 2018 21:31:06 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat,  9 Jun 2018 21:30:31 +0200
Message-Id: <20180609193031.2728-3-nicolas.iooss@m4x.org>
In-Reply-To: <20180609193031.2728-1-nicolas.iooss@m4x.org>
References: <20180609193031.2728-1-nicolas.iooss@m4x.org>
Subject: [PATCH 3/3] libsepol/cil: use a colon instead of a
 semicolon to report rc
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_resolve_ast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 02259241ddfe..fb9d91745629 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -2923,7 +2923,7 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
 
 					rc = cil_fill_ipaddr(pc->cl_head, ipaddr);
 					if (rc != SEPOL_OK) {
-						cil_log(CIL_ERR, "Failed to create anonymous ip address, rc; %d\n", rc);
+						cil_log(CIL_ERR, "Failed to create anonymous ip address, rc: %d\n", rc);
 						cil_destroy_ipaddr(ipaddr);
 						goto exit;
 					}
-- 
2.17.1
