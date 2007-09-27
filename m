Message-Id: <20070927200752.265801216@tresys.com>
References: <20070927200712.950671948@tresys.com>
Date: Thu, 27 Sep 2007 16:07:13 -0400
From: "Todd C. Miller" <tmiller@tresys.com>
To: sds@tycho.nsa.gov, dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov, jbrindle@tresys.com, tmiller@tresys.com
Subject: [patch 1/4] libsemanage: validate homedir contexts
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Validate contexts against the new policy before writing them to
file_contexts.homedirs.

---
 libsemanage/src/direct_api.c     |    2 
 libsemanage/src/genhomedircon.c  |  100 +++++++++++++++++++++++++++++++--------
 libsemanage/src/genhomedircon.h  |    3 -
 libsemanage/src/semanage_store.c |    5 +
 libsemanage/src/semanage_store.h |    5 -
 5 files changed, 88 insertions(+), 27 deletions(-)

Index: trunk/libsemanage/src/genhomedircon.c
===================================================================
--- trunk.orig/libsemanage/src/genhomedircon.c
+++ trunk/libsemanage/src/genhomedircon.c
@@ -1,5 +1,6 @@
-/* Author: Mark Goldman   <mgoldman@tresys.com>
- * 			Paul Rosenfeld	<prosenfeld@tresys.com>
+/* Author: Mark Goldman	  <mgoldman@tresys.com>
+ * 	   Paul Rosenfeld <prosenfeld@tresys.com>
+ * 	   Todd C. Miller <tmiller@tresys.com>
  *
  * Copyright (C) 2007 Tresys Technology, LLC
  *
@@ -23,6 +24,8 @@
 #include <semanage/seusers_policy.h>
 #include <semanage/users_policy.h>
 #include <semanage/user_record.h>
+#include <sepol/context.h>
+#include <sepol/context_record.h>
 #include "semanage_store.h"
 #include "seuser_internal.h"
 #include "debug.h"
@@ -80,6 +83,7 @@ typedef struct {
 	int usepasswd;
 	const char *homedir_template_path;
 	semanage_handle_t *h_semanage;
+	sepol_policydb_t *policydb;
 } genhomedircon_settings_t;
 
 typedef struct user_entry {
@@ -352,9 +356,49 @@ static Ustr *replace_all(const char *str
 	return retval;
 }
 
-static int write_home_dir_context(FILE * out, semanage_list_t * tpl,
-				  const char *user, const char *seuser,
-				  const char *home, const char *role_prefix)
+static const char * extract_context(Ustr *line)
+{
+	const char whitespace[] = " \t\n";
+	size_t off, len;
+
+	/* check for trailing whitespace */
+	off = ustr_spn_chrs_rev(line, 0, whitespace, strlen(whitespace));
+
+	/* find the length of the last field in line */
+	len = ustr_cspn_chrs_rev(line, off, whitespace, strlen(whitespace));
+
+	if (len == 0)
+		return NULL;
+	return ustr_cstr(line) + ustr_len(line) - (len + off);
+}
+
+static int check_line(genhomedircon_settings_t * s, Ustr *line)
+{
+	sepol_context_t *ctx_record = NULL;
+	const char *ctx_str;
+	int result;
+
+	ctx_str = extract_context(line);
+	if (!ctx_str)
+		return STATUS_ERR;
+
+	result = sepol_context_from_string(s->h_semanage->sepolh,
+					   ctx_str, &ctx_record);
+	if (result == STATUS_SUCCESS && ctx_record != NULL) {
+		sepol_msg_set_callback(s->h_semanage->sepolh, NULL, NULL);
+		result = sepol_context_check(s->h_semanage->sepolh,
+					     s->policydb, ctx_record);
+		sepol_msg_set_callback(s->h_semanage->sepolh,
+				       semanage_msg_relay_handler, s->h_semanage);
+		sepol_context_free(ctx_record);
+	}
+	return result;
+}
+
+static int write_home_dir_context(genhomedircon_settings_t * s, FILE * out,
+				  semanage_list_t * tpl, const char *user,
+				  const char *seuser, const char *home,
+				  const char *role_prefix)
 {
 	replacement_pair_t repl[] = {
 		{.search_for = TEMPLATE_SEUSER,.replace_with = seuser},
@@ -369,8 +413,12 @@ static int write_home_dir_context(FILE *
 
 	for (; tpl; tpl = tpl->next) {
 		line = replace_all(tpl->data, repl);
-		if (!line || !ustr_io_putfileline(&line, out))
+		if (!line)
 			goto fail;
+		if (check_line(s, line) == STATUS_SUCCESS) {
+			if (!ustr_io_putfileline(&line, out))
+				goto fail;
+		}
 		ustr_sc_free(&line);
 	}
 	return STATUS_SUCCESS;
@@ -380,8 +428,8 @@ static int write_home_dir_context(FILE *
 	return STATUS_ERR;
 }
 
-static int write_home_root_context(FILE * out, semanage_list_t * tpl,
-				   char *homedir)
+static int write_home_root_context(genhomedircon_settings_t * s, FILE * out,
+				   semanage_list_t * tpl, char *homedir)
 {
 	replacement_pair_t repl[] = {
 		{.search_for = TEMPLATE_HOME_ROOT,.replace_with = homedir},
@@ -391,8 +439,12 @@ static int write_home_root_context(FILE 
 
 	for (; tpl; tpl = tpl->next) {
 		line = replace_all(tpl->data, repl);
-		if (!line || !ustr_io_putfileline(&line, out))
+		if (!line)
 			goto fail;
+		if (check_line(s, line) == STATUS_SUCCESS) {
+			if (!ustr_io_putfileline(&line, out))
+				goto fail;
+		}
 		ustr_sc_free(&line);
 	}
 	return STATUS_SUCCESS;
@@ -402,8 +454,9 @@ static int write_home_root_context(FILE 
 	return STATUS_ERR;
 }
 
-static int write_user_context(FILE * out, semanage_list_t * tpl, char *user,
-			      char *seuser, char *role_prefix)
+static int write_user_context(genhomedircon_settings_t * s, FILE * out,
+			      semanage_list_t * tpl, const char *user,
+			      const char *seuser, const char *role_prefix)
 {
 	replacement_pair_t repl[] = {
 		{.search_for = TEMPLATE_USER,.replace_with = user},
@@ -415,8 +468,12 @@ static int write_user_context(FILE * out
 
 	for (; tpl; tpl = tpl->next) {
 		line = replace_all(tpl->data, repl);
-		if (!line || !ustr_io_putfileline(&line, out))
+		if (!line)
 			goto fail;
+		if (check_line(s, line) == STATUS_SUCCESS) {
+			if (!ustr_io_putfileline(&line, out))
+				goto fail;
+		}
 		ustr_sc_free(&line);
 	}
 	return STATUS_SUCCESS;
@@ -602,7 +659,7 @@ static genhomedircon_user_entry_t *get_u
 	return head;
 }
 
-static int write_gen_home_dir_context(FILE * out, genhomedircon_settings_t * s,
+static int write_gen_home_dir_context(genhomedircon_settings_t * s, FILE * out,
 				      semanage_list_t * user_context_tpl,
 				      semanage_list_t * homedir_context_tpl)
 {
@@ -615,13 +672,13 @@ static int write_gen_home_dir_context(FI
 	}
 
 	for (; users; pop_user_entry(&users)) {
-		if (write_home_dir_context(out, homedir_context_tpl,
+		if (write_home_dir_context(s, out, homedir_context_tpl,
 					   users->name,
 					   users->sename, users->home,
 					   users->prefix)) {
 			return STATUS_ERR;
 		}
-		if (write_user_context(out, user_context_tpl, users->name,
+		if (write_user_context(s, out, user_context_tpl, users->name,
 				       users->sename, users->prefix)) {
 			return STATUS_ERR;
 		}
@@ -671,7 +728,7 @@ static int write_context_file(genhomedir
 			goto done;
 		}
 
-		if (write_home_dir_context(out,
+		if (write_home_dir_context(s, out,
 					   homedir_context_tpl, FALLBACK_USER,
 					   FALLBACK_USER, ustr_cstr(temp),
 					   FALLBACK_USER_PREFIX) !=
@@ -680,7 +737,7 @@ static int write_context_file(genhomedir
 			retval = STATUS_ERR;
 			goto done;
 		}
-		if (write_home_root_context(out,
+		if (write_home_root_context(s, out,
 					    homeroot_context_tpl,
 					    h->data) != STATUS_SUCCESS) {
 			ustr_sc_free(&temp);
@@ -711,7 +768,9 @@ static int write_context_file(genhomedir
 	return retval;
 }
 
-int semanage_genhomedircon(semanage_handle_t * sh, int usepasswd)
+int semanage_genhomedircon(semanage_handle_t * sh,
+			   sepol_policydb_t * policydb,
+			   int usepasswd)
 {
 	genhomedircon_settings_t s;
 	FILE *out = NULL;
@@ -725,6 +784,7 @@ int semanage_genhomedircon(semanage_hand
 
 	s.usepasswd = usepasswd;
 	s.h_semanage = sh;
+	s.policydb = policydb;
 
 	if (!(out = fopen(s.fcfilepath, "w"))) {
 		/* couldn't open output file */
Index: trunk/libsemanage/src/genhomedircon.h
===================================================================
--- trunk.orig/libsemanage/src/genhomedircon.h
+++ trunk/libsemanage/src/genhomedircon.h
@@ -22,6 +22,7 @@
 
 #include "utilities.h"
 
-int semanage_genhomedircon(semanage_handle_t * sh, int usepasswd);
+int semanage_genhomedircon(semanage_handle_t * sh,
+			   sepol_policydb_t * policydb, int usepasswd);
 
 #endif
Index: trunk/libsemanage/src/direct_api.c
===================================================================
--- trunk.orig/libsemanage/src/direct_api.c
+++ trunk/libsemanage/src/direct_api.c
@@ -702,7 +702,7 @@ static int semanage_direct_commit(semana
 		goto cleanup;
 
 	if (sh->do_rebuild || modified) {
-		retval = semanage_install_sandbox(sh);
+		retval = semanage_install_sandbox(sh, out);
 	}
 
       cleanup:
Index: trunk/libsemanage/src/semanage_store.c
===================================================================
--- trunk.orig/libsemanage/src/semanage_store.c
+++ trunk/libsemanage/src/semanage_store.c
@@ -1279,7 +1279,8 @@ static int semanage_commit_sandbox(seman
  * should be placed within a mutex lock to ensure that it runs
  * atomically.	Returns commit number on success, -1 on error.
  */
-int semanage_install_sandbox(semanage_handle_t * sh)
+int semanage_install_sandbox(semanage_handle_t * sh,
+			     sepol_policydb_t * policydb)
 {
 	int retval = -1, commit_num = -1;
 
@@ -1294,7 +1295,7 @@ int semanage_install_sandbox(semanage_ha
 	}
 	if (!sh->conf->disable_genhomedircon) {
 		if ((retval =
-		     semanage_genhomedircon(sh, TRUE)) != 0) {
+		     semanage_genhomedircon(sh, policydb, TRUE)) != 0) {
 			ERR(sh, "semanage_genhomedircon returned error code %d.",
 			    retval);
 			goto cleanup;
Index: trunk/libsemanage/src/semanage_store.h
===================================================================
--- trunk.orig/libsemanage/src/semanage_store.h
+++ trunk/libsemanage/src/semanage_store.h
@@ -83,8 +83,6 @@ int semanage_make_sandbox(semanage_handl
 int semanage_get_modules_names(semanage_handle_t * sh,
 			       char ***filenames, int *len);
 
-int semanage_install_sandbox(semanage_handle_t * sh);
-
 /* lock file routines */
 int semanage_get_trans_lock(semanage_handle_t * sh);
 int semanage_get_active_lock(semanage_handle_t * sh);
@@ -102,7 +100,8 @@ int semanage_expand_sandbox(semanage_han
 int semanage_write_policydb(semanage_handle_t * sh,
 			    sepol_policydb_t * policydb);
 
-int semanage_install_sandbox(semanage_handle_t * sh);
+int semanage_install_sandbox(semanage_handle_t * sh,
+			     sepol_policydb_t * policydb);
 
 int semanage_verify_modules(semanage_handle_t * sh,
 			    char **module_filenames, int num_modules);

-- 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
