Message-ID: <43F226B5.6020603@cornell.edu>
Date: Tue, 14 Feb 2006 13:51:33 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Improve bindings, add PyList(String) for roles array
References: <43E26F62.7010400@cornell.edu> <43F1B827.401@cornell.edu> <43F1C84C.5030800@cornell.edu>
In-Reply-To: <43F1C84C.5030800@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------050800010508010209040003"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050800010508010209040003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

ChangeLog:

- Split out PyList building code and put it in a common function. In 
that function:
   - audit failure in PyNew
   - audit failure in PyAppend (used to be SetItem)
   - audit failure in SWIG_NewPointerObj
   - on failure, call the object destructor function on the entire list, 
and return STATUS_ERR.

   I'm not sure if that accomplishes much. I suspect the swig wrappers 
have a million ways in which they can fail internally. Yet, I feel like 
it is wrong to not audit errors in code that I write, so this corrects 
that mistake. I also like the idea of the list building code being in a 
common function.

- Add more PyLists..... convert semanage_user_get_roles() to using 
PyList, instead of character arrays.
    - Remove char_by_idx.
    - fix dependency in seobject.py
    - unlike other wrappers, this one also converts the string itself, 
from char* to a python string
      (see semanage2plist, which can be called in two ways)

- Use fewer SWIG internal conventions
     - don't use the result variable - use the $result python variable, 
which is documented. Use SWIG_As_int to get the integer out of it.
     - do not use SWIGTYPE_...* where possible. Use special variables 
that provide access to the descriptor without writing out the type.

Next:
- make the opposite conversion, and make set_roles() work properly
- try to get rid of usage of t_output_helper()

--------------050800010508010209040003
Content-Type: text/x-patch;
 name="libsemanage.improve_bindings.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.improve_bindings.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/pywrap-test.py new/libsemanage/src/pywrap-test.py
--- old/libsemanage/src/pywrap-test.py	2006-02-14 05:59:03.000000000 -0500
+++ new/libsemanage/src/pywrap-test.py	2006-02-14 11:08:01.000000000 -0500
@@ -178,12 +178,13 @@ class Tests:
 			print "   User mls range: ", semanage.semanage_user_get_mlsrange(user)
 			print "   User number of roles: ", semanage.semanage_user_get_num_roles(user)
 			print "   User roles: "
-			(status, rlist, rlist_size) = semanage.semanage_user_get_roles(sh, user)
+			(status, rlist) = semanage.semanage_user_get_roles(sh, user)
 			if status < 0:
 				raise Error("Could not get user roles")
+				
+			for role in rlist:
+				print "      ", role
 
-			for ridx in range (rlist_size):
-				print "      ", semanage.char_by_idx(rlist, ridx)
 			semanage.semanage_user_free(user)
 
 	def test_ports(self,sh):
diff -Naurp --exclude-from excludes old/libsemanage/src/semanageswig.i new/libsemanage/src/semanageswig.i
--- old/libsemanage/src/semanageswig.i	2006-02-14 11:16:51.000000000 -0500
+++ new/libsemanage/src/semanageswig.i	2006-02-14 09:11:19.000000000 -0500
@@ -20,9 +20,6 @@
 
 
 %module semanage
-%{
-	#include "semanage/semanage.h"
-%}
 
 /* pull in the headers */
 %include "../include/semanage/debug.h"
diff -Naurp --exclude-from excludes old/libsemanage/src/semanageswig_python.i new/libsemanage/src/semanageswig_python.i
--- old/libsemanage/src/semanageswig_python.i	2006-02-14 11:16:51.000000000 -0500
+++ new/libsemanage/src/semanageswig_python.i	2006-02-14 13:46:29.000000000 -0500
@@ -20,6 +20,77 @@
 
 /** standard typemaps **/
 
+%header %{
+	#include <stdlib.h>
+	#include <semanage/semanage.h>
+
+	#define STATUS_SUCCESS 0
+	#define STATUS_ERR -1
+%}
+
+%wrapper %{
+
+
+	/* There are two ways to call this function:
+	 * One is with a valid swig_type and destructor.
+	 * Two is with a NULL swig_type and NULL destructor. 
+	 * 
+	 * In the first mode, the function converts
+	 * an array of *cloned* objects [of the given pointer swig type] 
+	 * into a PyList, and destroys the array in the process 
+	 * (the objects pointers are preserved).
+	 *
+	 * In the second mode, the function converts
+	 * an array of *constant* strings into a PyList, and destroys
+	 * the array in the process 
+	 * (the strings are copied, originals not freed). */
+
+	static int semanage_array2plist(
+		semanage_handle_t* handle,
+		void** arr, 
+		unsigned int asize, 
+		swig_type_info* swig_type,
+		void (*destructor) (void*),	
+		PyObject** result) {
+		
+		PyObject* plist = PyList_New(0);
+		unsigned int i;
+
+		if (!plist) 
+			goto err;
+	
+		for (i = 0; i < asize; i++)  {
+			
+			PyObject* obj = NULL;
+
+			/* NULL indicates string conversion,
+			 * otherwise create an opaque pointer */
+			if (!swig_type)
+				obj = SWIG_FromCharPtr(arr[i]);
+			else
+				obj = SWIG_NewPointerObj(arr[i], swig_type, 0);				 
+
+			if (!obj) 
+				goto err;
+
+			if (PyList_Append(plist, obj) < 0) 
+				goto err;
+		}
+
+		free(arr);
+		
+		*result = plist;		
+		return STATUS_SUCCESS;
+
+		err:
+		for (i = 0; i < asize; i++) 
+			if (destructor)
+				destructor(arr[i]);
+		free(arr);
+		return STATUS_ERR;
+	}
+%}
+
 /* a few helpful typemaps are available in this library */
 %include <typemaps.i>
 /* wrap all int*'s so they can be used for results 
@@ -28,12 +99,6 @@
 %apply int *OUTPUT { size_t * };
 %apply int *OUTPUT { unsigned int * };
 
-%inline {
-	char *char_by_idx(char **list, int n) {
-		return list[n];
-	}
-}
-
 %typemap(in, numinputs=0) char **(char *temp) {
 	$1 = &temp;
 }
@@ -47,8 +112,23 @@
 	$1 = &temp;
 }
 
-%typemap(argout) char*** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_p_char, 0));
+%typemap(argout) (
+ 	semanage_handle_t* handle,
+	const semanage_user_t* user,
+	const char*** roles_arr, 
+	unsigned int* num_roles) {
+
+	if ($result) {	
+		int value = SWIG_As_int($result);
+		if (value >= 0) {
+			PyObject* plist = NULL;
+			if (semanage_array2plist($1, (void**) *$3, *$4,
+                        	NULL, NULL, &plist) < 0)
+				$result = SWIG_From_int(STATUS_ERR);
+			else
+				$result = t_output_helper($result, plist);
+		}
+	}
 }
 
 /** module typemaps**/
@@ -60,7 +140,7 @@
 }
 
 %typemap(argout) semanage_module_info_t ** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_module_info, 0));
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 /** context typemaps **/
@@ -72,7 +152,7 @@
 }
 
 %typemap(argout) semanage_context_t** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_context, 0));
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 /** boolean typemaps **/
@@ -84,19 +164,20 @@
 }
 
 %typemap(argout) (
-	semanage_handle_t* handle,
-	semanage_bool_t*** records,
+ 	semanage_handle_t* handle,
+	semanage_bool_t*** records, 
 	unsigned int* count) {
 
-	if (result >= 0) {
-		PyObject* plist = PyList_New(*$3);
-		unsigned int i;
-
-		for (i = 0; i < *$3; i++) 
-			PyList_SetItem(plist, i, SWIG_NewPointerObj((*$2)[i], SWIGTYPE_p_semanage_bool, 0));
-	
-		$result = t_output_helper($result, plist);
-		free(*$2);
+	if ($result) {	
+		int value = SWIG_As_int($result);
+		if (value >= 0) {
+			PyObject* plist = NULL;
+			if (semanage_array2plist($1, (void**) *$2, *$3, SWIGTYPE_p_semanage_bool,
+				(void (*) (void*)) &semanage_bool_free, &plist) < 0)
+				$result = SWIG_From_int(STATUS_ERR);
+			else
+				$result = t_output_helper($result, plist);
+		}
 	}
 }
 
@@ -105,11 +186,11 @@
 }
 
 %typemap(argout) semanage_bool_t ** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_bool, 0));
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(argout) semanage_bool_key_t ** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_bool_key, 0));
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(in, numinputs=0) semanage_bool_key_t **(semanage_bool_key_t *temp) {
@@ -125,19 +206,20 @@
 }
 
 %typemap(argout) (
-	semanage_handle_t* handle,
-	semanage_fcontext_t*** records,
+ 	semanage_handle_t* handle,
+	semanage_fcontext_t*** records, 
 	unsigned int* count) {
 
-	if (result >= 0) {
-		PyObject* plist = PyList_New(*$3);
-		unsigned int i;
-
-		for (i = 0; i < *$3; i++) 
-			PyList_SetItem(plist, i, SWIG_NewPointerObj((*$2)[i], SWIGTYPE_p_semanage_fcontext, 0));
-	
-		$result = t_output_helper($result, plist);
-		free(*$2);
+	if ($result) {	
+		int value = SWIG_As_int($result);
+		if (value >= 0) {
+			PyObject* plist = NULL;
+			if (semanage_array2plist($1, (void**) *$2, *$3, SWIGTYPE_p_semanage_fcontext,
+				(void (*) (void*)) &semanage_fcontext_free, &plist) < 0)
+				$result = SWIG_From_int(STATUS_ERR);
+			else
+				$result = t_output_helper($result, plist);
+		}
 	}
 }
 
@@ -146,11 +228,11 @@
 }
 
 %typemap(argout) semanage_fcontext_t ** {
-        $result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_fcontext, 0));
+        $result = t_output_helper($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(argout) semanage_fcontext_key_t ** {
-        $result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_fcontext_key, 0));
+        $result = t_output_helper($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(in, numinputs=0) semanage_fcontext_key_t **(semanage_fcontext_key_t *temp) {
@@ -165,33 +247,35 @@
 	$1 = &temp;
 }
 
+
 %typemap(argout) (
-	semanage_handle_t* handle,
-	semanage_iface_t*** records,
+ 	semanage_handle_t* handle,
+	semanage_iface_t*** records, 
 	unsigned int* count) {
 
-	if (result >= 0) {
-		PyObject* plist = PyList_New(*$3);
-		unsigned int i;
-
-		for (i = 0; i < *$3; i++) 
-			PyList_SetItem(plist, i, SWIG_NewPointerObj((*$2)[i], SWIGTYPE_p_semanage_iface, 0));
-	
-		$result = t_output_helper($result, plist);
-		free(*$2);
+	if ($result) {	
+		int value = SWIG_As_int($result);
+		if (value >= 0) {
+			PyObject* plist = NULL;
+			if (semanage_array2plist($1, (void**) *$2, *$3, SWIGTYPE_p_semanage_iface,
+				(void (*) (void*)) &semanage_iface_free, &plist) < 0)
+				$result = SWIG_From_int(STATUS_ERR);
+			else
+				$result = t_output_helper($result, plist);
+		}
 	}
-}	
+}
 
 %typemap(in, numinputs=0) semanage_iface_t **(semanage_iface_t *temp) {
 	$1 = &temp;
 }
 
 %typemap(argout) semanage_iface_t ** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_iface, 0));
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(argout) semanage_iface_key_t ** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_iface_key, 0));
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(in, numinputs=0) semanage_iface_key_t **(semanage_iface_key_t *temp) {
@@ -206,33 +290,35 @@
 	$1 = &temp;
 }
 
+
 %typemap(argout) (
-	semanage_handle_t* handle,
-	semanage_seuser_t*** records,
+ 	semanage_handle_t* handle,
+	semanage_seuser_t*** records, 
 	unsigned int* count) {
 
-	if (result >= 0) {
-		PyObject* plist = PyList_New(*$3);
-		unsigned int i;
-
-		for (i = 0; i < *$3; i++) 
-			PyList_SetItem(plist, i, SWIG_NewPointerObj((*$2)[i], SWIGTYPE_p_semanage_seuser, 0));
-	
-		$result = t_output_helper($result, plist);
-		free(*$2);
+	if ($result) {	
+		int value = SWIG_As_int($result);
+		if (value >= 0) {
+			PyObject* plist = NULL;
+			if (semanage_array2plist($1, (void**) *$2, *$3, SWIGTYPE_p_semanage_seuser,
+				(void (*) (void*)) &semanage_seuser_free, &plist) < 0)
+				$result = SWIG_From_int(STATUS_ERR);
+			else
+				$result = t_output_helper($result, plist);
+		}
 	}
-}	
+}
 
 %typemap(in, numinputs=0) semanage_seuser_t **(semanage_seuser_t *temp) {
 	$1 = &temp;
 }
 
 %typemap(argout) semanage_seuser_t ** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_seuser, 0));
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(argout) semanage_seuser_key_t ** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_seuser_key, 0));
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(in, numinputs=0) semanage_seuser_key_t **(semanage_seuser_key_t *temp) {
@@ -248,32 +334,33 @@
 }
 
 %typemap(argout) (
-	semanage_handle_t* handle,
-	semanage_user_t*** records,
+ 	semanage_handle_t* handle,
+	semanage_user_t*** records, 
 	unsigned int* count) {
 
-	if (result >= 0) {
-		PyObject* plist = PyList_New(*$3);
-		unsigned int i;
-
-		for (i = 0; i < *$3; i++) 
-			PyList_SetItem(plist, i, SWIG_NewPointerObj((*$2)[i], SWIGTYPE_p_semanage_user, 0));
-	
-		$result = t_output_helper($result, plist);
-		free(*$2);
+	if ($result) {	
+		int value = SWIG_As_int($result);
+		if (value >= 0) {
+			PyObject* plist = NULL;
+			if (semanage_array2plist($1, (void**) *$2, *$3, SWIGTYPE_p_semanage_user,
+				(void (*) (void*)) &semanage_user_free, &plist) < 0)
+				$result = SWIG_From_int(STATUS_ERR);
+			else
+				$result = t_output_helper($result, plist);
+		}
 	}
 }
-	
+
 %typemap(in, numinputs=0) semanage_user_t **(semanage_user_t *temp) {
 	$1 = &temp;
 }
 
 %typemap(argout) semanage_user_t ** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_user, 0));
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(argout) semanage_user_key_t ** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_user_key, 0));
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(in, numinputs=0) semanage_user_key_t **(semanage_user_key_t *temp) {
@@ -289,32 +376,33 @@
 }
 
 %typemap(argout) (
-	semanage_handle_t* handle,
-	semanage_port_t*** records,
+ 	semanage_handle_t* handle,
+	semanage_port_t*** records, 
 	unsigned int* count) {
 
-	if (result >= 0) {
-		PyObject* plist = PyList_New(*$3);
-		unsigned int i;
-
-		for (i = 0; i < *$3; i++) 
-			PyList_SetItem(plist, i, SWIG_NewPointerObj((*$2)[i], SWIGTYPE_p_semanage_port, 0));
-	
-		$result = t_output_helper($result, plist);
-		free(*$2);
+	if ($result) {	
+		int value = SWIG_As_int($result);
+		if (value >= 0) {
+			PyObject* plist = NULL;
+			if (semanage_array2plist($1, (void**) *$2, *$3, SWIGTYPE_p_semanage_port,
+				(void (*) (void*)) &semanage_port_free, &plist) < 0)
+				$result = SWIG_From_int(STATUS_ERR);
+			else
+				$result = t_output_helper($result, plist);
+		}
 	}
-}	
+}
 
 %typemap(in, numinputs=0) semanage_port_t **(semanage_port_t *temp) {
 	$1 = &temp;
 }
 
 %typemap(argout) semanage_port_t ** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_port, 0));
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(argout) semanage_port_key_t ** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_port_key, 0));
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(in, numinputs=0) semanage_port_key_t **(semanage_port_key_t *temp) {
@@ -330,19 +418,20 @@
 }
 
 %typemap(argout) (
-	semanage_handle_t* handle,
-	semanage_node_t*** records,
+ 	semanage_handle_t* handle,
+	semanage_node_t*** records, 
 	unsigned int* count) {
 
-	if (result >= 0) {
-		PyObject* plist = PyList_New(*$3);
-		unsigned int i;
-
-		for (i = 0; i < *$3; i++)
-			PyList_SetItem(plist, i, SWIG_NewPointerObj((*$2)[i], SWIGTYPE_p_semanage_node, 0));
-
-		$result = t_output_helper($result, plist);
-		free(*$2);
+	if ($result) {	
+		int value = SWIG_As_int($result);
+		if (value >= 0) {
+			PyObject* plist = NULL;
+			if (semanage_array2plist($1, (void**) *$2, *$3, SWIGTYPE_p_semanage_node,
+				(void (*) (void*)) &semanage_node_free, &plist) < 0)
+				$result = SWIG_From_int(STATUS_ERR);
+			else
+				$result = t_output_helper($result, plist);
+		}
 	}
 }
 
@@ -351,12 +440,12 @@
 }
 
 %typemap(argout) semanage_node_t ** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_node, 0));
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 
 %typemap(argout) semanage_node_key_t ** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_node_key, 0));
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
 %typemap(in, numinputs=0) semanage_node_key_t **(semanage_node_key_t *temp) {
diff -Naurp --exclude-from excludes old/policycoreutils/semanage/seobject.py new/policycoreutils/semanage/seobject.py
--- old/policycoreutils/semanage/seobject.py	2006-02-14 05:59:03.000000000 -0500
+++ new/policycoreutils/semanage/seobject.py	2006-02-14 07:40:43.000000000 -0500
@@ -452,16 +452,11 @@ class seluserRecords(semanageRecords):
 
 		for u in self.ulist:
 			name = semanage_user_get_name(u)
-			(rc, rlist, rlist_size) = semanage_user_get_roles(self.sh, u)
+			(rc, rlist) = semanage_user_get_roles(self.sh, u)
 			if rc < 0:
 				raise ValueError("Could not list roles for user %s" % name)
 
-			roles = ""
-
-			if rlist_size:
-				roles += char_by_idx(rlist, 0)
-				for ridx in range (1,rlist_size):
-					roles += " " + char_by_idx(rlist, ridx)
+			roles = string.join(rlist, ' ');
 			ddict[semanage_user_get_name(u)] = (semanage_user_get_mlslevel(u), semanage_user_get_mlsrange(u), roles)
 
 		return ddict

--------------050800010508010209040003--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
