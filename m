Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAQFO10K010906
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 10:24:01 -0500
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAQFNKYS012669
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 15:23:57 GMT
Received: by nf-out-0910.google.com with SMTP id k4so865859nfd
        for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 07:23:57 -0800 (PST)
Message-ID: <cadfc0e40711260723k5e49a748r420671ddd309ba8@mail.gmail.com>
Date: Mon, 26 Nov 2007 09:23:56 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: [RFC Patch 7/10] PAM Namespace: different pam users
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The current implementation neglects to recognize that the pam requesting user
(PAM_RUSER) and the authenticating user (PAM_USER) can have different namespaces
by virtue of the use of $HOME or $USER in the namespace.conf file. This
oversight can among other things cause pam_namespace to attempt to unmount
directories that don't exist and weren't intended to be polyinstantiated. When
the unmount fails so does authentication. This patch sets up separate instance
structures for the requesting and authenticating users so that they can be
processed independently.
This patch also contains some minor debug output changes.

 pam_namespace.c |  277 +++++++++++++++++++++++++-------------------------------
 pam_namespace.h |    5 +
 2 files changed, 133 insertions(+), 149 deletions(-)


--- Linux-PAM-0.99.8.1/modules/pam_namespace/pam_namespace.c	2007-11-14
10:14:18.000000000 -0600
+++ Linux-PAM-0.99.8.1.new/modules/pam_namespace/pam_namespace.c	2007-11-14
10:27:16.000000000 -0600
@@ -1240,114 +1240,56 @@ out:
  * cycles through all polyinstantiated directory entries and calls
  * ns_setup to setup polyinstantiation for each one of them.
  */
-static int setup_namespace(struct instance_data *idata, enum unmnt_op unmnt)
+static int setup_namespace(struct instance_data *idata, struct
instance_data *rdata, enum unmnt_op unmnt)
 {
     int retval = 0, need_poly = 0, changing_dir = 0;
     char *cptr, *fptr, poly_parent[PATH_MAX];
-    struct polydir_s *pptr;
-    uid_t req_uid;
-    const void *ruser_name;
-    struct passwd *pwd;
+    struct polydir_s *pptr, *rpptr;

     if (idata->flags & PAMNS_DEBUG)
         pam_syslog(idata->pamh, LOG_DEBUG, "Set up namespace for pid %d",
 		getpid());
-
-    retval = pam_get_item(idata->pamh, PAM_RUSER, &ruser_name);
-    if (ruser_name == NULL || retval != PAM_SUCCESS) {
-	retval = PAM_SUCCESS;
-	req_uid = getuid();
-    } else {
-        pwd = pam_modutil_getpwnam(idata->pamh, ruser_name);
-        if (pwd != NULL) {
-    	    req_uid = pwd->pw_uid;
-        } else {
-	    req_uid = getuid();
-        }
-    }
-
-    /*
-     * Cycle through all polyinstantiated directory entries to see if
-     * polyinstantiation is needed at all.
-     */
-    for (pptr = idata->polydirs_ptr; pptr; pptr = pptr->next) {
-        if (ns_override(pptr, idata, idata->uid)) {
-    	    if (unmnt == NO_UNMNT || ns_override(pptr, idata, req_uid)) {
-        	if (idata->flags & PAMNS_DEBUG)
-        	    pam_syslog(idata->pamh, LOG_DEBUG,
-			"Overriding poly for user %d for dir %s",
-			idata->uid, pptr->dir);
-	    } else {
-        	if (idata->flags & PAMNS_DEBUG)
-            	    pam_syslog(idata->pamh, LOG_DEBUG,
-			"Need unmount ns for user %d for dir %s",
-			idata->uid, pptr->dir);
-		need_poly = 1;
-		break;
-	    }
-            continue;
-        } else {
-            if (idata->flags & PAMNS_DEBUG)
-                pam_syslog(idata->pamh, LOG_DEBUG,
-			"Need poly ns for user %d for dir %s",
-			idata->uid, pptr->dir);
-            need_poly = 1;
-            break;
-        }
-    }
-
     /*
      * If polyinstnatiation is needed, call the unshare system call to
      * disassociate from the parent namespace.
      */
-    if (need_poly) {
+    if (idata->polydirs_ptr) {
 	if (pam_set_data(idata->pamh, NAMESPACE_POLYDIR_DATA, idata->polydirs_ptr,
     		cleanup_data) != PAM_SUCCESS) {
     	    pam_syslog(idata->pamh, LOG_ERR,
     	    	"Unable to set namespace data");
     	    return PAM_SYSTEM_ERR;
     	}
+    }
+
+    if (idata->polydirs_ptr || rdata->polydirs_ptr) {
         if (unshare(CLONE_NEWNS) < 0) {
 		pam_set_data(idata->pamh, NAMESPACE_POLYDIR_DATA, NULL, NULL);
 		pam_syslog(idata->pamh, LOG_ERR,
 		"Unable to unshare from parent namespace, %m");
             return PAM_SESSION_ERR;
         }
-    } else {
-    	del_polydir_list(idata->polydirs_ptr);
-        return PAM_SUCCESS;
     }

     /*
-     * Again cycle through all polyinstantiated directories, this time,
-     * call ns_setup to setup polyinstantiation for a particular entry.
+     * Cycle through all polyinstantiated directory entries of the currently
+     * authenticated user and see if any need to be unmounted
      */
-    for (pptr = idata->polydirs_ptr; pptr; pptr = pptr->next) {
-	enum unmnt_op dir_unmnt = unmnt;
-        if (ns_override(pptr, idata, idata->uid)) {
-    	    if (unmnt == NO_UNMNT || ns_override(pptr, idata, req_uid)) {
-    		continue;
-	    } else {
-		dir_unmnt = UNMNT_ONLY;
-	    }
-	}
-	if (idata->flags & PAMNS_DEBUG)
-                pam_syslog(idata->pamh, LOG_DEBUG,
-			"Setting poly ns for user %d for dir %s",
-                      idata->uid, pptr->dir);
-
-	if ((dir_unmnt == UNMNT_REMNT) || (dir_unmnt == UNMNT_ONLY)) {
+    for (rpptr = rdata->polydirs_ptr; rpptr; rpptr = rpptr->next) {
+	if ((unmnt == UNMNT_REMNT) || (unmnt == UNMNT_ONLY)) {
                 /*
                  * Check to see if process current directory is in the
                  * bind mounted instance_parent directory that we are trying to
                  * umount
                  */
-                if ((changing_dir = cwd_in(pptr->dir, idata)) < 0) {
+                if ((changing_dir = cwd_in(rpptr->dir, rdata)) < 0) {
+		    pam_syslog(rdata->pamh, LOG_ERR, "Directory %s is current
working directory can't unmount.",
+			       rpptr->dir);
                     retval = PAM_SESSION_ERR;
                     goto out;
                 } else if (changing_dir) {
-                    if (idata->flags & PAMNS_DEBUG)
-                        pam_syslog(idata->pamh, LOG_DEBUG, "changing cwd");
+                    if (rdata->flags & PAMNS_DEBUG)
+                        pam_syslog(rdata->pamh, LOG_DEBUG, "changing cwd");

                     /*
                      * Change current working directory to the parent of
@@ -1355,7 +1297,7 @@ static int setup_namespace(struct instan
                      * directory where original contents of the polydir
                      * are available from
                      */
-                    strcpy(poly_parent, pptr->dir);
+                    strcpy(poly_parent, rpptr->dir);
     	            fptr = strchr(poly_parent, '/');
         	    cptr = strrchr(poly_parent, '/');
         	    if (fptr && cptr && (fptr == cptr))
@@ -1363,25 +1305,32 @@ static int setup_namespace(struct instan
         	    else if (cptr)
         	        *cptr = '\0';
                     if (chdir(poly_parent) < 0) {
-                        pam_syslog(idata->pamh, LOG_ERR,
+                        pam_syslog(rdata->pamh, LOG_ERR,
 				"Can't chdir to %s, %m", poly_parent);
                     }
                 }

-                if (umount(pptr->dir) < 0) {
-            	    int saved_errno = errno;
-            	    pam_syslog(idata->pamh, LOG_ERR, "Unmount of %s failed, %m",
-                    	pptr->dir);
-            	    if (saved_errno != EINVAL) {
+                if (umount(rpptr->dir) < 0) {
+            	    if (errno != EINVAL) {
+		        pam_syslog(rdata->pamh, LOG_ERR, "Unmount of %s failed, %m",
+			       rpptr->dir);
                 	retval = PAM_SESSION_ERR;
                 	goto out;
                     }
-                } else if (idata->flags & PAMNS_DEBUG)
-                    pam_syslog(idata->pamh, LOG_DEBUG, "Umount succeeded %s",
-				pptr->dir);
-	}
+                } else if (rdata->flags & PAMNS_DEBUG)
+                    pam_syslog(rdata->pamh, LOG_DEBUG, "Umount succeeded %s",
+				rpptr->dir);
+	    }
+    }
+
+    /*
+     * Again cycle through all polyinstantiated directories, this time,
+     * call ns_setup to setup polyinstantiation for a particular entry.
+     */

-	if (dir_unmnt != UNMNT_ONLY) {
+
+    for (pptr = idata->polydirs_ptr; pptr; pptr = pptr->next) {
+	if (unmnt != UNMNT_ONLY) {
                 retval = ns_setup(pptr, idata);
                 if (retval != PAM_SUCCESS)
                      break;
@@ -1460,6 +1409,61 @@ static int ctxt_based_inst_needed(void)
     }
 }
 #endif
+static int setup_instance_data(struct instance_data *idata, int item_type)
+{
+        int retval;
+        char *user_name;
+        struct passwd *pwd;
+
+        if (idata->flags & PAMNS_DEBUG)
+                pam_syslog(idata->pamh, LOG_DEBUG,
"setup_instance_data for pid %d",
+                           getpid());
+        /*
+         * Lookup user and fill struct items
+         */
+        retval = pam_get_item(idata->pamh, item_type, (void*) &user_name);
+        if (user_name == NULL || retval != PAM_SUCCESS) {
+                pam_syslog(idata->pamh, LOG_ERR, "No pam user name");
+                idata->user[0] = '\0';
+                return PAMNS_NO_PAM_USER;
+        }
+        if (idata->flags & PAMNS_DEBUG)
+                pam_syslog(idata->pamh, LOG_DEBUG,
"setup_instance_data for user %s",
+                           user_name);
+
+        pwd = pam_modutil_getpwnam(idata->pamh, user_name);
+        if (!pwd) {
+                pam_syslog(idata->pamh, LOG_ERR, "user unknown '%s'",
user_name);
+                return PAMNS_UNKNOWN_USER;
+        }
+
+        if (idata->flags & PAMNS_DEBUG)
+                pam_syslog(idata->pamh, LOG_DEBUG,
"setup_instance_data for uid %d",
+                           pwd->pw_uid);
+        /*
+         * Add the user info to the instance data so we can refer to
them later.
+         */
+        idata->user[0] = '\0';
+        strncat(idata->user, user_name, sizeof(idata->user) - 1);
+        idata->uid = pwd->pw_uid;
+
+        if (!idata->polydirs_ptr) {
+                /*
+                 * Parse namespace configuration file which lists
directories to
+                 * polyinstantiate, directory where instance directories are to
+                 * be created and the method used for polyinstantiation.
+                 */
+                retval = parse_config_file(idata);
+                if (retval != PAM_SUCCESS) {
+                        del_polydir_list(idata->polydirs_ptr);
+                        return PAMNS_PARSE_CONFIG_ERROR;
+                }
+                if (idata->flags & PAMNS_DEBUG)
+                        pam_syslog(idata->pamh, LOG_DEBUG,
"setup_instance_data for %s returning %d",
+                                   user_name, retval);
+        }
+        return retval;
+}


 /*
@@ -1470,14 +1474,16 @@ PAM_EXTERN int pam_sm_open_session(pam_h
 {
     int i, retval;
     struct instance_data idata;
-    char *user_name;
-    struct passwd *pwd;
+    struct instance_data rdata;
     enum unmnt_op unmnt = NO_UNMNT;

     /* init instance data */
     idata.flags = 0;
     idata.polydirs_ptr = NULL;
     idata.pamh = pamh;
+    rdata.flags = 0;
+    rdata.polydirs_ptr = NULL;
+    rdata.pamh = pamh;
 #ifdef WITH_SELINUX
     if (is_selinux_enabled())
         idata.flags |= PAMNS_SELINUX_ENABLED;
@@ -1495,6 +1501,7 @@ PAM_EXTERN int pam_sm_open_session(pam_h
             idata.flags |= PAMNS_IGN_CONFIG_ERR;
         if (strcmp(argv[i], "ignore_instance_parent_mode") == 0)
             idata.flags |= PAMNS_IGN_INST_PARENT_MODE;
+#ifdef WITH_SELINUX
         if (strcmp(argv[i], "user_default_level_fallback") == 0) {
 		if (idata.flags & PAMNS_USE_GETCON) {
                         pam_syslog(idata.pamh, LOG_ERR,
@@ -1511,6 +1518,7 @@ PAM_EXTERN int pam_sm_open_session(pam_h
                 }
                 idata.flags |= PAMNS_USE_GETCON;
         }
+#endif
         if (strcmp(argv[i], "unmnt_remnt") == 0)
             unmnt = UNMNT_REMNT;
         if (strcmp(argv[i], "unmnt_only") == 0)
@@ -1526,54 +1534,42 @@ PAM_EXTERN int pam_sm_open_session(pam_h
     if (idata.flags & PAMNS_DEBUG)
         pam_syslog(idata.pamh, LOG_DEBUG, "open_session - start");

-    /*
-     * Lookup user and fill struct items
-     */
-    retval = pam_get_item(idata.pamh, PAM_USER, (void*) &user_name );
-    if ( user_name == NULL || retval != PAM_SUCCESS ) {
-        pam_syslog(idata.pamh, LOG_ERR, "Error recovering pam user name");
+    retval = setup_instance_data(&idata, PAM_USER);
+    if (retval)
         return PAM_SESSION_ERR;
-    }

-    pwd = pam_modutil_getpwnam(idata.pamh, user_name);
-    if (!pwd) {
-        pam_syslog(idata.pamh, LOG_ERR, "user unknown '%s'", user_name);
+    rdata.flags = idata.flags;
+    /*
+      setup pam requesters polyinstantiated directories structure
+    */
+    retval = setup_instance_data(&rdata, PAM_RUSER);
+    if (retval != PAMNS_NO_PAM_USER && retval != PAM_SUCCESS) {
         return PAM_SESSION_ERR;
     }

-    /*
-     * Add the user info to the instance data so we can refer to them later.
-     */
-    idata.user[0] = 0;
-    strncat(idata.user, user_name, sizeof(idata.user) - 1);
-    idata.uid = pwd->pw_uid;
+    if (idata.polydirs_ptr) {
+        retval = setup_namespace(&idata, &rdata, unmnt);
+    } else if (idata.flags & PAMNS_DEBUG) {
+        pam_syslog(idata.pamh, LOG_DEBUG, "Nothing to polyinstantiate");
+	return PAM_SUCCESS;
+    }

-    /*
-     * Parse namespace configuration file which lists directories to
-     * polyinstantiate, directory where instance directories are to
-     * be created and the method used for polyinstantiation.
-     */
-    retval = parse_config_file(&idata);
     if (retval != PAM_SUCCESS) {
+      if (rdata.polydirs_ptr)
+	del_polydir_list(rdata.polydirs_ptr);
+      if (idata.polydirs_ptr)
 	del_polydir_list(idata.polydirs_ptr);
-        return PAM_SESSION_ERR;
     }

-    if (idata.polydirs_ptr) {
-        retval = setup_namespace(&idata, unmnt);
-        if (idata.flags & PAMNS_DEBUG) {
-            if (retval)
-                pam_syslog(idata.pamh, LOG_DEBUG,
-			"namespace setup failed for pid %d", getpid());
-            else
-                pam_syslog(idata.pamh, LOG_DEBUG,
-			"namespace setup ok for pid %d", getpid());
-        }
-    } else if (idata.flags & PAMNS_DEBUG)
-        pam_syslog(idata.pamh, LOG_DEBUG, "Nothing to polyinstantiate");
+    if (idata.flags & PAMNS_DEBUG) {
+        if (retval)
+	    pam_syslog(idata.pamh, LOG_DEBUG,
+		       "namespace setup failed for pid %d", getpid());
+        else
+	    pam_syslog(idata.pamh, LOG_DEBUG,
+		       "namespace setup ok for pid %d", getpid());
+    }

-    if (retval != PAM_SUCCESS)
-	del_polydir_list(idata.polydirs_ptr);
     return retval;
 }

@@ -1586,9 +1582,7 @@ PAM_EXTERN int pam_sm_close_session(pam_
 {
     int i, retval;
     struct instance_data idata;
-    char *user_name;
-    struct passwd *pwd;
-    const void *polyptr;
+    void *polyptr;

     /* init instance data */
     idata.flags = 0;
@@ -1630,28 +1624,6 @@ PAM_EXTERN int pam_sm_close_session(pam_
         return PAM_SUCCESS;
     }

-    /*
-     * Lookup user and fill struct items
-     */
-    retval = pam_get_item(idata.pamh, PAM_USER, (void*) &user_name );
-    if ( user_name == NULL || retval != PAM_SUCCESS ) {
-        pam_syslog(idata.pamh, LOG_ERR, "Error recovering pam user name");
-        return PAM_SESSION_ERR;
-    }
-
-    pwd = pam_modutil_getpwnam(idata.pamh, user_name);
-    if (!pwd) {
-        pam_syslog(idata.pamh, LOG_ERR, "user unknown '%s'", user_name);
-        return PAM_SESSION_ERR;
-    }
-
-    /*
-     * Add the user info to the instance data so we can refer to them later.
-     */
-    idata.user[0] = 0;
-    strncat(idata.user, user_name, sizeof(idata.user) - 1);
-    idata.uid = pwd->pw_uid;
-
     retval = pam_get_data(idata.pamh, NAMESPACE_POLYDIR_DATA, &polyptr);
     if (retval != PAM_SUCCESS || polyptr == NULL)
     	/* nothing to reset */
@@ -1659,6 +1631,13 @@ PAM_EXTERN int pam_sm_close_session(pam_
     	
     idata.polydirs_ptr = polyptr;

+    /*
+     * Lookup user and fill struct items
+     */
+    retval = setup_instance_data(&idata, PAM_USER);
+    if (retval)
+        return retval;
+
     if (idata.flags & PAMNS_DEBUG)
         pam_syslog(idata.pamh, LOG_DEBUG, "Resetting namespace for pid %d",
 		getpid());
--- Linux-PAM-0.99.8.1/modules/pam_namespace/pam_namespace.h	2007-11-14
10:14:18.000000000 -0600
+++ Linux-PAM-0.99.8.1.new/modules/pam_namespace/pam_namespace.h	2007-11-14
10:13:49.000000000 -0600
@@ -64,6 +64,7 @@
 #ifdef WITH_SELINUX
 #include <selinux/selinux.h>
 #include <selinux/context.h>
+#include <selinux/get_context_list.h>
 #endif

 #ifndef CLONE_NEWNS
@@ -91,6 +92,10 @@
 #define PAMNS_USER_DEFAULT_LEVEL_FALLBACK 0x00020000 /* if getexeccon
not called use user default level */
 #define PAMNS_USE_GETCON  0x00040000 /* if getexeccon not called use
getcon for context */

+#define PAMNS_NO_PAM_USER 1
+#define PAMNS_UNKNOWN_USER 2
+#define PAMNS_PARSE_CONFIG_ERROR 3
+
 #define NAMESPACE_MAX_DIR_LEN 80
 #define NAMESPACE_POLYDIR_DATA "pam_namespace:polydir_data"

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
