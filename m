Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4QIgpmN004187
 for <selinux@tycho.nsa.gov>; Sat, 26 May 2018 14:42:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC10.oob.disa.mil (Postfix) with SMTP id 40tX6w6S1Mz4KRK4
 for <selinux@tycho.nsa.gov>; Sat, 26 May 2018 18:42:48 +0000 (UTC)
Received: from UPDC3CPA07_EEMSG_MP23.eemsg.mil (unknown [192.168.18.18])
 by UPDCF3IC10.oob.disa.mil (Postfix) with ESMTP id 40tX6w2YVtz4KRKR
 for <selinux@tycho.nsa.gov>; Sat, 26 May 2018 18:42:48 +0000 (UTC)
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 98B0156069F
 for <selinux@tycho.nsa.gov>; Sat, 26 May 2018 20:42:45 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat, 26 May 2018 20:42:07 +0200
Message-Id: <20180526184213.4896-2-nicolas.iooss@m4x.org>
In-Reply-To: <20180526184213.4896-1-nicolas.iooss@m4x.org>
References: <20180526184213.4896-1-nicolas.iooss@m4x.org>
Subject: [PATCH 1/7] libsepol: cil: silence clang analyzer false
 positive
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In cil_tree_print_expr(), "rc < 0" is equivalent to "rc != 0" but
clang's static analyzer does not know about this. Help it.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index 1b04fe68a302..b1cbda918565 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -512,7 +512,7 @@ void cil_tree_print_expr(struct cil_list *datum_expr, struct cil_list *str_expr)
 	} else {
 		rc = cil_expr_to_string(str_expr, &expr_str);
 	}
-	if (rc < 0) {
+	if (rc != SEPOL_OK) {
 		cil_log(CIL_INFO, "ERROR)");
 		return;
 	}
-- 
2.17.0
