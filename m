Subject: [PATCH 2/4] features/fixes for rawhide and refpolicy
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-YOQGp9JZR35jAhV1rxbs"
Date: Mon, 24 Oct 2005 13:02:28 -0400
Message-Id: <1130173348.15661.30.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-YOQGp9JZR35jAhV1rxbs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Semanage fixes:
	
allows store selection
adds do_reload to handle
adds reload function
does not reload policy if operating on a different store
moves config file to /etc/selinux
bug fixes relating to opening files for write without O_TRUNC
added file_context splitting for homedir_template
adds genhomedircon and runs it after commit

Joshua Brindle

--=-YOQGp9JZR35jAhV1rxbs
Content-Disposition: attachment; filename=2-libsemanage.diff
Content-Type: text/x-patch; name=2-libsemanage.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -purN -x .svn libsemanage/src/conf-parse.y libsemanage/src/conf-parse.y
--- libsemanage/src/conf-parse.y	2005-10-20 14:26:44.000000000 -0400
+++ libsemanage/src/conf-parse.y	2005-10-24 08:12:26.000000000 -0400
@@ -22,6 +22,8 @@
 #include "semanage_conf.h"
 
 #include <sepol/policydb.h>
+#include <selinux/selinux.h>
+#include <semanage/handle.h>
 
 #include <stdio.h>
 #include <stdlib.h>
@@ -181,6 +183,15 @@ static int semanage_conf_init(semanage_c
 	    (conf->setfiles->args = strdup("-q -c $@ $<")) == NULL) {
 		return -1;
 	}
+
+	if ((conf->genhomedircon= calloc(1, sizeof(*(current_conf->genhomedircon)))) == NULL) {
+		return -1;
+	}
+	if ((conf->genhomedircon->path = strdup("/usr/sbin/genhomedircon")) == NULL ||
+	    (conf->genhomedircon->args = strdup("-t $@")) == NULL) {
+		return -1;
+	}
+
 	return 0;
 }
 
@@ -229,9 +240,10 @@ static void semanage_conf_external_prog_
  * including the pointer itself. */
 void semanage_conf_destroy(semanage_conf_t *conf) {
 	if (conf != NULL) {
-		free(conf->server_path);
+		free(conf->store_path);
 		semanage_conf_external_prog_destroy(conf->load_policy);
 		semanage_conf_external_prog_destroy(conf->setfiles);
+		semanage_conf_external_prog_destroy(conf->genhomedircon);
 		semanage_conf_external_prog_destroy(conf->mod_prog);
 		semanage_conf_external_prog_destroy(conf->linked_prog);
 		semanage_conf_external_prog_destroy(conf->kernel_prog);
@@ -246,7 +258,8 @@ int semanage_error(char *msg) {
 
 /* Take the string argument for a module store.	 If it is exactly the
  * word "direct" then have libsemanage directly manipulate the module
- * store.  Otherwise if it begins with a forward slash interpret it as
+ * store. The policy path will default to the active policy directory.
+ * Otherwise if it begins with a forward slash interpret it as
  * an absolute path to a named socket, to which a policy server is
  * listening on the other end.	Otherwise treat it as the host name to
  * an external server; if there is a colon in the name then everything
@@ -259,35 +272,29 @@ static int parse_module_store(char *arg)
 	if (arg == NULL) {
 		return -1;
 	}
-	free(current_conf->server_path);
-	if (strcmp(arg, "source") == 0) {
-		current_conf->store_type = SEMANAGE_CON_SOURCE;
-		current_conf->server_path = NULL;
-		current_conf->server_port = -1;
-		free(arg);
-	}
+	free(current_conf->store_path);
 	if (strcmp(arg, "direct") == 0) {
 		current_conf->store_type = SEMANAGE_CON_DIRECT;
-		current_conf->server_path = NULL;
+		current_conf->store_path = strdup(basename(selinux_policy_root()));
 		current_conf->server_port = -1;
 		free(arg);
 	}
 	else if(*arg == '/') {
 		current_conf->store_type = SEMANAGE_CON_POLSERV_LOCAL;
-		current_conf->server_path = arg;
+		current_conf->store_path = arg;
 		current_conf->server_port = -1;
 	}
 	else {
 		char *s;
 		current_conf->store_type = SEMANAGE_CON_POLSERV_REMOTE;
 		if ((s = strchr(arg, ':')) == NULL) {
-			current_conf->server_path = arg;
+			current_conf->store_path = arg;
 			current_conf->server_port = 4242;
 		}
 		else {
 			char *endptr;
 			*s = '\0';
-			current_conf->server_path = arg;
+			current_conf->store_path = arg;
 			current_conf->server_port = strtol(s + 1, &endptr, 10);
 			if (*(s + 1) == '\0' || *endptr != '\0') {
 				return -2;
diff -purN -x .svn libsemanage/src/direct_api.c libsemanage/src/direct_api.c
--- libsemanage/src/direct_api.c	2005-10-20 14:26:43.000000000 -0400
+++ libsemanage/src/direct_api.c	2005-10-24 08:12:26.000000000 -0400
@@ -18,6 +18,7 @@
  */
 
 #include <sepol/module.h>
+#include <selinux/selinux.h>
 
 #include <assert.h>
 #include <fcntl.h>
@@ -27,6 +28,7 @@
 #include <unistd.h>
 #include <sys/stat.h>
 #include <sys/types.h>
+#include <limits.h>
 
 #include "users_file.h"
 #include "seusers_file.h"
@@ -74,11 +76,18 @@ static struct semanage_policy_table dire
 /* Check that the module store exists, creating it if necessary.
  */
 int semanage_direct_connect(semanage_handle_t *sh) {
+	char polpath[PATH_MAX];
+
 	sh->sepolh = sepol_handle_create();
 	if (!sh->sepolh)
 		goto err;
 	sepol_msg_set_callback(sh->sepolh, semanage_msg_relay_handler, sh);
 
+	snprintf(polpath, PATH_MAX, "%s%s", selinux_path(), sh->conf->store_path);
+	
+	if (semanage_check_init(polpath))
+		goto err;
+
 	if (semanage_create_store(sh, 1) < 0) 
 		goto err;
 
@@ -254,7 +263,7 @@ static int parse_base_headers(semanage_h
 static int write_file(semanage_handle_t *sh,
 		      const char *filename, char *data, size_t num_bytes) {
 	int out;
-	if ((out = open(filename, O_WRONLY | O_CREAT, S_IRUSR | S_IWUSR)) == -1) {
+	if ((out = open(filename, O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR)) == -1) {
 		ERR(sh, "Could not open %s for writing.", filename);
 		return -1;
 	}
@@ -322,11 +331,15 @@ static int semanage_direct_commit(semana
 		goto cleanup;
 	}
 
-	/* write the linked file contexts */
-	if ((fc_filename = semanage_path(SEMANAGE_TMP, SEMANAGE_FC)) == NULL ||
+	/* write the linked file contexts template */
+	if ((fc_filename = semanage_path(SEMANAGE_TMP, SEMANAGE_FC_TMPL)) == NULL ||
 	    write_file(sh, fc_filename, sepol_module_package_get_file_contexts(base), sepol_module_package_get_file_contexts_len(base)) == -1) {
 		goto cleanup;
 	}
+	
+	if (semanage_split_fc(sh)) {
+		goto cleanup;
+	}
 
 	/* Expand the resulting policy */
 	if (semanage_expand_sandbox(sh, base) < 0)
@@ -512,7 +525,7 @@ static int semanage_direct_remove(semana
  */
 static int semanage_direct_list(semanage_handle_t *sh,
 				semanage_module_info_t **modinfo, int *num_modules) {
-	struct sepol_policy_file *pf;
+	struct sepol_policy_file *pf = NULL;
 	int i, retval = -1;
 	char **module_filenames = NULL;
 	int num_mod_files;
diff -purN -x .svn libsemanage/src/handle.c libsemanage/src/handle.c
--- libsemanage/src/handle.c	2005-10-20 14:26:43.000000000 -0400
+++ libsemanage/src/handle.c	2005-10-24 08:12:26.000000000 -0400
@@ -20,7 +20,6 @@
 
 /* This file implements only the publicly-visible handle functions to libsemanage. */
 
-#include <semanage/semanage.h>
 #include <selinux/selinux.h>
 
 #include <stdarg.h>
@@ -47,21 +46,15 @@ semanage_handle_t *semanage_handle_creat
 	if ((sh = calloc(1, sizeof(semanage_handle_t))) == NULL)
 		goto err;
 
-	/* Policy root */
-	const char *pr = selinux_policy_root();
-	if (!pr)
-		goto err;
-
-	if (semanage_check_init(pr))
-		goto err;
-
-	/* Config */
 	if ((conf_name = semanage_conf_path()) == NULL) 
 		goto err;
 
 	if ((sh->conf = semanage_conf_parse(conf_name)) == NULL)
 		goto err;
 
+	/* By default always reload policy after commit */
+	sh->do_reload = 1;
+
 	/* Set timeout: some default value for now, later use config */
 	sh->timeout = SEMANAGE_COMMIT_READ_WAIT; 
 
@@ -80,6 +73,27 @@ semanage_handle_t *semanage_handle_creat
 	return NULL;
 }
 
+void semanage_set_reload(semanage_handle_t *sh, int do_reload) {
+	
+	assert(sh != NULL);
+
+	sh->do_reload = do_reload;
+	return;
+}
+
+void semanage_select_store(semanage_handle_t *sh, char *storename,
+			  enum semanage_connect_type storetype) {
+	
+	assert(sh != NULL);
+
+	/* This just sets the storename to what the user requests, no 
+	   verification of existance will be done until connect */
+	sh->conf->store_path = storename;
+	sh->conf->store_type = storetype;
+
+	return;
+}
+
 int semanage_connect(semanage_handle_t *sh) {
 	assert(sh != NULL);
 	switch (sh->conf->store_type) {
diff -purN -x .svn libsemanage/src/handle.h libsemanage/src/handle.h
--- libsemanage/src/handle.h	2005-10-20 14:26:43.000000000 -0400
+++ libsemanage/src/handle.h	2005-10-22 18:00:04.000000000 -0400
@@ -60,6 +60,7 @@ struct semanage_handle {
 	} conn;
 	int is_connected;
 	int is_in_transaction;
+	int do_reload;		/* whether to reload policy after commit */
 
 	/* This timeout is used for transactions and waiting for lock
 	   -1 means wait indefinetely
diff -purN -x .svn libsemanage/src/libsemanage.map libsemanage/src/libsemanage.map
--- libsemanage/src/libsemanage.map	2005-10-13 13:34:06.000000000 -0400
+++ libsemanage/src/libsemanage.map	2005-10-22 18:00:04.000000000 -0400
@@ -7,6 +7,7 @@ LIBSEMANAGE_1.0 {
 	  semanage_module_install_base; semanage_module_remove;
 	  semanage_module_list; semanage_module_info_datum_destroy;
 	  semanage_module_list_nth; semanage_module_get_name;
-	  semanage_module_get_version;
+	  semanage_module_get_version; semanage_select_store;
+	  semanage_reload_policy; semanage_set_reload;
   local: *;
 };
diff -purN -x .svn libsemanage/src/Makefile libsemanage/src/Makefile
--- libsemanage/src/Makefile	2005-10-20 14:26:11.000000000 -0400
+++ libsemanage/src/Makefile	2005-10-21 13:54:09.000000000 -0400
@@ -4,7 +4,7 @@ LIBDIR ?= $(PREFIX)/lib
 SHLIBDIR ?= $(DESTDIR)/lib
 INCLUDEDIR ?= $(PREFIX)/include
 
-DEFAULT_SEMANAGE_CONF_LOCATION=$(PREFIX)/share/semanage/semanage.conf
+DEFAULT_SEMANAGE_CONF_LOCATION=$(DESTDIR)/etc/selinux/semanage.conf
 
 ifeq ($(DEBUG),1)
 	export CFLAGS = -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow
diff -purN -x .svn libsemanage/src/modules.c libsemanage/src/modules.c
--- libsemanage/src/modules.c	2005-10-13 13:34:06.000000000 -0400
+++ libsemanage/src/modules.c	2005-10-22 18:02:51.000000000 -0400
@@ -20,7 +20,6 @@
 
 /* This file implements only the publicly-visible module functions to libsemanage. */
 
-#include <semanage/semanage.h>
 #include "direct_api.h"
 #include "semanage_conf.h"
 #include "semanage_store.h"
diff -purN -x .svn libsemanage/src/semanage.c libsemanage/src/semanage.c
--- libsemanage/src/semanage.c	2005-10-20 14:27:37.000000000 -0400
+++ libsemanage/src/semanage.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,47 +0,0 @@
-/* Author: Joshua Brindle <jbrindle@tresys.co
- *	   Jason Tang	  <jtang@tresys.com>
- *
- * Copyright (C) 2004-2005 Tresys Technology, LLC
- *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <semanage/semanage.h>
-#include "direct_api.h"
-#include "semanage_conf.h"
-#include "semanage_store.h"
-#include <selinux/selinux.h>
-
-#include <stdarg.h>
-#include <assert.h>
-
-int semanage_init(void)
-{
-        /* Get the selinux policy root and pass to the path init function */
-        const char *pr = selinux_policy_root();
-        if (!pr)
-                return -1;
-
-        if (semanage_check_init(pr))
-                return -1;
-
-	return 0;
-}
-
-static void libsemanage_init(void) __attribute__ ((constructor));
-static void libsemanage_init(void)
-{
-	semanage_init();
-}
diff -purN -x .svn libsemanage/src/semanage.conf libsemanage/src/semanage.conf
--- libsemanage/src/semanage.conf	2005-10-20 14:27:37.000000000 -0400
+++ libsemanage/src/semanage.conf	2005-10-21 13:52:49.000000000 -0400
@@ -36,71 +36,3 @@ module-store = direct
 # version is necessary.
 #policy-version = 19
 
-# After a policy has been created this library will attempt to load it
-# by calling the load_policy utility.  If there are special
-# requirements (e.g., read booleans from a certain file) then add them
-# here.  Below are the default values.  The path should be absolute
-# (i.e., beginning with a slash).  Within 'args', the special sequence
-# "$@" will be replaced with the policy filename.
-#
-# Note that this option is ignored when using a policy management
-# server.
-#[load_policy]
-#path = /usr/sbin/load_policy
-#args = -b $@
-#[end]
-
-# In addition to loading a policy libsemanage will validate file
-# contexts by calling the setfiles utility.  As above, "$@" will be
-# replaced with the policy filename.  In addition "$<" will be
-# replaced with the file contexts filename.
-#
-# Note that this option is ignored when using a policy management
-# server.
-#[setfiles]
-#path = /usr/sbin/setfiles
-#args = -q -c $@ $<
-#[end]
-
-# Each program specified within a [verify] block is run during
-# committing.  There are three types of verifies allowed: module,
-# linked, and kernel.  Multiple verifies may exist for a stage; place
-# each program within its own [verify] block.  For each stage the
-# programs are executed in the order given below.  If a program ever
-# returns a non-zero value then the entire commit is aborted.
-#
-# Module verifies are executed for each source module prior to
-# linking.  After they have been linked each link verifier is run
-# against the linked base module.  Finally, each kernel verifier is
-# run against the final expanded kernel policy.  If these verifiers
-# all exit with a return value of 0 then that kernel policy will be
-# loaded.
-#
-# 'path' gives a path the verificaton program.  'args' is any
-# free-form string that supplies command line arguments to the
-# verifier.  Within args single quotes, double quotes, and backslashes
-# are metacharacters handled similarly to bash.  Within 'args', the
-# special sequence "$@" will be replaced with a filename to the entity
-# being checked: source module for module verifiers, linked module for
-# linked, kernel policy for kernel.
-#
-# Note that this option is ignored when using a policy management
-# server.
-#[verify module]
-#path = /usr/bin/some_module_verifier
-#args = -Wall -ansi -pedantic $@
-#[end]
-
-#[verify module]
-#path = /another/module/verify/program
-#args = -With -some_more arguments
-#[end]
-
-#[verify linked]
-#path = /usr/local/bin/some_link_verifier
-#[end]
-
-#[verify kernel]
-#path = /usr/sbin/kernel_verifier
-#args = "some argument" "some other parameter" -k $@
-#[end]
diff -purN -x .svn libsemanage/src/semanage_conf.h libsemanage/src/semanage_conf.h
--- libsemanage/src/semanage_conf.h	2005-10-20 14:27:37.000000000 -0400
+++ libsemanage/src/semanage_conf.h	2005-10-24 08:12:26.000000000 -0400
@@ -20,24 +20,22 @@
 #ifndef SEMANAGE_CONF_H
 #define SEMANAGE_CONF_H
 
+#include <semanage/handle.h>
+
 /* libsemanage has its own configuration file.	It has two main parts:
  *  - single options
  *  - external programs to execute whenever a policy is to be loaded
  */
 
-enum semanage_connect_type {
-	SEMANAGE_CON_INVALID = 0,
-	SEMANAGE_CON_SOURCE, SEMANAGE_CON_DIRECT,
-	SEMANAGE_CON_POLSERV_LOCAL, SEMANAGE_CON_POLSERV_REMOTE
-};
 typedef struct semanage_conf {
 	enum semanage_connect_type store_type;
-	char *server_path;
+	char *store_path;	/* used for both socket path and policy dir */
 	int server_port;
 	int policyvers;		/* version for server generated policies */
         int expand_check;
 	struct external_prog *load_policy;
 	struct external_prog *setfiles;
+	struct external_prog *genhomedircon;
 	struct external_prog *mod_prog, *linked_prog, *kernel_prog;
 } semanage_conf_t;
 
diff -purN -x .svn libsemanage/src/semanage_store.c libsemanage/src/semanage_store.c
--- libsemanage/src/semanage_store.c	2005-10-20 14:27:37.000000000 -0400
+++ libsemanage/src/semanage_store.c	2005-10-24 12:30:20.000000000 -0400
@@ -49,6 +49,7 @@ typedef struct dbase_policydb dbase_t;
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <limits.h>
 
 #include "debug.h"
 
@@ -58,7 +59,6 @@ enum semanage_file_defs {
 	SEMANAGE_ROOT, 
 	SEMANAGE_TRANS_LOCK, 
 	SEMANAGE_READ_LOCK,
-	SEMANAGE_CONF,
 	SEMANAGE_NUM_FILES
 };
 
@@ -70,8 +70,7 @@ static int semanage_paths_initialized = 
 static const char *semanage_relative_files[SEMANAGE_NUM_FILES] = {
 	"", 
 	"/semanage.trans.LOCK",
-	"/semanage.read.LOCK",
-	"/semanage.conf"
+	"/semanage.read.LOCK"
 };
 
 static const char *semanage_store_paths[SEMANAGE_NUM_STORES] = {
@@ -91,6 +90,8 @@ static const char *semanage_sandbox_path
 	"/base.pp",
 	"/base.linked",
 	"/file_contexts",
+	"/homedir_template",
+	"/file_contexts.template",
 	"/commit_num"
 };
 
@@ -192,11 +193,11 @@ const char *semanage_path(enum semanage_
  * configuration file.  The caller must not alter the string returned
  * (and hence why this function return type is const).
  *
- * This function shall never return a NULL, assuming that
- * semanage_check_init() was previously called.
+ * This is going to be hard coded to /etc/selinux/semanage.conf for
+ * the time being. FIXME
  */
 const char *semanage_conf_path(void) {
-	return semanage_files[SEMANAGE_CONF];
+	return "/etc/selinux/semanage.conf";
 }
 
 /**************** functions that create module store ***************/
@@ -293,10 +294,11 @@ static int semanage_filename_select(cons
 static int semanage_copy_file(const char *src, const char *dst) {
 	int in, out, retval = 0, amount_read;
 	char buf[4192];
+
 	if ((in = open(src, O_RDONLY)) == -1) {
 		return -1;
 	}
-	if ((out = open(dst, O_WRONLY | O_CREAT, S_IRUSR | S_IWUSR)) == -1) {
+	if ((out = open(dst, O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR)) == -1) {
 		close(in);
 		return -1;
 	}
@@ -764,37 +766,168 @@ static int semanage_exec_prog(semanage_h
 	return 0;	 /* never reached, but here to satisfy lint */
 }
 
+/* reloads the policy pointed to by the handle, used locally by install 
+ * and exported for user reload requests */
+int semanage_reload_policy(semanage_handle_t *sh) {
+	char running_policy[PATH_MAX];
+	int r = 0;
+	
+	if (!sh)
+		return -1;
+
+	snprintf(running_policy, PATH_MAX, "%s.%d",
+		 selinux_binary_policy_path(), sh->conf->policyvers);
+
+        if ((r = semanage_exec_prog(sh, sh->conf->load_policy, running_policy, "")) != 0) {
+                ERR(sh, "load_policy returned error code %d.", r);
+        }
+	return r;
+}
+
+/* This expands the file_context.tmpl file to file_context and homedirs.template */
+int semanage_split_fc(semanage_handle_t *sh) {
+	FILE *file_con;
+	int fc, hd, retval = 0;
+	char buf[PATH_MAX] = {0};
+
+	/* I use fopen here instead of open so that I can use fgets which only reads a single line */
+	file_con = fopen(semanage_path(SEMANAGE_TMP, SEMANAGE_FC_TMPL), "r");
+	if (!file_con) {
+		ERR(sh, "Could not open %s for reading.", semanage_path(SEMANAGE_TMP, SEMANAGE_FC_TMPL));
+		return -1;
+	}
+
+	fc = open(semanage_path(SEMANAGE_TMP, SEMANAGE_FC), O_WRONLY | O_CREAT | O_TRUNC,  S_IRUSR | S_IWUSR);
+	if (!fc) {
+		ERR(sh, "Could not open %s for writing.", semanage_path(SEMANAGE_TMP, SEMANAGE_FC));
+		return -1;
+	}
+	hd = open(semanage_path(SEMANAGE_TMP, SEMANAGE_HOMEDIR_TMPL), O_WRONLY | O_CREAT | O_TRUNC,  S_IRUSR | S_IWUSR);
+	if (!hd) {
+		ERR(sh, "Could not open %s for writing.", semanage_path(SEMANAGE_TMP, SEMANAGE_HOMEDIR_TMPL));
+		close(fc);
+		return -1;
+	}
+
+	while (fgets(buf, PATH_MAX, file_con)) {
+		if (strstr(buf, "HOME_DIR") ||
+		    strstr(buf, "HOME_ROOT") ||
+		    strstr(buf, "ROLE")) {
+			/* This contains one of the template variables, write it to homedir.template */
+			if (write(hd, buf, strnlen(buf, PATH_MAX)) == 0) {
+				ERR(sh, "Write to %s failed.", semanage_path(SEMANAGE_TMP, SEMANAGE_HOMEDIR_TMPL));
+				retval = -1;
+				goto cleanup;
+			}
+		} else {
+			if (write(fc, buf, strnlen(buf, PATH_MAX)) == 0) {
+				ERR(sh, "Write to %s failed.", semanage_path(SEMANAGE_TMP, SEMANAGE_FC));
+				retval = -1;	
+				goto cleanup;
+			}
+		}
+	}
+	
+cleanup:
+	fclose(file_con);
+	close(fc);
+	close(hd);	
+
+	return retval;
+		
+}	
+
 /* Actually load the contents of the current active directory into the
  * kernel.  Return 0 on success, -3 on error. */
 static int semanage_install_active(semanage_handle_t *sh) {
-	char running_policy[PATH_MAX];
+	int retval = -3, r, len;
+	char *storepath;
+	struct stat astore, istore;
 	const char *active_kernel = semanage_path(SEMANAGE_ACTIVE,SEMANAGE_KERNEL);
 	const char *active_fc = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_FC);
+	const char *active_hd = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_HOMEDIR_TMPL);
+
 	const char *running_fc = selinux_file_context_path();
-	int retval = -3, r;
-	int policyvers = sh->conf->policyvers;
+	const char *running_hd = selinux_homedir_context_path();
+	const char *running_policy = selinux_binary_policy_path();
+	const char *really_active_store = selinux_policy_root();
+
+	/* This is very unelegant, the right thing to do is export the path 
+	 * building code in libselinux so that you can get paths for a given 
+	 * POLICYTYPE and should probably be done in the future. */
+	char store_fc[PATH_MAX];
+	char store_hd[PATH_MAX];
+	char store_pol[PATH_MAX];
+	
+	len = strlen(really_active_store);
+	running_fc += len;
+	running_hd += len;
+	running_policy += len;
 
-	snprintf(running_policy, PATH_MAX, "%s.%d",
-		 selinux_binary_policy_path(), policyvers);
-	if (semanage_copy_file(active_kernel, running_policy) == -1) {
-		ERR(sh, "Could not copy %s to %s.", active_kernel, running_policy);
+	len = strlen(selinux_path()) + strlen(sh->conf->store_path) + 1;
+	storepath = (char *)malloc(len);
+	if (!storepath)
+		goto cleanup;
+	snprintf(storepath, PATH_MAX, "%s%s", selinux_path(), sh->conf->store_path);	
+
+	snprintf(store_pol, PATH_MAX, "%s%s.%d", storepath,
+		 running_policy, sh->conf->policyvers);
+	if (semanage_copy_file(active_kernel, store_pol) == -1) {
+		ERR(sh, "Could not copy %s to %s.", active_kernel, store_pol);
 		goto cleanup;
 	}
-	if (semanage_copy_file(active_fc, running_fc) == -1) {
-		ERR(sh, "Could not copy %s to %s.", active_fc, running_fc);
+
+	snprintf(store_hd, PATH_MAX, "%s%s", storepath, running_hd);	
+	if (semanage_copy_file(active_hd, store_hd) == -1) {
+		ERR(sh, "Could not copy %s to %s.", active_hd, store_hd);
 		goto cleanup;
 	}
-	if ((r = semanage_exec_prog(sh, sh->conf->load_policy, running_policy, "")) != 0) {
-		ERR(sh, "load_policy returned error code %d.", r);
+
+	snprintf(store_fc, PATH_MAX, "%s%s", storepath, running_fc);
+	if (semanage_copy_file(active_fc, store_fc) == -1) {
+		ERR(sh, "Could not copy %s to %s.", active_fc, store_fc);
 		goto cleanup;
 	}
+
+	if (!sh->do_reload)
+		goto skip_reload;
+
+	/* This stats what libselinux says the active store is (according to config)
+	 * and what we are installing to, to decide if they are the same store. If
+	 * they are not then we do not reload policy */	
+
+	if (stat(really_active_store, &astore) == 0) {
+
+		if (stat(storepath, &istore)) {
+			ERR(sh, "Could not stat store path %s.", storepath);
+			goto cleanup;
+		}
+
+		if (!(astore.st_ino == istore.st_ino &&
+    		      astore.st_dev == istore.st_dev)) { 
+			/* They are not the same store */
+			goto skip_reload;
+		}
+	}
+
+	if (semanage_reload_policy(sh)) {
+		goto cleanup;
+	}
+
+skip_reload:
 	
-	if ((r = semanage_exec_prog(sh, sh->conf->setfiles, running_policy, running_fc)) != 0) {
+	if ((r = semanage_exec_prog(sh, sh->conf->setfiles, store_pol, store_fc)) != 0) {
 		ERR(sh, "setfiles returned error code %d.", r);
 		goto cleanup;
 	}
+
+	if ((r = semanage_exec_prog(sh, sh->conf->genhomedircon, sh->conf->store_path, "")) != 0) {
+		ERR(sh, "genhomedircon returned error code %d.", r);
+		goto cleanup;
+	}
+
 	retval = 0;
- cleanup:
+cleanup:
 	return retval;
 }
 
@@ -819,7 +952,7 @@ static int semanage_commit_sandbox(seman
 	commit_number++;
 	memset(write_buf, 0, sizeof(write_buf));
 	snprintf(write_buf, sizeof(write_buf), "%d", commit_number);
-	if ((fd = open(commit_filename, O_WRONLY | O_CREAT, S_IRUSR | S_IWUSR)) == -1) {
+	if ((fd = open(commit_filename, O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR)) == -1) {
 		ERR(sh, "Could not open commit number file %s for writing.", commit_filename);
 		return -1;
 	}
@@ -922,7 +1055,7 @@ static int semanage_get_lock(semanage_ha
 	struct timeval origtime, curtime;
 	int got_lock = 0;
 
-	if ((fd = open(lock_file, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR)) == -1) {
+	if ((fd = open(lock_file, O_RDWR | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR)) == -1) {
 		ERR(sh, "Could not open direct %s at %s.", lock_name, lock_file);
 		return -1;
 	}
diff -purN -x .svn libsemanage/src/semanage_store.h libsemanage/src/semanage_store.h
--- libsemanage/src/semanage_store.h	2005-10-20 14:27:37.000000000 -0400
+++ libsemanage/src/semanage_store.h	2005-10-24 08:12:26.000000000 -0400
@@ -41,6 +41,8 @@ enum semanage_sandbox_defs {
 	SEMANAGE_BASE, 
 	SEMANAGE_LINKED, 
 	SEMANAGE_FC,
+	SEMANAGE_HOMEDIR_TMPL,
+	SEMANAGE_FC_TMPL,
 	SEMANAGE_COMMIT_NUM_FILE,
 	SEMANAGE_STORE_NUM_PATHS
 };
@@ -77,5 +79,6 @@ int semanage_verify_modules(semanage_han
 			    char **module_filenames, int num_modules);
 int semanage_verify_linked(semanage_handle_t *sh);
 int semanage_verify_kernel(semanage_handle_t *sh);
+int semanage_split_fc(semanage_handle_t *sh);
 
 #endif
diff -purN -x .svn libsemanage/include/semanage/handle.h libsemanage/include/semanage/handle.h
--- libsemanage/include/semanage/handle.h	2005-10-13 13:34:03.000000000 -0400
+++ libsemanage/include/semanage/handle.h	2005-10-22 18:00:03.000000000 -0400
@@ -38,6 +38,27 @@ semanage_handle_t *semanage_handle_creat
  * previously called if the handle was connected. */
 void semanage_handle_destroy(semanage_handle_t *);
 
+/* This is the type of connection to the store, for now only
+ * direct is supported */
+enum semanage_connect_type {
+        SEMANAGE_CON_INVALID = 0, SEMANAGE_CON_DIRECT,
+        SEMANAGE_CON_POLSERV_LOCAL, SEMANAGE_CON_POLSERV_REMOTE
+};
+
+/* This function allows you to specify the store to  connect to.
+ * It must be called after semanage_handle_create but before 
+ * semanage_connect. The argument should be the full path to the store.
+ */
+void semanage_select_store(semanage_handle_t *handle, char *path, 
+			  enum semanage_connect_type storetype);
+
+/* Just reload the policy */
+int semanage_reload_policy(semanage_handle_t *handle);
+
+/* set whether to reload the policy or not after a commit,
+ * 1 for yes (default), 0 for no */
+void semanage_set_reload(semanage_handle_t *handle, int do_reload);
+
 /* "Connect" to a manager based on the configuration and 
  * associate the provided handle with the connection.
  * If the connect fails then this function returns a negative value, 
diff -purN -x .svn libsemanage/include/semanage/semanage.h libsemanage/include/semanage/semanage.h
--- libsemanage/include/semanage/semanage.h	2005-10-18 11:02:27.000000000 -0400
+++ libsemanage/include/semanage/semanage.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,37 +0,0 @@
-/* Authors: Joshua Brindle  <jbrindle@tresys.com>
- *	    Jason Tang	    <jtang@tresys.com>
- *
- * Copyright (C) 2005 Tresys Technology, LLC
- *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#ifndef _SEMANAGE_SEMANAGE_H_
-#define _SEMANAGE_SEMANAGE_H_
-
-#include <semanage/handle.h>
-#include <semanage/modules.h>
-#include <semanage/debug.h>
-
-/*
- * Explicit libsemanage initialization.
- * This is normally handled via a constructor, but
- * an application may explicitly invoke it in order to
- * check for an error condition early prior to using any
- * other libsemanage interface.
- */
-int semanage_init(void);
-
-#endif

--=-YOQGp9JZR35jAhV1rxbs--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
