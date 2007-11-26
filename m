Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAQFNtWt010882
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 10:23:55 -0500
Received: from nf-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAQFNGjo025808
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 15:23:48 GMT
Received: by nf-out-0910.google.com with SMTP id k4so865788nfd
        for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 07:23:48 -0800 (PST)
Message-ID: <cadfc0e40711260723u137e2891q88bd1be825f97106@mail.gmail.com>
Date: Mon, 26 Nov 2007 09:23:47 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: [RFC Patch 6/10] PAM Namespace: ignore directory if user excluded
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch exclude polyinstantiated directory from a users instance
structure list based on the override
configuration since no further processing is required for these
directories. The patch also moves up the
decision to the earliest possible point and makes some minor changes
to debug output messages.

 pam_namespace.c |  117 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 65 insertions(+), 52 deletions(-)


--- Linux-PAM-0.99.8.1/modules/pam_namespace/pam_namespace.c	2007-11-14
10:09:21.000000000 -0600
+++ Linux-PAM-0.99.8.1.new/modules/pam_namespace/pam_namespace.c	2007-11-14
10:10:48.000000000 -0600
@@ -209,6 +209,68 @@ static int process_line(char *line, cons
      * skip it.
      */
     uids = config_options[3];
+
+    /*
+     * If the line in namespace.conf for a directory to polyinstantiate
+     * contains a list of override users (users for whom polyinstantiation
+     * is not performed), read the user ids, convert names into uids, and
+     * add to polyinstantiated directory structure.
+     */
+    if (uids) {
+            uid_t *uidptr;
+            char *saveptr, *token;
+            char *ustr, *sstr;
+            int count;
+
+            sstr = uids;
+            if (*uids == '~') {
+                    poly.exclusive = 1;
+                    uids++;
+            }
+
+            for (count = 0, ustr = uids; ; count++, ustr = NULL) {
+                    token = strtok_r(ustr, ",", &saveptr);
+                    if (token == NULL)
+                            break;
+            }
+
+            if (count == 0) {
+                    pam_syslog(idata->pamh, LOG_NOTICE, "Invalid
override list %s", sstr);
+                    goto skipping;
+            }
+
+            poly.num_uids = count;
+            poly.uid = (uid_t *)malloc(count * sizeof(uid_t));
+            if (poly.uid == NULL) {
+                    pam_syslog(idata->pamh, LOG_NOTICE, "out of memory");
+                    goto skipping;
+            }
+            uidptr = poly.uid;
+
+            for (ustr = uids; ;ustr = NULL) {
+                    struct passwd *pwd;
+                    token = strtok_r(ustr, ",", &saveptr);
+                    if (token == NULL)
+                            break;
+
+                    pwd = getpwnam(token);
+                    if (pwd == NULL) {
+                            pam_syslog(idata->pamh, LOG_ERR, "Unknown
user %s in configuration", token);
+                            poly.num_uids--;	
+                    } else {
+                            if (pwd->pw_uid == idata->uid) {
+                                    /*
+                                     * Why put it in the list if this
+                                     * user doesn't polyinstiate it
+                                     */
+                                    free(poly.uid);
+                                    goto out;
+                            }
+                            *uidptr = pwd->pw_uid;
+                            uidptr++;
+                    }
+            }
+    }

     /*
      * If the directory being polyinstantiated is the home directory
@@ -304,52 +366,6 @@ static int process_line(char *line, cons
     }

     /*
-     * If the line in namespace.conf for a directory to polyinstantiate
-     * contains a list of override users (users for whom polyinstantiation
-     * is not performed), read the user ids, convert names into uids, and
-     * add to polyinstantiated directory structure.
-     */
-    if (uids) {
-        uid_t *uidptr;
-        const char *ustr, *sstr;
-        int count, i;
-	
-	if (*uids == '~') {
-		poly.exclusive = 1;
-		uids++;
-	}
-        for (count = 0, ustr = sstr = uids; sstr; ustr = sstr + 1, count++)
-           sstr = strchr(ustr, ',');
-
-        poly.num_uids = count;
-        poly.uid = (uid_t *) malloc(count * sizeof (uid_t));
-        uidptr = poly.uid;
-        if (uidptr == NULL) {
-            pam_syslog(idata->pamh, LOG_NOTICE, "out of memory");
-            goto skipping;
-        }
-
-        ustr = uids;
-        for (i = 0; i < count; i++) {
-            struct passwd *pwd;
-
-            tptr = strchr(ustr, ',');
-            if (tptr)
-                *tptr = '\0';
-
-            pwd = pam_modutil_getpwnam(idata->pamh, ustr);
-            if (pwd == NULL) {
-        	pam_syslog(idata->pamh, LOG_ERR, "Unknown user %s in
configuration", ustr);
-        	poly.num_uids--;	
-            } else {
-                *uidptr = pwd->pw_uid;
-                uidptr++;
-            }
-            ustr = tptr + 1;
-        }
-    }
-
-    /*
      * Add polyinstantiated directory structure to the linked list
      * of all polyinstantiated directory structures.
      */
@@ -441,8 +457,6 @@ static int parse_config_file(struct inst
         while (dptr) {
             pam_syslog(idata->pamh, LOG_DEBUG, "dir='%s' iprefix='%s' meth=%d",
 		   dptr->dir, dptr->instance_prefix, dptr->method);
-            for (i = 0, iptr = dptr->uid; i < dptr->num_uids; i++, iptr++)
-                pam_syslog(idata->pamh, LOG_DEBUG, "override user %d ", *iptr);
             dptr = dptr->next;
         }
     }
@@ -1090,10 +1104,6 @@ static int ns_setup(struct polydir_s *po
     if (asprintf(&inst_dir, "%s%s", polyptr->instance_prefix, instname) < 0)
 	goto error_out;

-    if (idata->flags & PAMNS_DEBUG)
-        pam_syslog(idata->pamh, LOG_DEBUG, "instance_dir %s",
-		inst_dir);
-
     /*
      * Create instance directory with appropriate security
      * contexts, owner, group and mode bits.
@@ -1110,6 +1120,10 @@ static int ns_setup(struct polydir_s *po
         goto error_out;
     }

+    if (idata->flags & PAMNS_DEBUG)
+        pam_syslog(idata->pamh, LOG_DEBUG, "mount instance_dir %s on %s",
+                   inst_dir, polyptr->dir);
+
     /*
      * Bind mount instance directory on top of the polyinstantiated
      * directory to provide an instance of polyinstantiated directory

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
