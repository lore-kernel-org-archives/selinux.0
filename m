From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Allow libsepol C++ static library on device.
Date: Tue, 20 Jan 2015 10:34:40 -0500
Message-Id: <1421768080-16629-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel Cashman <dcashman@google.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Daniel Cashman <dcashman@google.com>

Change-Id: I7da601767c3a4ebed7274e33304d8b589a9115fe
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 checkpolicy/policy_define.c                    |  4 ++--
 checkpolicy/test/dismod.c                      |  4 ++--
 libsepol/Android.mk                            | 11 +++++++++++
 libsepol/include/sepol/boolean_record.h        |  4 ++++
 libsepol/include/sepol/booleans.h              |  4 ++++
 libsepol/include/sepol/context.h               |  5 +++++
 libsepol/include/sepol/context_record.h        |  4 ++++
 libsepol/include/sepol/debug.h                 |  5 +++++
 libsepol/include/sepol/errcodes.h              |  4 ++++
 libsepol/include/sepol/handle.h                |  5 +++++
 libsepol/include/sepol/iface_record.h          |  4 ++++
 libsepol/include/sepol/interfaces.h            |  4 ++++
 libsepol/include/sepol/module.h                |  4 ++++
 libsepol/include/sepol/node_record.h           |  4 ++++
 libsepol/include/sepol/nodes.h                 |  4 ++++
 libsepol/include/sepol/policydb.h              |  4 ++++
 libsepol/include/sepol/policydb/avrule_block.h |  4 ++++
 libsepol/include/sepol/policydb/avtab.h        |  4 ++++
 libsepol/include/sepol/policydb/conditional.h  |  4 ++++
 libsepol/include/sepol/policydb/constraint.h   |  4 +++-
 libsepol/include/sepol/policydb/context.h      |  4 +++-
 libsepol/include/sepol/policydb/ebitmap.h      |  5 ++++-
 libsepol/include/sepol/policydb/expand.h       |  4 ++++
 libsepol/include/sepol/policydb/flask_types.h  |  5 ++++-
 libsepol/include/sepol/policydb/hashtab.h      |  5 ++++-
 libsepol/include/sepol/policydb/hierarchy.h    |  4 ++++
 libsepol/include/sepol/policydb/link.h         |  4 ++++
 libsepol/include/sepol/policydb/mls_types.h    |  5 ++++-
 libsepol/include/sepol/policydb/module.h       |  4 ++++
 libsepol/include/sepol/policydb/polcaps.h      |  5 +++++
 libsepol/include/sepol/policydb/policydb.h     |  8 +++++---
 libsepol/include/sepol/policydb/services.h     |  4 ++++
 libsepol/include/sepol/policydb/sidtab.h       |  5 ++++-
 libsepol/include/sepol/policydb/symtab.h       |  4 ++++
 libsepol/include/sepol/policydb/util.h         |  5 +++++
 libsepol/include/sepol/port_record.h           |  4 ++++
 libsepol/include/sepol/ports.h                 |  4 ++++
 libsepol/include/sepol/roles.h                 |  5 +++++
 libsepol/include/sepol/sepol.h                 |  4 ++++
 libsepol/include/sepol/user_record.h           |  4 ++++
 libsepol/include/sepol/users.h                 |  4 ++++
 libsepol/src/assertion.c                       | 14 +++++++-------
 libsepol/src/expand.c                          |  8 ++++----
 libsepol/src/link.c                            | 10 +++++-----
 libsepol/src/policydb.c                        |  2 +-
 libsepol/src/write.c                           |  2 +-
 policycoreutils/hll/pp/pp.c                    |  6 +++---
 47 files changed, 193 insertions(+), 35 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 683eb0f..a6c5d65 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1575,7 +1575,7 @@ int define_compute_type_helper(int which, avrule_t ** rule)
 				goto bad;
 			}
 			class_perm_node_init(perm);
-			perm->class = i + 1;
+			perm->tclass = i + 1;
 			perm->data = datum->s.value;
 			perm->next = avrule->perms;
 			avrule->perms = perm;
@@ -1796,7 +1796,7 @@ int define_te_avtab_helper(int which, avrule_t ** rule)
 			goto out;
 		}
 		class_perm_node_init(cur_perms);
-		cur_perms->class = i + 1;
+		cur_perms->tclass = i + 1;
 		if (!perms)
 			perms = cur_perms;
 		if (tail)
diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index b305643..db9ae55 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -269,7 +269,7 @@ int display_avrule(avrule_t * avrule, policydb_t * policy,
 
 	cur = avrule->perms;
 	while (cur) {
-		display_id(policy, fp, SYM_CLASSES, cur->class - 1, "");
+		display_id(policy, fp, SYM_CLASSES, cur->tclass - 1, "");
 		cur = cur->next;
 	}
 
@@ -278,7 +278,7 @@ int display_avrule(avrule_t * avrule, policydb_t * policy,
 	fprintf(fp, " ");
 
 	if (avrule->specified & (AVRULE_AV | AVRULE_NEVERALLOW)) {
-		render_access_mask(avrule->perms->data, avrule->perms->class,
+		render_access_mask(avrule->perms->data, avrule->perms->tclass,
 				   policy, fp);
 	} else if (avrule->specified & AVRULE_TYPE) {
 		display_id(policy, fp, SYM_TYPES, avrule->perms->data - 1, "");
diff --git a/libsepol/Android.mk b/libsepol/Android.mk
index e193765..9bbcee1 100644
--- a/libsepol/Android.mk
+++ b/libsepol/Android.mk
@@ -95,3 +95,14 @@ LOCAL_SHARED_LIBRARIES := libsepol
 LOCAL_MODULE_CLASS := EXECUTABLES
 
 include $(BUILD_HOST_EXECUTABLE)
+
+include $(CLEAR_VARS)
+
+LOCAL_MODULE := libsepol
+LOCAL_MODULE_TAGES := optional
+LOCAL_C_INCLUDES := $(common_includes)
+LOCAL_CFLAGS := $(common_cflags)
+LOCAL_SRC_FILES := $(common_src_files)
+LOCAL_MODULE_CLASS := STATIC_LIBRARIES
+
+include $(BUILD_STATIC_LIBRARY)
diff --git a/libsepol/include/sepol/boolean_record.h b/libsepol/include/sepol/boolean_record.h
index 54ca021..9af16be 100644
--- a/libsepol/include/sepol/boolean_record.h
+++ b/libsepol/include/sepol/boolean_record.h
@@ -3,6 +3,9 @@
 
 #include <stddef.h>
 #include <sepol/handle.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 struct sepol_bool;
 struct sepol_bool_key;
@@ -48,4 +51,5 @@ extern int sepol_bool_clone(sepol_handle_t * handle,
 
 extern void sepol_bool_free(sepol_bool_t * boolean);
 
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/booleans.h b/libsepol/include/sepol/booleans.h
index 95ee7de..7374dde 100644
--- a/libsepol/include/sepol/booleans.h
+++ b/libsepol/include/sepol/booleans.h
@@ -5,6 +5,9 @@
 #include <sepol/policydb.h>
 #include <sepol/boolean_record.h>
 #include <sepol/handle.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 /*--------------compatibility--------------*/
 
@@ -56,4 +59,5 @@ extern int sepol_bool_iterate(sepol_handle_t * handle,
 			      int (*fn) (const sepol_bool_t * boolean,
 					 void *fn_arg), void *arg);
 
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/context.h b/libsepol/include/sepol/context.h
index c1eadca..a69e8c9 100644
--- a/libsepol/include/sepol/context.h
+++ b/libsepol/include/sepol/context.h
@@ -4,6 +4,9 @@
 #include <sepol/context_record.h>
 #include <sepol/policydb.h>
 #include <sepol/handle.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 /* -- Deprecated -- */
 
@@ -22,4 +25,6 @@ extern int sepol_mls_contains(sepol_handle_t * handle,
 
 extern int sepol_mls_check(sepol_handle_t * handle,
 			   const sepol_policydb_t * policydb, const char *mls);
+
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/context_record.h b/libsepol/include/sepol/context_record.h
index c305480..c07da8f 100644
--- a/libsepol/include/sepol/context_record.h
+++ b/libsepol/include/sepol/context_record.h
@@ -2,6 +2,9 @@
 #define _SEPOL_CONTEXT_RECORD_H_
 
 #include <sepol/handle.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 struct sepol_context;
 typedef struct sepol_context sepol_context_t;
@@ -50,4 +53,5 @@ extern int sepol_context_from_string(sepol_handle_t * handle,
 extern int sepol_context_to_string(sepol_handle_t * handle,
 				   const sepol_context_t * con, char **str_ptr);
 
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/debug.h b/libsepol/include/sepol/debug.h
index 3370845..b852c8d 100644
--- a/libsepol/include/sepol/debug.h
+++ b/libsepol/include/sepol/debug.h
@@ -2,6 +2,9 @@
 #define _SEPOL_DEBUG_H_
 
 #include <sepol/handle.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 /* Deprecated */
 extern void sepol_debug(int on);
@@ -31,4 +34,6 @@ extern void sepol_msg_set_callback(sepol_handle_t * handle,
 							 handle,
 							 const char *fmt, ...),
 				   void *msg_callback_arg);
+
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/errcodes.h b/libsepol/include/sepol/errcodes.h
index c6f3a8b..eba7088 100644
--- a/libsepol/include/sepol/errcodes.h
+++ b/libsepol/include/sepol/errcodes.h
@@ -4,6 +4,9 @@
 #define __sepol_errno_h__
 
 #include <errno.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 #define SEPOL_OK             0
 
@@ -22,4 +25,5 @@
 #define SEPOL_EEXIST         -EEXIST
 #define SEPOL_ENOENT         -ENOENT
 
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/handle.h b/libsepol/include/sepol/handle.h
index 115bda1..00ed0ed 100644
--- a/libsepol/include/sepol/handle.h
+++ b/libsepol/include/sepol/handle.h
@@ -1,6 +1,10 @@
 #ifndef _SEPOL_HANDLE_H_
 #define _SEPOL_HANDLE_H_
 
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
+
 struct sepol_handle;
 typedef struct sepol_handle sepol_handle_t;
 
@@ -31,4 +35,5 @@ int sepol_get_preserve_tunables(sepol_handle_t * sh);
  * 0 is default and discard such branch, 1 preserves them */
 void sepol_set_preserve_tunables(sepol_handle_t * sh, int preserve_tunables);
 
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/iface_record.h b/libsepol/include/sepol/iface_record.h
index a72678c..81d7027 100644
--- a/libsepol/include/sepol/iface_record.h
+++ b/libsepol/include/sepol/iface_record.h
@@ -3,6 +3,9 @@
 
 #include <sepol/handle.h>
 #include <sepol/context_record.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 struct sepol_iface;
 struct sepol_iface_key;
@@ -56,4 +59,5 @@ extern int sepol_iface_clone(sepol_handle_t * handle,
 
 extern void sepol_iface_free(sepol_iface_t * iface);
 
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/interfaces.h b/libsepol/include/sepol/interfaces.h
index 9849e13..3cb5043 100644
--- a/libsepol/include/sepol/interfaces.h
+++ b/libsepol/include/sepol/interfaces.h
@@ -4,6 +4,9 @@
 #include <sepol/policydb.h>
 #include <sepol/iface_record.h>
 #include <sepol/handle.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 /* Return the number of interfaces */
 extern int sepol_iface_count(sepol_handle_t * handle,
@@ -40,4 +43,5 @@ extern int sepol_iface_iterate(sepol_handle_t * handle,
 			       int (*fn) (const sepol_iface_t * iface,
 					  void *fn_arg), void *arg);
 
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/module.h b/libsepol/include/sepol/module.h
index 35f5cb7..ff27f96 100644
--- a/libsepol/include/sepol/module.h
+++ b/libsepol/include/sepol/module.h
@@ -7,6 +7,9 @@
 
 #include <sepol/handle.h>
 #include <sepol/policydb.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 struct sepol_module_package;
 typedef struct sepol_module_package sepol_module_package_t;
@@ -79,4 +82,5 @@ extern int sepol_expand_module(sepol_handle_t * handle,
 			       sepol_policydb_t * base,
 			       sepol_policydb_t * out, int verbose, int check);
 
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/node_record.h b/libsepol/include/sepol/node_record.h
index 9f61ac7..e2d3e6d 100644
--- a/libsepol/include/sepol/node_record.h
+++ b/libsepol/include/sepol/node_record.h
@@ -4,6 +4,9 @@
 #include <stddef.h>
 #include <sepol/context_record.h>
 #include <sepol/handle.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 struct sepol_node;
 struct sepol_node_key;
@@ -89,4 +92,5 @@ extern int sepol_node_clone(sepol_handle_t * handle,
 
 extern void sepol_node_free(sepol_node_t * node);
 
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/nodes.h b/libsepol/include/sepol/nodes.h
index 1e0ac4f..6fa534e 100644
--- a/libsepol/include/sepol/nodes.h
+++ b/libsepol/include/sepol/nodes.h
@@ -4,6 +4,9 @@
 #include <sepol/handle.h>
 #include <sepol/policydb.h>
 #include <sepol/node_record.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 /* Return the number of nodes */
 extern int sepol_node_count(sepol_handle_t * handle,
@@ -37,4 +40,5 @@ extern int sepol_node_iterate(sepol_handle_t * handle,
 			      int (*fn) (const sepol_node_t * node,
 					 void *fn_arg), void *arg);
 
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/policydb.h b/libsepol/include/sepol/policydb.h
index f4ecf57..c3943e9 100644
--- a/libsepol/include/sepol/policydb.h
+++ b/libsepol/include/sepol/policydb.h
@@ -5,6 +5,9 @@
 #include <stdio.h>
 
 #include <sepol/handle.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 struct sepol_policy_file;
 typedef struct sepol_policy_file sepol_policy_file_t;
@@ -141,4 +144,5 @@ extern int sepol_policydb_mls_enabled(const sepol_policydb_t * p);
  */
 extern int sepol_policydb_compat_net(const sepol_policydb_t * p);
 
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/policydb/avrule_block.h b/libsepol/include/sepol/policydb/avrule_block.h
index dc926e5..ecd347b 100644
--- a/libsepol/include/sepol/policydb/avrule_block.h
+++ b/libsepol/include/sepol/policydb/avrule_block.h
@@ -21,6 +21,9 @@
 #define _SEPOL_AVRULE_BLOCK_H_
 
 #include <sepol/policydb/policydb.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 extern avrule_block_t *avrule_block_create(void);
 extern void avrule_block_destroy(avrule_block_t * x);
@@ -34,4 +37,5 @@ extern cond_list_t *get_decl_cond_list(policydb_t * p,
 extern int is_id_enabled(char *id, policydb_t * p, int symbol_table);
 extern int is_perm_enabled(char *class_id, char *perm_id, policydb_t * p);
 
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/include/sepol/policydb/avtab.h
index bb6e79f..3f56a0e 100644
--- a/libsepol/include/sepol/policydb/avtab.h
+++ b/libsepol/include/sepol/policydb/avtab.h
@@ -40,9 +40,12 @@
 #ifndef _SEPOL_POLICYDB_AVTAB_H_
 #define _SEPOL_POLICYDB_AVTAB_H_
 
+#include <sys/cdefs.h>
 #include <sys/types.h>
 #include <stdint.h>
 
+__BEGIN_DECLS
+
 typedef struct avtab_key {
 	uint16_t source_type;
 	uint16_t target_type;
@@ -123,6 +126,7 @@ extern avtab_ptr_t avtab_search_node_next(avtab_ptr_t node, int specified);
 /* avtab_alloc uses one bucket per 2-4 elements, so adjust to get maximum buckets */
 #define MAX_AVTAB_SIZE (MAX_AVTAB_HASH_BUCKETS << 1)
 
+__END_DECLS
 #endif				/* _AVTAB_H_ */
 
 /* FLASK */
diff --git a/libsepol/include/sepol/policydb/conditional.h b/libsepol/include/sepol/policydb/conditional.h
index 48ec106..cd2a9a9 100644
--- a/libsepol/include/sepol/policydb/conditional.h
+++ b/libsepol/include/sepol/policydb/conditional.h
@@ -25,6 +25,9 @@
 #include <sepol/policydb/avtab.h>
 #include <sepol/policydb/symtab.h>
 #include <sepol/policydb/policydb.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 #define COND_EXPR_MAXDEPTH 10
 
@@ -133,4 +136,5 @@ extern int cond_read_list(policydb_t * p, cond_list_t ** list, void *fp);
 extern void cond_compute_av(avtab_t * ctab, avtab_key_t * key,
 			    struct sepol_av_decision *avd);
 
+__END_DECLS
 #endif				/* _CONDITIONAL_H_ */
diff --git a/libsepol/include/sepol/policydb/constraint.h b/libsepol/include/sepol/policydb/constraint.h
index 4c16ab0..ae7034d 100644
--- a/libsepol/include/sepol/policydb/constraint.h
+++ b/libsepol/include/sepol/policydb/constraint.h
@@ -1,4 +1,3 @@
-
 /* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
 
 /* FLASK */
@@ -23,6 +22,8 @@
 #include <sepol/policydb/ebitmap.h>
 #include <sepol/policydb/flask_types.h>
 
+__BEGIN_DECLS
+
 #define CEXPR_MAXDEPTH 5
 
 struct type_set;
@@ -72,6 +73,7 @@ struct policydb;
 extern int constraint_expr_init(constraint_expr_t * expr);
 extern void constraint_expr_destroy(constraint_expr_t * expr);
 
+__END_DECLS
 #endif				/* _CONSTRAINT_H_ */
 
 /* FLASK */
diff --git a/libsepol/include/sepol/policydb/context.h b/libsepol/include/sepol/policydb/context.h
index 8d74a25..dbb7c3e 100644
--- a/libsepol/include/sepol/policydb/context.h
+++ b/libsepol/include/sepol/policydb/context.h
@@ -1,4 +1,3 @@
-
 /* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
 
 /* FLASK */
@@ -23,6 +22,8 @@
 #include <sepol/policydb/ebitmap.h>
 #include <sepol/policydb/mls_types.h>
 
+__BEGIN_DECLS
+
 /*
  * A security context consists of an authenticated user
  * identity, a role, a type and a MLS range.
@@ -94,4 +95,5 @@ static inline int context_cmp(context_struct_t * c1, context_struct_t * c2)
 		(c1->type == c2->type) && mls_context_cmp(c1, c2));
 }
 
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/include/sepol/policydb/ebitmap.h
index 214da95..801438c 100644
--- a/libsepol/include/sepol/policydb/ebitmap.h
+++ b/libsepol/include/sepol/policydb/ebitmap.h
@@ -1,4 +1,3 @@
-
 /* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
 
 /* FLASK */
@@ -20,6 +19,9 @@
 
 #include <stdint.h>
 #include <string.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 #define MAPTYPE uint64_t	/* portion of bitmap in each node */
 #define MAPSIZE (sizeof(MAPTYPE) * 8)	/* number of bits in node bitmap */
@@ -89,6 +91,7 @@ extern int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, int value);
 extern void ebitmap_destroy(ebitmap_t * e);
 extern int ebitmap_read(ebitmap_t * e, void *fp);
 
+__END_DECLS
 #endif				/* _EBITMAP_H_ */
 
 /* FLASK */
diff --git a/libsepol/include/sepol/policydb/expand.h b/libsepol/include/sepol/policydb/expand.h
index 31e25ec..a8de41e 100644
--- a/libsepol/include/sepol/policydb/expand.h
+++ b/libsepol/include/sepol/policydb/expand.h
@@ -28,6 +28,9 @@
 #include <stddef.h>
 #include <sepol/handle.h>
 #include <sepol/policydb/conditional.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 /*
  * Expand only the avrules for a module. It is valid for this function
@@ -76,4 +79,5 @@ extern int expand_avtab(policydb_t * p, avtab_t * a, avtab_t * expa);
 extern int expand_cond_av_list(policydb_t * p, cond_av_list_t * l,
 			       cond_av_list_t ** newl, avtab_t * expa);
 
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/policydb/flask_types.h b/libsepol/include/sepol/policydb/flask_types.h
index 575c6f2..2a59565 100644
--- a/libsepol/include/sepol/policydb/flask_types.h
+++ b/libsepol/include/sepol/policydb/flask_types.h
@@ -1,4 +1,3 @@
-
 /* -*- linux-c -*- */
 
 /*
@@ -14,6 +13,9 @@
 
 #include <sys/types.h>
 #include <stdint.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 /*
  * A security context is a set of security attributes 
@@ -59,4 +61,5 @@ struct sepol_av_decision {
 	uint32_t seqno;
 };
 
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/policydb/hashtab.h b/libsepol/include/sepol/policydb/hashtab.h
index 1081ff6..0afc59c 100644
--- a/libsepol/include/sepol/policydb/hashtab.h
+++ b/libsepol/include/sepol/policydb/hashtab.h
@@ -1,4 +1,3 @@
-
 /* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
 
 /* FLASK */
@@ -18,6 +17,9 @@
 
 #include <stdint.h>
 #include <stdio.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 typedef char *hashtab_key_t;	/* generic key type */
 typedef void *hashtab_datum_t;	/* generic datum type */
@@ -134,4 +136,5 @@ extern void hashtab_map_remove_on_error(hashtab_t h,
 
 extern void hashtab_hash_eval(hashtab_t h, char *tag);
 
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/policydb/hierarchy.h b/libsepol/include/sepol/policydb/hierarchy.h
index de2dfc7..b4eb9bc 100644
--- a/libsepol/include/sepol/policydb/hierarchy.h
+++ b/libsepol/include/sepol/policydb/hierarchy.h
@@ -26,7 +26,11 @@
 #define _SEPOL_POLICYDB_HIERARCHY_H_
 
 #include <sepol/policydb/policydb.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 extern int hierarchy_check_constraints(sepol_handle_t * handle, policydb_t * p);
 
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/policydb/link.h b/libsepol/include/sepol/policydb/link.h
index fca9114..7c7c9be 100644
--- a/libsepol/include/sepol/policydb/link.h
+++ b/libsepol/include/sepol/policydb/link.h
@@ -12,9 +12,13 @@
 
 
 #include <stddef.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 extern int link_modules(sepol_handle_t * handle,
 			policydb_t * b, policydb_t ** mods, int len,
 			int verbose);
 
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/policydb/mls_types.h b/libsepol/include/sepol/policydb/mls_types.h
index e491209..4bf7367 100644
--- a/libsepol/include/sepol/policydb/mls_types.h
+++ b/libsepol/include/sepol/policydb/mls_types.h
@@ -1,4 +1,3 @@
-
 /* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
 /*
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
@@ -35,6 +34,9 @@
 #include <stdlib.h>
 #include <sepol/policydb/ebitmap.h>
 #include <sepol/policydb/flask_types.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 typedef struct mls_level {
 	uint32_t sens;		/* sensitivity */
@@ -150,4 +152,5 @@ extern void mls_semantic_range_init(mls_semantic_range_t *r);
 extern void mls_semantic_range_destroy(mls_semantic_range_t *r);
 extern int mls_semantic_range_cpy(mls_semantic_range_t *dst, mls_semantic_range_t *src);
 
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/policydb/module.h b/libsepol/include/sepol/policydb/module.h
index 10403c8..3fe560c 100644
--- a/libsepol/include/sepol/policydb/module.h
+++ b/libsepol/include/sepol/policydb/module.h
@@ -27,9 +27,12 @@
 
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/conditional.h>
+#include <sys/cdefs.h>
 
 #define SEPOL_MODULE_PACKAGE_MAGIC 0xf97cff8f
 
+__BEGIN_DECLS
+
 struct sepol_module_package {
 	sepol_policydb_t *policy;
 	uint32_t version;
@@ -45,4 +48,5 @@ struct sepol_module_package {
 
 extern int sepol_module_package_init(sepol_module_package_t * p);
 
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
index f90a48d..74b7c9e 100644
--- a/libsepol/include/sepol/policydb/polcaps.h
+++ b/libsepol/include/sepol/policydb/polcaps.h
@@ -1,6 +1,10 @@
 #ifndef _SEPOL_POLICYDB_POLCAPS_H_
 #define _SEPOL_POLICYDB_POLCAPS_H_
 
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
+
 /* Policy capabilities */
 enum {
 	POLICYDB_CAPABILITY_NETPEER,
@@ -17,4 +21,5 @@ extern int sepol_polcap_getnum(const char *name);
 /* Convert a capability number to name. */
 extern const char *sepol_polcap_getname(int capnum);
 
+__END_DECLS
 #endif /* _SEPOL_POLICYDB_POLCAPS_H_ */
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 20bf759..6254fef 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -1,4 +1,3 @@
-
 /* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
 
 /*
@@ -62,6 +61,7 @@
 #include <sepol/policydb/context.h>
 #include <sepol/policydb/constraint.h>
 #include <sepol/policydb/sidtab.h>
+#include <sys/cdefs.h>
 
 #define ERRMSG_LEN 1024
 
@@ -69,6 +69,8 @@
 #define POLICYDB_ERROR       -1
 #define POLICYDB_UNSUPPORTED -2
 
+__BEGIN_DECLS
+
 /*
  * A datum type is defined for each kind of symbol 
  * in the configuration data:  individual permissions, 
@@ -234,7 +236,7 @@ typedef struct cond_node cond_list_t;
 struct cond_av_list;
 
 typedef struct class_perm_node {
-	uint32_t class;
+	uint32_t tclass;
 	uint32_t data;		/* permissions or new type */
 	struct class_perm_node *next;
 } class_perm_node_t;
@@ -742,7 +744,7 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define POLICYDB_MOD_MAGIC SELINUX_MOD_MAGIC
 #define POLICYDB_MOD_STRING "SE Linux Module"
 
-
+__END_DECLS
 #endif				/* _POLICYDB_H_ */
 
 /* FLASK */
diff --git a/libsepol/include/sepol/policydb/services.h b/libsepol/include/sepol/policydb/services.h
index bcde47b..8a5dc9a 100644
--- a/libsepol/include/sepol/policydb/services.h
+++ b/libsepol/include/sepol/policydb/services.h
@@ -15,6 +15,9 @@
 #include <sepol/policydb/flask_types.h>
 #include <sepol/policydb/policydb.h>
 #include <stddef.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 /* Set the policydb and sidtab structures to be used by
    the service functions.  If not set, then these default
@@ -227,4 +230,5 @@ extern int sepol_genfs_sid(const char *fstype,	/* IN */
 			   sepol_security_class_t sclass,	/* IN */
 			   sepol_security_id_t * sid);	/* OUT  */
 
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/policydb/sidtab.h b/libsepol/include/sepol/policydb/sidtab.h
index 33c7cb5..4b93567 100644
--- a/libsepol/include/sepol/policydb/sidtab.h
+++ b/libsepol/include/sepol/policydb/sidtab.h
@@ -1,4 +1,3 @@
-
 /* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
 
 /* FLASK */
@@ -12,6 +11,9 @@
 #define _SEPOL_POLICYDB_SIDTAB_H_
 
 #include <sepol/policydb/context.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 typedef struct sidtab_node {
 	sepol_security_id_t sid;	/* security identifier */
@@ -67,6 +69,7 @@ extern void sepol_sidtab_set(sidtab_t * dst, sidtab_t * src);
 
 extern void sepol_sidtab_shutdown(sidtab_t * s);
 
+__END_DECLS
 #endif				/* _SIDTAB_H_ */
 
 /* FLASK */
diff --git a/libsepol/include/sepol/policydb/symtab.h b/libsepol/include/sepol/policydb/symtab.h
index 490731b..e0da337 100644
--- a/libsepol/include/sepol/policydb/symtab.h
+++ b/libsepol/include/sepol/policydb/symtab.h
@@ -14,6 +14,9 @@
 #define _SEPOL_POLICYDB_SYMTAB_H_
 
 #include <sepol/policydb/hashtab.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 /* The symtab_datum struct stores the common information for
  * all symtab datums. It should the first element in every
@@ -34,6 +37,7 @@ typedef struct {
 extern int symtab_init(symtab_t *, unsigned int size);
 extern void symtab_destroy(symtab_t *);
 
+__END_DECLS
 #endif				/* _SYMTAB_H_ */
 
 /* FLASK */
diff --git a/libsepol/include/sepol/policydb/util.h b/libsepol/include/sepol/policydb/util.h
index 40bfaa6..ef1c90d 100644
--- a/libsepol/include/sepol/policydb/util.h
+++ b/libsepol/include/sepol/policydb/util.h
@@ -23,9 +23,14 @@
 #ifndef __SEPOL_UTIL_H__
 #define __SEPOL_UTIL_H__
 
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
+
 extern int add_i_to_a(uint32_t i, uint32_t * cnt, uint32_t ** a);
 
 extern char *sepol_av_to_string(policydb_t * policydbp, uint32_t tclass,
 				sepol_access_vector_t av);
 
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/port_record.h b/libsepol/include/sepol/port_record.h
index b347e08..697cea4 100644
--- a/libsepol/include/sepol/port_record.h
+++ b/libsepol/include/sepol/port_record.h
@@ -3,6 +3,9 @@
 
 #include <sepol/context_record.h>
 #include <sepol/handle.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 struct sepol_port;
 struct sepol_port_key;
@@ -63,4 +66,5 @@ extern int sepol_port_clone(sepol_handle_t * handle,
 
 extern void sepol_port_free(sepol_port_t * port);
 
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/ports.h b/libsepol/include/sepol/ports.h
index fb94117..b4622ba 100644
--- a/libsepol/include/sepol/ports.h
+++ b/libsepol/include/sepol/ports.h
@@ -4,6 +4,9 @@
 #include <sepol/handle.h>
 #include <sepol/policydb.h>
 #include <sepol/port_record.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 /* Return the number of ports */
 extern int sepol_port_count(sepol_handle_t * handle,
@@ -37,4 +40,5 @@ extern int sepol_port_iterate(sepol_handle_t * handle,
 			      int (*fn) (const sepol_port_t * port,
 					 void *fn_arg), void *arg);
 
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/roles.h b/libsepol/include/sepol/roles.h
index 113f9d2..89b3af2 100644
--- a/libsepol/include/sepol/roles.h
+++ b/libsepol/include/sepol/roles.h
@@ -1,10 +1,15 @@
 #ifndef _SEPOL_ROLES_H_
 #define _SEPOL_ROLES_H_
 
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
+
 extern int sepol_role_exists(const sepol_policydb_t * policydb,
 			     const char *role, int *response);
 
 extern int sepol_role_list(const sepol_policydb_t * policydb,
 			   char ***roles, unsigned int *nroles);
 
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/sepol.h b/libsepol/include/sepol/sepol.h
index c8900d3..00a2129 100644
--- a/libsepol/include/sepol/sepol.h
+++ b/libsepol/include/sepol/sepol.h
@@ -3,6 +3,9 @@
 
 #include <stddef.h>
 #include <stdio.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 #include <sepol/user_record.h>
 #include <sepol/context_record.h>
@@ -25,4 +28,5 @@
 /* Set internal policydb from a file for subsequent service calls. */
 extern int sepol_set_policydb_from_file(FILE * fp);
 
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/user_record.h b/libsepol/include/sepol/user_record.h
index c86ad16..9a39526 100644
--- a/libsepol/include/sepol/user_record.h
+++ b/libsepol/include/sepol/user_record.h
@@ -3,6 +3,9 @@
 
 #include <stddef.h>
 #include <sepol/handle.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 struct sepol_user;
 struct sepol_user_key;
@@ -73,4 +76,5 @@ extern int sepol_user_clone(sepol_handle_t * handle,
 
 extern void sepol_user_free(sepol_user_t * user);
 
+__END_DECLS
 #endif
diff --git a/libsepol/include/sepol/users.h b/libsepol/include/sepol/users.h
index 01b0775..0e0f76e 100644
--- a/libsepol/include/sepol/users.h
+++ b/libsepol/include/sepol/users.h
@@ -5,6 +5,9 @@
 #include <sepol/user_record.h>
 #include <sepol/handle.h>
 #include <stddef.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
 
 /*---------compatibility------------*/
 
@@ -54,4 +57,5 @@ extern int sepol_user_iterate(sepol_handle_t * handle,
 			      int (*fn) (const sepol_user_t * user,
 					 void *fn_arg), void *arg);
 
+__END_DECLS
 #endif
diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 5e4c4e8..c335968 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -38,22 +38,22 @@ static void report_failure(sepol_handle_t *handle, policydb_t *p,
 		    avrule->source_line, avrule->source_filename, avrule->line,
 		    p->p_type_val_to_name[stype],
 		    p->p_type_val_to_name[ttype],
-		    p->p_class_val_to_name[curperm->class - 1],
-		    sepol_av_to_string(p, curperm->class,
+		    p->p_class_val_to_name[curperm->tclass - 1],
+		    sepol_av_to_string(p, curperm->tclass,
 				       node->datum.data & curperm->data));
 	} else if (avrule->line) {
 		ERR(handle, "neverallow on line %lu violated by allow %s %s:%s {%s };",
 		    avrule->line, p->p_type_val_to_name[stype],
 		    p->p_type_val_to_name[ttype],
-		    p->p_class_val_to_name[curperm->class - 1],
-		    sepol_av_to_string(p, curperm->class,
+		    p->p_class_val_to_name[curperm->tclass - 1],
+		    sepol_av_to_string(p, curperm->tclass,
 				       node->datum.data & curperm->data));
 	} else {
 		ERR(handle, "neverallow violated by allow %s %s:%s {%s };",
 		    p->p_type_val_to_name[stype],
 		    p->p_type_val_to_name[ttype],
-		    p->p_class_val_to_name[curperm->class - 1],
-		    sepol_av_to_string(p, curperm->class,
+		    p->p_class_val_to_name[curperm->tclass - 1],
+		    sepol_av_to_string(p, curperm->tclass,
 				       node->datum.data & curperm->data));
 	}
 }
@@ -72,7 +72,7 @@ static unsigned long check_assertion_helper(sepol_handle_t * handle,
 	for (curperm = avrule->perms; curperm != NULL; curperm = curperm->next) {
 		avkey.source_type = stype + 1;
 		avkey.target_type = ttype + 1;
-		avkey.target_class = curperm->class;
+		avkey.target_class = curperm->tclass;
 		avkey.specified = AVTAB_ALLOWED;
 		for (node = avtab_search_node(te_avtab, &avkey);
 		     node != NULL;
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 57293ae..467f7a7 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1679,7 +1679,7 @@ static int expand_terule_helper(sepol_handle_t * handle,
 		    typemap ? typemap[cur->data - 1] : cur->data;
 		avkey.source_type = stype + 1;
 		avkey.target_type = ttype + 1;
-		avkey.target_class = cur->class;
+		avkey.target_class = cur->tclass;
 		avkey.specified = spec;
 
 		conflict = 0;
@@ -1791,7 +1791,7 @@ static int expand_avrule_helper(sepol_handle_t * handle,
 	while (cur) {
 		avkey.source_type = stype + 1;
 		avkey.target_type = ttype + 1;
-		avkey.target_class = cur->class;
+		avkey.target_class = cur->tclass;
 		avkey.specified = spec;
 
 		node = find_avtab_node(handle, avtab, &avkey, cond);
@@ -2574,8 +2574,8 @@ static int copy_neverallow(policydb_t * dest_pol, uint32_t * typemap,
 		if (!new_perm)
 			goto err;
 		class_perm_node_init(new_perm);
-		new_perm->class = cur_perm->class;
-		assert(new_perm->class);
+		new_perm->tclass = cur_perm->tclass;
+		assert(new_perm->tclass);
 
 		/* once we have modules with permissions we'll need to map the permissions (and classes) */
 		new_perm->data = cur_perm->data;
diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index e0bb198..f98a8d2 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -1293,21 +1293,21 @@ static int copy_avrule_list(avrule_t * list, avrule_t ** dst,
 			}
 			class_perm_node_init(new_perm);
 
-			new_perm->class =
-			    module->map[SYM_CLASSES][cur_perm->class - 1];
-			assert(new_perm->class);
+			new_perm->tclass =
+			    module->map[SYM_CLASSES][cur_perm->tclass - 1];
+			assert(new_perm->tclass);
 
 			if (new_rule->specified & AVRULE_AV) {
 				for (i = 0;
 				     i <
-				     module->perm_map_len[cur_perm->class - 1];
+				     module->perm_map_len[cur_perm->tclass - 1];
 				     i++) {
 					if (!(cur_perm->data & (1U << i)))
 						continue;
 					new_perm->data |=
 					    (1U <<
 					     (module->
-					      perm_map[cur_perm->class - 1][i] -
+					      perm_map[cur_perm->tclass - 1][i] -
 					      1));
 				}
 			} else {
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index f077b93..667e98a 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -3039,7 +3039,7 @@ static avrule_t *avrule_read(policydb_t * p
 			goto bad;
 		}
 
-		cur->class = le32_to_cpu(buf[0]);
+		cur->tclass = le32_to_cpu(buf[0]);
 		cur->data = le32_to_cpu(buf[1]);
 
 		if (!tail) {
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 2e6541d..d03dc20 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -1514,7 +1514,7 @@ static int avrule_write(avrule_t * avrule, struct policy_file *fp)
 	cur = avrule->perms;
 	while (cur) {
 		items = 0;
-		buf[items++] = cpu_to_le32(cur->class);
+		buf[items++] = cpu_to_le32(cur->tclass);
 		buf[items++] = cpu_to_le32(cur->data);
 		items2 = put_entry(buf, sizeof(uint32_t), items, fp);
 		if (items2 != items)
diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
index 4b9f310..b863346 100644
--- a/policycoreutils/hll/pp/pp.c
+++ b/policycoreutils/hll/pp/pp.c
@@ -538,7 +538,7 @@ static int avrule_to_cil(int indent, struct policydb *pdb, uint32_t type, const
 
 	for (classperm = classperms; classperm != NULL; classperm = classperm->next) {
 		if (type & AVRULE_AV) {
-			perms = sepol_av_to_string(pdb, classperm->class, classperm->data);
+			perms = sepol_av_to_string(pdb, classperm->tclass, classperm->data);
 			if (perms == NULL) {
 				log_err("Failed to generate permission string");
 				rc = -1;
@@ -546,12 +546,12 @@ static int avrule_to_cil(int indent, struct policydb *pdb, uint32_t type, const
 			}
 			cil_println(indent, "(%s %s %s (%s (%s)))",
 					rule, src, tgt,
-					pdb->p_class_val_to_name[classperm->class - 1],
+					pdb->p_class_val_to_name[classperm->tclass - 1],
 					perms + 1);
 		} else {
 			cil_println(indent, "(%s %s %s %s %s)",
 					rule, src, tgt,
-					pdb->p_class_val_to_name[classperm->class - 1],
+					pdb->p_class_val_to_name[classperm->tclass - 1],
 					pdb->p_type_val_to_name[classperm->data - 1]);
 		}
 	}
-- 
1.9.3
