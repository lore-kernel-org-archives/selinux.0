Message-ID: <461530F6.3030407@redhat.com>
Date: Thu, 05 Apr 2007 13:25:10 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: libselinux patch
Content-Type: multipart/mixed;
 boundary="------------070500030705080206070100"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070500030705080206070100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fixes for rpm_execcon python binding

Manpage fix

Fix for erperm on getsebool.



--------------070500030705080206070100
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibselinux/man/man8/matchpathcon.8 libselinux-2.0.9/man/man8/matchpathcon.8
--- nsalibselinux/man/man8/matchpathcon.8	2007-01-17 11:11:35.000000000 -0500
+++ libselinux-2.0.9/man/man8/matchpathcon.8	2007-04-05 13:19:29.000000000 -0400
@@ -28,4 +28,4 @@
 
 .SH "SEE ALSO"
 .BR selinux "(8), "
-.BR mathpathcon "(3), " 
+.BR matchpathcon "(3), " 
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinuxswig.i libselinux-2.0.9/src/selinuxswig.i
--- nsalibselinux/src/selinuxswig.i	2007-02-22 08:53:23.000000000 -0500
+++ libselinux-2.0.9/src/selinuxswig.i	2007-04-05 11:53:17.000000000 -0400
@@ -115,9 +115,34 @@
 extern const char *selinux_path(void);
 extern int selinux_check_passwd_access(access_vector_t requested);
 extern int checkPasswdAccess(access_vector_t requested);
+
+// This tells SWIG to treat char ** as a special case
+%typemap(python,in) char ** {
+  /* Check if is a list */
+  if (PyList_Check($input)) {
+    int size = PyList_Size($input);
+    int i = 0;
+    $1 = (char **) malloc((size+1)*sizeof(char *));
+    for (i = 0; i < size; i++) {
+      PyObject *o = PyList_GetItem($input,i);
+      if (PyString_Check(o))
+	$1[i] = PyString_AsString(PyList_GetItem($input,i));
+      else {
+	PyErr_SetString(PyExc_TypeError,"list must contain strings");
+	free($1);
+	return NULL;
+      }
+    }
+    $1[i] = 0;
+  } else {
+    PyErr_SetString(PyExc_TypeError,"not a list");
+    return NULL;
+  }
+}
+
 extern int rpm_execcon(unsigned int verified, 
 		       const char *filename, 
-		       char *const argv[], char *const envp[]);
+		       char **, char **);
 
 extern int is_context_customizable (security_context_t scontext);
 
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinuxswig_wrap.c libselinux-2.0.9/src/selinuxswig_wrap.c
--- nsalibselinux/src/selinuxswig_wrap.c	2007-02-22 08:53:23.000000000 -0500
+++ libselinux-2.0.9/src/selinuxswig_wrap.c	2007-04-05 11:45:04.000000000 -0400
@@ -4145,18 +4145,14 @@
   PyObject *resultobj = 0;
   unsigned int arg1 ;
   char *arg2 = (char *) 0 ;
-  char **arg3 ;
-  char **arg4 ;
+  char **arg3 = (char **) 0 ;
+  char **arg4 = (char **) 0 ;
   int result;
   unsigned int val1 ;
   int ecode1 = 0 ;
   int res2 ;
   char *buf2 = 0 ;
   int alloc2 = 0 ;
-  void *argp3 = 0 ;
-  int res3 = 0 ;
-  void *argp4 = 0 ;
-  int res4 = 0 ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   PyObject * obj2 = 0 ;
@@ -4173,17 +4169,51 @@
     SWIG_exception_fail(SWIG_ArgError(res2), "in method '" "rpm_execcon" "', argument " "2"" of type '" "char const *""'");
   }
   arg2 = (char *)(buf2);
-  res3 = SWIG_ConvertPtr(obj2, &argp3,SWIGTYPE_p_p_char, 0 |  0 );
-  if (!SWIG_IsOK(res3)) {
-    SWIG_exception_fail(SWIG_ArgError(res3), "in method '" "rpm_execcon" "', argument " "3"" of type '" "char *const []""'"); 
-  } 
-  arg3 = (char **)(argp3);
-  res4 = SWIG_ConvertPtr(obj3, &argp4,SWIGTYPE_p_p_char, 0 |  0 );
-  if (!SWIG_IsOK(res4)) {
-    SWIG_exception_fail(SWIG_ArgError(res4), "in method '" "rpm_execcon" "', argument " "4"" of type '" "char *const []""'"); 
-  } 
-  arg4 = (char **)(argp4);
-  result = (int)rpm_execcon(arg1,(char const *)arg2,(char *const (*))arg3,(char *const (*))arg4);
+  {
+    /* Check if is a list */
+    if (PyList_Check(obj2)) {
+      int size = PyList_Size(obj2);
+      int i = 0;
+      arg3 = (char **) malloc((size+1)*sizeof(char *));
+      for (i = 0; i < size; i++) {
+        PyObject *o = PyList_GetItem(obj2,i);
+        if (PyString_Check(o))
+        arg3[i] = PyString_AsString(PyList_GetItem(obj2,i));
+        else {
+          PyErr_SetString(PyExc_TypeError,"list must contain strings");
+          free(arg3);
+          return NULL;
+        }
+      }
+      arg3[i] = 0;
+    } else {
+      PyErr_SetString(PyExc_TypeError,"not a list");
+      return NULL;
+    }
+  }
+  {
+    /* Check if is a list */
+    if (PyList_Check(obj3)) {
+      int size = PyList_Size(obj3);
+      int i = 0;
+      arg4 = (char **) malloc((size+1)*sizeof(char *));
+      for (i = 0; i < size; i++) {
+        PyObject *o = PyList_GetItem(obj3,i);
+        if (PyString_Check(o))
+        arg4[i] = PyString_AsString(PyList_GetItem(obj3,i));
+        else {
+          PyErr_SetString(PyExc_TypeError,"list must contain strings");
+          free(arg4);
+          return NULL;
+        }
+      }
+      arg4[i] = 0;
+    } else {
+      PyErr_SetString(PyExc_TypeError,"not a list");
+      return NULL;
+    }
+  }
+  result = (int)rpm_execcon(arg1,(char const *)arg2,arg3,arg4);
   resultobj = SWIG_From_int((int)(result));
   if (alloc2 == SWIG_NEWOBJ) free((char*)buf2);
   return resultobj;
diff --exclude-from=exclude -N -u -r nsalibselinux/utils/getsebool.c libselinux-2.0.9/utils/getsebool.c
--- nsalibselinux/utils/getsebool.c	2006-11-16 17:15:17.000000000 -0500
+++ libselinux-2.0.9/utils/getsebool.c	2007-04-05 10:53:29.000000000 -0400
@@ -72,17 +72,23 @@
 	for (i = 0; i < len; i++) {
 		active = security_get_boolean_active(names[i]);
 		if (active < 0) {
-			fprintf(stderr, "Error getting active value for %s\n",
-				names[i]);
-			rc = -1;
-			goto out;
+			if (errno != EACCES) { 
+				fprintf(stderr, "Error getting active value for %s\n",
+					names[i]);
+				rc = -1;
+				goto out;
+			}
+			continue;
 		}
 		pending = security_get_boolean_pending(names[i]);
 		if (pending < 0) {
-			fprintf(stderr, "Error getting pending value for %s\n",
-				names[i]);
-			rc = -1;
-			goto out;
+			if (errno != EACCES) { 
+				fprintf(stderr, "Error getting pending value for %s\n",
+					names[i]);
+				rc = -1;
+				goto out;
+			}
+			continue;
 		}
 		if (pending != active) {
 			printf("%s --> %s pending: %s\n", names[i],

--------------070500030705080206070100--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
