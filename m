Subject: Re: libsemanage patch to make seusers world readable.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, SELinux-dev@tresys.com,
   selinux@tycho.nsa.gov
In-Reply-To: <1134047260.2366.149.camel@moss-spartans.epoch.ncsc.mil>
References: <43971CDB.1070507@redhat.com>
	 <1133977698.2366.81.camel@moss-spartans.epoch.ncsc.mil>
	 <1134047260.2366.149.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-wMIF/jyQDnlBgDzs46tY"
Date: Mon, 12 Dec 2005 11:34:46 -0500
Message-Id: <1134405286.7305.108.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-wMIF/jyQDnlBgDzs46tY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-12-08 at 08:07 -0500, Stephen Smalley wrote:
> libsemanage needs a saner way of setting the modes on the files it
> installs.  The installed files presently include the kernel policy file,
> the file_contexts file, the homedir_template file, and the seusers file.
> Options are:
> - Create them world readable as far as DAC mode is concerned, but
> restrict access via SELinux policy based on file contexts as desired.
> That seems to be the situation prior to libsemanage, with targeted
> policy allowing users to access them.
> - Make the DAC mode configurable via semanage.conf.  In this case, we
> need to decide whether a single mode is sufficient for all of the files
> or if we want separate modes for different files (e.g.
> kernel-policy=0600, file-contexts=0644, seusers=0644).

Patch attached adds a file-mode= optional setting to semanage.conf, with
the default being 0644 (the old defaults for these files prior to
libsemanage).  semanage_copy_file() is changed to take a mode argument.
semanage_copy_dir() passes in the mode of the original file to preserve
mode on store files (which ends up staying as 0600 since they are
created that way separately).  semanage_install_active() passes in the
configured file mode so that installed files use that mode.  If we want
finer-grained protection of the installed files, we can either use
policy or we can add further more specific file modes to semanage.conf,
with the current file-mode setting being the default in the absence of a
more specific one.  Look sane?

> Also, it occurs to me that libsemanage doesn't presently do anything
> about setting file contexts for these files, so they always just inherit
> the default (parent directory type or transition type if one is defined
> in policy).  I think that is currently ok since that is the current
> labeling anyway for these files, but it could be a problem if we later
> introduce distinct types for e.g. seusers.  Likely should be doing a
> matchpathcon() and setfscreatecon() when creating the new file (or
> setfilecon prior to renaming it into place, as long as it is adequately
> protected while within the sandbox).

This still needs to be addressed.

-- 
Stephen Smalley
National Security Agency

--=-wMIF/jyQDnlBgDzs46tY
Content-Disposition: attachment; filename=libsemanage-mode.patch
Content-Type: text/x-patch; name=libsemanage-mode.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: libsemanage/src/conf-parse.y
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsemanage/src/conf-parse.y,v
retrieving revision 1.10
diff -u -p -r1.10 conf-parse.y
--- libsemanage/src/conf-parse.y	25 Oct 2005 12:09:10 -0000	1.10
+++ libsemanage/src/conf-parse.y	12 Dec 2005 16:00:16 -0000
@@ -54,7 +54,7 @@ static int parse_errors;
         char *s;
 }
 
-%token MODULE_STORE VERSION EXPAND_CHECK
+%token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE
 %token LOAD_POLICY_START SETFILES_START
 %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_END
 %token PROG_PATH PROG_ARGS
@@ -75,6 +75,7 @@ config_line:    single_opt
 single_opt:     module_store
         |       version
         |       expand_check
+        |       file_mode
         ;
 
 module_store:   MODULE_STORE '=' ARG {
@@ -103,6 +104,11 @@ expand_check:   EXPAND_CHECK '=' ARG  {
                 }
         ;
 
+file_mode:   FILE_MODE '=' ARG  {
+                        current_conf->file_mode = strtoul($3, NULL, 8);
+                        free($3);
+                }
+        ;
 
 command_block: 
                 command_start external_opts BLOCK_END  {
@@ -168,6 +174,7 @@ static int semanage_conf_init(semanage_c
 	conf->store_path = strdup(basename(selinux_policy_root()));
 	conf->policyvers = sepol_policy_kern_vers_max();
 	conf->expand_check = 1;
+	conf->file_mode = 0644;
 
 	if ((conf->load_policy = calloc(1, sizeof(*(current_conf->load_policy)))) == NULL) {
 		return -1;
Index: libsemanage/src/conf-scan.l
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsemanage/src/conf-scan.l,v
retrieving revision 1.5
diff -u -p -r1.5 conf-scan.l
--- libsemanage/src/conf-scan.l	20 Oct 2005 13:53:12 -0000	1.5
+++ libsemanage/src/conf-scan.l	12 Dec 2005 15:56:31 -0000
@@ -41,6 +41,7 @@ int yywrap(void);
 module-store      return MODULE_STORE;
 policy-version    return VERSION;
 expand-check      return EXPAND_CHECK;
+file-mode         return FILE_MODE;
 "[load_policy]"   return LOAD_POLICY_START;
 "[setfiles]"      return SETFILES_START;
 "[verify module]" return VERIFY_MOD_START;
Index: libsemanage/src/semanage_conf.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsemanage/src/semanage_conf.h,v
retrieving revision 1.4
diff -u -p -r1.4 semanage_conf.h
--- libsemanage/src/semanage_conf.h	25 Oct 2005 12:09:11 -0000	1.4
+++ libsemanage/src/semanage_conf.h	12 Dec 2005 16:04:16 -0000
@@ -21,6 +21,8 @@
 #define SEMANAGE_CONF_H
 
 #include <semanage/handle.h>
+#include <sys/types.h>
+#include <sys/stat.h>
 
 /* libsemanage has its own configuration file.	It has two main parts:
  *  - single options
@@ -33,6 +35,7 @@ typedef struct semanage_conf {
 	int server_port;
 	int policyvers;		/* version for server generated policies */
         int expand_check;
+	mode_t file_mode;
 	struct external_prog *load_policy;
 	struct external_prog *setfiles;
 	struct external_prog *genhomedircon;
Index: libsemanage/src/semanage_store.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsemanage/src/semanage_store.c,v
retrieving revision 1.28
diff -u -p -r1.28 semanage_store.c
--- libsemanage/src/semanage_store.c	16 Nov 2005 13:49:15 -0000	1.28
+++ libsemanage/src/semanage_store.c	12 Dec 2005 16:03:34 -0000
@@ -303,7 +303,7 @@ static int semanage_filename_select(cons
 
 /* Copies a file from src to dst.  If dst already exists then
  * overwrite it.  Returns 0 on success, -1 on error. */
-static int semanage_copy_file(const char *src, const char *dst) {
+static int semanage_copy_file(const char *src, const char *dst, mode_t mode) {
 	int in, out, retval = 0, amount_read, n;
 	char tmp[PATH_MAX];
 	char buf[4192];
@@ -315,8 +315,11 @@ static int semanage_copy_file(const char
 	if ((in = open(src, O_RDONLY)) == -1) {
 		return -1;
 	}
+
+	if (!mode)
+		mode = S_IRUSR | S_IWUSR;
 	
-	if ((out = open(tmp, O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR)) == -1) {
+	if ((out = open(tmp, O_WRONLY | O_CREAT | O_TRUNC, mode)) == -1) {
 		close(in);
 		return -1;
 	}
@@ -364,7 +367,7 @@ static int semanage_copy_dir(const char 
 			}
 		}
 		else if (S_ISREG(sb.st_mode)) {
-			if (semanage_copy_file(path, path2) == -1) {
+			if (semanage_copy_file(path, path2, sb.st_mode) == -1) {
 				goto cleanup;
 			}
 		}
@@ -895,25 +898,25 @@ static int semanage_install_active(seman
 
 	snprintf(store_pol, PATH_MAX, "%s%s.%d", storepath,
 		 running_policy, sh->conf->policyvers);
-	if (semanage_copy_file(active_kernel, store_pol) == -1) {
+	if (semanage_copy_file(active_kernel, store_pol, sh->conf->file_mode) == -1) {
 		ERR(sh, "Could not copy %s to %s.", active_kernel, store_pol);
 		goto cleanup;
 	}
 
 	snprintf(store_hd, PATH_MAX, "%s%s", storepath, running_hd);	
-	if (semanage_copy_file(active_hd, store_hd) == -1) {
+	if (semanage_copy_file(active_hd, store_hd, sh->conf->file_mode) == -1) {
 		ERR(sh, "Could not copy %s to %s.", active_hd, store_hd);
 		goto cleanup;
 	}
 
 	snprintf(store_fc, PATH_MAX, "%s%s", storepath, running_fc);
-	if (semanage_copy_file(active_fc, store_fc) == -1) {
+	if (semanage_copy_file(active_fc, store_fc, sh->conf->file_mode) == -1) {
 		ERR(sh, "Could not copy %s to %s.", active_fc, store_fc);
 		goto cleanup;
 	}
 
 	snprintf(store_seusers, PATH_MAX, "%s%s", storepath, running_seusers);
-	if (semanage_copy_file(active_seusers, store_seusers) == -1) {
+	if (semanage_copy_file(active_seusers, store_seusers, sh->conf->file_mode) == -1) {
 		INFO(sh, "Non-fatal error:  Could not copy %s to %s.", active_seusers, store_seusers);
 		/* Non-fatal; fall through */
 	}

--=-wMIF/jyQDnlBgDzs46tY--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
