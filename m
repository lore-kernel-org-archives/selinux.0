Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAQFONwR011101
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 10:24:23 -0500
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAQFNKYT012669
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 15:24:15 GMT
Received: by nf-out-0910.google.com with SMTP id k4so865859nfd
        for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 07:24:14 -0800 (PST)
Message-ID: <cadfc0e40711260724s198c8ea8vcc5a73047ef89b8b@mail.gmail.com>
Date: Mon, 26 Nov 2007 09:24:09 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: [RFC Patch 9/10] PAM Namespace: no access, no polyinstantiation attempt
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch check for DAC and MAC accessibility of polyinstantiated
directories and instance directories and generates warnings instead
of causing PAM session failures. DAC access failures result in
warnings and the directories not being included in the instance
structures list of polyinstantied directories. MAC access failures
cause warnings and when in enforcing mode the directories are not
included in the instance structures list of polyinstantied
directories.
One issue with the namespace.conf override list is that it is not
always possible to specify all of the users who should be part of it.
A major benefit of this patch is not failing a PAM session when
DAC or MAC access failures occur for users not in override lists who
who don't care about polyinstantiating these directories anyway.
Also included in this patch are some changes if string compares to if
else string compares.


--- Linux-PAM-0.99.8.1/modules/pam_namespace/pam_namespace.c	2007-11-14
11:01:17.000000000 -0600
+++ Linux-PAM-0.99.8.1.new/modules/pam_namespace/pam_namespace.c	2007-11-14
11:01:00.000000000 -0600
@@ -317,6 +317,24 @@ static int process_line(char *line, cons
     }

     /*
+     * Make sure these directories exist otherwise there is no point
+     * in continuing.
+     */
+    struct stat statbuf;
+    if (stat(dir, &statbuf) < 0) {
+            pam_syslog(idata->pamh, LOG_WARNING, "Error stating %s,
%m, no polyinstantiation will occur.", dir);
+            free(poly.uid);
+            retval = PAM_SUCCESS;
+            goto out;
+    }
+    if (stat(instance_prefix, &statbuf) < 0) {
+            pam_syslog(idata->pamh, LOG_WARNING, "Error stating %s,
%m, no polyinstantiation will occur.", instance_prefix);
+            free(poly.uid);
+            retval = PAM_SUCCESS;
+            goto out;
+    }
+
+    /*
      * Populate polyinstantiated directory structure with appropriate
      * pathnames and the method with which to polyinstantiate.
      */
@@ -336,35 +354,73 @@ static int process_line(char *line, cons
     if (strcmp(method, "user") == 0)
 	    poly.method = USER;

-    if (strcmp(method, "tmpdir") == 0) {
+    else if (strcmp(method, "tmpdir") == 0) {
     	    poly.method = TMPDIR;
     	    if (sizeof(poly.instance_prefix) - strlen(poly.instance_prefix) < 7) {
     		pam_syslog(idata->pamh, LOG_NOTICE, "Pathnames too long");
     		goto skipping;
     	    }
     	    strcat(poly.instance_prefix, "XXXXXX");
-    }
-
-    if (strcmp(method, "tmpfs") == 0)
+    } else if (strcmp(method, "tmpfs") == 0)
             poly.method = TMPFS;
-
 #ifdef WITH_SELINUX
-    if (strcmp(method, "lvlshared") == 0) {
-              poly.method = LEVEL_SHARED;
-    }
-
-    if (strcmp(method, "ctxshared") == 0) {
-              poly.method = CONTEXT_SHARED;
-    }
-
-    if (strcmp(method, "level") == 0) {
+    else if (strcmp(method, "lvlshared") == 0)
+            poly.method = LEVEL_SHARED;
+    else if (strcmp(method, "ctxshared") == 0)
+            poly.method = CONTEXT_SHARED;
+    else if (strcmp(method, "level") == 0)
             poly.method = LEVEL;
-    }
-
-    if (strcmp(method, "context") == 0) {
+    else if (strcmp(method, "context") == 0)
             poly.method = CONTEXT;
+
+    if ( poly.method != NONE) {
+            security_context_t scon = NULL;
+            security_context_t polydircon = NULL;
+            retval = getfilecon(poly.dir, &polydircon);
+            if (retval < 0 || polydircon == NULL) {
+                    pam_syslog(idata->pamh, LOG_ERR,
+                               "Error getting poly dir context for
%s, %m", poly.dir);
+                    free(poly.uid);
+                    retval = PAM_SUCCESS;
+                    goto out;
+            }
+
+            retval = getcon(&scon);
+            if (retval < 0 || scon == NULL) {
+                    freecon(polydircon);
+                    free(poly.uid);
+                    pam_syslog(idata->pamh, LOG_ERR,
+                               "Error getting context, %m");
+                    retval = PAM_SESSION_ERR;
+                    goto out;
+            }
+            /*
+             * If you aren't going to be able to mount the directory
+             * there isn't any point in putting the directory in the
+             * list of polyinstantiated directories.
+             */
+            struct av_decision avd;
+            unsigned int bit = DIR__MOUNTON;
+            retval = security_compute_av(scon, polydircon,
+
string_to_security_class("dir"), bit, &avd);
+            if (retval || ((bit & avd.allowed) != bit)) {
+                    if (security_getenforce()) {
+                            freecon(scon);
+                            freecon(polydircon);
+                            free(poly.uid);
+                            retval = PAM_SUCCESS;
+                            pam_syslog(idata->pamh, LOG_WARNING,
+                                       "Mount of %s denied by policy,
no polyinstantiation will occur.", poly.dir);
+                            goto out;
+                    }
+                    else {
+                            pam_syslog(idata->pamh, LOG_WARNING,
+                                       "Mount of %s will fail in
enforcing mode.", poly.dir);
+                    }
+            }
+            freecon(scon);
+            freecon(polydircon);
     }
-
 #endif

     if (poly.method == NONE) {
@@ -960,9 +1016,16 @@ static int create_dirs(struct polydir_s
      */
 	rc = PAM_SUCCESS;
     if (stat(polyptr->dir, &statbuf) < 0) {
-        pam_syslog(idata->pamh, LOG_ERR, "Error stating %s, %m",
-		polyptr->dir);
-        return PAM_SESSION_ERR;
+        if (errno == EACCES || errno == ENOENT) {
+            pam_syslog(idata->pamh, LOG_ERR, "Error stating %s,
possible MAC denial %m, ignoring.",
+			polyptr->dir);
+            return PAM_SUCCESS;
+        }
+        else {
+                pam_syslog(idata->pamh, LOG_ERR, "Error stating %s, %m",
+                           polyptr->dir);
+                return PAM_SESSION_ERR;
+        }
     }

     /*
@@ -999,6 +1062,11 @@ static int create_dirs(struct polydir_s
     } else if (mkdir(ipath, S_IRUSR) < 0) {
         if (errno == EEXIST)
             goto inst_init;
+        else if (errno == EACCES || errno == ENOENT) {
+            pam_syslog(idata->pamh, LOG_ERR, "Error creating %s,
possible MAC denial %m, ignoring.",
+			ipath);
+            return PAM_SUCCESS;
+        }
         else {
             pam_syslog(idata->pamh, LOG_ERR, "Error creating %s, %m",
 			ipath);
@@ -1161,9 +1229,17 @@ static int ns_setup(struct polydir_s *po
      * based on polyinstantiated method.
      */
     if (mount(inst_dir, polyptr->dir, NULL, MS_BIND, NULL) < 0) {
-        pam_syslog(idata->pamh, LOG_ERR, "Error mounting %s on %s, %m",
-                   inst_dir, polyptr->dir);
-        goto error_out;
+        if (errno == EACCES || errno == ENOENT) {
+                pam_syslog(idata->pamh, LOG_ERR, "Error mounting %s
on %s, %m, possible MAC denial, ignoring.",
+                           inst_dir, polyptr->dir);
+                retval = PAM_SUCCESS;
+                goto cleanup;
+        }
+        else {
+                pam_syslog(idata->pamh, LOG_ERR, "Error mounting %s on %s, %m",
+                           inst_dir, polyptr->dir);
+                goto error_out;
+        }
     }

     goto cleanup;

--- Linux-PAM-0.99.8.1/modules/pam_namespace/pam_namespace.h
2007-10-29 11:22:41.000000000 -0600
+++ Linux-PAM-0.99.8.1.new/modules/pam_namespace/pam_namespace.h
 2007-10-29 11:22:52.000000000 -0600
@@ -65,6 +65,7 @@
 #include <selinux/selinux.h>
 #include <selinux/context.h>
 #include <selinux/get_context_list.h>
+#include <selinux/av_permissions.h>
 #endif

 #ifndef CLONE_NEWNS

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
