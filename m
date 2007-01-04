Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l04Gu3wx012183
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2007 11:56:03 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l04GulVJ019170
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2007 16:56:48 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l04Guk0Q003739
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2007 11:56:46 -0500
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l04GukLn018552
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2007 11:56:46 -0500
Received: from [10.11.14.80] (vpn-14-80.rdu.redhat.com [10.11.14.80])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l04GukvC023873
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2007 11:56:46 -0500
Message-ID: <459D31C2.2030409@mentalrootkit.com>
Date: Thu, 04 Jan 2007 11:56:34 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: [PATCH] semanage: optionally remove previous and linked to reduce
 disck usage
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds two options to the semanage config file to control 
whether the previous module directory and linked module are saved after 
a successful commit to the policy store. The default is to delete both.

On my system this reduces the size of the module directory from 78mb to 
22mb.

Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

diff -r 5a199c52a29c libsemanage/src/conf-parse.y
--- a/libsemanage/src/conf-parse.y	Wed Jan 03 22:27:17 2007 -0500
+++ b/libsemanage/src/conf-parse.y	Thu Jan 04 11:48:29 2007 -0500
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
@@ -112,6 +114,24 @@ file_mode:   FILE_MODE '=' ARG  {
                  }
          ;

+save_previous:    SAVE_PREVIOUS '=' ARG {
+	                if (strcmp($3, "true") == 0)
+		                current_conf->save_previous = 1;
+			else
+				current_conf->save_previous = 0;		
+                }
+        ;
+
+
+save_linked:    SAVE_LINKED '=' ARG {
+	                if (strcmp($3, "true") == 0)
+		                current_conf->save_linked = 1;
+			else
+				current_conf->save_linked = 0;		
+                }
+        ;
+
+
  command_block:
                  command_start external_opts BLOCK_END  {
                          if (new_external->path == NULL) {
@@ -186,6 +206,9 @@ static int semanage_conf_init(semanage_c
  	conf->policyvers = sepol_policy_kern_vers_max();
  	conf->expand_check = 1;
  	conf->file_mode = 0644;
+
+	conf->save_previous = 0;
+	conf->save_linked = 0;

  	if ((conf->load_policy =
  	     calloc(1, sizeof(*(current_conf->load_policy)))) == NULL) {
@@ -284,6 +307,7 @@ void semanage_conf_destroy(semanage_conf

  int semanage_error(char *msg)
  {
+	fprintf(stderr, "error parsing semanage configuration file: %s\n", msg);
  	parse_errors++;
  	return 0;
  }
diff -r 5a199c52a29c libsemanage/src/conf-scan.l
--- a/libsemanage/src/conf-scan.l	Wed Jan 03 22:27:17 2007 -0500
+++ b/libsemanage/src/conf-scan.l	Thu Jan 04 11:48:29 2007 -0500
@@ -42,6 +42,8 @@ policy-version    return VERSION;
  policy-version    return VERSION;
  expand-check      return EXPAND_CHECK;
  file-mode         return FILE_MODE;
+save-previous     return SAVE_PREVIOUS;
+save-linked       return SAVE_LINKED;
  "[load_policy]"   return LOAD_POLICY_START;
  "[setfiles]"      return SETFILES_START;
  "[genhomedircon]" return GENHOMEDIRCON_START;
diff -r 5a199c52a29c libsemanage/src/direct_api.c
--- a/libsemanage/src/direct_api.c	Wed Jan 03 22:27:17 2007 -0500
+++ b/libsemanage/src/direct_api.c	Thu Jan 04 11:48:29 2007 -0500
@@ -509,18 +509,35 @@ static int semanage_direct_commit(semana
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
+				if (retval < 0)
+					goto cleanup;
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

diff -r 5a199c52a29c libsemanage/src/semanage_conf.h
--- a/libsemanage/src/semanage_conf.h	Wed Jan 03 22:27:17 2007 -0500
+++ b/libsemanage/src/semanage_conf.h	Thu Jan 04 11:48:29 2007 -0500
@@ -35,6 +35,8 @@ typedef struct semanage_conf {
  	int server_port;
  	int policyvers;		/* version for server generated policies */
  	int expand_check;
+	int save_previous;
+	int save_linked;
  	mode_t file_mode;
  	struct external_prog *load_policy;
  	struct external_prog *setfiles;
diff -r 5a199c52a29c libsemanage/src/semanage_store.c
--- a/libsemanage/src/semanage_store.c	Wed Jan 03 22:27:17 2007 -0500
+++ b/libsemanage/src/semanage_store.c	Thu Jan 04 11:48:29 2007 -0500
@@ -1224,6 +1224,10 @@ static int semanage_commit_sandbox(seman
  		goto cleanup;
  	}

+	if (sh->conf->save_previous != 1) {
+		retval = semanage_remove_directory(backup);
+	}
+
        cleanup:
  	semanage_release_active_lock(sh);
  	return retval;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
