Message-ID: <46FB08A0.2000308@redhat.com>
Date: Wed, 26 Sep 2007 21:34:24 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Todd Miller <Tmiller@tresys.com>
CC: sds@tycho.nsa.gov, selinux@tycho.nsa.gov
Subject: Re: I am concerned about putting genhomedircon changesinlibsemanage
 into Fedora 8.
References: <200709262020.l8QKKDX7025382@tex.courtesan.com> <46FACCF8.2060500@redhat.com> <6FE441CD9F0C0C479F2D88F959B01588011446F4@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588011446F4@exchange.columbia.tresys.com>
Content-Type: multipart/mixed;
 boundary="------------000300090208060007060605"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000300090208060007060605
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Todd Miller wrote:
> I see the issue, getpwnam_r() has surprising semantics when a user is not found.  I'll have a fix for that tomorrow AM.
> 
>  - todd
> 
> 
> -----Original Message-----
> 
> But
> /usr/sbin/semanage login -m -s guest_u __default__
> 
> Is causing a segfault in genhomedircon line 627
Already have it.

This is a repatch off of libsemanage-2.0.9

It should include your stuff plus it gets the fallback_user by looking
up the __default__ login record.

That way if I change the __default__ record to use xguest_u, it will
build all user accounts with this context.

getpwnam_r returns 0 even if an account does not exist.

So you need to check the pointer.

A couple of other translation problems also.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG+whdrlYvE4MpobMRAlR1AKDo9/UsBwEpuVTITZ3TNGPcJUzj3wCfQuqi
3sJtxxIok2gVI0olG85lAnM=
=1n+T
-----END PGP SIGNATURE-----

--------------000300090208060007060605
Content-Type: text/x-patch;
 name="libsemanage-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibsemanage/include/semanage/handle.h libsemanage-2.0.9/include/semanage/handle.h
--- nsalibsemanage/include/semanage/handle.h	2007-08-20 19:15:36.000000000 -0400
+++ libsemanage-2.0.9/include/semanage/handle.h	2007-09-26 19:49:09.000000000 -0400
@@ -69,6 +69,10 @@
  * 1 for yes, 0 for no (default) */
 void semanage_set_create_store(semanage_handle_t * handle, int create_store);
 
+/* set whether to generate homedir file context
+ * 1 for yes (default), 0 for no */
+void semanage_set_rebuild_file_context(semanage_handle_t * handle, int do_rebuild_file_context);
+
 /* Set whether or not to disable dontaudits upon commit */
 void semanage_set_disable_dontaudit(semanage_handle_t * handle, int disable_dontaudit);
 
diff --exclude-from=exclude -N -u -r nsalibsemanage/Makefile libsemanage-2.0.9/Makefile
--- nsalibsemanage/Makefile	2007-07-16 14:20:39.000000000 -0400
+++ libsemanage-2.0.9/Makefile	2007-09-26 19:49:09.000000000 -0400
@@ -1,6 +1,9 @@
 all: 
 	$(MAKE) -C src all
 
+swigify: 
+	$(MAKE) -C src swigify
+
 pywrap: 
 	$(MAKE) -C src pywrap
 
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/direct_api.c libsemanage-2.0.9/src/direct_api.c
--- nsalibsemanage/src/direct_api.c	2007-09-26 19:37:44.000000000 -0400
+++ libsemanage-2.0.9/src/direct_api.c	2007-09-26 19:49:09.000000000 -0400
@@ -702,7 +702,7 @@
 		goto cleanup;
 
 	if (sh->do_rebuild || modified) {
-		retval = semanage_install_sandbox(sh);
+		retval = semanage_install_sandbox(sh, out);
 	}
 
       cleanup:
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/genhomedircon.c libsemanage-2.0.9/src/genhomedircon.c
--- nsalibsemanage/src/genhomedircon.c	2007-09-13 08:21:11.000000000 -0400
+++ libsemanage-2.0.9/src/genhomedircon.c	2007-09-26 19:49:09.000000000 -0400
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
@@ -352,9 +356,48 @@
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
+		sepol_msg_set_callback(s->h_semanage->sepolh, semanage_msg_relay_handler, NULL);		
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
@@ -369,8 +412,12 @@
 
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
@@ -380,8 +427,8 @@
 	return STATUS_ERR;
 }
 
-static int write_home_root_context(FILE * out, semanage_list_t * tpl,
-				   char *homedir)
+static int write_home_root_context(genhomedircon_settings_t * s, FILE * out,
+				   semanage_list_t * tpl, char *homedir)
 {
 	replacement_pair_t repl[] = {
 		{.search_for = TEMPLATE_HOME_ROOT,.replace_with = homedir},
@@ -391,8 +438,12 @@
 
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
@@ -402,7 +453,8 @@
 	return STATUS_ERR;
 }
 
-static int write_user_context(FILE * out, semanage_list_t * tpl, char *user,
+static int write_user_context(genhomedircon_settings_t * s, FILE * out,
+			      semanage_list_t * tpl, char *user,
 			      char *seuser, char *role_prefix)
 {
 	replacement_pair_t repl[] = {
@@ -415,8 +467,12 @@
 
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
@@ -496,6 +552,32 @@
 	free(temp);
 }
 
+static char *global_fallback_user=NULL;
+static char *global_fallback_user_prefix=NULL;
+
+static int set_fallback_user(const char *user, const char *prefix) {
+	free(global_fallback_user);
+	free(global_fallback_user_prefix);
+	global_fallback_user = strdup(user);
+	global_fallback_user_prefix = strdup(prefix);
+	if (!global_fallback_user || !global_fallback_user_prefix)
+		return -1;
+	return 0;
+}
+
+static char *get_fallback_user(void) {
+	return global_fallback_user;
+}
+
+static char *get_fallback_user_prefix(void) {
+	return global_fallback_user_prefix;
+}
+
+static void free_fallback_user(void) {
+	free(global_fallback_user);
+	free(global_fallback_user_prefix);
+}
+
 static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
 					     int *errors)
 {
@@ -538,13 +620,39 @@
 
 	for (i = 0; i < nseusers; i++) {
 		name = semanage_seuser_get_name(seuser_list[i]);
+		if (strcmp(name, DEFAULT_LOGIN) == 0) {
+			seuname = semanage_seuser_get_sename(seuser_list[i]);
+
+			/* find the user structure given the name */
+			u = bsearch(seuname, user_list, nusers, sizeof(semanage_user_t *),
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
+	char *fallback_user = get_fallback_user();
+			
+	for (i = 0; i < nseusers; i++) {
+		name = semanage_seuser_get_name(seuser_list[i]);
 		seuname = semanage_seuser_get_sename(seuser_list[i]);
 
-		if (strcmp(seuname, FALLBACK_USER) == 0)
+		if (strcmp(seuname, fallback_user) == 0)
 			continue;
-		if (strcmp(seuname, DEFAULT_LOGIN) == 0)
+
+		if (strcmp(name, DEFAULT_LOGIN) == 0)
 			continue;
-		if (strcmp(seuname, TEMPLATE_SEUSER) == 0)
+		
+		if (strcmp(name, TEMPLATE_SEUSER) == 0)
 			continue;
 
 		/* find the user structure given the name */
@@ -563,6 +671,9 @@
 				*errors = STATUS_ERR;
 				goto cleanup;
 			}
+		}
+
+		if (!pwent) {
 			WARN(s->h_semanage,
 			     "user %s not in password file", name);
 			continue;
@@ -602,7 +713,7 @@
 	return head;
 }
 
-static int write_gen_home_dir_context(FILE * out, genhomedircon_settings_t * s,
+static int write_gen_home_dir_context(genhomedircon_settings_t * s, FILE * out,
 				      semanage_list_t * user_context_tpl,
 				      semanage_list_t * homedir_context_tpl)
 {
@@ -615,13 +726,13 @@
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
@@ -662,6 +773,14 @@
 		goto done;
 	}
 
+	if (write_gen_home_dir_context(s, out, user_context_tpl,
+				       homedir_context_tpl) != STATUS_SUCCESS) {
+		retval = STATUS_ERR;
+	}
+
+	char *fallback_user = get_fallback_user();
+	char *fallback_user_prefix = get_fallback_user_prefix();
+
 	for (h = homedirs; h; h = h->next) {
 		Ustr *temp = ustr_dup_cstr(h->data);
 
@@ -671,16 +790,16 @@
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
@@ -690,16 +809,12 @@
 
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
@@ -711,7 +826,9 @@
 	return retval;
 }
 
-int semanage_genhomedircon(semanage_handle_t * sh, int usepasswd)
+int semanage_genhomedircon(semanage_handle_t * sh,
+			   sepol_policydb_t * policydb,
+			   int usepasswd)
 {
 	genhomedircon_settings_t s;
 	FILE *out = NULL;
@@ -719,12 +836,15 @@
 
 	assert(sh);
 
+	set_fallback_user(FALLBACK_USER, FALLBACK_USER_PREFIX);
+
 	s.homedir_template_path =
 	    semanage_path(SEMANAGE_TMP, SEMANAGE_HOMEDIR_TMPL);
 	s.fcfilepath = semanage_path(SEMANAGE_TMP, SEMANAGE_FC_HOMEDIRS);
 
 	s.usepasswd = usepasswd;
 	s.h_semanage = sh;
+	s.policydb = policydb;
 
 	if (!(out = fopen(s.fcfilepath, "w"))) {
 		/* couldn't open output file */
@@ -735,5 +855,8 @@
 	retval = write_context_file(&s, out);
 
 	fclose(out);
+
+	free_fallback_user();
+
 	return retval;
 }
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/genhomedircon.h libsemanage-2.0.9/src/genhomedircon.h
--- nsalibsemanage/src/genhomedircon.h	2007-08-23 16:52:25.000000000 -0400
+++ libsemanage-2.0.9/src/genhomedircon.h	2007-09-26 19:49:09.000000000 -0400
@@ -22,6 +22,7 @@
 
 #include "utilities.h"
 
-int semanage_genhomedircon(semanage_handle_t * sh, int usepasswd);
+int semanage_genhomedircon(semanage_handle_t * sh,
+			   sepol_policydb_t * policydb, int usepasswd);
 
 #endif
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/handle.c libsemanage-2.0.9/src/handle.c
--- nsalibsemanage/src/handle.c	2007-08-20 19:15:37.000000000 -0400
+++ libsemanage-2.0.9/src/handle.c	2007-09-26 19:49:09.000000000 -0400
@@ -68,6 +68,7 @@
 	/* By default do not create store */
 	sh->create_store = 0;
 
+	sh->do_rebuild_file_context = 1;
 	/* Set timeout: some default value for now, later use config */
 	sh->timeout = SEMANAGE_COMMIT_READ_WAIT;
 
@@ -100,6 +101,15 @@
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
 
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/handle.h libsemanage-2.0.9/src/handle.h
--- nsalibsemanage/src/handle.h	2007-07-16 14:20:38.000000000 -0400
+++ libsemanage-2.0.9/src/handle.h	2007-09-26 19:49:09.000000000 -0400
@@ -58,6 +58,7 @@
 	int is_connected;
 	int is_in_transaction;
 	int do_reload;		/* whether to reload policy after commit */
+	int do_rebuild_file_context;	/* whether to generate homedircontext */
 	int do_rebuild;		/* whether to rebuild policy if there were no changes */
 	int modules_modified;
 	int create_store;	/* whether to create the store if it does not exist
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/libsemanage.map libsemanage-2.0.9/src/libsemanage.map
--- nsalibsemanage/src/libsemanage.map	2007-08-20 19:15:37.000000000 -0400
+++ libsemanage-2.0.9/src/libsemanage.map	2007-09-26 19:49:09.000000000 -0400
@@ -9,6 +9,7 @@
 	  semanage_module_list_nth; semanage_module_get_name;
 	  semanage_module_get_version; semanage_select_store;
 	  semanage_reload_policy; semanage_set_reload; semanage_set_rebuild;
+	  semanage_set_rebuild_file_context;
 	  semanage_user_*; semanage_bool_*; semanage_seuser_*;
 	  semanage_iface_*; semanage_port_*; semanage_context_*;
 	  semanage_node_*;
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/semanage_store.c libsemanage-2.0.9/src/semanage_store.c
--- nsalibsemanage/src/semanage_store.c	2007-09-26 19:37:44.000000000 -0400
+++ libsemanage-2.0.9/src/semanage_store.c	2007-09-26 19:49:09.000000000 -0400
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
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/semanage_store.h libsemanage-2.0.9/src/semanage_store.h
--- nsalibsemanage/src/semanage_store.h	2007-08-23 16:52:25.000000000 -0400
+++ libsemanage-2.0.9/src/semanage_store.h	2007-09-26 20:10:59.000000000 -0400
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

--------------000300090208060007060605
Content-Type: application/octet-stream;
 name="libsemanage-rhat.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libsemanage-rhat.patch.sig"

iD8DBQBG+whdrlYvE4MpobMRAvKbAJ96+a0V55bLFZpnVpHXnskZyoEeEQCghVEyvFbLj5mv
3AUEP6mZQ4qPDBo=
--------------000300090208060007060605--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
