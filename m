From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, txtoth@gmail.com,
        Caleb Case <ccase@tresys.com>
Subject: [PATCH 1/2] [src-policy] cil compiler path in semanage.conf
Date: Wed, 27 Jan 2010 12:12:39 -0500
Message-Id: <1264612360-32106-2-git-send-email-ccase@tresys.com>
In-Reply-To: <1264612360-32106-1-git-send-email-ccase@tresys.com>
References: <1264612360-32106-1-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds the 'cil-path' configuration variable to semanage.conf.
It also defines SEMANAGE_CONF_CIL_PATH which can be overridden with
compiler flags.
---
 libsemanage/src/conf-parse.y     |   13 +++++++++++++
 libsemanage/src/conf-scan.l      |    1 +
 libsemanage/src/semanage_conf.h  |    5 +++++
 libsemanage/src/semanage_store.c |   11 +----------
 4 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index e885202..831eb14 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -59,6 +59,7 @@ static int parse_errors;
 %token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LINKED
 %token LOAD_POLICY_START SETFILES_START DISABLE_GENHOMEDIRCON HANDLE_UNKNOWN
 %token BZIP_BLOCKSIZE BZIP_SMALL
+%token CIL_PATH
 %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_END
 %token PROG_PATH PROG_ARGS
 %token <s> ARG
@@ -85,6 +86,7 @@ single_opt:     module_store
         |       handle_unknown
 	|	bzip_blocksize
 	|	bzip_small
+	|	cil_path
         ;
 
 module_store:   MODULE_STORE '=' ARG {
@@ -186,6 +188,11 @@ bzip_small:  BZIP_SMALL '=' ARG {
 	free($3);
 }
 
+cil_path: CIL_PATH '=' ARG {
+	free(current_conf->cil_path);
+	current_conf->cil_path = $3;
+}
+
 command_block: 
                 command_start external_opts BLOCK_END  {
                         if (new_external->path == NULL) {
@@ -256,6 +263,11 @@ static int semanage_conf_init(semanage_conf_t * conf)
 	conf->bzip_blocksize = 9;
 	conf->bzip_small = 0;
 
+	conf->cil_path = strdup(SEMANAGE_CONF_CIL_PATH);
+	if (conf->cil_path == NULL) {
+		return -1;
+	}
+
 	conf->save_previous = 0;
 	conf->save_linked = 0;
 
@@ -340,6 +352,7 @@ void semanage_conf_destroy(semanage_conf_t * conf)
 {
 	if (conf != NULL) {
 		free(conf->store_path);
+		free(conf->cil_path);
 		semanage_conf_external_prog_destroy(conf->load_policy);
 		semanage_conf_external_prog_destroy(conf->setfiles);
 		semanage_conf_external_prog_destroy(conf->mod_prog);
diff --git a/libsemanage/src/conf-scan.l b/libsemanage/src/conf-scan.l
index 8af5137..840786d 100644
--- a/libsemanage/src/conf-scan.l
+++ b/libsemanage/src/conf-scan.l
@@ -49,6 +49,7 @@ disable-genhomedircon return DISABLE_GENHOMEDIRCON;
 handle-unknown    return HANDLE_UNKNOWN;
 bzip-blocksize	return BZIP_BLOCKSIZE;
 bzip-small	return BZIP_SMALL;
+cil-path	return CIL_PATH;
 "[load_policy]"   return LOAD_POLICY_START;
 "[setfiles]"      return SETFILES_START;
 "[verify module]" return VERIFY_MOD_START;
diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage_conf.h
index 4118910..0700ec1 100644
--- a/libsemanage/src/semanage_conf.h
+++ b/libsemanage/src/semanage_conf.h
@@ -24,6 +24,10 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 
+#ifndef SEMANAGE_CONF_CIL_PATH
+#define SEMANAGE_CONF_CIL_PATH "/usr/bin/refpol_ilc"
+#endif
+
 /* libsemanage has its own configuration file.	It has two main parts:
  *  - single options
  *  - external programs to execute whenever a policy is to be loaded
@@ -42,6 +46,7 @@ typedef struct semanage_conf {
 	mode_t file_mode;
 	int bzip_blocksize;
 	int bzip_small;
+	char *cil_path;
 	struct external_prog *load_policy;
 	struct external_prog *setfiles;
 	struct external_prog *mod_prog, *linked_prog, *kernel_prog;
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index fedaa86..5b87864 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -503,15 +503,6 @@ const char *semanage_lang_conf_path(void)
 	return "/etc/selinux/language.d";
 }
 
-/* Return a fully-qualified path + filename to the cil compiler. The
- * caller must not alter the string returned (and hence why this
- * function return type is const).
- */
-static const char *semanage_cil_path(void)
-{
-	return "/usr/bin/refpol_ilc";
-}
-
 /**************** functions that create module store ***************/
 
 /* Check that the semanage store exists.  If 'create' is non-zero then
@@ -3137,7 +3128,7 @@ int semanage_compile_cil(semanage_handle_t *sh, sepol_module_package_t **base)
 	FILE *fp = NULL;
 	struct sepol_policy_file *pf = NULL;
 
-	const char *cilc = semanage_cil_path();
+	const char *cilc = sh->conf->cil_path;
 	const char *log = semanage_path(SEMANAGE_TMP, SEMANAGE_CIL_LOG);
 
 	char *data = NULL;
-- 
1.6.3.3


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
