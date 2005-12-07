Message-ID: <43971BE2.5050004@redhat.com>
Date: Wed, 07 Dec 2005 12:29:06 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Patch to fix some of the swig objects.  Now using them in chcat.
Content-Type: multipart/mixed;
 boundary="------------090407090605040702030100"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090407090605040702030100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


-- 



--------------090407090605040702030100
Content-Type: text/x-patch;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux.py libselinux-1.27.28/src/selinux.py
--- nsalibselinux/src/selinux.py	2005-11-28 14:10:10.000000000 -0500
+++ libselinux-1.27.28/src/selinux.py	2005-12-07 09:00:01.000000000 -0500
@@ -87,8 +87,6 @@
 
 security_setenforce = _selinux.security_setenforce
 
-security_disable = _selinux.security_disable
-
 security_policyvers = _selinux.security_policyvers
 
 security_get_boolean_names = _selinux.security_get_boolean_names
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinuxswig.i libselinux-1.27.28/src/selinuxswig.i
--- nsalibselinux/src/selinuxswig.i	2005-11-28 14:10:10.000000000 -0500
+++ libselinux-1.27.28/src/selinuxswig.i	2005-12-07 08:59:48.000000000 -0500
@@ -22,6 +22,15 @@
 %{
 	#include "selinux/selinux.h"
 %}
+%apply int *OUTPUT { int * };
+%apply int *OUTPUT { size_t * };
+
+%typemap(in, numinputs=0) security_context_t *(security_context_t temp) {
+	$1 = &temp;
+}
+%typemap(argout) security_context_t * {
+	$result = t_output_helper($result, PyString_FromString(*$1));
+}
 
 extern int is_selinux_enabled(void);
 extern int is_selinux_mls_enabled(void);
@@ -51,7 +60,6 @@
 					 security_context_t *canoncon);
 extern int security_getenforce(void);
 extern int security_setenforce(int value);
-extern int security_disable(void);
 extern int security_policyvers(void);
 extern int security_get_boolean_names(char ***names, int *len);
 extern int security_get_boolean_pending(const char *name);
@@ -96,10 +104,16 @@
 
 extern int is_context_customizable (security_context_t scontext);
 
-extern int selinux_trans_to_raw_context(security_context_t trans, 
+extern int selinux_trans_to_raw_context(char *trans, 
 					security_context_t *rawp);
-extern int selinux_raw_to_trans_context(security_context_t raw, 
+extern int selinux_raw_to_trans_context(char *raw, 
 					security_context_t *transp);
 
+%typemap(in, numinputs=0) char **(char *temp) {
+	$1 = &temp;
+}
+
+%typemap(argout) char ** {
+	$result = t_output_helper($result, PyString_FromString(*$1));
+}
 extern int getseuserbyname(const char *linuxuser, char **seuser, char **level);
-
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinuxswig_wrap.c libselinux-1.27.28/src/selinuxswig_wrap.c
--- nsalibselinux/src/selinuxswig_wrap.c	2005-11-28 14:10:10.000000000 -0500
+++ libselinux-1.27.28/src/selinuxswig_wrap.c	2005-12-07 09:00:01.000000000 -0500
@@ -1515,6 +1515,26 @@
 int getpeercon(int,security_context_t *);
 int selinux_mkload_policy(int);
 int selinux_init_load_policy(int *);
+
+SWIGINTERN PyObject*
+t_output_helper(PyObject* target, PyObject* o) {
+  if (!target) {
+    target = o;
+  } else if (target == Py_None) {  
+    Py_DECREF(target);
+    target = o;
+  } else {
+    if (!PyList_Check(target)) {
+      PyObject *o2 = target;
+      target = PyList_New(1);
+      PyList_SetItem(target, 0, o2);
+    }
+    PyList_Append(target,o);
+    }
+  return target;
+}
+
+
 int security_set_boolean_list(size_t,SELboolean *,int);
 
 SWIGINTERN int
@@ -1569,7 +1589,6 @@
 int security_canonicalize_context(security_context_t,security_context_t *);
 int security_getenforce(void);
 int security_setenforce(int);
-int security_disable(void);
 int security_policyvers(void);
 int security_get_boolean_names(char ***,int *);
 int security_get_boolean_pending(char const *);
@@ -1688,8 +1707,8 @@
 int checkPasswdAccess(access_vector_t);
 int rpm_execcon(unsigned int,char const *,char *const [],char *const []);
 int is_context_customizable(security_context_t);
-int selinux_trans_to_raw_context(security_context_t,security_context_t *);
-int selinux_raw_to_trans_context(security_context_t,security_context_t *);
+int selinux_trans_to_raw_context(char *,security_context_t *);
+int selinux_raw_to_trans_context(char *,security_context_t *);
 int getseuserbyname(char const *,char **,char **);
 #ifdef __cplusplus
 extern "C" {
@@ -1730,16 +1749,20 @@
     PyObject *resultobj;
     security_context_t *arg1 = (security_context_t *) 0 ;
     int result;
-    PyObject * obj0 = 0 ;
+    security_context_t temp1 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"O:getcon",&obj0)) goto fail;
-    SWIG_Python_ConvertPtr(obj0, (void **)&arg1, SWIGTYPE_p_security_context_t, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(1)) SWIG_fail;
+    {
+        arg1 = &temp1;
+    }
+    if(!PyArg_ParseTuple(args,(char *)":getcon")) goto fail;
     result = (int)getcon(arg1);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    {
+        resultobj = t_output_helper(resultobj, PyString_FromString(*arg1));
+    }
     return resultobj;
     fail:
     return NULL;
@@ -1779,10 +1802,13 @@
     pid_t arg1 ;
     security_context_t *arg2 = (security_context_t *) 0 ;
     int result;
+    security_context_t temp2 ;
     PyObject * obj0 = 0 ;
-    PyObject * obj1 = 0 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"OO:getpidcon",&obj0,&obj1)) goto fail;
+    {
+        arg2 = &temp2;
+    }
+    if(!PyArg_ParseTuple(args,(char *)"O:getpidcon",&obj0)) goto fail;
     {
         pid_t * argp;
         SWIG_Python_ConvertPtr(obj0, (void **)&argp, SWIGTYPE_p_pid_t, SWIG_POINTER_EXCEPTION);
@@ -1793,13 +1819,14 @@
         if (SWIG_arg_fail(1)) SWIG_fail;
         arg1 = *argp;
     }
-    SWIG_Python_ConvertPtr(obj1, (void **)&arg2, SWIGTYPE_p_security_context_t, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(2)) SWIG_fail;
     result = (int)getpidcon(arg1,arg2);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    {
+        resultobj = t_output_helper(resultobj, PyString_FromString(*arg2));
+    }
     return resultobj;
     fail:
     return NULL;
@@ -1810,16 +1837,20 @@
     PyObject *resultobj;
     security_context_t *arg1 = (security_context_t *) 0 ;
     int result;
-    PyObject * obj0 = 0 ;
+    security_context_t temp1 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"O:getprevcon",&obj0)) goto fail;
-    SWIG_Python_ConvertPtr(obj0, (void **)&arg1, SWIGTYPE_p_security_context_t, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(1)) SWIG_fail;
+    {
+        arg1 = &temp1;
+    }
+    if(!PyArg_ParseTuple(args,(char *)":getprevcon")) goto fail;
     result = (int)getprevcon(arg1);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    {
+        resultobj = t_output_helper(resultobj, PyString_FromString(*arg1));
+    }
     return resultobj;
     fail:
     return NULL;
@@ -1830,16 +1861,20 @@
     PyObject *resultobj;
     security_context_t *arg1 = (security_context_t *) 0 ;
     int result;
-    PyObject * obj0 = 0 ;
+    security_context_t temp1 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"O:getexeccon",&obj0)) goto fail;
-    SWIG_Python_ConvertPtr(obj0, (void **)&arg1, SWIGTYPE_p_security_context_t, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(1)) SWIG_fail;
+    {
+        arg1 = &temp1;
+    }
+    if(!PyArg_ParseTuple(args,(char *)":getexeccon")) goto fail;
     result = (int)getexeccon(arg1);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    {
+        resultobj = t_output_helper(resultobj, PyString_FromString(*arg1));
+    }
     return resultobj;
     fail:
     return NULL;
@@ -1878,16 +1913,20 @@
     PyObject *resultobj;
     security_context_t *arg1 = (security_context_t *) 0 ;
     int result;
-    PyObject * obj0 = 0 ;
+    security_context_t temp1 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"O:getfscreatecon",&obj0)) goto fail;
-    SWIG_Python_ConvertPtr(obj0, (void **)&arg1, SWIGTYPE_p_security_context_t, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(1)) SWIG_fail;
+    {
+        arg1 = &temp1;
+    }
+    if(!PyArg_ParseTuple(args,(char *)":getfscreatecon")) goto fail;
     result = (int)getfscreatecon(arg1);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    {
+        resultobj = t_output_helper(resultobj, PyString_FromString(*arg1));
+    }
     return resultobj;
     fail:
     return NULL;
@@ -1927,20 +1966,24 @@
     char *arg1 = (char *) 0 ;
     security_context_t *arg2 = (security_context_t *) 0 ;
     int result;
+    security_context_t temp2 ;
     PyObject * obj0 = 0 ;
-    PyObject * obj1 = 0 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"OO:getfilecon",&obj0,&obj1)) goto fail;
+    {
+        arg2 = &temp2;
+    }
+    if(!PyArg_ParseTuple(args,(char *)"O:getfilecon",&obj0)) goto fail;
     if (!SWIG_AsCharPtr(obj0, (char**)&arg1)) {
         SWIG_arg_fail(1);SWIG_fail;
     }
-    SWIG_Python_ConvertPtr(obj1, (void **)&arg2, SWIGTYPE_p_security_context_t, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(2)) SWIG_fail;
     result = (int)getfilecon((char const *)arg1,arg2);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    {
+        resultobj = t_output_helper(resultobj, PyString_FromString(*arg2));
+    }
     return resultobj;
     fail:
     return NULL;
@@ -1952,20 +1995,24 @@
     char *arg1 = (char *) 0 ;
     security_context_t *arg2 = (security_context_t *) 0 ;
     int result;
+    security_context_t temp2 ;
     PyObject * obj0 = 0 ;
-    PyObject * obj1 = 0 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"OO:lgetfilecon",&obj0,&obj1)) goto fail;
+    {
+        arg2 = &temp2;
+    }
+    if(!PyArg_ParseTuple(args,(char *)"O:lgetfilecon",&obj0)) goto fail;
     if (!SWIG_AsCharPtr(obj0, (char**)&arg1)) {
         SWIG_arg_fail(1);SWIG_fail;
     }
-    SWIG_Python_ConvertPtr(obj1, (void **)&arg2, SWIGTYPE_p_security_context_t, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(2)) SWIG_fail;
     result = (int)lgetfilecon((char const *)arg1,arg2);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    {
+        resultobj = t_output_helper(resultobj, PyString_FromString(*arg2));
+    }
     return resultobj;
     fail:
     return NULL;
@@ -1977,21 +2024,25 @@
     int arg1 ;
     security_context_t *arg2 = (security_context_t *) 0 ;
     int result;
+    security_context_t temp2 ;
     PyObject * obj0 = 0 ;
-    PyObject * obj1 = 0 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"OO:fgetfilecon",&obj0,&obj1)) goto fail;
+    {
+        arg2 = &temp2;
+    }
+    if(!PyArg_ParseTuple(args,(char *)"O:fgetfilecon",&obj0)) goto fail;
     {
         arg1 = (int)(SWIG_As_int(obj0)); 
         if (SWIG_arg_fail(1)) SWIG_fail;
     }
-    SWIG_Python_ConvertPtr(obj1, (void **)&arg2, SWIGTYPE_p_security_context_t, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(2)) SWIG_fail;
     result = (int)fgetfilecon(arg1,arg2);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    {
+        resultobj = t_output_helper(resultobj, PyString_FromString(*arg2));
+    }
     return resultobj;
     fail:
     return NULL;
@@ -2103,21 +2154,25 @@
     int arg1 ;
     security_context_t *arg2 = (security_context_t *) 0 ;
     int result;
+    security_context_t temp2 ;
     PyObject * obj0 = 0 ;
-    PyObject * obj1 = 0 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"OO:getpeercon",&obj0,&obj1)) goto fail;
+    {
+        arg2 = &temp2;
+    }
+    if(!PyArg_ParseTuple(args,(char *)"O:getpeercon",&obj0)) goto fail;
     {
         arg1 = (int)(SWIG_As_int(obj0)); 
         if (SWIG_arg_fail(1)) SWIG_fail;
     }
-    SWIG_Python_ConvertPtr(obj1, (void **)&arg2, SWIGTYPE_p_security_context_t, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(2)) SWIG_fail;
     result = (int)getpeercon(arg1,arg2);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    {
+        resultobj = t_output_helper(resultobj, PyString_FromString(*arg2));
+    }
     return resultobj;
     fail:
     return NULL;
@@ -2150,16 +2205,18 @@
     PyObject *resultobj;
     int *arg1 = (int *) 0 ;
     int result;
-    PyObject * obj0 = 0 ;
+    int temp1 ;
+    int res1 = 0 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"O:selinux_init_load_policy",&obj0)) goto fail;
-    SWIG_Python_ConvertPtr(obj0, (void **)&arg1, SWIGTYPE_p_int, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(1)) SWIG_fail;
+    arg1 = &temp1; res1 = SWIG_NEWOBJ;
+    if(!PyArg_ParseTuple(args,(char *)":selinux_init_load_policy")) goto fail;
     result = (int)selinux_init_load_policy(arg1);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    resultobj = t_output_helper(resultobj, ((res1 == SWIG_NEWOBJ) ?
+    SWIG_From_int((*arg1)) : SWIG_NewPointerObj((void*)(arg1), SWIGTYPE_p_int, 0)));
     return resultobj;
     fail:
     return NULL;
@@ -2252,10 +2309,13 @@
     security_context_t arg1 ;
     security_context_t *arg2 = (security_context_t *) 0 ;
     int result;
+    security_context_t temp2 ;
     PyObject * obj0 = 0 ;
-    PyObject * obj1 = 0 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"OO:security_canonicalize_context",&obj0,&obj1)) goto fail;
+    {
+        arg2 = &temp2;
+    }
+    if(!PyArg_ParseTuple(args,(char *)"O:security_canonicalize_context",&obj0)) goto fail;
     {
         security_context_t * argp;
         SWIG_Python_ConvertPtr(obj0, (void **)&argp, SWIGTYPE_p_security_context_t, SWIG_POINTER_EXCEPTION);
@@ -2266,13 +2326,14 @@
         if (SWIG_arg_fail(1)) SWIG_fail;
         arg1 = *argp;
     }
-    SWIG_Python_ConvertPtr(obj1, (void **)&arg2, SWIGTYPE_p_security_context_t, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(2)) SWIG_fail;
     result = (int)security_canonicalize_context(arg1,arg2);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    {
+        resultobj = t_output_helper(resultobj, PyString_FromString(*arg2));
+    }
     return resultobj;
     fail:
     return NULL;
@@ -2317,22 +2378,6 @@
 }
 
 
-static PyObject *_wrap_security_disable(PyObject *self, PyObject *args) {
-    PyObject *resultobj;
-    int result;
-    
-    if(!PyArg_ParseTuple(args,(char *)":security_disable")) goto fail;
-    result = (int)security_disable();
-    
-    {
-        resultobj = SWIG_From_int((int)(result)); 
-    }
-    return resultobj;
-    fail:
-    return NULL;
-}
-
-
 static PyObject *_wrap_security_policyvers(PyObject *self, PyObject *args) {
     PyObject *resultobj;
     int result;
@@ -2354,19 +2399,21 @@
     char ***arg1 = (char ***) 0 ;
     int *arg2 = (int *) 0 ;
     int result;
+    int temp2 ;
+    int res2 = 0 ;
     PyObject * obj0 = 0 ;
-    PyObject * obj1 = 0 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"OO:security_get_boolean_names",&obj0,&obj1)) goto fail;
+    arg2 = &temp2; res2 = SWIG_NEWOBJ;
+    if(!PyArg_ParseTuple(args,(char *)"O:security_get_boolean_names",&obj0)) goto fail;
     SWIG_Python_ConvertPtr(obj0, (void **)&arg1, SWIGTYPE_p_p_p_char, SWIG_POINTER_EXCEPTION | 0);
     if (SWIG_arg_fail(1)) SWIG_fail;
-    SWIG_Python_ConvertPtr(obj1, (void **)&arg2, SWIGTYPE_p_int, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(2)) SWIG_fail;
     result = (int)security_get_boolean_names(arg1,arg2);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    resultobj = t_output_helper(resultobj, ((res2 == SWIG_NEWOBJ) ?
+    SWIG_From_int((*arg2)) : SWIG_NewPointerObj((void*)(arg2), SWIGTYPE_p_int, 0)));
     return resultobj;
     fail:
     return NULL;
@@ -2504,11 +2551,14 @@
     mode_t arg2 ;
     security_context_t *arg3 = (security_context_t *) 0 ;
     int result;
+    security_context_t temp3 ;
     PyObject * obj0 = 0 ;
     PyObject * obj1 = 0 ;
-    PyObject * obj2 = 0 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"OOO:matchpathcon",&obj0,&obj1,&obj2)) goto fail;
+    {
+        arg3 = &temp3;
+    }
+    if(!PyArg_ParseTuple(args,(char *)"OO:matchpathcon",&obj0,&obj1)) goto fail;
     if (!SWIG_AsCharPtr(obj0, (char**)&arg1)) {
         SWIG_arg_fail(1);SWIG_fail;
     }
@@ -2522,13 +2572,14 @@
         if (SWIG_arg_fail(2)) SWIG_fail;
         arg2 = *argp;
     }
-    SWIG_Python_ConvertPtr(obj2, (void **)&arg3, SWIGTYPE_p_security_context_t, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(3)) SWIG_fail;
     result = (int)matchpathcon((char const *)arg1,arg2,arg3);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    {
+        resultobj = t_output_helper(resultobj, PyString_FromString(*arg3));
+    }
     return resultobj;
     fail:
     return NULL;
@@ -2540,20 +2591,24 @@
     char *arg1 = (char *) 0 ;
     security_context_t *arg2 = (security_context_t *) 0 ;
     int result;
+    security_context_t temp2 ;
     PyObject * obj0 = 0 ;
-    PyObject * obj1 = 0 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"OO:matchmediacon",&obj0,&obj1)) goto fail;
+    {
+        arg2 = &temp2;
+    }
+    if(!PyArg_ParseTuple(args,(char *)"O:matchmediacon",&obj0)) goto fail;
     if (!SWIG_AsCharPtr(obj0, (char**)&arg1)) {
         SWIG_arg_fail(1);SWIG_fail;
     }
-    SWIG_Python_ConvertPtr(obj1, (void **)&arg2, SWIGTYPE_p_security_context_t, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(2)) SWIG_fail;
     result = (int)matchmediacon((char const *)arg1,arg2);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    {
+        resultobj = t_output_helper(resultobj, PyString_FromString(*arg2));
+    }
     return resultobj;
     fail:
     return NULL;
@@ -2564,16 +2619,18 @@
     PyObject *resultobj;
     int *arg1 = (int *) 0 ;
     int result;
-    PyObject * obj0 = 0 ;
+    int temp1 ;
+    int res1 = 0 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"O:selinux_getenforcemode",&obj0)) goto fail;
-    SWIG_Python_ConvertPtr(obj0, (void **)&arg1, SWIGTYPE_p_int, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(1)) SWIG_fail;
+    arg1 = &temp1; res1 = SWIG_NEWOBJ;
+    if(!PyArg_ParseTuple(args,(char *)":selinux_getenforcemode")) goto fail;
     result = (int)selinux_getenforcemode(arg1);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    resultobj = t_output_helper(resultobj, ((res1 == SWIG_NEWOBJ) ?
+    SWIG_From_int((*arg1)) : SWIG_NewPointerObj((void*)(arg1), SWIGTYPE_p_int, 0)));
     return resultobj;
     fail:
     return NULL;
@@ -2925,30 +2982,27 @@
 
 static PyObject *_wrap_selinux_trans_to_raw_context(PyObject *self, PyObject *args) {
     PyObject *resultobj;
-    security_context_t arg1 ;
+    char *arg1 = (char *) 0 ;
     security_context_t *arg2 = (security_context_t *) 0 ;
     int result;
+    security_context_t temp2 ;
     PyObject * obj0 = 0 ;
-    PyObject * obj1 = 0 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"OO:selinux_trans_to_raw_context",&obj0,&obj1)) goto fail;
     {
-        security_context_t * argp;
-        SWIG_Python_ConvertPtr(obj0, (void **)&argp, SWIGTYPE_p_security_context_t, SWIG_POINTER_EXCEPTION);
-        if (SWIG_arg_fail(1)) SWIG_fail;
-        if (argp == NULL) {
-            SWIG_null_ref("security_context_t");
-        }
-        if (SWIG_arg_fail(1)) SWIG_fail;
-        arg1 = *argp;
+        arg2 = &temp2;
+    }
+    if(!PyArg_ParseTuple(args,(char *)"O:selinux_trans_to_raw_context",&obj0)) goto fail;
+    if (!SWIG_AsCharPtr(obj0, (char**)&arg1)) {
+        SWIG_arg_fail(1);SWIG_fail;
     }
-    SWIG_Python_ConvertPtr(obj1, (void **)&arg2, SWIGTYPE_p_security_context_t, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(2)) SWIG_fail;
     result = (int)selinux_trans_to_raw_context(arg1,arg2);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    {
+        resultobj = t_output_helper(resultobj, PyString_FromString(*arg2));
+    }
     return resultobj;
     fail:
     return NULL;
@@ -2957,30 +3011,27 @@
 
 static PyObject *_wrap_selinux_raw_to_trans_context(PyObject *self, PyObject *args) {
     PyObject *resultobj;
-    security_context_t arg1 ;
+    char *arg1 = (char *) 0 ;
     security_context_t *arg2 = (security_context_t *) 0 ;
     int result;
+    security_context_t temp2 ;
     PyObject * obj0 = 0 ;
-    PyObject * obj1 = 0 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"OO:selinux_raw_to_trans_context",&obj0,&obj1)) goto fail;
     {
-        security_context_t * argp;
-        SWIG_Python_ConvertPtr(obj0, (void **)&argp, SWIGTYPE_p_security_context_t, SWIG_POINTER_EXCEPTION);
-        if (SWIG_arg_fail(1)) SWIG_fail;
-        if (argp == NULL) {
-            SWIG_null_ref("security_context_t");
-        }
-        if (SWIG_arg_fail(1)) SWIG_fail;
-        arg1 = *argp;
+        arg2 = &temp2;
+    }
+    if(!PyArg_ParseTuple(args,(char *)"O:selinux_raw_to_trans_context",&obj0)) goto fail;
+    if (!SWIG_AsCharPtr(obj0, (char**)&arg1)) {
+        SWIG_arg_fail(1);SWIG_fail;
     }
-    SWIG_Python_ConvertPtr(obj1, (void **)&arg2, SWIGTYPE_p_security_context_t, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(2)) SWIG_fail;
     result = (int)selinux_raw_to_trans_context(arg1,arg2);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    {
+        resultobj = t_output_helper(resultobj, PyString_FromString(*arg2));
+    }
     return resultobj;
     fail:
     return NULL;
@@ -2993,23 +3044,31 @@
     char **arg2 = (char **) 0 ;
     char **arg3 = (char **) 0 ;
     int result;
+    char *temp2 ;
+    char *temp3 ;
     PyObject * obj0 = 0 ;
-    PyObject * obj1 = 0 ;
-    PyObject * obj2 = 0 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"OOO:getseuserbyname",&obj0,&obj1,&obj2)) goto fail;
+    {
+        arg2 = &temp2;
+    }
+    {
+        arg3 = &temp3;
+    }
+    if(!PyArg_ParseTuple(args,(char *)"O:getseuserbyname",&obj0)) goto fail;
     if (!SWIG_AsCharPtr(obj0, (char**)&arg1)) {
         SWIG_arg_fail(1);SWIG_fail;
     }
-    SWIG_Python_ConvertPtr(obj1, (void **)&arg2, SWIGTYPE_p_p_char, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(2)) SWIG_fail;
-    SWIG_Python_ConvertPtr(obj2, (void **)&arg3, SWIGTYPE_p_p_char, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(3)) SWIG_fail;
     result = (int)getseuserbyname((char const *)arg1,arg2,arg3);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    {
+        resultobj = t_output_helper(resultobj, PyString_FromString(*arg2));
+    }
+    {
+        resultobj = t_output_helper(resultobj, PyString_FromString(*arg3));
+    }
     return resultobj;
     fail:
     return NULL;
@@ -3042,7 +3101,6 @@
 	 { (char *)"security_canonicalize_context", _wrap_security_canonicalize_context, METH_VARARGS, NULL},
 	 { (char *)"security_getenforce", _wrap_security_getenforce, METH_VARARGS, NULL},
 	 { (char *)"security_setenforce", _wrap_security_setenforce, METH_VARARGS, NULL},
-	 { (char *)"security_disable", _wrap_security_disable, METH_VARARGS, NULL},
 	 { (char *)"security_policyvers", _wrap_security_policyvers, METH_VARARGS, NULL},
 	 { (char *)"security_get_boolean_names", _wrap_security_get_boolean_names, METH_VARARGS, NULL},
 	 { (char *)"security_get_boolean_pending", _wrap_security_get_boolean_pending, METH_VARARGS, NULL},
diff --exclude-from=exclude -N -u -r nsalibselinux/utils/getseuser.c libselinux-1.27.28/utils/getseuser.c
--- nsalibselinux/utils/getseuser.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.27.28/utils/getseuser.c	2005-12-07 08:58:59.000000000 -0500
@@ -0,0 +1,27 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <selinux/selinux.h>
+
+int main(int argc, char **argv) 
+{
+	char *seuser, *range;
+	int rc, i;
+
+	if (argc < 2) {
+		fprintf(stderr, "usage:  %s path...\n", argv[0]);
+		exit(1);
+	}
+
+	for (i = 1; i < argc; i++) {
+		rc = getseuserbyname(argv[i], &seuser, &range);
+		if (rc < 0) {
+			fprintf(stderr, "%s:  getseuserbyname(%s) failed\n", argv[0], argv[i]);
+			exit(2);
+		}
+		printf("%s\t%s\t%s\n", argv[i], seuser, range);
+		freecon(seuser);
+		freecon(range);
+	}
+	exit(0);
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/utils/setrans.c libselinux-1.27.28/utils/setrans.c
--- nsalibselinux/utils/setrans.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.27.28/utils/setrans.c	2005-12-07 08:58:59.000000000 -0500
@@ -0,0 +1,26 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <selinux/selinux.h>
+
+int main(int argc, char **argv) 
+{
+	char *buf;
+	int rc, i;
+
+	if (argc < 2) {
+		fprintf(stderr, "usage:  %s context...\n", argv[0]);
+		exit(1);
+	}
+
+	for (i = 1; i < argc; i++) {
+		rc = selinux_raw_to_trans_context(argv[i], &buf);
+		if (rc < 0) {
+			fprintf(stderr, "%s:  selinux_raw_to_trans_context(%s) failed\n", argv[0], argv[i]);
+			exit(2);
+		}
+		printf("%s\t%s\t%s\n", argv[i], buf);
+		freecon(buf);
+	}
+	exit(0);
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/utils/seuntrans.c libselinux-1.27.28/utils/seuntrans.c
--- nsalibselinux/utils/seuntrans.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.27.28/utils/seuntrans.c	2005-12-07 08:58:59.000000000 -0500
@@ -0,0 +1,26 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <selinux/selinux.h>
+
+int main(int argc, char **argv) 
+{
+	char *buf;
+	int rc, i;
+
+	if (argc < 2) {
+		fprintf(stderr, "usage:  %s path...\n", argv[0]);
+		exit(1);
+	}
+
+	for (i = 1; i < argc; i++) {
+		rc = selinux_trans_to_raw_context(argv[i], &buf);
+		if (rc < 0) {
+			fprintf(stderr, "%s:  selinux_trans_to_raw_context(%s) failed\n", argv[0], argv[i]);
+			exit(2);
+		}
+		printf("%s\t%s\t%s\n", argv[i], buf);
+		freecon(buf);
+	}
+	exit(0);
+}

--------------090407090605040702030100--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
