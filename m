Message-ID: <43BADD2A.1060903@redhat.com>
Date: Tue, 03 Jan 2006 15:23:06 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: libselinux patch to add getpidcon python wrapper.
Content-Type: multipart/mixed;
 boundary="------------040206010300040400000106"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040206010300040400000106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------040206010300040400000106
Content-Type: text/x-patch;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinuxswig.i libselinux-1.29.2/src/selinuxswig.i
--- nsalibselinux/src/selinuxswig.i	2005-12-08 12:52:24.000000000 -0500
+++ libselinux-1.29.2/src/selinuxswig.i	2005-12-20 09:41:32.000000000 -0500
@@ -36,7 +37,7 @@
 extern int is_selinux_mls_enabled(void);
 extern int getcon(security_context_t *con);
 extern int setcon(security_context_t con);
-extern int getpidcon(pid_t pid, security_context_t *con);
+extern int getpidcon(int pid, security_context_t *con);
 extern int getprevcon(security_context_t *con);
 extern int getexeccon(security_context_t *con);
 extern int setexeccon(security_context_t con);
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinuxswig_wrap.c libselinux-1.29.2/src/selinuxswig_wrap.c
--- nsalibselinux/src/selinuxswig_wrap.c	2005-12-08 12:52:24.000000000 -0500
+++ libselinux-1.29.2/src/selinuxswig_wrap.c	2005-12-20 09:41:35.000000000 -0500
@@ -1322,17 +1322,16 @@
 /* -------- TYPES TABLE (BEGIN) -------- */
 
 #define  SWIGTYPE_p_mode_t swig_types[0] 
-#define  SWIGTYPE_p_pid_t swig_types[1] 
-#define  SWIGTYPE_p_SELboolean swig_types[2] 
-#define  SWIGTYPE_p_char swig_types[3] 
-#define  SWIGTYPE_p_p_p_char swig_types[4] 
-#define  SWIGTYPE_p_access_vector_t swig_types[5] 
-#define  SWIGTYPE_p_p_char swig_types[6] 
-#define  SWIGTYPE_size_t swig_types[7] 
-#define  SWIGTYPE_p_security_context_t swig_types[8] 
-#define  SWIGTYPE_ptrdiff_t swig_types[9] 
-#define  SWIGTYPE_p_int swig_types[10] 
-static swig_type_info *swig_types[12];
+#define  SWIGTYPE_p_SELboolean swig_types[1] 
+#define  SWIGTYPE_p_char swig_types[2] 
+#define  SWIGTYPE_p_p_p_char swig_types[3] 
+#define  SWIGTYPE_p_access_vector_t swig_types[4] 
+#define  SWIGTYPE_p_p_char swig_types[5] 
+#define  SWIGTYPE_size_t swig_types[6] 
+#define  SWIGTYPE_p_security_context_t swig_types[7] 
+#define  SWIGTYPE_ptrdiff_t swig_types[8] 
+#define  SWIGTYPE_p_int swig_types[9] 
+static swig_type_info *swig_types[11];
 
 /* -------- TYPES TABLE (END) -------- */
 
@@ -1355,59 +1354,7 @@
 int is_selinux_mls_enabled(void);
 int getcon(security_context_t *);
 int setcon(security_context_t);
-int getpidcon(pid_t,security_context_t *);
-int getprevcon(security_context_t *);
-int getexeccon(security_context_t *);
-int setexeccon(security_context_t);
-int getfscreatecon(security_context_t *);
-int setfscreatecon(security_context_t);
-int getfilecon(char const *,security_context_t *);
-
-/* returns SWIG_OLDOBJ if the input is a raw char*, SWIG_PYSTR if is a PyString */
-SWIGINTERN int
-SWIG_AsCharPtrAndSize(PyObject *obj, char** cptr, size_t* psize)
-{
-  static swig_type_info* pchar_info = 0;
-  char* vptr = 0;
-  if (!pchar_info) pchar_info = SWIG_TypeQuery("char *");
-  if (SWIG_ConvertPtr(obj, (void**)&vptr, pchar_info, 0) != -1) {
-    if (cptr) *cptr = vptr;
-    if (psize) *psize = vptr ? (strlen(vptr) + 1) : 0;
-    return SWIG_OLDOBJ;
-  } else {
-    PyErr_Clear();
-    if (PyString_Check(obj)) {
-      if (cptr) {
-	*cptr = PyString_AS_STRING(obj);
-	if (psize) {
-	  *psize = PyString_GET_SIZE(obj) + 1;
-	}
-      }
-      return SWIG_PYSTR;
-    }
-  }
-  if (cptr) {
-    SWIG_type_error("char *", obj);
-  }
-  return 0;
-}
-
-
-SWIGINTERNSHORT int
-SWIG_AsCharPtr(PyObject *obj, char **val)
-{
-  if (SWIG_AsCharPtrAndSize(obj, val, (size_t*)(0))) {
-    return 1;
-  }
-  if (val) {
-    PyErr_Clear();
-    SWIG_type_error("char *", obj);
-  }
-  return 0;
-}
-
-int lgetfilecon(char const *,security_context_t *);
-int fgetfilecon(int,security_context_t *);
+int getpidcon(int,security_context_t *);
 
 #include <limits.h>
 
@@ -1509,6 +1456,58 @@
   return SWIG_AsVal_int(obj, (int*)0);
 }
 
+int getprevcon(security_context_t *);
+int getexeccon(security_context_t *);
+int setexeccon(security_context_t);
+int getfscreatecon(security_context_t *);
+int setfscreatecon(security_context_t);
+int getfilecon(char const *,security_context_t *);
+
+/* returns SWIG_OLDOBJ if the input is a raw char*, SWIG_PYSTR if is a PyString */
+SWIGINTERN int
+SWIG_AsCharPtrAndSize(PyObject *obj, char** cptr, size_t* psize)
+{
+  static swig_type_info* pchar_info = 0;
+  char* vptr = 0;
+  if (!pchar_info) pchar_info = SWIG_TypeQuery("char *");
+  if (SWIG_ConvertPtr(obj, (void**)&vptr, pchar_info, 0) != -1) {
+    if (cptr) *cptr = vptr;
+    if (psize) *psize = vptr ? (strlen(vptr) + 1) : 0;
+    return SWIG_OLDOBJ;
+  } else {
+    PyErr_Clear();
+    if (PyString_Check(obj)) {
+      if (cptr) {
+	*cptr = PyString_AS_STRING(obj);
+	if (psize) {
+	  *psize = PyString_GET_SIZE(obj) + 1;
+	}
+      }
+      return SWIG_PYSTR;
+    }
+  }
+  if (cptr) {
+    SWIG_type_error("char *", obj);
+  }
+  return 0;
+}
+
+
+SWIGINTERNSHORT int
+SWIG_AsCharPtr(PyObject *obj, char **val)
+{
+  if (SWIG_AsCharPtrAndSize(obj, val, (size_t*)(0))) {
+    return 1;
+  }
+  if (val) {
+    PyErr_Clear();
+    SWIG_type_error("char *", obj);
+  }
+  return 0;
+}
+
+int lgetfilecon(char const *,security_context_t *);
+int fgetfilecon(int,security_context_t *);
 int setfilecon(char const *,security_context_t);
 int lsetfilecon(char const *,security_context_t);
 int fsetfilecon(int,security_context_t);
@@ -1799,7 +1798,7 @@
 
 static PyObject *_wrap_getpidcon(PyObject *self, PyObject *args) {
     PyObject *resultobj;
-    pid_t arg1 ;
+    int arg1 ;
     security_context_t *arg2 = (security_context_t *) 0 ;
     int result;
     security_context_t temp2 ;
@@ -1810,14 +1809,8 @@
     }
     if(!PyArg_ParseTuple(args,(char *)"O:getpidcon",&obj0)) goto fail;
     {
-        pid_t * argp;
-        SWIG_Python_ConvertPtr(obj0, (void **)&argp, SWIGTYPE_p_pid_t, SWIG_POINTER_EXCEPTION);
-        if (SWIG_arg_fail(1)) SWIG_fail;
-        if (argp == NULL) {
-            SWIG_null_ref("pid_t");
-        }
+        arg1 = (int)(SWIG_As_int(obj0)); 
         if (SWIG_arg_fail(1)) SWIG_fail;
-        arg1 = *argp;
     }
     result = (int)getpidcon(arg1,arg2);
     
@@ -3142,7 +3135,6 @@
 /* -------- TYPE CONVERSION AND EQUIVALENCE RULES (BEGIN) -------- */
 
 static swig_type_info _swigt__p_mode_t[] = {{"_p_mode_t", 0, "mode_t *", 0, 0, 0, 0},{"_p_mode_t", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
-static swig_type_info _swigt__p_pid_t[] = {{"_p_pid_t", 0, "pid_t *", 0, 0, 0, 0},{"_p_pid_t", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_SELboolean[] = {{"_p_SELboolean", 0, "SELboolean *", 0, 0, 0, 0},{"_p_SELboolean", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_char[] = {{"_p_char", 0, "char *", 0, 0, 0, 0},{"_p_char", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_p_p_char[] = {{"_p_p_p_char", 0, "char ***", 0, 0, 0, 0},{"_p_p_p_char", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
@@ -3155,7 +3147,6 @@
 
 static swig_type_info *swig_types_initial[] = {
 _swigt__p_mode_t, 
-_swigt__p_pid_t, 
 _swigt__p_SELboolean, 
 _swigt__p_char, 
 _swigt__p_p_p_char, 

--------------040206010300040400000106--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
