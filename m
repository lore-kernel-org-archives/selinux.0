Subject: [PATCH] libselinux: add library support for sockcreate
From: Eric Paris <eparis@parisplace.org>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 08 Aug 2006 14:53:39 -0400
Message-Id: <1155063219.24349.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The below patch adds sockcreate support for libselinux by means of the 4
stamdard interfaces {get,set}sockcreatecon{,_raw}.  This should complete
the /proc/self/attr/sockcreate implementation which is already in the
mainline kernel.

-Eric

 include/selinux/selinux.h |   11 +++++++++++
 src/getsockcreatecon.c    |   15 +++++++++++++++
 src/selinux.py            |    2 ++
 src/selinux_internal.h    |    2 ++
 src/selinuxswig.i         |    2 ++
 src/selinuxswig_wrap.c    |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 src/setsockcreatecon.c    |   15 +++++++++++++++
 7 files changed, 93 insertions(+)

diff -Naupr libselinux-1.30.22/include/selinux/selinux.h libselinux-1.30.22.sockcreate/include/selinux/selinux.h
--- libselinux-1.30.22/include/selinux/selinux.h	2006-08-03 11:22:37.000000000 -0400
+++ libselinux-1.30.22.sockcreate/include/selinux/selinux.h	2006-08-08 14:11:46.000000000 -0400
@@ -82,6 +82,17 @@ extern "C" {
 	extern int setkeycreatecon(security_context_t context);
 	extern int setkeycreatecon_raw(security_context_t context);
 
+/* Get sockcreate context, and set *con to refer to it.
+   Sets *con to NULL if no socket create context has been set, i.e. using default.
+   If non-NULL, caller must free via freecon. */
+	extern int getsockcreatecon(security_context_t * con);
+	extern int getsockcreatecon_raw(security_context_t * con);
+
+/* Set the sockcreate security context for subsequent socket creations.
+   Call with NULL if you want to reset to the default. */
+	extern int setsockcreatecon(security_context_t context);
+	extern int setsockcreatecon_raw(security_context_t context);
+
 /* Wrappers for the xattr API. */
 
 /* Get file context, and set *con to refer to it.
diff -Naupr libselinux-1.30.22/src/getsockcreatecon.c libselinux-1.30.22.sockcreate/src/getsockcreatecon.c
--- libselinux-1.30.22/src/getsockcreatecon.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.30.22.sockcreate/src/getsockcreatecon.c	2006-08-08 14:09:23.000000000 -0400
@@ -0,0 +1,15 @@
+#include "selinux_internal.h"
+
+#define SOCKCREATE_PROC_ENTRY "/proc/self/attr/sockcreate"
+
+int getsockcreatecon_raw(security_context_t * context)
+{
+	return getprocattrcon_raw(context, SOCKCREATE_PROC_ENTRY);
+}
+
+hidden_def(getsockcreatecon_raw)
+
+int getsockcreatecon(security_context_t * context)
+{
+	return getprocattrcon(context, SOCKCREATE_PROC_ENTRY);
+}
diff -Naupr libselinux-1.30.22/src/selinux_internal.h libselinux-1.30.22.sockcreate/src/selinux_internal.h
--- libselinux-1.30.22/src/selinux_internal.h	2006-08-03 11:22:35.000000000 -0400
+++ libselinux-1.30.22.sockcreate/src/selinux_internal.h	2006-08-08 14:16:29.000000000 -0400
@@ -45,8 +45,10 @@ hidden_proto(selinux_mkload_policy)
     hidden_proto(setexeccon_raw)
     hidden_proto(getfscreatecon_raw)
     hidden_proto(getkeycreatecon_raw)
+    hidden_proto(getsockcreatecon_raw)
     hidden_proto(setfscreatecon_raw)
     hidden_proto(setkeycreatecon_raw)
+    hidden_proto(setsockcreatecon_raw)
     hidden_proto(security_getenforce)
     hidden_proto(security_setenforce)
     hidden_proto(selinux_binary_policy_path)
diff -Naupr libselinux-1.30.22/src/selinux.py libselinux-1.30.22.sockcreate/src/selinux.py
--- libselinux-1.30.22/src/selinux.py	2006-08-03 11:22:35.000000000 -0400
+++ libselinux-1.30.22.sockcreate/src/selinux.py	2006-08-08 14:18:16.000000000 -0400
@@ -54,6 +54,8 @@ getfscreatecon = _selinux.getfscreatecon
 setfscreatecon = _selinux.setfscreatecon
 getkeycreatecon = _selinux.getkeycreatecon
 setkeycreatecon = _selinux.setkeycreatecon
+getsockcreatecon = _selinux.getsockcreatecon
+setsockcreatecon = _selinux.setsockcreatecon
 getfilecon = _selinux.getfilecon
 lgetfilecon = _selinux.lgetfilecon
 fgetfilecon = _selinux.fgetfilecon
diff -Naupr libselinux-1.30.22/src/selinuxswig.i libselinux-1.30.22.sockcreate/src/selinuxswig.i
--- libselinux-1.30.22/src/selinuxswig.i	2006-08-03 11:22:36.000000000 -0400
+++ libselinux-1.30.22.sockcreate/src/selinuxswig.i	2006-08-08 14:18:07.000000000 -0400
@@ -54,6 +54,8 @@ extern int getfscreatecon(security_conte
 extern int setfscreatecon(security_context_t context);
 extern int getkeycreatecon(security_context_t *con);
 extern int setkeycreatecon(security_context_t context);
+extern int getsockcreatecon(security_context_t *con);
+extern int setsockcreatecon(security_context_t context);
 extern int getfilecon(const char *path, security_context_t *con);
 extern int lgetfilecon(const char *path, security_context_t *con);
 extern int fgetfilecon(int fd, security_context_t *con);
diff -Naupr libselinux-1.30.22/src/selinuxswig_wrap.c libselinux-1.30.22.sockcreate/src/selinuxswig_wrap.c
--- libselinux-1.30.22/src/selinuxswig_wrap.c	2006-08-03 11:22:35.000000000 -0400
+++ libselinux-1.30.22.sockcreate/src/selinuxswig_wrap.c	2006-08-08 14:18:16.000000000 -0400
@@ -3064,6 +3064,50 @@ fail:
 }
 
 
+SWIGINTERN PyObject *_wrap_getsockcreatecon(PyObject *SWIGUNUSEDPARM(self), PyObject *args) {
+  PyObject *resultobj = 0;
+  security_context_t *arg1 = (security_context_t *) 0 ;
+  int result;
+  security_context_t temp1 ;
+  char *temp10 ;
+  
+  {
+    arg1 = &temp1;
+  }
+  if (!PyArg_ParseTuple(args,(char *)":getsockcreatecon")) SWIG_fail;
+  result = (int)getsockcreatecon(arg1);
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
+SWIGINTERN PyObject *_wrap_setsockcreatecon(PyObject *SWIGUNUSEDPARM(self), PyObject *args) {
+  PyObject *resultobj = 0;
+  security_context_t arg1 ;
+  int result;
+  PyObject * obj0 = 0 ;
+  
+  if (!PyArg_ParseTuple(args,(char *)"O:setsockcreatecon",&obj0)) SWIG_fail;
+  {
+    arg1 = (security_context_t)PyString_AsString(obj0);
+  }
+  result = (int)setsockcreatecon(arg1);
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
@@ -4285,6 +4329,8 @@ static PyMethodDef SwigMethods[] = {
 	 { (char *)"setfscreatecon", _wrap_setfscreatecon, METH_VARARGS, NULL},
 	 { (char *)"getkeycreatecon", _wrap_getkeycreatecon, METH_VARARGS, NULL},
 	 { (char *)"setkeycreatecon", _wrap_setkeycreatecon, METH_VARARGS, NULL},
+	 { (char *)"getsockcreatecon", _wrap_getsockcreatecon, METH_VARARGS, NULL},
+	 { (char *)"setsockcreatecon", _wrap_setsockcreatecon, METH_VARARGS, NULL},
 	 { (char *)"getfilecon", _wrap_getfilecon, METH_VARARGS, NULL},
 	 { (char *)"lgetfilecon", _wrap_lgetfilecon, METH_VARARGS, NULL},
 	 { (char *)"fgetfilecon", _wrap_fgetfilecon, METH_VARARGS, NULL},
diff -Naupr libselinux-1.30.22/src/setsockcreatecon.c libselinux-1.30.22.sockcreate/src/setsockcreatecon.c
--- libselinux-1.30.22/src/setsockcreatecon.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.30.22.sockcreate/src/setsockcreatecon.c	2006-08-08 14:09:45.000000000 -0400
@@ -0,0 +1,15 @@
+#include "selinux_internal.h"
+
+#define SOCKCREATE_PROC_ENTRY "/proc/self/attr/sockcreate"
+
+int setsockcreatecon_raw(security_context_t context)
+{
+	return setprocattrcon_raw(context, SOCKCREATE_PROC_ENTRY);
+}
+
+hidden_def(setsockcreatecon_raw)
+
+int setsockcreatecon(char *context)
+{
+	return setprocattrcon(context, SOCKCREATE_PROC_ENTRY);
+}



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
