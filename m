Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4FKhjS1021297
 for <selinux@tycho.nsa.gov>; Mon, 15 May 2017 16:43:47 -0400
From: Dan Jurgens <danielj@mellanox.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH v1 7/9] semanage: Update semanage to allow runtime labeling of
 Infiniband Pkeys
Date: Mon, 15 May 2017 23:42:39 +0300
Message-Id: <1494880961-73481-8-git-send-email-danielj@mellanox.com>
In-Reply-To: <1494880961-73481-1-git-send-email-danielj@mellanox.com>
References: <1494880961-73481-1-git-send-email-danielj@mellanox.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Daniel Jurgens <danielj@mellanox.com>

Update libsepol and libsemanage to work with pkey records. Add local
storage for new and modified pkey records in pkeys.local. Update semanage
to parse the pkey command options to add, modify, and delete pkeys.

Signed-off-by: Daniel Jurgens <danielj@mellanox.com>

---
v1:
Fixed semanage_pkey_exists -> semanage_ibpkey_exists in delete flow in
seobject.py

Stephen Smalley:
- Subnet prefix can't vary in size always 16 bytes, remove size field.
- Removed extraneous change in libsepol/VERSION
- Removed ifdef DARWIN s6_addr/32 blocks in favor of s6_addr.
- Got rid of magic constant for subnet prefix size.

Jason Zaman:
- Use SETools directly to query types in seobject.py.

Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
---
 libsemanage/include/semanage/ibpkey_record.h  |  76 +++++
 libsemanage/include/semanage/ibpkeys_local.h  |  36 +++
 libsemanage/include/semanage/ibpkeys_policy.h |  28 ++
 libsemanage/include/semanage/semanage.h       |   3 +
 libsemanage/src/direct_api.c                  |  29 +-
 libsemanage/src/handle.h                      |  36 ++-
 libsemanage/src/ibpkey_internal.h             |  52 +++
 libsemanage/src/ibpkey_record.c               | 185 +++++++++++
 libsemanage/src/ibpkeys_file.c                | 181 +++++++++++
 libsemanage/src/ibpkeys_local.c               | 178 ++++++++++
 libsemanage/src/ibpkeys_policy.c              |  52 +++
 libsemanage/src/ibpkeys_policydb.c            |  62 ++++
 libsemanage/src/libsemanage.map               |   1 +
 libsemanage/src/policy_components.c           |   5 +-
 libsemanage/src/semanage_store.c              |   1 +
 libsemanage/src/semanage_store.h              |   1 +
 libsemanage/src/semanageswig.i                |   3 +
 libsemanage/src/semanageswig_python.i         |  43 +++
 libsemanage/utils/semanage_migrate_store      |   3 +-
 libsepol/include/sepol/ibpkey_record.h        |  77 +++++
 libsepol/include/sepol/ibpkeys.h              |  44 +++
 libsepol/include/sepol/sepol.h                |   2 +
 libsepol/src/ibpkey_internal.h                |  21 ++
 libsepol/src/ibpkey_record.c                  | 448 ++++++++++++++++++++++++++
 libsepol/src/ibpkeys.c                        | 263 +++++++++++++++
 python/semanage/semanage                      |  60 +++-
 python/semanage/seobject.py                   | 255 +++++++++++++++
 27 files changed, 2129 insertions(+), 16 deletions(-)
 create mode 100644 libsemanage/include/semanage/ibpkey_record.h
 create mode 100644 libsemanage/include/semanage/ibpkeys_local.h
 create mode 100644 libsemanage/include/semanage/ibpkeys_policy.h
 create mode 100644 libsemanage/src/ibpkey_internal.h
 create mode 100644 libsemanage/src/ibpkey_record.c
 create mode 100644 libsemanage/src/ibpkeys_file.c
 create mode 100644 libsemanage/src/ibpkeys_local.c
 create mode 100644 libsemanage/src/ibpkeys_policy.c
 create mode 100644 libsemanage/src/ibpkeys_policydb.c
 create mode 100644 libsepol/include/sepol/ibpkey_record.h
 create mode 100644 libsepol/include/sepol/ibpkeys.h
 create mode 100644 libsepol/src/ibpkey_internal.h
 create mode 100644 libsepol/src/ibpkey_record.c
 create mode 100644 libsepol/src/ibpkeys.c

diff --git a/libsemanage/include/semanage/ibpkey_record.h b/libsemanage/include/semanage/ibpkey_record.h
new file mode 100644
index 0000000..d76aaae
--- /dev/null
+++ b/libsemanage/include/semanage/ibpkey_record.h
@@ -0,0 +1,76 @@
+/* Copyright (C) 2017 Mellanox Technologies Inc */
+
+#ifndef _SEMANAGE_IBPKEY_RECORD_H_
+#define _SEMANAGE_IBPKEY_RECORD_H_
+
+#include <semanage/context_record.h>
+#include <semanage/handle.h>
+#include <stddef.h>
+
+#ifndef _SEMANAGE_IBPKEY_DEFINED_
+struct semanage_ibpkey;
+struct semanage_ibpkey_key;
+typedef struct semanage_ibpkey semanage_ibpkey_t;
+typedef struct semanage_ibpkey_key semanage_ibpkey_key_t;
+#define _SEMANAGE_IBPKEY_DEFINED_
+#endif
+
+#define INET6_ADDRLEN 16
+
+extern int semanage_ibpkey_compare(const semanage_ibpkey_t *ibpkey,
+				   const semanage_ibpkey_key_t *key);
+
+extern int semanage_ibpkey_compare2(const semanage_ibpkey_t *ibpkey,
+				    const semanage_ibpkey_t *ibpkey2);
+
+extern int semanage_ibpkey_key_create(semanage_handle_t *handle,
+				      const char *subnet_prefix,
+				      int low, int high,
+				      semanage_ibpkey_key_t **key_ptr);
+
+extern int semanage_ibpkey_key_extract(semanage_handle_t *handle,
+				       const semanage_ibpkey_t *ibpkey,
+				       semanage_ibpkey_key_t **key_ptr);
+
+extern void semanage_ibpkey_key_free(semanage_ibpkey_key_t *key);
+
+extern int semanage_ibpkey_get_subnet_prefix(semanage_handle_t *handle,
+					     const semanage_ibpkey_t *ibpkey,
+					     char **subnet_prefix_ptr);
+
+extern int semanage_ibpkey_get_subnet_prefix_bytes(semanage_handle_t *handle,
+						   const semanage_ibpkey_t *ibpkey,
+						   char **subnet_prefix);
+
+extern int semanage_ibpkey_set_subnet_prefix(semanage_handle_t *handle,
+					     semanage_ibpkey_t *ibpkey,
+					     const char *subnet_prefix);
+
+extern int semanage_ibpkey_set_subnet_prefix_bytes(semanage_handle_t *handle,
+						   semanage_ibpkey_t *ibpkey,
+						   const char *subnet_prefix);
+
+extern int semanage_ibpkey_get_low(const semanage_ibpkey_t *ibpkey);
+
+extern int semanage_ibpkey_get_high(const semanage_ibpkey_t *ibpkey);
+
+extern void semanage_ibpkey_set_pkey(semanage_ibpkey_t *ibpkey, int pkey_num);
+
+extern void semanage_ibpkey_set_range(semanage_ibpkey_t *ibpkey, int low, int high);
+
+extern semanage_context_t *semanage_ibpkey_get_con(const semanage_ibpkey_t *ibpkey);
+
+extern int semanage_ibpkey_set_con(semanage_handle_t *handle,
+				   semanage_ibpkey_t *ibpkey,
+				   semanage_context_t *con);
+
+extern int semanage_ibpkey_create(semanage_handle_t *handle,
+				  semanage_ibpkey_t **ibpkey_ptr);
+
+extern int semanage_ibpkey_clone(semanage_handle_t *handle,
+				 const semanage_ibpkey_t *ibpkey,
+				 semanage_ibpkey_t **ibpkey_ptr);
+
+extern void semanage_ibpkey_free(semanage_ibpkey_t *ibpkey);
+
+#endif
diff --git a/libsemanage/include/semanage/ibpkeys_local.h b/libsemanage/include/semanage/ibpkeys_local.h
new file mode 100644
index 0000000..079a642
--- /dev/null
+++ b/libsemanage/include/semanage/ibpkeys_local.h
@@ -0,0 +1,36 @@
+/* Copyright (C) 2017 Mellanox Technologies Inc */
+
+#ifndef _SEMANAGE_IBPKEYS_LOCAL_H_
+#define _SEMANAGE_IBPKEYS_LOCAL_H_
+
+#include <semanage/ibpkey_record.h>
+#include <semanage/handle.h>
+
+extern int semanage_ibpkey_modify_local(semanage_handle_t *handle,
+					const semanage_ibpkey_key_t *key,
+					const semanage_ibpkey_t *data);
+
+extern int semanage_ibpkey_del_local(semanage_handle_t *handle,
+				     const semanage_ibpkey_key_t *key);
+
+extern int semanage_ibpkey_query_local(semanage_handle_t *handle,
+				       const semanage_ibpkey_key_t *key,
+				       semanage_ibpkey_t **response);
+
+extern int semanage_ibpkey_exists_local(semanage_handle_t *handle,
+					const semanage_ibpkey_key_t *key,
+					int *response);
+
+extern int semanage_ibpkey_count_local(semanage_handle_t *handle,
+				       unsigned int *response);
+
+extern int semanage_ibpkey_iterate_local(semanage_handle_t *handle,
+					 int (*handler)(const semanage_ibpkey_t *
+							record, void *varg),
+					 void *handler_arg);
+
+extern int semanage_ibpkey_list_local(semanage_handle_t *handle,
+				      semanage_ibpkey_t ***records,
+				      unsigned int *count);
+
+#endif
diff --git a/libsemanage/include/semanage/ibpkeys_policy.h b/libsemanage/include/semanage/ibpkeys_policy.h
new file mode 100644
index 0000000..c287ac0
--- /dev/null
+++ b/libsemanage/include/semanage/ibpkeys_policy.h
@@ -0,0 +1,28 @@
+/* Copyright (C) 2017 Mellanox Technolgies Inc. */
+
+#ifndef _SEMANAGE_IBPKEYS_POLICY_H_
+#define _SEMANAGE_IBPKEYS_POLICY_H_
+
+#include <semanage/handle.h>
+#include <semanage/ibpkey_record.h>
+
+extern int semanage_ibpkey_query(semanage_handle_t *handle,
+				 const semanage_ibpkey_key_t *key,
+				 semanage_ibpkey_t **response);
+
+extern int semanage_ibpkey_exists(semanage_handle_t *handle,
+				  const semanage_ibpkey_key_t *key, int *response);
+
+extern int semanage_ibpkey_count(semanage_handle_t *handle,
+				 unsigned int *response);
+
+extern int semanage_ibpkey_iterate(semanage_handle_t *handle,
+				   int (*handler)(const semanage_ibpkey_t *record,
+						  void *varg),
+				   void *handler_arg);
+
+extern int semanage_ibpkey_list(semanage_handle_t *handle,
+				semanage_ibpkey_t ***records,
+				unsigned int *count);
+
+#endif
diff --git a/libsemanage/include/semanage/semanage.h b/libsemanage/include/semanage/semanage.h
index f417ce4..cebf3f4 100644
--- a/libsemanage/include/semanage/semanage.h
+++ b/libsemanage/include/semanage/semanage.h
@@ -33,6 +33,7 @@
 #include <semanage/context_record.h>
 #include <semanage/iface_record.h>
 #include <semanage/port_record.h>
+#include <semanage/ibpkey_record.h>
 #include <semanage/node_record.h>
 
 /* Dbase */
@@ -47,6 +48,8 @@
 #include <semanage/seusers_policy.h>
 #include <semanage/ports_local.h>
 #include <semanage/ports_policy.h>
+#include <semanage/ibpkeys_local.h>
+#include <semanage/ibpkeys_policy.h>
 #include <semanage/interfaces_local.h>
 #include <semanage/interfaces_policy.h>
 #include <semanage/nodes_local.h>
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index f4b0416..436e334 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -40,6 +40,7 @@
 #include "user_internal.h"
 #include "seuser_internal.h"
 #include "port_internal.h"
+#include "ibpkey_internal.h"
 #include "iface_internal.h"
 #include "boolean_internal.h"
 #include "fcontext_internal.h"
@@ -224,6 +225,14 @@ int semanage_direct_connect(semanage_handle_t * sh)
 				 semanage_node_dbase_local(sh)) < 0)
 		goto err;
 
+	if (ibpkey_file_dbase_init(sh,
+				 semanage_path(SEMANAGE_ACTIVE,
+					       SEMANAGE_IBPKEYS_LOCAL),
+				 semanage_path(SEMANAGE_TMP,
+					       SEMANAGE_IBPKEYS_LOCAL),
+				 semanage_ibpkey_dbase_local(sh)) < 0)
+		goto err;
+
 	/* Object databases: local modifications + policy */
 	if (user_base_policydb_dbase_init(sh,
 					  semanage_user_base_dbase_policy(sh)) <
@@ -248,6 +257,9 @@ int semanage_direct_connect(semanage_handle_t * sh)
 	if (port_policydb_dbase_init(sh, semanage_port_dbase_policy(sh)) < 0)
 		goto err;
 
+	if (ibpkey_policydb_dbase_init(sh, semanage_ibpkey_dbase_policy(sh)) < 0)
+		goto err;
+
 	if (iface_policydb_dbase_init(sh, semanage_iface_dbase_policy(sh)) < 0)
 		goto err;
 
@@ -320,6 +332,7 @@ static int semanage_direct_disconnect(semanage_handle_t * sh)
 	user_extra_file_dbase_release(semanage_user_extra_dbase_local(sh));
 	user_join_dbase_release(semanage_user_dbase_local(sh));
 	port_file_dbase_release(semanage_port_dbase_local(sh));
+	ibpkey_file_dbase_release(semanage_ibpkey_dbase_local(sh));
 	iface_file_dbase_release(semanage_iface_dbase_local(sh));
 	bool_file_dbase_release(semanage_bool_dbase_local(sh));
 	fcontext_file_dbase_release(semanage_fcontext_dbase_local(sh));
@@ -331,6 +344,7 @@ static int semanage_direct_disconnect(semanage_handle_t * sh)
 	user_extra_file_dbase_release(semanage_user_extra_dbase_policy(sh));
 	user_join_dbase_release(semanage_user_dbase_policy(sh));
 	port_policydb_dbase_release(semanage_port_dbase_policy(sh));
+	ibpkey_policydb_dbase_release(semanage_ibpkey_dbase_policy(sh));
 	iface_policydb_dbase_release(semanage_iface_dbase_policy(sh));
 	bool_policydb_dbase_release(semanage_bool_dbase_policy(sh));
 	fcontext_file_dbase_release(semanage_fcontext_dbase_policy(sh));
@@ -1144,13 +1158,15 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 
 	int do_rebuild, do_write_kernel, do_install;
 	int fcontexts_modified, ports_modified, seusers_modified,
-		disable_dontaudit, preserve_tunables;
+		disable_dontaudit, preserve_tunables, ibpkeys_modified;
 	dbase_config_t *users = semanage_user_dbase_local(sh);
 	dbase_config_t *users_base = semanage_user_base_dbase_local(sh);
 	dbase_config_t *pusers_base = semanage_user_base_dbase_policy(sh);
 	dbase_config_t *pusers_extra = semanage_user_extra_dbase_policy(sh);
 	dbase_config_t *ports = semanage_port_dbase_local(sh);
 	dbase_config_t *pports = semanage_port_dbase_policy(sh);
+	dbase_config_t *ibpkeys = semanage_ibpkey_dbase_local(sh);
+	dbase_config_t *pibpkeys = semanage_ibpkey_dbase_policy(sh);
 	dbase_config_t *bools = semanage_bool_dbase_local(sh);
 	dbase_config_t *pbools = semanage_bool_dbase_policy(sh);
 	dbase_config_t *ifaces = semanage_iface_dbase_local(sh);
@@ -1164,6 +1180,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 
 	/* Modified flags that we need to use more than once. */
 	ports_modified = ports->dtable->is_modified(ports->dbase);
+	ibpkeys_modified = ibpkeys->dtable->is_modified(ibpkeys->dbase);
 	seusers_modified = seusers->dtable->is_modified(seusers->dbase);
 	fcontexts_modified = fcontexts->dtable->is_modified(fcontexts->dbase);
 
@@ -1285,7 +1302,7 @@ rebuild:
 	 * that live under /etc/selinux (kernel policy, seusers, file contexts)
 	 * will be modified.
 	 */
-	do_write_kernel = do_rebuild | ports_modified |
+	do_write_kernel = do_rebuild | ports_modified | ibpkeys_modified |
 		bools->dtable->is_modified(bools->dbase) |
 		ifaces->dtable->is_modified(ifaces->dbase) |
 		nodes->dtable->is_modified(nodes->dbase) |
@@ -1431,6 +1448,7 @@ rebuild:
 	/* Attach our databases to the policydb we just created or loaded. */
 	dbase_policydb_attach((dbase_policydb_t *) pusers_base->dbase, out);
 	dbase_policydb_attach((dbase_policydb_t *) pports->dbase, out);
+	dbase_policydb_attach((dbase_policydb_t *) pibpkeys->dbase, out);
 	dbase_policydb_attach((dbase_policydb_t *) pifaces->dbase, out);
 	dbase_policydb_attach((dbase_policydb_t *) pbools->dbase, out);
 	dbase_policydb_attach((dbase_policydb_t *) pnodes->dbase, out);
@@ -1479,6 +1497,12 @@ rebuild:
 			goto cleanup;
 	}
 
+	/* Validate local ibpkeys for overlap */
+	if (do_rebuild || ibpkeys_modified) {
+		retval = semanage_ibpkey_validate_local(sh);
+		if (retval < 0)
+			goto cleanup;
+	}
 	/* ================== Write non-policydb components ========= */
 
 	/* Commit changes to components */
@@ -1558,6 +1582,7 @@ cleanup:
 	/* Detach from policydb, so it can be freed */
 	dbase_policydb_detach((dbase_policydb_t *) pusers_base->dbase);
 	dbase_policydb_detach((dbase_policydb_t *) pports->dbase);
+	dbase_policydb_detach((dbase_policydb_t *) pibpkeys->dbase);
 	dbase_policydb_detach((dbase_policydb_t *) pifaces->dbase);
 	dbase_policydb_detach((dbase_policydb_t *) pnodes->dbase);
 	dbase_policydb_detach((dbase_policydb_t *) pbools->dbase);
diff --git a/libsemanage/src/handle.h b/libsemanage/src/handle.h
index 64175c4..306727a 100644
--- a/libsemanage/src/handle.h
+++ b/libsemanage/src/handle.h
@@ -79,7 +79,7 @@ struct semanage_handle {
 	struct semanage_policy_table *funcs;
 
 	/* Object databases */
-#define DBASE_COUNT      19
+#define DBASE_COUNT      21
 
 /* Local modifications */
 #define DBASE_LOCAL_USERS_BASE  0
@@ -91,20 +91,22 @@ struct semanage_handle {
 #define DBASE_LOCAL_FCONTEXTS	6
 #define DBASE_LOCAL_SEUSERS     7
 #define DBASE_LOCAL_NODES       8
+#define DBASE_LOCAL_IBPKEYS     9
 
 /* Policy + Local modifications */
-#define DBASE_POLICY_USERS_BASE  9
-#define DBASE_POLICY_USERS_EXTRA 10
-#define DBASE_POLICY_USERS       11
-#define DBASE_POLICY_PORTS       12
-#define DBASE_POLICY_INTERFACES  13
-#define DBASE_POLICY_BOOLEANS    14
-#define DBASE_POLICY_FCONTEXTS   15
-#define DBASE_POLICY_SEUSERS     16
-#define DBASE_POLICY_NODES       17
+#define DBASE_POLICY_USERS_BASE  10
+#define DBASE_POLICY_USERS_EXTRA 11
+#define DBASE_POLICY_USERS       12
+#define DBASE_POLICY_PORTS       13
+#define DBASE_POLICY_INTERFACES  14
+#define DBASE_POLICY_BOOLEANS    15
+#define DBASE_POLICY_FCONTEXTS   16
+#define DBASE_POLICY_SEUSERS     17
+#define DBASE_POLICY_NODES       18
+#define DBASE_POLICY_IBPKEYS     19
 
 /* Active kernel policy */
-#define DBASE_ACTIVE_BOOLEANS    18
+#define DBASE_ACTIVE_BOOLEANS    20
 	dbase_config_t dbase[DBASE_COUNT];
 };
 
@@ -134,6 +136,12 @@ static inline
 }
 
 static inline
+    dbase_config_t * semanage_ibpkey_dbase_local(semanage_handle_t * handle)
+{
+	return &handle->dbase[DBASE_LOCAL_IBPKEYS];
+}
+
+static inline
     dbase_config_t * semanage_iface_dbase_local(semanage_handle_t * handle)
 {
 	return &handle->dbase[DBASE_LOCAL_INTERFACES];
@@ -190,6 +198,12 @@ static inline
 }
 
 static inline
+    dbase_config_t * semanage_ibpkey_dbase_policy(semanage_handle_t * handle)
+{
+	return &handle->dbase[DBASE_POLICY_IBPKEYS];
+}
+
+static inline
     dbase_config_t * semanage_iface_dbase_policy(semanage_handle_t * handle)
 {
 	return &handle->dbase[DBASE_POLICY_INTERFACES];
diff --git a/libsemanage/src/ibpkey_internal.h b/libsemanage/src/ibpkey_internal.h
new file mode 100644
index 0000000..9465bb8
--- /dev/null
+++ b/libsemanage/src/ibpkey_internal.h
@@ -0,0 +1,52 @@
+#ifndef _SEMANAGE_IBPKEY_INTERNAL_H_
+#define _SEMANAGE_IBPKEY_INTERNAL_H_
+
+#include <semanage/ibpkey_record.h>
+#include <semanage/ibpkeys_local.h>
+#include <semanage/ibpkeys_policy.h>
+#include "database.h"
+#include "handle.h"
+#include "dso.h"
+
+hidden_proto(semanage_ibpkey_create)
+hidden_proto(semanage_ibpkey_compare)
+hidden_proto(semanage_ibpkey_compare2)
+hidden_proto(semanage_ibpkey_clone)
+hidden_proto(semanage_ibpkey_free)
+hidden_proto(semanage_ibpkey_key_extract)
+hidden_proto(semanage_ibpkey_key_free)
+hidden_proto(semanage_ibpkey_get_high)
+hidden_proto(semanage_ibpkey_get_low)
+hidden_proto(semanage_ibpkey_set_pkey)
+hidden_proto(semanage_ibpkey_set_range)
+hidden_proto(semanage_ibpkey_get_con)
+hidden_proto(semanage_ibpkey_set_con)
+hidden_proto(semanage_ibpkey_list_local)
+hidden_proto(semanage_ibpkey_get_subnet_prefix)
+hidden_proto(semanage_ibpkey_get_subnet_prefix_bytes)
+hidden_proto(semanage_ibpkey_set_subnet_prefix)
+hidden_proto(semanage_ibpkey_set_subnet_prefix_bytes)
+
+/* PKEY RECORD: method table */
+extern record_table_t SEMANAGE_IBPKEY_RTABLE;
+
+extern int ibpkey_file_dbase_init(semanage_handle_t *handle,
+				  const char *path_ro,
+				  const char *path_rw,
+				  dbase_config_t *dconfig);
+
+extern void ibpkey_file_dbase_release(dbase_config_t *dconfig);
+
+extern int ibpkey_policydb_dbase_init(semanage_handle_t *handle,
+				      dbase_config_t *dconfig);
+
+extern void ibpkey_policydb_dbase_release(dbase_config_t *dconfig);
+
+extern int hidden semanage_ibpkey_validate_local(semanage_handle_t *handle);
+
+/* ==== Internal (to ibpkeys) API === */
+
+hidden int semanage_ibpkey_compare2_qsort(const semanage_ibpkey_t **ibpkey,
+					  const semanage_ibpkey_t **ibpkey2);
+
+#endif
diff --git a/libsemanage/src/ibpkey_record.c b/libsemanage/src/ibpkey_record.c
new file mode 100644
index 0000000..707eebd
--- /dev/null
+++ b/libsemanage/src/ibpkey_record.c
@@ -0,0 +1,185 @@
+/* Copyright (C) 2017 Mellanox Technologies Inc. */
+
+/* Object: semanage_ibpkey_t (Infiniband Pkey)
+ * Object: semanage_ibpkey_key_t (Infiniband Pkey Key)
+ * Implements: record_t (Database Record)
+ * Implements: record_key_t (Database Record Key)
+ */
+
+#include <sepol/context_record.h>
+#include <sepol/ibpkey_record.h>
+
+typedef sepol_context_t semanage_context_t;
+typedef sepol_ibpkey_t semanage_ibpkey_t;
+typedef sepol_ibpkey_key_t semanage_ibpkey_key_t;
+#define _SEMANAGE_IBPKEY_DEFINED_
+#define _SEMANAGE_CONTEXT_DEFINED_
+
+typedef semanage_ibpkey_t record_t;
+typedef semanage_ibpkey_key_t record_key_t;
+#define DBASE_RECORD_DEFINED
+
+#include "ibpkey_internal.h"
+#include "handle.h"
+#include "database.h"
+
+int semanage_ibpkey_compare(const semanage_ibpkey_t *ibpkey,
+			    const semanage_ibpkey_key_t *key)
+{
+	return sepol_ibpkey_compare(ibpkey, key);
+}
+
+hidden_def(semanage_ibpkey_compare)
+
+int semanage_ibpkey_compare2(const semanage_ibpkey_t *ibpkey,
+			     const semanage_ibpkey_t *ibpkey2)
+{
+	return sepol_ibpkey_compare2(ibpkey, ibpkey2);
+}
+
+hidden_def(semanage_ibpkey_compare2)
+
+hidden int semanage_ibpkey_compare2_qsort(const semanage_ibpkey_t **ibpkey,
+					  const semanage_ibpkey_t **ibpkey2)
+{
+	return sepol_ibpkey_compare2(*ibpkey, *ibpkey2);
+}
+
+int semanage_ibpkey_key_create(semanage_handle_t *handle,
+			       const char *subnet_prefix,
+			       int low, int high,
+			       semanage_ibpkey_key_t **key_ptr)
+{
+	return sepol_ibpkey_key_create(handle->sepolh, subnet_prefix, low, high, key_ptr);
+}
+
+int semanage_ibpkey_key_extract(semanage_handle_t *handle,
+				const semanage_ibpkey_t *ibpkey,
+				semanage_ibpkey_key_t **key_ptr)
+{
+	return sepol_ibpkey_key_extract(handle->sepolh, ibpkey, key_ptr);
+}
+
+hidden_def(semanage_ibpkey_key_extract)
+
+void semanage_ibpkey_key_free(semanage_ibpkey_key_t *key)
+{
+	sepol_ibpkey_key_free(key);
+}
+
+hidden_def(semanage_ibpkey_key_free)
+
+int semanage_ibpkey_get_subnet_prefix(semanage_handle_t *handle,
+				      const semanage_ibpkey_t *ibpkey,
+				      char **subnet_prefix_ptr)
+{
+	return sepol_ibpkey_get_subnet_prefix(handle->sepolh, ibpkey, subnet_prefix_ptr);
+}
+
+hidden_def(semanage_ibpkey_get_subnet_prefix)
+
+int semanage_ibpkey_get_subnet_prefix_bytes(semanage_handle_t *handle,
+					    const semanage_ibpkey_t *ibpkey,
+					    char **subnet_prefix)
+{
+	return sepol_ibpkey_get_subnet_prefix_bytes(handle->sepolh, ibpkey, subnet_prefix);
+}
+
+hidden_def(semanage_ibpkey_get_subnet_prefix_bytes)
+
+int semanage_ibpkey_set_subnet_prefix(semanage_handle_t *handle,
+				      semanage_ibpkey_t *ibpkey,
+				      const char *subnet_prefix)
+{
+	return sepol_ibpkey_set_subnet_prefix(handle->sepolh, ibpkey, subnet_prefix);
+}
+
+hidden_def(semanage_ibpkey_set_subnet_prefix)
+
+int semanage_ibpkey_set_subnet_prefix_bytes(semanage_handle_t *handle,
+					    semanage_ibpkey_t *ibpkey,
+					    const char *subnet_prefix)
+{
+	return sepol_ibpkey_set_subnet_prefix_bytes(handle->sepolh, ibpkey, subnet_prefix);
+}
+
+hidden_def(semanage_ibpkey_set_subnet_prefix_bytes)
+
+int semanage_ibpkey_get_low(const semanage_ibpkey_t *ibpkey)
+{
+	return sepol_ibpkey_get_low(ibpkey);
+}
+
+hidden_def(semanage_ibpkey_get_low)
+
+int semanage_ibpkey_get_high(const semanage_ibpkey_t *ibpkey)
+{
+	return sepol_ibpkey_get_high(ibpkey);
+}
+
+hidden_def(semanage_ibpkey_get_high)
+
+void semanage_ibpkey_set_pkey(semanage_ibpkey_t *ibpkey, int ibpkey_num)
+{
+	sepol_ibpkey_set_pkey(ibpkey, ibpkey_num);
+}
+
+hidden_def(semanage_ibpkey_set_pkey)
+
+void semanage_ibpkey_set_range(semanage_ibpkey_t *ibpkey, int low, int high)
+{
+	sepol_ibpkey_set_range(ibpkey, low, high);
+}
+
+hidden_def(semanage_ibpkey_set_range)
+
+semanage_context_t *semanage_ibpkey_get_con(const semanage_ibpkey_t *ibpkey)
+{
+	return sepol_ibpkey_get_con(ibpkey);
+}
+
+hidden_def(semanage_ibpkey_get_con)
+
+int semanage_ibpkey_set_con(semanage_handle_t *handle,
+			    semanage_ibpkey_t *ibpkey, semanage_context_t *con)
+{
+	return sepol_ibpkey_set_con(handle->sepolh, ibpkey, con);
+}
+
+hidden_def(semanage_ibpkey_set_con)
+
+int semanage_ibpkey_create(semanage_handle_t *handle,
+			   semanage_ibpkey_t **ibpkey_ptr)
+{
+	return sepol_ibpkey_create(handle->sepolh, ibpkey_ptr);
+}
+
+hidden_def(semanage_ibpkey_create)
+
+int semanage_ibpkey_clone(semanage_handle_t *handle,
+			  const semanage_ibpkey_t *ibpkey,
+			  semanage_ibpkey_t **ibpkey_ptr)
+{
+	return sepol_ibpkey_clone(handle->sepolh, ibpkey, ibpkey_ptr);
+}
+
+hidden_def(semanage_ibpkey_clone)
+
+void semanage_ibpkey_free(semanage_ibpkey_t *ibpkey)
+{
+	sepol_ibpkey_free(ibpkey);
+}
+
+hidden_def(semanage_ibpkey_free)
+
+/* key base functions */
+record_table_t SEMANAGE_IBPKEY_RTABLE = {
+	.create = semanage_ibpkey_create,
+	.key_extract = semanage_ibpkey_key_extract,
+	.key_free = semanage_ibpkey_key_free,
+	.clone = semanage_ibpkey_clone,
+	.compare = semanage_ibpkey_compare,
+	.compare2 = semanage_ibpkey_compare2,
+	.compare2_qsort = semanage_ibpkey_compare2_qsort,
+	.free = semanage_ibpkey_free,
+};
diff --git a/libsemanage/src/ibpkeys_file.c b/libsemanage/src/ibpkeys_file.c
new file mode 100644
index 0000000..ceaea7a
--- /dev/null
+++ b/libsemanage/src/ibpkeys_file.c
@@ -0,0 +1,181 @@
+/* Copyright (C) 2017 Mellanox Technologies Inc. */
+
+struct semanage_ibpkey;
+struct semanage_ibpkey_key;
+typedef struct semanage_ibpkey record_t;
+typedef struct semanage_ibpkey_key record_key_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_file;
+typedef struct dbase_file dbase_t;
+#define DBASE_DEFINED
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <strings.h>
+#include <semanage/handle.h>
+#include "ibpkey_internal.h"
+#include "context_internal.h"
+#include "database_file.h"
+#include "parse_utils.h"
+#include "debug.h"
+
+static int ibpkey_print(semanage_handle_t *handle,
+			semanage_ibpkey_t *ibpkey, FILE *str)
+{
+	char *con_str = NULL;
+	char *subnet_prefix_str = NULL;
+
+	int low = semanage_ibpkey_get_low(ibpkey);
+	int high = semanage_ibpkey_get_high(ibpkey);
+
+	if (semanage_ibpkey_get_subnet_prefix(handle, ibpkey, &subnet_prefix_str) != 0)
+		goto err;
+
+	semanage_context_t *con = semanage_ibpkey_get_con(ibpkey);
+
+	if (fprintf(str, "ibpkeycon %s ", subnet_prefix_str) < 0)
+		goto err;
+
+	if (low == high) {
+		if (fprintf(str, "%d ", low) < 0)
+			goto err;
+	} else {
+		if (fprintf(str, "%d - %d ", low, high) < 0)
+			goto err;
+	}
+
+	if (semanage_context_to_string(handle, con, &con_str) < 0)
+		goto err;
+	if (fprintf(str, "%s\n", con_str) < 0)
+		goto err;
+
+	free(subnet_prefix_str);
+	free(con_str);
+	return STATUS_SUCCESS;
+
+err:
+	ERR(handle, "could not print ibpkey range (%s) %u - %u to stream",
+	    subnet_prefix_str, low, high);
+	free(subnet_prefix_str);
+	free(con_str);
+	return STATUS_ERR;
+}
+
+static int ibpkey_parse(semanage_handle_t *handle,
+			parse_info_t *info, semanage_ibpkey_t *ibpkey)
+{
+	int low, high;
+	char *str = NULL;
+	semanage_context_t *con = NULL;
+
+	if (parse_skip_space(handle, info) < 0)
+		goto err;
+	if (!info->ptr)
+		goto last;
+
+	/* Header */
+	if (parse_assert_str(handle, info, "ibpkeycon") < 0)
+		goto err;
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+
+	/* Subnet Prefix */
+	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+		goto err;
+	if (semanage_ibpkey_set_subnet_prefix(handle, ibpkey, str) < 0)
+		goto err;
+	free(str);
+	str = NULL;
+
+	/* Range/Pkey */
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+	if (parse_fetch_int(handle, info, &low, '-') < 0)
+		goto err;
+
+	/* If range (-) does not follow immediately, require a space
+	 * In other words, the space here is optional, but only
+	 * in the ranged case, not in the single ibpkey case,
+	 * so do a custom test
+	 */
+	if (*info->ptr && *info->ptr != '-') {
+		if (parse_assert_space(handle, info) < 0)
+			goto err;
+	}
+
+	if (parse_optional_ch(info, '-') != STATUS_NODATA) {
+		if (parse_skip_space(handle, info) < 0)
+			goto err;
+		if (parse_fetch_int(handle, info, &high, ' ') < 0)
+			goto err;
+		if (parse_assert_space(handle, info) < 0)
+			goto err;
+		semanage_ibpkey_set_range(ibpkey, low, high);
+	} else {
+		semanage_ibpkey_set_pkey(ibpkey, low);
+	}
+	/* Pkey context */
+	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+		goto err;
+	if (semanage_context_from_string(handle, str, &con) < 0) {
+		ERR(handle, "invalid security context \"%s\" (%s: %u)\n%s",
+		    str, info->filename, info->lineno, info->orig_line);
+		goto err;
+	}
+	if (!con) {
+		ERR(handle, "<<none>> context is not valid for ibpkeys (%s: %u):\n%s",
+		    info->filename,
+		    info->lineno, info->orig_line);
+		goto err;
+	}
+	free(str);
+	str = NULL;
+
+	if (semanage_ibpkey_set_con(handle, ibpkey, con) < 0)
+		goto err;
+
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+
+	semanage_context_free(con);
+	return STATUS_SUCCESS;
+
+last:
+	parse_dispose_line(info);
+	return STATUS_NODATA;
+
+err:
+	ERR(handle, "could not parse ibpkey record");
+	free(str);
+	semanage_context_free(con);
+	parse_dispose_line(info);
+	return STATUS_ERR;
+}
+
+/* IBPKEY RECORD: FILE extension: method table */
+record_file_table_t SEMANAGE_IBPKEY_FILE_RTABLE = {
+	.parse = ibpkey_parse,
+	.print = ibpkey_print,
+};
+
+int ibpkey_file_dbase_init(semanage_handle_t *handle,
+			   const char *path_ro,
+			   const char *path_rw,
+			   dbase_config_t *dconfig)
+{
+	if (dbase_file_init(handle,
+			    path_ro,
+			    path_rw,
+			    &SEMANAGE_IBPKEY_RTABLE,
+			    &SEMANAGE_IBPKEY_FILE_RTABLE, &dconfig->dbase) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_FILE_DTABLE;
+	return STATUS_SUCCESS;
+}
+
+void ibpkey_file_dbase_release(dbase_config_t *dconfig)
+{
+	dbase_file_release(dconfig->dbase);
+}
diff --git a/libsemanage/src/ibpkeys_local.c b/libsemanage/src/ibpkeys_local.c
new file mode 100644
index 0000000..82d771e
--- /dev/null
+++ b/libsemanage/src/ibpkeys_local.c
@@ -0,0 +1,178 @@
+/* Copyright (C) 2017 Mellanox Technologies Inc. */
+
+struct semanage_ibpkey;
+struct semanage_ibpkey_key;
+typedef struct semanage_ibpkey_key record_key_t;
+typedef struct semanage_ibpkey record_t;
+#define DBASE_RECORD_DEFINED
+
+#include <stdlib.h>
+#include <string.h>
+#include "ibpkey_internal.h"
+#include "debug.h"
+#include "handle.h"
+#include "database.h"
+
+int semanage_ibpkey_modify_local(semanage_handle_t *handle,
+				 const semanage_ibpkey_key_t *key,
+				 const semanage_ibpkey_t *data)
+{
+	dbase_config_t *dconfig = semanage_ibpkey_dbase_local(handle);
+
+	return dbase_modify(handle, dconfig, key, data);
+}
+
+int semanage_ibpkey_del_local(semanage_handle_t *handle,
+			      const semanage_ibpkey_key_t *key)
+{
+	dbase_config_t *dconfig = semanage_ibpkey_dbase_local(handle);
+
+	return dbase_del(handle, dconfig, key);
+}
+
+int semanage_ibpkey_query_local(semanage_handle_t *handle,
+				const semanage_ibpkey_key_t *key,
+				semanage_ibpkey_t **response)
+{
+	dbase_config_t *dconfig = semanage_ibpkey_dbase_local(handle);
+
+	return dbase_query(handle, dconfig, key, response);
+}
+
+int semanage_ibpkey_exists_local(semanage_handle_t *handle,
+				 const semanage_ibpkey_key_t *key,
+				 int *response)
+{
+	dbase_config_t *dconfig = semanage_ibpkey_dbase_local(handle);
+
+	return dbase_exists(handle, dconfig, key, response);
+}
+
+int semanage_ibpkey_count_local(semanage_handle_t *handle,
+				unsigned int *response)
+{
+	dbase_config_t *dconfig = semanage_ibpkey_dbase_local(handle);
+
+	return dbase_count(handle, dconfig, response);
+}
+
+int semanage_ibpkey_iterate_local(semanage_handle_t *handle,
+				  int (*handler)(const semanage_ibpkey_t *record,
+						 void *varg), void *handler_arg)
+{
+	dbase_config_t *dconfig = semanage_ibpkey_dbase_local(handle);
+
+	return dbase_iterate(handle, dconfig, handler, handler_arg);
+}
+
+int semanage_ibpkey_list_local(semanage_handle_t *handle,
+			       semanage_ibpkey_t ***records, unsigned int *count)
+{
+	dbase_config_t *dconfig = semanage_ibpkey_dbase_local(handle);
+
+	return dbase_list(handle, dconfig, records, count);
+}
+
+hidden_def(semanage_ibpkey_list_local)
+
+int hidden semanage_ibpkey_validate_local(semanage_handle_t *handle)
+{
+	semanage_ibpkey_t **ibpkeys = NULL;
+	unsigned int nibpkeys = 0;
+	unsigned int i = 0, j = 0;
+	char *subnet_prefix;
+	char *subnet_prefix2;
+	char *subnet_prefix_str;
+	char *subnet_prefix_str2;
+	int low, high;
+	int low2, high2;
+
+	/* List and sort the ibpkeys */
+	if (semanage_ibpkey_list_local(handle, &ibpkeys, &nibpkeys) < 0)
+		goto err;
+
+	qsort(ibpkeys, nibpkeys, sizeof(semanage_ibpkey_t *),
+	      (int (*)(const void *, const void *))
+	      &semanage_ibpkey_compare2_qsort);
+
+	/* Test each ibpkey for overlap */
+	while (i < nibpkeys) {
+		int stop = 0;
+
+		if (STATUS_SUCCESS !=
+				semanage_ibpkey_get_subnet_prefix_bytes(handle,
+								      ibpkeys[i],
+								      &subnet_prefix)) {
+			ERR(handle, "Couldn't get subnet prefix");
+			goto err;
+		}
+		if (STATUS_SUCCESS != semanage_ibpkey_get_subnet_prefix(handle,
+									ibpkeys[i],
+									&subnet_prefix_str)) {
+			ERR(handle, "Couldn't get subnet prefix string");
+			goto err;
+		}
+
+		low = semanage_ibpkey_get_low(ibpkeys[i]);
+		high = semanage_ibpkey_get_high(ibpkeys[i]);
+
+		/* Find the first ibpkey with matching
+		 * subnet_prefix to compare against
+		 */
+		do {
+			if (j == nibpkeys - 1)
+				goto next;
+			j++;
+			if (STATUS_SUCCESS !=
+				semanage_ibpkey_get_subnet_prefix_bytes(handle,
+									ibpkeys[j],
+									&subnet_prefix2)) {
+				ERR(handle, "Couldn't get subnet prefix");
+				goto err;
+			}
+			if (STATUS_SUCCESS !=
+				semanage_ibpkey_get_subnet_prefix(handle,
+								ibpkeys[j],
+								&subnet_prefix_str2)) {
+				ERR(handle, "Couldn't get subnet prefix string");
+				goto err;
+			}
+			low2 = semanage_ibpkey_get_low(ibpkeys[j]);
+			high2 = semanage_ibpkey_get_high(ibpkeys[j]);
+
+			stop = !memcmp(subnet_prefix, subnet_prefix2, INET6_ADDRLEN);
+		} while (!stop);
+
+		/* Overlap detected */
+		if (low2 <= high) {
+			ERR(handle, "ibpkey overlap between ranges "
+			    "(%s) %u - %u <--> (%s) %u - %u.",
+			    subnet_prefix_str, low, high,
+			    subnet_prefix_str2, low2, high2);
+			goto invalid;
+		}
+
+		/* If closest ibpkey of matching subnet prefix doesn't overlap
+		 * with test ibpkey, neither do the rest of them, because that's
+		 * how the sort function works on ibpkeys - lower bound
+		 * ibpkeys come first
+		 */
+next:
+		i++;
+		j = i;
+	}
+
+	for (i = 0; i < nibpkeys; i++)
+		semanage_ibpkey_free(ibpkeys[i]);
+	free(ibpkeys);
+	return STATUS_SUCCESS;
+
+err:
+	ERR(handle, "could not complete ibpkeys validity check");
+
+invalid:
+	for (i = 0; i < nibpkeys; i++)
+		semanage_ibpkey_free(ibpkeys[i]);
+	free(ibpkeys);
+	return STATUS_ERR;
+}
diff --git a/libsemanage/src/ibpkeys_policy.c b/libsemanage/src/ibpkeys_policy.c
new file mode 100644
index 0000000..0956230
--- /dev/null
+++ b/libsemanage/src/ibpkeys_policy.c
@@ -0,0 +1,52 @@
+/* Copyright (C) 2017 Mellanox Technologies Inc. */
+
+struct semanage_ibpkey;
+struct semanage_ibpkey_key;
+typedef struct semanage_ibpkey_key record_key_t;
+typedef struct semanage_ibpkey record_t;
+#define DBASE_RECORD_DEFINED
+
+#include "ibpkey_internal.h"
+#include "handle.h"
+#include "database.h"
+
+int semanage_ibpkey_query(semanage_handle_t *handle,
+			  const semanage_ibpkey_key_t *key,
+			  semanage_ibpkey_t **response)
+{
+	dbase_config_t *dconfig = semanage_ibpkey_dbase_policy(handle);
+
+	return dbase_query(handle, dconfig, key, response);
+}
+
+int semanage_ibpkey_exists(semanage_handle_t *handle,
+			   const semanage_ibpkey_key_t *key, int *response)
+{
+	dbase_config_t *dconfig = semanage_ibpkey_dbase_policy(handle);
+
+	return dbase_exists(handle, dconfig, key, response);
+}
+
+int semanage_ibpkey_count(semanage_handle_t *handle, unsigned int *response)
+{
+	dbase_config_t *dconfig = semanage_ibpkey_dbase_policy(handle);
+
+	return dbase_count(handle, dconfig, response);
+}
+
+int semanage_ibpkey_iterate(semanage_handle_t *handle,
+			    int (*handler)(const semanage_ibpkey_t *record,
+					   void *varg), void *handler_arg)
+{
+	dbase_config_t *dconfig = semanage_ibpkey_dbase_policy(handle);
+
+	return dbase_iterate(handle, dconfig, handler, handler_arg);
+}
+
+int semanage_ibpkey_list(semanage_handle_t *handle,
+			 semanage_ibpkey_t ***records, unsigned int *count)
+{
+	dbase_config_t *dconfig = semanage_ibpkey_dbase_policy(handle);
+
+	return dbase_list(handle, dconfig, records, count);
+}
diff --git a/libsemanage/src/ibpkeys_policydb.c b/libsemanage/src/ibpkeys_policydb.c
new file mode 100644
index 0000000..8d73cf6
--- /dev/null
+++ b/libsemanage/src/ibpkeys_policydb.c
@@ -0,0 +1,62 @@
+/*
+ * Copyright (C) 2017 Mellanox Technologies Inc
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ */
+
+struct semanage_ibpkey;
+struct semanage_ibpkey_key;
+typedef struct semanage_ibpkey record_t;
+typedef struct semanage_ibpkey_key record_key_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_policydb;
+typedef struct dbase_policydb dbase_t;
+#define DBASE_DEFINED
+
+#include <sepol/ibpkeys.h>
+#include <semanage/handle.h>
+#include "ibpkey_internal.h"
+#include "debug.h"
+#include "database_policydb.h"
+#include "semanage_store.h"
+
+/* PKEY RECORD (SEPOL): POLICYDB extension : method table */
+record_policydb_table_t SEMANAGE_IBPKEY_POLICYDB_RTABLE = {
+	.add = NULL,
+	.modify = (record_policydb_table_modify_t)sepol_ibpkey_modify,
+	.set = NULL,
+	.query = (record_policydb_table_query_t)sepol_ibpkey_query,
+	.count = (record_policydb_table_count_t)sepol_ibpkey_count,
+	.exists = (record_policydb_table_exists_t)sepol_ibpkey_exists,
+	.iterate = (record_policydb_table_iterate_t)sepol_ibpkey_iterate,
+};
+
+int ibpkey_policydb_dbase_init(semanage_handle_t *handle,
+			       dbase_config_t *dconfig)
+{
+	if (dbase_policydb_init(handle,
+				semanage_path(SEMANAGE_ACTIVE, SEMANAGE_STORE_KERNEL),
+				semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_KERNEL),
+				&SEMANAGE_IBPKEY_RTABLE,
+				&SEMANAGE_IBPKEY_POLICYDB_RTABLE,
+				&dconfig->dbase) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_POLICYDB_DTABLE;
+
+	return STATUS_SUCCESS;
+}
+
+void ibpkey_policydb_dbase_release(dbase_config_t *dconfig)
+{
+	dbase_policydb_release(dconfig->dbase);
+}
diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
index 9f8a754..041b1ce 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -18,6 +18,7 @@ LIBSEMANAGE_1.0 {
 	  semanage_root;
 	  semanage_user_*; semanage_bool_*; semanage_seuser_*;
 	  semanage_iface_*; semanage_port_*; semanage_context_*;
+	  semanage_ibpkey_*;
 	  semanage_node_*;
 	  semanage_fcontext_*; semanage_access_check; semanage_set_create_store;
 	  semanage_is_connected; semanage_get_disable_dontaudit; semanage_set_disable_dontaudit;
diff --git a/libsemanage/src/policy_components.c b/libsemanage/src/policy_components.c
index d31bd48..136c5a7 100644
--- a/libsemanage/src/policy_components.c
+++ b/libsemanage/src/policy_components.c
@@ -137,12 +137,14 @@ int semanage_base_merge_components(semanage_handle_t * handle)
 
 		{semanage_node_dbase_local(handle),
 		 semanage_node_dbase_policy(handle), MODE_MODIFY | MODE_SORT},
+
+		{semanage_ibpkey_dbase_local(handle),
+		 semanage_ibpkey_dbase_policy(handle), MODE_MODIFY},
 	};
 	const unsigned int CCOUNT = sizeof(components) / sizeof(components[0]);
 
 	/* Merge components into policy (and validate) */
 	for (i = 0; i < CCOUNT; i++) {
-
 		record_t **records = NULL;
 		unsigned int nrecords = 0;
 
@@ -218,6 +220,7 @@ int semanage_commit_components(semanage_handle_t * handle)
 		semanage_seuser_dbase_policy(handle),
 		semanage_bool_dbase_active(handle),
 		semanage_node_dbase_local(handle),
+		semanage_ibpkey_dbase_local(handle),
 	};
 	const int CCOUNT = sizeof(components) / sizeof(components[0]);
 
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 6b75002..f61f3b2 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -99,6 +99,7 @@ static const char *semanage_sandbox_paths[SEMANAGE_STORE_NUM_PATHS] = {
 	"/homedir_template",
 	"/file_contexts.template",
 	"/commit_num",
+	"/pkeys.local",
 	"/ports.local",
 	"/interfaces.local",
 	"/nodes.local",
diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
index 0b96fbe..c7bcf44 100644
--- a/libsemanage/src/semanage_store.h
+++ b/libsemanage/src/semanage_store.h
@@ -44,6 +44,7 @@ enum semanage_sandbox_defs {
 	SEMANAGE_HOMEDIR_TMPL,
 	SEMANAGE_FC_TMPL,
 	SEMANAGE_COMMIT_NUM_FILE,
+	SEMANAGE_IBPKEYS_LOCAL,
 	SEMANAGE_PORTS_LOCAL,
 	SEMANAGE_INTERFACES_LOCAL,
 	SEMANAGE_NODES_LOCAL,
diff --git a/libsemanage/src/semanageswig.i b/libsemanage/src/semanageswig.i
index 583b7d8..d3ca795 100644
--- a/libsemanage/src/semanageswig.i
+++ b/libsemanage/src/semanageswig.i
@@ -39,6 +39,9 @@
 %include "../include/semanage/port_record.h"
 %include "../include/semanage/ports_local.h"
 %include "../include/semanage/ports_policy.h"
+%include "../include/semanage/ibpkey_record.h"
+%include "../include/semanage/ibpkeys_local.h"
+%include "../include/semanage/ibpkeys_policy.h"
 %include "../include/semanage/fcontext_record.h"
 %include "../include/semanage/fcontexts_local.h"
 %include "../include/semanage/fcontexts_policy.h"
diff --git a/libsemanage/src/semanageswig_python.i b/libsemanage/src/semanageswig_python.i
index 1346b2e..40932d8 100644
--- a/libsemanage/src/semanageswig_python.i
+++ b/libsemanage/src/semanageswig_python.i
@@ -437,6 +437,49 @@
 	$1 = &temp;
 }
 
+/** ibpkey typemaps **/
+
+/* the wrapper will setup this parameter for passing... the resulting python functions
+   will not take the semanage_ibpkey_t *** parameter */
+%typemap(in, numinputs=0) semanage_ibpkey_t ***(semanage_ibpkey_t **temp=NULL) {
+	$1 = &temp;
+}
+
+%typemap(argout) (
+	semanage_handle_t* handle,
+	semanage_ibpkey_t*** records,
+	unsigned int* count) {
+
+	if ($result) {
+		int value;
+		SWIG_AsVal_int($result, &value);
+		if (value >= 0) {
+			PyObject* plist = NULL;
+			if (semanage_array2plist($1, (void**) *$2, *$3, SWIGTYPE_p_semanage_ibpkey,
+				(void (*) (void*)) &semanage_ibpkey_free, &plist) < 0)
+				$result = SWIG_From_int(STATUS_ERR);
+			else
+				$result = SWIG_Python_AppendOutput($result, plist);
+		}
+	}
+}
+
+%typemap(in, numinputs=0) semanage_ibpkey_t **(semanage_ibpkey_t *temp=NULL) {
+	$1 = &temp;
+}
+
+%typemap(argout) semanage_ibpkey_t ** {
+	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+}
+
+%typemap(argout) semanage_ibpkey_key_t ** {
+	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+}
+
+%typemap(in, numinputs=0) semanage_ibpkey_key_t **(semanage_ibpkey_key_t *temp=NULL) {
+	$1 = &temp;
+}
+
 /** node typemaps **/
 
 /* the wrapper will setup this parameter for passing... the resulting python functions
diff --git a/libsemanage/utils/semanage_migrate_store b/libsemanage/utils/semanage_migrate_store
index 0ebd285..325de47 100755
--- a/libsemanage/utils/semanage_migrate_store
+++ b/libsemanage/utils/semanage_migrate_store
@@ -253,7 +253,8 @@ if __name__ == "__main__":
 		"preserve_tunables",
 		"policy.kern",
 		"file_contexts",
-		"homedir_template"]
+		"homedir_template",
+                "pkeys.local"]
 
 
 	create_dir(newroot_path(), 0o755)
diff --git a/libsepol/include/sepol/ibpkey_record.h b/libsepol/include/sepol/ibpkey_record.h
new file mode 100644
index 0000000..fff4591
--- /dev/null
+++ b/libsepol/include/sepol/ibpkey_record.h
@@ -0,0 +1,77 @@
+#ifndef _SEPOL_IBPKEY_RECORD_H_
+#define _SEPOL_IBPKEY_RECORD_H_
+
+#include <stddef.h>
+#include <sepol/context_record.h>
+#include <sepol/handle.h>
+#include <sys/cdefs.h>
+
+#define INET6_ADDRLEN 16
+
+__BEGIN_DECLS
+
+struct sepol_ibpkey;
+struct sepol_ibpkey_key;
+typedef struct sepol_ibpkey sepol_ibpkey_t;
+typedef struct sepol_ibpkey_key sepol_ibpkey_key_t;
+
+extern int sepol_ibpkey_compare(const sepol_ibpkey_t *ibpkey,
+				const sepol_ibpkey_key_t *key);
+
+extern int sepol_ibpkey_compare2(const sepol_ibpkey_t *ibpkey,
+				 const sepol_ibpkey_t *ibpkey2);
+
+extern int sepol_ibpkey_key_create(sepol_handle_t *handle,
+				   const char *subnet_prefix,
+				   int low, int high,
+				   sepol_ibpkey_key_t **key_ptr);
+
+extern void sepol_ibpkey_key_unpack(const sepol_ibpkey_key_t *key,
+				    const char **subnet_prefix,
+				    int *low, int *high);
+
+extern int sepol_ibpkey_key_extract(sepol_handle_t *handle,
+				    const sepol_ibpkey_t *ibpkey,
+				    sepol_ibpkey_key_t **key_ptr);
+
+extern void sepol_ibpkey_key_free(sepol_ibpkey_key_t *key);
+
+extern int sepol_ibpkey_get_low(const sepol_ibpkey_t *ibpkey);
+
+extern int sepol_ibpkey_get_high(const sepol_ibpkey_t *ibpkey);
+
+extern void sepol_ibpkey_set_pkey(sepol_ibpkey_t *ibpkey, int pkey_num);
+
+extern void sepol_ibpkey_set_range(sepol_ibpkey_t *ibpkey, int low, int high);
+
+extern int sepol_ibpkey_get_subnet_prefix(sepol_handle_t *handle,
+					  const sepol_ibpkey_t *ibpkey,
+					  char **subnet_prefix);
+
+extern int sepol_ibpkey_get_subnet_prefix_bytes(sepol_handle_t *handle,
+						const sepol_ibpkey_t *ibpkey,
+						char **buffer);
+
+extern int sepol_ibpkey_set_subnet_prefix(sepol_handle_t *handle,
+					  sepol_ibpkey_t *ibpkey,
+					  const char *subnet_prefix);
+
+extern int sepol_ibpkey_set_subnet_prefix_bytes(sepol_handle_t *handle,
+						sepol_ibpkey_t *ibpkey,
+						const char *subnet_prefix);
+
+extern sepol_context_t *sepol_ibpkey_get_con(const sepol_ibpkey_t *ibpkey);
+
+extern int sepol_ibpkey_set_con(sepol_handle_t *handle,
+				sepol_ibpkey_t *ibpkey, sepol_context_t *con);
+
+extern int sepol_ibpkey_create(sepol_handle_t *handle, sepol_ibpkey_t **ibpkey_ptr);
+
+extern int sepol_ibpkey_clone(sepol_handle_t *handle,
+			      const sepol_ibpkey_t *ibpkey,
+			      sepol_ibpkey_t **ibpkey_ptr);
+
+extern void sepol_ibpkey_free(sepol_ibpkey_t *ibpkey);
+
+__END_DECLS
+#endif
diff --git a/libsepol/include/sepol/ibpkeys.h b/libsepol/include/sepol/ibpkeys.h
new file mode 100644
index 0000000..4ab0a8a
--- /dev/null
+++ b/libsepol/include/sepol/ibpkeys.h
@@ -0,0 +1,44 @@
+#ifndef _SEPOL_IBPKEYS_H_
+#define _SEPOL_IBPKEYS_H_
+
+#include <sepol/handle.h>
+#include <sepol/policydb.h>
+#include <sepol/ibpkey_record.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
+
+/* Return the number of ibpkeys */
+extern int sepol_ibpkey_count(sepol_handle_t *handle,
+			      const sepol_policydb_t *p, unsigned int *response);
+
+/* Check if a ibpkey exists */
+extern int sepol_ibpkey_exists(sepol_handle_t *handle,
+			       const sepol_policydb_t *policydb,
+			       const sepol_ibpkey_key_t *key, int *response);
+
+/* Query a ibpkey - returns the ibpkey, or NULL if not found */
+extern int sepol_ibpkey_query(sepol_handle_t *handle,
+			      const sepol_policydb_t *policydb,
+			      const sepol_ibpkey_key_t *key,
+			      sepol_ibpkey_t **response);
+
+/* Modify a ibpkey, or add it, if the key is not found */
+extern int sepol_ibpkey_modify(sepol_handle_t *handle,
+			       sepol_policydb_t *policydb,
+			       const sepol_ibpkey_key_t *key,
+			       const sepol_ibpkey_t *data);
+
+/* Iterate the ibpkeys
+ * The handler may return:
+ * -1 to signal an error condition,
+ * 1 to signal successful exit
+ * 0 to signal continue
+ */
+extern int sepol_ibpkey_iterate(sepol_handle_t *handle,
+				const sepol_policydb_t *policydb,
+				int (*fn)(const sepol_ibpkey_t *ibpkey,
+					  void *fn_arg), void *arg);
+
+__END_DECLS
+#endif
diff --git a/libsepol/include/sepol/sepol.h b/libsepol/include/sepol/sepol.h
index 513f77d..540f01d 100644
--- a/libsepol/include/sepol/sepol.h
+++ b/libsepol/include/sepol/sepol.h
@@ -11,12 +11,14 @@ extern "C" {
 #include <sepol/user_record.h>
 #include <sepol/context_record.h>
 #include <sepol/iface_record.h>
+#include <sepol/ibpkey_record.h>
 #include <sepol/port_record.h>
 #include <sepol/boolean_record.h>
 #include <sepol/node_record.h>
 
 #include <sepol/booleans.h>
 #include <sepol/interfaces.h>
+#include <sepol/ibpkeys.h>
 #include <sepol/ports.h>
 #include <sepol/nodes.h>
 #include <sepol/users.h>
diff --git a/libsepol/src/ibpkey_internal.h b/libsepol/src/ibpkey_internal.h
new file mode 100644
index 0000000..addf80a
--- /dev/null
+++ b/libsepol/src/ibpkey_internal.h
@@ -0,0 +1,21 @@
+#ifndef _SEPOL_IBPKEY_INTERNAL_H_
+#define _SEPOL_IBPKEY_INTERNAL_H_
+
+#include <sepol/ibpkey_record.h>
+#include <sepol/ibpkeys.h>
+#include "dso.h"
+
+hidden_proto(sepol_ibpkey_create)
+hidden_proto(sepol_ibpkey_free)
+hidden_proto(sepol_ibpkey_get_con)
+hidden_proto(sepol_ibpkey_get_high)
+hidden_proto(sepol_ibpkey_get_low)
+hidden_proto(sepol_ibpkey_key_create)
+hidden_proto(sepol_ibpkey_key_unpack)
+hidden_proto(sepol_ibpkey_set_con)
+hidden_proto(sepol_ibpkey_set_range)
+hidden_proto(sepol_ibpkey_get_subnet_prefix)
+hidden_proto(sepol_ibpkey_get_subnet_prefix_bytes)
+hidden_proto(sepol_ibpkey_set_subnet_prefix)
+hidden_proto(sepol_ibpkey_set_subnet_prefix_bytes)
+#endif
diff --git a/libsepol/src/ibpkey_record.c b/libsepol/src/ibpkey_record.c
new file mode 100644
index 0000000..4eed083
--- /dev/null
+++ b/libsepol/src/ibpkey_record.c
@@ -0,0 +1,448 @@
+#include <stdlib.h>
+#include <string.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include <errno.h>
+#include <sepol/ibpkey_record.h>
+
+#include "ibpkey_internal.h"
+#include "context_internal.h"
+#include "debug.h"
+
+struct sepol_ibpkey {
+	/* Subnet prefix */
+	char *subnet_prefix;
+
+	/* Low - High range. Same for single ibpkeys. */
+	int low, high;
+
+	/* Context */
+	sepol_context_t *con;
+};
+
+struct sepol_ibpkey_key {
+	/* Subnet prefix */
+	char *subnet_prefix;
+
+	/* Low - High range. Same for single ibpkeys. */
+	int low, high;
+};
+
+/* Converts a string represtation (subnet_prefix_str)
+ * to a numeric representation (subnet_prefix_bytes)
+ */
+static int ibpkey_parse_subnet_prefix(sepol_handle_t *handle,
+				      const char *subnet_prefix_str,
+				      char *subnet_prefix_bytes)
+{
+	struct in6_addr in_addr;
+
+	if (inet_pton(AF_INET6, subnet_prefix_str, &in_addr) <= 0) {
+		ERR(handle, "could not parse IPv6 address for ibpkey subnet prefix %s: %s",
+		    subnet_prefix_str, strerror(errno));
+		return STATUS_ERR;
+	}
+
+	memcpy(subnet_prefix_bytes, in_addr.s6_addr, INET6_ADDRLEN);
+
+	return STATUS_SUCCESS;
+}
+
+static int ibpkey_alloc_subnet_prefix(sepol_handle_t *handle,
+				      char **subnet_prefix)
+{
+	char *tmp_subnet_prefix = malloc(INET6_ADDRLEN);
+
+	if (!tmp_subnet_prefix)
+		goto omem;
+
+	*subnet_prefix = tmp_subnet_prefix;
+	return STATUS_SUCCESS;
+
+omem:
+	ERR(handle, "out of memory");
+	return STATUS_ERR;
+}
+
+/* Converts a numeric representation (subnet_prefix_bytes)
+ * to a string representation (subnet_prefix_str)
+ */
+
+static int ibpkey_expand_subnet_prefix(sepol_handle_t *handle,
+				       char *subnet_prefix_bytes,
+				       char *subnet_prefix_str)
+{
+	struct in6_addr addr;
+
+	memset(&addr, 0, sizeof(struct in6_addr));
+#ifdef DARWIN
+	memcpy(&addr.s6_addr[0], subnet_prefix_bytes, 16);
+#else
+	memcpy(&addr.s6_addr32[0], subnet_prefix_bytes, 16);
+#endif
+	if (inet_ntop(AF_INET6, &addr, subnet_prefix_str,
+		      INET6_ADDRSTRLEN) == NULL) {
+		ERR(handle,
+		    "could not expand IPv6 address to string: %s",
+		    strerror(errno));
+		return STATUS_ERR;
+	}
+
+	return STATUS_SUCCESS;
+}
+
+/* Allocates a sufficiently large string (subnet_prefix)
+ * for an IPV6 address for the subnet prefix
+ */
+static int ibpkey_alloc_subnet_prefix_string(sepol_handle_t *handle,
+					     char **subnet_prefix)
+{
+	char *tmp_subnet_prefix = NULL;
+
+	tmp_subnet_prefix = malloc(INET6_ADDRSTRLEN);
+
+	if (!tmp_subnet_prefix)
+		goto omem;
+
+	*subnet_prefix = tmp_subnet_prefix;
+	return STATUS_SUCCESS;
+
+omem:
+	ERR(handle, "out of memory");
+
+	ERR(handle, "could not allocate string buffer for subnet_prefix");
+	return STATUS_ERR;
+}
+
+/* Key */
+int sepol_ibpkey_key_create(sepol_handle_t *handle,
+			    const char *subnet_prefix,
+			    int low, int high,
+			    sepol_ibpkey_key_t **key_ptr)
+{
+	sepol_ibpkey_key_t *tmp_key =
+	    (sepol_ibpkey_key_t *)malloc(sizeof(sepol_ibpkey_key_t));
+
+	if (!tmp_key) {
+		ERR(handle, "out of memory, could not create ibpkey key");
+		goto omem;
+	}
+
+	if (ibpkey_alloc_subnet_prefix(handle, &tmp_key->subnet_prefix) < 0)
+		goto err;
+	if (ibpkey_parse_subnet_prefix(handle, subnet_prefix, tmp_key->subnet_prefix) < 0)
+		goto err;
+
+	tmp_key->low = low;
+	tmp_key->high = high;
+
+	*key_ptr = tmp_key;
+	return STATUS_SUCCESS;
+
+omem:
+	ERR(handle, "out of memory");
+
+err:
+	sepol_ibpkey_key_free(tmp_key);
+	ERR(handle, "could not create ibpkey key for subnet prefix%s, range %u, %u",
+	    subnet_prefix, low, high);
+	return STATUS_ERR;
+}
+
+hidden_def(sepol_ibpkey_key_create)
+
+void sepol_ibpkey_key_unpack(const sepol_ibpkey_key_t *key,
+			     const char **subnet_prefix, int *low, int *high)
+{
+	*subnet_prefix = key->subnet_prefix;
+	*low = key->low;
+	*high = key->high;
+}
+
+hidden_def(sepol_ibpkey_key_unpack)
+
+int sepol_ibpkey_key_extract(sepol_handle_t *handle,
+			     const sepol_ibpkey_t *ibpkey,
+			     sepol_ibpkey_key_t **key_ptr)
+{
+	char subnet_prefix_str[INET6_ADDRSTRLEN];
+
+	ibpkey_expand_subnet_prefix(handle, ibpkey->subnet_prefix, subnet_prefix_str);
+
+	if (sepol_ibpkey_key_create
+	    (handle, subnet_prefix_str, ibpkey->low, ibpkey->high, key_ptr) < 0) {
+		ERR(handle, "could not extract key from ibpkey %s %d:%d",
+		    subnet_prefix_str,
+		    ibpkey->low, ibpkey->high);
+
+		return STATUS_ERR;
+	}
+
+	return STATUS_SUCCESS;
+}
+
+void sepol_ibpkey_key_free(sepol_ibpkey_key_t *key)
+{
+	if (!key)
+		return;
+	free(key->subnet_prefix);
+	free(key);
+}
+
+int sepol_ibpkey_compare(const sepol_ibpkey_t *ibpkey, const sepol_ibpkey_key_t *key)
+{
+	int rc;
+
+	rc = memcmp(ibpkey->subnet_prefix, key->subnet_prefix, INET6_ADDRLEN);
+
+	if (ibpkey->low == key->low &&
+	    ibpkey->high == key->high &&
+	    !rc)
+		return 0;
+
+	if (ibpkey->low < key->low)
+		return -1;
+
+	else if (key->low < ibpkey->low)
+		return 1;
+
+	else if (ibpkey->high < key->high)
+		return -1;
+
+	else if (key->high < ibpkey->high)
+		return 1;
+	else
+		return rc;
+}
+
+int sepol_ibpkey_compare2(const sepol_ibpkey_t *ibpkey, const sepol_ibpkey_t *ibpkey2)
+{
+	int rc;
+
+	rc = memcmp(ibpkey->subnet_prefix, ibpkey2->subnet_prefix, INET6_ADDRLEN);
+
+	if (ibpkey->low == ibpkey2->low &&
+	    ibpkey->high == ibpkey2->high &&
+	    !rc)
+		return 0;
+
+	if (ibpkey->low < ibpkey2->low)
+		return -1;
+
+	else if (ibpkey2->low < ibpkey->low)
+		return 1;
+
+	else if (ibpkey->high < ibpkey2->high)
+		return -1;
+
+	else if (ibpkey2->high < ibpkey->high)
+		return 1;
+	else
+		return rc;
+}
+
+/* Pkey */
+int sepol_ibpkey_get_low(const sepol_ibpkey_t *ibpkey)
+{
+	return ibpkey->low;
+}
+
+hidden_def(sepol_ibpkey_get_low)
+
+int sepol_ibpkey_get_high(const sepol_ibpkey_t *ibpkey)
+{
+	return ibpkey->high;
+}
+
+hidden_def(sepol_ibpkey_get_high)
+
+void sepol_ibpkey_set_pkey(sepol_ibpkey_t *ibpkey, int pkey_num)
+{
+	ibpkey->low = pkey_num;
+	ibpkey->high = pkey_num;
+}
+
+void sepol_ibpkey_set_range(sepol_ibpkey_t *ibpkey, int low, int high)
+{
+	ibpkey->low = low;
+	ibpkey->high = high;
+}
+
+hidden_def(sepol_ibpkey_set_range)
+
+int sepol_ibpkey_get_subnet_prefix(sepol_handle_t *handle,
+				   const sepol_ibpkey_t *ibpkey,
+				   char **subnet_prefix)
+{
+	char *tmp_subnet_prefix = NULL;
+
+	if (ibpkey_alloc_subnet_prefix_string(handle, &tmp_subnet_prefix) < 0)
+		goto err;
+
+	if (ibpkey_expand_subnet_prefix(handle, ibpkey->subnet_prefix, tmp_subnet_prefix) < 0)
+		goto err;
+
+	*subnet_prefix = tmp_subnet_prefix;
+	return STATUS_SUCCESS;
+
+err:
+	free(tmp_subnet_prefix);
+	ERR(handle, "could not get ibpkey subnet_prefix");
+	return STATUS_ERR;
+}
+
+hidden_def(sepol_ibpkey_get_subnet_prefix)
+
+/* Subnet prefix */
+int sepol_ibpkey_get_subnet_prefix_bytes(sepol_handle_t *handle,
+					 const sepol_ibpkey_t *ibpkey,
+					 char **buffer)
+{
+	char *tmp_buf = malloc(INET6_ADDRLEN);
+
+	if (!tmp_buf) {
+		ERR(handle, "out of memory, could not get subnet prefix bytes");
+		return STATUS_ERR;
+	}
+
+	memcpy(tmp_buf, ibpkey->subnet_prefix, INET6_ADDRLEN);
+	*buffer = tmp_buf;
+	return STATUS_SUCCESS;
+}
+
+hidden_def(sepol_ibpkey_get_subnet_prefix_bytes)
+
+int sepol_ibpkey_set_subnet_prefix(sepol_handle_t *handle,
+				   sepol_ibpkey_t *ibpkey,
+				   const char *subnet_prefix)
+{
+	char *tmp = NULL;
+
+	if (ibpkey_alloc_subnet_prefix(handle, &tmp) < 0)
+		goto err;
+
+	if (ibpkey_parse_subnet_prefix(handle, subnet_prefix, tmp) < 0)
+		goto err;
+
+	free(ibpkey->subnet_prefix);
+	ibpkey->subnet_prefix = tmp;
+	return STATUS_SUCCESS;
+
+err:
+	free(tmp);
+	ERR(handle, "could not set ibpkey subnet prefix to %s", subnet_prefix);
+	return STATUS_ERR;
+}
+
+hidden_def(sepol_ibpkey_set_subnet_prefix)
+
+int sepol_ibpkey_set_subnet_prefix_bytes(sepol_handle_t *handle,
+					 sepol_ibpkey_t *ibpkey,
+					 const char *subnet_prefix)
+{
+	char *tmp_subnet_prefix = malloc(INET6_ADDRLEN);
+
+	if (!tmp_subnet_prefix) {
+		ERR(handle, "out of memory, could not set ibpkey subnet prefix");
+		return STATUS_ERR;
+	}
+
+	memcpy(tmp_subnet_prefix, subnet_prefix, INET6_ADDRLEN);
+	free(ibpkey->subnet_prefix);
+	ibpkey->subnet_prefix = tmp_subnet_prefix;
+	return STATUS_SUCCESS;
+}
+
+hidden_def(sepol_ibpkey_set_subnet_prefix_bytes)
+
+/* Create */
+int sepol_ibpkey_create(sepol_handle_t *handle, sepol_ibpkey_t **ibpkey)
+{
+	sepol_ibpkey_t *tmp_ibpkey = (sepol_ibpkey_t *)malloc(sizeof(sepol_ibpkey_t));
+
+	if (!tmp_ibpkey) {
+		ERR(handle, "out of memory, could not create ibpkey record");
+		return STATUS_ERR;
+	}
+
+	tmp_ibpkey->subnet_prefix = NULL;
+	tmp_ibpkey->low = 0;
+	tmp_ibpkey->high = 0;
+	tmp_ibpkey->con = NULL;
+	*ibpkey = tmp_ibpkey;
+
+	return STATUS_SUCCESS;
+}
+
+hidden_def(sepol_ibpkey_create)
+
+/* Deep copy clone */
+int sepol_ibpkey_clone(sepol_handle_t *handle,
+		       const sepol_ibpkey_t *ibpkey, sepol_ibpkey_t **ibpkey_ptr)
+{
+	sepol_ibpkey_t *new_ibpkey = NULL;
+
+	if (sepol_ibpkey_create(handle, &new_ibpkey) < 0)
+		goto err;
+
+	new_ibpkey->subnet_prefix = malloc(INET6_ADDRLEN);
+	if (!new_ibpkey->subnet_prefix)
+		goto omem;
+
+	memcpy(new_ibpkey->subnet_prefix, ibpkey->subnet_prefix, INET6_ADDRLEN);
+	new_ibpkey->low = ibpkey->low;
+	new_ibpkey->high = ibpkey->high;
+
+	if (ibpkey->con &&
+	    (sepol_context_clone(handle, ibpkey->con, &new_ibpkey->con) < 0))
+		goto err;
+
+	*ibpkey_ptr = new_ibpkey;
+	return STATUS_SUCCESS;
+
+omem:
+	ERR(handle, "out of memory");
+
+err:
+	ERR(handle, "could not clone ibpkey record");
+	sepol_ibpkey_free(new_ibpkey);
+	return STATUS_ERR;
+}
+
+/* Destroy */
+void sepol_ibpkey_free(sepol_ibpkey_t *ibpkey)
+{
+	if (!ibpkey)
+		return;
+
+	free(ibpkey->subnet_prefix);
+	sepol_context_free(ibpkey->con);
+	free(ibpkey);
+}
+
+hidden_def(sepol_ibpkey_free)
+
+/* Context */
+sepol_context_t *sepol_ibpkey_get_con(const sepol_ibpkey_t *ibpkey)
+{
+	return ibpkey->con;
+}
+
+hidden_def(sepol_ibpkey_get_con)
+
+int sepol_ibpkey_set_con(sepol_handle_t *handle,
+			 sepol_ibpkey_t *ibpkey, sepol_context_t *con)
+{
+	sepol_context_t *newcon;
+
+	if (sepol_context_clone(handle, con, &newcon) < 0) {
+		ERR(handle, "out of memory, could not set ibpkey context");
+		return STATUS_ERR;
+	}
+
+	sepol_context_free(ibpkey->con);
+	ibpkey->con = newcon;
+	return STATUS_SUCCESS;
+}
+
+hidden_def(sepol_ibpkey_set_con)
diff --git a/libsepol/src/ibpkeys.c b/libsepol/src/ibpkeys.c
new file mode 100644
index 0000000..eb46954
--- /dev/null
+++ b/libsepol/src/ibpkeys.c
@@ -0,0 +1,263 @@
+#include <netinet/in.h>
+#include <stdlib.h>
+
+#include "debug.h"
+#include "context.h"
+#include "handle.h"
+
+#include <sepol/ibpkey_record.h>
+#include <sepol/policydb/policydb.h>
+#include "ibpkey_internal.h"
+
+/* Create a low level ibpkey structure from
+ * a high level representation
+ */
+static int ibpkey_from_record(sepol_handle_t *handle,
+			    const policydb_t *policydb,
+			    ocontext_t **ibpkey, const sepol_ibpkey_t *data)
+{
+	ocontext_t *tmp_ibpkey = NULL;
+	context_struct_t *tmp_con = NULL;
+	char *subnet_prefix_buf = NULL;
+	int low = sepol_ibpkey_get_low(data);
+	int high = sepol_ibpkey_get_high(data);
+
+	tmp_ibpkey = (ocontext_t *)calloc(1, sizeof(*tmp_ibpkey));
+	if (!tmp_ibpkey)
+		goto omem;
+
+	if (sepol_ibpkey_get_subnet_prefix_bytes(handle,
+					       data,
+					       &subnet_prefix_buf) < 0)
+		goto err;
+
+	memcpy(tmp_ibpkey->u.ibpkey.subnet_prefix, subnet_prefix_buf,
+	       INET6_ADDRLEN);
+
+	free(subnet_prefix_buf);
+	subnet_prefix_buf = NULL;
+
+	/* Pkey range */
+	tmp_ibpkey->u.ibpkey.low_pkey = low;
+	tmp_ibpkey->u.ibpkey.high_pkey = high;
+	if (tmp_ibpkey->u.ibpkey.low_pkey > tmp_ibpkey->u.ibpkey.high_pkey) {
+		ERR(handle, "low ibpkey %d exceeds high ibpkey %d",
+		    tmp_ibpkey->u.ibpkey.low_pkey, tmp_ibpkey->u.ibpkey.high_pkey);
+		goto err;
+	}
+
+	/* Context */
+	if (context_from_record(handle, policydb, &tmp_con,
+				sepol_ibpkey_get_con(data)) < 0)
+		goto err;
+	context_cpy(&tmp_ibpkey->context[0], tmp_con);
+	context_destroy(tmp_con);
+	free(tmp_con);
+	tmp_con = NULL;
+
+	*ibpkey = tmp_ibpkey;
+	return STATUS_SUCCESS;
+
+omem:
+	ERR(handle, "out of memory");
+
+err:
+	if (tmp_ibpkey) {
+		context_destroy(&tmp_ibpkey->context[0]);
+		free(tmp_ibpkey);
+	}
+	context_destroy(tmp_con);
+	free(tmp_con);
+	free(subnet_prefix_buf);
+	ERR(handle, "could not create ibpkey structure");
+	return STATUS_ERR;
+}
+
+static int ibpkey_to_record(sepol_handle_t *handle,
+			  const policydb_t *policydb,
+			  ocontext_t *ibpkey, sepol_ibpkey_t **record)
+{
+	int low = ibpkey->u.ibpkey.low_pkey;
+	int high = ibpkey->u.ibpkey.high_pkey;
+	context_struct_t *con = &ibpkey->context[0];
+
+	sepol_context_t *tmp_con = NULL;
+	sepol_ibpkey_t *tmp_record = NULL;
+
+	if (sepol_ibpkey_create(handle, &tmp_record) < 0)
+		goto err;
+
+	if (sepol_ibpkey_set_subnet_prefix_bytes(handle, tmp_record,
+					       (const char *)&ibpkey->u.ibpkey.subnet_prefix) < 0)
+		goto err;
+
+	sepol_ibpkey_set_range(tmp_record, low, high);
+
+	if (context_to_record(handle, policydb, con, &tmp_con) < 0)
+		goto err;
+
+	if (sepol_ibpkey_set_con(handle, tmp_record, tmp_con) < 0)
+		goto err;
+
+	sepol_context_free(tmp_con);
+	*record = tmp_record;
+	return STATUS_SUCCESS;
+
+err:
+	ERR(handle, "could not convert ibpkey to record");
+	sepol_context_free(tmp_con);
+	sepol_ibpkey_free(tmp_record);
+	return STATUS_ERR;
+}
+
+/* Return the number of ibpkeys */
+extern int sepol_ibpkey_count(sepol_handle_t *handle __attribute__ ((unused)),
+			    const sepol_policydb_t *p, unsigned int *response)
+{
+	unsigned int count = 0;
+	ocontext_t *c, *head;
+	const policydb_t *policydb = &p->p;
+
+	head = policydb->ocontexts[OCON_IBPKEY];
+	for (c = head; c; c = c->next)
+		count++;
+
+	*response = count;
+
+	handle = NULL;
+	return STATUS_SUCCESS;
+}
+
+/* Check if a ibpkey exists */
+int sepol_ibpkey_exists(sepol_handle_t *handle __attribute__ ((unused)),
+		      const sepol_policydb_t *p,
+		      const sepol_ibpkey_key_t *key, int *response)
+{
+	const policydb_t *policydb = &p->p;
+	ocontext_t *c, *head;
+	int low, high;
+	const char *subnet_prefix;
+
+	sepol_ibpkey_key_unpack(key, &subnet_prefix, &low, &high);
+
+	head = policydb->ocontexts[OCON_IBPKEY];
+	for (c = head; c; c = c->next) {
+		unsigned int *subnet_prefix2 = c->u.ibpkey.subnet_prefix;
+		uint16_t low2 = c->u.ibpkey.low_pkey;
+		uint16_t high2 = c->u.ibpkey.high_pkey;
+
+		if (low2 == low &&
+		    high2 == high &&
+		    (!memcmp(subnet_prefix, subnet_prefix2, 16))) {
+			*response = 1;
+			return STATUS_SUCCESS;
+		}
+	}
+
+	*response = 0;
+	return STATUS_SUCCESS;
+}
+
+/* Query a ibpkey */
+int sepol_ibpkey_query(sepol_handle_t *handle,
+		     const sepol_policydb_t *p,
+		     const sepol_ibpkey_key_t *key, sepol_ibpkey_t **response)
+{
+	const policydb_t *policydb = &p->p;
+	ocontext_t *c, *head;
+	int low, high;
+	const char *subnet_prefix;
+
+	sepol_ibpkey_key_unpack(key, &subnet_prefix, &low, &high);
+
+	head = policydb->ocontexts[OCON_IBPKEY];
+	for (c = head; c; c = c->next) {
+		unsigned int *subnet_prefix2 = c->u.ibpkey.subnet_prefix;
+		int low2 = c->u.ibpkey.low_pkey;
+		int high2 = c->u.ibpkey.high_pkey;
+
+		if (low2 == low &&
+		    high2 == high &&
+		    (!memcmp(subnet_prefix, subnet_prefix2, 16))) {
+			if (ibpkey_to_record(handle, policydb, c, response) < 0)
+				goto err;
+			return STATUS_SUCCESS;
+		}
+	}
+
+	*response = NULL;
+	return STATUS_SUCCESS;
+
+err:
+	ERR(handle, "could not query ibpkey subnet prefix: %s range %u - %u exists",
+	    subnet_prefix, low, high);
+	return STATUS_ERR;
+}
+
+/* Load a ibpkey into policy */
+int sepol_ibpkey_modify(sepol_handle_t *handle,
+		      sepol_policydb_t *p,
+		      const sepol_ibpkey_key_t *key, const sepol_ibpkey_t *data)
+{
+	policydb_t *policydb = &p->p;
+	ocontext_t *ibpkey = NULL;
+	int low, high;
+	const char *subnet_prefix;
+
+	sepol_ibpkey_key_unpack(key, &subnet_prefix, &low, &high);
+
+	if (ibpkey_from_record(handle, policydb, &ibpkey, data) < 0)
+		goto err;
+
+	/* Attach to context list */
+	ibpkey->next = policydb->ocontexts[OCON_IBPKEY];
+	policydb->ocontexts[OCON_IBPKEY] = ibpkey;
+
+	return STATUS_SUCCESS;
+
+err:
+	ERR(handle, "could not load ibpkey subnet prefix: %s range %u - %u exists",
+	    subnet_prefix, low, high);
+	if (ibpkey) {
+		context_destroy(&ibpkey->context[0]);
+		free(ibpkey);
+	}
+	return STATUS_ERR;
+}
+
+int sepol_ibpkey_iterate(sepol_handle_t *handle,
+		       const sepol_policydb_t *p,
+		       int (*fn)(const sepol_ibpkey_t *ibpkey,
+				 void *fn_arg), void *arg)
+{
+	const policydb_t *policydb = &p->p;
+	ocontext_t *c, *head;
+	sepol_ibpkey_t *ibpkey = NULL;
+
+	head = policydb->ocontexts[OCON_IBPKEY];
+	for (c = head; c; c = c->next) {
+		int status;
+
+		if (ibpkey_to_record(handle, policydb, c, &ibpkey) < 0)
+			goto err;
+
+		/* Invoke handler */
+		status = fn(ibpkey, arg);
+		if (status < 0)
+			goto err;
+
+		sepol_ibpkey_free(ibpkey);
+		ibpkey = NULL;
+
+		/* Handler requested exit */
+		if (status > 0)
+			break;
+	}
+
+	return STATUS_SUCCESS;
+
+err:
+	ERR(handle, "could not iterate over ibpkeys");
+	sepol_ibpkey_free(ibpkey);
+	return STATUS_ERR;
+}
diff --git a/python/semanage/semanage b/python/semanage/semanage
index 9659aac..11b56e2 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -58,6 +58,9 @@ usage_user_dict = {' --add': ('(', '-L LEVEL', '-R ROLES', '-r RANGE', '-s SEUSE
 usage_port = "semanage port [-h] [-n] [-N] [-S STORE] ["
 usage_port_dict = {' --add': ('-t TYPE', '-p PROTOCOL', '-r RANGE', '(', 'port_name', '|', 'port_range', ')'), ' --modify': ('-t TYPE', '-p PROTOCOL', '-r RANGE', '(', 'port_name', '|', 'port_range', ')'), ' --delete': ('-p PROTOCOL', '(', 'port_name', '|', 'port_range', ')'), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
 
+usage_ibpkey = "semanage ibpkey [-h] [-n] [-N] [-s STORE] ["
+usage_ibpkey_dict = {' --add': ('-t TYPE', '-x SUBNET_PREFIX', '-r RANGE', '(', 'ibpkey_name', '|', 'pkey_range', ')'), ' --modify': ('-t TYPE', '-x SUBNET_PREFIX', '-r RANGE', '(', 'ibpkey_name', '|', 'pkey_range', ')'), ' --delete': ('-x SUBNET_PREFIX', '(', 'ibpkey_name', '|', 'pkey_range', ')'), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
+
 usage_node = "semanage node [-h] [-n] [-N] [-S STORE] ["
 usage_node_dict = {' --add': ('-M NETMASK', '-p PROTOCOL', '-t TYPE', '-r RANGE', 'node'), ' --modify': ('-M NETMASK', '-p PROTOCOL', '-t TYPE', '-r RANGE', 'node'), ' --delete': ('-M NETMASK', '-p PROTOCOL', 'node'), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
 
@@ -145,6 +148,9 @@ def port_ini():
     OBJECT = seobject.portRecords(store)
     return OBJECT
 
+def ibpkey_ini():
+    OBJECT = seobject.ibpkeyRecords(store)
+    return OBJECT
 
 def module_ini():
     OBJECT = seobject.moduleRecords(store)
@@ -181,7 +187,7 @@ def dontaudit_ini():
     return OBJECT
 
 # define dictonary for seobject OBEJCTS
-object_dict = {'login': login_ini, 'user': user_ini, 'port': port_ini, 'module': module_ini, 'interface': interface_ini, 'node': node_ini, 'fcontext': fcontext_ini, 'boolean': boolean_ini, 'permissive': permissive_ini, 'dontaudit': dontaudit_ini}
+object_dict = {'login': login_ini, 'user': user_ini, 'port': port_ini, 'module': module_ini, 'interface': interface_ini, 'node': node_ini, 'fcontext': fcontext_ini, 'boolean': boolean_ini, 'permissive': permissive_ini, 'dontaudit': dontaudit_ini, 'ibpkey': ibpkey_ini}
 
 
 def generate_custom_usage(usage_text, usage_dict):
@@ -292,6 +298,11 @@ def parser_add_proto(parser, name):
     version for the specified node (ipv4|ipv6).
 '''))
 
+def parser_add_subnet_prefix(parser, name):
+    parser.add_argument('-x', '--subnet_prefix', help=_('''
+    Subnet prefix for  the specified infiniband ibpkey.
+'''))
+
 
 def parser_add_modify(parser, name):
     parser.add_argument('-m', '--modify', dest='action', action='store_const', const='modify', help=_("Modify a record of the %s object type") % name)
@@ -511,6 +522,52 @@ def setupPortParser(subparsers):
     portParser.set_defaults(func=handlePort)
 
 
+
+def handlePkey(args):
+    ibpkey_args = {'list': [('ibpkey', 'type', 'subnet_prefix'), ('')], 'add': [('locallist'), ('type', 'ibpkey', 'subnet_prefix')], 'modify': [('localist'), ('ibpkey', 'subnet_prefix')], 'delete': [('locallist'), ('ibpkey', 'subnet_prefix')], 'extract': [('locallist', 'ibpkey', 'type', 'subnet prefix'), ('')], 'deleteall': [('locallist'), ('')]}
+
+    handle_opts(args, ibpkey_args, args.action)
+
+    OBJECT = object_dict['ibpkey']()
+    OBJECT.set_reload(args.noreload)
+
+    if args.action is "add":
+        OBJECT.add(args.ibpkey, args.subnet_prefix, args.range, args.type)
+    if args.action is "modify":
+        OBJECT.modify(args.ibpkey, args.subnet_prefix, args.range, args.type)
+    if args.action is "delete":
+        OBJECT.delete(args.ibpkey, args.subnet_prefix)
+    if args.action is "list":
+        OBJECT.list(args.noheading, args.locallist)
+    if args.action is "deleteall":
+        OBJECT.deleteall()
+    if args.action is "extract":
+        for i in OBJECT.customized():
+            print("ibpkey %s" % str(i))
+
+
+def setupPkeyParser(subparsers):
+    generated_usage = generate_custom_usage(usage_ibpkey, usage_ibpkey_dict)
+    ibpkeyParser = subparsers.add_parser('ibpkey', usage=generated_usage, help=_('Manage infiniband ibpkey type definitions'))
+    parser_add_locallist(ibpkeyParser, "ibpkey")
+    parser_add_noheading(ibpkeyParser, "ibpkey")
+    parser_add_noreload(ibpkeyParser, "ibpkey")
+    parser_add_store(ibpkeyParser, "ibpkey")
+
+    ibpkey_action = ibpkeyParser.add_mutually_exclusive_group(required=True)
+    parser_add_add(ibpkey_action, "ibpkey")
+    parser_add_delete(ibpkey_action, "ibpkey")
+    parser_add_modify(ibpkey_action, "ibpkey")
+    parser_add_list(ibpkey_action, "ibpkey")
+    parser_add_extract(ibpkey_action, "ibpkey")
+    parser_add_deleteall(ibpkey_action, "ibpkey")
+    parser_add_type(ibpkeyParser, "ibpkey")
+    parser_add_range(ibpkeyParser, "ibpkey")
+    parser_add_subnet_prefix(ibpkeyParser, "ibpkey")
+    ibpkeyParser.add_argument('ibpkey', nargs='?', default=None, help=_('pkey | pkey_range'))
+    ibpkeyParser.set_defaults(func=handlePkey)
+
+
 def handleInterface(args):
     interface_args = {'list': [('interface'), ('')], 'add': [('locallist'), ('type', 'interface')], 'modify': [('locallist'), ('type', 'interface')], 'delete': [('locallist'), ('interface')], 'extract': [('locallist', 'interface', 'type'), ('')], 'deleteall': [('locallist'), ('')]}
 
@@ -849,6 +906,7 @@ def createCommandParser():
     setupLoginParser(subparsers)
     setupUserParser(subparsers)
     setupPortParser(subparsers)
+    setupPkeyParser(subparsers)
     setupInterfaceParser(subparsers)
     setupModuleParser(subparsers)
     setupNodeParser(subparsers)
diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 7a54373..41b0aca 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -32,6 +32,7 @@ import socket
 from semanage import *
 PROGNAME = "policycoreutils"
 import sepolicy
+import setools
 from IPy import IP
 
 try:
@@ -1309,6 +1310,260 @@ class portRecords(semanageRecords):
                 rec += ", %s" % p
             print(rec)
 
+class ibpkeyRecords(semanageRecords):
+    try:
+        q = setools.TypeQuery(setools.SELinuxPolicy(sepolicy.get_installed_policy()), attrs=["ibpkey_type"])
+        valid_types = sorted(str(t) for t in q.results())
+    except RuntimeError:
+        valid_types = []
+
+    def __init__(self, store=""):
+        semanageRecords.__init__(self, store)
+
+    def __genkey(self, pkey, subnet_prefix):
+	if subnet_prefix == "":
+            raise ValueError(_("Subnet Prefix is required"))
+
+	pkeys = pkey.split("-")
+        if len(pkeys) == 1:
+            high = low = int(pkeys[0], 0)
+        else:
+            low = int(pkeys[0], 0)
+            high = int(pkeys[1], 0)
+
+        if high > 65535:
+            raise ValueError(_("Invalid Pkey"))
+
+        (rc, k) = semanage_ibpkey_key_create(self.sh, subnet_prefix, low, high)
+        if rc < 0:
+            raise ValueError(_("Could not create a key for %s/%s") % (subnet_prefix, pkey))
+        return (k, subnet_prefix, low, high)
+
+    def __add(self, pkey, subnet_prefix, serange, type):
+        if is_mls_enabled == 1:
+            if serange == "":
+                serange = "s0"
+            else:
+                serange = untranslate(serange)
+
+        if type == "":
+            raise ValueError(_("Type is required"))
+
+        if type not in self.valid_types:
+            raise ValueError(_("Type %s is invalid, must be a ibpkey type") % type)
+
+        (k, subnet_prefix, low, high) = self.__genkey(pkey, subnet_prefix)
+
+        (rc, exists) = semanage_ibpkey_exists(self.sh, k)
+        if rc < 0:
+            raise ValueError(_("Could not check if ibpkey %s/%s is defined") % (subnet_prefix, pkey))
+        if exists:
+            raise ValueError(_("ibpkey %s/%s already defined") % (subnet_prefix, pkey))
+
+        (rc, p) = semanage_ibpkey_create(self.sh)
+        if rc < 0:
+            raise ValueError(_("Could not create ibpkey for %s/%s") % (subnet_prefix, pkey))
+
+        semanage_ibpkey_set_subnet_prefix(self.sh, p, subnet_prefix)
+        semanage_ibpkey_set_range(p, low, high)
+        (rc, con) = semanage_context_create(self.sh)
+        if rc < 0:
+            raise ValueError(_("Could not create context for %s/%s") % (subnet_prefix, pkey))
+
+        rc = semanage_context_set_user(self.sh, con, "system_u")
+        if rc < 0:
+            raise ValueError(_("Could not set user in ibpkey context for %s/%s") % (subnet_prefix, pkey))
+
+        rc = semanage_context_set_role(self.sh, con, "object_r")
+        if rc < 0:
+            raise ValueError(_("Could not set role in ibpkey context for %s/%s") % (subnet_prefix, pkey))
+
+        rc = semanage_context_set_type(self.sh, con, type)
+        if rc < 0:
+            raise ValueError(_("Could not set type in ibpkey context for %s/%s") % (subnet_prefix, pkey))
+
+        if (is_mls_enabled == 1) and (serange != ""):
+            rc = semanage_context_set_mls(self.sh, con, serange)
+            if rc < 0:
+                raise ValueError(_("Could not set mls fields in ibpkey context for %s/%s") % (subnet_prefix, pkey))
+
+        rc = semanage_ibpkey_set_con(self.sh, p, con)
+        if rc < 0:
+            raise ValueError(_("Could not set ibpkey context for %s/%s") % (subnet_prefix, pkey))
+
+        rc = semanage_ibpkey_modify_local(self.sh, k, p)
+        if rc < 0:
+            raise ValueError(_("Could not add ibpkey %s/%s") % (subnet_prefix, pkey))
+
+        semanage_context_free(con)
+        semanage_ibpkey_key_free(k)
+        semanage_ibpkey_free(p)
+
+    def add(self, pkey, subnet_prefix, serange, type):
+        self.begin()
+        self.__add(pkey, subnet_prefix, serange, type)
+        self.commit()
+
+    def __modify(self, pkey, subnet_prefix, serange, setype):
+        if serange == "" and setype == "":
+            if is_mls_enabled == 1:
+                raise ValueError(_("Requires setype or serange"))
+            else:
+                raise ValueError(_("Requires setype"))
+
+        if setype and setype not in self.valid_types:
+            raise ValueError(_("Type %s is invalid, must be a ibpkey type") % setype)
+
+        (k, subnet_prefix, low, high) = self.__genkey(pkey, subnet_prefix)
+
+        (rc, exists) = semanage_ibpkey_exists(self.sh, k)
+        if rc < 0:
+            raise ValueError(_("Could not check if ibpkey %s/%s is defined") % (subnet_prefix, pkey))
+        if not exists:
+            raise ValueError(_("ibpkey %s/%s is not defined") % (subnet_prefix, pkey))
+
+        (rc, p) = semanage_ibpkey_query(self.sh, k)
+        if rc < 0:
+            raise ValueError(_("Could not query ibpkey %s/%s") % (subnet_prefix, pkey))
+
+        con = semanage_ibpkey_get_con(p)
+
+        if (is_mls_enabled == 1) and (serange != ""):
+            semanage_context_set_mls(self.sh, con, untranslate(serange))
+        if setype != "":
+            semanage_context_set_type(self.sh, con, setype)
+
+        rc = semanage_ibpkey_modify_local(self.sh, k, p)
+        if rc < 0:
+            raise ValueError(_("Could not modify ibpkey %s/%s") % (subnet_prefix, pkey))
+
+        semanage_ibpkey_key_free(k)
+        semanage_ibpkey_free(p)
+
+    def modify(self, pkey, subnet_prefix, serange, setype):
+        self.begin()
+        self.__modify(pkey, subnet_prefix, serange, setype)
+        self.commit()
+
+    def deleteall(self):
+        (rc, plist) = semanage_ibpkey_list_local(self.sh)
+        if rc < 0:
+            raise ValueError(_("Could not list the ibpkeys"))
+
+        self.begin()
+
+        for ibpkey in plist:
+            (rc, subnet_prefix) = semanage_ibpkey_get_subnet_prefix(self.sh, ibpkey)
+            low = semanage_ibpkey_get_low(ibpkey)
+            high = semanage_ibpkey_get_high(ibpkey)
+            pkey_str = "%s-%s" % (low, high)
+            (k, subnet_prefix, low, high) = self.__genkey(pkey_str, subnet_prefix)
+            if rc < 0:
+                raise ValueError(_("Could not create a key for %s") % pkey_str)
+
+            rc = semanage_ibpkey_del_local(self.sh, k)
+            if rc < 0:
+                raise ValueError(_("Could not delete the ibpkey %s") % pkey_str)
+            semanage_ibpkey_key_free(k)
+
+        self.commit()
+
+    def __delete(self, pkey, subnet_prefix):
+        (k, subnet_prefix, low, high) = self.__genkey(pkey, subnet_prefix)
+        (rc, exists) = semanage_ibpkey_exists(self.sh, k)
+        if rc < 0:
+            raise ValueError(_("Could not check if ibpkey %s/%s is defined") % (subnet_prefix, pkey))
+        if not exists:
+            raise ValueError(_("ibpkey %s/%s is not defined") % (subnet_prefix, pkey))
+
+        (rc, exists) = semanage_ibpkey_exists_local(self.sh, k)
+        if rc < 0:
+            raise ValueError(_("Could not check if ibpkey %s/%s is defined") % (subnet_prefix, pkey))
+        if not exists:
+            raise ValueError(_("ibpkey %s/%s is defined in policy, cannot be deleted") % (subnet_prefix, pkey))
+
+        rc = semanage_ibpkey_del_local(self.sh, k)
+        if rc < 0:
+            raise ValueError(_("Could not delete ibpkey %s/%s") % (subnet_prefix, pkey))
+
+        semanage_ibpkey_key_free(k)
+
+    def delete(self, pkey, subnet_prefix):
+        self.begin()
+        self.__delete(pkey, subnet_prefix)
+        self.commit()
+
+    def get_all(self, locallist=0):
+        ddict = {}
+        if locallist:
+            (rc, self.plist) = semanage_ibpkey_list_local(self.sh)
+        else:
+            (rc, self.plist) = semanage_ibpkey_list(self.sh)
+        if rc < 0:
+            raise ValueError(_("Could not list ibpkeys"))
+
+        for ibpkey in self.plist:
+            con = semanage_ibpkey_get_con(ibpkey)
+            ctype = semanage_context_get_type(con)
+            if ctype == "reserved_ibpkey_t":
+                continue
+            level = semanage_context_get_mls(con)
+            (rc, subnet_prefix) = semanage_ibpkey_get_subnet_prefix(self.sh, ibpkey)
+            low = semanage_ibpkey_get_low(ibpkey)
+            high = semanage_ibpkey_get_high(ibpkey)
+            ddict[(low, high, subnet_prefix)] = (ctype, level)
+        return ddict
+
+    def get_all_by_type(self, locallist=0):
+        ddict = {}
+        if locallist:
+            (rc, self.plist) = semanage_ibpkey_list_local(self.sh)
+        else:
+            (rc, self.plist) = semanage_ibpkey_list(self.sh)
+        if rc < 0:
+            raise ValueError(_("Could not list ibpkeys"))
+
+        for ibpkey in self.plist:
+            con = semanage_ibpkey_get_con(ibpkey)
+            ctype = semanage_context_get_type(con)
+            (rc, subnet_prefix) = semanage_ibpkey_get_subnet_prefix(self.sh, ibpkey)
+            low = semanage_ibpkey_get_low(ibpkey)
+            high = semanage_ibpkey_get_high(ibpkey)
+            if (ctype, subnet_prefix) not in ddict.keys():
+                ddict[(ctype, subnet_prefix)] = []
+            if low == high:
+                ddict[(ctype, subnet_prefix)].append("0x%x" % low)
+            else:
+                ddict[(ctype, subnet_prefix)].append("0x%x-0x%x" % (low, high))
+        return ddict
+
+    def customized(self):
+        l = []
+        ddict = self.get_all(True)
+        keys = ddict.keys()
+        keys.sort()
+        for k in keys:
+            if k[0] == k[1]:
+                l.append("-a -t %s -x %s %s" % (ddict[k][0], k[2], k[0]))
+            else:
+                l.append("-a -t %s -x %s %s-%s" % (ddict[k][0], k[2], k[0], k[1]))
+        return l
+
+    def list(self, heading=1, locallist=0):
+        ddict = self.get_all_by_type(locallist)
+        keys = ddict.keys()
+        if len(keys) == 0:
+            return
+        keys.sort()
+
+        if heading:
+            print "%-30s %-18s %s\n" % (_("SELinux IB Pkey Type"), _("Subnet_Prefix"), _("Pkey Number"))
+        for i in keys:
+            rec = "%-30s %-18s " % i
+            rec += "%s" % ddict[i][0]
+            for p in ddict[i][1:]:
+                rec += ", %s" % p
+            print rec
 
 class nodeRecords(semanageRecords):
     try:
-- 
2.7.4
