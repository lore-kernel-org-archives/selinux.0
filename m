Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7LHhmK9009712
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2007 13:43:48 -0400
Received: from tresys-sp-eval (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7LHhktV010261
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2007 17:43:47 GMT
Received: from tresys-sp-eval (localhost.localdomain [127.0.0.1])
	by tresys-sp-eval (8.13.8/8.13.8) with ESMTP id l7LJAppQ008372
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2007 15:10:51 -0400
Received: (from paul@localhost)
	by tresys-sp-eval (8.13.8/8.13.8/Submit) id l7LJAomV008371
	for selinux@tycho.nsa.gov; Tue, 21 Aug 2007 15:10:50 -0400
Message-Id: <20070821191050.474805124@tresys.com>
References: <20070821191042.482612921@tresys.com>
Date: Tue, 21 Aug 2007 15:10:47 -0400
From: tmiller@tresys.com
To: selinux@tycho.nsa.gov
Subject: [patch 5/5] libsemanage: genhomedircon enable/disable GHDC
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch allows the user to disable genhomedircon by adding
"disable-genhomedircon = true" to /etc/selinux/semanage.conf

It also eliminates the [genhomedircon] section from semanage.conf

Index: selinux-unmodified-trunk/libsemanage/src/conf-parse.y
===================================================================
--- selinux-unmodified-trunk.orig/libsemanage/src/conf-parse.y
+++ selinux-unmodified-trunk/libsemanage/src/conf-parse.y
@@ -57,7 +57,7 @@ static int parse_errors;
 }
 
 %token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LINKED
-%token LOAD_POLICY_START SETFILES_START GENHOMEDIRCON_START
+%token LOAD_POLICY_START SETFILES_START DISABLE_GENHOMEDIRCON
 %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_END
 %token PROG_PATH PROG_ARGS
 %token <s> ARG
@@ -80,6 +80,7 @@ single_opt:     module_store
         |       file_mode
         |       save_previous
         |       save_linked
+        |       disable_genhomedircon
         ;
 
 module_store:   MODULE_STORE '=' ARG {
@@ -137,6 +138,16 @@ save_linked:    SAVE_LINKED '=' ARG {
                 }
         ;
 
+disable_genhomedircon: DISABLE_GENHOMEDIRCON '=' ARG {
+								if (strcasecmp($3, "false") == 0) {
+										current_conf->disable_genhomedircon = 0;
+									} else if (strcasecmp($3, "true") == 0) {
+										current_conf->disable_genhomedircon = 1;
+									} else {
+										yyerror("disable-genhomedircon can only be 'true' or 'false'");
+									}
+									free($3);
+					  }
 
 command_block: 
                 command_start external_opts BLOCK_END  {
@@ -164,14 +175,6 @@ command_start:
                                 YYABORT;
                         }
                 }
-        |       GENHOMEDIRCON_START {
-                        semanage_conf_external_prog_destroy(current_conf->genhomedircon);
-                        current_conf->genhomedircon = NULL;
-                        if (new_external_prog(&current_conf->genhomedircon) == -1) {
-                                parse_errors++;
-                                YYABORT;
-                        }
-                }
         ;
 
 verify_block:   verify_start external_opts BLOCK_END  {
@@ -239,16 +242,6 @@ static int semanage_conf_init(semanage_c
 		return -1;
 	}
 
-	if ((conf->genhomedircon =
-	     calloc(1, sizeof(*(current_conf->genhomedircon)))) == NULL) {
-		return -1;
-	}
-	if ((conf->genhomedircon->path =
-	     strdup("/usr/sbin/genhomedircon")) == NULL
-	    || (conf->genhomedircon->args = strdup("-t $@")) == NULL) {
-		return -1;
-	}
-
 	return 0;
 }
 
@@ -303,7 +296,6 @@ void semanage_conf_destroy(semanage_conf
 		free(conf->store_path);
 		semanage_conf_external_prog_destroy(conf->load_policy);
 		semanage_conf_external_prog_destroy(conf->setfiles);
-		semanage_conf_external_prog_destroy(conf->genhomedircon);
 		semanage_conf_external_prog_destroy(conf->mod_prog);
 		semanage_conf_external_prog_destroy(conf->linked_prog);
 		semanage_conf_external_prog_destroy(conf->kernel_prog);
Index: selinux-unmodified-trunk/libsemanage/src/conf-scan.l
===================================================================
--- selinux-unmodified-trunk.orig/libsemanage/src/conf-scan.l
+++ selinux-unmodified-trunk/libsemanage/src/conf-scan.l
@@ -44,9 +44,9 @@ expand-check      return EXPAND_CHECK;
 file-mode         return FILE_MODE;
 save-previous     return SAVE_PREVIOUS;
 save-linked       return SAVE_LINKED;
+disable-genhomedircon return DISABLE_GENHOMEDIRCON;
 "[load_policy]"   return LOAD_POLICY_START;
 "[setfiles]"      return SETFILES_START;
-"[genhomedircon]" return GENHOMEDIRCON_START;
 "[verify module]" return VERIFY_MOD_START;
 "[verify linked]" return VERIFY_LINKED_START;
 "[verify kernel]" return VERIFY_KERNEL_START;
Index: selinux-unmodified-trunk/libsemanage/src/semanage_conf.h
===================================================================
--- selinux-unmodified-trunk.orig/libsemanage/src/semanage_conf.h
+++ selinux-unmodified-trunk/libsemanage/src/semanage_conf.h
@@ -37,10 +37,10 @@ typedef struct semanage_conf {
 	int expand_check;
 	int save_previous;
 	int save_linked;
+	int disable_genhomedircon;
 	mode_t file_mode;
 	struct external_prog *load_policy;
 	struct external_prog *setfiles;
-	struct external_prog *genhomedircon;
 	struct external_prog *mod_prog, *linked_prog, *kernel_prog;
 } semanage_conf_t;
 
Index: selinux-unmodified-trunk/libsemanage/src/semanage_store.c
===================================================================
--- selinux-unmodified-trunk.orig/libsemanage/src/semanage_store.c
+++ selinux-unmodified-trunk/libsemanage/src/semanage_store.c
@@ -1062,11 +1062,13 @@ static int semanage_install_active(seman
 		goto cleanup;
 	}
 
-	snprintf(store_fc_hd, PATH_MAX, "%s%s", storepath, running_fc_hd);
-	if (semanage_copy_file(active_fc_hd, store_fc_hd, sh->conf->file_mode)
-	    == -1) {
-		ERR(sh, "Could not copy %s to %s.", active_fc_hd, store_fc_hd);
-		goto cleanup;
+	if (!sh->conf->disable_genhomedircon) {
+		snprintf(store_fc_hd, PATH_MAX, "%s%s", storepath, running_fc_hd);
+		if (semanage_copy_file(active_fc_hd, store_fc_hd, sh->conf->file_mode)
+			== -1) {
+			ERR(sh, "Could not copy %s to %s.", active_fc_hd, store_fc_hd);
+			goto cleanup;
+		}
 	}
 
 	snprintf(store_fc, PATH_MAX, "%s%s", storepath, running_fc);
@@ -1268,12 +1270,16 @@ int semanage_install_sandbox(semanage_ha
 		ERR(sh, "No setfiles program specified in configuration file.");
 		goto cleanup;
 	}
-
-	if ((retval =
-	     semanage_genhomedircon(sh, TRUE)) != 0) {
-		ERR(sh, "semanage_genhomedircon returned error code %d.",
-		    retval);
-		goto cleanup;
+	if (!sh->conf->disable_genhomedircon) {
+		if ((retval =
+		     semanage_genhomedircon(sh, TRUE)) != 0) {
+			ERR(sh, "semanage_genhomedircon returned error code %d.",
+			    retval);
+			goto cleanup;
+		}
+	} else {
+		WARN(sh, "WARNING: genhomedircon is disabled. \
+See /etc/selinux/semanage.conf if you need to enable it.");
 	}
 
 	if ((commit_num = semanage_commit_sandbox(sh)) < 0) {

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
