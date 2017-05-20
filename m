Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4KACAco029614
 for <selinux@tycho.nsa.gov>; Sat, 20 May 2017 06:12:11 -0400
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 68CD65607A0
 for <selinux@tycho.nsa.gov>; Sat, 20 May 2017 12:12:04 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] libsepol: propagate calloc() failure
Date: Sat, 20 May 2017 12:11:40 +0200
Message-Id: <20170520101141.6207-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When common_to_cil() or class_to_cil() fail to allocate an array to map
a permissions hashtable (for example when permissions.nprim is too big),
class_perm_to_array() gets called on a NULL pointer. Fix this.

This issue has been found while fuzzing hll/pp with the American Fuzzy
Lop.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/module_to_cil.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 7d8eb204d2fd..e2bc4b2e6bec 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1662,6 +1662,9 @@ static int common_to_cil(char *key, void *data, void *UNUSED(arg))
 
 	arr.count = 0;
 	arr.perms = calloc(common->permissions.nprim, sizeof(*arr.perms));
+	if (arr.perms == NULL) {
+		goto exit;
+	}
 	rc = hashtab_map(common->permissions.table, class_perm_to_array, &arr);
 	if (rc != 0) {
 		goto exit;
@@ -1952,6 +1955,9 @@ static int class_to_cil(int indent, struct policydb *pdb, struct avrule_block *U
 
 	arr.count = 0;
 	arr.perms = calloc(class->permissions.nprim, sizeof(*arr.perms));
+	if (arr.perms == NULL) {
+		goto exit;
+	}
 	rc = hashtab_map(class->permissions.table, class_perm_to_array, &arr);
 	if (rc != 0) {
 		goto exit;
-- 
2.12.2
