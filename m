Subject: [RFC 1/3] hook callbacks
From: Josh Brindle <jbrindle@tresys.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Content-Type: text/plain
Date: Tue, 01 Aug 2006 07:51:46 -0400
Message-Id: <1154433106.23513.8.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is the main hooks.h which is a public header, it implements the
security_ops struct.

diff -pruN trunk-old/libsepol/include/sepol/hooks.h trunk/libsepol/include/sepol/hooks.h
--- trunk-old/libsepol/include/sepol/hooks.h	1969-12-31 19:00:00.000000000 -0500
+++ trunk/libsepol/include/sepol/hooks.h	2006-07-31 13:03:26.000000000 -0400
@@ -0,0 +1,49 @@
+#ifndef _SEPOL_HOOKS_H
+#define _SEPOL_HOOKS_H
+
+#include <sepol/policydb.h>
+
+#define SEPOL_SEC_CLASSES 1
+#define SEPOL_SEC_ROLES   2
+#define SEPOL_SEC_TYPES   3
+#define SEPOL_SEC_USERS   4
+#define SEPOL_SEC_BOOLS   5
+#define SEPOL_SEC_LEVELS  6
+#define SEPOL_SEC_CATS    7
+#define SEPOL_SEC_ATTRIBS 8
+
+#define SEPOL_SEC_TGT 1
+#define SEPOL_SEC_SRC 2
+
+#define SEPOL_SEC_ALLOW 1
+#define SEPOL_SEC_DONTAUDIT 2
+
+typedef struct sepol_security_internal sepol_security_internal_t;
+
+typedef struct sepol_security_ops {
+	int (*symbol_add) (int sym_type, char *type);
+	int (*symbol_remove) (int sym_type, char *type);
+
+	/* type hooks */
+	int (*type_add_attrib) (char *attrib, char *type);
+
+	/* role hooks */
+	int (*role_allow_add) (char *role, char *new_role);
+	int (*role_trans_add) (char *role, char *type, char *new_role);
+	int (*role_add_type) (char *role, char *type);
+
+	/* user hooks */
+	int (*user_add_role) (char *user, char *role);
+
+	int (*avrule_add) (int type, char *src, char *tgt, char *class, char **perms, int num_perms);
+
+	
+	/* opaque struct that has internal state for the security checks */
+	sepol_security_internal_t *pvt;
+
+} sepol_security_ops_t;
+
+extern int sepol_set_security_ops(sepol_handle_t *sh,
+				   sepol_security_ops_t *sec);
+
+#endif
diff -pruN trunk-old/libsepol/src/hooks_internal.h trunk/libsepol/src/hooks_internal.h
--- trunk-old/libsepol/src/hooks_internal.h	1969-12-31 19:00:00.000000000 -0500
+++ trunk/libsepol/src/hooks_internal.h	2006-07-31 13:03:26.000000000 -0400
@@ -0,0 +1,15 @@
+#ifndef _SEPOL_HOOKS_INTERNAL_H_
+#define _SEPOL_HOOKS_INTERNAL_H_
+
+#include <sepol/handle.h>
+#include <sepol/hooks.h>
+#include <sepol/policydb/policydb.h>
+
+extern int sepol_security_create_maps(const policydb_t *src, sepol_security_ops_t *sec);
+extern void sepol_init_security_ops(sepol_security_ops_t *sec);
+
+extern int sepol_symbol_add(sepol_handle_t *sh, int sym_type, char *id);
+extern int sepol_role_allow_add_check(sepol_handle_t *sh, policydb_t *new_pol, uint32_t role, uint32_t new_role);
+extern int sepol_role_trans_check(sepol_handle_t *sh, policydb_t *new_pol, uint32_t role, uint32_t type, uint32_t new_role);
+int sepol_avrule_add_check(sepol_handle_t *sh, policydb_t *new_pol, int spec, uint32_t stype, uint32_t ttype, uint32_t class, sepol_access_vector_t perms);
+#endif



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
