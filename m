Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAQFOCgG010985
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 10:24:12 -0500
Received: from nf-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAQFNGjp025808
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 15:24:04 GMT
Received: by nf-out-0910.google.com with SMTP id k4so865788nfd
        for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 07:24:04 -0800 (PST)
Message-ID: <cadfc0e40711260724i4023309en3cb6dcda4192687e@mail.gmail.com>
Date: Mon, 26 Nov 2007 09:24:02 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: [RFC Patch 8/10] PAM Namespace: configurable running on init script
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If the file /etc/security/namespace.init exists it will be exec'd for every
directory being polyinstantiated. The functionality of this script may not
actually be required for all directories being polyinstantiated. However,
the current implementation provides no mechanism to avoid this costly overhead.
This patch adds a run option (run_init/no_init) to control the execution of
the init script for each polyinstantiated directory. One side affect of this
patch is the configuration of the override list is no longer optional so if
no overrides are required 'none' must be specified. To deal with this side
affect I've, in a seperate patch, added an awk script to the %post of the
spec file to add default values for the override list and init script option.

 pam_namespace.c |  126 ++++++++++++++++++++++++++++++++------------------------
 pam_namespace.h |    5 ++
 2 files changed, 78 insertions(+), 53 deletions(-)


--- Linux-PAM-0.99.8.1/modules/pam_namespace/pam_namespace.c	2007-11-14
11:26:57.000000000 -0600
+++ Linux-PAM-0.99.8.1.new/modules/pam_namespace/pam_namespace.c	2007-11-14
11:28:09.000000000 -0600
@@ -43,6 +43,7 @@ static int copy_ent(const struct polydir
 	strcpy(pent->dir, ent->dir);
 	strcpy(pent->instance_prefix, ent->instance_prefix);
 	pent->method = ent->method;
+	pent->run_init = ent->run_init;
 	pent->num_uids = ent->num_uids;
 	pent->exclusive = ent->exclusive;
 	if (ent->num_uids) {
@@ -139,7 +140,7 @@ static int process_line(char *line, cons
 			struct instance_data *idata)
 {
     const char *dir, *instance_prefix;
-    const char *method, *uids;
+    const char *method, *uids, *run_init_script;
     char *tptr;
     struct polydir_s poly;
     int retval = 0;
@@ -182,22 +183,24 @@ static int process_line(char *line, cons
      */
     retval = argv_parse(line, &num_config_options, &config_options);
     if (retval != 0) {
-        pam_syslog(idata->pamh, LOG_NOTICE, "Invalid line missing polydir");
+        pam_syslog(idata->pamh, LOG_NOTICE, "Error parsing
configuration line");
         goto skipping;
     }

     dir = config_options[0];
-    if (dir == NULL) {
+    if (num_config_options < 1 || dir == NULL) {
         pam_syslog(idata->pamh, LOG_NOTICE, "Invalid line missing polydir");
         goto skipping;
     }
+
     instance_prefix = config_options[1];
-    if (instance_prefix == NULL) {
+    if (num_config_options < 2 || instance_prefix == NULL) {
         pam_syslog(idata->pamh, LOG_NOTICE, "Invalid line missing
instance_prefix");
         goto skipping;
     }
+
     method = config_options[2];
-    if (method == NULL) {
+    if (num_config_options < 3 || method == NULL) {
         pam_syslog(idata->pamh, LOG_NOTICE, "Invalid line missing method");
         goto skipping;
     }
@@ -216,60 +219,72 @@ static int process_line(char *line, cons
      * is not performed), read the user ids, convert names into uids, and
      * add to polyinstantiated directory structure.
      */
-    if (uids) {
-            uid_t *uidptr;
-            char *saveptr, *token;
-            char *ustr, *sstr;
-            int count;
-
-            sstr = uids;
-            if (*uids == '~') {
-                    poly.exclusive = 1;
-                    uids++;
-            }
+    if (num_config_options >= 4 && uids) {
+            if (strcmp(uids, "none") != 0) {
+                    uid_t *uidptr;
+                    char *saveptr, *token;
+                    const char *ustr, *sstr;
+                    int count, i;
+
+                    sstr = uids;
+                    if (*uids == '~') {
+                            poly.exclusive = 1;
+                            uids++;
+                    }

-            for (count = 0, ustr = uids; ; count++, ustr = NULL) {
-                    token = strtok_r(ustr, ",", &saveptr);
-                    if (token == NULL)
-                            break;
-            }
+                    for (count = 0, ustr = uids; ; count++, ustr = NULL) {
+                            token = strtok_r(ustr, ",", &saveptr);
+                            if (token == NULL)
+                                    break;
+                    }

-            if (count == 0) {
-                    pam_syslog(idata->pamh, LOG_NOTICE, "Invalid
override list %s", sstr);
-                    goto skipping;
-            }
+                    if (count == 0) {
+                            pam_syslog(idata->pamh, LOG_NOTICE,
"Invalid override list %s", sstr);
+                            goto skipping;
+                    }

-            poly.num_uids = count;
-            poly.uid = (uid_t *)malloc(count * sizeof(uid_t));
-            if (poly.uid == NULL) {
-                    pam_syslog(idata->pamh, LOG_NOTICE, "out of memory");
-                    goto skipping;
-            }
-            uidptr = poly.uid;
+                    poly.num_uids = count;
+                    poly.uid = (uid_t *)malloc(count * sizeof(uid_t));
+                    if (poly.uid == NULL) {
+                            pam_syslog(idata->pamh, LOG_NOTICE, "out
of memory");
+                            goto skipping;
+                    }
+                    uidptr = poly.uid;

-            for (ustr = uids; ;ustr = NULL) {
-                    struct passwd *pwd;
-                    token = strtok_r(ustr, ",", &saveptr);
-                    if (token == NULL)
-                            break;
-
-                    pwd = getpwnam(token);
-                    if (pwd == NULL) {
-                            pam_syslog(idata->pamh, LOG_ERR, "Unknown
user %s in configuration", token);
-                            poly.num_uids--;	
-                    } else {
-                            if (pwd->pw_uid == idata->uid) {
-                                    /*
-                                     * Why put it in the list if this
-                                     * user doesn't polyinstiate it
-                                     */
-                                    free(poly.uid);
-                                    goto out;
+                    for (ustr = uids; ;ustr = NULL) {
+                            struct passwd *pwd;
+                            token = strtok_r(ustr, ",", &saveptr);
+                            if (token == NULL)
+                                    break;
+
+                            pwd = getpwnam(token);
+                            if (pwd == NULL) {
+                                    pam_syslog(idata->pamh, LOG_ERR,
"Unknown user %s in configuration", token);
+                                    poly.num_uids--;	
+                            } else {
+                                    if (pwd->pw_uid == idata->uid) {
+                                            /*
+                                             * Why put it in the list if this
+                                             * user doesn't polyinstiate it
+                                             */
+                                            free(poly.uid);
+                                            goto out;
+                                    }
+                                    *uidptr = pwd->pw_uid;
+                                    uidptr++;
                             }
-                            *uidptr = pwd->pw_uid;
-                            uidptr++;
                     }
             }
+    } else {
+            pam_syslog(idata->pamh, LOG_NOTICE, "Invalid line missing
override list or 'none'");
+            goto skipping;
+
+    }
+
+    run_init_script = config_options[4];
+    if (num_config_options < 5 || run_init_script == NULL) {
+        pam_syslog(idata->pamh, LOG_NOTICE, "Invalid line missing
init script configuration");
+        goto skipping;
     }

     /*
@@ -313,6 +328,10 @@ static int process_line(char *line, cons
     strcpy(poly.dir, dir);
     strcpy(poly.instance_prefix, instance_prefix);

+    poly.run_init = DONT_RUN_INIT_SCRIPT;
+    if (strcmp(run_init_script, "run_init") == 0)
+	    poly.run_init = RUN_INIT_SCRIPT;
+
     poly.method = NONE;
     if (strcmp(method, "user") == 0)
 	    poly.method = USER;
@@ -1041,7 +1060,8 @@ static int create_dirs(struct polydir_s
      */

 inst_init:
-    rc = inst_init(polyptr, ipath, idata, newdir);
+    if (polyptr->run_init == RUN_INIT_SCRIPT)
+      rc = inst_init(polyptr, ipath, idata, newdir);
     return rc;
 }

--- Linux-PAM-0.99.8.1/modules/pam_namespace/pam_namespace.h	2007-11-14
10:49:21.000000000 -0600
+++ Linux-PAM-0.99.8.1.new/modules/pam_namespace/pam_namespace.h	2007-11-14
10:48:57.000000000 -0600
@@ -131,6 +131,10 @@ enum unmnt_op {
     UNMNT_ONLY,
 };

+enum run_init_op {
+    RUN_INIT_SCRIPT,
+    DONT_RUN_INIT_SCRIPT
+};
 /*
  * Structure that holds information about a directory to polyinstantiate
  */
@@ -138,7 +142,8 @@ struct polydir_s {
     char dir[PATH_MAX];    	       	/* directory to polyinstantiate */
     char instance_prefix[PATH_MAX];	/* prefix for instance dir path name */
     enum polymethod method;		/* method used to polyinstantiate */
+    enum run_init_op run_init;
     unsigned int num_uids;		/* number of override uids */
     uid_t *uid;				/* list of override uids */
     int exclusive;			/* polyinstatiate exclusively for override uids */

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
