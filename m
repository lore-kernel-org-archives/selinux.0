Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5QH4qUm029762
	for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2006 13:04:52 -0400
Subject: Re: [PATCH] libselinux: add support for keycreate attribute
From: Eric Paris <eparis@parisplace.org>
To: Michael LeMay <mdlemay@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1151094843.21012.96.camel@localhost.localdomain>
References: <1150987778.3400.9.camel@moss-tarheels.epoch.ncsc.mil>
	 <1151094843.21012.96.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 13:05:58 -0400
Message-Id: <1151341558.21012.157.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-06-23 at 16:34 -0400, Eric Paris wrote:
> On Thu, 2006-06-22 at 10:49 -0400, Michael LeMay wrote:
> > This is a patch to libselinux that adds support for the keycreate attribute
> > that is visible in /proc/self/attr/keycreate.  Specifically, it adds routines
> > getkeycreatecon and setkeycreatecon, and their corresponding wrappers.
> > 
> 
> After just submitting my refactoring to eliminate all of the duplicated
> code I realized that your patch and mine will conflict in
> src/selinux_internal.h since your patch is going to look for line I
> deleted (and mine confused by a line you added).  Here is a totally new
> copy of your patch using the new interface I just submitted.  The only
> changes should be to src/selinux_internal.h (since I eliminated the _raw
> functions we don't need to hidden_proto them) and obviously changed
> {get,set}keycreatecon.c to use the generic interface.  This patch should
> be implemented in place of the last keycreate patch
> 
> -Eric

So here is a new patch for the keycreate interface that leaves the _raw
interfaces intact in case something wants to use it.  This should be
able to replace both my last patch and michaels original patch.

-Eric

 include/selinux/selinux.h |   11 +++++++++++
 src/getkeycreatecon.c     |   14 ++++++++++++++
 src/selinux.py            |    2 ++
 src/selinux_internal.h    |    2 ++
 src/selinuxswig.i         |    2 ++
 src/selinuxswig_wrap.c    |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 src/setkeycreatecon.c     |   15 +++++++++++++++
 7 files changed, 92 insertions(+)

--- libselinux-1.30.15/src/getkeycreatecon.c.keycreate	2006-06-26 12:52:46.000000000 -0400
+++ libselinux-1.30.15/src/getkeycreatecon.c	2006-06-26 12:55:57.000000000 -0400
@@ -0,0 +1,14 @@
+#include "selinux_internal.h"
+
+#define KEYCREATE_PROC_ENTRY "/proc/self/attr/keycreate"
+
+int getkeycreatecon_raw(security_context_t *context)
+{
+	return getprocattrcon_raw(context, KEYCREATE_PROC_ENTRY);
+}
+hidden_def(getkeycreatecon_raw)
+
+int getkeycreatecon(security_context_t *context)
+{
+ 	return getprocattrcon(context, KEYCREATE_PROC_ENTRY);
+}
--- libselinux-1.30.15/src/selinux_internal.h.keycreate	2006-06-26 12:58:54.000000000 -0400
+++ libselinux-1.30.15/src/selinux_internal.h	2006-06-26 13:00:22.000000000 -0400
@@ -48,7 +48,9 @@ hidden_proto(fsetfilecon_raw)
 hidden_proto(setexeccon)
 hidden_proto(setexeccon_raw)
 hidden_proto(getfscreatecon_raw)
+hidden_proto(getkeycreatecon_raw)
 hidden_proto(setfscreatecon_raw)
+hidden_proto(setkeycreatecon_raw)
 hidden_proto(security_getenforce)
 hidden_proto(security_setenforce)
 hidden_proto(selinux_binary_policy_path)
--- libselinux-1.30.15/src/setkeycreatecon.c.keycreate	2006-06-26 12:52:46.000000000 -0400
+++ libselinux-1.30.15/src/setkeycreatecon.c	2006-06-26 12:55:36.000000000 -0400
@@ -0,0 +1,15 @@
+#include "selinux_internal.h"
+
+#define KEYCREATE_PROC_ENTRY "/proc/self/attr/keycreate"
+
+int setkeycreatecon_raw(security_context_t context)
+{
+	return setprocattrcon_raw(context, KEYCREATE_PROC_ENTRY);
+}
+
+hidden_def(setkeycreatecon_raw)
+
+int setkeycreatecon(char *context)
+{
+ 	return setprocattrcon(context, KEYCREATE_PROC_ENTRY);
+}
--- libselinux-1.30.15/src/selinuxswig_wrap.c.keycreate	2006-06-16 15:08:51.000000000 -0400
+++ libselinux-1.30.15/src/selinuxswig_wrap.c	2006-06-26 12:52:46.000000000 -0400
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
+++ libselinux-1.30.15/src/selinuxswig.i	2006-06-26 12:52:46.000000000 -0400
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
+++ libselinux-1.30.15/src/selinux.py	2006-06-26 12:52:46.000000000 -0400
@@ -52,6 +52,8 @@ getexeccon = _selinux.getexeccon
 setexeccon = _selinux.setexeccon
 getfscreatecon = _selinux.getfscreatecon
 setfscreatecon = _selinux.setfscreatecon
+getkeycreatecon = _selinux.getkeycreatecon
+setkeycreatecon = _selinux.setkeycreatecon
 getfilecon = _selinux.getfilecon
 lgetfilecon = _selinux.lgetfilecon
 fgetfilecon = _selinux.fgetfilecon
--- libselinux-1.30.15/include/selinux/selinux.h.keycreate	2006-06-26 12:25:28.000000000 -0400
+++ libselinux-1.30.15/include/selinux/selinux.h	2006-06-26 12:59:51.000000000 -0400
@@ -80,6 +80,17 @@ extern int getfscreatecon_raw(security_c
 extern int setfscreatecon(security_context_t context);
 extern int setfscreatecon_raw(security_context_t context);
 
+/* Get keycreate context, and set *con to refer to it.
+   Sets *con to NULL if no key create context has been set, i.e. using default.
+   If non-NULL, caller must free via freecon. */
+extern int getkeycreatecon(security_context_t *con);
+extern int getkeycreatecon_raw(security_context_t *con);
+
+/* Set the keycreate security context for subsequent key creations.
+   Call with NULL if you want to reset to the default. */
+extern int setkeycreatecon(security_context_t context);
+extern int setkeycreatecon_raw(security_context_t context);
+
 
 /* Wrappers for the xattr API. */
 




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
