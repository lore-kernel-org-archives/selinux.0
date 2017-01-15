Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0FD4ofl000632
 for <selinux@tycho.nsa.gov>; Sun, 15 Jan 2017 08:04:50 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id B690956481B
 for <selinux@tycho.nsa.gov>; Sun, 15 Jan 2017 14:04:20 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/5] libsepol: remove useless assignments
Date: Sun, 15 Jan 2017 14:03:57 +0100
Message-Id: <20170115130359.6108-3-nicolas.iooss@m4x.org>
In-Reply-To: <20170115130359.6108-1-nicolas.iooss@m4x.org>
References: <20170115130359.6108-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

There is no point in initializing a variable which gets
almost-immediately assigned an other value.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_binary.c | 2 --
 libsepol/src/write.c          | 1 -
 2 files changed, 3 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index aaad364efce7..19cbc1b87c1e 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -2253,7 +2253,6 @@ int cil_roletrans_to_policydb(policydb_t *pdb, const struct cil_db *db, struct c
 				new->tclass = sepol_obj->s.value;
 				new->new_role = sepol_result->s.value;
 
-				rc = SEPOL_OK;
 				rc = hashtab_insert(role_trans_table, (hashtab_key_t)new, &(new->new_role));
 				if (rc != SEPOL_OK) {
 					if (rc == SEPOL_EEXIST) {
@@ -3041,7 +3040,6 @@ int cil_rangetransition_to_policydb(policydb_t *pdb, const struct cil_db *db, st
 					goto exit;
 				}
 
-				rc = SEPOL_OK;
 				rc = hashtab_insert(range_trans_table, (hashtab_key_t)newkey, newdatum);
 				if (rc != SEPOL_OK) {
 					if (rc == SEPOL_EEXIST) {
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index c4c84ac48062..e75b9abc381c 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -926,7 +926,6 @@ static int write_cons_helper(policydb_t * p,
 		if (items != 2)
 			return POLICYDB_ERROR;
 		for (e = c->expr; e; e = e->next) {
-			items = 0;
 			buf[0] = cpu_to_le32(e->expr_type);
 			buf[1] = cpu_to_le32(e->attr);
 			buf[2] = cpu_to_le32(e->op);
-- 
2.11.0
