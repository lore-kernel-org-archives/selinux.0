Message-ID: <459EA231.9040802@mentalrootkit.com>
Date: Fri, 05 Jan 2007 14:08:33 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux Mail List <selinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [PATCH] semanage: optionally remove previous and linked	to	reduce
 disck usage
References: <459D31C2.2030409@mentalrootkit.com>	 <1168009924.18961.131.camel@moss-spartans.epoch.ncsc.mil>	 <459E7A96.9070909@mentalrootkit.com> <1168022412.18961.181.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1168022412.18961.181.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2007-01-05 at 11:19 -0500, Karl MacMillan wrote:
>> New version below:
>>
>> Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
> 

Another try below.

This patch adds two options to the semanage config file to control 
whether the previous module directory and linked module are saved after 
a successful commit to the policy store. The default is to delete both.

On my system this reduces the size of the module directory from 78mb to 
22mb.

Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

diff -r 701cfcc87cf7 libsemanage/src/conf-parse.y
--- a/libsemanage/src/conf-parse.y	Fri Jan 05 14:02:14 2007 -0500
+++ b/libsemanage/src/conf-parse.y	Fri Jan 05 14:06:00 2007 -0500
@@ -56,7 +56,7 @@ static int parse_errors;
          char *s;
  }

-%token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE
+%token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS 
SAVE_LINKED
  %token LOAD_POLICY_START SETFILES_START GENHOMEDIRCON_START
  %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_END
  %token PROG_PATH PROG_ARGS
@@ -78,6 +78,8 @@ single_opt:     module_store
          |       version
          |       expand_check
          |       file_mode
+        |       save_previous
+        |       save_linked
          ;

  module_store:   MODULE_STORE '=' ARG {
@@ -112,6 +114,30 @@ file_mode:   FILE_MODE '=' ARG  {
                  }
          ;

+save_previous:    SAVE_PREVIOUS '=' ARG {
+	                if (strcasecmp($3, "true") == 0)
+		                current_conf->save_previous = 1;
+			else if (strcasecmp($3, "false") == 0)
+				current_conf->save_previous = 0;		
+			else {
+				yyerror("save-previous can only be 'true' or 'false'");
+			}
+                }
+        ;
+
+
+save_linked:    SAVE_LINKED '=' ARG {
+	                if (strcasecmp($3, "true") == 0)
+		                current_conf->save_linked = 1;
+			else if (strcasecmp($3, "false") == 0)
+				current_conf->save_linked = 0;		
+			else {
+				yyerror("save-linked can only be 'true' or 'false'");
+			}
+                }
+        ;
+
+
  command_block:
                  command_start external_opts BLOCK_END  {
                          if (new_external->path == NULL) {
@@ -186,6 +212,9 @@ static int semanage_conf_init(semanage_c
  	conf->policyvers = sepol_policy_kern_vers_max();
  	conf->expand_check = 1;
  	conf->file_mode = 0644;
+
+	conf->save_previous = 0;
+	conf->save_linked = 0;

  	if ((conf->load_policy =
  	     calloc(1, sizeof(*(current_conf->load_policy)))) == NULL) {
@@ -284,6 +313,7 @@ void semanage_conf_destroy(semanage_conf

  int semanage_error(char *msg)
  {
+	fprintf(stderr, "error parsing semanage configuration file: %s\n", msg);
  	parse_errors++;
  	return 0;
  }
diff -r 701cfcc87cf7 libsemanage/src/conf-scan.l
--- a/libsemanage/src/conf-scan.l	Fri Jan 05 14:02:14 2007 -0500
+++ b/libsemanage/src/conf-scan.l	Fri Jan 05 14:06:00 2007 -0500
@@ -42,6 +42,8 @@ policy-version    return VERSION;
  policy-version    return VERSION;
  expand-check      return EXPAND_CHECK;
  file-mode         return FILE_MODE;
+save-previous     return SAVE_PREVIOUS;
+save-linked       return SAVE_LINKED;
  "[load_policy]"   return LOAD_POLICY_START;
  "[setfiles]"      return SETFILES_START;
  "[genhomedircon]" return GENHOMEDIRCON_START;
diff -r 701cfcc87cf7 libsemanage/src/direct_api.c
--- a/libsemanage/src/direct_api.c	Fri Jan 05 14:02:14 2007 -0500
+++ b/libsemanage/src/direct_api.c	Fri Jan 05 14:06:00 2007 -0500
@@ -509,18 +509,38 @@ static int semanage_direct_commit(semana
  		if (retval < 0)
  			goto cleanup;

-		/* write the linked base */
+		/* write the linked base if we want to save or we have a
+		 * verification program that wants it. */
  		linked_filename = semanage_path(SEMANAGE_TMP, SEMANAGE_LINKED);
  		if (linked_filename == NULL) {
  			retval = -1;
  			goto cleanup;
  		}
-		retval = semanage_write_module(sh, linked_filename, base);
-		if (retval < 0)
-			goto cleanup;
-		retval = semanage_verify_linked(sh);
-		if (retval < 0)
-			goto cleanup;
+		if (sh->conf->save_linked || sh->conf->linked_prog) {
+			retval = semanage_write_module(sh, linked_filename, base);
+			if (retval < 0)
+				goto cleanup;
+			retval = semanage_verify_linked(sh);
+			if (retval < 0)
+				goto cleanup;
+			/* remove the linked policy if we only wrote it for the
+			 * verification program. */
+			if (!sh->conf->save_linked) {
+				retval = unlink(linked_filename);
+				if (retval < 0) {
+					ERR(sh, "could not remove linked base %s",
+					    linked_filename);
+					goto cleanup;
+				}
+			}
+		} else {
+			/* Try to delete the linked copy - this is needed if
+			 * the save_link option has changed to prevent the
+			 * old linked copy from being copied forever. No error
+			 * checking is done because this is likely to fail because
+			 * the file does not exist - which is not an error. */
+			unlink(linked_filename);
+		}

  		/* ==================== File-backed ================== */

diff -r 701cfcc87cf7 libsemanage/src/semanage_conf.h
--- a/libsemanage/src/semanage_conf.h	Fri Jan 05 14:02:14 2007 -0500
+++ b/libsemanage/src/semanage_conf.h	Fri Jan 05 14:06:00 2007 -0500
@@ -35,6 +35,8 @@ typedef struct semanage_conf {
  	int server_port;
  	int policyvers;		/* version for server generated policies */
  	int expand_check;
+	int save_previous;
+	int save_linked;
  	mode_t file_mode;
  	struct external_prog *load_policy;
  	struct external_prog *setfiles;
diff -r 701cfcc87cf7 libsemanage/src/semanage_store.c
--- a/libsemanage/src/semanage_store.c	Fri Jan 05 14:02:14 2007 -0500
+++ b/libsemanage/src/semanage_store.c	Fri Jan 05 14:06:00 2007 -0500
@@ -1224,6 +1224,14 @@ static int semanage_commit_sandbox(seman
  		goto cleanup;
  	}

+	if (!sh->conf->save_previous) {
+		retval = semanage_remove_directory(backup);
+		if (retval < 0) {
+			ERR(sh, "Could not delete previous directory %s.", backup);
+			goto cleanup;
+		}
+	}
+
        cleanup:
  	semanage_release_active_lock(sh);
  	return retval;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
