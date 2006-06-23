Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5NKXA5B012431
	for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2006 16:33:10 -0400
Subject: Re: [PATCH] libselinux: add support for keycreate attribute
From: Eric Paris <eparis@parisplace.org>
To: Michael LeMay <mdlemay@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1150987778.3400.9.camel@moss-tarheels.epoch.ncsc.mil>
References: <1150987778.3400.9.camel@moss-tarheels.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 16:34:03 -0400
Message-Id: <1151094843.21012.96.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-06-22 at 10:49 -0400, Michael LeMay wrote:
> This is a patch to libselinux that adds support for the keycreate attribute
> that is visible in /proc/self/attr/keycreate.  Specifically, it adds routines
> getkeycreatecon and setkeycreatecon, and their corresponding wrappers.
> 

After just submitting my refactoring to eliminate all of the duplicated
code I realized that your patch and mine will conflict in
src/selinux_internal.h since your patch is going to look for line I
deleted (and mine confused by a line you added).  Here is a totally new
copy of your patch using the new interface I just submitted.  The only
changes should be to src/selinux_internal.h (since I eliminated the _raw
functions we don't need to hidden_proto them) and obviously changed
{get,set}keycreatecon.c to use the generic interface.  This patch should
be implemented in place of the last keycreate patch

-Eric

--- libselinux-1.30.15/src/getkeycreatecon.c.keycreate	2006-06-23 16:09:27.000000000 -0400
+++ libselinux-1.30.15/src/getkeycreatecon.c	2006-06-23 16:11:51.000000000 -0400
@@ -0,0 +1,7 @@
+#include "selinux_internal.h"
+
+int getkeycreatecon(security_context_t *context)
+{
+	char * keycreate_proc_entry = "/proc/self/attr/keycreate";
+ 	return getprocattrcon(context, keycreate_proc_entry);
+}
--- libselinux-1.30.15/src/setkeycreatecon.c.keycreate	2006-06-23 16:09:27.000000000 -0400
+++ libselinux-1.30.15/src/setkeycreatecon.c	2006-06-23 16:13:12.000000000 -0400
@@ -0,0 +1,7 @@
+#include "selinux_internal.h"
+
+int setkeycreatecon(char *context)
+{
+	char *keycreate_proc_entry = "/proc/self/attr/keycreate";
+ 	return setprocattrcon(context, keycreate_proc_entry);
+}
--- libselinux-1.30.15/src/selinuxswig_wrap.c.keycreate	2006-06-16 15:08:51.000000000 -0400
+++ libselinux-1.30.15/src/selinuxswig_wrap.c	2006-06-23 16:09:27.000000000 -0400
@@ -3020,6 +3020,50 @@ fail:
 }
 
 
+SWIGINTERN PyObject *_wrap_getkeycreatecon(PyObject *SWIGUNUSEDPARM(self), PyObject *args) {
+  PyObject *resultobj = 0;
+  security_context_t *arg1 = (security_context_t *) 0 ;
+  int result;
+  security_context_t temp1 ;
+  char *temp10 ;
+  
+  {
+    arg1 = &temp1;
+  }
+  if (!PyArg_ParseTuple(args,(char *)":getkeycreatecon")) SWIG_fail;
+  result = (int)getkeycreatecon(arg1);
+  resultobj = SWIG_From_int((int)(result));
+  {
+    if (*arg1)
+    temp10 = *arg1;
+    else
+    temp10 = "";
+    resultobj = SWIG_Python_AppendOutput(resultobj, PyString_FromString(temp10));
+  }
+  return resultobj;
+fail:
+  return NULL;
+}
+
+
+SWIGINTERN PyObject *_wrap_setkeycreatecon(PyObject *SWIGUNUSEDPARM(self), PyObject *args) {
+  PyObject *resultobj = 0;
+  security_context_t arg1 ;
+  int result;
+  PyObject * obj0 = 0 ;
+  
+  if (!PyArg_ParseTuple(args,(char *)"O:setkeycreatecon",&obj0)) SWIG_fail;
+  {
+    arg1 = (security_context_t)PyString_AsString(obj0);
+  }
+  result = (int)setkeycreatecon(arg1);
+  resultobj = SWIG_From_int((int)(result));
+  return resultobj;
+fail:
+  return NULL;
+}
+
+
 SWIGINTERN PyObject *_wrap_getfilecon(PyObject *SWIGUNUSEDPARM(self), PyObject *args) {
   PyObject *resultobj = 0;
   char *arg1 = (char *) 0 ;
@@ -4226,6 +4270,8 @@ static PyMethodDef SwigMethods[] = {
 	 { (char *)"setexeccon", _wrap_setexeccon, METH_VARARGS, NULL},
 	 { (char *)"getfscreatecon", _wrap_getfscreatecon, METH_VARARGS, NULL},
 	 { (char *)"setfscreatecon", _wrap_setfscreatecon, METH_VARARGS, NULL},
+	 { (char *)"getkeycreatecon", _wrap_getkeycreatecon, METH_VARARGS, NULL},
+	 { (char *)"setkeycreatecon", _wrap_setkeycreatecon, METH_VARARGS, NULL},
 	 { (char *)"getfilecon", _wrap_getfilecon, METH_VARARGS, NULL},
 	 { (char *)"lgetfilecon", _wrap_lgetfilecon, METH_VARARGS, NULL},
 	 { (char *)"fgetfilecon", _wrap_fgetfilecon, METH_VARARGS, NULL},
--- libselinux-1.30.15/src/selinuxswig.i.keycreate	2006-06-16 15:08:51.000000000 -0400
+++ libselinux-1.30.15/src/selinuxswig.i	2006-06-23 16:09:27.000000000 -0400
@@ -52,6 +52,8 @@ extern int getexeccon(security_context_t
 extern int setexeccon(security_context_t con);
 extern int getfscreatecon(security_context_t *con);
 extern int setfscreatecon(security_context_t context);
+extern int getkeycreatecon(security_context_t *con);
+extern int setkeycreatecon(security_context_t context);
 extern int getfilecon(const char *path, security_context_t *con);
 extern int lgetfilecon(const char *path, security_context_t *con);
 extern int fgetfilecon(int fd, security_context_t *con);
--- libselinux-1.30.15/src/selinux.py.keycreate	2006-06-16 15:08:51.000000000 -0400
+++ libselinux-1.30.15/src/selinux.py	2006-06-23 16:09:27.000000000 -0400
@@ -52,6 +52,8 @@ getexeccon = _selinux.getexeccon
 setexeccon = _selinux.setexeccon
 getfscreatecon = _selinux.getfscreatecon
 setfscreatecon = _selinux.setfscreatecon
+getkeycreatecon = _selinux.getkeycreatecon
+setkeycreatecon = _selinux.setkeycreatecon
 getfilecon = _selinux.getfilecon
 lgetfilecon = _selinux.lgetfilecon
 fgetfilecon = _selinux.fgetfilecon
--- libselinux-1.30.15/include/selinux/selinux.h.keycreate	2006-06-23 16:08:33.000000000 -0400
+++ libselinux-1.30.15/include/selinux/selinux.h	2006-06-23 16:14:21.000000000 -0400
@@ -74,6 +74,15 @@ extern int getfscreatecon(security_conte
    Call with NULL if you want to reset to the default. */
 extern int setfscreatecon(security_context_t context);
 
+/* Get keycreate context, and set *con to refer to it.
+   Sets *con to NULL if no key create context has been set, i.e. using default.
+   If non-NULL, caller must free via freecon. */
+extern int getkeycreatecon(security_context_t *con);
+
+/* Set the keycreate security context for subsequent key creations.
+   Call with NULL if you want to reset to the default. */
+extern int setkeycreatecon(security_context_t context);
+
 
 /* Wrappers for the xattr API. */
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
