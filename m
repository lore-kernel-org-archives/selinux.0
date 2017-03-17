Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2HL5xaI018960
 for <selinux@tycho.nsa.gov>; Fri, 17 Mar 2017 17:05:59 -0400
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] libsepol/cil: make reporting conflicting type transitions
 work
Date: Fri, 17 Mar 2017 22:05:26 +0100
Message-Id: <20170317210526.6813-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When compiling a CIL policy which defines conflicting type transitions,
secilc crashes when trying to format an error message with uninitialized
values. This is caused by __cil_typetransition_to_avtab() not
initializing the ..._str fields of its local variable "struct
cil_type_rule trans" before calling __cil_type_rule_to_avtab().

While at it, make the error report clearer about what is wrong by
showing the types and classes which got expanded in
__cil_type_rule_to_avtab(). Here is an example of the result:

    Conflicting type rules (scontext=testuser_emacs.subj
    tcontext=fs.tmpfs.fs tclass=dir
    result=users.generic_tmpfs.user_tmpfs_file),
    existing=emacs.tmpfs.user_tmpfs_file

    Expanded from type rule (scontext=ARG1 tcontext=fs tclass=ARG3
    result=ARG2)

Reported-By: Dominick Grift <dac.override@gmail.com>
Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_binary.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index ac371aef7b2d..ac18c4e2ee5d 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -1018,7 +1018,14 @@ int __cil_insert_type_rule(policydb_t *pdb, uint32_t kind, uint32_t src, uint32_
 		 * non-duplicate rule using the same key.
 		 */
 		if (existing->datum.data != res) {
-			cil_log(CIL_ERR, "Conflicting type rules (scontext=%s tcontext=%s tclass=%s result=%s)\n", cil_rule->src_str, cil_rule->tgt_str, cil_rule->obj_str, cil_rule->result_str);
+			cil_log(CIL_ERR, "Conflicting type rules (scontext=%s tcontext=%s tclass=%s result=%s), existing=%s\n",
+				pdb->p_type_val_to_name[src - 1],
+				pdb->p_type_val_to_name[tgt - 1],
+				pdb->p_class_val_to_name[obj - 1],
+				pdb->p_type_val_to_name[res - 1],
+				pdb->p_type_val_to_name[existing->datum.data - 1]);
+			cil_log(CIL_ERR, "Expanded from type rule (scontext=%s tcontext=%s tclass=%s result=%s)\n",
+				cil_rule->src_str, cil_rule->tgt_str, cil_rule->obj_str, cil_rule->result_str);
 			rc = SEPOL_ERR;
 		}
 		goto exit;
@@ -1044,7 +1051,14 @@ int __cil_insert_type_rule(policydb_t *pdb, uint32_t kind, uint32_t src, uint32_
 			search_datum = cil_cond_av_list_search(&avtab_key, other_list);
 			if (search_datum == NULL) {
 				if (existing->datum.data != res) {
-					cil_log(CIL_ERR, "Conflicting type rules (scontext=%s tcontext=%s tclass=%s result=%s)\n", cil_rule->src_str, cil_rule->tgt_str, cil_rule->obj_str, cil_rule->result_str);
+					cil_log(CIL_ERR, "Conflicting type rules (scontext=%s tcontext=%s tclass=%s result=%s), existing=%s\n",
+						pdb->p_type_val_to_name[src - 1],
+						pdb->p_type_val_to_name[tgt - 1],
+						pdb->p_class_val_to_name[obj - 1],
+						pdb->p_type_val_to_name[res - 1],
+						pdb->p_type_val_to_name[existing->datum.data - 1]);
+					cil_log(CIL_ERR, "Expanded from type rule (scontext=%s tcontext=%s tclass=%s result=%s)\n",
+						cil_rule->src_str, cil_rule->tgt_str, cil_rule->obj_str, cil_rule->result_str);
 					rc = SEPOL_ERR;
 					goto exit;
 				}
@@ -1146,6 +1160,10 @@ int __cil_typetransition_to_avtab(policydb_t *pdb, const struct cil_db *db, stru
 		trans.tgt = typetrans->tgt;
 		trans.obj = typetrans->obj;
 		trans.result = typetrans->result;
+		trans.src_str = typetrans->src_str;
+		trans.tgt_str = typetrans->tgt_str;
+		trans.obj_str = typetrans->obj_str;
+		trans.result_str = typetrans->result_str;
 		return __cil_type_rule_to_avtab(pdb, db, &trans, cond_node, cond_flavor);
 	}
 
-- 
2.12.0
