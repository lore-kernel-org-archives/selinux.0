Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j75GKEOb001411
	for <selinux@tycho.nsa.gov>; Fri, 5 Aug 2005 12:20:14 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j75GD626003133
	for <selinux@tycho.nsa.gov>; Fri, 5 Aug 2005 16:13:06 GMT
Message-ID: <42F3904F.5080401@tresys.com>
Date: Fri, 05 Aug 2005 12:14:07 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Red Hat's passwd
Content-Type: multipart/mixed;
 boundary="------------030603000604000504070301"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030603000604000504070301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch removes the selinux code from Red Hat's passwd.c and 
uses the libselinux function checkPasswdAccess. Aside from eliminating 
some duplication this will make it easier for passwd to use the 
userspace security server with dynamic object classes since it will only 
require a libselinux change and both shadows passwd and Red Hats passwd 
will benefit.

Let me know if there are problems merging this into mainline.

Joshua

--------------030603000604000504070301
Content-Type: text/plain;
 name="passwd-0.70-checkaccess.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="passwd-0.70-checkaccess.patch"

diff -purN passwd-0.70/passwd.c passwd-0.70-new/passwd.c
--- passwd-0.70/passwd.c	2005-06-17 05:53:50.000000000 -0400
+++ passwd-0.70-new/passwd.c	2005-08-05 11:03:11.213620856 -0400
@@ -54,7 +54,6 @@
 #include <selinux/selinux.h>
 #include <selinux/context.h>
 #include <selinux/av_permissions.h>
-#include "selinux_utils.h"
 #endif
 
 #ifdef WITH_AUDIT
@@ -366,7 +365,8 @@ main(int argc, const char **argv)
 #ifdef WITH_SELINUX
 	if ((is_selinux_enabled() > 0) &&
 	    (getuid() == 0) &&
-	    (check_selinux_access(username, pwd->pw_uid, PASSWD__PASSWD) != 0)) {
+	    (pwd->pw_uid != getuid ()) &&
+	    (checkPasswdAccess(PASSWD__PASSWD) != 0)) {
 		security_context_t user_context;
 		if (getprevcon(&user_context) < 0) {
 			user_context = strdup(_("Unknown user context"));
diff -purN passwd-0.70/selinux_utils.c passwd-0.70-new/selinux_utils.c
--- passwd-0.70/selinux_utils.c	2005-01-25 17:00:49.000000000 -0500
+++ passwd-0.70-new/selinux_utils.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,82 +0,0 @@
-/*
- * Copyright Red Hat, Inc., 2003,2004.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, and the entire permission notice in its entirety,
- *    including the disclaimer of warranties.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. The name of the author may not be used to endorse or promote
- *    products derived from this software without specific prior
- *    written permission.
- *
- * ALTERNATIVELY, this product may be distributed under the terms of
- * the GNU Public License, in which case the provisions of the GPL are
- * required INSTEAD OF the above restrictions.  (This clause is
- * necessary due to a potential bad interaction between the GPL and
- * the restrictions contained in a BSD-style copyright.)
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
- * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- * DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT,
- * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
- * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
- * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
- * OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-/* Written by Daniel Walsh <dwalsh@redhat.com> */
-
-#include "config.h"
-#include <sys/types.h>
-#include <stdio.h>
-#include <string.h>
-#include <selinux/selinux.h>
-#include <selinux/flask.h>
-#include <selinux/av_permissions.h>
-#include <selinux/context.h>
-#include "selinux_utils.h"
-
-int
-check_selinux_access(const char *change_user, int change_uid, unsigned int access)
-{
-	int status = -1;
-	security_context_t user_context;
-	const char *user;
-
-	if (security_getenforce() == 0) {
-		status = 0;
-	} else {
-		if (getprevcon(&user_context) == 0) {
-			context_t c;
-			c = context_new(user_context);
-			user = context_user_get(c);
-			if (change_uid != 0 && strcmp(change_user, user) == 0) {
-				status = 0;
-			} else {
-				struct av_decision avd;
-				int retval;
-				retval = security_compute_av(user_context,
-							     user_context,
-							     SECCLASS_PASSWD,
-							     access,
-							     &avd);
-				if ((retval == 0) && 
-				    ((access & avd.allowed) == access)) {
-					status = 0;
-				}
-			}
-			context_free(c);
-			freecon(user_context);
-		}
-	}
-	return status;
-}
diff -purN passwd-0.70/selinux_utils.h passwd-0.70-new/selinux_utils.h
--- passwd-0.70/selinux_utils.h	2005-01-25 17:00:49.000000000 -0500
+++ passwd-0.70-new/selinux_utils.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,4 +0,0 @@
-#ifndef __RH_SELINUX_UTILS_H
-#define __RH_SELINUX_UTILS_H
-int check_selinux_access(const char *change_user, int change_uid, unsigned int access);
-#endif

--------------030603000604000504070301--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
