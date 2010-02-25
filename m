Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1PL8VEY008410
	for <selinux@tycho.nsa.gov>; Thu, 25 Feb 2010 16:08:31 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o1PL8DuT022360
	for <selinux@tycho.nsa.gov>; Thu, 25 Feb 2010 21:08:13 GMT
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o1PL8Txb025761
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 25 Feb 2010 16:08:29 -0500
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by int-mx03.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o1PL8SCm031617
	for <selinux@tycho.nsa.gov>; Thu, 25 Feb 2010 16:08:28 -0500
Message-ID: <4B86E6CC.9000405@redhat.com>
Date: Thu, 25 Feb 2010 16:08:28 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Patch to run genhomedircon without looking at /etc/passwd
Content-Type: multipart/mixed;
 boundary="------------010604080406040507050505"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010604080406040507050505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I want to change the default of libsemanage to not look for home 
directories in getpwent.  This patch allows you to set the flag 
usepasswd=false in the semanage.conf file. and genhomedircon will only 
setup the labeling of /home, /export/home and any confined users homedirs.

If this patch is not acceptable because libsemanage is being rewritten, 
I would like the functionality to be added to the new libsemanage.

--------------010604080406040507050505
Content-Type: text/plain;
 name="libsemanage_usepasswd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libsemanage_usepasswd.patch"

diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index e885202..9b261b9 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -57,7 +57,7 @@ static int parse_errors;
 }
 
 %token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LINKED
-%token LOAD_POLICY_START SETFILES_START DISABLE_GENHOMEDIRCON HANDLE_UNKNOWN
+%token LOAD_POLICY_START SETFILES_START DISABLE_GENHOMEDIRCON HANDLE_UNKNOWN USEPASSWD
 %token BZIP_BLOCKSIZE BZIP_SMALL
 %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_END
 %token PROG_PATH PROG_ARGS
@@ -82,6 +82,7 @@ single_opt:     module_store
         |       save_previous
         |       save_linked
         |       disable_genhomedircon
+        |       usepasswd
         |       handle_unknown
 	|	bzip_blocksize
 	|	bzip_small
@@ -153,6 +154,17 @@ disable_genhomedircon: DISABLE_GENHOMEDIRCON '=' ARG {
 	free($3);
  }
 
+usepasswd: USEPASSWD '=' ARG {
+	if (strcasecmp($3, "false") == 0) {
+		current_conf->usepasswd = 0;
+	} else if (strcasecmp($3, "true") == 0) {
+		current_conf->usepasswd = 1;
+	} else {
+		yyerror("usepasswd can only be 'true' or 'false'");
+	}
+	free($3);
+ }
+
 handle_unknown: HANDLE_UNKNOWN '=' ARG {
 	if (strcasecmp($3, "deny") == 0) {
 		current_conf->handle_unknown = SEPOL_DENY_UNKNOWN;
@@ -252,6 +264,7 @@ static int semanage_conf_init(semanage_conf_t * conf)
 	conf->policyvers = sepol_policy_kern_vers_max();
 	conf->expand_check = 1;
 	conf->handle_unknown = -1;
+	conf->usepasswd = 1;
 	conf->file_mode = 0644;
 	conf->bzip_blocksize = 9;
 	conf->bzip_small = 0;
diff --git a/libsemanage/src/conf-scan.l b/libsemanage/src/conf-scan.l
index 8af5137..e57119d 100644
--- a/libsemanage/src/conf-scan.l
+++ b/libsemanage/src/conf-scan.l
@@ -46,6 +46,7 @@ file-mode         return FILE_MODE;
 save-previous     return SAVE_PREVIOUS;
 save-linked       return SAVE_LINKED;
 disable-genhomedircon return DISABLE_GENHOMEDIRCON;
+usepasswd return USEPASSWD;
 handle-unknown    return HANDLE_UNKNOWN;
 bzip-blocksize	return BZIP_BLOCKSIZE;
 bzip-small	return BZIP_SMALL;
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index fee6644..47834eb 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -959,7 +959,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	 * which requires the out policydb */
 	if (!sh->conf->disable_genhomedircon) {
 		if (out && (retval =
-		     semanage_genhomedircon(sh, out, 1)) != 0) {
+		     semanage_genhomedircon(sh, out, sh->conf->usepasswd)) != 0) {
 			ERR(sh, "semanage_genhomedircon returned error code %d.",
 			    retval);
 			goto cleanup;
diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage_conf.h
index 4118910..f58d9ac 100644
--- a/libsemanage/src/semanage_conf.h
+++ b/libsemanage/src/semanage_conf.h
@@ -38,6 +38,7 @@ typedef struct semanage_conf {
 	int save_previous;
 	int save_linked;
 	int disable_genhomedircon;
+	int usepasswd;
 	int handle_unknown;
 	mode_t file_mode;
 	int bzip_blocksize;

--------------010604080406040507050505--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
