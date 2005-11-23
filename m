Subject: [PATCH] wrappers for writing users and seusers
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-KeIH1axhg2LMQbpWXO5b"
Date: Wed, 23 Nov 2005 11:28:01 -0500
Message-Id: <1132763281.3714.3.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-KeIH1axhg2LMQbpWXO5b
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds wrappers necessary to write users and seusers using
libsemanage. It also includes the wrappers for ports, but they are
commented out since the port functions are not exported via
libsemanage.map. Examples of how to write users and seusers (and tests)
are in pywrap-test.py as usual. Let me know if there are any problems
with this patch.

Joshua

--=-KeIH1axhg2LMQbpWXO5b
Content-Disposition: attachment; filename=add-more-wrappers-semanage.diff
Content-Type: text/x-patch; name=add-more-wrappers-semanage.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -purN -x .svn trunk/libsemanage/src/pywrap-test.py branch/archive/swigify/libsemanage/src/pywrap-test.py
--- trunk/libsemanage/src/pywrap-test.py	2005-11-22 19:39:01.000000000 -0500
+++ branch/archive/swigify/libsemanage/src/pywrap-test.py	2005-11-23 09:22:11.000000000 -0500
@@ -7,7 +7,9 @@ usage = "\
 Choose one of the following tests:\n\
 -m for modules\n\
 -u for users\n\n\
+-U for add user (warning this will write!)\n\n\
 -s for seusers\n\n\
+-S for add seuser (warning this will write!)\n\n\
 Other options:\n\
 -h for this help\n\
 -v for verbose output\
@@ -25,12 +27,14 @@ class Tests:
 	def __init__(self):
         	self.all = False
 		self.users = False
+		self.writeuser = False
 		self.seusers = False
+		self.writeseuser = False
 		self.modules = False
 		self.verbose = False
 
 	def selected(self):
-		return (self.all or self.users or self.modules or self.seusers)
+		return (self.all or self.users or self.modules or self.seusers or self.writeuser or self.writeseuser)
 
 	def run(self, handle):
 		if (self.users or self.all): 
@@ -42,6 +46,12 @@ class Tests:
 		if (self.modules or self.all): 
 			self.test_modules(handle)
 			print ""
+		if (self.writeuser or self.all): 
+			self.test_writeuser(handle)
+			print ""
+		if (self.writeseuser or self.all): 
+			self.test_writeseuser(handle)
+			print ""
 
 	def test_modules(self,sh):
 		print "Testing modules..."
@@ -100,13 +110,78 @@ class Tests:
 			print "   User mls range: ", semanage.semanage_user_get_mlsrange(user)
 			print "   User number of roles: ", semanage.semanage_user_get_num_roles(user)
 			print "   User default role: ", semanage.semanage_user_get_defrole(user)
-		
+
+	def test_writeuser(self,sh):
+                print "Testing user write..."
+                
+		(status, user) = semanage.semanage_user_create(sh)
+                if self.verbose: print "User object created."
+
+		status = semanage.semanage_user_set_name(sh,user, "testPyUser")
+               	if self.verbose: print "User name set: ", semanage.semanage_user_get_name(user)
+                
+		status = semanage.semanage_user_add_role(sh, user, "user_r")
+                if self.verbose: print "User default role: ", semanage.semanage_user_get_defrole(user)
+		
+		status = semanage.semanage_user_set_mlsrange(sh, user, "s0")
+                if self.verbose: print "User mlsrange: ", semanage.semanage_user_get_mlsrange(user)
+
+		status = semanage.semanage_user_set_mlslevel(sh, user, "s0")
+                if self.verbose: print "User mlslevel: ", semanage.semanage_user_get_mlslevel(user)
+                
+		(status,key) = semanage.semanage_user_key_extract(sh,user)
+                if self.verbose: print "User key extracted : ", key
+		
+		print "Starting transaction..."
+                status = semanage.semanage_begin_transaction(sh)
+                status = semanage.semanage_user_add_local(sh,key,user)
+                status = semanage.semanage_commit(sh)
+                print "Commit status (transaction number): ", status
+
+		print "Removing user..."
+                status = semanage.semanage_begin_transaction(sh)
+		status = semanage.semanage_user_del_local(sh, key)
+                if self.verbose: print "User delete: ", status
+                status = semanage.semanage_commit(sh)
+                print "Commit status (transaction number): ", status
+			
+	def test_writeseuser(self,sh):
+                print "Testing seuser write..."
+                
+		(status, seuser) = semanage.semanage_seuser_create(sh)
+                if self.verbose: print "SEUser object created."
+
+		status = semanage.semanage_seuser_set_name(sh,seuser, "testPySEUser")
+               	if self.verbose: print "SEUser name set: ", semanage.semanage_seuser_get_name(seuser)
+                
+		status = semanage.semanage_seuser_set_sename(sh, seuser, "root")
+                if self.verbose: print "SEUser seuser: ", semanage.semanage_seuser_get_sename(seuser)
+		
+		status = semanage.semanage_seuser_set_mlsrange(sh, seuser, "s0:c0.c255")
+                if self.verbose: print "SEUser mlsrange: ", semanage.semanage_seuser_get_mlsrange(seuser)
+                
+		(status,key) = semanage.semanage_seuser_key_extract(sh,seuser)
+                if self.verbose: print "SEUser key extracted : ", key
+		
+		print "Starting transaction..."
+                status = semanage.semanage_begin_transaction(sh)
+                status = semanage.semanage_seuser_add(sh,key,seuser)
+                status = semanage.semanage_commit(sh)
+                print "Commit status (transaction number): ", status
+
+		print "Removing seuser..."
+                status = semanage.semanage_begin_transaction(sh)
+		status = semanage.semanage_seuser_del(sh, key)
+                if self.verbose: print "SEUser delete: ", status
+                status = semanage.semanage_commit(sh)
+                print "Commit status (transaction number): ", status
+			
 def main(argv=None):
 	if argv is None:
 		argv = sys.argv
 	try:
         	try:
-			opts, args = getopt.getopt(argv[1:], "hvmusa", ["help", "verbose", "modules", "users", "seusers", "all"])
+			opts, args = getopt.getopt(argv[1:], "hvmusUSa", ["help", "verbose", "modules", "users", "seusers", "writeuser", "writeseuser", "all"])
 			tests = Tests()
 			for o, a in opts:
         			if o == "-v":
@@ -116,8 +191,12 @@ def main(argv=None):
             				tests.all = True
         			if o == "-u":
             				tests.users = True
+        			if o == "-U":
+            				tests.writeuser = True
         			if o == "-s":
             				tests.seusers = True
+        			if o == "-S":
+            				tests.writeseuser = True
         			if o == "-m":
             				tests.modules = True
         			if o == "-h":
diff -purN -x .svn trunk/libsemanage/src/semanage.py branch/archive/swigify/libsemanage/src/semanage.py
--- trunk/libsemanage/src/semanage.py	2005-11-22 19:39:18.000000000 -0500
+++ branch/archive/swigify/libsemanage/src/semanage.py	2005-11-22 19:56:28.000000000 -0500
@@ -41,6 +41,8 @@ semanage_user_by_idx = _semanage.semanag
 
 semanage_seuser_by_idx = _semanage.semanage_seuser_by_idx
 
+semanage_port_by_idx = _semanage.semanage_port_by_idx
+
 semanage_bool_key_create = _semanage.semanage_bool_key_create
 
 semanage_bool_key_extract = _semanage.semanage_bool_key_extract
diff -purN -x .svn trunk/libsemanage/src/semanageswig.i branch/archive/swigify/libsemanage/src/semanageswig.i
--- trunk/libsemanage/src/semanageswig.i	2005-11-22 19:39:26.000000000 -0500
+++ branch/archive/swigify/libsemanage/src/semanageswig.i	2005-11-23 11:25:26.000000000 -0500
@@ -39,8 +39,26 @@
 	#include "semanage/ports_local.h"        
 	#include "semanage/seusers.h"            
 	#include "semanage/users_policy.h"
+	#include "semanage/port_record.h"
+	#include "semanage/ports_local.h"
+	#include "semanage/ports_policy.h"
 %}
 
+%include <carrays.i>
+
+%inline {
+	semanage_user_t *semanage_user_by_idx(semanage_user_t **list, int n){
+		return list[n];
+	}	
+	semanage_seuser_t *semanage_seuser_by_idx(semanage_seuser_t **list, int n){
+		return list[n];
+	}	
+	semanage_port_t *semanage_port_by_idx(semanage_port_t **list, int n){
+		return list[n];
+	}	
+}
+
+
 /** standard typemaps **/
 
 /* a few helpful typemaps are available in this library */
@@ -74,6 +92,22 @@
 	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_p_semanage_seuser, 0));
 }
 
+%typemap(in, numinputs=0) semanage_seuser_t **(semanage_seuser_t *temp) {
+	$1 = &temp;
+}
+
+%typemap(argout) semanage_seuser_t ** {
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_seuser, 0));
+}
+
+%typemap(argout) semanage_seuser_key_t ** {
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_seuser_key, 0));
+}
+
+%typemap(in, numinputs=0) semanage_seuser_key_t **(semanage_seuser_key_t *temp) {
+	$1 = &temp;
+}
+
 /** user typemaps **/
 
 /* the wrapper will setup this parameter for passing... the resulting python functions
@@ -86,17 +120,52 @@
 	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_p_semanage_user, 0));
 }
 
-%include <carrays.i>
+%typemap(in, numinputs=0) semanage_user_t **(semanage_user_t *temp) {
+	$1 = &temp;
+}
 
-%inline {
-	semanage_user_t *semanage_user_by_idx(semanage_user_t **list, int n){
-		return list[n];
-	}	
-	semanage_seuser_t *semanage_seuser_by_idx(semanage_seuser_t **list, int n){
-		return list[n];
-	}	
+%typemap(argout) semanage_user_t ** {
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_user, 0));
+}
+
+%typemap(argout) semanage_user_key_t ** {
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_user_key, 0));
+}
+
+%typemap(in, numinputs=0) semanage_user_key_t **(semanage_user_key_t *temp) {
+	$1 = &temp;
+}
+
+/** port typemaps **/
+
+/* the wrapper will setup this parameter for passing... the resulting python functions
+   will not take the semanage_port_t *** parameter */
+/*
+%typemap(in, numinputs=0) semanage_port_t ***(semanage_port_t **temp) {
+	$1 = &temp;
+}
+
+%typemap(argout) semanage_port_t *** {
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_p_semanage_port, 0));
+}
+
+%typemap(in, numinputs=0) semanage_port_t **(semanage_port_t *temp) {
+	$1 = &temp;
+}
+
+%typemap(argout) semanage_port_t ** {
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_port, 0));
+}
+
+%typemap(argout) semanage_port_key_t ** {
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_port_key, 0));
 }
 
+%typemap(in, numinputs=0) semanage_port_key_t **(semanage_port_key_t *temp) {
+	$1 = &temp;
+}
+*/
+
 /* pull in the headers */
 %include "../include/semanage/boolean_record.h"
 %include "../include/semanage/debug.h"
@@ -114,4 +183,8 @@
 %include "../include/semanage/interfaces_local.h"   
 %include "../include/semanage/seusers.h"            
 %include "../include/semanage/users_policy.h"
-
+/*
+%include "../include/semanage/port_record.h"
+%include "../include/semanage/ports_local.h"
+%include "../include/semanage/ports_policy.h"
+*/
diff -purN -x .svn trunk/libsemanage/src/semanageswig_wrap.c branch/archive/swigify/libsemanage/src/semanageswig_wrap.c
--- trunk/libsemanage/src/semanageswig_wrap.c	2005-11-22 19:39:26.000000000 -0500
+++ branch/archive/swigify/libsemanage/src/semanageswig_wrap.c	2005-11-23 11:25:26.000000000 -0500
@@ -1321,45 +1321,47 @@ SWIG_Python_GetTypeList() {
 
 /* -------- TYPES TABLE (BEGIN) -------- */
 
-#define  SWIGTYPE_p_f_p_struct_semanage_user_p_void__int swig_types[0] 
-#define  SWIGTYPE_p_f_p_struct_semanage_bool_p_void__int swig_types[1] 
-#define  SWIGTYPE_p_f_p_struct_semanage_iface_p_void__int swig_types[2] 
-#define  SWIGTYPE_p_p_char swig_types[3] 
-#define  SWIGTYPE_p_p_p_char swig_types[4] 
-#define  SWIGTYPE_p_char swig_types[5] 
+#define  SWIGTYPE_p_f_p_struct_semanage_bool_p_void__int swig_types[0] 
+#define  SWIGTYPE_p_f_p_struct_semanage_iface_p_void__int swig_types[1] 
+#define  SWIGTYPE_p_p_char swig_types[2] 
+#define  SWIGTYPE_p_p_p_char swig_types[3] 
+#define  SWIGTYPE_p_char swig_types[4] 
+#define  SWIGTYPE_p_f_p_struct_semanage_user_p_void__int swig_types[5] 
 #define  SWIGTYPE_p_f_p_struct_semanage_seuser_p_void__int swig_types[6] 
-#define  SWIGTYPE_p_p_semanage_seuser swig_types[7] 
-#define  SWIGTYPE_p_semanage_seuser swig_types[8] 
-#define  SWIGTYPE_p_p_p_semanage_seuser swig_types[9] 
-#define  SWIGTYPE_p_p_p_semanage_bool swig_types[10] 
-#define  SWIGTYPE_p_semanage_bool swig_types[11] 
-#define  SWIGTYPE_p_p_semanage_bool swig_types[12] 
-#define  SWIGTYPE_p_p_semanage_user swig_types[13] 
-#define  SWIGTYPE_p_semanage_user swig_types[14] 
-#define  SWIGTYPE_p_size_t swig_types[15] 
-#define  SWIGTYPE_size_t swig_types[16] 
-#define  SWIGTYPE_p_p_p_semanage_user swig_types[17] 
-#define  SWIGTYPE_p_p_semanage_seuser_key swig_types[18] 
-#define  SWIGTYPE_p_semanage_seuser_key swig_types[19] 
-#define  SWIGTYPE_p_p_semanage_user_key swig_types[20] 
-#define  SWIGTYPE_p_semanage_user_key swig_types[21] 
-#define  SWIGTYPE_p_semanage_iface swig_types[22] 
-#define  SWIGTYPE_p_p_p_semanage_iface swig_types[23] 
-#define  SWIGTYPE_p_p_semanage_iface swig_types[24] 
-#define  SWIGTYPE_p_semanage_bool_key swig_types[25] 
-#define  SWIGTYPE_p_p_semanage_bool_key swig_types[26] 
-#define  SWIGTYPE_p_unsigned_int swig_types[27] 
-#define  SWIGTYPE_p_semanage_context swig_types[28] 
-#define  SWIGTYPE_p_p_semanage_context swig_types[29] 
-#define  SWIGTYPE_p_p_semanage_module_info swig_types[30] 
-#define  SWIGTYPE_p_semanage_module_info swig_types[31] 
-#define  SWIGTYPE_p_p_semanage_iface_key swig_types[32] 
-#define  SWIGTYPE_p_semanage_iface_key swig_types[33] 
-#define  SWIGTYPE_p_f_p_void_p_struct_semanage_handle_p_q_const__char_v_______void swig_types[34] 
-#define  SWIGTYPE_ptrdiff_t swig_types[35] 
-#define  SWIGTYPE_p_int swig_types[36] 
-#define  SWIGTYPE_p_semanage_handle swig_types[37] 
-static swig_type_info *swig_types[39];
+#define  SWIGTYPE_p_p_semanage_port_t swig_types[7] 
+#define  SWIGTYPE_p_semanage_port_t swig_types[8] 
+#define  SWIGTYPE_p_p_semanage_seuser swig_types[9] 
+#define  SWIGTYPE_p_semanage_seuser swig_types[10] 
+#define  SWIGTYPE_p_p_p_semanage_seuser swig_types[11] 
+#define  SWIGTYPE_p_p_p_semanage_bool swig_types[12] 
+#define  SWIGTYPE_p_semanage_bool swig_types[13] 
+#define  SWIGTYPE_p_p_semanage_bool swig_types[14] 
+#define  SWIGTYPE_p_p_semanage_user swig_types[15] 
+#define  SWIGTYPE_p_semanage_user swig_types[16] 
+#define  SWIGTYPE_p_size_t swig_types[17] 
+#define  SWIGTYPE_size_t swig_types[18] 
+#define  SWIGTYPE_p_p_p_semanage_user swig_types[19] 
+#define  SWIGTYPE_p_semanage_seuser_key swig_types[20] 
+#define  SWIGTYPE_p_p_semanage_user_key swig_types[21] 
+#define  SWIGTYPE_p_semanage_user_key swig_types[22] 
+#define  SWIGTYPE_p_p_semanage_seuser_key swig_types[23] 
+#define  SWIGTYPE_p_semanage_iface swig_types[24] 
+#define  SWIGTYPE_p_p_p_semanage_iface swig_types[25] 
+#define  SWIGTYPE_p_p_semanage_iface swig_types[26] 
+#define  SWIGTYPE_p_semanage_bool_key swig_types[27] 
+#define  SWIGTYPE_p_p_semanage_bool_key swig_types[28] 
+#define  SWIGTYPE_p_unsigned_int swig_types[29] 
+#define  SWIGTYPE_p_semanage_context swig_types[30] 
+#define  SWIGTYPE_p_p_semanage_context swig_types[31] 
+#define  SWIGTYPE_p_p_semanage_module_info swig_types[32] 
+#define  SWIGTYPE_p_semanage_module_info swig_types[33] 
+#define  SWIGTYPE_p_p_semanage_iface_key swig_types[34] 
+#define  SWIGTYPE_p_semanage_iface_key swig_types[35] 
+#define  SWIGTYPE_p_f_p_void_p_struct_semanage_handle_p_q_const__char_v_______void swig_types[36] 
+#define  SWIGTYPE_ptrdiff_t swig_types[37] 
+#define  SWIGTYPE_p_int swig_types[38] 
+#define  SWIGTYPE_p_semanage_handle swig_types[39] 
+static swig_type_info *swig_types[41];
 
 /* -------- TYPES TABLE (END) -------- */
 
@@ -1390,6 +1392,9 @@ static swig_type_info *swig_types[39];
 	#include "semanage/ports_local.h"        
 	#include "semanage/seusers.h"            
 	#include "semanage/users_policy.h"
+	#include "semanage/port_record.h"
+	#include "semanage/ports_local.h"
+	#include "semanage/ports_policy.h"
 
 
 	semanage_user_t *semanage_user_by_idx(semanage_user_t **list, int n){
@@ -1398,6 +1403,9 @@ static swig_type_info *swig_types[39];
 	semanage_seuser_t *semanage_seuser_by_idx(semanage_seuser_t **list, int n){
 		return list[n];
 	}	
+	semanage_port_t *semanage_port_by_idx(semanage_port_t **list, int n){
+		return list[n];
+	}	
 
 
 #include <limits.h>
@@ -1815,6 +1823,30 @@ static PyObject *_wrap_semanage_seuser_b
 }
 
 
+static PyObject *_wrap_semanage_port_by_idx(PyObject *self, PyObject *args) {
+    PyObject *resultobj;
+    semanage_port_t **arg1 = (semanage_port_t **) 0 ;
+    int arg2 ;
+    semanage_port_t *result;
+    PyObject * obj0 = 0 ;
+    PyObject * obj1 = 0 ;
+    
+    if(!PyArg_ParseTuple(args,(char *)"OO:semanage_port_by_idx",&obj0,&obj1)) goto fail;
+    SWIG_Python_ConvertPtr(obj0, (void **)&arg1, SWIGTYPE_p_p_semanage_port_t, SWIG_POINTER_EXCEPTION | 0);
+    if (SWIG_arg_fail(1)) SWIG_fail;
+    {
+        arg2 = (int)(SWIG_As_int(obj1)); 
+        if (SWIG_arg_fail(2)) SWIG_fail;
+    }
+    result = (semanage_port_t *)semanage_port_by_idx(arg1,arg2);
+    
+    resultobj = SWIG_NewPointerObj((void*)(result), SWIGTYPE_p_semanage_port_t, 0);
+    return resultobj;
+    fail:
+    return NULL;
+}
+
+
 static PyObject *_wrap_semanage_bool_key_create(PyObject *self, PyObject *args) {
     PyObject *resultobj;
     semanage_handle_t *arg1 = (semanage_handle_t *) 0 ;
@@ -2987,23 +3019,27 @@ static PyObject *_wrap_semanage_user_key
     char *arg2 = (char *) 0 ;
     semanage_user_key_t **arg3 = (semanage_user_key_t **) 0 ;
     int result;
+    semanage_user_key_t *temp3 ;
     PyObject * obj0 = 0 ;
     PyObject * obj1 = 0 ;
-    PyObject * obj2 = 0 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"OOO:semanage_user_key_create",&obj0,&obj1,&obj2)) goto fail;
+    {
+        arg3 = &temp3;
+    }
+    if(!PyArg_ParseTuple(args,(char *)"OO:semanage_user_key_create",&obj0,&obj1)) goto fail;
     SWIG_Python_ConvertPtr(obj0, (void **)&arg1, SWIGTYPE_p_semanage_handle, SWIG_POINTER_EXCEPTION | 0);
     if (SWIG_arg_fail(1)) SWIG_fail;
     if (!SWIG_AsCharPtr(obj1, (char**)&arg2)) {
         SWIG_arg_fail(2);SWIG_fail;
     }
-    SWIG_Python_ConvertPtr(obj2, (void **)&arg3, SWIGTYPE_p_p_semanage_user_key, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(3)) SWIG_fail;
     result = (int)semanage_user_key_create(arg1,(char const *)arg2,arg3);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    {
+        resultobj = t_output_helper(resultobj, SWIG_NewPointerObj(*arg3, SWIGTYPE_p_semanage_user_key, 0));
+    }
     return resultobj;
     fail:
     return NULL;
@@ -3016,22 +3052,26 @@ static PyObject *_wrap_semanage_user_key
     semanage_user_t *arg2 = (semanage_user_t *) 0 ;
     semanage_user_key_t **arg3 = (semanage_user_key_t **) 0 ;
     int result;
+    semanage_user_key_t *temp3 ;
     PyObject * obj0 = 0 ;
     PyObject * obj1 = 0 ;
-    PyObject * obj2 = 0 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"OOO:semanage_user_key_extract",&obj0,&obj1,&obj2)) goto fail;
+    {
+        arg3 = &temp3;
+    }
+    if(!PyArg_ParseTuple(args,(char *)"OO:semanage_user_key_extract",&obj0,&obj1)) goto fail;
     SWIG_Python_ConvertPtr(obj0, (void **)&arg1, SWIGTYPE_p_semanage_handle, SWIG_POINTER_EXCEPTION | 0);
     if (SWIG_arg_fail(1)) SWIG_fail;
     SWIG_Python_ConvertPtr(obj1, (void **)&arg2, SWIGTYPE_p_semanage_user, SWIG_POINTER_EXCEPTION | 0);
     if (SWIG_arg_fail(2)) SWIG_fail;
-    SWIG_Python_ConvertPtr(obj2, (void **)&arg3, SWIGTYPE_p_p_semanage_user_key, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(3)) SWIG_fail;
     result = (int)semanage_user_key_extract(arg1,arg2,arg3);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    {
+        resultobj = t_output_helper(resultobj, SWIG_NewPointerObj(*arg3, SWIGTYPE_p_semanage_user_key, 0));
+    }
     return resultobj;
     fail:
     return NULL;
@@ -3443,19 +3483,23 @@ static PyObject *_wrap_semanage_user_cre
     semanage_handle_t *arg1 = (semanage_handle_t *) 0 ;
     semanage_user_t **arg2 = (semanage_user_t **) 0 ;
     int result;
+    semanage_user_t *temp2 ;
     PyObject * obj0 = 0 ;
-    PyObject * obj1 = 0 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"OO:semanage_user_create",&obj0,&obj1)) goto fail;
+    {
+        arg2 = &temp2;
+    }
+    if(!PyArg_ParseTuple(args,(char *)"O:semanage_user_create",&obj0)) goto fail;
     SWIG_Python_ConvertPtr(obj0, (void **)&arg1, SWIGTYPE_p_semanage_handle, SWIG_POINTER_EXCEPTION | 0);
     if (SWIG_arg_fail(1)) SWIG_fail;
-    SWIG_Python_ConvertPtr(obj1, (void **)&arg2, SWIGTYPE_p_p_semanage_user, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(2)) SWIG_fail;
     result = (int)semanage_user_create(arg1,arg2);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    {
+        resultobj = t_output_helper(resultobj, SWIG_NewPointerObj(*arg2, SWIGTYPE_p_semanage_user, 0));
+    }
     return resultobj;
     fail:
     return NULL;
@@ -3468,22 +3512,26 @@ static PyObject *_wrap_semanage_user_clo
     semanage_user_t *arg2 = (semanage_user_t *) 0 ;
     semanage_user_t **arg3 = (semanage_user_t **) 0 ;
     int result;
+    semanage_user_t *temp3 ;
     PyObject * obj0 = 0 ;
     PyObject * obj1 = 0 ;
-    PyObject * obj2 = 0 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"OOO:semanage_user_clone",&obj0,&obj1,&obj2)) goto fail;
+    {
+        arg3 = &temp3;
+    }
+    if(!PyArg_ParseTuple(args,(char *)"OO:semanage_user_clone",&obj0,&obj1)) goto fail;
     SWIG_Python_ConvertPtr(obj0, (void **)&arg1, SWIGTYPE_p_semanage_handle, SWIG_POINTER_EXCEPTION | 0);
     if (SWIG_arg_fail(1)) SWIG_fail;
     SWIG_Python_ConvertPtr(obj1, (void **)&arg2, SWIGTYPE_p_semanage_user, SWIG_POINTER_EXCEPTION | 0);
     if (SWIG_arg_fail(2)) SWIG_fail;
-    SWIG_Python_ConvertPtr(obj2, (void **)&arg3, SWIGTYPE_p_p_semanage_user, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(3)) SWIG_fail;
     result = (int)semanage_user_clone(arg1,arg2,arg3);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    {
+        resultobj = t_output_helper(resultobj, SWIG_NewPointerObj(*arg3, SWIGTYPE_p_semanage_user, 0));
+    }
     return resultobj;
     fail:
     return NULL;
@@ -3948,23 +3996,27 @@ static PyObject *_wrap_semanage_seuser_k
     char *arg2 = (char *) 0 ;
     semanage_seuser_key_t **arg3 = (semanage_seuser_key_t **) 0 ;
     int result;
+    semanage_seuser_key_t *temp3 ;
     PyObject * obj0 = 0 ;
     PyObject * obj1 = 0 ;
-    PyObject * obj2 = 0 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"OOO:semanage_seuser_key_create",&obj0,&obj1,&obj2)) goto fail;
+    {
+        arg3 = &temp3;
+    }
+    if(!PyArg_ParseTuple(args,(char *)"OO:semanage_seuser_key_create",&obj0,&obj1)) goto fail;
     SWIG_Python_ConvertPtr(obj0, (void **)&arg1, SWIGTYPE_p_semanage_handle, SWIG_POINTER_EXCEPTION | 0);
     if (SWIG_arg_fail(1)) SWIG_fail;
     if (!SWIG_AsCharPtr(obj1, (char**)&arg2)) {
         SWIG_arg_fail(2);SWIG_fail;
     }
-    SWIG_Python_ConvertPtr(obj2, (void **)&arg3, SWIGTYPE_p_p_semanage_seuser_key, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(3)) SWIG_fail;
     result = (int)semanage_seuser_key_create(arg1,(char const *)arg2,arg3);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    {
+        resultobj = t_output_helper(resultobj, SWIG_NewPointerObj(*arg3, SWIGTYPE_p_semanage_seuser_key, 0));
+    }
     return resultobj;
     fail:
     return NULL;
@@ -3977,22 +4029,26 @@ static PyObject *_wrap_semanage_seuser_k
     semanage_seuser_t *arg2 = (semanage_seuser_t *) 0 ;
     semanage_seuser_key_t **arg3 = (semanage_seuser_key_t **) 0 ;
     int result;
+    semanage_seuser_key_t *temp3 ;
     PyObject * obj0 = 0 ;
     PyObject * obj1 = 0 ;
-    PyObject * obj2 = 0 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"OOO:semanage_seuser_key_extract",&obj0,&obj1,&obj2)) goto fail;
+    {
+        arg3 = &temp3;
+    }
+    if(!PyArg_ParseTuple(args,(char *)"OO:semanage_seuser_key_extract",&obj0,&obj1)) goto fail;
     SWIG_Python_ConvertPtr(obj0, (void **)&arg1, SWIGTYPE_p_semanage_handle, SWIG_POINTER_EXCEPTION | 0);
     if (SWIG_arg_fail(1)) SWIG_fail;
     SWIG_Python_ConvertPtr(obj1, (void **)&arg2, SWIGTYPE_p_semanage_seuser, SWIG_POINTER_EXCEPTION | 0);
     if (SWIG_arg_fail(2)) SWIG_fail;
-    SWIG_Python_ConvertPtr(obj2, (void **)&arg3, SWIGTYPE_p_p_semanage_seuser_key, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(3)) SWIG_fail;
     result = (int)semanage_seuser_key_extract(arg1,arg2,arg3);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    {
+        resultobj = t_output_helper(resultobj, SWIG_NewPointerObj(*arg3, SWIGTYPE_p_semanage_seuser_key, 0));
+    }
     return resultobj;
     fail:
     return NULL;
@@ -4186,19 +4242,23 @@ static PyObject *_wrap_semanage_seuser_c
     semanage_handle_t *arg1 = (semanage_handle_t *) 0 ;
     semanage_seuser_t **arg2 = (semanage_seuser_t **) 0 ;
     int result;
+    semanage_seuser_t *temp2 ;
     PyObject * obj0 = 0 ;
-    PyObject * obj1 = 0 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"OO:semanage_seuser_create",&obj0,&obj1)) goto fail;
+    {
+        arg2 = &temp2;
+    }
+    if(!PyArg_ParseTuple(args,(char *)"O:semanage_seuser_create",&obj0)) goto fail;
     SWIG_Python_ConvertPtr(obj0, (void **)&arg1, SWIGTYPE_p_semanage_handle, SWIG_POINTER_EXCEPTION | 0);
     if (SWIG_arg_fail(1)) SWIG_fail;
-    SWIG_Python_ConvertPtr(obj1, (void **)&arg2, SWIGTYPE_p_p_semanage_seuser, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(2)) SWIG_fail;
     result = (int)semanage_seuser_create(arg1,arg2);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    {
+        resultobj = t_output_helper(resultobj, SWIG_NewPointerObj(*arg2, SWIGTYPE_p_semanage_seuser, 0));
+    }
     return resultobj;
     fail:
     return NULL;
@@ -4211,22 +4271,26 @@ static PyObject *_wrap_semanage_seuser_c
     semanage_seuser_t *arg2 = (semanage_seuser_t *) 0 ;
     semanage_seuser_t **arg3 = (semanage_seuser_t **) 0 ;
     int result;
+    semanage_seuser_t *temp3 ;
     PyObject * obj0 = 0 ;
     PyObject * obj1 = 0 ;
-    PyObject * obj2 = 0 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"OOO:semanage_seuser_clone",&obj0,&obj1,&obj2)) goto fail;
+    {
+        arg3 = &temp3;
+    }
+    if(!PyArg_ParseTuple(args,(char *)"OO:semanage_seuser_clone",&obj0,&obj1)) goto fail;
     SWIG_Python_ConvertPtr(obj0, (void **)&arg1, SWIGTYPE_p_semanage_handle, SWIG_POINTER_EXCEPTION | 0);
     if (SWIG_arg_fail(1)) SWIG_fail;
     SWIG_Python_ConvertPtr(obj1, (void **)&arg2, SWIGTYPE_p_semanage_seuser, SWIG_POINTER_EXCEPTION | 0);
     if (SWIG_arg_fail(2)) SWIG_fail;
-    SWIG_Python_ConvertPtr(obj2, (void **)&arg3, SWIGTYPE_p_p_semanage_seuser, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(3)) SWIG_fail;
     result = (int)semanage_seuser_clone(arg1,arg2,arg3);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    {
+        resultobj = t_output_helper(resultobj, SWIG_NewPointerObj(*arg3, SWIGTYPE_p_semanage_seuser, 0));
+    }
     return resultobj;
     fail:
     return NULL;
@@ -4364,22 +4428,26 @@ static PyObject *_wrap_semanage_user_que
     semanage_user_key_t *arg2 = (semanage_user_key_t *) 0 ;
     semanage_user_t **arg3 = (semanage_user_t **) 0 ;
     int result;
+    semanage_user_t *temp3 ;
     PyObject * obj0 = 0 ;
     PyObject * obj1 = 0 ;
-    PyObject * obj2 = 0 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"OOO:semanage_user_query_local",&obj0,&obj1,&obj2)) goto fail;
+    {
+        arg3 = &temp3;
+    }
+    if(!PyArg_ParseTuple(args,(char *)"OO:semanage_user_query_local",&obj0,&obj1)) goto fail;
     SWIG_Python_ConvertPtr(obj0, (void **)&arg1, SWIGTYPE_p_semanage_handle, SWIG_POINTER_EXCEPTION | 0);
     if (SWIG_arg_fail(1)) SWIG_fail;
     SWIG_Python_ConvertPtr(obj1, (void **)&arg2, SWIGTYPE_p_semanage_user_key, SWIG_POINTER_EXCEPTION | 0);
     if (SWIG_arg_fail(2)) SWIG_fail;
-    SWIG_Python_ConvertPtr(obj2, (void **)&arg3, SWIGTYPE_p_p_semanage_user, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(3)) SWIG_fail;
     result = (int)semanage_user_query_local(arg1,arg2,arg3);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    {
+        resultobj = t_output_helper(resultobj, SWIG_NewPointerObj(*arg3, SWIGTYPE_p_semanage_user, 0));
+    }
     return resultobj;
     fail:
     return NULL;
@@ -5184,22 +5252,26 @@ static PyObject *_wrap_semanage_seuser_q
     semanage_seuser_key_t *arg2 = (semanage_seuser_key_t *) 0 ;
     semanage_seuser_t **arg3 = (semanage_seuser_t **) 0 ;
     int result;
+    semanage_seuser_t *temp3 ;
     PyObject * obj0 = 0 ;
     PyObject * obj1 = 0 ;
-    PyObject * obj2 = 0 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"OOO:semanage_seuser_query",&obj0,&obj1,&obj2)) goto fail;
+    {
+        arg3 = &temp3;
+    }
+    if(!PyArg_ParseTuple(args,(char *)"OO:semanage_seuser_query",&obj0,&obj1)) goto fail;
     SWIG_Python_ConvertPtr(obj0, (void **)&arg1, SWIGTYPE_p_semanage_handle, SWIG_POINTER_EXCEPTION | 0);
     if (SWIG_arg_fail(1)) SWIG_fail;
     SWIG_Python_ConvertPtr(obj1, (void **)&arg2, SWIGTYPE_p_semanage_seuser_key, SWIG_POINTER_EXCEPTION | 0);
     if (SWIG_arg_fail(2)) SWIG_fail;
-    SWIG_Python_ConvertPtr(obj2, (void **)&arg3, SWIGTYPE_p_p_semanage_seuser, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(3)) SWIG_fail;
     result = (int)semanage_seuser_query(arg1,arg2,arg3);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    {
+        resultobj = t_output_helper(resultobj, SWIG_NewPointerObj(*arg3, SWIGTYPE_p_semanage_seuser, 0));
+    }
     return resultobj;
     fail:
     return NULL;
@@ -5331,22 +5403,26 @@ static PyObject *_wrap_semanage_user_que
     semanage_user_key_t *arg2 = (semanage_user_key_t *) 0 ;
     semanage_user_t **arg3 = (semanage_user_t **) 0 ;
     int result;
+    semanage_user_t *temp3 ;
     PyObject * obj0 = 0 ;
     PyObject * obj1 = 0 ;
-    PyObject * obj2 = 0 ;
     
-    if(!PyArg_ParseTuple(args,(char *)"OOO:semanage_user_query",&obj0,&obj1,&obj2)) goto fail;
+    {
+        arg3 = &temp3;
+    }
+    if(!PyArg_ParseTuple(args,(char *)"OO:semanage_user_query",&obj0,&obj1)) goto fail;
     SWIG_Python_ConvertPtr(obj0, (void **)&arg1, SWIGTYPE_p_semanage_handle, SWIG_POINTER_EXCEPTION | 0);
     if (SWIG_arg_fail(1)) SWIG_fail;
     SWIG_Python_ConvertPtr(obj1, (void **)&arg2, SWIGTYPE_p_semanage_user_key, SWIG_POINTER_EXCEPTION | 0);
     if (SWIG_arg_fail(2)) SWIG_fail;
-    SWIG_Python_ConvertPtr(obj2, (void **)&arg3, SWIGTYPE_p_p_semanage_user, SWIG_POINTER_EXCEPTION | 0);
-    if (SWIG_arg_fail(3)) SWIG_fail;
     result = (int)semanage_user_query(arg1,arg2,arg3);
     
     {
         resultobj = SWIG_From_int((int)(result)); 
     }
+    {
+        resultobj = t_output_helper(resultobj, SWIG_NewPointerObj(*arg3, SWIGTYPE_p_semanage_user, 0));
+    }
     return resultobj;
     fail:
     return NULL;
@@ -5475,6 +5551,7 @@ static PyObject *_wrap_semanage_user_lis
 static PyMethodDef SwigMethods[] = {
 	 { (char *)"semanage_user_by_idx", _wrap_semanage_user_by_idx, METH_VARARGS, NULL},
 	 { (char *)"semanage_seuser_by_idx", _wrap_semanage_seuser_by_idx, METH_VARARGS, NULL},
+	 { (char *)"semanage_port_by_idx", _wrap_semanage_port_by_idx, METH_VARARGS, NULL},
 	 { (char *)"semanage_bool_key_create", _wrap_semanage_bool_key_create, METH_VARARGS, NULL},
 	 { (char *)"semanage_bool_key_extract", _wrap_semanage_bool_key_extract, METH_VARARGS, NULL},
 	 { (char *)"semanage_bool_key_free", _wrap_semanage_bool_key_free, METH_VARARGS, NULL},
@@ -5626,13 +5703,15 @@ static PyMethodDef SwigMethods[] = {
 
 /* -------- TYPE CONVERSION AND EQUIVALENCE RULES (BEGIN) -------- */
 
-static swig_type_info _swigt__p_f_p_struct_semanage_user_p_void__int[] = {{"_p_f_p_struct_semanage_user_p_void__int", 0, "int (*)(struct semanage_user *,void *)|int (*)(semanage_user_t *,void *)", 0, 0, 0, 0},{"_p_f_p_struct_semanage_user_p_void__int", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_f_p_struct_semanage_bool_p_void__int[] = {{"_p_f_p_struct_semanage_bool_p_void__int", 0, "int (*)(struct semanage_bool *,void *)|int (*)(semanage_bool_t *,void *)", 0, 0, 0, 0},{"_p_f_p_struct_semanage_bool_p_void__int", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_f_p_struct_semanage_iface_p_void__int[] = {{"_p_f_p_struct_semanage_iface_p_void__int", 0, "int (*)(struct semanage_iface *,void *)|int (*)(semanage_iface_t *,void *)", 0, 0, 0, 0},{"_p_f_p_struct_semanage_iface_p_void__int", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_p_char[] = {{"_p_p_char", 0, "char **", 0, 0, 0, 0},{"_p_p_char", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_p_p_char[] = {{"_p_p_p_char", 0, "char ***", 0, 0, 0, 0},{"_p_p_p_char", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_char[] = {{"_p_char", 0, "char *", 0, 0, 0, 0},{"_p_char", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
+static swig_type_info _swigt__p_f_p_struct_semanage_user_p_void__int[] = {{"_p_f_p_struct_semanage_user_p_void__int", 0, "int (*)(struct semanage_user *,void *)|int (*)(semanage_user_t *,void *)", 0, 0, 0, 0},{"_p_f_p_struct_semanage_user_p_void__int", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_f_p_struct_semanage_seuser_p_void__int[] = {{"_p_f_p_struct_semanage_seuser_p_void__int", 0, "int (*)(struct semanage_seuser *,void *)|int (*)(semanage_seuser_t *,void *)", 0, 0, 0, 0},{"_p_f_p_struct_semanage_seuser_p_void__int", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
+static swig_type_info _swigt__p_p_semanage_port_t[] = {{"_p_p_semanage_port_t", 0, "semanage_port_t **", 0, 0, 0, 0},{"_p_p_semanage_port_t", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
+static swig_type_info _swigt__p_semanage_port_t[] = {{"_p_semanage_port_t", 0, "semanage_port_t *", 0, 0, 0, 0},{"_p_semanage_port_t", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_p_semanage_seuser[] = {{"_p_p_semanage_seuser", 0, "struct semanage_seuser **|semanage_seuser_t **", 0, 0, 0, 0},{"_p_p_semanage_seuser", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_semanage_seuser[] = {{"_p_semanage_seuser", 0, "struct semanage_seuser *|semanage_seuser_t *", 0, 0, 0, 0},{"_p_semanage_seuser", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_p_p_semanage_seuser[] = {{"_p_p_p_semanage_seuser", 0, "struct semanage_seuser ***|semanage_seuser_t ***", 0, 0, 0, 0},{"_p_p_p_semanage_seuser", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
@@ -5644,10 +5723,10 @@ static swig_type_info _swigt__p_semanage
 static swig_type_info _swigt__p_size_t[] = {{"_p_size_t", 0, "size_t *", 0, 0, 0, 0},{"_p_size_t", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__size_t[] = {{"_size_t", 0, "size_t", 0, 0, 0, 0},{"_size_t", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_p_p_semanage_user[] = {{"_p_p_p_semanage_user", 0, "struct semanage_user ***|semanage_user_t ***", 0, 0, 0, 0},{"_p_p_p_semanage_user", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
-static swig_type_info _swigt__p_p_semanage_seuser_key[] = {{"_p_p_semanage_seuser_key", 0, "struct semanage_seuser_key **|semanage_seuser_key_t **", 0, 0, 0, 0},{"_p_p_semanage_seuser_key", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_semanage_seuser_key[] = {{"_p_semanage_seuser_key", 0, "struct semanage_seuser_key *|semanage_seuser_key_t *", 0, 0, 0, 0},{"_p_semanage_seuser_key", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_p_semanage_user_key[] = {{"_p_p_semanage_user_key", 0, "struct semanage_user_key **|semanage_user_key_t **", 0, 0, 0, 0},{"_p_p_semanage_user_key", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_semanage_user_key[] = {{"_p_semanage_user_key", 0, "struct semanage_user_key *|semanage_user_key_t *", 0, 0, 0, 0},{"_p_semanage_user_key", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
+static swig_type_info _swigt__p_p_semanage_seuser_key[] = {{"_p_p_semanage_seuser_key", 0, "struct semanage_seuser_key **|semanage_seuser_key_t **", 0, 0, 0, 0},{"_p_p_semanage_seuser_key", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_semanage_iface[] = {{"_p_semanage_iface", 0, "struct semanage_iface *|semanage_iface_t *", 0, 0, 0, 0},{"_p_semanage_iface", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_p_p_semanage_iface[] = {{"_p_p_p_semanage_iface", 0, "struct semanage_iface ***|semanage_iface_t ***", 0, 0, 0, 0},{"_p_p_p_semanage_iface", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 static swig_type_info _swigt__p_p_semanage_iface[] = {{"_p_p_semanage_iface", 0, "struct semanage_iface **|semanage_iface_t **", 0, 0, 0, 0},{"_p_p_semanage_iface", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
@@ -5666,13 +5745,15 @@ static swig_type_info _swigt__p_int[] = 
 static swig_type_info _swigt__p_semanage_handle[] = {{"_p_semanage_handle", 0, "struct semanage_handle *|semanage_handle_t *", 0, 0, 0, 0},{"_p_semanage_handle", 0, 0, 0, 0, 0, 0},{0, 0, 0, 0, 0, 0, 0}};
 
 static swig_type_info *swig_types_initial[] = {
-_swigt__p_f_p_struct_semanage_user_p_void__int, 
 _swigt__p_f_p_struct_semanage_bool_p_void__int, 
 _swigt__p_f_p_struct_semanage_iface_p_void__int, 
 _swigt__p_p_char, 
 _swigt__p_p_p_char, 
 _swigt__p_char, 
+_swigt__p_f_p_struct_semanage_user_p_void__int, 
 _swigt__p_f_p_struct_semanage_seuser_p_void__int, 
+_swigt__p_p_semanage_port_t, 
+_swigt__p_semanage_port_t, 
 _swigt__p_p_semanage_seuser, 
 _swigt__p_semanage_seuser, 
 _swigt__p_p_p_semanage_seuser, 
@@ -5684,10 +5765,10 @@ _swigt__p_semanage_user, 
 _swigt__p_size_t, 
 _swigt__size_t, 
 _swigt__p_p_p_semanage_user, 
-_swigt__p_p_semanage_seuser_key, 
 _swigt__p_semanage_seuser_key, 
 _swigt__p_p_semanage_user_key, 
 _swigt__p_semanage_user_key, 
+_swigt__p_p_semanage_seuser_key, 
 _swigt__p_semanage_iface, 
 _swigt__p_p_p_semanage_iface, 
 _swigt__p_p_semanage_iface, 

--=-KeIH1axhg2LMQbpWXO5b--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
