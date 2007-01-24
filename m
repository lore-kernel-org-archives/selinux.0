Message-ID: <45B7968E.8040106@redhat.com>
Date: Wed, 24 Jan 2007 12:25:34 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: libselinux python binding segfault patch
Content-Type: multipart/mixed;
 boundary="------------060803060606000500050706"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060803060606000500050706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes a segfault in the python binding when getfilecon is 
called with a non existant file.


--------------060803060606000500050706
Content-Type: text/x-patch;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

Binary files nsalibselinux/src/selinux.pyc and libselinux-1.34.0/src/selinux.pyc differ
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinuxswig.i libselinux-1.34.0/src/selinuxswig.i
--- nsalibselinux/src/selinuxswig.i	2006-11-16 17:15:25.000000000 -0500
+++ libselinux-1.34.0/src/selinuxswig.i	2007-01-24 12:16:39.000000000 -0500
@@ -25,7 +25,7 @@
 %apply int *OUTPUT { int * };
 %apply int *OUTPUT { size_t * };
 
-%typemap(in, numinputs=0) security_context_t *(security_context_t temp) {
+%typemap(in, numinputs=0) security_context_t *(security_context_t temp=NULL) {
 	$1 = &temp;
 }
 %typemap(argout) security_context_t * (char *temp) {
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinuxswig_wrap.c libselinux-1.34.0/src/selinuxswig_wrap.c
--- nsalibselinux/src/selinuxswig_wrap.c	2006-11-16 17:15:25.000000000 -0500
+++ libselinux-1.34.0/src/selinuxswig_wrap.c	2007-01-24 12:16:58.000000000 -0500
@@ -2831,7 +2831,7 @@
   PyObject *resultobj = 0;
   security_context_t *arg1 = (security_context_t *) 0 ;
   int result;
-  security_context_t temp1 ;
+  security_context_t temp1 = NULL ;
   char *temp10 ;
   
   {
@@ -2878,7 +2878,7 @@
   int result;
   int val1 ;
   int ecode1 = 0 ;
-  security_context_t temp2 ;
+  security_context_t temp2 = NULL ;
   char *temp20 ;
   PyObject * obj0 = 0 ;
   
@@ -2910,7 +2910,7 @@
   PyObject *resultobj = 0;
   security_context_t *arg1 = (security_context_t *) 0 ;
   int result;
-  security_context_t temp1 ;
+  security_context_t temp1 = NULL ;
   char *temp10 ;
   
   {
@@ -2936,7 +2936,7 @@
   PyObject *resultobj = 0;
   security_context_t *arg1 = (security_context_t *) 0 ;
   int result;
-  security_context_t temp1 ;
+  security_context_t temp1 = NULL ;
   char *temp10 ;
   
   {
@@ -2980,7 +2980,7 @@
   PyObject *resultobj = 0;
   security_context_t *arg1 = (security_context_t *) 0 ;
   int result;
-  security_context_t temp1 ;
+  security_context_t temp1 = NULL ;
   char *temp10 ;
   
   {
@@ -3024,7 +3024,7 @@
   PyObject *resultobj = 0;
   security_context_t *arg1 = (security_context_t *) 0 ;
   int result;
-  security_context_t temp1 ;
+  security_context_t temp1 = NULL ;
   char *temp10 ;
   
   {
@@ -3068,7 +3068,7 @@
   PyObject *resultobj = 0;
   security_context_t *arg1 = (security_context_t *) 0 ;
   int result;
-  security_context_t temp1 ;
+  security_context_t temp1 = NULL ;
   char *temp10 ;
   
   {
@@ -3116,7 +3116,7 @@
   int res1 ;
   char *buf1 = 0 ;
   int alloc1 = 0 ;
-  security_context_t temp2 ;
+  security_context_t temp2 = NULL ;
   char *temp20 ;
   PyObject * obj0 = 0 ;
   
@@ -3154,7 +3154,7 @@
   int res1 ;
   char *buf1 = 0 ;
   int alloc1 = 0 ;
-  security_context_t temp2 ;
+  security_context_t temp2 = NULL ;
   char *temp20 ;
   PyObject * obj0 = 0 ;
   
@@ -3191,7 +3191,7 @@
   int result;
   int val1 ;
   int ecode1 = 0 ;
-  security_context_t temp2 ;
+  security_context_t temp2 = NULL ;
   char *temp20 ;
   PyObject * obj0 = 0 ;
   
@@ -3313,7 +3313,7 @@
   int result;
   int val1 ;
   int ecode1 = 0 ;
-  security_context_t temp2 ;
+  security_context_t temp2 = NULL ;
   char *temp20 ;
   PyObject * obj0 = 0 ;
   
@@ -3474,7 +3474,7 @@
   security_context_t arg1 ;
   security_context_t *arg2 = (security_context_t *) 0 ;
   int result;
-  security_context_t temp2 ;
+  security_context_t temp2 = NULL ;
   char *temp20 ;
   PyObject * obj0 = 0 ;
   
@@ -3734,7 +3734,7 @@
   int alloc1 = 0 ;
   unsigned int val2 ;
   int ecode2 = 0 ;
-  security_context_t temp3 ;
+  security_context_t temp3 = NULL ;
   char *temp30 ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
@@ -3778,7 +3778,7 @@
   int res1 ;
   char *buf1 = 0 ;
   int alloc1 = 0 ;
-  security_context_t temp2 ;
+  security_context_t temp2 = NULL ;
   char *temp20 ;
   PyObject * obj0 = 0 ;
   
@@ -4212,7 +4212,7 @@
   int res1 ;
   char *buf1 = 0 ;
   int alloc1 = 0 ;
-  security_context_t temp2 ;
+  security_context_t temp2 = NULL ;
   char *temp20 ;
   PyObject * obj0 = 0 ;
   
@@ -4250,7 +4250,7 @@
   int res1 ;
   char *buf1 = 0 ;
   int alloc1 = 0 ;
-  security_context_t temp2 ;
+  security_context_t temp2 = NULL ;
   char *temp20 ;
   PyObject * obj0 = 0 ;
   

--------------060803060606000500050706--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
