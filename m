Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAQFNeqY010817
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 10:23:40 -0500
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAQFNKYQ012669
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 15:23:34 GMT
Received: by nf-out-0910.google.com with SMTP id k4so865859nfd
        for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 07:23:33 -0800 (PST)
Message-ID: <cadfc0e40711260723g5ccd09brf47a3a0b9037203@mail.gmail.com>
Date: Mon, 26 Nov 2007 09:23:28 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: [RFC Patch 3/10] PAM Namespace: options when setexeccon not called
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch introduces two pam_namespace configuration options ('use_getcon'
and 'user_default_level_fallback') to deal with applications that don't
call setexeccon for example gdm and su and which are unaffected by pam_selinux.
If getexecon fails and 'user_default_level_fallback' has been specified
then the session context will become the current context with the default
level of the selinux user replacing the current contexts level. The primary
use of this option is with gdm when using MLS policy. If getexecon fails
and 'use_getcon' has been specified then the session context will become
the current context.

 pam_namespace.c |   81 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 pam_namespace.h |    2 +
 2 files changed, 76 insertions(+), 7 deletions(-)


--- Linux-PAM-0.99.8.1/modules/pam_namespace/pam_namespace.c	2007-11-14
08:56:49.000000000 -0600
+++ Linux-PAM-0.99.8.1.new/modules/pam_namespace/pam_namespace.c	2007-11-14
09:17:35.000000000 -0600
@@ -31,6 +31,7 @@
  */

 #include "pam_namespace.h"
+#include "libpam/pam_private.h"

 /*
  * Copies the contents of ent into pent
@@ -503,6 +504,8 @@ static int form_context(const struct pol
 	int rc = PAM_SUCCESS;
 	security_context_t scon = NULL;
 	security_class_t tclass;
+        char *selinuxuser, *level;
+        context_t scontext = NULL;

 	/*
 	 * Get the security context of the directory to polyinstantiate.
@@ -516,12 +519,56 @@ static int form_context(const struct pol

 	if (polyptr->method == USER) return PAM_SUCCESS;

-	rc = getexeccon(&scon);
-	if (rc < 0 || scon == NULL) {
-		pam_syslog(idata->pamh, LOG_ERR,
-			   "Error getting exec context, %m");
-		return PAM_SESSION_ERR;
-	}
+        /*
+         * Check whether setexeccon was called prior to opening
+         * the pam session.
+         */
+        rc = getexeccon(&scon);
+        if (rc < 0 || scon == NULL) {
+                /*
+                 * setexeccon wasn't called. If user_default_level_fallback
+                 * was set use the current context and the users default level.
+                 */
+                if (idata->flags & PAMNS_USER_DEFAULT_LEVEL_FALLBACK) {
+                        rc = getseuserbyname(idata->user,
&selinuxuser, &level);
+                        if (rc < 0) {
+                                pam_syslog(idata->pamh, LOG_ERR,
+                                           "Error getting selinux user, %m");
+                                return PAM_SESSION_ERR;
+                        }
+                        rc = getcon(&scon);
+                        if (rc < 0 || scon == NULL) {
+                                pam_syslog(idata->pamh, LOG_ERR,
+                                           "Error getting context, %m");
+                                return PAM_SESSION_ERR;
+                        }
+                        scontext = context_new(scon);
+                        if (!scontext) {
+                                pam_syslog(idata->pamh, LOG_ERR,
"Error creating context_t for %s", scon);
+                                goto fail;
+                        }
+
+                        if (context_range_set(scontext, level) != 0) {
+                                pam_syslog(idata->pamh, LOG_ERR,
"Unable to set MLS level of context");
+                                goto fail;
+                        }
+                        scon = strdup(context_str(scontext));
+                        context_free(scontext);
+                        free(selinuxuser);
+                        free(level);
+                } else if (idata->flags & PAMNS_USE_GETCON) {
+                        rc = getcon(&scon);
+                        if (rc < 0 || scon == NULL) {
+                                pam_syslog(idata->pamh, LOG_ERR,
+                                           "Error getting context, %m");
+                                return PAM_SESSION_ERR;
+                        }
+                } else {
+                        pam_syslog(idata->pamh, LOG_ERR,
+                                   "Error no available context
because setexeccon has not been called.");
+                        return PAM_SESSION_ERR;
+                }
+        }

 	/*
 	 * If polyinstantiating based on security context, get current
@@ -553,7 +600,7 @@ static int form_context(const struct pol
 	 */

 	if (polyptr->method == LEVEL) {
-		context_t scontext = NULL;
+		scontext = NULL;
 		context_t fcontext = NULL;
 		rc = PAM_SESSION_ERR;

@@ -571,6 +618,10 @@ static int form_context(const struct pol
 			pam_syslog(idata->pamh, LOG_ERR, "Unable to set MLS Componant of context");
 			goto fail;
 		}
+		if (idata->flags & PAMNS_DEBUG)
+                        pam_syslog(idata->pamh, LOG_DEBUG,
+                                   "context_range_set %s %s",
context_str(fcontext), context_str(scontext));
+
 		*i_context=strdup(context_str(fcontext));
 		if (! *i_context) {
 			pam_syslog(idata->pamh, LOG_ERR, "out of memory");
@@ -1406,6 +1457,22 @@ PAM_EXTERN int pam_sm_open_session(pam_h
             idata.flags |= PAMNS_IGN_CONFIG_ERR;
         if (strcmp(argv[i], "ignore_instance_parent_mode") == 0)
             idata.flags |= PAMNS_IGN_INST_PARENT_MODE;
+        if (strcmp(argv[i], "user_default_level_fallback") == 0) {
+		if (idata.flags & PAMNS_USE_GETCON) {
+                        pam_syslog(idata.pamh, LOG_ERR,
+                                   "Both user_default_level_fallback
and use_getcon option given please select one or the other.");
+                        return PAM_SESSION_ERR;
+                }
+                idata.flags |= PAMNS_USER_DEFAULT_LEVEL_FALLBACK;
+        }
+        if (strcmp(argv[i], "use_getcon") == 0) {
+                if (idata.flags & PAMNS_USER_DEFAULT_LEVEL_FALLBACK) {
+                        pam_syslog(idata.pamh, LOG_ERR,
+                                   "Both user_default_level_fallback
and use_getcon option given please select one or the other.");
+                        return PAM_SESSION_ERR;
+                }
+                idata.flags |= PAMNS_USE_GETCON;
+        }
         if (strcmp(argv[i], "unmnt_remnt") == 0)
             unmnt = UNMNT_REMNT;
         if (strcmp(argv[i], "unmnt_only") == 0)
--- Linux-PAM-0.99.8.1/modules/pam_namespace/pam_namespace.h	2007-11-14
08:56:49.000000000 -0600
+++ Linux-PAM-0.99.8.1.new/modules/pam_namespace/pam_namespace.h	2007-11-14
09:00:16.000000000 -0600
@@ -88,6 +88,8 @@
 #define PAMNS_IGN_CONFIG_ERR  0x00004000 /* Ignore format error in conf file */
 #define PAMNS_IGN_INST_PARENT_MODE  0x00008000 /* Ignore instance
parent mode */
 #define PAMNS_NO_UNMOUNT_ON_CLOSE  0x00010000 /* no unmount at session close */
+#define PAMNS_USER_DEFAULT_LEVEL_FALLBACK 0x00020000 /* if getexeccon
not called use user default level */
+#define PAMNS_USE_GETCON  0x00040000 /* if getexeccon not called use
getcon for context */

 #define NAMESPACE_MAX_DIR_LEN 80
 #define NAMESPACE_POLYDIR_DATA "pam_namespace:polydir_data"

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
