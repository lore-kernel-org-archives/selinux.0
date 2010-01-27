From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, txtoth@gmail.com,
        Caleb Case <ccase@tresys.com>
Subject: [PATCH 2/2] [src-policy] cil compiler flags in semanage.conf
Date: Wed, 27 Jan 2010 12:12:40 -0500
Message-Id: <1264612360-32106-3-git-send-email-ccase@tresys.com>
In-Reply-To: <1264612360-32106-2-git-send-email-ccase@tresys.com>
References: <1264612360-32106-1-git-send-email-ccase@tresys.com>
 <1264612360-32106-2-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds the 'cil-flags' configuration variable to semanage.conf.
The flags provided will be passed to the cil compiler as the last
arguments. It also adds SEMANAGE_CONF_CIL_FLAGS which can be overridden
with compiler flags.

Example:

This sets the temporary build location to /tmp/last-semanage, tells the
refpol_ilc to overwrite the directory if it already exists (--force),
and to leave it after compilation is complete (--cleanup=false). This
directory will always contain the last build attempt of semanage.

# cat /etc/selinux/semanage.conf
<snip>
cil-flags = "--force --cleanup=false --tmp=/tmp/last-semanage"

# semodule -B
# ls /tmp/last-semanage/build/
base.conf   Changelog     doc       policy            support
base.fc     config        INSTALL   README            tmp
base.pp     COPYING       Makefile  Rules.modular     VERSION
build.conf  _defines.ref  man       Rules.monolithic

Beware that simultaneous builds will all use the same tmp space for
their builds and cause indeterminate behavior. Setting the flags like
this is primarily useful for debugging policy compilation issues.

Another option is to not set the tmp location. This will allow
simultaneous builds, but may make finding the last build harder. If not
cleaned up manually this may fill the drive.

# cat /etc/selinux/semanage.conf
<snip>
cil-flags = "--force --cleanup=false"

# semodule -B
# semodule -B
# ls -lht /tmp/tmp*-refpol_ilc
/tmp/tmpXotSm3-refpol_ilc:
total 4.0K
drwxr-xr-x 9 root root 4.0K 2010-01-26 23:42 build

/tmp/tmpEv18Kx-refpol_ilc:
total 4.0K
drwxr-xr-x 9 root root 4.0K 2010-01-26 23:40 build
---
 libsemanage/src/conf-parse.y     |   14 +++++++++++++-
 libsemanage/src/conf-scan.l      |    1 +
 libsemanage/src/semanage_conf.h  |    5 +++++
 libsemanage/src/semanage_store.c |   30 +++++++++++++++++++++++++++++-
 4 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index 831eb14..bf7c84a 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -59,7 +59,7 @@ static int parse_errors;
 %token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LINKED
 %token LOAD_POLICY_START SETFILES_START DISABLE_GENHOMEDIRCON HANDLE_UNKNOWN
 %token BZIP_BLOCKSIZE BZIP_SMALL
-%token CIL_PATH
+%token CIL_PATH CIL_FLAGS
 %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_END
 %token PROG_PATH PROG_ARGS
 %token <s> ARG
@@ -87,6 +87,7 @@ single_opt:     module_store
 	|	bzip_blocksize
 	|	bzip_small
 	|	cil_path
+	|	cil_flags
         ;
 
 module_store:   MODULE_STORE '=' ARG {
@@ -193,6 +194,11 @@ cil_path: CIL_PATH '=' ARG {
 	current_conf->cil_path = $3;
 }
 
+cil_flags: CIL_FLAGS '=' ARG {
+	free(current_conf->cil_flags);
+	current_conf->cil_flags = $3;
+}
+
 command_block: 
                 command_start external_opts BLOCK_END  {
                         if (new_external->path == NULL) {
@@ -268,6 +274,11 @@ static int semanage_conf_init(semanage_conf_t * conf)
 		return -1;
 	}
 
+	conf->cil_flags = strdup(SEMANAGE_CONF_CIL_FLAGS);
+	if (conf->cil_flags == NULL) {
+		return -1;
+	}
+
 	conf->save_previous = 0;
 	conf->save_linked = 0;
 
@@ -353,6 +364,7 @@ void semanage_conf_destroy(semanage_conf_t * conf)
 	if (conf != NULL) {
 		free(conf->store_path);
 		free(conf->cil_path);
+		free(conf->cil_flags);
 		semanage_conf_external_prog_destroy(conf->load_policy);
 		semanage_conf_external_prog_destroy(conf->setfiles);
 		semanage_conf_external_prog_destroy(conf->mod_prog);
diff --git a/libsemanage/src/conf-scan.l b/libsemanage/src/conf-scan.l
index 840786d..9e469d6 100644
--- a/libsemanage/src/conf-scan.l
+++ b/libsemanage/src/conf-scan.l
@@ -50,6 +50,7 @@ handle-unknown    return HANDLE_UNKNOWN;
 bzip-blocksize	return BZIP_BLOCKSIZE;
 bzip-small	return BZIP_SMALL;
 cil-path	return CIL_PATH;
+cil-flags	return CIL_FLAGS;
 "[load_policy]"   return LOAD_POLICY_START;
 "[setfiles]"      return SETFILES_START;
 "[verify module]" return VERIFY_MOD_START;
diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage_conf.h
index 0700ec1..63ef9c0 100644
--- a/libsemanage/src/semanage_conf.h
+++ b/libsemanage/src/semanage_conf.h
@@ -28,6 +28,10 @@
 #define SEMANAGE_CONF_CIL_PATH "/usr/bin/refpol_ilc"
 #endif
 
+#ifndef SEMANAGE_CONF_CIL_FLAGS
+#define SEMANAGE_CONF_CIL_FLAGS ""
+#endif
+
 /* libsemanage has its own configuration file.	It has two main parts:
  *  - single options
  *  - external programs to execute whenever a policy is to be loaded
@@ -47,6 +51,7 @@ typedef struct semanage_conf {
 	int bzip_blocksize;
 	int bzip_small;
 	char *cil_path;
+	char *cil_flags;
 	struct external_prog *load_policy;
 	struct external_prog *setfiles;
 	struct external_prog *mod_prog, *linked_prog, *kernel_prog;
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 5b87864..d5bb810 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -3117,6 +3117,10 @@ int semanage_compile_cil(semanage_handle_t *sh, sepol_module_package_t **base)
 	int io[3];
 	int io_len = 3;
 
+	int j = 0;
+	char **flags = NULL;
+	int flags_len = 0;
+
 	int i = 0;
 	char path[PATH_MAX];
 	semanage_module_info_t *modinfos = NULL;
@@ -3157,6 +3161,15 @@ int semanage_compile_cil(semanage_handle_t *sh, sepol_module_package_t **base)
 		goto cleanup;
 	}
 
+	/* get compiler flags */
+	flags = split_args("", sh->conf->cil_flags, "", "");
+	if (flags == NULL) {
+		ERR(sh, "Out of memory!");
+		status = -1;
+		goto cleanup;
+	}
+	for (flags_len = 0; flags[flags_len] != NULL; flags_len++);
+
 	/* get modinfos */
 	ret = semanage_module_list_all(sh, &modinfos, &modinfos_len);
 	if (ret != 0) {
@@ -3165,7 +3178,7 @@ int semanage_compile_cil(semanage_handle_t *sh, sepol_module_package_t **base)
 	}
 
 	/* argv for module paths */
-	argv = calloc(modinfos_len + 2, sizeof(char *));
+	argv = calloc(modinfos_len + 2 + flags_len, sizeof(char *));
 	if (argv == NULL) {
 		ERR(sh, "Out of memory!");
 		status = -1;
@@ -3201,6 +3214,20 @@ int semanage_compile_cil(semanage_handle_t *sh, sepol_module_package_t **base)
 		}
 	}
 
+	/* for each flag
+	 *
+	 * Note: that i is not reset to 0 and
+	 *       that j is 1 (to avoid the prog name)
+	 */
+	for(j = 1; j < flags_len; i++, j++) {
+		argv[i + 1] = strdup(flags[j]);
+		if (argv[i + 1] == NULL) {
+			ERR(sh, "Out of memory!");
+			status = -1;
+			goto cleanup;
+		}
+	}
+
 	argv[0] = strdup(cilc);
 	if (argv[0] == NULL) {
 		ERR(sh, "Out of memory!");
@@ -3289,6 +3316,7 @@ cleanup:
 	}
 	free(modinfos);
 
+	free(flags);
 	free(data);
 
 	for (i = 0; i < io_len; i++) {
-- 
1.6.3.3


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
