Subject: [PATCH] libselinux: add support for keycreate attribute
From: Michael LeMay <mdlemay@epoch.ncsc.mil>
To: sds@tycho.nsa.gov, eparis@parisplace.org,
        David Howells <dhowells@redhat.com>, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 22 Jun 2006 10:49:38 -0400
Message-Id: <1150987778.3400.9.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a patch to libselinux that adds support for the keycreate attribute
that is visible in /proc/self/attr/keycreate.  Specifically, it adds routines
getkeycreatecon and setkeycreatecon, and their corresponding wrappers.

---

 include/selinux/selinux.h |   11 +++++++
 src/getkeycreatecon.c     |   64 ++++++++++++++++++++++++++++++++++++++++++++++
 src/selinux.py            |    2 +
 src/selinux_internal.h    |    2 +
 src/selinuxswig.i         |    2 +
 src/selinuxswig_wrap.c    |   46 +++++++++++++++++++++++++++++++++
 src/setkeycreatecon.c     |   39 ++++++++++++++++++++++++++++
 7 files changed, 166 insertions(+)

diff -X dontdiff -uprN libselinux.orig/include/selinux/selinux.h libselinux/include/selinux/selinux.h
--- libselinux.orig/include/selinux/selinux.h	2006-06-21 12:33:52.000000000 -0400
+++ libselinux/include/selinux/selinux.h	2006-06-22 10:44:37.000000000 -0400
@@ -72,6 +72,17 @@ extern int getfscreatecon_raw(security_c
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
 
diff -X dontdiff -uprN libselinux.orig/src/getkeycreatecon.c libselinux/src/getkeycreatecon.c
--- libselinux.orig/src/getkeycreatecon.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux/src/getkeycreatecon.c	2006-06-02 09:38:23.000000000 -0400
@@ -0,0 +1,64 @@
+#include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+#include <stdlib.h>
+#include <errno.h>
+#include "selinux_internal.h"
+#include "policy.h"
+
+int getkeycreatecon_raw(security_context_t *context)
+{
+	char *buf;
+	size_t size;
+	int fd;
+	ssize_t ret;
+
+	fd = open("/proc/self/attr/keycreate", O_RDONLY);
+	if (fd < 0)
+		return -1;
+
+	size = selinux_page_size;
+	buf = malloc(size);
+	if (!buf) {
+		ret = -1;
+		goto out;
+	}
+	memset(buf, 0, size);
+
+	ret = read(fd, buf, size-1);
+	if (ret < 0)
+		goto out2;
+
+	if (ret == 0) {
+		*context = NULL;
+		goto out2;
+	}
+
+	*context = strdup(buf);
+	if (!(*context)) {
+		ret = -1;
+		goto out2;
+	}
+	ret = 0;
+out2:			
+	free(buf);
+out:
+	close(fd);
+	return ret;
+}
+hidden_def(getkeycreatecon_raw)
+
+int getkeycreatecon(security_context_t *context)
+{
+	int ret;
+	security_context_t rcontext;
+
+ 	ret = getkeycreatecon_raw(&rcontext);
+
+	if (!ret) {
+		ret = selinux_raw_to_trans_context(rcontext, context);
+		freecon(rcontext);
+	} 
+
+	return ret;
+}
diff -X dontdiff -uprN libselinux.orig/src/selinux_internal.h libselinux/src/selinux_internal.h
--- libselinux.orig/src/selinux_internal.h	2006-06-21 12:33:52.000000000 -0400
+++ libselinux/src/selinux_internal.h	2006-06-20 16:11:31.000000000 -0400
@@ -44,7 +44,9 @@ hidden_proto(fsetfilecon_raw)
 hidden_proto(setexeccon)
 hidden_proto(setexeccon_raw)
 hidden_proto(getfscreatecon_raw)
+hidden_proto(getkeycreatecon_raw)
 hidden_proto(setfscreatecon_raw)
+hidden_proto(setkeycreatecon_raw)
 hidden_proto(security_getenforce)
 hidden_proto(security_setenforce)
 hidden_proto(selinux_binary_policy_path)
diff -X dontdiff -uprN libselinux.orig/src/selinux.py libselinux/src/selinux.py
--- libselinux.orig/src/selinux.py	2006-06-21 12:33:53.000000000 -0400
+++ libselinux/src/selinux.py	2006-06-20 16:11:31.000000000 -0400
@@ -52,6 +52,8 @@ getexeccon = _selinux.getexeccon
 setexeccon = _selinux.setexeccon
 getfscreatecon = _selinux.getfscreatecon
 setfscreatecon = _selinux.setfscreatecon
+getkeycreatecon = _selinux.getkeycreatecon
+setkeycreatecon = _selinux.setkeycreatecon
 getfilecon = _selinux.getfilecon
 lgetfilecon = _selinux.lgetfilecon
 fgetfilecon = _selinux.fgetfilecon
diff -X dontdiff -uprN libselinux.orig/src/selinuxswig.i libselinux/src/selinuxswig.i
--- libselinux.orig/src/selinuxswig.i	2006-06-21 12:33:53.000000000 -0400
+++ libselinux/src/selinuxswig.i	2006-06-20 16:11:31.000000000 -0400
@@ -52,6 +52,8 @@ extern int getexeccon(security_context_t
 extern int setexeccon(security_context_t con);
 extern int getfscreatecon(security_context_t *con);
 extern int setfscreatecon(security_context_t context);
+extern int getkeycreatecon(security_context_t *con);
+extern int setkeycreatecon(security_context_t context);
 extern int getfilecon(const char *path, security_context_t *con);
 extern int lgetfilecon(const char *path, security_context_t *con);
 extern int fgetfilecon(int fd, security_context_t *con);
diff -X dontdiff -uprN libselinux.orig/src/selinuxswig_wrap.c libselinux/src/selinuxswig_wrap.c
--- libselinux.orig/src/selinuxswig_wrap.c	2006-06-21 12:33:53.000000000 -0400
+++ libselinux/src/selinuxswig_wrap.c	2006-06-20 16:11:31.000000000 -0400
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
diff -X dontdiff -uprN libselinux.orig/src/setkeycreatecon.c libselinux/src/setkeycreatecon.c
--- libselinux.orig/src/setkeycreatecon.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux/src/setkeycreatecon.c	2006-06-02 10:24:36.000000000 -0400
@@ -0,0 +1,39 @@
+#include <unistd.h>
+#include <string.h>
+#include <fcntl.h>
+#include "selinux_internal.h"
+
+int setkeycreatecon_raw(char *context)
+{
+	int fd;
+	ssize_t ret;
+
+	fd = open("/proc/self/attr/keycreate", O_RDWR);
+	if (fd < 0)
+		return -1;
+	if (context) 
+		ret = write(fd, context, strlen(context)+1);
+	else
+		ret = write(fd, NULL, 0); /* clear */
+	close(fd);
+	if (ret < 0)
+		return -1;
+	else
+		return 0;
+}
+hidden_def(setkeycreatecon_raw)
+
+int setkeycreatecon(char *context)
+{
+	int ret;
+	security_context_t rcontext = context;
+
+	if (selinux_trans_to_raw_context(context, &rcontext))
+		return -1;
+
+ 	ret = setkeycreatecon_raw(rcontext);
+
+	freecon(rcontext);
+
+	return ret;
+}



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
