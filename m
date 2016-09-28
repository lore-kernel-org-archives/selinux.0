Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8SKvkTO005944
 for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2016 16:57:46 -0400
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 321045649AE
 for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2016 22:57:17 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] libsepol/cil: do not heap-overflow when too many
 permissions are in a class
Date: Wed, 28 Sep 2016 22:57:08 +0200
Message-Id: <20160928205708.14686-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When compiling a CIL policy with more than 32 items in a class (e.g. in
(class capability (chown ...)) with many items),
cil_classorder_to_policydb() overflows perm_value_to_cil[class_index]
array. As this array is allocated on the heap through
calloc(PERMS_PER_CLASS+1, sizeof(...)), this makes secilc crash with the
following message:

    *** Error in `/usr/bin/secilc': double free or corruption (!prev): 0x000000000062be80 ***
    ======= Backtrace: =========
    /usr/lib/libc.so.6(+0x70c4b)[0x7ffff76a7c4b]
    /usr/lib/libc.so.6(+0x76fe6)[0x7ffff76adfe6]
    /usr/lib/libc.so.6(+0x777de)[0x7ffff76ae7de]
    /lib/libsepol.so.1(+0x14fbda)[0x7ffff7b24bda]
    /lib/libsepol.so.1(+0x152db8)[0x7ffff7b27db8]
    /lib/libsepol.so.1(cil_build_policydb+0x63)[0x7ffff7af8723]
    /usr/bin/secilc[0x40273b]
    /usr/lib/libc.so.6(__libc_start_main+0xf1)[0x7ffff7657291]
    /usr/bin/secilc[0x402f7a]

Fix this by detecting the overflow before adding new permissions to a
class.

This bug has been found by fuzzing secilc with american fuzzy lop.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_binary.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index cc73648ad1b7..d3b3e90df45b 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -332,6 +332,11 @@ int cil_classorder_to_policydb(policydb_t *pdb, const struct cil_db *db, struct
 					goto exit;
 				}
 			}
+			if (sepol_class->permissions.nprim + sepol_common->permissions.nprim > PERMS_PER_CLASS) {
+				cil_log(CIL_ERR, "Too many permissions in class '%s'\n", cil_class->datum.fqn);
+				rc = SEPOL_ERR;
+				goto exit;
+			}
 			sepol_class->comdatum = sepol_common;
 			sepol_class->comkey = cil_strdup(key);
 			sepol_class->permissions.nprim += sepol_common->permissions.nprim;
@@ -344,9 +349,15 @@ int cil_classorder_to_policydb(policydb_t *pdb, const struct cil_db *db, struct
 
 		for (curr = NODE(cil_class)->cl_head; curr; curr = curr->next) {
 			struct cil_perm *cil_perm = curr->data;
-			perm_datum_t *sepol_perm = cil_malloc(sizeof(*sepol_perm));
-			memset(sepol_perm, 0, sizeof(perm_datum_t));
+			perm_datum_t *sepol_perm;
 
+			if (sepol_class->permissions.nprim + 1 > PERMS_PER_CLASS) {
+				cil_log(CIL_ERR, "Too many permissions in class '%s'\n", cil_class->datum.fqn);
+				rc = SEPOL_ERR;
+				goto exit;
+			}
+			sepol_perm = cil_malloc(sizeof(*sepol_perm));
+			memset(sepol_perm, 0, sizeof(perm_datum_t));
 			key = cil_strdup(cil_perm->datum.fqn);
 			rc = hashtab_insert(sepol_class->permissions.table, key, sepol_perm);
 			if (rc != SEPOL_OK) {
-- 
2.10.0
