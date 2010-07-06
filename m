Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o66MNM2b024366
	for <selinux@tycho.nsa.gov>; Tue, 6 Jul 2010 18:23:26 -0400
Received: from mail-pv0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o66MMRJ6028058
	for <selinux@tycho.nsa.gov>; Tue, 6 Jul 2010 22:22:32 GMT
Received: by mail-pv0-f181.google.com with SMTP id 2so246838pvg.12
        for <selinux@tycho.nsa.gov>; Tue, 06 Jul 2010 15:23:24 -0700 (PDT)
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Cc: refpolicy@oss1.tresys.com, "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH 2/3]libsepol 
Date: Tue,  6 Jul 2010 15:23:29 -0700
Message-Id: <1278455010-23244-3-git-send-email-justinmattock@gmail.com>
In-Reply-To: <1278455010-23244-1-git-send-email-justinmattock@gmail.com>
References: <1278455010-23244-1-git-send-email-justinmattock@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Going through these warning messages Im getting:
(example 1 of many)
booleans.c: In function 'sepol_bool_count':
booleans.c:106:39: error: parameter 'handle' set but not used
cc1: all warnings being treated as errors

seems most of these go to NULL; Which tells me that these are here for
future use and/or need to be there for some other reason.
The biggest problem I have is Im getting errors out of these as opposed
to just a warning(-Werror) so marking the variable with a GCC
__attribute__ ((unused)) gets things going. 
 
Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 libsepol/src/booleans.c   |    2 +-
 libsepol/src/debug.c      |    2 +-
 libsepol/src/interfaces.c |    4 ++--
 libsepol/src/nodes.c      |    2 +-
 libsepol/src/policydb.c   |    4 +---
 libsepol/src/ports.c      |    2 +-
 libsepol/src/roles.c      |    2 +-
 libsepol/src/services.c   |    2 --
 libsepol/src/users.c      |    4 ++--
 9 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/libsepol/src/booleans.c b/libsepol/src/booleans.c
index 7f37c8b..03f8c98 100644
--- a/libsepol/src/booleans.c
+++ b/libsepol/src/booleans.c
@@ -103,7 +103,7 @@ int sepol_bool_set(sepol_handle_t * handle,
 	return STATUS_ERR;
 }
 
-int sepol_bool_count(sepol_handle_t * handle,
+int sepol_bool_count(sepol_handle_t * handle __attribute__ ((unused)),
 		     const sepol_policydb_t * p, unsigned int *response)
 {
 
diff --git a/libsepol/src/debug.c b/libsepol/src/debug.c
index 552b7d7..51918fd 100644
--- a/libsepol/src/debug.c
+++ b/libsepol/src/debug.c
@@ -41,7 +41,7 @@ hidden_def(sepol_msg_get_fname)
 #ifdef __GNUC__
     __attribute__ ((format(printf, 3, 4)))
 #endif
-void hidden sepol_msg_default_handler(void *varg,
+void hidden sepol_msg_default_handler(void *varg __attribute__ ((unused)),
 				      sepol_handle_t * handle,
 				      const char *fmt, ...)
 {
diff --git a/libsepol/src/interfaces.c b/libsepol/src/interfaces.c
index fd4a001..b82d0f3 100644
--- a/libsepol/src/interfaces.c
+++ b/libsepol/src/interfaces.c
@@ -106,7 +106,7 @@ static int iface_to_record(sepol_handle_t * handle,
 }
 
 /* Check if an interface exists */
-int sepol_iface_exists(sepol_handle_t * handle,
+int sepol_iface_exists(sepol_handle_t * handle __attribute__ ((unused)),
 		       const sepol_policydb_t * p,
 		       const sepol_iface_key_t * key, int *response)
 {
@@ -216,7 +216,7 @@ int sepol_iface_modify(sepol_handle_t * handle,
 }
 
 /* Return the number of interfaces */
-extern int sepol_iface_count(sepol_handle_t * handle,
+extern int sepol_iface_count(sepol_handle_t * handle __attribute__ ((unused)),
 			     const sepol_policydb_t * p, unsigned int *response)
 {
 
diff --git a/libsepol/src/nodes.c b/libsepol/src/nodes.c
index ba2934d..ebf5f1d 100644
--- a/libsepol/src/nodes.c
+++ b/libsepol/src/nodes.c
@@ -144,7 +144,7 @@ static int node_to_record(sepol_handle_t * handle,
 }
 
 /* Return the number of nodes */
-extern int sepol_node_count(sepol_handle_t * handle,
+extern int sepol_node_count(sepol_handle_t * handle __attribute__ ((unused)),
 			    const sepol_policydb_t * p, unsigned int *response)
 {
 
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index dae05d3..5c0081f 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -3234,7 +3234,7 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 {
 
 	unsigned int i, j, r_policyvers;
-	uint32_t buf[5], config;
+	uint32_t buf[5];
 	size_t len, nprim, nel;
 	char *policydb_str;
 	struct policydb_compat_info *info;
@@ -3242,8 +3242,6 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 	ebitmap_node_t *tnode;
 	int rc;
 
-	config = 0;
-
 	/* Read the magic number and string length. */
 	rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
 	if (rc < 0)
diff --git a/libsepol/src/ports.c b/libsepol/src/ports.c
index 06a0743..cbf2a0b 100644
--- a/libsepol/src/ports.c
+++ b/libsepol/src/ports.c
@@ -140,7 +140,7 @@ static int port_to_record(sepol_handle_t * handle,
 }
 
 /* Return the number of ports */
-extern int sepol_port_count(sepol_handle_t * handle,
+extern int sepol_port_count(sepol_handle_t * handle __attribute__ ((unused)),
 			    const sepol_policydb_t * p, unsigned int *response)
 {
 
diff --git a/libsepol/src/roles.c b/libsepol/src/roles.c
index 47aed15..419a3b2 100644
--- a/libsepol/src/roles.c
+++ b/libsepol/src/roles.c
@@ -8,7 +8,7 @@
 #include "handle.h"
 
 /* Check if a role exists */
-int sepol_role_exists(sepol_handle_t * handle,
+int sepol_role_exists(sepol_handle_t * handle __attribute__ ((unused)),
 		      sepol_policydb_t * p, const char *role, int *response)
 {
 
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index eed413f..9c2920c 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -1003,7 +1003,6 @@ int hidden sepol_load_policy(void *data, size_t len)
 	policydb_t oldpolicydb, newpolicydb;
 	sidtab_t oldsidtab, newsidtab;
 	convert_context_args_t args;
-	uint32_t seqno;
 	int rc = 0;
 	struct policy_file file, *fp;
 
@@ -1050,7 +1049,6 @@ int hidden sepol_load_policy(void *data, size_t len)
 	/* Install the new policydb and SID table. */
 	memcpy(policydb, &newpolicydb, sizeof *policydb);
 	sepol_sidtab_set(sidtab, &newsidtab);
-	seqno = ++latest_granting;
 
 	/* Free the old policydb and SID table. */
 	policydb_destroy(&oldpolicydb);
diff --git a/libsepol/src/users.c b/libsepol/src/users.c
index 903fc62..17e1426 100644
--- a/libsepol/src/users.c
+++ b/libsepol/src/users.c
@@ -284,7 +284,7 @@ int sepol_user_modify(sepol_handle_t * handle,
 	return STATUS_ERR;
 }
 
-int sepol_user_exists(sepol_handle_t * handle,
+int sepol_user_exists(sepol_handle_t * handle __attribute__ ((unused)),
 		      const sepol_policydb_t * p,
 		      const sepol_user_key_t * key, int *response)
 {
@@ -301,7 +301,7 @@ int sepol_user_exists(sepol_handle_t * handle,
 	return STATUS_SUCCESS;
 }
 
-int sepol_user_count(sepol_handle_t * handle,
+int sepol_user_count(sepol_handle_t * handle __attribute__ ((unused)),
 		     const sepol_policydb_t * p, unsigned int *response)
 {
 
-- 
1.7.1.rc1.21.gf3bd6


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
