Message-ID: <43F1C84C.5030800@cornell.edu>
Date: Tue, 14 Feb 2006 07:08:44 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: Move python bindings into semanageswig_python.i
References: <43E26F62.7010400@cornell.edu> <43F1B827.401@cornell.edu>
In-Reply-To: <43F1B827.401@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------090909010605010304040009"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090909010605010304040009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ivan Gyurdiev wrote:
> Attached is a resync of this patch against current genhomedircon.
Now move python stuff into semanageswig_python.i. Trim #include list to 
semanage/semanage.h, which is sufficient. Actually, I doubt that's 
needed at all, since swig seems to prototype all wrapped functions itself.

I define "python stuff" as any typemaps, which are overriding the normal 
SWIG-generated output with custom code - things that re-direct pointers 
to output, as well as list-to-array conversions. There should be no need 
to override swig in the language independent .i file. Also move the lone 
char_by_idx function. Other by_idx functions should be kept out, because 
they might not be needed in other languages. In fact, I should look at 
char_by_idx too, it's probably not needed.

Patch requires resync-ed pylist patch above, as well as the small 
free-leak patch I sent earlier.
It doesn't attempt to make the Makefile language independent - it just 
renames the current .i file being used (it's already hardcoded to use 
-python anyways).


--------------090909010605010304040009
Content-Type: text/x-patch;
 name="libsemanage.split_swig.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.split_swig.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/Makefile new/libsemanage/src/Makefile
--- old/libsemanage/src/Makefile	2006-01-27 10:00:53.000000000 -0500
+++ new/libsemanage/src/Makefile	2006-02-14 06:52:03.000000000 -0500
@@ -23,7 +23,7 @@ LIBVERSION = 1
 
 LIBA=libsemanage.a
 TARGET=libsemanage.so
-SWIGIF= semanageswig.i
+SWIGIF= semanageswig_python.i
 SWIGCOUT= semanageswig_wrap.c
 SWIGLOBJ:= $(patsubst %.c,%.lo,$(SWIGCOUT)) 
 SWIGSO=_semanage.so
diff -Naurp --exclude-from excludes old/libsemanage/src/semanageswig.i new/libsemanage/src/semanageswig.i
--- old/libsemanage/src/semanageswig.i	2006-02-14 06:48:05.000000000 -0500
+++ new/libsemanage/src/semanageswig.i	2006-02-14 06:56:05.000000000 -0500
@@ -1,6 +1,7 @@
 /* Author: Spencer Shimko <sshimko@tresys.com>
  *
  * Copyright (C) 2004-2005 Tresys Technology, LLC
+ * Copyright (C) 2006 Red Hat, Inc.
  * 
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -20,381 +21,9 @@
 
 %module semanage
 %{
-	#include "semanage/debug.h"
-	#include "semanage/handle.h"
-	#include "semanage/modules.h"
-	#include "semanage/context_record.h"
-	#include "semanage/boolean_record.h"
-	#include "semanage/booleans_policy.h"
-	#include "semanage/booleans_local.h"
-	#include "semanage/booleans_active.h"
-	#include "semanage/iface_record.h"
-	#include "semanage/node_record.h"
-	#include "semanage/interfaces_local.h"
-	#include "semanage/interfaces_policy.h"
-	#include "semanage/user_record.h"
-	#include "semanage/users_local.h"
-	#include "semanage/users_policy.h"
-	#include "semanage/port_record.h"
-	#include "semanage/ports_local.h"
-	#include "semanage/ports_policy.h"
-	#include "semanage/seuser_record.h"
-	#include "semanage/fcontext_record.h"
-	#include "semanage/fcontexts_local.h"
-	#include "semanage/fcontexts_policy.h"
-	#include "semanage/seusers_local.h"
-	#include "semanage/seusers_policy.h"
-	#include "semanage/nodes_local.h"
-	#include "semanage/nodes_policy.h"
 	#include "semanage/semanage.h"
 %}
 
-%inline {
-	char *char_by_idx(char **list, int n) {
-		return list[n];
-	}
-}
-
-
-/** standard typemaps **/
-
-/* a few helpful typemaps are available in this library */
-%include <typemaps.i>
-/* wrap all int*'s so they can be used for results 
-   if it becomes necessary to send in data this should be changed to INOUT */
-%apply int *OUTPUT { int * };
-%apply int *OUTPUT { size_t * };
-%apply int *OUTPUT { unsigned int * };
-
-%typemap(in, numinputs=0) char **(char *temp) {
-	$1 = &temp;
-}
-
-%typemap(argout) char** {
-	$result = t_output_helper($result, SWIG_FromCharPtr(*$1));
-	free(*$1);
-}
-
-%typemap(in, numinputs=0) char ***(char **temp) {
-	$1 = &temp;
-}
-
-%typemap(argout) char*** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_p_char, 0));
-}
-
-/** module typemaps**/
-
-/* the wrapper will setup this parameter for passing... the resulting python functions
-   will not take the semanage_module_info_t ** parameter */
-%typemap(in, numinputs=0) semanage_module_info_t **(semanage_module_info_t *temp) {
-	$1 = &temp;
-}
-
-%typemap(argout) semanage_module_info_t ** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_module_info, 0));
-}
-
-/** context typemaps **/
-
-/* the wrapper will setup this parameter for passing... the resulting python functions
-   will not take the semanage_context_t ** parameter */
-%typemap(in, numinputs=0) semanage_context_t **(semanage_context_t *temp) {
-	$1 = &temp;
-}
-
-%typemap(argout) semanage_context_t** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_context, 0));
-}
-
-/** boolean typemaps **/
-
-/* the wrapper will setup this parameter for passing... the resulting python functions
-   will not take the semanage_bool_t *** parameter */
-%typemap(in, numinputs=0) semanage_bool_t ***(semanage_bool_t **temp) {
-	$1 = &temp;
-}
-
-%typemap(argout) (
-	semanage_handle_t* handle,
-	semanage_bool_t*** records,
-	unsigned int* count) {
-
-	if (result >= 0) {
-		PyObject* plist = PyList_New(*$3);
-		unsigned int i;
-
-		for (i = 0; i < *$3; i++) 
-			PyList_SetItem(plist, i, SWIG_NewPointerObj((*$2)[i], SWIGTYPE_p_semanage_bool, 0));
-	
-		$result = t_output_helper($result, plist);
-		free(*$2);
-	}
-}
-
-%typemap(in, numinputs=0) semanage_bool_t **(semanage_bool_t *temp) {
-	$1 = &temp;
-}
-
-%typemap(argout) semanage_bool_t ** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_bool, 0));
-}
-
-%typemap(argout) semanage_bool_key_t ** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_bool_key, 0));
-}
-
-%typemap(in, numinputs=0) semanage_bool_key_t **(semanage_bool_key_t *temp) {
-	$1 = &temp;
-}
-
-/** fcontext typemaps **/
-
-/* the wrapper will setup this parameter for passing... the resulting python functions
-   will not take the semanage_fcontext_t *** parameter */
-%typemap(in, numinputs=0) semanage_fcontext_t ***(semanage_fcontext_t **temp) {
-        $1 = &temp;
-}
-
-%typemap(argout) (
-	semanage_handle_t* handle,
-	semanage_fcontext_t*** records,
-	unsigned int* count) {
-
-	if (result >= 0) {
-		PyObject* plist = PyList_New(*$3);
-		unsigned int i;
-
-		for (i = 0; i < *$3; i++) 
-			PyList_SetItem(plist, i, SWIG_NewPointerObj((*$2)[i], SWIGTYPE_p_semanage_fcontext, 0));
-	
-		$result = t_output_helper($result, plist);
-		free(*$2);
-	}
-}
-
-%typemap(in, numinputs=0) semanage_fcontext_t **(semanage_fcontext_t *temp) {
-        $1 = &temp;
-}
-
-%typemap(argout) semanage_fcontext_t ** {
-        $result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_fcontext, 0));
-}
-
-%typemap(argout) semanage_fcontext_key_t ** {
-        $result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_fcontext_key, 0));
-}
-
-%typemap(in, numinputs=0) semanage_fcontext_key_t **(semanage_fcontext_key_t *temp) {
-        $1 = &temp;
-}
-
-/** interface typemaps **/
-
-/* the wrapper will setup this parameter for passing... the resulting python functions
-   will not take the semanage_iface_t *** parameter */
-%typemap(in, numinputs=0) semanage_iface_t ***(semanage_iface_t **temp) {
-	$1 = &temp;
-}
-
-%typemap(argout) (
-	semanage_handle_t* handle,
-	semanage_iface_t*** records,
-	unsigned int* count) {
-
-	if (result >= 0) {
-		PyObject* plist = PyList_New(*$3);
-		unsigned int i;
-
-		for (i = 0; i < *$3; i++) 
-			PyList_SetItem(plist, i, SWIG_NewPointerObj((*$2)[i], SWIGTYPE_p_semanage_iface, 0));
-	
-		$result = t_output_helper($result, plist);
-		free(*$2);
-	}
-}	
-
-%typemap(in, numinputs=0) semanage_iface_t **(semanage_iface_t *temp) {
-	$1 = &temp;
-}
-
-%typemap(argout) semanage_iface_t ** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_iface, 0));
-}
-
-%typemap(argout) semanage_iface_key_t ** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_iface_key, 0));
-}
-
-%typemap(in, numinputs=0) semanage_iface_key_t **(semanage_iface_key_t *temp) {
-	$1 = &temp;
-}
-
-/** seuser typemaps **/
-
-/* the wrapper will setup this parameter for passing... the resulting python functions
-   will not take the semanage_seuser_t *** parameter */
-%typemap(in, numinputs=0) semanage_seuser_t ***(semanage_seuser_t **temp) {
-	$1 = &temp;
-}
-
-%typemap(argout) (
-	semanage_handle_t* handle,
-	semanage_seuser_t*** records,
-	unsigned int* count) {
-
-	if (result >= 0) {
-		PyObject* plist = PyList_New(*$3);
-		unsigned int i;
-
-		for (i = 0; i < *$3; i++) 
-			PyList_SetItem(plist, i, SWIG_NewPointerObj((*$2)[i], SWIGTYPE_p_semanage_seuser, 0));
-	
-		$result = t_output_helper($result, plist);
-		free(*$2);
-	}
-}	
-
-%typemap(in, numinputs=0) semanage_seuser_t **(semanage_seuser_t *temp) {
-	$1 = &temp;
-}
-
-%typemap(argout) semanage_seuser_t ** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_seuser, 0));
-}
-
-%typemap(argout) semanage_seuser_key_t ** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_seuser_key, 0));
-}
-
-%typemap(in, numinputs=0) semanage_seuser_key_t **(semanage_seuser_key_t *temp) {
-	$1 = &temp;
-}
-
-/** user typemaps **/
-
-/* the wrapper will setup this parameter for passing... the resulting python functions
-   will not take the semanage_user_t *** parameter */
-%typemap(in, numinputs=0) semanage_user_t ***(semanage_user_t **temp) {
-	$1 = &temp;
-}
-
-%typemap(argout) (
-	semanage_handle_t* handle,
-	semanage_user_t*** records,
-	unsigned int* count) {
-
-	if (result >= 0) {
-		PyObject* plist = PyList_New(*$3);
-		unsigned int i;
-
-		for (i = 0; i < *$3; i++) 
-			PyList_SetItem(plist, i, SWIG_NewPointerObj((*$2)[i], SWIGTYPE_p_semanage_user, 0));
-	
-		$result = t_output_helper($result, plist);
-		free(*$2);
-	}
-}
-	
-%typemap(in, numinputs=0) semanage_user_t **(semanage_user_t *temp) {
-	$1 = &temp;
-}
-
-%typemap(argout) semanage_user_t ** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_user, 0));
-}
-
-%typemap(argout) semanage_user_key_t ** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_user_key, 0));
-}
-
-%typemap(in, numinputs=0) semanage_user_key_t **(semanage_user_key_t *temp) {
-	$1 = &temp;
-}
-
-/** port typemaps **/
-
-/* the wrapper will setup this parameter for passing... the resulting python functions
-   will not take the semanage_port_t *** parameter */
-%typemap(in, numinputs=0) semanage_port_t ***(semanage_port_t **temp) {
-	$1 = &temp;
-}
-
-%typemap(argout) (
-	semanage_handle_t* handle,
-	semanage_port_t*** records,
-	unsigned int* count) {
-
-	if (result >= 0) {
-		PyObject* plist = PyList_New(*$3);
-		unsigned int i;
-
-		for (i = 0; i < *$3; i++) 
-			PyList_SetItem(plist, i, SWIG_NewPointerObj((*$2)[i], SWIGTYPE_p_semanage_port, 0));
-	
-		$result = t_output_helper($result, plist);
-		free(*$2);
-	}
-}	
-
-%typemap(in, numinputs=0) semanage_port_t **(semanage_port_t *temp) {
-	$1 = &temp;
-}
-
-%typemap(argout) semanage_port_t ** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_port, 0));
-}
-
-%typemap(argout) semanage_port_key_t ** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_port_key, 0));
-}
-
-%typemap(in, numinputs=0) semanage_port_key_t **(semanage_port_key_t *temp) {
-	$1 = &temp;
-}
-
-/** node typemaps **/
-
-/* the wrapper will setup this parameter for passing... the resulting python functions
-   will not take the semanage_node_t *** parameter */
-%typemap(in, numinputs=0) semanage_node_t ***(semanage_node_t **temp) {
-	$1 = &temp;
-}
-
-%typemap(argout) (
-	semanage_handle_t* handle,
-	semanage_node_t*** records,
-	unsigned int* count) {
-
-	if (result >= 0) {
-		PyObject* plist = PyList_New(*$3);
-		unsigned int i;
-
-		for (i = 0; i < *$3; i++)
-			PyList_SetItem(plist, i, SWIG_NewPointerObj((*$2)[i], SWIGTYPE_p_semanage_node, 0));
-
-		$result = t_output_helper($result, plist);
-		free(*$2);
-	}
-}
-
-%typemap(in, numinputs=0) semanage_node_t **(semanage_node_t *temp) {
-	$1 = &temp;
-}
-
-%typemap(argout) semanage_node_t ** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_node, 0));
-}
-
-
-%typemap(argout) semanage_node_key_t ** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_node_key, 0));
-}
-
-%typemap(in, numinputs=0) semanage_node_key_t **(semanage_node_key_t *temp) {
-	$1 = &temp;
-}
-
 /* pull in the headers */
 %include "../include/semanage/debug.h"
 %include "../include/semanage/handle.h"
diff -Naurp --exclude-from excludes old/libsemanage/src/semanageswig_python.i new/libsemanage/src/semanageswig_python.i
--- old/libsemanage/src/semanageswig_python.i	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/semanageswig_python.i	2006-02-14 06:56:10.000000000 -0500
@@ -0,0 +1,366 @@
+/* Author: Spencer Shimko <sshimko@tresys.com>
+ *
+ * Copyright (C) 2004-2005 Tresys Technology, LLC
+ * Copyright (C) 2006 Red Hat, Inc
+ *  
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+/** standard typemaps **/
+
+/* a few helpful typemaps are available in this library */
+%include <typemaps.i>
+/* wrap all int*'s so they can be used for results 
+   if it becomes necessary to send in data this should be changed to INOUT */
+%apply int *OUTPUT { int * };
+%apply int *OUTPUT { size_t * };
+%apply int *OUTPUT { unsigned int * };
+
+%inline {
+	char *char_by_idx(char **list, int n) {
+		return list[n];
+	}
+}
+
+%typemap(in, numinputs=0) char **(char *temp) {
+	$1 = &temp;
+}
+
+%typemap(argout) char** {
+	$result = t_output_helper($result, SWIG_FromCharPtr(*$1));
+	free(*$1);
+}
+
+%typemap(in, numinputs=0) char ***(char **temp) {
+	$1 = &temp;
+}
+
+%typemap(argout) char*** {
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_p_char, 0));
+}
+
+/** module typemaps**/
+
+/* the wrapper will setup this parameter for passing... the resulting python functions
+   will not take the semanage_module_info_t ** parameter */
+%typemap(in, numinputs=0) semanage_module_info_t **(semanage_module_info_t *temp) {
+	$1 = &temp;
+}
+
+%typemap(argout) semanage_module_info_t ** {
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_module_info, 0));
+}
+
+/** context typemaps **/
+
+/* the wrapper will setup this parameter for passing... the resulting python functions
+   will not take the semanage_context_t ** parameter */
+%typemap(in, numinputs=0) semanage_context_t **(semanage_context_t *temp) {
+	$1 = &temp;
+}
+
+%typemap(argout) semanage_context_t** {
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_context, 0));
+}
+
+/** boolean typemaps **/
+
+/* the wrapper will setup this parameter for passing... the resulting python functions
+   will not take the semanage_bool_t *** parameter */
+%typemap(in, numinputs=0) semanage_bool_t ***(semanage_bool_t **temp) {
+	$1 = &temp;
+}
+
+%typemap(argout) (
+	semanage_handle_t* handle,
+	semanage_bool_t*** records,
+	unsigned int* count) {
+
+	if (result >= 0) {
+		PyObject* plist = PyList_New(*$3);
+		unsigned int i;
+
+		for (i = 0; i < *$3; i++) 
+			PyList_SetItem(plist, i, SWIG_NewPointerObj((*$2)[i], SWIGTYPE_p_semanage_bool, 0));
+	
+		$result = t_output_helper($result, plist);
+		free(*$2);
+	}
+}
+
+%typemap(in, numinputs=0) semanage_bool_t **(semanage_bool_t *temp) {
+	$1 = &temp;
+}
+
+%typemap(argout) semanage_bool_t ** {
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_bool, 0));
+}
+
+%typemap(argout) semanage_bool_key_t ** {
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_bool_key, 0));
+}
+
+%typemap(in, numinputs=0) semanage_bool_key_t **(semanage_bool_key_t *temp) {
+	$1 = &temp;
+}
+
+/** fcontext typemaps **/
+
+/* the wrapper will setup this parameter for passing... the resulting python functions
+   will not take the semanage_fcontext_t *** parameter */
+%typemap(in, numinputs=0) semanage_fcontext_t ***(semanage_fcontext_t **temp) {
+        $1 = &temp;
+}
+
+%typemap(argout) (
+	semanage_handle_t* handle,
+	semanage_fcontext_t*** records,
+	unsigned int* count) {
+
+	if (result >= 0) {
+		PyObject* plist = PyList_New(*$3);
+		unsigned int i;
+
+		for (i = 0; i < *$3; i++) 
+			PyList_SetItem(plist, i, SWIG_NewPointerObj((*$2)[i], SWIGTYPE_p_semanage_fcontext, 0));
+	
+		$result = t_output_helper($result, plist);
+		free(*$2);
+	}
+}
+
+%typemap(in, numinputs=0) semanage_fcontext_t **(semanage_fcontext_t *temp) {
+        $1 = &temp;
+}
+
+%typemap(argout) semanage_fcontext_t ** {
+        $result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_fcontext, 0));
+}
+
+%typemap(argout) semanage_fcontext_key_t ** {
+        $result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_fcontext_key, 0));
+}
+
+%typemap(in, numinputs=0) semanage_fcontext_key_t **(semanage_fcontext_key_t *temp) {
+        $1 = &temp;
+}
+
+/** interface typemaps **/
+
+/* the wrapper will setup this parameter for passing... the resulting python functions
+   will not take the semanage_iface_t *** parameter */
+%typemap(in, numinputs=0) semanage_iface_t ***(semanage_iface_t **temp) {
+	$1 = &temp;
+}
+
+%typemap(argout) (
+	semanage_handle_t* handle,
+	semanage_iface_t*** records,
+	unsigned int* count) {
+
+	if (result >= 0) {
+		PyObject* plist = PyList_New(*$3);
+		unsigned int i;
+
+		for (i = 0; i < *$3; i++) 
+			PyList_SetItem(plist, i, SWIG_NewPointerObj((*$2)[i], SWIGTYPE_p_semanage_iface, 0));
+	
+		$result = t_output_helper($result, plist);
+		free(*$2);
+	}
+}	
+
+%typemap(in, numinputs=0) semanage_iface_t **(semanage_iface_t *temp) {
+	$1 = &temp;
+}
+
+%typemap(argout) semanage_iface_t ** {
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_iface, 0));
+}
+
+%typemap(argout) semanage_iface_key_t ** {
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_iface_key, 0));
+}
+
+%typemap(in, numinputs=0) semanage_iface_key_t **(semanage_iface_key_t *temp) {
+	$1 = &temp;
+}
+
+/** seuser typemaps **/
+
+/* the wrapper will setup this parameter for passing... the resulting python functions
+   will not take the semanage_seuser_t *** parameter */
+%typemap(in, numinputs=0) semanage_seuser_t ***(semanage_seuser_t **temp) {
+	$1 = &temp;
+}
+
+%typemap(argout) (
+	semanage_handle_t* handle,
+	semanage_seuser_t*** records,
+	unsigned int* count) {
+
+	if (result >= 0) {
+		PyObject* plist = PyList_New(*$3);
+		unsigned int i;
+
+		for (i = 0; i < *$3; i++) 
+			PyList_SetItem(plist, i, SWIG_NewPointerObj((*$2)[i], SWIGTYPE_p_semanage_seuser, 0));
+	
+		$result = t_output_helper($result, plist);
+		free(*$2);
+	}
+}	
+
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
+/** user typemaps **/
+
+/* the wrapper will setup this parameter for passing... the resulting python functions
+   will not take the semanage_user_t *** parameter */
+%typemap(in, numinputs=0) semanage_user_t ***(semanage_user_t **temp) {
+	$1 = &temp;
+}
+
+%typemap(argout) (
+	semanage_handle_t* handle,
+	semanage_user_t*** records,
+	unsigned int* count) {
+
+	if (result >= 0) {
+		PyObject* plist = PyList_New(*$3);
+		unsigned int i;
+
+		for (i = 0; i < *$3; i++) 
+			PyList_SetItem(plist, i, SWIG_NewPointerObj((*$2)[i], SWIGTYPE_p_semanage_user, 0));
+	
+		$result = t_output_helper($result, plist);
+		free(*$2);
+	}
+}
+	
+%typemap(in, numinputs=0) semanage_user_t **(semanage_user_t *temp) {
+	$1 = &temp;
+}
+
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
+%typemap(in, numinputs=0) semanage_port_t ***(semanage_port_t **temp) {
+	$1 = &temp;
+}
+
+%typemap(argout) (
+	semanage_handle_t* handle,
+	semanage_port_t*** records,
+	unsigned int* count) {
+
+	if (result >= 0) {
+		PyObject* plist = PyList_New(*$3);
+		unsigned int i;
+
+		for (i = 0; i < *$3; i++) 
+			PyList_SetItem(plist, i, SWIG_NewPointerObj((*$2)[i], SWIGTYPE_p_semanage_port, 0));
+	
+		$result = t_output_helper($result, plist);
+		free(*$2);
+	}
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
+}
+
+%typemap(in, numinputs=0) semanage_port_key_t **(semanage_port_key_t *temp) {
+	$1 = &temp;
+}
+
+/** node typemaps **/
+
+/* the wrapper will setup this parameter for passing... the resulting python functions
+   will not take the semanage_node_t *** parameter */
+%typemap(in, numinputs=0) semanage_node_t ***(semanage_node_t **temp) {
+	$1 = &temp;
+}
+
+%typemap(argout) (
+	semanage_handle_t* handle,
+	semanage_node_t*** records,
+	unsigned int* count) {
+
+	if (result >= 0) {
+		PyObject* plist = PyList_New(*$3);
+		unsigned int i;
+
+		for (i = 0; i < *$3; i++)
+			PyList_SetItem(plist, i, SWIG_NewPointerObj((*$2)[i], SWIGTYPE_p_semanage_node, 0));
+
+		$result = t_output_helper($result, plist);
+		free(*$2);
+	}
+}
+
+%typemap(in, numinputs=0) semanage_node_t **(semanage_node_t *temp) {
+	$1 = &temp;
+}
+
+%typemap(argout) semanage_node_t ** {
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_node, 0));
+}
+
+
+%typemap(argout) semanage_node_key_t ** {
+	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_semanage_node_key, 0));
+}
+
+%typemap(in, numinputs=0) semanage_node_key_t **(semanage_node_key_t *temp) {
+	$1 = &temp;
+}
+
+%include "semanageswig.i"

--------------090909010605010304040009--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
