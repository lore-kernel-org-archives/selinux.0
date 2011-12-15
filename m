Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pBFFa9Hc028119
	for <selinux@tycho.nsa.gov>; Thu, 15 Dec 2011 10:36:09 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id pBFFa8sp000516
	for <selinux@tycho.nsa.gov>; Thu, 15 Dec 2011 15:36:08 GMT
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pBFFa7bl029883
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 15 Dec 2011 10:36:08 -0500
Received: from [10.16.62.208] (dhcp-10-16-62-208.boston.devel.redhat.com [10.16.62.208])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id pBFFa7Lv026446
	for <selinux@tycho.nsa.gov>; Thu, 15 Dec 2011 10:36:07 -0500
Message-ID: <4EEA13E7.6020106@redhat.com>
Date: Thu, 15 Dec 2011 10:36:07 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: For a long time /root has been treated differently in Red Hat Distributions
 then upstream policy.
Content-Type: multipart/mixed;
 boundary="------------010000050808070508050907"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010000050808070508050907
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

We do not want to label /root the same as a users homedir.  Because of
this we have carried a patch in libsemanage/genhomedircon.c to ignore
/root.

This patch adds a flag to semanage.conf, ignoredirs.  That will allow
distributions or users to specify directories that genhomedircon
should ignore when setting up users homedir labeling.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEUEARECAAYFAk7qE+cACgkQrlYvE4MpobMMNQCYxFzXOJL906yDItasgrulADeD
1ACgwXjQR0tbmgWlymn5E5ch68bx5DU=
=NteG
-----END PGP SIGNATURE-----

--------------010000050808070508050907
Content-Type: text/plain;
 name="libsemanage-ignoredirs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libsemanage-ignoredirs.patch"

diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man5/semanage.conf.5
index c60bdc6..6a8b4e8 100644
--- a/libsemanage/man/man5/semanage.conf.5
+++ b/libsemanage/man/man5/semanage.conf.5
@@ -56,6 +56,11 @@ It controls whether the previously linked module is saved (with name "base.linke
 It can be set to either "true" or "false" and by default it is set to "false" (the previous module is deleted).
 
 .TP
+.B ignoredirs
+List, separated by ";",  of directories to ignore when setting up users homedirs. 
+Some distributions use this to stop labeling /root as a homedir. 
+
+.TP
 .B usepasswd 
 Whether or not to enable the use getpwent() to obtain a list of home directories to label. It can be set to either "true" or "false".
 By default it is set to "true".
diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index 77c00b2..bbdac1d 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -58,7 +58,7 @@ static int parse_errors;
 }
 
 %token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LINKED
-%token LOAD_POLICY_START SETFILES_START DISABLE_GENHOMEDIRCON HANDLE_UNKNOWN USEPASSWD
+%token LOAD_POLICY_START SETFILES_START DISABLE_GENHOMEDIRCON HANDLE_UNKNOWN USEPASSWD IGNOREDIRS
 %token BZIP_BLOCKSIZE BZIP_SMALL
 %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_END
 %token PROG_PATH PROG_ARGS
@@ -84,6 +84,7 @@ single_opt:     module_store
         |       save_linked
         |       disable_genhomedircon
         |       usepasswd
+        |       ignoredirs
         |       handle_unknown
 	|	bzip_blocksize
 	|	bzip_small
@@ -166,6 +167,10 @@ usepasswd: USEPASSWD '=' ARG {
 	free($3);
  }
 
+ignoredirs: IGNOREDIRS '=' ARG {
+	current_conf->ignoredirs = strdup($3);
+ }
+
 handle_unknown: HANDLE_UNKNOWN '=' ARG {
 	if (strcasecmp($3, "deny") == 0) {
 		current_conf->handle_unknown = SEPOL_DENY_UNKNOWN;
@@ -262,6 +267,7 @@ static int semanage_conf_init(semanage_conf_t * conf)
 {
 	conf->store_type = SEMANAGE_CON_DIRECT;
 	conf->store_path = strdup(basename(semanage_policy_root()));
+	conf->ignoredirs = NULL;
 	conf->policyvers = sepol_policy_kern_vers_max();
 	conf->expand_check = 1;
 	conf->handle_unknown = -1;
@@ -354,6 +360,7 @@ void semanage_conf_destroy(semanage_conf_t * conf)
 {
 	if (conf != NULL) {
 		free(conf->store_path);
+		free(conf->ignoredirs);
 		semanage_conf_external_prog_destroy(conf->load_policy);
 		semanage_conf_external_prog_destroy(conf->setfiles);
 		semanage_conf_external_prog_destroy(conf->mod_prog);
diff --git a/libsemanage/src/conf-scan.l b/libsemanage/src/conf-scan.l
index e57119d..7ef4154 100644
--- a/libsemanage/src/conf-scan.l
+++ b/libsemanage/src/conf-scan.l
@@ -47,6 +47,7 @@ save-previous     return SAVE_PREVIOUS;
 save-linked       return SAVE_LINKED;
 disable-genhomedircon return DISABLE_GENHOMEDIRCON;
 usepasswd return USEPASSWD;
+ignoredirs        return IGNOREDIRS;
 handle-unknown    return HANDLE_UNKNOWN;
 bzip-blocksize	return BZIP_BLOCKSIZE;
 bzip-small	return BZIP_SMALL;
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 8fcfb88..4f919a6 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -992,7 +992,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	 * which requires the out policydb */
 	if (!sh->conf->disable_genhomedircon) {
 		if (out && (retval =
-		     semanage_genhomedircon(sh, out, sh->conf->usepasswd)) != 0) {
+			semanage_genhomedircon(sh, out, sh->conf->usepasswd, sh->conf->ignoredirs)) != 0) {
 			ERR(sh, "semanage_genhomedircon returned error code %d.",
 			    retval);
 			goto cleanup;
diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 847d87e..d2646ae 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -113,6 +113,61 @@ typedef struct {
 	int matched;
 } fc_match_handle_t;
 
+typedef struct IgnoreDir {
+	struct IgnoreDir *next;
+	char *dir;
+} ignoredir_t;
+
+ignoredir_t *ignore_head = NULL;
+
+static void ignore_free(void) {
+	ignoredir_t *next;
+
+	while (ignore_head) {
+		next = ignore_head->next;
+		free(ignore_head->dir);
+		free(ignore_head);
+		ignore_head = next;
+	}
+}
+
+static int ignore_setup(char *ignoredirs) {
+	char *tok;
+	ignoredir_t *ptr = NULL; 
+
+	tok = strtok(ignoredirs, ";");
+	while(tok) {
+		ptr = calloc(sizeof(ignoredir_t),1);
+		if (!ptr)
+			goto err;
+		ptr->dir = strdup(tok);
+		if (!ptr->dir)
+			goto err;
+
+		ptr->next = ignore_head;
+		ignore_head = ptr;
+
+		tok = strtok(NULL, ";");
+	}
+
+	return 0;
+err:
+	free(ptr);
+	ignore_free();
+	return -1;
+}
+
+static int ignore(const char *homedir) {
+	ignoredir_t *ptr = ignore_head;
+	while (ptr) {
+		if (strcmp(ptr->dir, homedir) == 0) {
+			return 1;
+		}
+		ptr = ptr->next;
+	}
+	return 0;
+}
+
 static semanage_list_t *default_shell_list(void)
 {
 	semanage_list_t *list = NULL;
@@ -314,6 +369,8 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 		}
 		if (strcmp(pwbuf->pw_dir, "/") == 0)
 			continue;
+		if (ignore(pwbuf->pw_dir))
+			continue;
 		if (semanage_str_count(pwbuf->pw_dir, '/') <= 1)
 			continue;
 		if (!(path = strdup(pwbuf->pw_dir))) {
@@ -829,6 +889,8 @@ static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
 			 * /root */
 			continue;
 		}
+		if (ignore(pwent->pw_dir))
+			continue;
 		if (push_user_entry(&head, name, seuname,
 				    prefix, pwent->pw_dir, level) != STATUS_SUCCESS) {
 			*errors = STATUS_ERR;
@@ -980,7 +1042,8 @@ done:
 
 int semanage_genhomedircon(semanage_handle_t * sh,
 			   sepol_policydb_t * policydb,
-			   int usepasswd)
+			   int usepasswd, 
+			   char *ignoredirs)
 {
 	genhomedircon_settings_t s;
 	FILE *out = NULL;
@@ -998,6 +1061,8 @@ int semanage_genhomedircon(semanage_handle_t * sh,
 	if (s.fallback_user == NULL || s.fallback_user_prefix == NULL || s.fallback_user_level == NULL)
 		return STATUS_ERR;
 
+	if (ignoredirs) ignore_setup(ignoredirs);
+
 	s.usepasswd = usepasswd;
 	s.h_semanage = sh;
 	s.policydb = policydb;
@@ -1014,6 +1079,7 @@ int semanage_genhomedircon(semanage_handle_t * sh,
 
 	free(s.fallback_user);
 	free(s.fallback_user_prefix);
+	ignore_free();
 
 	return retval;
 }
diff --git a/libsemanage/src/genhomedircon.h b/libsemanage/src/genhomedircon.h
index 443e345..3f9ef8f 100644
--- a/libsemanage/src/genhomedircon.h
+++ b/libsemanage/src/genhomedircon.h
@@ -23,6 +23,7 @@
 #include "utilities.h"
 
 int semanage_genhomedircon(semanage_handle_t * sh,
-			   sepol_policydb_t * policydb, int usepasswd);
+			   sepol_policydb_t * policydb, int usepasswd,
+			   char *ignoredirs);
 
 #endif
diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage_conf.h
index f58d9ac..95f8ec3 100644
--- a/libsemanage/src/semanage_conf.h
+++ b/libsemanage/src/semanage_conf.h
@@ -43,6 +43,7 @@ typedef struct semanage_conf {
 	mode_t file_mode;
 	int bzip_blocksize;
 	int bzip_small;
+	char *ignoredirs;	/* ";" separated of list for genhomedircon to ignore */
 	struct external_prog *load_policy;
 	struct external_prog *setfiles;
 	struct external_prog *mod_prog, *linked_prog, *kernel_prog;

--------------010000050808070508050907--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
