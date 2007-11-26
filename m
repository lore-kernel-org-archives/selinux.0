Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAQFNjPd010830
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 10:23:45 -0500
Received: from nf-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAQFNGjn025808
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 15:23:38 GMT
Received: by nf-out-0910.google.com with SMTP id k4so865788nfd
        for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 07:23:37 -0800 (PST)
Message-ID: <cadfc0e40711260723w73a801ddhcf727e5edd94eb6a@mail.gmail.com>
Date: Mon, 26 Nov 2007 09:23:36 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: [RFC Patch 4/10] PAM Namespace: shared polyinstantiated directories
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch introduces two new methods for naming polyinstantiated directories
'lvlshared' and 'ctxshared'. The current implementation methods context and
level always append the user name to the generated directory name. The new
methods allow for the generation of directory names without appending the user
name so that the directories can be shared by multiple users. This patch also
includes some minor changes to improve debug output.

 pam_namespace.c |   57 +++++++++++++++++++++++++++++++++++---------------------
 pam_namespace.h |    4 ++-
 2 files changed, 39 insertions(+), 22 deletions(-)

--- Linux-PAM-0.99.8.1/modules/pam_namespace/pam_namespace.c	2007-11-14
09:35:06.000000000 -0600
+++ Linux-PAM-0.99.8.1.new/modules/pam_namespace/pam_namespace.c	2007-11-14
09:37:59.000000000 -0600
@@ -260,18 +260,20 @@ static int process_line(char *line, cons
             poly.method = TMPFS;

 #ifdef WITH_SELINUX
+    if (strcmp(method, "lvlshared") == 0) {
+              poly.method = LEVEL_SHARED;
+    }
+
+    if (strcmp(method, "ctxshared") == 0) {
+              poly.method = CONTEXT_SHARED;
+    }
+
     if (strcmp(method, "level") == 0) {
-        if (idata->flags & PAMNS_CTXT_BASED_INST)
             poly.method = LEVEL;
-	else
-            poly.method = USER;
     }

     if (strcmp(method, "context") == 0) {
-        if (idata->flags & PAMNS_CTXT_BASED_INST)
             poly.method = CONTEXT;
-	else
-            poly.method = USER;
     }

 #endif
@@ -452,13 +454,14 @@ static int ns_override(struct polydir_s
 {
     unsigned int i;

-    if (idata->flags & PAMNS_DEBUG)
-    	pam_syslog(idata->pamh, LOG_DEBUG,
-		"Checking for ns override in dir %s for uid %d",
-		polyptr->dir, uid);

     for (i = 0; i < polyptr->num_uids; i++) {
         if (uid == polyptr->uid[i]) {
+	    if (idata->flags & PAMNS_DEBUG) {
+	        pam_syslog(idata->pamh, LOG_DEBUG,
+		       "ns override in dir %s for uid %d",
+		       polyptr->dir, uid);
+	    }
             return !polyptr->exclusive;
         }
     }
@@ -577,7 +580,7 @@ static int form_context(const struct pol
 	 * polyinstantiated instance directory.
 	 */

-	if (polyptr->method == CONTEXT) {
+	if (polyptr->method == CONTEXT || polyptr->method == CONTEXT_SHARED) {
 		tclass = string_to_security_class("dir");

 		if (security_compute_member(scon, *origcon, tclass,
@@ -599,23 +602,23 @@ static int form_context(const struct pol
 	 * and change the directories MLS Level to match process.
 	 */

-	if (polyptr->method == LEVEL) {
+	if (polyptr->method == LEVEL || polyptr->method == LEVEL_SHARED) {
 		scontext = NULL;
 		context_t fcontext = NULL;
 		rc = PAM_SESSION_ERR;

 		scontext = context_new(scon);
 		if (! scontext) {
-			pam_syslog(idata->pamh, LOG_ERR, "out of memory");
+                        pam_syslog(idata->pamh, LOG_ERR, "Error
creating context_t for %s", scon);
 			goto fail;
 		}
 		fcontext = context_new(*origcon);
 		if (! fcontext) {
-			pam_syslog(idata->pamh, LOG_ERR, "out of memory");
+			pam_syslog(idata->pamh, LOG_ERR, "Error creating context_t for
%s", *origcon);
 			goto fail;
 		}
 		if (context_range_set(fcontext, context_range_get(scontext)) != 0) {
-			pam_syslog(idata->pamh, LOG_ERR, "Unable to set MLS Componant of context");
+			pam_syslog(idata->pamh, LOG_ERR, "Unable to set MLS range of context");
 			goto fail;
 		}
 		if (idata->flags & PAMNS_DEBUG)
@@ -623,7 +626,7 @@ static int form_context(const struct pol
                                    "context_range_set %s %s",
context_str(fcontext), context_str(scontext));

 		*i_context=strdup(context_str(fcontext));
-		if (! *i_context) {
+		if (!*i_context) {
 			pam_syslog(idata->pamh, LOG_ERR, "out of memory");
 			goto fail;
 		}
@@ -685,18 +688,30 @@ static int poly_name(const struct polydi
     	    break;

 #ifdef WITH_SELINUX
-    	case LEVEL:
-        case CONTEXT:
+    	case LEVEL_SHARED:
+        case CONTEXT_SHARED:
 	    if (selinux_trans_to_raw_context(*i_context, &rawcon) < 0) {
 		pam_syslog(idata->pamh, LOG_ERR, "Error translating directory context");
 		goto fail;
 	    }    	
-	    if (asprintf(i_name, "%s_%s", rawcon, idata->user) < 0) {
-		*i_name = NULL;
-		goto fail;
+	    if (asprintf(i_name, "%s", rawcon) < 0) {
+                    *i_name = NULL;
+                    goto fail;
 	    }
     	    break;

+        case LEVEL:
+        case CONTEXT:
+               if (selinux_trans_to_raw_context(*i_context, &rawcon) < 0) {
+                       pam_syslog(idata->pamh, LOG_ERR, "Error
translating directory context");
+                       goto fail;
+               }    	
+               if (asprintf(i_name, "%s_%s", rawcon, idata->user) < 0) {
+                       *i_name = NULL;
+                       goto fail;
+               }
+            break;
+
 #endif /* WITH_SELINUX */

 	case TMPDIR:
--- Linux-PAM-0.99.8.1/modules/pam_namespace/pam_namespace.h	2007-11-14
09:35:06.000000000 -0600
+++ Linux-PAM-0.99.8.1.new/modules/pam_namespace/pam_namespace.h	2007-11-14
09:32:51.000000000 -0600
@@ -104,7 +104,9 @@ enum polymethod {
     CONTEXT,
     LEVEL,
     TMPDIR,
-    TMPFS
+    TMPFS,
+    CONTEXT_SHARED,
+    LEVEL_SHARED
 };

 /*

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
