Subject: Re: [PATCH] wrap char*** for user_get_roles()
From: Joshua Brindle <jbrindle@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <438B5A15.4060604@redhat.com>
References: <1133205192.17541.1.camel@twoface.columbia.tresys.com>
	 <438B5A15.4060604@redhat.com>
Content-Type: multipart/mixed; boundary="=-OfJ+kL6mgJPfzbkjrVrX"
Date: Mon, 28 Nov 2005 14:29:30 -0500
Message-Id: <1133206170.17541.2.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-OfJ+kL6mgJPfzbkjrVrX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2005-11-28 at 14:27 -0500, Daniel J Walsh wrote:
> Joshua Brindle wrote:
> > This adds wrappers for char*** so that semanage_user_get_roles will
> > work. I added the test to the user test (-u), please let me know if
> > there are any issues with this.
> >
> >   
> No patch attached.
> 

oops.

--=-OfJ+kL6mgJPfzbkjrVrX
Content-Disposition: attachment; filename=wrap-char-for-roles.patch
Content-Type: text/x-patch; name=wrap-char-for-roles.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -purN -x .svn trunk/libsemanage/src/pywrap-test.py branch/swigifymore/libsemanage/src/pywrap-test.py
--- trunk/libsemanage/src/pywrap-test.py	2005-11-28 13:44:37.000000000 -0500
+++ branch/swigifymore/libsemanage/src/pywrap-test.py	2005-11-28 13:41:56.000000000 -0500
@@ -98,6 +98,7 @@ class Tests:
 		print "User list size: ", list_size
 		if self.verbose: print "List reference: ",  list
 
+
 		if (list_size == 0):
 			print "No users found!"
 			print "This is not necessarily a test failure."
@@ -110,6 +111,10 @@ class Tests:
 			print "   User mls range: ", semanage.semanage_user_get_mlsrange(user)
 			print "   User number of roles: ", semanage.semanage_user_get_num_roles(user)
 			print "   User default role: ", semanage.semanage_user_get_defrole(user)
+			print "   User roles: "
+			(status, rlist, rlist_size) = semanage.semanage_user_get_roles(sh, user)
+			for ridx in range (rlist_size):
+				print "      ", semanage.char_by_idx(rlist, ridx) 
 
 	def test_writeuser(self,sh):
                 print "Testing user write..."
diff -purN -x .svn trunk/libsemanage/src/semanage.py branch/swigifymore/libsemanage/src/semanage.py
--- trunk/libsemanage/src/semanage.py	2005-11-28 13:44:37.000000000 -0500
+++ branch/swigifymore/libsemanage/src/semanage.py	2005-11-28 13:41:56.000000000 -0500
@@ -43,6 +43,8 @@ semanage_seuser_by_idx = _semanage.seman
 
 semanage_port_by_idx = _semanage.semanage_port_by_idx
 
+char_by_idx = _semanage.char_by_idx
+
 semanage_bool_key_create = _semanage.semanage_bool_key_create
 
 semanage_bool_key_extract = _semanage.semanage_bool_key_extract
Binary files trunk/libsemanage/src/semanage.pyc and branch/swigifymore/libsemanage/src/semanage.pyc differ
diff -purN -x .svn trunk/libsemanage/src/semanageswig.i branch/swigifymore/libsemanage/src/semanageswig.i
--- trunk/libsemanage/src/semanageswig.i	2005-11-28 13:44:37.000000000 -0500
+++ branch/swigifymore/libsemanage/src/semanageswig.i	2005-11-28 13:41:56.000000000 -0500
@@ -44,18 +44,19 @@
 	#include "semanage/ports_policy.h"
 %}
 
-%include <carrays.i>
-
 %inline {
-	semanage_user_t *semanage_user_by_idx(semanage_user_t **list, int n){
+	semanage_user_t *semanage_user_by_idx(semanage_user_t **list, int n) {
 		return list[n];
 	}	
-	semanage_seuser_t *semanage_seuser_by_idx(semanage_seuser_t **list, int n){
+	semanage_seuser_t *semanage_seuser_by_idx(semanage_seuser_t **list, int n) {
 		return list[n];
 	}	
-	semanage_port_t *semanage_port_by_idx(semanage_port_t **list, int n){
+	semanage_port_t *semanage_port_by_idx(semanage_port_t **list, int n) {
 		return list[n];
 	}	
+	char *char_by_idx(char **list, int n) {
+		return list[n];
+	}
 }
 
 
@@ -68,6 +69,14 @@
 %apply int *OUTPUT { int * };
 %apply int *OUTPUT { size_t * };
 
+%typemap(in, numinputs=0) char ***(char **temp) {
+	$1 = &temp;
+}
+
+%typemap(argout) char*** {
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_p_char, 0));
+}
+
 /** module typemaps**/
 
 /* the wrapper will setup this parameter for passing... the resulting python functions
diff -purN -x .svn trunk/libsemanage/src/semanageswig_wrap.c branch/swigifymore/libsemanage/src/semanageswig_wrap.c
--- trunk/libsemanage/src/semanageswig_wrap.c	2005-11-28 13:44:37.000000000 -0500
+++ branch/swigifymore/libsemanage/src/semanageswig_wrap.c	2005-11-28 13:41:56.000000000 -0500
@@ -1323,9 +1323,9 @@ SWIG_Python_GetTypeList() {
 
 #define  SWIGTYPE_p_f_p_struct_semanage_bool_p_void__int swig_types[0] 
 #define  SWIGTYPE_p_f_p_struct_semanage_iface_p_void__int swig_types[1] 
-#define  SWIGTYPE_p_p_char swig_types[2] 
-#define  SWIGTYPE_p_p_p_char swig_types[3] 
-#define  SWIGTYPE_p_char swig_types[4] 
+#define  SWIGTYPE_p_p_p_char swig_types[2] 
+#define  SWIGTYPE_p_char swig_types[3] 
+#define  SWIGTYPE_p_p_char swig_types[4] 
 #define  SWIGTYPE_p_f_p_struct_semanage_user_p_void__int swig_types[5] 
 #define  SWIGTYPE_p_f_p_struct_semanage_seuser_p_void__int swig_types[6] 
 #define  SWIGTYPE_p_p_semanage_port_t swig_types[7] 
@@ -1334,8 +1334,8 @@ SWIG_Python_GetTypeList() {
 #define  SWIGTYPE_p_semanage_seuser swig_types[10] 
 #define  SWIGTYPE_p_p_p_semanage_seuser swig_types[11] 
 #define  SWIGTYPE_p_p_p_semanage_bool swig_types[12] 
-#define  SWIGTYPE_p_semanage_bool swig_types[13] 
-#define  SWIGTYPE_p_p_semanage_bool swig_types[14] 
+#define  SWIGTYPE_p_p_semanage_bool swig_types[13] 
+#define  SWIGTYPE_p_semanage_bool swig_types[14] 
 #define  SWIGTYPE_p_p_semanage_user swig_types[15] 
 #define  SWIGTYPE_p_semanage_user swig_types[16] 
 #define  SWIGTYPE_p_size_t swig_types[17] 
@@ -1397,15 +1397,18 @@ static swig_type_info *swig_types[41];
 	#include "semanage/ports_policy.h"
 
 
-	semanage_user_t *semanage_user_by_idx(semanage_user_t **list, int n){
+	semanage_user_t *semanage_user_by_idx(semanage_user_t **list, int n) {
 		return list[n];
 	}	
-	semanage_seuser_t *semanage_seuser_by_idx(semanage_seuser_t **list, int n){
+	semanage_seuser_t *semanage_seuser_by_idx(semanage_seuser_t **list, int n) {
 		return list[n];
 	}	
-	semanage_port_t *semanage_port_by_idx(semanage_port_t **list, int n){
+	semanage_port_t *semanage_port_by_idx(semanage_port_t **list, int n) {
 		return list[n];
 	}	
+	char *char_by_idx(char **list, int n) {
+		return list[n];
+	}
 
 
 #include <limits.h>
@@ -1508,6 +1511,27 @@ SWIG_Check_int(PyObject* obj)
   return SWIG_AsVal_int(obj, (int*)0);
 }
 
+
+SWIGINTERN PyObject *
+SWIG_FromCharPtr(const char* cptr)
+{ 
+  if (cptr) {
+    size_t size = strlen(cptr);
+    if (size > INT_MAX) {
+      return SWIG_NewPointerObj((char*)(cptr), 
+				SWIG_TypeQuery("char *"), 0);
+    } else {
+      if (size != 0) {
+	return PyString_FromStringAndSize(cptr, size);
+      } else {
+	return PyString_FromString(cptr);
+      }
+    }
+  }
+  Py_INCREF(Py_None);
+  return Py_None;
+}
+
 int semanage_bool_key_create(semanage_handle_t *,char const *,semanage_bool_key_t **);
 
 /* returns SWIG_OLDOBJ if the input is a raw char*, SWIG_PYSTR if is a PyString */
@@ -1562,27 +1586,6 @@ int semanage_bool_key_extract(semanage_h
 void semanage_bool_key_free(semanage_bool_key_t *);
 int semanage_bool_compare(semanage_bool_t *,semanage_bool_key_t *);
 char const *semanage_bool_get_name(semanage_bool_t *);
-
-SWIGINTERN PyObject *
-SWIG_FromCharPtr(const char* cptr)
-{ 
-  if (cptr) {
-    size_t size = strlen(cptr);
-    if (size > INT_MAX) {
-      return SWIG_NewPointerObj((char*)(cptr), 
-				SWIG_TypeQuery("char *"), 0);
-    } else {
-      if (size != 0) {
-	return PyString_FromStringAndSize(cptr, size);
-      } else {
-	return PyString_FromString(cptr);
-      }
-    }
-  }
-  Py_INCREF(Py_None);
-  return Py_None;
-}
-
 int semanage_bool_set_name(semanage_handle_t *,semanage_bool_t *,char const *);
 int semanage_bool_get_value(semanage_bool_t *);
 void semanage_bool_set_value(semanage_bool_t *,int);
@@ -1847,6 +1850,30 @@ static PyObject *_wrap_semanage_port_by_
 }
 
 
+static PyObject *_wrap_char_by_idx(PyObject *self, PyObject *args) {
+    PyObject *resultobj;
+    char **arg1 = (char **) 0 ;
+    int arg2 ;
+    char *result;
+    PyObject * obj0 = 0 ;
+    PyObject * obj1 = 0 ;
+    
+    if(!PyArg_ParseTuple(args,(char *)"OO:char_by_idx",&obj0,&obj1)) goto fail;
+    SWIG_Python_ConvertPtr(obj0, (void **)&arg1, SWIGTYPE_p_p_char, SWIG_POINTER_EXCEPTION | 0);
+    if (SWIG_arg_fail(1)) SWIG_fail;
+    {
+        arg2 = (int)(SWIG_As_int(obj1)); 
+        if (SWIG_arg_fail(2)) SWIG_fail;
+    }
+    result = (char *)char_by_idx(arg1,arg2);
+    
+    resultobj = SWIG_FromCharPtr(result);
+    return resultobj;
+    fail:
+    return NULL;
+}
+
+
 static PyObject *_wrap_semanage_bool_key_create(PyObject *self, PyObject *args) {
     PyObject *resultobj;
     semanage_handle_t *arg1 = (semanage_handle_t *) 0 ;
@@ -3417,25 +3444,29 @@ static PyObject *_wrap_semanage_user_get
     char ***arg3 = (char ***) 0 ;
     size_t *arg4 = (size_t *) 0 ;
     int result;
+    char **temp3 ;
     size_t temp4 ;
     int res4 = 0 ;
     PyObject * obj0 = 0 ;
     PyObject * obj1 = 0 ;
-    PyObject * obj2 = 0 ;
     
+    {
+        arg3 = &temp3;
+    }
     arg4 = &temp4; res4 = SWIG_NEWOBJ;
-    if(!PyArg_ParseTuple(args,(char *)"OOO:semanage_user_get_roles",&obj0,&obj1,&obj2)) goto fail;
+    if(!PyArg_ParseTuple(args,(char *)"OO:semanage_user_get_roles",&obj0,&obj1)) goto fail;
     SWIG_Python_ConvertPtr(obj0, (void **)&arg1, SWIGTYPE_p_semanage_handle, SWIG_POINTER_EXCEPTION | 0);
     if (SWIG_arg_fail(1)) SWIG_fail;
     SWIG_Python_ConvertPtr(obj1, (void **)&arg2, SWIGTYPE_p_semanage_user, SWIG_POINTER_EXCEPTION | 0);
     if (SWIG_arg_fail(2)) SWIG_fail;
-    SWIG_Python_ConvertPtr(obj2, (void **)&arg3, SWIGTYPE_p_p_p_char, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(3)) SWIG_fail;
     result = (int)semanage_user_get_roles(arg1,arg2,(char const ***)arg3,arg4);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    {
+        resultobj = t_output_helper(resultobj, SWIG_NewPointerObj(*arg3, SWIGTYPE_p_p_char, 0));
+    }
     resultobj = t_output_helper(resultobj, ((res4 == SWIG_NEWOBJ) ?
     SWIG_From_int((*arg4)) : SWIG_NewPointerObj((void*)(arg4), SWIGTYPE_p_size_t, 0)));
     return resultobj;
@@ -5552,6 +5583,7 @@ static PyMethodDef SwigMethods[] = {
 	 { (char *)"semanage_user_by_idx", _wrap_semanage_user_by_idx, METH_VARARGS, NULL},
 	 { (char *)"semanage_seuser_by_idx", _wrap_semanage_seuser_by_idx, METH_VARARGS, NULL},
 	 { (char *)"semanage_port_by_idx", _wrap_semanage_port_by_idx, METH_VARARGS, NULL},
+	 { (char *)"char_by_idx", _wrap_char_by_idx, METH_VARARGS, NULL},
 	 { (char *)"semanage_bool_key_create", _wrap_semanage_bool_key_create, METH_VARARGS, NULL},
 	 { (char *)"semanage_bool_key_extract", _wrap_semanage_bool_key_extract, METH_VARARGS, NULL},
 	 { (char *)"semanage_bool_key_free", _wrap_semanage_bool_key_free, METH_VARARGS, NULL},
@@ -5705,9 +5737,9 @@ static PyMethodDef SwigMethods[] = {
 
 static swig_type_info _swigt__p_f_p_struct_semanage_bool_p_void__int[] = {{"_p_f_p_struct_semanage_bool_p_void__int", 0, "int (*)(struct semanage_bool *,void *)|int (*)(semanage_bool_t *,void *)", 0, 0, 0, 0},{"_p_f_p_struct_semanage_bool_p_void__int", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_f_p_struct_semanage_iface_p_void__int[] = {{"_p_f_p_struct_semanage_iface_p_void__int", 0, "int (*)(struct semanage_iface *,void *)|int (*)(semanage_iface_t *,void *)", 0, 0, 0, 0},{"_p_f_p_struct_semanage_iface_p_void__int", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
-static swig_type_info _swigt__p_p_char[] = {{"_p_p_char", 0, "char **", 0, 0, 0, 0},{"_p_p_char", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_p_p_char[] = {{"_p_p_p_char", 0, "char ***", 0, 0, 0, 0},{"_p_p_p_char", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_char[] = {{"_p_char", 0, "char *", 0, 0, 0, 0},{"_p_char", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
+static swig_type_info _swigt__p_p_char[] = {{"_p_p_char", 0, "char **", 0, 0, 0, 0},{"_p_p_char", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_f_p_struct_semanage_user_p_void__int[] = {{"_p_f_p_struct_semanage_user_p_void__int", 0, "int (*)(struct semanage_user *,void *)|int (*)(semanage_user_t *,void *)", 0, 0, 0, 0},{"_p_f_p_struct_semanage_user_p_void__int", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_f_p_struct_semanage_seuser_p_void__int[] = {{"_p_f_p_struct_semanage_seuser_p_void__int", 0, "int (*)(struct semanage_seuser *,void *)|int (*)(semanage_seuser_t *,void *)", 0, 0, 0, 0},{"_p_f_p_struct_semanage_seuser_p_void__int", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_p_semanage_port_t[] = {{"_p_p_semanage_port_t", 0, "semanage_port_t **", 0, 0, 0, 0},{"_p_p_semanage_port_t", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
@@ -5716,8 +5748,8 @@ static swig_type_info _swigt__p_p_semana
 static swig_type_info _swigt__p_semanage_seuser[] = {{"_p_semanage_seuser", 0, "struct semanage_seuser *|semanage_seuser_t *", 0, 0, 0, 0},{"_p_semanage_seuser", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_p_p_semanage_seuser[] = {{"_p_p_p_semanage_seuser", 0, "struct semanage_seuser ***|semanage_seuser_t ***", 0, 0, 0, 0},{"_p_p_p_semanage_seuser", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_p_p_semanage_bool[] = {{"_p_p_p_semanage_bool", 0, "struct semanage_bool ***|semanage_bool_t ***", 0, 0, 0, 0},{"_p_p_p_semanage_bool", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
-static swig_type_info _swigt__p_semanage_bool[] = {{"_p_semanage_bool", 0, "struct semanage_bool *|semanage_bool_t *", 0, 0, 0, 0},{"_p_semanage_bool", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_p_semanage_bool[] = {{"_p_p_semanage_bool", 0, "struct semanage_bool **|semanage_bool_t **", 0, 0, 0, 0},{"_p_p_semanage_bool", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
+static swig_type_info _swigt__p_semanage_bool[] = {{"_p_semanage_bool", 0, "struct semanage_bool *|semanage_bool_t *", 0, 0, 0, 0},{"_p_semanage_bool", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_p_semanage_user[] = {{"_p_p_semanage_user", 0, "struct semanage_user **|semanage_user_t **", 0, 0, 0, 0},{"_p_p_semanage_user", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_semanage_user[] = {{"_p_semanage_user", 0, "struct semanage_user *|semanage_user_t *", 0, 0, 0, 0},{"_p_semanage_user", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_size_t[] = {{"_p_size_t", 0, "size_t *", 0, 0, 0, 0},{"_p_size_t", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
@@ -5747,9 +5779,9 @@ static swig_type_info _swigt__p_semanage
 static swig_type_info *swig_types_initial[] = {
 _swigt__p_f_p_struct_semanage_bool_p_void__int, 
 _swigt__p_f_p_struct_semanage_iface_p_void__int, 
-_swigt__p_p_char, 
 _swigt__p_p_p_char, 
 _swigt__p_char, 
+_swigt__p_p_char, 
 _swigt__p_f_p_struct_semanage_user_p_void__int, 
 _swigt__p_f_p_struct_semanage_seuser_p_void__int, 
 _swigt__p_p_semanage_port_t, 
@@ -5758,8 +5790,8 @@ _swigt__p_p_semanage_seuser, 
 _swigt__p_semanage_seuser, 
 _swigt__p_p_p_semanage_seuser, 
 _swigt__p_p_p_semanage_bool, 
-_swigt__p_semanage_bool, 
 _swigt__p_p_semanage_bool, 
+_swigt__p_semanage_bool, 
 _swigt__p_p_semanage_user, 
 _swigt__p_semanage_user, 
 _swigt__p_size_t, 

--=-OfJ+kL6mgJPfzbkjrVrX--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
