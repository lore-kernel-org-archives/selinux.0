Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v49KpCa9005427
 for <selinux@tycho.nsa.gov>; Tue, 9 May 2017 16:51:12 -0400
From: Dan Jurgens <danielj@mellanox.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 8/9] semanage: Update semanage to allow runtime labeling of
 ibendports
Date: Tue,  9 May 2017 23:50:41 +0300
Message-Id: <1494363042-121766-9-git-send-email-danielj@mellanox.com>
In-Reply-To: <1494363042-121766-1-git-send-email-danielj@mellanox.com>
References: <1494363042-121766-1-git-send-email-danielj@mellanox.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Daniel Jurgens <danielj@mellanox.com>

Update libsepol and libsemanage to work with ibendport records. Add local
storage for new and modified ibendport records in ibendports.local.
Update semanage to parse the ibendport command options to add, modify,
and delete them.

Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
---
 libsemanage/include/semanage/ibendport_record.h  |   62 +++++
 libsemanage/include/semanage/ibendports_local.h  |   36 +++
 libsemanage/include/semanage/ibendports_policy.h |   28 ++
 libsemanage/include/semanage/semanage.h          |    3 +
 libsemanage/src/direct_api.c                     |   42 +++-
 libsemanage/src/handle.h                         |   38 ++-
 libsemanage/src/ibendport_internal.h             |   48 ++++
 libsemanage/src/ibendport_record.c               |  154 +++++++++++
 libsemanage/src/ibendports_file.c                |  157 +++++++++++
 libsemanage/src/ibendports_local.c               |  153 +++++++++++
 libsemanage/src/ibendports_policy.c              |   55 ++++
 libsemanage/src/ibendports_policydb.c            |   62 +++++
 libsemanage/src/libsemanage.map                  |    1 +
 libsemanage/src/policy_components.c              |    4 +
 libsemanage/src/semanage_store.c                 |    1 +
 libsemanage/src/semanage_store.h                 |    1 +
 libsemanage/src/semanageswig.i                   |    3 +
 libsemanage/src/semanageswig_python.i            |   43 +++
 libsemanage/utils/semanage_migrate_store         |    3 +-
 libsepol/include/sepol/ibendport_record.h        |   68 +++++
 libsepol/include/sepol/ibendports.h              |   45 ++++
 libsepol/include/sepol/sepol.h                   |    2 +
 libsepol/src/ibendport_internal.h                |   20 ++
 libsepol/src/ibendport_record.c                  |  299 ++++++++++++++++++++++
 libsepol/src/ibendports.c                        |  255 ++++++++++++++++++
 python/semanage/semanage                         |   58 ++++-
 python/semanage/seobject.py                      |  238 +++++++++++++++++
 27 files changed, 1857 insertions(+), 22 deletions(-)
 create mode 100644 libsemanage/include/semanage/ibendport_record.h
 create mode 100644 libsemanage/include/semanage/ibendports_local.h
 create mode 100644 libsemanage/include/semanage/ibendports_policy.h
 create mode 100644 libsemanage/src/ibendport_internal.h
 create mode 100644 libsemanage/src/ibendport_record.c
 create mode 100644 libsemanage/src/ibendports_file.c
 create mode 100644 libsemanage/src/ibendports_local.c
 create mode 100644 libsemanage/src/ibendports_policy.c
 create mode 100644 libsemanage/src/ibendports_policydb.c
 create mode 100644 libsepol/include/sepol/ibendport_record.h
 create mode 100644 libsepol/include/sepol/ibendports.h
 create mode 100644 libsepol/src/ibendport_internal.h
 create mode 100644 libsepol/src/ibendport_record.c
 create mode 100644 libsepol/src/ibendports.c

diff --git a/libsemanage/include/semanage/ibendport_record.h b/libsemanage/include/semanage/ibendport_record.h
new file mode 100644
index 0000000..153eea0
--- /dev/null
+++ b/libsemanage/include/semanage/ibendport_record.h
@@ -0,0 +1,62 @@
+/*Copyright (C) 2005 Red Hat, Inc. */
+
+#ifndef _SEMANAGE_IBENDPORT_RECORD_H_
+#define _SEMANAGE_IBENDPORT_RECORD_H_
+
+#include <semanage/context_record.h>
+#include <semanage/handle.h>
+#include <stddef.h>
+
+#ifndef _SEMANAGE_IBENDPORT_DEFINED_
+struct semanage_ibendport;
+struct semanage_ibendport_key;
+typedef struct semanage_ibendport semanage_ibendport_t;
+typedef struct semanage_ibendport_key semanage_ibendport_key_t;
+#define _SEMANAGE_IBENDPORT_DEFINED_
+#endif
+
+extern int semanage_ibendport_compare(const semanage_ibendport_t *ibendport,
+				      const semanage_ibendport_key_t *key);
+
+extern int semanage_ibendport_compare2(const semanage_ibendport_t *ibendport,
+				       const semanage_ibendport_t *ibendport2);
+
+extern int semanage_ibendport_key_create(semanage_handle_t *handle,
+					 const char *ibdev_name,
+					 int port,
+					 semanage_ibendport_key_t **key_ptr);
+
+extern int semanage_ibendport_key_extract(semanage_handle_t *handle,
+					  const semanage_ibendport_t *ibendport,
+					  semanage_ibendport_key_t **key_ptr);
+
+extern void semanage_ibendport_key_free(semanage_ibendport_key_t *key);
+
+extern int semanage_ibendport_get_ibdev_name(semanage_handle_t *handle,
+					     const semanage_ibendport_t *ibendport,
+					     char **ibdev_name_ptr);
+
+extern int semanage_ibendport_set_ibdev_name(semanage_handle_t *handle,
+					     semanage_ibendport_t *ibendport,
+					     const char *ibdev_name);
+
+extern int semanage_ibendport_get_port(const semanage_ibendport_t *ibendport);
+
+extern void semanage_ibendport_set_port(semanage_ibendport_t *ibendport, int port);
+
+extern semanage_context_t *semanage_ibendport_get_con(const semanage_ibendport_t *ibendport);
+
+extern int semanage_ibendport_set_con(semanage_handle_t *handle,
+				      semanage_ibendport_t *ibendport,
+				      semanage_context_t *con);
+
+extern int semanage_ibendport_create(semanage_handle_t *handle,
+				     semanage_ibendport_t **ibendport_ptr);
+
+extern int semanage_ibendport_clone(semanage_handle_t *handle,
+				    const semanage_ibendport_t *ibendport,
+				    semanage_ibendport_t **ibendport_ptr);
+
+extern void semanage_ibendport_free(semanage_ibendport_t *ibendport);
+
+#endif
diff --git a/libsemanage/include/semanage/ibendports_local.h b/libsemanage/include/semanage/ibendports_local.h
new file mode 100644
index 0000000..641dd35
--- /dev/null
+++ b/libsemanage/include/semanage/ibendports_local.h
@@ -0,0 +1,36 @@
+/* Copyright (C) 2017 Mellanox Technologies Inc */
+
+#ifndef _SEMANAGE_IBENDPORTS_LOCAL_H_
+#define _SEMANAGE_IBENDPORTS_LOCAL_H_
+
+#include <semanage/ibendport_record.h>
+#include <semanage/handle.h>
+
+extern int semanage_ibendport_modify_local(semanage_handle_t *handle,
+					   const semanage_ibendport_key_t *key,
+					   const semanage_ibendport_t *data);
+
+extern int semanage_ibendport_del_local(semanage_handle_t *handle,
+					const semanage_ibendport_key_t *key);
+
+extern int semanage_ibendport_query_local(semanage_handle_t *handle,
+					  const semanage_ibendport_key_t *key,
+					  semanage_ibendport_t **response);
+
+extern int semanage_ibendport_exists_local(semanage_handle_t *handle,
+					   const semanage_ibendport_key_t *key,
+					   int *response);
+
+extern int semanage_ibendport_count_local(semanage_handle_t *handle,
+					  unsigned int *response);
+
+extern int semanage_ibendport_iterate_local(semanage_handle_t *handle,
+					    int (*handler)(const semanage_ibendport_t *record,
+							   void *varg),
+					    void *handler_arg);
+
+extern int semanage_ibendport_list_local(semanage_handle_t *handle,
+					 semanage_ibendport_t ***records,
+					 unsigned int *count);
+
+#endif
diff --git a/libsemanage/include/semanage/ibendports_policy.h b/libsemanage/include/semanage/ibendports_policy.h
new file mode 100644
index 0000000..3fc1976
--- /dev/null
+++ b/libsemanage/include/semanage/ibendports_policy.h
@@ -0,0 +1,28 @@
+/* Copyright (C) 2017 Mellanox Techonologies Inc */
+
+#ifndef _SEMANAGE_IBENDPORTS_POLICY_H_
+#define _SEMANAGE_IBENDPORTS_POLICY_H_
+
+#include <semanage/handle.h>
+#include <semanage/ibendport_record.h>
+
+extern int semanage_ibendport_query(semanage_handle_t *handle,
+				    const semanage_ibendport_key_t *key,
+				    semanage_ibendport_t **response);
+
+extern int semanage_ibendport_exists(semanage_handle_t *handle,
+				     const semanage_ibendport_key_t *key, int *response);
+
+extern int semanage_ibendport_count(semanage_handle_t *handle,
+				    unsigned int *response);
+
+extern int semanage_ibendport_iterate(semanage_handle_t *handle,
+				      int (*handler)(const semanage_ibendport_t *record,
+						     void *varg),
+				      void *handler_arg);
+
+extern int semanage_ibendport_list(semanage_handle_t *handle,
+				   semanage_ibendport_t ***records,
+				   unsigned int *count);
+
+#endif
diff --git a/libsemanage/include/semanage/semanage.h b/libsemanage/include/semanage/semanage.h
index cebf3f4..0489014 100644
--- a/libsemanage/include/semanage/semanage.h
+++ b/libsemanage/include/semanage/semanage.h
@@ -34,6 +34,7 @@
 #include <semanage/iface_record.h>
 #include <semanage/port_record.h>
 #include <semanage/ibpkey_record.h>
+#include <semanage/ibendport_record.h>
 #include <semanage/node_record.h>
 
 /* Dbase */
@@ -49,6 +50,8 @@
 #include <semanage/ports_local.h>
 #include <semanage/ports_policy.h>
 #include <semanage/ibpkeys_local.h>
+#include <semanage/ibendports_local.h>
+#include <semanage/ibendports_policy.h>
 #include <semanage/ibpkeys_policy.h>
 #include <semanage/interfaces_local.h>
 #include <semanage/interfaces_policy.h>
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index f190b0c..68c1868 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -41,6 +41,7 @@
 #include "seuser_internal.h"
 #include "port_internal.h"
 #include "ibpkey_internal.h"
+#include "ibendport_internal.h"
 #include "iface_internal.h"
 #include "boolean_internal.h"
 #include "fcontext_internal.h"
@@ -226,11 +227,19 @@ int semanage_direct_connect(semanage_handle_t * sh)
 		goto err;
 
 	if (ibpkey_file_dbase_init(sh,
-				 semanage_path(SEMANAGE_ACTIVE,
-					       SEMANAGE_IBPKEYS_LOCAL),
-				 semanage_path(SEMANAGE_TMP,
-					       SEMANAGE_IBPKEYS_LOCAL),
-				 semanage_ibpkey_dbase_local(sh)) < 0)
+				   semanage_path(SEMANAGE_ACTIVE,
+						 SEMANAGE_IBPKEYS_LOCAL),
+				   semanage_path(SEMANAGE_TMP,
+						 SEMANAGE_IBPKEYS_LOCAL),
+				   semanage_ibpkey_dbase_local(sh)) < 0)
+		goto err;
+
+	if (ibendport_file_dbase_init(sh,
+				      semanage_path(SEMANAGE_ACTIVE,
+						    SEMANAGE_IBENDPORTS_LOCAL),
+				      semanage_path(SEMANAGE_TMP,
+						    SEMANAGE_IBENDPORTS_LOCAL),
+				      semanage_ibendport_dbase_local(sh)) < 0)
 		goto err;
 
 	/* Object databases: local modifications + policy */
@@ -260,6 +269,9 @@ int semanage_direct_connect(semanage_handle_t * sh)
 	if (ibpkey_policydb_dbase_init(sh, semanage_ibpkey_dbase_policy(sh)) < 0)
 		goto err;
 
+	if (ibendport_policydb_dbase_init(sh, semanage_ibendport_dbase_policy(sh)) < 0)
+		goto err;
+
 	if (iface_policydb_dbase_init(sh, semanage_iface_dbase_policy(sh)) < 0)
 		goto err;
 
@@ -333,6 +345,7 @@ static int semanage_direct_disconnect(semanage_handle_t * sh)
 	user_join_dbase_release(semanage_user_dbase_local(sh));
 	port_file_dbase_release(semanage_port_dbase_local(sh));
 	ibpkey_file_dbase_release(semanage_ibpkey_dbase_local(sh));
+	ibendport_file_dbase_release(semanage_ibendport_dbase_local(sh));
 	iface_file_dbase_release(semanage_iface_dbase_local(sh));
 	bool_file_dbase_release(semanage_bool_dbase_local(sh));
 	fcontext_file_dbase_release(semanage_fcontext_dbase_local(sh));
@@ -345,6 +358,7 @@ static int semanage_direct_disconnect(semanage_handle_t * sh)
 	user_join_dbase_release(semanage_user_dbase_policy(sh));
 	port_policydb_dbase_release(semanage_port_dbase_policy(sh));
 	ibpkey_policydb_dbase_release(semanage_ibpkey_dbase_policy(sh));
+	ibendport_policydb_dbase_release(semanage_ibendport_dbase_policy(sh));
 	iface_policydb_dbase_release(semanage_iface_dbase_policy(sh));
 	bool_policydb_dbase_release(semanage_bool_dbase_policy(sh));
 	fcontext_file_dbase_release(semanage_fcontext_dbase_policy(sh));
@@ -1158,7 +1172,8 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 
 	int do_rebuild, do_write_kernel, do_install;
 	int fcontexts_modified, ports_modified, seusers_modified,
-		disable_dontaudit, preserve_tunables, ibpkeys_modified;
+		disable_dontaudit, preserve_tunables, ibpkeys_modified,
+		ibendports_modified;
 	dbase_config_t *users = semanage_user_dbase_local(sh);
 	dbase_config_t *users_base = semanage_user_base_dbase_local(sh);
 	dbase_config_t *pusers_base = semanage_user_base_dbase_policy(sh);
@@ -1167,6 +1182,8 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	dbase_config_t *pports = semanage_port_dbase_policy(sh);
 	dbase_config_t *ibpkeys = semanage_ibpkey_dbase_local(sh);
 	dbase_config_t *pibpkeys = semanage_ibpkey_dbase_policy(sh);
+	dbase_config_t *ibendports = semanage_ibendport_dbase_local(sh);
+	dbase_config_t *pibendports = semanage_ibendport_dbase_policy(sh);
 	dbase_config_t *bools = semanage_bool_dbase_local(sh);
 	dbase_config_t *pbools = semanage_bool_dbase_policy(sh);
 	dbase_config_t *ifaces = semanage_iface_dbase_local(sh);
@@ -1181,6 +1198,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	/* Modified flags that we need to use more than once. */
 	ports_modified = ports->dtable->is_modified(ports->dbase);
 	ibpkeys_modified = ibpkeys->dtable->is_modified(ibpkeys->dbase);
+	ibendports_modified = ibendports->dtable->is_modified(ibendports->dbase);
 	seusers_modified = seusers->dtable->is_modified(seusers->dbase);
 	fcontexts_modified = fcontexts->dtable->is_modified(fcontexts->dbase);
 
@@ -1302,7 +1320,8 @@ rebuild:
 	 * that live under /etc/selinux (kernel policy, seusers, file contexts)
 	 * will be modified.
 	 */
-	do_write_kernel = do_rebuild | ports_modified | ibpkeys_modified
+	do_write_kernel = do_rebuild | ports_modified | ibpkeys_modified |
+		ibendports_modified |
 		bools->dtable->is_modified(bools->dbase) |
 		ifaces->dtable->is_modified(ifaces->dbase) |
 		nodes->dtable->is_modified(nodes->dbase) |
@@ -1449,6 +1468,7 @@ rebuild:
 	dbase_policydb_attach((dbase_policydb_t *) pusers_base->dbase, out);
 	dbase_policydb_attach((dbase_policydb_t *) pports->dbase, out);
 	dbase_policydb_attach((dbase_policydb_t *) pibpkeys->dbase, out);
+	dbase_policydb_attach((dbase_policydb_t *) pibendports->dbase, out);
 	dbase_policydb_attach((dbase_policydb_t *) pifaces->dbase, out);
 	dbase_policydb_attach((dbase_policydb_t *) pbools->dbase, out);
 	dbase_policydb_attach((dbase_policydb_t *) pnodes->dbase, out);
@@ -1503,6 +1523,13 @@ rebuild:
 		if (retval < 0)
 			goto cleanup;
 	}
+
+	/* Validate local ibendports */
+	if (do_rebuild || ibendports_modified) {
+		retval = semanage_ibendport_validate_local(sh);
+		if (retval < 0)
+			goto cleanup;
+	}
 	/* ================== Write non-policydb components ========= */
 
 	/* Commit changes to components */
@@ -1583,6 +1610,7 @@ cleanup:
 	dbase_policydb_detach((dbase_policydb_t *) pusers_base->dbase);
 	dbase_policydb_detach((dbase_policydb_t *) pports->dbase);
 	dbase_policydb_detach((dbase_policydb_t *) pibpkeys->dbase);
+	dbase_policydb_detach((dbase_policydb_t *) pibendports->dbase);
 	dbase_policydb_detach((dbase_policydb_t *) pifaces->dbase);
 	dbase_policydb_detach((dbase_policydb_t *) pnodes->dbase);
 	dbase_policydb_detach((dbase_policydb_t *) pbools->dbase);
diff --git a/libsemanage/src/handle.h b/libsemanage/src/handle.h
index 306727a..889871d 100644
--- a/libsemanage/src/handle.h
+++ b/libsemanage/src/handle.h
@@ -79,7 +79,7 @@ struct semanage_handle {
 	struct semanage_policy_table *funcs;
 
 	/* Object databases */
-#define DBASE_COUNT      21
+#define DBASE_COUNT      23
 
 /* Local modifications */
 #define DBASE_LOCAL_USERS_BASE  0
@@ -92,21 +92,23 @@ struct semanage_handle {
 #define DBASE_LOCAL_SEUSERS     7
 #define DBASE_LOCAL_NODES       8
 #define DBASE_LOCAL_IBPKEYS     9
+#define DBASE_LOCAL_IBENDPORTS  10
 
 /* Policy + Local modifications */
-#define DBASE_POLICY_USERS_BASE  10
-#define DBASE_POLICY_USERS_EXTRA 11
-#define DBASE_POLICY_USERS       12
-#define DBASE_POLICY_PORTS       13
-#define DBASE_POLICY_INTERFACES  14
-#define DBASE_POLICY_BOOLEANS    15
-#define DBASE_POLICY_FCONTEXTS   16
-#define DBASE_POLICY_SEUSERS     17
-#define DBASE_POLICY_NODES       18
-#define DBASE_POLICY_IBPKEYS     19
+#define DBASE_POLICY_USERS_BASE  11
+#define DBASE_POLICY_USERS_EXTRA 12
+#define DBASE_POLICY_USERS       13
+#define DBASE_POLICY_PORTS       14
+#define DBASE_POLICY_INTERFACES  15
+#define DBASE_POLICY_BOOLEANS    16
+#define DBASE_POLICY_FCONTEXTS   17
+#define DBASE_POLICY_SEUSERS     18
+#define DBASE_POLICY_NODES       19
+#define DBASE_POLICY_IBPKEYS     20
+#define DBASE_POLICY_IBENDPORTS  21
 
 /* Active kernel policy */
-#define DBASE_ACTIVE_BOOLEANS    20
+#define DBASE_ACTIVE_BOOLEANS    22
 	dbase_config_t dbase[DBASE_COUNT];
 };
 
@@ -142,6 +144,12 @@ static inline
 }
 
 static inline
+    dbase_config_t * semanage_ibendport_dbase_local(semanage_handle_t * handle)
+{
+	return &handle->dbase[DBASE_LOCAL_IBENDPORTS];
+}
+
+static inline
     dbase_config_t * semanage_iface_dbase_local(semanage_handle_t * handle)
 {
 	return &handle->dbase[DBASE_LOCAL_INTERFACES];
@@ -204,6 +212,12 @@ static inline
 }
 
 static inline
+    dbase_config_t * semanage_ibendport_dbase_policy(semanage_handle_t * handle)
+{
+	return &handle->dbase[DBASE_POLICY_IBENDPORTS];
+}
+
+static inline
     dbase_config_t * semanage_iface_dbase_policy(semanage_handle_t * handle)
 {
 	return &handle->dbase[DBASE_POLICY_INTERFACES];
diff --git a/libsemanage/src/ibendport_internal.h b/libsemanage/src/ibendport_internal.h
new file mode 100644
index 0000000..970fbdb
--- /dev/null
+++ b/libsemanage/src/ibendport_internal.h
@@ -0,0 +1,48 @@
+#ifndef _SEMANAGE_IBENDPORT_INTERNAL_H_
+#define _SEMANAGE_IBENDPORT_INTERNAL_H_
+
+#include <semanage/ibendport_record.h>
+#include <semanage/ibendports_local.h>
+#include <semanage/ibendports_policy.h>
+#include "database.h"
+#include "handle.h"
+#include "dso.h"
+
+hidden_proto(semanage_ibendport_create)
+hidden_proto(semanage_ibendport_compare)
+hidden_proto(semanage_ibendport_compare2)
+hidden_proto(semanage_ibendport_clone)
+hidden_proto(semanage_ibendport_free)
+hidden_proto(semanage_ibendport_key_extract)
+hidden_proto(semanage_ibendport_key_free)
+hidden_proto(semanage_ibendport_get_port)
+hidden_proto(semanage_ibendport_set_port)
+hidden_proto(semanage_ibendport_get_con)
+hidden_proto(semanage_ibendport_set_con)
+hidden_proto(semanage_ibendport_list_local)
+hidden_proto(semanage_ibendport_get_ibdev_name)
+hidden_proto(semanage_ibendport_set_ibdev_name)
+
+/* IBENDPORT RECORD: method table */
+extern record_table_t SEMANAGE_IBENDPORT_RTABLE;
+
+extern int ibendport_file_dbase_init(semanage_handle_t *handle,
+				     const char *path_ro,
+				     const char *path_rw,
+				     dbase_config_t *dconfig);
+
+extern void ibendport_file_dbase_release(dbase_config_t *dconfig);
+
+extern int ibendport_policydb_dbase_init(semanage_handle_t *handle,
+					 dbase_config_t *dconfig);
+
+extern void ibendport_policydb_dbase_release(dbase_config_t *dconfig);
+
+extern int hidden semanage_ibendport_validate_local(semanage_handle_t *handle);
+
+/* ==== Internal (to ibendports) API === */
+
+hidden int semanage_ibendport_compare2_qsort(const semanage_ibendport_t **ibendport,
+					     const semanage_ibendport_t **ibendport2);
+
+#endif
diff --git a/libsemanage/src/ibendport_record.c b/libsemanage/src/ibendport_record.c
new file mode 100644
index 0000000..955067e
--- /dev/null
+++ b/libsemanage/src/ibendport_record.c
@@ -0,0 +1,154 @@
+/*Copyright (C) 2005 Red Hat, Inc. */
+
+/*Object: semanage_ibendport_t (Infiniband Pkey)
+ *Object: semanage_ibendport_key_t (Infiniband Pkey Key)
+ *Implements: record_t (Database Record)
+ *Implements: record_key_t (Database Record Key)
+ */
+
+#include <sepol/context_record.h>
+#include <sepol/ibendport_record.h>
+
+typedef sepol_context_t semanage_context_t;
+typedef sepol_ibendport_t semanage_ibendport_t;
+typedef sepol_ibendport_key_t semanage_ibendport_key_t;
+#define _SEMANAGE_IBENDPORT_DEFINED_
+#define _SEMANAGE_CONTEXT_DEFINED_
+
+typedef semanage_ibendport_t record_t;
+typedef semanage_ibendport_key_t record_key_t;
+#define DBASE_RECORD_DEFINED
+
+#include "ibendport_internal.h"
+#include "handle.h"
+#include "database.h"
+
+int semanage_ibendport_compare(const semanage_ibendport_t *ibendport,
+			       const semanage_ibendport_key_t *key)
+{
+	return sepol_ibendport_compare(ibendport, key);
+}
+
+hidden_def(semanage_ibendport_compare)
+
+int semanage_ibendport_compare2(const semanage_ibendport_t *ibendport,
+				const semanage_ibendport_t *ibendport2)
+{
+	return sepol_ibendport_compare2(ibendport, ibendport2);
+}
+
+hidden_def(semanage_ibendport_compare2)
+
+hidden int semanage_ibendport_compare2_qsort(const semanage_ibendport_t **ibendport,
+					     const semanage_ibendport_t **ibendport2)
+{
+	return sepol_ibendport_compare2(*ibendport, *ibendport2);
+}
+
+int semanage_ibendport_key_create(semanage_handle_t *handle,
+				  const char *ibdev_name,
+				  int port,
+				  semanage_ibendport_key_t **key_ptr)
+{
+	return sepol_ibendport_key_create(handle->sepolh, ibdev_name, port, key_ptr);
+}
+
+int semanage_ibendport_key_extract(semanage_handle_t *handle,
+				   const semanage_ibendport_t *ibendport,
+				   semanage_ibendport_key_t **key_ptr)
+{
+	return sepol_ibendport_key_extract(handle->sepolh, ibendport, key_ptr);
+}
+
+hidden_def(semanage_ibendport_key_extract)
+
+void semanage_ibendport_key_free(semanage_ibendport_key_t *key)
+{
+	sepol_ibendport_key_free(key);
+}
+
+hidden_def(semanage_ibendport_key_free)
+
+int semanage_ibendport_get_ibdev_name(semanage_handle_t *handle,
+				      const semanage_ibendport_t *ibendport,
+				      char **ibdev_name_ptr)
+{
+	return sepol_ibendport_get_ibdev_name(handle->sepolh, ibendport, ibdev_name_ptr);
+}
+
+hidden_def(semanage_ibendport_get_ibdev_name)
+
+int semanage_ibendport_set_ibdev_name(semanage_handle_t *handle,
+				      semanage_ibendport_t *ibendport,
+				      const char *ibdev_name)
+{
+	return sepol_ibendport_set_ibdev_name(handle->sepolh, ibendport, ibdev_name);
+}
+
+hidden_def(semanage_ibendport_set_ibdev_name)
+
+int semanage_ibendport_get_port(const semanage_ibendport_t *ibendport)
+{
+	return sepol_ibendport_get_port(ibendport);
+}
+
+hidden_def(semanage_ibendport_get_port)
+
+void semanage_ibendport_set_port(semanage_ibendport_t *ibendport, int port)
+{
+	sepol_ibendport_set_port(ibendport, port);
+}
+
+hidden_def(semanage_ibendport_set_port)
+
+semanage_context_t *semanage_ibendport_get_con(const semanage_ibendport_t *ibendport)
+{
+	return sepol_ibendport_get_con(ibendport);
+}
+
+hidden_def(semanage_ibendport_get_con)
+
+int semanage_ibendport_set_con(semanage_handle_t *handle,
+			       semanage_ibendport_t *ibendport,
+			       semanage_context_t *con)
+{
+	return sepol_ibendport_set_con(handle->sepolh, ibendport, con);
+}
+
+hidden_def(semanage_ibendport_set_con)
+
+int semanage_ibendport_create(semanage_handle_t *handle,
+			      semanage_ibendport_t **ibendport_ptr)
+{
+	return sepol_ibendport_create(handle->sepolh, ibendport_ptr);
+}
+
+hidden_def(semanage_ibendport_create)
+
+int semanage_ibendport_clone(semanage_handle_t *handle,
+			     const semanage_ibendport_t *ibendport,
+			     semanage_ibendport_t **ibendport_ptr)
+{
+	return sepol_ibendport_clone(handle->sepolh, ibendport, ibendport_ptr);
+}
+
+hidden_def(semanage_ibendport_clone)
+
+void semanage_ibendport_free(semanage_ibendport_t *ibendport)
+{
+	sepol_ibendport_free(ibendport);
+}
+
+hidden_def(semanage_ibendport_free)
+
+/*key base functions */
+record_table_t SEMANAGE_IBENDPORT_RTABLE = {
+	.create = semanage_ibendport_create,
+	.key_extract = semanage_ibendport_key_extract,
+	.key_free = semanage_ibendport_key_free,
+	.clone = semanage_ibendport_clone,
+	.compare = semanage_ibendport_compare,
+	.compare2 = semanage_ibendport_compare2,
+	.compare2_qsort = semanage_ibendport_compare2_qsort,
+	.free = semanage_ibendport_free,
+};
diff --git a/libsemanage/src/ibendports_file.c b/libsemanage/src/ibendports_file.c
new file mode 100644
index 0000000..402c7a5
--- /dev/null
+++ b/libsemanage/src/ibendports_file.c
@@ -0,0 +1,157 @@
+/* Copyright (C) 2017 Mellanox Technologies Inc. */
+
+struct semanage_ibendport;
+struct semanage_ibendport_key;
+typedef struct semanage_ibendport record_t;
+typedef struct semanage_ibendport_key record_key_t;
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
+#include "ibendport_internal.h"
+#include "context_internal.h"
+#include "database_file.h"
+#include "parse_utils.h"
+#include "debug.h"
+
+static int ibendport_print(semanage_handle_t *handle,
+			   semanage_ibendport_t *ibendport,
+			   FILE *str)
+{
+	char *con_str = NULL;
+	char *ibdev_name_str = NULL;
+	int port = semanage_ibendport_get_port(ibendport);
+
+	if (semanage_ibendport_get_ibdev_name(handle, ibendport, &ibdev_name_str) != 0)
+		goto err;
+
+	semanage_context_t *con = semanage_ibendport_get_con(ibendport);
+
+	if (fprintf(str, "ibendportcon %s ", ibdev_name_str) < 0)
+		goto err;
+
+	if (fprintf(str, "%d ", port) < 0)
+		goto err;
+
+	if (semanage_context_to_string(handle, con, &con_str) < 0)
+		goto err;
+	if (fprintf(str, "%s\n", con_str) < 0)
+		goto err;
+
+	free(ibdev_name_str);
+	free(con_str);
+	return STATUS_SUCCESS;
+
+err:
+	ERR(handle, "could not print ibendport (%s) %u to stream",
+	    ibdev_name_str, port);
+	free(ibdev_name_str);
+	free(con_str);
+	return STATUS_ERR;
+}
+
+static int ibendport_parse(semanage_handle_t *handle,
+			   parse_info_t *info,
+			   semanage_ibendport_t *ibendport)
+{
+	int port;
+	char *str = NULL;
+	semanage_context_t *con = NULL;
+
+	if (parse_skip_space(handle, info) < 0)
+		goto err;
+	if (!info->ptr)
+		goto last;
+
+	/* Header */
+	if (parse_assert_str(handle, info, "ibendportcon") < 0)
+		goto err;
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+
+	/* IB Device Name */
+	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+		goto err;
+	if (semanage_ibendport_set_ibdev_name(handle, ibendport, str) < 0)
+		goto err;
+	free(str);
+	str = NULL;
+
+	/* Port */
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+	if (parse_fetch_int(handle, info, &port, ' ') < 0)
+		goto err;
+	semanage_ibendport_set_port(ibendport, port);
+
+	/* context */
+	if (parse_assert_space(handle, info) < 0)
+		goto err;
+	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+		goto err;
+	if (semanage_context_from_string(handle, str, &con) < 0) {
+		ERR(handle, "invalid security context \"%s\" (%s: %u)\n%s",
+		    str, info->filename, info->lineno, info->orig_line);
+		goto err;
+	}
+	if (!con) {
+		ERR(handle, "<<none>> context is not valid for ibendport (%s: %u):\n%s",
+		    info->filename, info->lineno, info->orig_line);
+		goto err;
+	}
+	free(str);
+	str = NULL;
+
+	if (semanage_ibendport_set_con(handle, ibendport, con) < 0)
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
+	ERR(handle, "could not parse ibendport record");
+	free(str);
+	semanage_context_free(con);
+	parse_dispose_line(info);
+	return STATUS_ERR;
+}
+
+/* IBENDPORT RECORD: FILE extension: method table */
+record_file_table_t SEMANAGE_IBENDPORT_FILE_RTABLE = {
+	.parse = ibendport_parse,
+	.print = ibendport_print,
+};
+
+int ibendport_file_dbase_init(semanage_handle_t *handle,
+			      const char *path_ro,
+			      const char *path_rw,
+			      dbase_config_t *dconfig)
+{
+	if (dbase_file_init(handle,
+			    path_ro,
+			    path_rw,
+			    &SEMANAGE_IBENDPORT_RTABLE,
+			    &SEMANAGE_IBENDPORT_FILE_RTABLE, &dconfig->dbase) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_FILE_DTABLE;
+	return STATUS_SUCCESS;
+}
+
+void ibendport_file_dbase_release(dbase_config_t *dconfig)
+{
+	dbase_file_release(dconfig->dbase);
+}
diff --git a/libsemanage/src/ibendports_local.c b/libsemanage/src/ibendports_local.c
new file mode 100644
index 0000000..8b5567d
--- /dev/null
+++ b/libsemanage/src/ibendports_local.c
@@ -0,0 +1,153 @@
+/* Copyright (C) 2017 Mellanox Technologies Inc */
+
+struct semanage_ibendport;
+struct semanage_ibendport_key;
+typedef struct semanage_ibendport_key record_key_t;
+typedef struct semanage_ibendport record_t;
+#define DBASE_RECORD_DEFINED
+
+#include <stdlib.h>
+#include <string.h>
+#include <sepol/policydb.h>
+#include "ibendport_internal.h"
+#include "debug.h"
+#include "handle.h"
+#include "database.h"
+
+int semanage_ibendport_modify_local(semanage_handle_t *handle,
+				    const semanage_ibendport_key_t *key,
+				    const semanage_ibendport_t *data)
+{
+	dbase_config_t *dconfig = semanage_ibendport_dbase_local(handle);
+
+	return dbase_modify(handle, dconfig, key, data);
+}
+
+int semanage_ibendport_del_local(semanage_handle_t *handle,
+				 const semanage_ibendport_key_t *key)
+{
+	dbase_config_t *dconfig = semanage_ibendport_dbase_local(handle);
+
+	return dbase_del(handle, dconfig, key);
+}
+
+int semanage_ibendport_query_local(semanage_handle_t *handle,
+				   const semanage_ibendport_key_t *key,
+				   semanage_ibendport_t **response)
+{
+	dbase_config_t *dconfig = semanage_ibendport_dbase_local(handle);
+
+	return dbase_query(handle, dconfig, key, response);
+}
+
+int semanage_ibendport_exists_local(semanage_handle_t *handle,
+				    const semanage_ibendport_key_t *key,
+				    int *response)
+{
+	dbase_config_t *dconfig = semanage_ibendport_dbase_local(handle);
+
+	return dbase_exists(handle, dconfig, key, response);
+}
+
+int semanage_ibendport_count_local(semanage_handle_t *handle,
+				   unsigned int *response)
+{
+	dbase_config_t *dconfig = semanage_ibendport_dbase_local(handle);
+
+	return dbase_count(handle, dconfig, response);
+}
+
+int semanage_ibendport_iterate_local(semanage_handle_t *handle,
+				     int (*handler)(const semanage_ibendport_t *record,
+						    void *varg), void *handler_arg)
+{
+	dbase_config_t *dconfig = semanage_ibendport_dbase_local(handle);
+	return dbase_iterate(handle, dconfig, handler, handler_arg);
+}
+
+int semanage_ibendport_list_local(semanage_handle_t *handle,
+				  semanage_ibendport_t ***records,
+				  unsigned int *count)
+{
+	dbase_config_t *dconfig = semanage_ibendport_dbase_local(handle);
+
+	return dbase_list(handle, dconfig, records, count);
+}
+
+hidden_def(semanage_ibendport_list_local)
+
+int hidden semanage_ibendport_validate_local(semanage_handle_t *handle)
+{
+	semanage_ibendport_t **ibendports = NULL;
+	unsigned int nibendports = 0;
+	unsigned int i = 0, j = 0;
+	char *ibdev_name;
+	char *ibdev_name2;
+	int port;
+	int port2;
+
+	/* List and sort the ibendports */
+	if (semanage_ibendport_list_local(handle, &ibendports, &nibendports) < 0)
+		goto err;
+
+	qsort(ibendports, nibendports, sizeof(semanage_ibendport_t *),
+	      (int (*)(const void *, const void *))
+	      &semanage_ibendport_compare2_qsort);
+
+	/* Test each ibendport */
+	while (i < nibendports) {
+		int stop = 0;
+
+		if (STATUS_SUCCESS !=
+				semanage_ibendport_get_ibdev_name(handle,
+								  ibendports[i],
+								  &ibdev_name)) {
+			ERR(handle, "Couldn't get IB device name");
+			goto err;
+		}
+
+		port = semanage_ibendport_get_port(ibendports[i]);
+
+		/* Find the first ibendport with matching
+		 * ibdev_name to compare against
+		 */
+		do {
+			if (j == nibendports - 1)
+				goto next;
+			j++;
+			if (STATUS_SUCCESS !=
+				semanage_ibendport_get_ibdev_name(handle,
+								  ibendports[j],
+								  &ibdev_name2)) {
+				ERR(handle, "Couldn't get IB device name.");
+				goto err;
+			}
+			port2 = semanage_ibendport_get_port(ibendports[j]);
+
+			stop = !strcmp(ibdev_name, ibdev_name2);
+		} while (!stop);
+
+		if (port == port2) {
+			ERR(handle, "ibendport %s/%u already exists.",
+			    ibdev_name2, port2);
+			goto invalid;
+		}
+next:
+		i++;
+		j = i;
+	}
+
+	for (i = 0; i < nibendports; i++)
+		semanage_ibendport_free(ibendports[i]);
+	free(ibendports);
+	return STATUS_SUCCESS;
+
+err:
+	ERR(handle, "could not complete ibendports validity check");
+
+invalid:
+	for (i = 0; i < nibendports; i++)
+		semanage_ibendport_free(ibendports[i]);
+	free(ibendports);
+	return STATUS_ERR;
+}
diff --git a/libsemanage/src/ibendports_policy.c b/libsemanage/src/ibendports_policy.c
new file mode 100644
index 0000000..1347b67
--- /dev/null
+++ b/libsemanage/src/ibendports_policy.c
@@ -0,0 +1,55 @@
+/* Copyright (C) 2017 Mellanox Technologies Inc */
+
+struct semanage_ibendport;
+struct semanage_ibendport_key;
+typedef struct semanage_ibendport_key record_key_t;
+typedef struct semanage_ibendport record_t;
+#define DBASE_RECORD_DEFINED
+
+#include "ibendport_internal.h"
+#include "handle.h"
+#include "database.h"
+
+int semanage_ibendport_query(semanage_handle_t *handle,
+			     const semanage_ibendport_key_t *key,
+			     semanage_ibendport_t **response)
+{
+	dbase_config_t *dconfig = semanage_ibendport_dbase_policy(handle);
+
+	return dbase_query(handle, dconfig, key, response);
+}
+
+int semanage_ibendport_exists(semanage_handle_t *handle,
+			      const semanage_ibendport_key_t *key,
+			      int *response)
+{
+	dbase_config_t *dconfig = semanage_ibendport_dbase_policy(handle);
+
+	return dbase_exists(handle, dconfig, key, response);
+}
+
+int semanage_ibendport_count(semanage_handle_t *handle,
+			     unsigned int *response)
+{
+	dbase_config_t *dconfig = semanage_ibendport_dbase_policy(handle);
+
+	return dbase_count(handle, dconfig, response);
+}
+
+int semanage_ibendport_iterate(semanage_handle_t *handle,
+			       int (*handler)(const semanage_ibendport_t *record,
+					      void *varg), void *handler_arg)
+{
+	dbase_config_t *dconfig = semanage_ibendport_dbase_policy(handle);
+
+	return dbase_iterate(handle, dconfig, handler, handler_arg);
+}
+
+int semanage_ibendport_list(semanage_handle_t *handle,
+			    semanage_ibendport_t ***records,
+			    unsigned int *count)
+{
+	dbase_config_t *dconfig = semanage_ibendport_dbase_policy(handle);
+
+	return dbase_list(handle, dconfig, records, count);
+}
diff --git a/libsemanage/src/ibendports_policydb.c b/libsemanage/src/ibendports_policydb.c
new file mode 100644
index 0000000..1029810
--- /dev/null
+++ b/libsemanage/src/ibendports_policydb.c
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
+struct semanage_ibendport;
+struct semanage_ibendport_key;
+typedef struct semanage_ibendport record_t;
+typedef struct semanage_ibendport_key record_key_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_policydb;
+typedef struct dbase_policydb dbase_t;
+#define DBASE_DEFINED
+
+#include <sepol/ibendports.h>
+#include <semanage/handle.h>
+#include "ibendport_internal.h"
+#include "debug.h"
+#include "database_policydb.h"
+#include "semanage_store.h"
+
+/* IBENDPORT RECORD (SEPOL): POLICYDB extension : method table */
+record_policydb_table_t SEMANAGE_IBENDPORT_POLICYDB_RTABLE = {
+	.add = NULL,
+	.modify = (record_policydb_table_modify_t)sepol_ibendport_modify,
+	.set = NULL,
+	.query = (record_policydb_table_query_t)sepol_ibendport_query,
+	.count = (record_policydb_table_count_t)sepol_ibendport_count,
+	.exists = (record_policydb_table_exists_t)sepol_ibendport_exists,
+	.iterate = (record_policydb_table_iterate_t)sepol_ibendport_iterate,
+};
+
+int ibendport_policydb_dbase_init(semanage_handle_t *handle,
+				  dbase_config_t *dconfig)
+{
+	if (dbase_policydb_init(handle,
+				semanage_path(SEMANAGE_ACTIVE, SEMANAGE_STORE_KERNEL),
+				semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_KERNEL),
+				&SEMANAGE_IBENDPORT_RTABLE,
+				&SEMANAGE_IBENDPORT_POLICYDB_RTABLE,
+				&dconfig->dbase) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_POLICYDB_DTABLE;
+
+	return STATUS_SUCCESS;
+}
+
+void ibendport_policydb_dbase_release(dbase_config_t *dconfig)
+{
+	dbase_policydb_release(dconfig->dbase);
+}
diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
index 041b1ce..0203669 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -19,6 +19,7 @@ LIBSEMANAGE_1.0 {
 	  semanage_user_*; semanage_bool_*; semanage_seuser_*;
 	  semanage_iface_*; semanage_port_*; semanage_context_*;
 	  semanage_ibpkey_*;
+	  semanage_ibendport_*;
 	  semanage_node_*;
 	  semanage_fcontext_*; semanage_access_check; semanage_set_create_store;
 	  semanage_is_connected; semanage_get_disable_dontaudit; semanage_set_disable_dontaudit;
diff --git a/libsemanage/src/policy_components.c b/libsemanage/src/policy_components.c
index 136c5a7..896ac51 100644
--- a/libsemanage/src/policy_components.c
+++ b/libsemanage/src/policy_components.c
@@ -140,6 +140,9 @@ int semanage_base_merge_components(semanage_handle_t * handle)
 
 		{semanage_ibpkey_dbase_local(handle),
 		 semanage_ibpkey_dbase_policy(handle), MODE_MODIFY},
+
+		{semanage_ibendport_dbase_local(handle),
+		 semanage_ibendport_dbase_policy(handle), MODE_MODIFY},
 	};
 	const unsigned int CCOUNT = sizeof(components) / sizeof(components[0]);
 
@@ -221,6 +224,7 @@ int semanage_commit_components(semanage_handle_t * handle)
 		semanage_bool_dbase_active(handle),
 		semanage_node_dbase_local(handle),
 		semanage_ibpkey_dbase_local(handle),
+		semanage_ibendport_dbase_local(handle),
 	};
 	const int CCOUNT = sizeof(components) / sizeof(components[0]);
 
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index f61f3b2..5642772 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -100,6 +100,7 @@ static const char *semanage_sandbox_paths[SEMANAGE_STORE_NUM_PATHS] = {
 	"/file_contexts.template",
 	"/commit_num",
 	"/pkeys.local",
+	"/ibendports.local",
 	"/ports.local",
 	"/interfaces.local",
 	"/nodes.local",
diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
index c7bcf44..fcaa505 100644
--- a/libsemanage/src/semanage_store.h
+++ b/libsemanage/src/semanage_store.h
@@ -45,6 +45,7 @@ enum semanage_sandbox_defs {
 	SEMANAGE_FC_TMPL,
 	SEMANAGE_COMMIT_NUM_FILE,
 	SEMANAGE_IBPKEYS_LOCAL,
+	SEMANAGE_IBENDPORTS_LOCAL,
 	SEMANAGE_PORTS_LOCAL,
 	SEMANAGE_INTERFACES_LOCAL,
 	SEMANAGE_NODES_LOCAL,
diff --git a/libsemanage/src/semanageswig.i b/libsemanage/src/semanageswig.i
index d3ca795..ebf39cf 100644
--- a/libsemanage/src/semanageswig.i
+++ b/libsemanage/src/semanageswig.i
@@ -42,6 +42,9 @@
 %include "../include/semanage/ibpkey_record.h"
 %include "../include/semanage/ibpkeys_local.h"
 %include "../include/semanage/ibpkeys_policy.h"
+%include "../include/semanage/ibendport_record.h"
+%include "../include/semanage/ibendports_local.h"
+%include "../include/semanage/ibendports_policy.h"
 %include "../include/semanage/fcontext_record.h"
 %include "../include/semanage/fcontexts_local.h"
 %include "../include/semanage/fcontexts_policy.h"
diff --git a/libsemanage/src/semanageswig_python.i b/libsemanage/src/semanageswig_python.i
index 40932d8..8604b8a 100644
--- a/libsemanage/src/semanageswig_python.i
+++ b/libsemanage/src/semanageswig_python.i
@@ -480,6 +480,49 @@
 	$1 = &temp;
 }
 
+/** ibendport typemaps **/
+
+/* the wrapper will setup this parameter for passing... the resulting python functions
+   will not take the semanage_ibendport_t *** parameter */
+%typemap(in, numinputs=0) semanage_ibendport_t ***(semanage_ibendport_t **temp=NULL) {
+	$1 = &temp;
+}
+
+%typemap(argout) (
+	semanage_handle_t* handle,
+	semanage_ibendport_t*** records,
+	unsigned int* count) {
+
+	if ($result) {
+		int value;
+		SWIG_AsVal_int($result, &value);
+		if (value >= 0) {
+			PyObject* plist = NULL;
+			if (semanage_array2plist($1, (void**) *$2, *$3, SWIGTYPE_p_semanage_ibendport,
+				(void (*) (void*)) &semanage_ibendport_free, &plist) < 0)
+				$result = SWIG_From_int(STATUS_ERR);
+			else
+				$result = SWIG_Python_AppendOutput($result, plist);
+		}
+	}
+}
+
+%typemap(in, numinputs=0) semanage_ibendport_t **(semanage_ibendport_t *temp=NULL) {
+	$1 = &temp;
+}
+
+%typemap(argout) semanage_ibendport_t ** {
+	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+}
+
+%typemap(argout) semanage_ibendport_key_t ** {
+	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
+}
+
+%typemap(in, numinputs=0) semanage_ibendport_key_t **(semanage_ibendport_key_t *temp=NULL) {
+	$1 = &temp;
+}
+
 /** node typemaps **/
 
 /* the wrapper will setup this parameter for passing... the resulting python functions
diff --git a/libsemanage/utils/semanage_migrate_store b/libsemanage/utils/semanage_migrate_store
index 325de47..9a9fac2 100755
--- a/libsemanage/utils/semanage_migrate_store
+++ b/libsemanage/utils/semanage_migrate_store
@@ -254,7 +254,8 @@ if __name__ == "__main__":
 		"policy.kern",
 		"file_contexts",
 		"homedir_template",
-                "pkeys.local"]
+                "pkeys.local",
+                "ibendports.local"]
 
 
 	create_dir(newroot_path(), 0o755)
diff --git a/libsepol/include/sepol/ibendport_record.h b/libsepol/include/sepol/ibendport_record.h
new file mode 100644
index 0000000..e30b252
--- /dev/null
+++ b/libsepol/include/sepol/ibendport_record.h
@@ -0,0 +1,68 @@
+#ifndef _SEPOL_IBENDPORT_RECORD_H_
+#define _SEPOL_IBENDPORT_RECORD_H_
+
+#include <stddef.h>
+#include <sepol/context_record.h>
+#include <sepol/handle.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
+
+struct sepol_ibendport;
+struct sepol_ibendport_key;
+typedef struct sepol_ibendport sepol_ibendport_t;
+typedef struct sepol_ibendport_key sepol_ibendport_key_t;
+
+extern int sepol_ibendport_compare(const sepol_ibendport_t *ibendport,
+				   const sepol_ibendport_key_t *key);
+
+extern int sepol_ibendport_compare2(const sepol_ibendport_t *ibendport,
+				    const sepol_ibendport_t *ibendport2);
+
+extern int sepol_ibendport_key_create(sepol_handle_t *handle,
+				      const char *ibdev_name,
+				      int port,
+				      sepol_ibendport_key_t **key_ptr);
+
+extern void sepol_ibendport_key_unpack(const sepol_ibendport_key_t *key,
+				       const char **ibdev_name,
+				       int *port);
+
+extern int sepol_ibendport_alloc_ibdev_name(sepol_handle_t *handle,
+					    char **ibdev_name);
+
+extern int sepol_ibendport_key_extract(sepol_handle_t *handle,
+				       const sepol_ibendport_t *ibendport,
+				       sepol_ibendport_key_t **key_ptr);
+
+extern void sepol_ibendport_key_free(sepol_ibendport_key_t *key);
+
+extern void sepol_ibendport_set_port(sepol_ibendport_t *ibendport, int port);
+
+extern int sepol_ibendport_get_port(const sepol_ibendport_t *ibendport);
+
+extern int sepol_ibendport_get_ibdev_name(sepol_handle_t *handle,
+					  const sepol_ibendport_t *ibendport,
+					  char **ibdev_name);
+
+extern int sepol_ibendport_set_ibdev_name(sepol_handle_t *handle,
+					  sepol_ibendport_t *ibendport,
+					  const char *ibdev_name);
+
+extern sepol_context_t *sepol_ibendport_get_con(const sepol_ibendport_t *ibendport);
+
+extern int sepol_ibendport_set_con(sepol_handle_t *handle,
+				   sepol_ibendport_t *ibendport,
+				   sepol_context_t *con);
+
+extern int sepol_ibendport_create(sepol_handle_t *handle,
+				  sepol_ibendport_t **ibendport_ptr);
+
+extern int sepol_ibendport_clone(sepol_handle_t *handle,
+				 const sepol_ibendport_t *ibendport,
+				 sepol_ibendport_t **ibendport_ptr);
+
+extern void sepol_ibendport_free(sepol_ibendport_t *ibendport);
+
+__END_DECLS
+#endif
diff --git a/libsepol/include/sepol/ibendports.h b/libsepol/include/sepol/ibendports.h
new file mode 100644
index 0000000..4a89e0c
--- /dev/null
+++ b/libsepol/include/sepol/ibendports.h
@@ -0,0 +1,45 @@
+#ifndef _SEPOL_IBENDPORTS_H_
+#define _SEPOL_IBENDPORTS_H_
+
+#include <sepol/handle.h>
+#include <sepol/policydb.h>
+#include <sepol/ibendport_record.h>
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
+
+/* Return the number of ibendports */
+extern int sepol_ibendport_count(sepol_handle_t *handle,
+				 const sepol_policydb_t *p,
+				 unsigned int *response);
+
+/* Check if a ibendport exists */
+extern int sepol_ibendport_exists(sepol_handle_t *handle,
+				  const sepol_policydb_t *policydb,
+				  const sepol_ibendport_key_t *key, int *response);
+
+/* Query a ibendport - returns the ibendport, or NULL if not found */
+extern int sepol_ibendport_query(sepol_handle_t *handle,
+				 const sepol_policydb_t *policydb,
+				 const sepol_ibendport_key_t *key,
+				 sepol_ibendport_t **response);
+
+/* Modify a ibendport, or add it, if the key is not found */
+extern int sepol_ibendport_modify(sepol_handle_t *handle,
+				  sepol_policydb_t *policydb,
+				  const sepol_ibendport_key_t *key,
+				  const sepol_ibendport_t *data);
+
+/* Iterate the ibendports
+ * The handler may return:
+ * -1 to signal an error condition,
+ * 1 to signal successful exit
+ * 0 to signal continue
+ */
+extern int sepol_ibendport_iterate(sepol_handle_t *handle,
+				   const sepol_policydb_t *policydb,
+				   int (*fn)(const sepol_ibendport_t *ibendport,
+					     void *fn_arg), void *arg);
+
+__END_DECLS
+#endif
diff --git a/libsepol/include/sepol/sepol.h b/libsepol/include/sepol/sepol.h
index 540f01d..540609a 100644
--- a/libsepol/include/sepol/sepol.h
+++ b/libsepol/include/sepol/sepol.h
@@ -12,6 +12,7 @@ extern "C" {
 #include <sepol/context_record.h>
 #include <sepol/iface_record.h>
 #include <sepol/ibpkey_record.h>
+#include <sepol/ibendport_record.h>
 #include <sepol/port_record.h>
 #include <sepol/boolean_record.h>
 #include <sepol/node_record.h>
@@ -19,6 +20,7 @@ extern "C" {
 #include <sepol/booleans.h>
 #include <sepol/interfaces.h>
 #include <sepol/ibpkeys.h>
+#include <sepol/ibendports.h>
 #include <sepol/ports.h>
 #include <sepol/nodes.h>
 #include <sepol/users.h>
diff --git a/libsepol/src/ibendport_internal.h b/libsepol/src/ibendport_internal.h
new file mode 100644
index 0000000..6c3df93
--- /dev/null
+++ b/libsepol/src/ibendport_internal.h
@@ -0,0 +1,20 @@
+#ifndef _SEPOL_IBENDPORT_INTERNAL_H_
+#define _SEPOL_IBENDPORT_INTERNAL_H_
+
+#include <sepol/ibendport_record.h>
+#include <sepol/ibendports.h>
+#include "dso.h"
+
+#define IB_DEVICE_NAME_MAX 64
+
+hidden_proto(sepol_ibendport_create)
+hidden_proto(sepol_ibendport_free)
+hidden_proto(sepol_ibendport_get_con)
+hidden_proto(sepol_ibendport_get_port)
+hidden_proto(sepol_ibendport_key_create)
+hidden_proto(sepol_ibendport_key_unpack)
+hidden_proto(sepol_ibendport_set_con)
+hidden_proto(sepol_ibendport_set_port)
+hidden_proto(sepol_ibendport_get_ibdev_name)
+hidden_proto(sepol_ibendport_set_ibdev_name)
+#endif
diff --git a/libsepol/src/ibendport_record.c b/libsepol/src/ibendport_record.c
new file mode 100644
index 0000000..3f302fe
--- /dev/null
+++ b/libsepol/src/ibendport_record.c
@@ -0,0 +1,299 @@
+#include <stdlib.h>
+#include <string.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include <errno.h>
+
+#include "ibendport_internal.h"
+#include "context_internal.h"
+#include "debug.h"
+
+#define IB_DEVICE_NAME_MAX 64
+
+struct sepol_ibendport {
+	/* Device Name */
+	char *ibdev_name;
+
+	/* Port number */
+	int port;
+
+	/* Context */
+	sepol_context_t *con;
+};
+
+struct sepol_ibendport_key {
+	/* Device Name */
+	char *ibdev_name;
+
+	/* Port number */
+	int port;
+};
+
+/* Allocates a sufficiently large string (ibdev_name) */
+int sepol_ibendport_alloc_ibdev_name(sepol_handle_t *handle,
+				     char **ibdev_name)
+{
+	char *tmp_ibdev_name = NULL;
+
+	tmp_ibdev_name = calloc(1, IB_DEVICE_NAME_MAX);
+
+	if (!tmp_ibdev_name)
+		goto omem;
+
+	*ibdev_name = tmp_ibdev_name;
+	return STATUS_SUCCESS;
+
+omem:
+	ERR(handle, "out of memory");
+	ERR(handle, "could not allocate string buffer for ibdev_name");
+	return STATUS_ERR;
+}
+
+/* Key */
+int sepol_ibendport_key_create(sepol_handle_t *handle,
+			       const char *ibdev_name,
+			       int port,
+			       sepol_ibendport_key_t **key_ptr)
+{
+	sepol_ibendport_key_t *tmp_key =
+	    (sepol_ibendport_key_t *)malloc(sizeof(sepol_ibendport_key_t));
+
+	if (!tmp_key) {
+		ERR(handle, "out of memory, could not create ibendport key");
+		goto omem;
+	}
+
+	if (sepol_ibendport_alloc_ibdev_name(handle, &tmp_key->ibdev_name) < 0)
+		goto err;
+
+	strncpy(tmp_key->ibdev_name, ibdev_name, IB_DEVICE_NAME_MAX);
+	tmp_key->port = port;
+
+	*key_ptr = tmp_key;
+	return STATUS_SUCCESS;
+
+omem:
+	ERR(handle, "out of memory");
+
+err:
+	sepol_ibendport_key_free(tmp_key);
+	ERR(handle, "could not create ibendport key for IB device %s, port %u",
+	    ibdev_name, port);
+	return STATUS_ERR;
+}
+
+hidden_def(sepol_ibendport_key_create)
+
+void sepol_ibendport_key_unpack(const sepol_ibendport_key_t *key,
+				const char **ibdev_name, int *port)
+{
+	*ibdev_name = key->ibdev_name;
+	*port = key->port;
+}
+
+hidden_def(sepol_ibendport_key_unpack)
+
+int sepol_ibendport_key_extract(sepol_handle_t *handle,
+				const sepol_ibendport_t *ibendport,
+				sepol_ibendport_key_t **key_ptr)
+{
+	if (sepol_ibendport_key_create
+	    (handle, ibendport->ibdev_name, ibendport->port, key_ptr) < 0) {
+		ERR(handle, "could not extract key from ibendport device %s port %d",
+		    ibendport->ibdev_name,
+		    ibendport->port);
+
+		return STATUS_ERR;
+	}
+
+	return STATUS_SUCCESS;
+}
+
+void sepol_ibendport_key_free(sepol_ibendport_key_t *key)
+{
+	if (!key)
+		return;
+	free(key->ibdev_name);
+	free(key);
+}
+
+int sepol_ibendport_compare(const sepol_ibendport_t *ibendport, const sepol_ibendport_key_t *key)
+{
+	int rc;
+
+	rc = strncmp(ibendport->ibdev_name, key->ibdev_name, IB_DEVICE_NAME_MAX);
+
+	if ((ibendport->port == key->port) && !rc)
+		return 0;
+
+	if (ibendport->port < key->port)
+		return -1;
+	else if (key->port < ibendport->port)
+		return 1;
+	else
+		return rc;
+}
+
+int sepol_ibendport_compare2(const sepol_ibendport_t *ibendport, const sepol_ibendport_t *ibendport2)
+{
+	int rc;
+
+	rc = strncmp(ibendport->ibdev_name, ibendport2->ibdev_name, IB_DEVICE_NAME_MAX);
+
+	if ((ibendport->port == ibendport2->port) && !rc)
+		return 0;
+
+	if (ibendport->port < ibendport2->port)
+		return -1;
+	else if (ibendport2->port < ibendport->port)
+		return 1;
+	else
+		return rc;
+}
+
+int sepol_ibendport_get_port(const sepol_ibendport_t *ibendport)
+{
+	return ibendport->port;
+}
+
+hidden_def(sepol_ibendport_get_port)
+
+void sepol_ibendport_set_port(sepol_ibendport_t *ibendport, int port)
+{
+	ibendport->port = port;
+}
+
+hidden_def(sepol_ibendport_set_port)
+
+int sepol_ibendport_get_ibdev_name(sepol_handle_t *handle,
+				   const sepol_ibendport_t *ibendport,
+				   char **ibdev_name)
+{
+	char *tmp_ibdev_name = NULL;
+
+	if (sepol_ibendport_alloc_ibdev_name(handle, &tmp_ibdev_name) < 0)
+		goto err;
+
+	strncpy(tmp_ibdev_name, ibendport->ibdev_name, IB_DEVICE_NAME_MAX);
+	*ibdev_name = tmp_ibdev_name;
+	return STATUS_SUCCESS;
+
+err:
+	free(tmp_ibdev_name);
+	ERR(handle, "could not get ibendport ibdev_name");
+	return STATUS_ERR;
+}
+
+hidden_def(sepol_ibendport_get_ibdev_name)
+
+int sepol_ibendport_set_ibdev_name(sepol_handle_t *handle,
+				   sepol_ibendport_t *ibendport,
+				   const char *ibdev_name)
+{
+	char *tmp = NULL;
+
+	if (sepol_ibendport_alloc_ibdev_name(handle, &tmp) < 0)
+		goto err;
+
+	strncpy(tmp, ibdev_name, IB_DEVICE_NAME_MAX);
+	free(ibendport->ibdev_name);
+	ibendport->ibdev_name = tmp;
+	return STATUS_SUCCESS;
+
+err:
+	free(tmp);
+	ERR(handle, "could not set ibendport subnet prefix to %s", ibdev_name);
+	return STATUS_ERR;
+}
+
+hidden_def(sepol_ibendport_set_ibdev_name)
+
+/* Create */
+int sepol_ibendport_create(sepol_handle_t *handle, sepol_ibendport_t **ibendport)
+{
+	sepol_ibendport_t *tmp_ibendport = (sepol_ibendport_t *)malloc(sizeof(sepol_ibendport_t));
+
+	if (!tmp_ibendport) {
+		ERR(handle, "out of memory, could not create ibendport record");
+		return STATUS_ERR;
+	}
+
+	tmp_ibendport->ibdev_name = NULL;
+	tmp_ibendport->port = 0;
+	tmp_ibendport->con = NULL;
+	*ibendport = tmp_ibendport;
+
+	return STATUS_SUCCESS;
+}
+
+hidden_def(sepol_ibendport_create)
+
+/* Deep copy clone */
+int sepol_ibendport_clone(sepol_handle_t *handle,
+			  const sepol_ibendport_t *ibendport,
+			  sepol_ibendport_t **ibendport_ptr)
+{
+	sepol_ibendport_t *new_ibendport = NULL;
+
+	if (sepol_ibendport_create(handle, &new_ibendport) < 0)
+		goto err;
+
+	if (sepol_ibendport_alloc_ibdev_name(handle, &new_ibendport->ibdev_name) < 0)
+		goto omem;
+
+	strncpy(new_ibendport->ibdev_name, ibendport->ibdev_name, IB_DEVICE_NAME_MAX);
+	new_ibendport->port = ibendport->port;
+
+	if (ibendport->con &&
+	    (sepol_context_clone(handle, ibendport->con, &new_ibendport->con) < 0))
+		goto err;
+
+	*ibendport_ptr = new_ibendport;
+	return STATUS_SUCCESS;
+
+omem:
+	ERR(handle, "out of memory");
+
+err:
+	ERR(handle, "could not clone ibendport record");
+	sepol_ibendport_free(new_ibendport);
+	return STATUS_ERR;
+}
+
+/* Destroy */
+void sepol_ibendport_free(sepol_ibendport_t *ibendport)
+{
+	if (!ibendport)
+		return;
+
+	free(ibendport->ibdev_name);
+	sepol_context_free(ibendport->con);
+	free(ibendport);
+}
+
+hidden_def(sepol_ibendport_free)
+
+/* Context */
+sepol_context_t *sepol_ibendport_get_con(const sepol_ibendport_t *ibendport)
+{
+	return ibendport->con;
+}
+
+hidden_def(sepol_ibendport_get_con)
+
+int sepol_ibendport_set_con(sepol_handle_t *handle,
+			    sepol_ibendport_t *ibendport, sepol_context_t *con)
+{
+	sepol_context_t *newcon;
+
+	if (sepol_context_clone(handle, con, &newcon) < 0) {
+		ERR(handle, "out of memory, could not set ibendport context");
+		return STATUS_ERR;
+	}
+
+	sepol_context_free(ibendport->con);
+	ibendport->con = newcon;
+	return STATUS_SUCCESS;
+}
+
+hidden_def(sepol_ibendport_set_con)
diff --git a/libsepol/src/ibendports.c b/libsepol/src/ibendports.c
new file mode 100644
index 0000000..636503b
--- /dev/null
+++ b/libsepol/src/ibendports.c
@@ -0,0 +1,255 @@
+#include <netinet/in.h>
+#include <stdlib.h>
+
+#include "debug.h"
+#include "context.h"
+#include "handle.h"
+
+#include <sepol/policydb/policydb.h>
+#include "ibendport_internal.h"
+
+/* Create a low level ibendport structure from
+ * a high level representation
+ */
+static int ibendport_from_record(sepol_handle_t *handle,
+				 const policydb_t *policydb,
+				 ocontext_t **ibendport,
+				 const sepol_ibendport_t *data)
+{
+	ocontext_t *tmp_ibendport = NULL;
+	context_struct_t *tmp_con = NULL;
+	char *ibdev_name = NULL;
+	int port = sepol_ibendport_get_port(data);
+
+	tmp_ibendport = (ocontext_t *)calloc(1, sizeof(ocontext_t));
+	if (!tmp_ibendport)
+		goto omem;
+
+	if (sepol_ibendport_alloc_ibdev_name(handle,
+					     &tmp_ibendport->u.ibendport.dev_name) < 0)
+		goto omem;
+
+	if (sepol_ibendport_get_ibdev_name(handle,
+					   data,
+					   &ibdev_name) < 0)
+		goto err;
+
+	strncpy(tmp_ibendport->u.ibendport.dev_name, ibdev_name, IB_DEVICE_NAME_MAX);
+
+	free(ibdev_name);
+	ibdev_name = NULL;
+
+	tmp_ibendport->u.ibendport.port = port;
+
+	/* Context */
+	if (context_from_record(handle, policydb, &tmp_con,
+				sepol_ibendport_get_con(data)) < 0)
+		goto err;
+	context_cpy(&tmp_ibendport->context[0], tmp_con);
+	context_destroy(tmp_con);
+	free(tmp_con);
+	tmp_con = NULL;
+
+	*ibendport = tmp_ibendport;
+	return STATUS_SUCCESS;
+
+omem:
+	ERR(handle, "out of memory");
+
+err:
+	if (tmp_ibendport) {
+		context_destroy(&tmp_ibendport->context[0]);
+		free(tmp_ibendport);
+	}
+	context_destroy(tmp_con);
+	free(tmp_con);
+	free(ibdev_name);
+	ERR(handle, "could not create ibendport structure");
+	return STATUS_ERR;
+}
+
+static int ibendport_to_record(sepol_handle_t *handle,
+			       const policydb_t *policydb,
+			       ocontext_t *ibendport,
+			       sepol_ibendport_t **record)
+{
+	int port = ibendport->u.ibendport.port;
+	context_struct_t *con = &ibendport->context[0];
+
+	sepol_context_t *tmp_con = NULL;
+	sepol_ibendport_t *tmp_record = NULL;
+
+	if (sepol_ibendport_create(handle, &tmp_record) < 0)
+		goto err;
+
+	if (sepol_ibendport_set_ibdev_name(handle, tmp_record,
+					   ibendport->u.ibendport.dev_name) < 0)
+		goto err;
+
+	sepol_ibendport_set_port(tmp_record, port);
+
+	if (context_to_record(handle, policydb, con, &tmp_con) < 0)
+		goto err;
+
+	if (sepol_ibendport_set_con(handle, tmp_record, tmp_con) < 0)
+		goto err;
+
+	sepol_context_free(tmp_con);
+	*record = tmp_record;
+	return STATUS_SUCCESS;
+
+err:
+	ERR(handle, "could not convert ibendport to record");
+	sepol_context_free(tmp_con);
+	sepol_ibendport_free(tmp_record);
+	return STATUS_ERR;
+}
+
+/* Return the number of ibendports */
+extern int sepol_ibendport_count(sepol_handle_t *handle __attribute__ ((unused)),
+				 const sepol_policydb_t *p, unsigned int *response)
+{
+	unsigned int count = 0;
+	ocontext_t *c, *head;
+	const policydb_t *policydb = &p->p;
+
+	head = policydb->ocontexts[OCON_IBENDPORT];
+	for (c = head; c; c = c->next)
+		count++;
+
+	*response = count;
+
+	handle = NULL;
+	return STATUS_SUCCESS;
+}
+
+/* Check if a ibendport exists */
+int sepol_ibendport_exists(sepol_handle_t *handle __attribute__ ((unused)),
+			   const sepol_policydb_t *p,
+			   const sepol_ibendport_key_t *key, int *response)
+{
+	const policydb_t *policydb = &p->p;
+	ocontext_t *c, *head;
+	int port;
+	const char *ibdev_name;
+
+	sepol_ibendport_key_unpack(key, &ibdev_name, &port);
+
+	head = policydb->ocontexts[OCON_IBENDPORT];
+	for (c = head; c; c = c->next) {
+		const char *ibdev_name2 = c->u.ibendport.dev_name;
+		int port2 = c->u.ibendport.port;
+
+		if (port2 == port &&
+		    (!strncmp(ibdev_name, ibdev_name2, IB_DEVICE_NAME_MAX))) {
+			*response = 1;
+			return STATUS_SUCCESS;
+		}
+	}
+
+	*response = 0;
+	return STATUS_SUCCESS;
+}
+
+int sepol_ibendport_query(sepol_handle_t *handle,
+			  const sepol_policydb_t *p,
+			  const sepol_ibendport_key_t *key,
+			  sepol_ibendport_t **response)
+{
+	const policydb_t *policydb = &p->p;
+	ocontext_t *c, *head;
+	int port;
+	const char *ibdev_name;
+
+	sepol_ibendport_key_unpack(key, &ibdev_name, &port);
+
+	head = policydb->ocontexts[OCON_IBENDPORT];
+	for (c = head; c; c = c->next) {
+		const char *ibdev_name2 = c->u.ibendport.dev_name;
+		int port2 = c->u.ibendport.port;
+
+		if (port2 == port &&
+		    (!strncmp(ibdev_name, ibdev_name2, IB_DEVICE_NAME_MAX))) {
+			if (ibendport_to_record(handle, policydb, c, response) < 0)
+				goto err;
+			return STATUS_SUCCESS;
+		}
+	}
+
+	*response = NULL;
+	return STATUS_SUCCESS;
+
+err:
+	ERR(handle, "could not query ibendport, IB device: %s port %u",
+	    ibdev_name, port);
+	return STATUS_ERR;
+}
+
+/* Load a ibendport into policy */
+int sepol_ibendport_modify(sepol_handle_t *handle,
+			   sepol_policydb_t *p,
+			   const sepol_ibendport_key_t *key,
+			   const sepol_ibendport_t *data)
+{
+	policydb_t *policydb = &p->p;
+	ocontext_t *ibendport = NULL;
+	int port;
+	const char *ibdev_name;
+
+	sepol_ibendport_key_unpack(key, &ibdev_name, &port);
+
+	if (ibendport_from_record(handle, policydb, &ibendport, data) < 0)
+		goto err;
+
+	/* Attach to context list */
+	ibendport->next = policydb->ocontexts[OCON_IBENDPORT];
+	policydb->ocontexts[OCON_IBENDPORT] = ibendport;
+
+	return STATUS_SUCCESS;
+
+err:
+	ERR(handle, "could not load ibendport %s/%d",
+	    ibdev_name, port);
+	if (ibendport) {
+		context_destroy(&ibendport->context[0]);
+		free(ibendport);
+	}
+	return STATUS_ERR;
+}
+
+int sepol_ibendport_iterate(sepol_handle_t *handle,
+			    const sepol_policydb_t *p,
+			    int (*fn)(const sepol_ibendport_t *ibendport,
+				      void *fn_arg), void *arg)
+{
+	const policydb_t *policydb = &p->p;
+	ocontext_t *c, *head;
+	sepol_ibendport_t *ibendport = NULL;
+
+	head = policydb->ocontexts[OCON_IBENDPORT];
+	for (c = head; c; c = c->next) {
+		int status;
+
+		if (ibendport_to_record(handle, policydb, c, &ibendport) < 0)
+			goto err;
+
+		/* Invoke handler */
+		status = fn(ibendport, arg);
+		if (status < 0)
+			goto err;
+
+		sepol_ibendport_free(ibendport);
+		ibendport = NULL;
+
+		/* Handler requested exit */
+		if (status > 0)
+			break;
+	}
+
+	return STATUS_SUCCESS;
+
+err:
+	ERR(handle, "could not iterate over ibendports");
+	sepol_ibendport_free(ibendport);
+	return STATUS_ERR;
+}
diff --git a/python/semanage/semanage b/python/semanage/semanage
index 11b56e2..313537c 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -61,6 +61,9 @@ usage_port_dict = {' --add': ('-t TYPE', '-p PROTOCOL', '-r RANGE', '(', 'port_n
 usage_ibpkey = "semanage ibpkey [-h] [-n] [-N] [-s STORE] ["
 usage_ibpkey_dict = {' --add': ('-t TYPE', '-x SUBNET_PREFIX', '-r RANGE', '(', 'ibpkey_name', '|', 'pkey_range', ')'), ' --modify': ('-t TYPE', '-x SUBNET_PREFIX', '-r RANGE', '(', 'ibpkey_name', '|', 'pkey_range', ')'), ' --delete': ('-x SUBNET_PREFIX', '(', 'ibpkey_name', '|', 'pkey_range', ')'), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
 
+usage_ibendport = "semanage ibendport [-h] [-n] [-N] [-s STORE] ["
+usage_ibendport_dict = {' --add': ('-t TYPE', '-z IBDEV_NAME', '-r RANGE', '(', 'port', ')'), ' --modify': ('-t TYPE', '-z IBDEV_NAME', '-r RANGE', '(', 'port', ')'), ' --delete': ('-z IBDEV_NAME', '-r RANGE''(', 'port', ')'), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
+
 usage_node = "semanage node [-h] [-n] [-N] [-S STORE] ["
 usage_node_dict = {' --add': ('-M NETMASK', '-p PROTOCOL', '-t TYPE', '-r RANGE', 'node'), ' --modify': ('-M NETMASK', '-p PROTOCOL', '-t TYPE', '-r RANGE', 'node'), ' --delete': ('-M NETMASK', '-p PROTOCOL', 'node'), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
 
@@ -152,6 +155,10 @@ def ibpkey_ini():
     OBJECT = seobject.ibpkeyRecords(store)
     return OBJECT
 
+def ibendport_ini():
+    OBJECT = seobject.ibendportRecords(store)
+    return OBJECT
+
 def module_ini():
     OBJECT = seobject.moduleRecords(store)
     return OBJECT
@@ -187,8 +194,7 @@ def dontaudit_ini():
     return OBJECT
 
 # define dictonary for seobject OBEJCTS
-object_dict = {'login': login_ini, 'user': user_ini, 'port': port_ini, 'module': module_ini, 'interface': interface_ini, 'node': node_ini, 'fcontext': fcontext_ini, 'boolean': boolean_ini, 'permissive': permissive_ini, 'dontaudit': dontaudit_ini, 'ibpkey': ibpkey_ini}
-
+object_dict = {'login': login_ini, 'user': user_ini, 'port': port_ini, 'module': module_ini, 'interface': interface_ini, 'node': node_ini, 'fcontext': fcontext_ini, 'boolean': boolean_ini, 'permissive': permissive_ini, 'dontaudit': dontaudit_ini, 'ibpkey': ibpkey_ini, 'ibendport': ibendport_ini}
 
 def generate_custom_usage(usage_text, usage_dict):
     # generate custom usage from given text and dictonary
@@ -303,6 +309,10 @@ def parser_add_subnet_prefix(parser, name):
     Subnet prefix for  the specified infiniband ibpkey.
 '''))
 
+def parser_add_ibdev_name(parser, name):
+    parser.add_argument('-z', '--ibdev_name', help=_('''
+    Name for the specified infiniband end port.
+'''))
 
 def parser_add_modify(parser, name):
     parser.add_argument('-m', '--modify', dest='action', action='store_const', const='modify', help=_("Modify a record of the %s object type") % name)
@@ -567,6 +577,49 @@ def setupPkeyParser(subparsers):
     ibpkeyParser.add_argument('ibpkey', nargs='?', default=None, help=_('pkey | pkey_range'))
     ibpkeyParser.set_defaults(func=handlePkey)
 
+def handleIbendport(args):
+    ibendport_args = {'list': [('ibendport', 'type', 'ibdev_name'), ('')], 'add': [('locallist'), ('type', 'ibendport', 'ibdev_name'), ('')], 'modify': [('localist'), ('ibendport', 'ibdev_name')], 'delete': [('locallist'), ('ibendport', 'ibdev_name')], 'extract': [('locallist', 'ibendport', 'type', 'ibdev_name'), ('')], 'deleteall': [('locallist'), ('')]}
+
+    handle_opts(args, ibendport_args, args.action)
+
+    OBJECT = object_dict['ibendport']()
+    OBJECT.set_reload(args.noreload)
+
+    if args.action is "add":
+        OBJECT.add(args.ibendport, args.ibdev_name, args.range, args.type)
+    if args.action is "modify":
+        OBJECT.modify(args.ibendport, args.ibdev_name, args.range, args.type)
+    if args.action is "delete":
+        OBJECT.delete(args.ibendport, args.ibdev_name)
+    if args.action is "list":
+        OBJECT.list(args.noheading, args.locallist)
+    if args.action is "deleteall":
+        OBJECT.deleteall()
+    if args.action is "extract":
+        for i in OBJECT.customized():
+            print("ibendport %s" % str(i))
+
+
+def setupIbendportParser(subparsers):
+    generated_usage = generate_custom_usage(usage_ibendport, usage_ibendport_dict)
+    ibendportParser = subparsers.add_parser('ibendport', usage=generated_usage, help=_('Manage infiniband end port type definitions'))
+    parser_add_locallist(ibendportParser, "ibendport")
+    parser_add_noheading(ibendportParser, "ibendport")
+    parser_add_noreload(ibendportParser, "ibendport")
+    parser_add_store(ibendportParser, "ibendport")
+
+    ibendport_action = ibendportParser.add_mutually_exclusive_group(required=True)
+    parser_add_add(ibendport_action, "ibendport")
+    parser_add_delete(ibendport_action, "ibendport")
+    parser_add_modify(ibendport_action, "ibendport")
+    parser_add_list(ibendport_action, "ibendport")
+    parser_add_extract(ibendport_action, "ibendport")
+    parser_add_deleteall(ibendport_action, "ibendport")
+    parser_add_type(ibendportParser, "ibendport")
+    parser_add_range(ibendportParser, "ibendport")
+    parser_add_ibdev_name(ibendportParser, "ibendport")
+    ibendportParser.add_argument('ibendport', nargs='?', default=None, help=_('ibendport'))
+    ibendportParser.set_defaults(func=handleIbendport)
 
 def handleInterface(args):
     interface_args = {'list': [('interface'), ('')], 'add': [('locallist'), ('type', 'interface')], 'modify': [('locallist'), ('type', 'interface')], 'delete': [('locallist'), ('interface')], 'extract': [('locallist', 'interface', 'type'), ('')], 'deleteall': [('locallist'), ('')]}
@@ -907,6 +960,7 @@ def createCommandParser():
     setupUserParser(subparsers)
     setupPortParser(subparsers)
     setupPkeyParser(subparsers)
+    setupIbendportParser(subparsers)
     setupInterfaceParser(subparsers)
     setupModuleParser(subparsers)
     setupNodeParser(subparsers)
diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 02ad9f3..895becd 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -1563,6 +1563,244 @@ class ibpkeyRecords(semanageRecords):
                 rec += ", %s" % p
             print rec
 
+class ibendportRecords(semanageRecords):
+    try:
+        valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "ibendport_type"))[0]["types"])
+    except RuntimeError:
+        valid_types = []
+
+    def __init__(self, store=""):
+        semanageRecords.__init__(self, store)
+
+    def __genkey(self, ibendport, ibdev_name):
+	if ibdev_name == "":
+            raise ValueError(_("IB device name is required"))
+
+        port = int(ibendport)
+
+        if port > 255 or port < 1:
+            raise ValueError(_("Invalid Port Number"))
+
+        (rc, k) = semanage_ibendport_key_create(self.sh, ibdev_name, port)
+        if rc < 0:
+            raise ValueError(_("Could not create a key for ibendport %s/%s") % (ibdev_name, ibendport))
+        return (k, ibdev_name, port)
+
+    def __add(self, ibendport, ibdev_name, serange, type):
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
+            raise ValueError(_("Type %s is invalid, must be an ibendport type") % type)
+        (k, ibendport, port) = self.__genkey(ibendport, ibdev_name)
+
+        (rc, exists) = semanage_ibendport_exists(self.sh, k)
+        if rc < 0:
+            raise ValueError(_("Could not check if ibendport %s/%s is defined") % (ibdev_name, port))
+        if exists:
+            raise ValueError(_("ibendport %s/%s already defined") % (ibdev_name, port))
+
+        (rc, p) = semanage_ibendport_create(self.sh)
+        if rc < 0:
+            raise ValueError(_("Could not create ibendport for %s/%s") % (ibdev_name, port))
+
+        semanage_ibendport_set_ibdev_name(self.sh, p, ibdev_name)
+        semanage_ibendport_set_port(p, port)
+        (rc, con) = semanage_context_create(self.sh)
+        if rc < 0:
+            raise ValueError(_("Could not create context for %s/%s") % (ibdev_name, port))
+
+        rc = semanage_context_set_user(self.sh, con, "system_u")
+        if rc < 0:
+            raise ValueError(_("Could not set user in ibendport context for %s/%s") % (ibdev_name, port))
+
+        rc = semanage_context_set_role(self.sh, con, "object_r")
+        if rc < 0:
+            raise ValueError(_("Could not set role in ibendport context for %s/%s") % (ibdev_name, port))
+
+        rc = semanage_context_set_type(self.sh, con, type)
+        if rc < 0:
+            raise ValueError(_("Could not set type in ibendport context for %s/%s") % (ibdev_name, port))
+
+        if (is_mls_enabled == 1) and (serange != ""):
+            rc = semanage_context_set_mls(self.sh, con, serange)
+            if rc < 0:
+                raise ValueError(_("Could not set mls fields in ibendport context for %s/%s") % (ibdev_name, port))
+
+        rc = semanage_ibendport_set_con(self.sh, p, con)
+        if rc < 0:
+            raise ValueError(_("Could not set ibendport context for %s/%s") % (ibdev_name, port))
+
+        rc = semanage_ibendport_modify_local(self.sh, k, p)
+        if rc < 0:
+            raise ValueError(_("Could not add ibendport %s/%s") % (ibdev_name, port))
+
+        semanage_context_free(con)
+        semanage_ibendport_key_free(k)
+        semanage_ibendport_free(p)
+
+    def add(self, ibendport, ibdev_name, serange, type):
+        self.begin()
+        self.__add(ibendport, ibdev_name, serange, type)
+        self.commit()
+
+    def __modify(self, ibendport, ibdev_name, serange, setype):
+        if serange == "" and setype == "":
+            if is_mls_enabled == 1:
+                raise ValueError(_("Requires setype or serange"))
+            else:
+                raise ValueError(_("Requires setype"))
+
+        if setype and setype not in self.valid_types:
+            raise ValueError(_("Type %s is invalid, must be an ibendport type") % setype)
+
+        (k, ibdev_name, port) = self.__genkey(ibendport, ibdev_name)
+
+        (rc, exists) = semanage_ibendport_exists(self.sh, k)
+        if rc < 0:
+            raise ValueError(_("Could not check if ibendport %s/%s is defined") % (ibdev_name, ibendport))
+        if not exists:
+            raise ValueError(_("ibendport %s/%s is not defined") % (ibdev_name, ibendport))
+
+        (rc, p) = semanage_ibendport_query(self.sh, k)
+        if rc < 0:
+            raise ValueError(_("Could not query ibendport %s/%s") % (ibdev_name, ibendport))
+
+        con = semanage_ibendport_get_con(p)
+
+        if (is_mls_enabled == 1) and (serange != ""):
+            semanage_context_set_mls(self.sh, con, untranslate(serange))
+        if setype != "":
+            semanage_context_set_type(self.sh, con, setype)
+
+        rc = semanage_ibendport_modify_local(self.sh, k, p)
+        if rc < 0:
+            raise ValueError(_("Could not modify ibendport %s/%s") % (ibdev_name, ibendport))
+
+        semanage_ibendport_key_free(k)
+        semanage_ibendport_free(p)
+
+    def modify(self, ibendport, ibdev_name, serange, setype):
+        self.begin()
+        self.__modify(ibendport, ibdev_name, serange, setype)
+        self.commit()
+
+    def deleteall(self):
+        (rc, plist) = semanage_ibendport_list_local(self.sh)
+        if rc < 0:
+            raise ValueError(_("Could not list the ibendports"))
+
+        self.begin()
+
+        for ibendport in plist:
+            (rc, ibdev_name) = semanage_ibendport_get_ibdev_name(self.sh, ibendport)
+            port = semanage_ibendport_get_port(ibendport)
+            (k, ibdev_name, port) = self.__genkey(str(port), ibdev_name)
+            if rc < 0:
+                raise ValueError(_("Could not create a key for %s/%d") % (ibdevname, port))
+
+            rc = semanage_ibendport_del_local(self.sh, k)
+            if rc < 0:
+                raise ValueError(_("Could not delete the ibendport %s/%d") % (ibdev_name, port))
+            semanage_ibendport_key_free(k)
+
+        self.commit()
+
+    def __delete(self, ibendport, ibdev_name):
+        (k, ibdev_name, port) = self.__genkey(ibendport, ibdev_name)
+        (rc, exists) = semanage_ibendport_exists(self.sh, k)
+        if rc < 0:
+            raise ValueError(_("Could not check if ibendport %s/%s is defined") % (ibdev_name, ibendport))
+        if not exists:
+            raise ValueError(_("ibendport %s/%s is not defined") % (ibdev_name, ibendport))
+
+        (rc, exists) = semanage_ibendport_exists_local(self.sh, k)
+        if rc < 0:
+            raise ValueError(_("Could not check if ibendport %s/%s is defined") % (ibdev_name, ibendport))
+        if not exists:
+            raise ValueError(_("ibendport %s/%s is defined in policy, cannot be deleted") % (ibdev_name, ibendport))
+
+        rc = semanage_ibendport_del_local(self.sh, k)
+        if rc < 0:
+            raise ValueError(_("Could not delete ibendport %s/%s") % (ibdev_name, ibendport))
+
+        semanage_ibendport_key_free(k)
+
+    def delete(self, ibendport, ibdev_name):
+        self.begin()
+        self.__delete(ibendport, ibdev_name)
+        self.commit()
+
+    def get_all(self, locallist=0):
+        ddict = {}
+        if locallist:
+            (rc, self.plist) = semanage_ibendport_list_local(self.sh)
+        else:
+            (rc, self.plist) = semanage_ibendport_list(self.sh)
+        if rc < 0:
+            raise ValueError(_("Could not list ibendports"))
+
+        for ibendport in self.plist:
+            con = semanage_ibendport_get_con(ibendport)
+            ctype = semanage_context_get_type(con)
+            if ctype == "reserved_ibendport_t":
+                continue
+            level = semanage_context_get_mls(con)
+            (rc, ibdev_name) = semanage_ibendport_get_ibdev_name(self.sh, ibendport)
+            port = semanage_ibendport_get_port(ibendport)
+            ddict[(port, ibdev_name)] = (ctype, level)
+        return ddict
+
+    def get_all_by_type(self, locallist=0):
+        ddict = {}
+        if locallist:
+            (rc, self.plist) = semanage_ibendport_list_local(self.sh)
+        else:
+            (rc, self.plist) = semanage_ibendport_list(self.sh)
+        if rc < 0:
+            raise ValueError(_("Could not list ibendports"))
+
+        for ibendport in self.plist:
+            con = semanage_ibendport_get_con(ibendport)
+            ctype = semanage_context_get_type(con)
+            (rc, ibdev_name) = semanage_ibendport_get_ibdev_name(self.sh, ibendport)
+            port = semanage_ibendport_get_port(ibendport)
+            if (ctype, ibdev_name) not in ddict.keys():
+                ddict[(ctype, ibdev_name)] = []
+            ddict[(ctype, ibdev_name)].append("0x%x" % port)
+        return ddict
+
+    def customized(self):
+        l = []
+        ddict = self.get_all(True)
+        keys = ddict.keys()
+        keys.sort()
+        for k in keys:
+            l.append("-a -t %s -x %s %s" % (ddict[k][0], k[2], k[0]))
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
+            print "%-30s %-18s %s\n" % (_("SELinux IB End Port Type"), _("IB Device Name"), _("Port Number"))
+        for i in keys:
+            rec = "%-30s %-18s " % i
+            rec += "%s" % ddict[i][0]
+            for p in ddict[i][1:]:
+                rec += ", %s" % p
+            print rec
+
 class nodeRecords(semanageRecords):
     try:
         valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "node_type"))[0]["types"])
-- 
1.7.1
