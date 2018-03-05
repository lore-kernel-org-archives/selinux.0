Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w25N0dx5005702
 for <selinux@tycho.nsa.gov>; Mon, 5 Mar 2018 18:00:41 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC13.oob.disa.mil (Postfix) with SMTP id 3zwFkJ38q0z25vbf
 for <selinux@tycho.nsa.gov>; Mon,  5 Mar 2018 23:00:40 +0000 (UTC)
Received: from UPDC3CPA11_EEMSG_MP27.eemsg.mil (unknown [192.168.18.22])
 by UPDCF3IC13.oob.disa.mil (Postfix) with ESMTP id 3zwFkJ2Wm6z25vbb
 for <selinux@tycho.nsa.gov>; Mon,  5 Mar 2018 23:00:40 +0000 (UTC)
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 73E8656128F
 for <selinux@tycho.nsa.gov>; Mon,  5 Mar 2018 23:58:31 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Mon,  5 Mar 2018 23:58:19 +0100
Message-Id: <20180305225820.23610-2-nicolas.iooss@m4x.org>
In-Reply-To: <20180305225820.23610-1-nicolas.iooss@m4x.org>
References: <20180305225820.23610-1-nicolas.iooss@m4x.org>
Subject: [PATCH 2/3] libsepol: cil: show an error when
 cil_expr_to_string() fails
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

cil_tree_print_expr() calls cil_expr_to_string() in order to compute a
string expression into expr_str. If this function fails, expr_str is
left unitialized but its value is dereferenced with:

    cil_log(CIL_INFO, "%s)", expr_str);

Prevent such an issue by checking cil_expr_to_string()'s return value
before using expr_str.

This issue has been found with clang's static analyzer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_tree.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index d36401b41dba..b394a9d849df 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -503,15 +503,19 @@ exit:
 void cil_tree_print_expr(struct cil_list *datum_expr, struct cil_list *str_expr)
 {
 	char *expr_str;
+	int rc;
 
 	cil_log(CIL_INFO, "(");
 
 	if (datum_expr != NULL) {
-		cil_expr_to_string(datum_expr, &expr_str);
+		rc = cil_expr_to_string(datum_expr, &expr_str);
 	} else {
-		cil_expr_to_string(str_expr, &expr_str);
+		rc = cil_expr_to_string(str_expr, &expr_str);
+	}
+	if (rc < 0) {
+		cil_log(CIL_INFO, "ERROR)");
+		return;
 	}
-
 	cil_log(CIL_INFO, "%s)", expr_str);
 	free(expr_str);
 }
-- 
2.16.0
