Message-ID: <43E26F62.7010400@cornell.edu>
Date: Thu, 02 Feb 2006 15:45:22 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: [SEMANAGE][UTILS] Use PyList in bindings
Content-Type: multipart/mixed;
 boundary="------------040800050703050902020008"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040800050703050902020008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Okay, this patch is being the subject of controversy on IRC, so I wanted 
to continue discussion on-list.

It's an API change in the python bindings only, which converts out-bound 
arrays of objects (port, iface, boolean, etc..) to a PyList, which makes 
them easier to work with, and better integrated with the target 
language. Also, it fixes memory leak of the list structure (otherwise we 
have to expose free() to address that). It eliminates the need for 
get_by_idx functions, which are not really part of the libsemanage API.

Some problems w/ patch - it relies on some internal swig things - like 
the output variable being called result (swig provides $result, but 
that's in python, and I don't want to unpack it). Not sure if that's a 
problem, I'm not sure this t_output_helper business is part of the 
official API either. Also, swig is not very intelligent, and wants all 
the argument names to match (despite the docs saying otherwise).

Joshua doesn't like it..says semanage.i should be portable to other 
languages. However, I like better integration w/ python, so I think in 
that case maybe it makes sense to have several .i files. Also, I'm not 
sure the .i file is language portable right now - what will happen in a 
language that doesn't support an output vector, so adding things to 
result w/ t_output_helper doesn't necessarily make sense?

Also, how do I implement a binding for set_roles()? I want to unpack a 
PyList into a char** array - requires understanding of python in the .i 
file.


--------------040800050703050902020008
Content-Type: text/x-patch;
 name="libsemanage.utils.pylist.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.utils.pylist.diff"

diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/booleans_policy.h new/libsemanage/include/semanage/booleans_policy.h
--- old/libsemanage/include/semanage/booleans_policy.h	2006-01-13 08:37:09.000000000 -0500
+++ new/libsemanage/include/semanage/booleans_policy.h	2006-02-02 14:13:37.000000000 -0500
@@ -30,6 +30,6 @@ extern int semanage_bool_iterate(
 extern int semanage_bool_list(
 	semanage_handle_t* handle,
 	semanage_bool_t*** records,
-	unsigned int* size);
+	unsigned int* count);
 
 #endif
diff -Naurp --exclude-from excludes old/libsemanage/src/pywrap-test.py new/libsemanage/src/pywrap-test.py
--- old/libsemanage/src/pywrap-test.py	2006-02-02 10:01:02.000000000 -0500
+++ new/libsemanage/src/pywrap-test.py	2006-02-02 14:58:04.000000000 -0500
@@ -114,7 +114,7 @@ class Tests:
 		print "Testing modules..."
 
 		(trans_cnt, mlist, mlist_size) = semanage.semanage_module_list(sh)
-		
+
 		print "Transaction number: ", trans_cnt
 		print "Module list size: ", mlist_size
 		if self.verbose: print "List reference: ", mlist
@@ -125,27 +125,23 @@ class Tests:
 			return
 		for idx in range(mlist_size):
 			module = semanage.semanage_module_list_nth(mlist, idx)
-			if self.verbose: print "Module reference: ", module 
+			if self.verbose: print "Module reference: ", module
 			print "Module name: ", semanage.semanage_module_get_name(module)
 			print "   Module version: ", semanage.semanage_module_get_version(module)
 
 	def test_seusers(self,sh):
 		print "Testing seusers..."
 
-		(status, slist, slist_size) = semanage.semanage_seuser_list(sh)
+		(status, slist) = semanage.semanage_seuser_list(sh)
 		if status < 0:
 			raise Error("Could not list seusers")
 		print "Query status (commit number): ", status
 
-		print "SEUser list size: ", slist_size
-		if self.verbose: print "List reference: ", slist
-
-		if (slist_size == 0):
+		if ( len(slist) == 0):
 			print "No seusers found!"
 			print "This is not necessarily a test failure."
 			return
-		for idx in range(slist_size):
-			seuser = semanage.semanage_seuser_by_idx(slist, idx)
+		for seuser in slist:
 			if self.verbose: print "seseuser reference: ", seuser 
 			print "seuser name: ", semanage.semanage_seuser_get_name(seuser)
 			print "   seuser mls range: ", semanage.semanage_seuser_get_mlsrange(seuser)
@@ -155,20 +151,16 @@ class Tests:
 	def test_users(self,sh):
 		print "Testing users..."
 
-		(status, ulist, ulist_size) = semanage.semanage_user_list(sh)
+		(status, ulist) = semanage.semanage_user_list(sh)
 		if status < 0:
 			raise Error("Could not list users")
 		print "Query status (commit number): ", status
 
-		print "User list size: ", ulist_size
-		if self.verbose: print "List reference: ", ulist
-
-		if (ulist_size == 0):
+		if ( len(ulist) == 0):
 			print "No users found!"
 			print "This is not necessarily a test failure."
 			return
-		for idx in range(ulist_size):
-			user = semanage.semanage_user_by_idx(ulist, idx)
+		for user in ulist:
 			if self.verbose: print "User reference: ", user 
 			print "User name: ", semanage.semanage_user_get_name(user)
 			print "   User labeling prefix: ", semanage.semanage_user_get_prefix(user)
@@ -187,20 +179,16 @@ class Tests:
 	def test_ports(self,sh):
 		print "Testing ports..."
 
-		(status, plist, plist_size) = semanage.semanage_port_list(sh)
+		(status, plist) = semanage.semanage_port_list(sh)
 		if status < 0:
 			raise Error("Could not list ports")
 		print "Query status (commit number): ", status
 
-		print "Port list size: ", plist_size
-		if self.verbose: print "List reference: ", plist
-
-		if (plist_size == 0):
+		if ( len(plist) == 0):
 			print "No ports found!"
 			print "This is not necessarily a test failure."
 			return
-		for idx in range(plist_size):
-			port = semanage.semanage_port_by_idx(plist, idx)
+		for port in plist:
 			if self.verbose: print "Port reference: ", port
 			low = semanage.semanage_port_get_low(port)
 			high = semanage.semanage_port_get_high(port)
@@ -219,20 +207,16 @@ class Tests:
 	def test_fcontexts(self,sh):
 		print "Testing file contexts..."
 
-		(status, flist, flist_size) = semanage.semanage_fcontext_list(sh)
+		(status, flist) = semanage.semanage_fcontext_list(sh)
 		if status < 0:
 			raise Error("Could not list file contexts")
 		print "Query status (commit number): ", status
 
-		print "File Context list size: ", flist_size
-		if self.verbose: print "List reference: ", flist
-
-		if (flist_size == 0):
+		if (len(flist) == 0):
 			print "No file contexts found!"
 			print "This is not necessarily a test failure."
 			return
-		for idx in range(flist_size):
-			fcon = semanage.semanage_fcontext_by_idx(flist, idx)
+		for fcon in flist:
 			if self.verbose: print "File Context reference: ", fcon
 			expr = semanage.semanage_fcontext_get_expr(fcon)
 			type = semanage.semanage_fcontext_get_type(fcon)
@@ -249,20 +233,16 @@ class Tests:
 	def test_interfaces(self,sh):
 		print "Testing network interfaces..."
 
-		(status, ilist, ilist_size) = semanage.semanage_iface_list(sh)
+		(status, ilist) = semanage.semanage_iface_list(sh)
 		if status < 0:
 			raise Error("Could not list interfaces")
 		print "Query status (commit number): ", status
 
-		print "Interfaces list size: ", ilist_size
-		if self.verbose: print "List reference: ", ilist
-
-		if (ilist_size == 0):
+		if (len(ilist) == 0):
 			print "No network interfaces found!"
 			print "This is not necessarily a test failure."
 			return
-		for idx in range(ilist_size):
-			iface = semanage.semanage_iface_by_idx(ilist, idx)
+		for iface in ilist:
 			if self.verbose: print "Interface reference: ", iface
 			name = semanage.semanage_iface_get_name(iface)
 			msg_con = semanage.semanage_iface_get_msgcon(iface)
@@ -277,20 +257,16 @@ class Tests:
 	def test_booleans(self,sh):
 		print "Testing booleans..."
 
-		(status, blist, blist_size) = semanage.semanage_bool_list(sh)
+		(status, blist) = semanage.semanage_bool_list(sh)
 		if status < 0:
 			raise Error("Could not list booleans")
 		print "Query status (commit number): ", status
 
-		print "Booleans list size: ", blist_size
-		if self.verbose: print "List reference: ", blist
-
-		if (blist_size == 0):
+		if (len(blist) == 0):
 			print "No booleans found!"
 			print "This is not necessarily a test failure."
 			return
-		for idx in range(blist_size):
-			pbool = semanage.semanage_bool_by_idx(blist, idx)
+		for pbool in blist:
 			if self.verbose: print "Boolean reference: ", pbool
 			name = semanage.semanage_bool_get_name(pbool)
 			value = semanage.semanage_bool_get_value(pbool)	
@@ -300,20 +276,16 @@ class Tests:
 	def test_abooleans(self,sh):
 		print "Testing active booleans..."
 
-		(status, ablist, ablist_size) = semanage.semanage_bool_list_active(sh)
+		(status, ablist) = semanage.semanage_bool_list_active(sh)
 		if status < 0:
 			raise Error("Could not list active booleans")
 		print "Query status (commit number): ", status
 
-		print "Active Booleans list size: ", ablist_size
-		if self.verbose: print "List reference: ", ablist
-
-		if (ablist_size == 0):
+		if (len(ablist) == 0):
                         print "No active booleans found!"
 			print "This is not necessarily a test failure."
 			return
-		for idx in range(ablist_size):
-			abool = semanage.semanage_bool_by_idx(ablist, idx)
+		for abool in ablist:
 			if self.verbose: print "Active boolean reference: ", abool
 			name = semanage.semanage_bool_get_name(abool)
 			value = semanage.semanage_bool_get_value(abool)
diff -Naurp --exclude-from excludes old/libsemanage/src/semanageswig.i new/libsemanage/src/semanageswig.i
--- old/libsemanage/src/semanageswig.i	2006-01-30 15:05:58.000000000 -0500
+++ new/libsemanage/src/semanageswig.i	2006-02-02 14:45:35.000000000 -0500
@@ -47,24 +47,6 @@
 %}
 
 %inline {
-	semanage_user_t *semanage_user_by_idx(semanage_user_t **list, int n) {
-		return list[n];
-	}	
-	semanage_seuser_t *semanage_seuser_by_idx(semanage_seuser_t **list, int n) {
-		return list[n];
-	}	
-	semanage_port_t *semanage_port_by_idx(semanage_port_t **list, int n) {
-		return list[n];
-	}
-	semanage_iface_t *semanage_iface_by_idx(semanage_iface_t **list, int n) {
-		return list[n];
-	}
-	semanage_bool_t *semanage_bool_by_idx(semanage_bool_t **list, int n) {
-		return list[n];
-	}
-	semanage_fcontext_t *semanage_fcontext_by_idx(semanage_fcontext_t **list, int n) {
-		return list[n];
-	}
 	char *char_by_idx(char **list, int n) {
 		return list[n];
 	}
@@ -129,8 +111,21 @@
 	$1 = &temp;
 }
 
-%typemap(argout) semanage_bool_t *** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_p_semanage_bool, 0));
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
 }
 
 %typemap(in, numinputs=0) semanage_bool_t **(semanage_bool_t *temp) {
@@ -157,8 +152,21 @@
         $1 = &temp;
 }
 
-%typemap(argout) semanage_fcontext_t *** {
-        $result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_p_semanage_fcontext, 0));
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
 }
 
 %typemap(in, numinputs=0) semanage_fcontext_t **(semanage_fcontext_t *temp) {
@@ -185,9 +193,22 @@
 	$1 = &temp;
 }
 
-%typemap(argout) semanage_iface_t *** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_p_semanage_iface, 0));
-}
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
 
 %typemap(in, numinputs=0) semanage_iface_t **(semanage_iface_t *temp) {
 	$1 = &temp;
@@ -213,9 +234,22 @@
 	$1 = &temp;
 }
 
-%typemap(argout) semanage_seuser_t *** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_p_semanage_seuser, 0));
-}
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
 
 %typemap(in, numinputs=0) semanage_seuser_t **(semanage_seuser_t *temp) {
 	$1 = &temp;
@@ -241,10 +275,23 @@
 	$1 = &temp;
 }
 
-%typemap(argout) semanage_user_t *** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_p_semanage_user, 0));
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
 }
-
+	
 %typemap(in, numinputs=0) semanage_user_t **(semanage_user_t *temp) {
 	$1 = &temp;
 }
@@ -269,9 +316,22 @@
 	$1 = &temp;
 }
 
-%typemap(argout) semanage_port_t *** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_p_semanage_port, 0));
-}
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
 
 %typemap(in, numinputs=0) semanage_port_t **(semanage_port_t *temp) {
 	$1 = &temp;
diff -Naurp --exclude-from excludes old/policycoreutils/scripts/genhomedircon new/policycoreutils/scripts/genhomedircon
--- old/policycoreutils/scripts/genhomedircon	2006-01-30 15:29:09.000000000 -0500
+++ new/policycoreutils/scripts/genhomedircon	2006-02-02 15:16:20.000000000 -0500
@@ -135,7 +135,7 @@ class selinuxConfig:
 		self.semanaged=semanage_is_managed(self.semanageHandle)
 		if self.semanaged:
 			semanage_connect(self.semanageHandle)
-			(status, self.ulist, self.usize) = semanage_user_list(self.semanageHandle)
+			(status, self.ulist) = semanage_user_list(self.semanageHandle)
 		self.type=type
 		self.selinuxdir=selinuxdir +"/"
 		self.contextdir="/contexts"
@@ -176,8 +176,7 @@ class selinuxConfig:
 		return ret
 
 	def defaultrole(self, name):
-		for idx in range(self.usize):
-			user = semanage_user_by_idx(self.ulist, idx)
+		for user in self.ulist:
 			if semanage_user_get_name(user) == name:
 				if name == "staff_u" or name == "root" and self.type != "targeted":
 					return "staff_r"
@@ -224,10 +223,9 @@ class selinuxConfig:
 	def getUsers(self):
 		udict = {}
 		if self.semanaged:
-			(status, list, lsize) = semanage_seuser_list(self.semanageHandle)
-			for idx in range(lsize):
+			(status, list) = semanage_seuser_list(self.semanageHandle)
+			for seuser in list:
 				user=[]
-				seuser = semanage_seuser_by_idx(list, idx)
 				seusername=semanage_seuser_get_sename(seuser)
 				self.adduser(udict, semanage_seuser_get_name(seuser), seusername, self.defaultrole(seusername))
 				
diff -Naurp --exclude-from excludes old/policycoreutils/semanage/seobject.py new/policycoreutils/semanage/seobject.py
--- old/policycoreutils/semanage/seobject.py	2006-02-02 10:01:02.000000000 -0500
+++ new/policycoreutils/semanage/seobject.py	2006-02-02 15:03:34.000000000 -0500
@@ -288,12 +288,11 @@ class loginRecords(semanageRecords):
 		
 	def get_all(self):
 		ddict={}
-		(rc, self.ulist, self.usize) = semanage_seuser_list(self.sh)
+		(rc, self.ulist) = semanage_seuser_list(self.sh)
 		if rc < 0:
 			raise ValueError("Could not list login mappings")
 
-		for idx in range(self.usize):
-			u = semanage_seuser_by_idx(self.ulist, idx)
+		for u in self.ulist:
 			name = semanage_seuser_get_name(u)
 			ddict[name]=(semanage_seuser_get_sename(u), semanage_seuser_get_mlsrange(u))
 		return ddict
@@ -447,12 +446,11 @@ class seluserRecords(semanageRecords):
 
 	def get_all(self):
 		ddict={}
-		(rc, self.ulist, self.usize) = semanage_user_list(self.sh)
+		(rc, self.ulist) = semanage_user_list(self.sh)
 		if rc < 0:
 			raise ValueError("Could not list SELinux users")
 
-		for idx in range(self.usize):
-			u = semanage_user_by_idx(self.ulist, idx)
+		for u in self.ulist:
 			name = semanage_user_get_name(u)
 			(rc, rlist, rlist_size) = semanage_user_get_roles(self.sh, u)
 			if rc < 0:
@@ -637,12 +635,11 @@ class portRecords(semanageRecords):
 
 	def get_all(self):
 		ddict={}
-		(rc, self.plist, self.psize) = semanage_port_list(self.sh)
+		(rc, self.plist) = semanage_port_list(self.sh)
 		if rc < 0:
 			raise ValueError("Could not list ports")
 
-		for idx in range(self.psize):
-			port = semanage_port_by_idx(self.plist, idx)
+		for port in self.plist:
 			con = semanage_port_get_con(port)
 			ctype = semanage_context_get_type(con)
 			if ctype == "reserved_port_t":
@@ -657,12 +654,11 @@ class portRecords(semanageRecords):
 
 	def get_all_by_type(self):
 		ddict={}
-		(rc, self.plist, self.psize) = semanage_port_list(self.sh)
+		(rc, self.plist) = semanage_port_list(self.sh)
 		if rc < 0:
 			raise ValueError("Could not list ports")
 
-		for idx in range(self.psize):
-			port = semanage_port_by_idx(self.plist, idx)
+		for port in self.plist:
 			con = semanage_port_get_con(port)
 			ctype = semanage_context_get_type(con)
 			if ctype == "reserved_port_t":
@@ -837,12 +833,11 @@ class interfaceRecords(semanageRecords):
 
 	def get_all(self):
 		ddict={}
-		(rc, self.plist, self.psize) = semanage_iface_list(self.sh)
+		(rc, self.ilist) = semanage_iface_list(self.sh)
 		if rc < 0:
 			raise ValueError("Could not list interfaces")
 
-		for idx in range(self.psize):
-			interface = semanage_iface_by_idx(self.plist, idx)
+		for interface in self.ilist:
 			con = semanage_iface_get_ifcon(interface)
 			ddict[semanage_iface_get_name(interface)]=(semanage_context_get_user(con), semanage_context_get_role(con), semanage_context_get_type(con), semanage_context_get_mls(con))
 
@@ -1022,12 +1017,11 @@ class fcontextRecords(semanageRecords):
 
 	def get_all(self):
 		ddict={}
-		(rc, self.plist, self.psize) = semanage_fcontext_list(self.sh)
+		(rc, self.flist) = semanage_fcontext_list(self.sh)
 		if rc < 0:
 			raise ValueError("Could not list file contexts")
 
-		for idx in range(self.psize):
-			fcontext = semanage_fcontext_by_idx(self.plist, idx)
+		for fcontext in self.flist:
 			expr = semanage_fcontext_get_expr(fcontext)
 			ftype = semanage_fcontext_get_type(fcontext)
 			ftype_str = semanage_fcontext_get_type_str(ftype)
@@ -1124,12 +1118,11 @@ class booleanRecords(semanageRecords):
 
 	def get_all(self):
 		ddict={}
-		(rc, self.blist, self.bsize) = semanage_bool_list(self.sh)
+		(rc, self.blist) = semanage_bool_list(self.sh)
 		if rc < 0:
 			raise ValueError("Could not list booleans")
 
-		for idx in range(self.bsize):
-			boolean = semanage_bool_by_idx(self.blist, idx)
+		for boolean in self.blist:
 			name = semanage_bool_get_name(boolean)
 			value = semanage_bool_get_value(boolean)
 			ddict[name] = value

--------------040800050703050902020008--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
