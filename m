Message-ID: <4457B47F.1000206@redhat.com>
Date: Tue, 02 May 2006 15:35:27 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: PAGE_SIZE is going away or at least being discouraged
Content-Type: multipart/mixed;
 boundary="------------000107080109050202010408"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000107080109050202010408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Also swig fixes from IBM

--------------000107080109050202010408
Content-Type: text/x-patch;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/src/canonicalize_context.c libselinux-1.30.3/src/canonicalize_context.c
--- nsalibselinux/src/canonicalize_context.c	2005-11-08 09:34:17.000000000 -0500
+++ libselinux-1.30.3/src/canonicalize_context.c	2006-05-02 14:48:20.000000000 -0400
@@ -5,7 +5,6 @@
 #include <stdio.h>
 #include <errno.h>
 #include <string.h>
-#include <asm/page.h>
 #include "selinux_internal.h"
 #include "policy.h"
 #include <limits.h>
@@ -23,7 +22,7 @@
 	if (fd < 0)
 		return -1;
 
-	size = PAGE_SIZE;
+	size = selinux_page_size;
 	buf = malloc(size);
 	if (!buf) {
 		ret = -1;
diff --exclude-from=exclude -N -u -r nsalibselinux/src/compute_av.c libselinux-1.30.3/src/compute_av.c
--- nsalibselinux/src/compute_av.c	2005-08-23 13:34:34.000000000 -0400
+++ libselinux-1.30.3/src/compute_av.c	2006-05-02 14:48:22.000000000 -0400
@@ -5,7 +5,6 @@
 #include <stdio.h>
 #include <errno.h>
 #include <string.h>
-#include <asm/page.h>
 #include "selinux_internal.h"
 #include "policy.h"
 #include <limits.h>
@@ -26,7 +25,7 @@
 	if (fd < 0) 
 		return -1;
 
-	len = PAGE_SIZE;
+	len = selinux_page_size;
 	buf = malloc(len);
 	if (!buf) {
 		ret = -1;
diff --exclude-from=exclude -N -u -r nsalibselinux/src/compute_create.c libselinux-1.30.3/src/compute_create.c
--- nsalibselinux/src/compute_create.c	2005-08-23 13:34:34.000000000 -0400
+++ libselinux-1.30.3/src/compute_create.c	2006-05-02 14:48:23.000000000 -0400
@@ -5,7 +5,6 @@
 #include <stdio.h>
 #include <errno.h>
 #include <string.h>
-#include <asm/page.h>
 #include "selinux_internal.h"
 #include "policy.h"
 #include <limits.h>
@@ -25,7 +24,7 @@
 	if (fd < 0)
 		return -1;
 
-	size = PAGE_SIZE;
+	size = selinux_page_size;
 	buf = malloc(size);
 	if (!buf) {
 		ret = -1;
diff --exclude-from=exclude -N -u -r nsalibselinux/src/compute_member.c libselinux-1.30.3/src/compute_member.c
--- nsalibselinux/src/compute_member.c	2005-08-25 11:32:02.000000000 -0400
+++ libselinux-1.30.3/src/compute_member.c	2006-05-02 14:48:25.000000000 -0400
@@ -5,7 +5,6 @@
 #include <stdio.h>
 #include <errno.h>
 #include <string.h>
-#include <asm/page.h>
 #include "selinux_internal.h"
 #include "policy.h"
 #include <limits.h>
@@ -25,7 +24,7 @@
 	if (fd < 0)
 		return -1;
 
-	size = PAGE_SIZE;
+	size = selinux_page_size;
 	buf = malloc(size);
 	if (!buf) {
 		ret = -1;
diff --exclude-from=exclude -N -u -r nsalibselinux/src/compute_relabel.c libselinux-1.30.3/src/compute_relabel.c
--- nsalibselinux/src/compute_relabel.c	2005-08-25 11:32:02.000000000 -0400
+++ libselinux-1.30.3/src/compute_relabel.c	2006-05-02 14:48:27.000000000 -0400
@@ -5,7 +5,6 @@
 #include <stdio.h>
 #include <errno.h>
 #include <string.h>
-#include <asm/page.h>
 #include "selinux_internal.h"
 #include "policy.h"
 #include <limits.h>
@@ -25,7 +24,7 @@
 	if (fd < 0)
 		return -1;
 
-	size = PAGE_SIZE;
+	size = selinux_page_size;
 	buf = malloc(size);
 	if (!buf) {
 		ret = -1;
diff --exclude-from=exclude -N -u -r nsalibselinux/src/compute_user.c libselinux-1.30.3/src/compute_user.c
--- nsalibselinux/src/compute_user.c	2005-08-23 13:34:34.000000000 -0400
+++ libselinux-1.30.3/src/compute_user.c	2006-05-02 14:48:32.000000000 -0400
@@ -5,7 +5,6 @@
 #include <stdio.h>
 #include <errno.h>
 #include <string.h>
-#include <asm/page.h>
 #include "selinux_internal.h"
 #include "policy.h"
 #include <limits.h>
@@ -26,7 +25,7 @@
 	if (fd < 0)
 		return -1;
 
-	size = PAGE_SIZE;
+	size = selinux_page_size;
 	buf = malloc(size);
 	if (!buf) {
 		ret = -1;
diff --exclude-from=exclude -N -u -r nsalibselinux/src/enabled.c libselinux-1.30.3/src/enabled.c
--- nsalibselinux/src/enabled.c	2005-08-23 13:34:34.000000000 -0400
+++ libselinux-1.30.3/src/enabled.c	2006-05-02 14:48:35.000000000 -0400
@@ -5,7 +5,6 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <limits.h>
-#include <asm/page.h>
 #include <stdio.h>
 #include "policy.h"
 
@@ -22,7 +21,7 @@
 	if (fd < 0)
 		return -1;
 
-	size = PAGE_SIZE;
+	size = selinux_page_size;
 	buf = malloc(size);
 	if (!buf) {
 		enabled = -1;
diff --exclude-from=exclude -N -u -r nsalibselinux/src/getcon.c libselinux-1.30.3/src/getcon.c
--- nsalibselinux/src/getcon.c	2005-08-23 13:34:34.000000000 -0400
+++ libselinux-1.30.3/src/getcon.c	2006-05-02 14:48:37.000000000 -0400
@@ -4,7 +4,6 @@
 #include "selinux_internal.h"
 #include <stdlib.h>
 #include <errno.h>
-#include <asm/page.h>
 #include "policy.h"
 
 int getcon_raw(security_context_t *context)
@@ -18,7 +17,7 @@
 	if (fd < 0)
 		return -1;
 
-	size = PAGE_SIZE;
+	size = selinux_page_size;
 	buf = malloc(size);
 	if (!buf) {
 		ret = -1;
diff --exclude-from=exclude -N -u -r nsalibselinux/src/getexeccon.c libselinux-1.30.3/src/getexeccon.c
--- nsalibselinux/src/getexeccon.c	2005-08-25 11:32:02.000000000 -0400
+++ libselinux-1.30.3/src/getexeccon.c	2006-05-02 14:48:39.000000000 -0400
@@ -3,7 +3,6 @@
 #include <string.h>
 #include <stdlib.h>
 #include <errno.h>
-#include <asm/page.h>
 #include "selinux_internal.h"
 #include "policy.h"
 
@@ -18,7 +17,7 @@
 	if (fd < 0)
 		return -1;
 
-	size = PAGE_SIZE;
+	size = selinux_page_size;
 	buf = malloc(size);
 	if (!buf) {
 		ret = -1;
diff --exclude-from=exclude -N -u -r nsalibselinux/src/getfscreatecon.c libselinux-1.30.3/src/getfscreatecon.c
--- nsalibselinux/src/getfscreatecon.c	2005-08-25 11:32:02.000000000 -0400
+++ libselinux-1.30.3/src/getfscreatecon.c	2006-05-02 14:48:41.000000000 -0400
@@ -3,7 +3,6 @@
 #include <string.h>
 #include <stdlib.h>
 #include <errno.h>
-#include <asm/page.h>
 #include "selinux_internal.h"
 #include "policy.h"
 
@@ -18,7 +17,7 @@
 	if (fd < 0)
 		return -1;
 
-	size = PAGE_SIZE;
+	size = selinux_page_size;
 	buf = malloc(size);
 	if (!buf) {
 		ret = -1;
diff --exclude-from=exclude -N -u -r nsalibselinux/src/getpidcon.c libselinux-1.30.3/src/getpidcon.c
--- nsalibselinux/src/getpidcon.c	2005-08-25 11:32:02.000000000 -0400
+++ libselinux-1.30.3/src/getpidcon.c	2006-05-02 14:48:43.000000000 -0400
@@ -4,7 +4,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <errno.h>
-#include <asm/page.h>
 #include "selinux_internal.h"
 #include "policy.h"
 
@@ -22,7 +21,7 @@
 	if (fd < 0)
 		return -1;
 
-	size = PAGE_SIZE;
+	size = selinux_page_size;
 	buf = malloc(size);
 	if (!buf) {
 		ret = -1;
diff --exclude-from=exclude -N -u -r nsalibselinux/src/getprevcon.c libselinux-1.30.3/src/getprevcon.c
--- nsalibselinux/src/getprevcon.c	2005-08-23 13:34:34.000000000 -0400
+++ libselinux-1.30.3/src/getprevcon.c	2006-05-02 14:48:45.000000000 -0400
@@ -4,7 +4,6 @@
 #include "selinux_internal.h"
 #include <stdlib.h>
 #include <errno.h>
-#include <asm/page.h>
 #include "policy.h"
 
 int getprevcon_raw(security_context_t *context)
@@ -18,7 +17,7 @@
 	if (fd < 0)
 		return -1;
 
-	size = PAGE_SIZE;
+	size = selinux_page_size;
 	buf = malloc(size);
 	if (!buf) {
 		ret = -1;
diff --exclude-from=exclude -N -u -r nsalibselinux/src/init.c libselinux-1.30.3/src/init.c
--- nsalibselinux/src/init.c	2005-12-14 14:16:46.000000000 -0500
+++ libselinux-1.30.3/src/init.c	2006-05-02 14:48:04.000000000 -0400
@@ -4,15 +4,16 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <ctype.h>
-#include <asm/page.h>
 #include <stdio.h>
 #include <dlfcn.h>
+#include <unistd.h>
 
 #include "dso.h"
 #include "policy.h"
 #include "selinux_internal.h"
 
 char *selinux_mnt = NULL;
+int selinux_page_size=0;
 
 static void init_selinuxmnt(void)
 {
@@ -27,11 +28,12 @@
 	if (!fp)
 		return;
 
-	size = PAGE_SIZE;
+	size = selinux_page_size;
+
 	buf = malloc(size);
 	if (!buf)
 		goto out;
-		
+
 	memset(buf, 0, size);
 
 	while(( bufp = fgets_unlocked(buf, size, fp)))
@@ -134,6 +136,7 @@
 static void init_lib(void) __attribute__ ((constructor));
 static void init_lib(void)
 {
+	selinux_page_size = sysconf(_SC_PAGE_SIZE);
 	init_selinuxmnt();
 	init_translations();
 }
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux_internal.h libselinux-1.30.3/src/selinux_internal.h
--- nsalibselinux/src/selinux_internal.h	2005-12-01 10:10:32.000000000 -0500
+++ libselinux-1.30.3/src/selinux_internal.h	2006-05-02 14:11:05.000000000 -0400
@@ -71,3 +71,4 @@
 
 extern int load_setlocaldefs hidden;
 extern int require_seusers hidden;
+extern int selinux_page_size hidden;
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinuxswig.i libselinux-1.30.3/src/selinuxswig.i
--- nsalibselinux/src/selinuxswig.i	2006-04-14 07:21:23.000000000 -0400
+++ libselinux-1.30.3/src/selinuxswig.i	2006-05-02 13:08:05.000000000 -0400
@@ -28,9 +28,18 @@
 %typemap(in, numinputs=0) security_context_t *(security_context_t temp) {
 	$1 = &temp;
 }
-%typemap(argout) security_context_t * {
-	$result = SWIG_Python_AppendOutput($result, PyString_FromString(*$1));
+%typemap(argout) security_context_t * (char *temp) {
+	if (*$1)
+		temp = *$1;
+	else
+		temp = "";
+	$result = SWIG_Python_AppendOutput($result, PyString_FromString(temp));
+}
+
+%typemap(in) security_context_t {
+	$1 = (security_context_t)PyString_AsString($input);
 }
+
 %typedef unsigned mode_t;
 
 extern int is_selinux_enabled(void);

--------------000107080109050202010408--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
