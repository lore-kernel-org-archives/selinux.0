Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2IDT8ao019118
	for <selinux@tycho.nsa.gov>; Sun, 18 Mar 2007 09:29:08 -0400
Received: from web51509.mail.re2.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l2IDT7l0024298
	for <selinux@tycho.nsa.gov>; Sun, 18 Mar 2007 13:29:08 GMT
Date: Sun, 18 Mar 2007 06:28:23 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: [PATCH] libselinux lazy init
To: SELinux List <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-347127218-1174224503=:69237"
Message-ID: <183389.69237.qm@web51509.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-347127218-1174224503=:69237
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,

Attached is the re-worked (and tested) patch that changes libselinux's startup
behavior of reading /etc/selinux/config to be on-demand. This improves
performance measurably for small programs that do not need to know the details of
policy. (Examples are cp, ls, id, install, ...) Please apply.

Signed-off-by: Steve Grubb <linux_4ever@yahoo.com>

-Steve


 
____________________________________________________________________________________
No need to miss a message. Get email on-the-go 
with Yahoo! Mail for Mobile. Get started.
http://mobile.yahoo.com/mail 
--0-347127218-1174224503=:69237
Content-Type: text/x-patch; name="libselinux-2.0.7-lazy-config.patch"
Content-Description: 2116209527-libselinux-2.0.7-lazy-config.patch
Content-Disposition: inline; filename="libselinux-2.0.7-lazy-config.patch"

diff -urp libselinux-2.0.7.orig/src/selinux_config.c libselinux-2.0.7/src/selinux_config.c
--- libselinux-2.0.7.orig/src/selinux_config.c	2007-03-17 21:09:48.000000000 -0400
+++ libselinux-2.0.7/src/selinux_config.c	2007-03-18 09:03:05.000000000 -0400
@@ -7,6 +7,7 @@
 #include <stdlib.h>
 #include <limits.h>
 #include <unistd.h>
+#include <pthread.h>
 #include "selinux_internal.h"
 #include "get_default_type_internal.h"
 
@@ -40,6 +41,24 @@
 #define SECURETTY_TYPES   18
 #define NEL               19
 
+/* Make pthread_once optional */
+#pragma weak pthread_once
+
+/* Part of one-time lazy init */
+static pthread_once_t once = PTHREAD_ONCE_INIT;
+static void init_selinux_config(void);
+
+/* Call handler iff the first call.  */
+#define __selinux_once(ONCE_CONTROL, INIT_FUNCTION)	\
+	do {						\
+		if (pthread_once != NULL)		\
+			pthread_once (&(ONCE_CONTROL), (INIT_FUNCTION));  \
+		else if ((ONCE_CONTROL) == PTHREAD_ONCE_INIT) {		  \
+			INIT_FUNCTION ();		\
+			(ONCE_CONTROL) = 2;		\
+		}					\
+	} while (0)
+
 /* New layout is relative to SELINUXDIR/policytype. */
 static char *file_paths[NEL];
 #define L1(l) L2(l)
@@ -115,6 +134,7 @@ static char *selinux_policytype;
 
 int selinux_getpolicytype(char **type)
 {
+	__selinux_once(once, init_selinux_config);
 	if (!selinux_policytype)
 		return -1;
 	*type = strdup(selinux_policytype);
@@ -124,9 +144,7 @@ int selinux_getpolicytype(char **type)
 hidden_def(selinux_getpolicytype)
 
 static char *selinux_policyroot = NULL;
-static char *selinux_rootpath = NULL;
-
-static void init_selinux_config(void) __attribute__ ((constructor));
+static const char *selinux_rootpath = SELINUXDIR;
 
 static void init_selinux_config(void)
 {
@@ -139,7 +157,6 @@ static void init_selinux_config(void)
 	if (selinux_policyroot)
 		return;
 
-	selinux_rootpath = SELINUXDIR;
 	fp = fopen(SELINUXCONFIG, "r");
 	if (fp) {
 		__fsetlocking(fp, FSETLOCKING_BYCALLER);
@@ -224,6 +241,7 @@ static void fini_selinux_policyroot(void
 
 static const char *get_path(int idx)
 {
+	__selinux_once(once, init_selinux_config);
 	return file_paths[idx];
 }
 
@@ -236,6 +254,7 @@ hidden_def(selinux_default_type_path)
 
 const char *selinux_policy_root()
 {
+	__selinux_once(once, init_selinux_config);
 	return selinux_policyroot;
 }
 

--0-347127218-1174224503=:69237--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
