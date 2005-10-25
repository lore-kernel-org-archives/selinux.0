From: Chad Sellers <csellers@tresys.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] selinux_set_file_paths function
Date: Tue, 25 Oct 2005 12:58:34 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux-dev@tresys.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_6QmXD19cnl6U9OG"
Message-Id: <200510251258.34894.csellers@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_6QmXD19cnl6U9OG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached is a patch to libselinux that moves the setting of file_paths[] out 
of init_selinux_config and into its own exported function.  This allows a 
caller to reset those paths to an alternate policy type for getting paths of 
files in that alternate policy type.  The patch also includes a patch to 
semanage_install_active in libsemanage to use this function rather than 
hacking the strings returned by libselinux.

Thanks,
Chad

-- 
----------------------
Chad Sellers
Tresys Technology, LLC
csellers@tresys.com
(410)290-1411 x117
http://www.tresys.com


--Boundary-00=_6QmXD19cnl6U9OG
Content-Type: text/x-diff;
  charset="us-ascii";
  name="8-set_file_paths.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="8-set_file_paths.diff"

diff -purN -x .svn libselinux/include/selinux/selinux.h libselinux/include/selinux/selinux.h
--- libselinux/include/selinux/selinux.h	2005-10-25 12:01:59.000000000 -0400
+++ libselinux/include/selinux/selinux.h	2005-10-24 22:08:39.000000000 -0400
@@ -360,6 +360,7 @@ extern const char *selinux_customizable_
 extern const char *selinux_users_path(void);
 extern const char *selinux_usersconf_path(void);
 extern const char *selinux_path(void);
+extern int selinux_set_file_paths(char *type);
 
 /* Check a permission in the passwd class.
    Return 0 if granted or -1 otherwise. */
diff -purN -x .svn libselinux/src/selinux_config.c libselinux/src/selinux_config.c
--- libselinux/src/selinux_config.c	2005-10-25 12:02:00.000000000 -0400
+++ libselinux/src/selinux_config.c	2005-10-25 11:56:41.000000000 -0400
@@ -132,6 +132,7 @@ static void init_selinux_config(void)
   size_t rootlen, len;
   char *line_buf = NULL, *buf_p, *value;
   FILE *fp;
+  char *type, *end;
 
   if (selinux_policyroot) return;
   if (access(SELINUXDIR, F_OK) != 0) {
@@ -156,7 +157,6 @@ static void init_selinux_config(void)
 
 		  if (!strncasecmp(buf_p, SELINUXTYPETAG, 
 				   sizeof(SELINUXTYPETAG)-1)) {
-			  char *type, *end;
 			  type = buf_p+sizeof(SELINUXTYPETAG)-1;
 			  end  = type + strlen(type)-1;
 			  while ((end > type) && 
@@ -193,17 +193,46 @@ static void init_selinux_config(void)
 	  free(line_buf);
 	  fclose(fp);
   }
+  for (i = 0; i < NEL; i++) {
+	  file_paths[i] = NULL;
+  }
+  i = selinux_set_file_paths(type);
+  if ( i < 0) {
+	  return;
+  }
+  use_compat_file_path = 0;
+}
 
+int selinux_set_file_paths(char *type) {
+  int i, ret=0;
+  size_t len;
+  char *mypolicyroot=NULL;
+  if (type) {
+	  len = sizeof(SELINUXDIR) + strlen(type) + 1;
+	  mypolicyroot = malloc(len);
+	  snprintf(mypolicyroot, len, "%s%s", SELINUXDIR, type);
+  }
+  /* If type=NULL then use default policy root */
+  else {
+	  mypolicyroot = selinux_policyroot;
+  }
   for (i = 0; i < NEL; i++) {
-	  len = rootlen + strlen(file_path_suffixes_data.str
+	  len = strlen(mypolicyroot)
+				 + strlen(file_path_suffixes_data.str
 				 + file_path_suffixes_idx[i])+1;
-	  file_paths[i] = malloc(len);
-	  if (!file_paths[i])
-		  return;
-	  snprintf(file_paths[i], len, "%s%s", selinux_policyroot,
+	  /* Note that this must be freed by the caller */
+	  file_paths[i] = realloc(file_paths[i],len);
+	  if (!file_paths[i]) {
+		  ret=-1;
+		  break;
+	  }
+	  snprintf(file_paths[i], len, "%s%s", mypolicyroot,
 		   file_path_suffixes_data.str + file_path_suffixes_idx[i]);
   }
-  use_compat_file_path = 0;
+  if (mypolicyroot != selinux_policyroot) {
+	  free(mypolicyroot);
+  }
+  return ret;
 }
 
 static void fini_selinux_policyroot(void) __attribute__ ((destructor));
diff -purN -x .svn libsemanage/src/semanage_store.c libsemanage/src/semanage_store.c
--- libsemanage/src/semanage_store.c	2005-10-25 12:01:58.000000000 -0400
+++ libsemanage/src/semanage_store.c	2005-10-25 11:57:13.000000000 -0400
@@ -847,48 +847,40 @@ cleanup:
 static int semanage_install_active(semanage_handle_t *sh) {
 	int retval = -3, r, len;
 	char *storepath = NULL;
+	const char *store_fc;
+	const char *store_hd;
+	char store_pol[PATH_MAX];
+	const char *really_active_store;
 	struct stat astore, istore;
 	const char *active_kernel = semanage_path(SEMANAGE_ACTIVE,SEMANAGE_KERNEL);
 	const char *active_fc = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_FC);
 	const char *active_hd = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_HOMEDIR_TMPL);
 
-	const char *running_fc = selinux_file_context_path();
-	const char *running_hd = selinux_homedir_context_path();
-	const char *running_policy = selinux_binary_policy_path();
-	const char *really_active_store = selinux_policy_root();
-
-	/* This is very unelegant, the right thing to do is export the path 
-	 * building code in libselinux so that you can get paths for a given 
-	 * POLICYTYPE and should probably be done in the future. */
-	char store_fc[PATH_MAX];
-	char store_hd[PATH_MAX];
-	char store_pol[PATH_MAX];
-	
-	len = strlen(really_active_store);
-	running_fc += len;
-	running_hd += len;
-	running_policy += len;
-
+	really_active_store = selinux_policy_root();
 	len = strlen(selinux_path()) + strlen(sh->conf->store_path) + 1;
 	storepath = (char *)malloc(len);
-	if (!storepath)
+	if (!storepath) {
 		goto cleanup;
-	snprintf(storepath, PATH_MAX, "%s%s", selinux_path(), sh->conf->store_path);	
+	}
+        snprintf(storepath, PATH_MAX, "%s%s", selinux_path(), sh->conf->store_path);
+	if (selinux_set_file_paths(sh->conf->store_path) < 0) {
+		goto cleanup;
+	}
+	store_fc = selinux_file_context_path();
+	store_hd = selinux_homedir_context_path();
+	snprintf(store_pol, PATH_MAX, "%s.%d", selinux_binary_policy_path(), sh->conf->policyvers);
+
 
-	snprintf(store_pol, PATH_MAX, "%s%s.%d", storepath,
-		 running_policy, sh->conf->policyvers);
 	if (semanage_copy_file(active_kernel, store_pol) == -1) {
 		ERR(sh, "Could not copy %s to %s.", active_kernel, store_pol);
 		goto cleanup;
 	}
 
-	snprintf(store_hd, PATH_MAX, "%s%s", storepath, running_hd);	
 	if (semanage_copy_file(active_hd, store_hd) == -1) {
 		ERR(sh, "Could not copy %s to %s.", active_hd, store_hd);
 		goto cleanup;
 	}
 
-	snprintf(store_fc, PATH_MAX, "%s%s", storepath, running_fc);
 	if (semanage_copy_file(active_fc, store_fc) == -1) {
 		ERR(sh, "Could not copy %s to %s.", active_fc, store_fc);
 		goto cleanup;
@@ -934,6 +926,7 @@ skip_reload:
 	retval = 0;
 cleanup:
 	free(storepath);
+	selinux_set_file_paths(NULL);
 	return retval;
 }
 

--Boundary-00=_6QmXD19cnl6U9OG--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
