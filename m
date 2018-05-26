Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4QIhsJi004244
 for <selinux@tycho.nsa.gov>; Sat, 26 May 2018 14:43:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC12.oob.disa.mil (Postfix) with SMTP id 40tX882FmTz1pF1G
 for <selinux@tycho.nsa.gov>; Sat, 26 May 2018 18:43:52 +0000 (UTC)
Received: from UPBD19PA13.eemsg.mil (unknown [192.168.18.15])
 by UPDCF3IC12.oob.disa.mil (Postfix) with ESMTP id 40tX880YqSz1pF1B
 for <selinux@tycho.nsa.gov>; Sat, 26 May 2018 18:43:52 +0000 (UTC)
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 1767056069F
 for <selinux@tycho.nsa.gov>; Sat, 26 May 2018 20:42:51 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat, 26 May 2018 20:42:11 +0200
Message-Id: <20180526184213.4896-6-nicolas.iooss@m4x.org>
In-Reply-To: <20180526184213.4896-1-nicolas.iooss@m4x.org>
References: <20180526184213.4896-1-nicolas.iooss@m4x.org>
Subject: [PATCH 5/7] libsepol: remove unused variable
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

sepol_ppfile_to_module_package() does not use its variable "FILE *f =
NULL;" but to fclose() it. This variable has been unneeded since the
introduction of function ppfile_to_module_package() in commit
893851c0a146 ("policycoreutils: add a HLL compiler to convert policy
packages (.pp) to CIL").

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/module_to_cil.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 56887366707a..dcf6ebb10b60 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -4232,7 +4232,6 @@ exit:
 int sepol_ppfile_to_module_package(FILE *fp, struct sepol_module_package **mod_pkg)
 {
 	int rc = -1;
-	FILE *f = NULL;
 	struct sepol_policy_file *pf = NULL;
 	struct sepol_module_package *pkg = NULL;
 	char *data = NULL;
@@ -4284,9 +4283,6 @@ exit:
 	free(data);
 
 	sepol_policy_file_free(pf);
-	if (f != NULL) {
-		fclose(f);
-	}
 
 	if (rc != 0) {
 		sepol_module_package_free(pkg);
-- 
2.17.0
