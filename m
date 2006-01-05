Message-ID: <43BD99A1.3070700@cornell.edu>
Date: Thu, 05 Jan 2006 17:11:45 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: [SEMANAGE] Validation of local file contexts
Content-Type: multipart/mixed;
 boundary="------------050608080003040900020202"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050608080003040900020202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds context validation of local changes to file contexts.

Should I also check if the regexp is valid?
Should I check if the Unix user exists for seusers?

=======

This also adds another warning for semanage <---> sepol incompatible 
data structures, but this is a known issue.
I could hide the warnings, but I'd rather not - we may still want to 
address the problem. I tried to write conversion wrappers once before, 
and got rather far - maybe I'll finish this work, if you think it's 
desirable not to rely on compatible records.

=========

Another thing that I'd like to note - those kinds of validation runs 
prevent installing seusers or file_contexts that are bad, but also work 
in the opposite direction, and prevent policy upgrades that will break 
local customizations - not sure if this is the desired approach. 

--------------050608080003040900020202
Content-Type: text/x-patch;
 name="libsemanage.fcontext_local_validation.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.fcontext_local_validation.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2006-01-05 08:26:19.000000000 -0500
+++ new/libsemanage/src/direct_api.c	2006-01-05 16:56:33.000000000 -0500
@@ -351,12 +351,13 @@ static int semanage_direct_commit(semana
 	dbase_config_t* ifaces = semanage_iface_dbase_local(sh);
 	dbase_config_t* fcontexts = semanage_fcontext_dbase_local(sh);
 	dbase_config_t* seusers = semanage_seuser_dbase(sh);
+	int fcontexts_modified = fcontexts->dtable->is_modified(fcontexts->dbase);
+	int seusers_modified = seusers->dtable->is_modified(seusers->dbase);
 	modified |= users->dtable->is_modified(users->dbase);
 	modified |= ports->dtable->is_modified(ports->dbase);
 	modified |= bools->dtable->is_modified(bools->dbase);
-	modified |= fcontexts->dtable->is_modified(fcontexts->dbase);
+	modified |= fcontexts_modified;
 	modified |= ifaces->dtable->is_modified(ifaces->dbase);
-	int seusers_modified = seusers->dtable->is_modified(seusers->dbase);
 
 	/* FIXME: get rid of this, once we support loading the existing policy,
 	 * instead of rebuilding it for seusers */
@@ -408,6 +409,15 @@ static int semanage_direct_commit(semana
 	/* FIXME: else if !modified, but seusers_modified, 
 	 * load the existing policy instead of rebuilding */
 
+	/* Validate local modifications to file contexts.
+	 * Note: those are still cached, even though they've been 
+	 * merged into the main file_contexts. We won't check the 
+	 * large file_contexts - checked at compile time */
+	if (sh->do_rebuild || modified || fcontexts_modified) {
+		if (semanage_fcontext_validate_local(sh, out) < 0)
+			goto cleanup;
+	}
+
 	/* Validate seusers against policy
 	 * if either policy changed, or seusers changed,
 	 * or we forced a rebuild */
diff -Naurp --exclude-from excludes old/libsemanage/src/fcontext_internal.h new/libsemanage/src/fcontext_internal.h
--- old/libsemanage/src/fcontext_internal.h	2006-01-04 12:18:17.000000000 -0500
+++ new/libsemanage/src/fcontext_internal.h	2006-01-05 16:55:49.000000000 -0500
@@ -4,6 +4,7 @@
 #include <semanage/fcontext_record.h>
 #include <semanage/fcontexts_local.h>
 #include <semanage/fcontexts_policy.h>
+#include <sepol/policydb.h>
 #include "database.h"
 #include "handle.h"
 #include "dso.h"
@@ -21,4 +22,8 @@ extern int fcontext_file_dbase_init(
 extern void fcontext_file_dbase_release(
 	dbase_config_t* dconfig);
 
+extern int hidden semanage_fcontext_validate_local(
+	semanage_handle_t* handle,
+	const sepol_policydb_t* policydb);
+
 #endif
diff -Naurp --exclude-from excludes old/libsemanage/src/fcontexts_local.c new/libsemanage/src/fcontexts_local.c
--- old/libsemanage/src/fcontexts_local.c	2006-01-05 14:41:09.000000000 -0500
+++ new/libsemanage/src/fcontexts_local.c	2006-01-05 16:58:56.000000000 -0500
@@ -6,8 +6,12 @@ typedef struct semanage_fcontext_key rec
 typedef struct semanage_fcontext record_t;
 #define DBASE_RECORD_DEFINED
 
+#include <stdlib.h>
 #include <stddef.h>
+#include <sepol/policydb.h>
+#include <sepol/context.h>
 #include "fcontext_internal.h"
+#include "debug.h"
 #include "handle.h" 
 #include "database.h"
 
@@ -91,3 +95,54 @@ int semanage_fcontext_list_local(
 	dbase_config_t* dconfig = semanage_fcontext_dbase_local(handle);
 	return dbase_list(handle, dconfig, records, count);
 }
+
+struct validate_handler_arg {
+	semanage_handle_t* handle;
+	const sepol_policydb_t* policydb;
+};
+
+static int validate_handler(
+	const semanage_fcontext_t* fcon,
+	void* varg) {
+
+	char* str;
+
+	/* Unpack varg */
+	struct validate_handler_arg* arg =
+		(struct validate_handler_arg*) varg;
+	semanage_handle_t* handle = arg->handle;
+	const sepol_policydb_t* policydb = arg->policydb;
+
+	/* Unpack fcontext */
+	const char* expr = semanage_fcontext_get_expr(fcon);
+	const char* type_str = semanage_fcontext_get_type_str(fcon);
+	semanage_context_t* con = semanage_fcontext_get_con(fcon);
+
+	/* FIXME: verify expr? */
+	
+	if (sepol_context_check(handle->sepolh, policydb, con) < 0)
+		goto invalid;
+
+	return 0;
+
+	invalid:
+	if (semanage_context_to_string(handle, con, &str) >= 0) {
+		ERR(handle, "invalid context %s specified for %s [%s]", 
+			str, expr, type_str);
+		free(str);
+	} else
+		ERR(handle, "invalid context specified for %s [%s]", 
+			expr, type_str);
+	return -1;
+}
+
+int hidden semanage_fcontext_validate_local(
+	semanage_handle_t* handle,
+	const sepol_policydb_t* policydb) {
+
+	struct validate_handler_arg arg;
+	arg.handle = handle;
+	arg.policydb = policydb;
+	return semanage_fcontext_iterate_local(handle, validate_handler, &arg);
+}
+
diff -Naurp --exclude-from excludes old/libsemanage/src/seusers.c new/libsemanage/src/seusers.c
--- old/libsemanage/src/seusers.c	2006-01-05 14:41:09.000000000 -0500
+++ new/libsemanage/src/seusers.c	2006-01-05 16:38:25.000000000 -0500
@@ -97,7 +97,6 @@ int semanage_seuser_list(
 	return dbase_list(handle, dconfig, records, count);
 }
 
-
 struct validate_handler_arg {
 	semanage_handle_t* handle;
 	const sepol_policydb_t* policydb;

--------------050608080003040900020202--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
