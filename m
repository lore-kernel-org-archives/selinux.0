Message-ID: <45DB0624.5060907@redhat.com>
Date: Tue, 20 Feb 2007 09:31:00 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: libselinux patch
Content-Type: multipart/mixed;
 boundary="------------070208010609060603020507"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070208010609060603020507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch initializes all swig parameters to prevent possible crashes 
in python.

Also changes is_selinux_enabled to work even if  signaled and not have 
short reads.



--------------070208010609060603020507
Content-Type: text/x-patch;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

--- libselinux-2.0.1/src/selinuxswig_wrap.c.rhat	2007-02-20 09:25:03.000000000 -0500
+++ libselinux-2.0.1/src/selinuxswig_wrap.c	2007-02-20 09:25:14.000000000 -0500
@@ -2832,7 +2832,7 @@
   security_context_t *arg1 = (security_context_t *) 0 ;
   int result;
   security_context_t temp1 = NULL ;
-  char *temp10 ;
+  char *temp10 = NULL ;
   
   {
     arg1 = &temp1;
@@ -2879,7 +2879,7 @@
   int val1 ;
   int ecode1 = 0 ;
   security_context_t temp2 = NULL ;
-  char *temp20 ;
+  char *temp20 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
@@ -2911,7 +2911,7 @@
   security_context_t *arg1 = (security_context_t *) 0 ;
   int result;
   security_context_t temp1 = NULL ;
-  char *temp10 ;
+  char *temp10 = NULL ;
   
   {
     arg1 = &temp1;
@@ -2937,7 +2937,7 @@
   security_context_t *arg1 = (security_context_t *) 0 ;
   int result;
   security_context_t temp1 = NULL ;
-  char *temp10 ;
+  char *temp10 = NULL ;
   
   {
     arg1 = &temp1;
@@ -2981,7 +2981,7 @@
   security_context_t *arg1 = (security_context_t *) 0 ;
   int result;
   security_context_t temp1 = NULL ;
-  char *temp10 ;
+  char *temp10 = NULL ;
   
   {
     arg1 = &temp1;
@@ -3025,7 +3025,7 @@
   security_context_t *arg1 = (security_context_t *) 0 ;
   int result;
   security_context_t temp1 = NULL ;
-  char *temp10 ;
+  char *temp10 = NULL ;
   
   {
     arg1 = &temp1;
@@ -3069,7 +3069,7 @@
   security_context_t *arg1 = (security_context_t *) 0 ;
   int result;
   security_context_t temp1 = NULL ;
-  char *temp10 ;
+  char *temp10 = NULL ;
   
   {
     arg1 = &temp1;
@@ -3117,7 +3117,7 @@
   char *buf1 = 0 ;
   int alloc1 = 0 ;
   security_context_t temp2 = NULL ;
-  char *temp20 ;
+  char *temp20 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
@@ -3155,7 +3155,7 @@
   char *buf1 = 0 ;
   int alloc1 = 0 ;
   security_context_t temp2 = NULL ;
-  char *temp20 ;
+  char *temp20 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
@@ -3192,7 +3192,7 @@
   int val1 ;
   int ecode1 = 0 ;
   security_context_t temp2 = NULL ;
-  char *temp20 ;
+  char *temp20 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
@@ -3314,7 +3314,7 @@
   int val1 ;
   int ecode1 = 0 ;
   security_context_t temp2 = NULL ;
-  char *temp20 ;
+  char *temp20 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
@@ -3475,7 +3475,7 @@
   security_context_t *arg2 = (security_context_t *) 0 ;
   int result;
   security_context_t temp2 = NULL ;
-  char *temp20 ;
+  char *temp20 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
@@ -3735,7 +3735,7 @@
   unsigned int val2 ;
   int ecode2 = 0 ;
   security_context_t temp3 = NULL ;
-  char *temp30 ;
+  char *temp30 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -3779,7 +3779,7 @@
   char *buf1 = 0 ;
   int alloc1 = 0 ;
   security_context_t temp2 = NULL ;
-  char *temp20 ;
+  char *temp20 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
@@ -4213,7 +4213,7 @@
   char *buf1 = 0 ;
   int alloc1 = 0 ;
   security_context_t temp2 = NULL ;
-  char *temp20 ;
+  char *temp20 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
@@ -4251,7 +4251,7 @@
   char *buf1 = 0 ;
   int alloc1 = 0 ;
   security_context_t temp2 = NULL ;
-  char *temp20 ;
+  char *temp20 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
@@ -4284,7 +4284,7 @@
   PyObject *resultobj = 0;
   char **arg1 = (char **) 0 ;
   int result;
-  char *temp1 ;
+  char *temp1 = NULL ;
   
   {
     arg1 = &temp1;
@@ -4310,8 +4310,8 @@
   int res1 ;
   char *buf1 = 0 ;
   int alloc1 = 0 ;
-  char *temp2 ;
-  char *temp3 ;
+  char *temp2 = NULL ;
+  char *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
--- libselinux-2.0.1/src/enabled.c.rhat	2007-02-20 09:25:03.000000000 -0500
+++ libselinux-2.0.1/src/enabled.c	2007-02-20 09:27:53.000000000 -0500
@@ -8,10 +8,44 @@
 #include <stdio.h>
 #include "policy.h"
 
+static int readFD (int fd, char **buf)
+{
+    char *p;
+    size_t size = 16384;
+    int s, filesize;
+
+    *buf = calloc (16384, sizeof (char));
+    if (*buf == 0)
+        return -1;
+
+    filesize = 0;
+    do {
+        p = &(*buf) [filesize];
+	do {
+		s = read (fd, p, 16384);
+	} while (s < 0 && errno == EINTR);
+        if (s < 0)
+            break;
+        filesize += s;
+        /* only exit for empty reads */
+        if (s == 0)
+            break;
+        size += s;
+        *buf = realloc (*buf, size);
+    } while (1);
+
+    if (filesize == 0 && s < 0) {
+        free (*buf);
+        *buf = NULL;
+        return -1;
+    }
+
+    return filesize;
+}
+
 int is_selinux_enabled(void)
 {
-	char *buf;
-	size_t size;
+	char *buf = NULL;
 	int fd;
 	ssize_t ret;
 	int enabled = 0;
@@ -21,19 +55,11 @@
 	if (fd < 0)
 		return -1;
 
-	size = selinux_page_size;
-	buf = malloc(size);
-	if (!buf) {
-		enabled = -1;
-		goto out;
-	}
-
-	memset(buf, 0, size);
-
-	ret = read(fd, buf, size - 1);
+        ret = readFD(fd, &buf);
+        close(fd);
 	if (ret < 0) {
 		enabled = -1;
-		goto out2;
+		goto out;
 	}
 
 	if (!strstr(buf, "selinuxfs"))
@@ -49,7 +75,6 @@
       out2:
 	free(buf);
       out:
-	close(fd);
 	return enabled;
 }
 
--- libselinux-2.0.1/src/selinuxswig.i.rhat	2007-02-20 09:25:03.000000000 -0500
+++ libselinux-2.0.1/src/selinuxswig.i	2007-02-20 09:25:14.000000000 -0500
@@ -28,7 +28,7 @@
 %typemap(in, numinputs=0) security_context_t *(security_context_t temp=NULL) {
 	$1 = &temp;
 }
-%typemap(argout) security_context_t * (char *temp) {
+%typemap(argout) security_context_t * (char *temp=NULL) {
 	if (*$1)
 		temp = *$1;
 	else
@@ -126,7 +126,7 @@
 extern int selinux_raw_to_trans_context(char *raw, 
 					security_context_t *transp);
 
-%typemap(in, numinputs=0) char **(char *temp) {
+%typemap(in, numinputs=0) char **(char *temp=NULL) {
 	$1 = &temp;
 }
 

--------------070208010609060603020507--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
