Date: Thu, 27 Sep 2007 10:46:52 -0400 (EDT)
Message-Id: <200709271446.l8REkqfW010331@tex.courtesan.com>
To: sds@tycho.nsa.gov, dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
From: "Todd C. Miller" <tmiller@tresys.com>
Subject: RE: I am concerned about putting genhomedircon changesinlibsemanage into Fedora 8.
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:

> Already have it.
> 
> This is a repatch off of libsemanage-2.0.9
> 
> It should include your stuff plus it gets the fallback_user by looking
> up the __default__ login record.
> 
> That way if I change the __default__ record to use xguest_u, it will
> build all user accounts with this context.
> 
> getpwnam_r returns 0 even if an account does not exist.
> 
> So you need to check the pointer.
> 
> A couple of other translation problems also.

Unfortunately, the return values for getpwnam_r() and getpwent_r()
are inconsistent.  While getpwnam_r() returns 0 when the user does
not exist, getpwent_r() returns ENOENT.  I decided to deal with
both semantics in the same way so if they are every brought into
line the code will still do the right thing.

I made similar fixes to yours for the seuser vs. user mismatches.
A merge of your diff and mine follows.  I added some error condition
fixes and made the style more consistent.

 - todd

Index: libsemanage/include/semanage/handle.h
===================================================================
--- libsemanage/include/semanage/handle.h	(revision 2587)
+++ libsemanage/include/semanage/handle.h	(working copy)
@@ -69,6 +69,10 @@
  * 1 for yes, 0 for no (default) */
 void semanage_set_create_store(semanage_handle_t * handle, int create_store);
 
+/* set whether to generate homedir file context
+ * 1 for yes (default), 0 for no */
+void semanage_set_rebuild_file_context(semanage_handle_t * handle, int do_rebuild_file_context);
+
 /* Set whether or not to disable dontaudits upon commit */
 void semanage_set_disable_dontaudit(semanage_handle_t * handle, int disable_dontaudit);
 
Index: libsemanage/src/handle.h
===================================================================
--- libsemanage/src/handle.h	(revision 2587)
+++ libsemanage/src/handle.h	(working copy)
@@ -58,6 +58,7 @@
 	int is_connected;
 	int is_in_transaction;
 	int do_reload;		/* whether to reload policy after commit */
+	int do_rebuild_file_context;	/* whether to generate homedircontext */
 	int do_rebuild;		/* whether to rebuild policy if there were no changes */
 	int modules_modified;
 	int create_store;	/* whether to create the store if it does not exist
Index: libsemanage/src/libsemanage.map
===================================================================
--- libsemanage/src/libsemanage.map	(revision 2587)
+++ libsemanage/src/libsemanage.map	(working copy)
@@ -9,6 +9,7 @@
 	  semanage_module_list_nth; semanage_module_get_name;
 	  semanage_module_get_version; semanage_select_store;
 	  semanage_reload_policy; semanage_set_reload; semanage_set_rebuild;
+	  semanage_set_rebuild_file_context;
 	  semanage_user_*; semanage_bool_*; semanage_seuser_*;
 	  semanage_iface_*; semanage_port_*; semanage_context_*;
 	  semanage_node_*;
Index: libsemanage/src/genhomedircon.c
===================================================================
--- libsemanage/src/genhomedircon.c	(revision 2587)
+++ libsemanage/src/genhomedircon.c	(working copy)
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
@@ -80,6 +83,7 @@
 	int usepasswd;
 	const char *homedir_template_path;
 	semanage_handle_t *h_semanage;
+	sepol_policydb_t *policydb;
 } genhomedircon_settings_t;
 
 typedef struct user_entry {
@@ -154,6 +158,7 @@
 	size_t temp;
 	struct passwd pwstorage, *pwbuf;
 	struct stat buf;
+	int retval;
 
 	shells = get_shell_list();
 	assert(shells);
@@ -225,7 +230,7 @@
 	if (rbuf == NULL)
 		goto fail;
 	setpwent();
-	for (errno = 0; getpwent_r(&pwstorage, rbuf, rbuflen, &pwbuf) == 0; errno = 0) {
+	while ((retval = getpwent_r(&pwstorage, rbuf, rbuflen, &pwbuf)) == 0) {
 		if (pwbuf->pw_uid < minuid)
 			continue;
 		if (!semanage_list_find(shells, pwbuf->pw_shell))
@@ -248,7 +253,7 @@
 		free(path);
 	}
 
-	if (errno) {
+	if (retval && retval != ENOENT) {
 		WARN(s->h_semanage, "Error while fetching users.  "
 		     "Returning list so far.");
 	}
@@ -352,10 +357,50 @@
 	return retval;
 }
 
-static int write_home_dir_context(FILE * out, semanage_list_t * tpl,
-				  const char *user, const char *seuser,
-				  const char *home, const char *role_prefix)
+static const char * extract_context(Ustr *line)
 {
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
+				       semanage_msg_relay_handler, NULL);
+		sepol_context_free(ctx_record);
+	}
+	return result;
+}
+
+static int write_home_dir_context(genhomedircon_settings_t * s, FILE * out,
+				  semanage_list_t * tpl, const char *user,
+				  const char *seuser, const char *home,
+				  const char *role_prefix)
+{
 	replacement_pair_t repl[] = {
 		{.search_for = TEMPLATE_SEUSER,.replace_with = seuser},
 		{.search_for = TEMPLATE_HOME_DIR,.replace_with = home},
@@ -369,8 +414,12 @@
 
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
@@ -380,8 +429,8 @@
 	return STATUS_ERR;
 }
 
-static int write_home_root_context(FILE * out, semanage_list_t * tpl,
-				   char *homedir)
+static int write_home_root_context(genhomedircon_settings_t * s, FILE * out,
+				   semanage_list_t * tpl, char *homedir)
 {
 	replacement_pair_t repl[] = {
 		{.search_for = TEMPLATE_HOME_ROOT,.replace_with = homedir},
@@ -391,8 +440,12 @@
 
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
@@ -402,7 +455,8 @@
 	return STATUS_ERR;
 }
 
-static int write_user_context(FILE * out, semanage_list_t * tpl, char *user,
+static int write_user_context(genhomedircon_settings_t * s, FILE * out,
+			      semanage_list_t * tpl, char *user,
 			      char *seuser, char *role_prefix)
 {
 	replacement_pair_t repl[] = {
@@ -415,8 +469,12 @@
 
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
@@ -496,6 +554,36 @@
 	free(temp);
 }
 
+static char *global_fallback_user;
+static char *global_fallback_user_prefix;
+
+static char *get_fallback_user(void)
+{
+	return global_fallback_user;
+}
+
+static char *get_fallback_user_prefix(void)
+{
+	return global_fallback_user_prefix;
+}
+
+static int set_fallback_user(const char *user, const char *prefix)
+{
+	free(global_fallback_user);
+	free(global_fallback_user_prefix);
+	global_fallback_user = strdup(user);
+	global_fallback_user_prefix = strdup(prefix);
+	if (!global_fallback_user || !global_fallback_user_prefix)
+		return -1;
+	return 0;
+}
+
+static void free_fallback_user(void)
+{
+	free(global_fallback_user);
+	free(global_fallback_user_prefix);
+}
+
 static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
 					     int *errors)
 {
@@ -508,6 +596,7 @@
 	const char *name = NULL;
 	const char *seuname = NULL;
 	const char *prefix = NULL;
+	const char *fallback_user = NULL;
 	struct passwd pwstorage, *pwent = NULL;
 	unsigned int i;
 	long rbuflen;
@@ -538,13 +627,41 @@
 
 	for (i = 0; i < nseusers; i++) {
 		name = semanage_seuser_get_name(seuser_list[i]);
+		if (strcmp(name, DEFAULT_LOGIN) == 0) {
+			seuname = semanage_seuser_get_sename(seuser_list[i]);
+
+			/* find the user structure given the name */
+			u = bsearch(seuname, user_list, nusers,
+				    sizeof(semanage_user_t *),
+				    (int (*)(const void *, const void *))
+				    &name_user_cmp);
+			if (u) {
+				prefix = semanage_user_get_prefix(*u);
+			} else {
+				prefix = name;
+			}
+
+			if (set_fallback_user(seuname, prefix) != 0) {
+				*errors = STATUS_ERR;
+				goto cleanup;
+			}
+			break;
+		}
+	}
+			
+	fallback_user = get_fallback_user();
+	for (i = 0; i < nseusers; i++) {
 		seuname = semanage_seuser_get_sename(seuser_list[i]);
 
-		if (strcmp(seuname, FALLBACK_USER) == 0)
+		if (strcmp(seuname, fallback_user) == 0)
 			continue;
-		if (strcmp(seuname, DEFAULT_LOGIN) == 0)
+
+		name = semanage_seuser_get_name(seuser_list[i]);
+
+		if (strcmp(name, DEFAULT_LOGIN) == 0)
 			continue;
-		if (strcmp(seuname, TEMPLATE_SEUSER) == 0)
+		
+		if (strcmp(name, TEMPLATE_SEUSER) == 0)
 			continue;
 
 		/* find the user structure given the name */
@@ -557,12 +674,13 @@
 			prefix = name;
 		}
 
-		errno = 0;
-		if (getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent) != 0) {
-			if (errno != 0) {
+		retval = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
+		if (retval != 0 || pwent == NULL) {
+			if (retval != 0 && retval != ENOENT) {
 				*errors = STATUS_ERR;
 				goto cleanup;
 			}
+
 			WARN(s->h_semanage,
 			     "user %s not in password file", name);
 			continue;
@@ -602,7 +720,7 @@
 	return head;
 }
 
-static int write_gen_home_dir_context(FILE * out, genhomedircon_settings_t * s,
+static int write_gen_home_dir_context(genhomedircon_settings_t * s, FILE * out,
 				      semanage_list_t * user_context_tpl,
 				      semanage_list_t * homedir_context_tpl)
 {
@@ -615,13 +733,13 @@
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
@@ -642,6 +760,7 @@
 	semanage_list_t *user_context_tpl = NULL;
 	semanage_list_t *homedir_context_tpl = NULL;
 	semanage_list_t *homeroot_context_tpl = NULL;
+	char *fallback_user, *fallback_user_prefix;
 	int retval = STATUS_SUCCESS;
 
 	homedirs = get_home_dirs(s);
@@ -662,6 +781,15 @@
 		goto done;
 	}
 
+	if (write_gen_home_dir_context(s, out, user_context_tpl,
+				       homedir_context_tpl) != STATUS_SUCCESS) {
+		retval = STATUS_ERR;
+		goto done;
+	}
+
+	fallback_user = get_fallback_user();
+	fallback_user_prefix = get_fallback_user_prefix();
+
 	for (h = homedirs; h; h = h->next) {
 		Ustr *temp = ustr_dup_cstr(h->data);
 
@@ -671,16 +799,16 @@
 			goto done;
 		}
 
-		if (write_home_dir_context(out,
-					   homedir_context_tpl, FALLBACK_USER,
-					   FALLBACK_USER, ustr_cstr(temp),
-					   FALLBACK_USER_PREFIX) !=
+		if (write_home_dir_context(s, out,
+					   homedir_context_tpl, fallback_user,
+					   fallback_user, ustr_cstr(temp),
+					   fallback_user_prefix) !=
 		    STATUS_SUCCESS) {
 			ustr_sc_free(&temp);
 			retval = STATUS_ERR;
 			goto done;
 		}
-		if (write_home_root_context(out,
+		if (write_home_root_context(s, out,
 					    homeroot_context_tpl,
 					    h->data) != STATUS_SUCCESS) {
 			ustr_sc_free(&temp);
@@ -690,16 +818,12 @@
 
 		ustr_sc_free(&temp);
 	}
-	if (write_user_context(out, user_context_tpl,
-			       ".*", FALLBACK_USER,
-			       FALLBACK_USER_PREFIX) != STATUS_SUCCESS) {
+	if (write_user_context(s, out, user_context_tpl,
+			       ".*", fallback_user,
+			       fallback_user_prefix) != STATUS_SUCCESS) {
 		retval = STATUS_ERR;
 		goto done;
 	}
-	if (write_gen_home_dir_context(out, s, user_context_tpl,
-				       homedir_context_tpl) != STATUS_SUCCESS) {
-		retval = STATUS_ERR;
-	}
 
       done:
 	/* Cleanup */
@@ -711,7 +835,9 @@
 	return retval;
 }
 
-int semanage_genhomedircon(semanage_handle_t * sh, int usepasswd)
+int semanage_genhomedircon(semanage_handle_t * sh,
+			   sepol_policydb_t * policydb,
+			   int usepasswd)
 {
 	genhomedircon_settings_t s;
 	FILE *out = NULL;
@@ -719,12 +845,16 @@
 
 	assert(sh);
 
+	if (set_fallback_user(FALLBACK_USER, FALLBACK_USER_PREFIX) != 0)
+		return STATUS_ERR;
+
 	s.homedir_template_path =
 	    semanage_path(SEMANAGE_TMP, SEMANAGE_HOMEDIR_TMPL);
 	s.fcfilepath = semanage_path(SEMANAGE_TMP, SEMANAGE_FC_HOMEDIRS);
 
 	s.usepasswd = usepasswd;
 	s.h_semanage = sh;
+	s.policydb = policydb;
 
 	if (!(out = fopen(s.fcfilepath, "w"))) {
 		/* couldn't open output file */
@@ -735,5 +865,8 @@
 	retval = write_context_file(&s, out);
 
 	fclose(out);
+
+	free_fallback_user();
+
 	return retval;
 }
Index: libsemanage/src/genhomedircon.h
===================================================================
--- libsemanage/src/genhomedircon.h	(revision 2587)
+++ libsemanage/src/genhomedircon.h	(working copy)
@@ -22,6 +22,7 @@
 
 #include "utilities.h"
 
-int semanage_genhomedircon(semanage_handle_t * sh, int usepasswd);
+int semanage_genhomedircon(semanage_handle_t * sh,
+			   sepol_policydb_t * policydb, int usepasswd);
 
 #endif
Index: libsemanage/src/direct_api.c
===================================================================
--- libsemanage/src/direct_api.c	(revision 2587)
+++ libsemanage/src/direct_api.c	(working copy)
@@ -702,7 +702,7 @@
 		goto cleanup;
 
 	if (sh->do_rebuild || modified) {
-		retval = semanage_install_sandbox(sh);
+		retval = semanage_install_sandbox(sh, out);
 	}
 
       cleanup:
Index: libsemanage/src/semanage_store.c
===================================================================
--- libsemanage/src/semanage_store.c	(revision 2587)
+++ libsemanage/src/semanage_store.c	(working copy)
@@ -1148,7 +1148,7 @@
 
       skip_reload:
 
-	if ((r =
+	if (sh->do_rebuild_file_context && (r =
 	     semanage_exec_prog(sh, sh->conf->setfiles, store_pol,
 				store_fc)) != 0) {
 		ERR(sh, "setfiles returned error code %d.", r);
@@ -1279,7 +1279,8 @@
  * should be placed within a mutex lock to ensure that it runs
  * atomically.	Returns commit number on success, -1 on error.
  */
-int semanage_install_sandbox(semanage_handle_t * sh)
+int semanage_install_sandbox(semanage_handle_t * sh,
+			     sepol_policydb_t * policydb)
 {
 	int retval = -1, commit_num = -1;
 
@@ -1294,7 +1295,7 @@
 	}
 	if (!sh->conf->disable_genhomedircon) {
 		if ((retval =
-		     semanage_genhomedircon(sh, TRUE)) != 0) {
+		     semanage_genhomedircon(sh, policydb, TRUE)) != 0) {
 			ERR(sh, "semanage_genhomedircon returned error code %d.",
 			    retval);
 			goto cleanup;
Index: libsemanage/src/semanage_store.h
===================================================================
--- libsemanage/src/semanage_store.h	(revision 2587)
+++ libsemanage/src/semanage_store.h	(working copy)
@@ -83,8 +83,6 @@
 int semanage_get_modules_names(semanage_handle_t * sh,
 			       char ***filenames, int *len);
 
-int semanage_install_sandbox(semanage_handle_t * sh);
-
 /* lock file routines */
 int semanage_get_trans_lock(semanage_handle_t * sh);
 int semanage_get_active_lock(semanage_handle_t * sh);
@@ -102,7 +100,8 @@
 int semanage_write_policydb(semanage_handle_t * sh,
 			    sepol_policydb_t * policydb);
 
-int semanage_install_sandbox(semanage_handle_t * sh);
+int semanage_install_sandbox(semanage_handle_t * sh,
+			     sepol_policydb_t * policydb);
 
 int semanage_verify_modules(semanage_handle_t * sh,
 			    char **module_filenames, int num_modules);
Index: libsemanage/src/handle.c
===================================================================
--- libsemanage/src/handle.c	(revision 2587)
+++ libsemanage/src/handle.c	(working copy)
@@ -68,6 +68,9 @@
 	/* By default do not create store */
 	sh->create_store = 0;
 
+	/* Rebuild the file_contexts by default */
+	sh->do_rebuild_file_context = 1;
+
 	/* Set timeout: some default value for now, later use config */
 	sh->timeout = SEMANAGE_COMMIT_READ_WAIT;
 
@@ -100,6 +103,15 @@
 	return;
 }
 
+void semanage_set_rebuild_file_context(semanage_handle_t * sh, int do_rebuild_file_context)
+{
+
+	assert(sh != NULL);
+
+	sh->do_rebuild_file_context = do_rebuild_file_context;
+	return;
+}
+
 void semanage_set_create_store(semanage_handle_t * sh, int create_store)
 {
 
Index: libsemanage/Makefile
===================================================================
--- libsemanage/Makefile	(revision 2587)
+++ libsemanage/Makefile	(working copy)
@@ -1,6 +1,9 @@
 all: 
 	$(MAKE) -C src all
 
+swigify: 
+	$(MAKE) -C src swigify
+
 pywrap: 
 	$(MAKE) -C src pywrap
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
