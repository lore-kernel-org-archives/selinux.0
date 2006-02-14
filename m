Message-ID: <43F1B827.401@cornell.edu>
Date: Tue, 14 Feb 2006 05:59:51 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEMANAGE][UTILS] Use PyList in bindings
References: <43E26F62.7010400@cornell.edu>
In-Reply-To: <43E26F62.7010400@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------020109000604030807040902"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020109000604030807040902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Attached is a resync of this patch against current genhomedircon.


--------------020109000604030807040902
Content-Type: text/x-patch;
 name="libsemanage.utils.pylist2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.utils.pylist2.diff"

diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/booleans_policy.h new/libsemanage/include/semanage/booleans_policy.h
--- old/libsemanage/include/semanage/booleans_policy.h	2006-02-14 05:41:35.000000000 -0500
+++ new/libsemanage/include/semanage/booleans_policy.h	2006-02-02 14:13:37.000000000 -0500
@@ -30,6 +30,6 @@ extern int semanage_bool_iterate(
 extern int semanage_bool_list(
 	semanage_handle_t* handle,
 	semanage_bool_t*** records,
-	unsigned int* size);
+	unsigned int* count);
 
 #endif
diff -Naurp --exclude-from excludes old/libsemanage/src/pywrap-test.py new/libsemanage/src/pywrap-test.py
--- old/libsemanage/src/pywrap-test.py	2006-02-14 05:41:35.000000000 -0500
+++ new/libsemanage/src/pywrap-test.py	2006-02-05 01:30:04.000000000 -0500
@@ -124,7 +124,7 @@ class Tests:
 		print "Testing modules..."
 
 		(trans_cnt, mlist, mlist_size) = semanage.semanage_module_list(sh)
-		
+
 		print "Transaction number: ", trans_cnt
 		print "Module list size: ", mlist_size
 		if self.verbose: print "List reference: ", mlist
@@ -135,27 +135,23 @@ class Tests:
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
@@ -165,20 +161,16 @@ class Tests:
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
@@ -197,20 +189,16 @@ class Tests:
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
@@ -229,20 +217,16 @@ class Tests:
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
@@ -259,20 +243,16 @@ class Tests:
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
@@ -287,20 +267,16 @@ class Tests:
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
@@ -310,20 +286,16 @@ class Tests:
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
--- old/libsemanage/src/semanageswig.i	2006-02-14 05:41:35.000000000 -0500
+++ new/libsemanage/src/semanageswig.i	2006-02-03 20:59:05.000000000 -0500
@@ -50,24 +50,6 @@
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
@@ -133,8 +115,21 @@
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
@@ -161,8 +156,21 @@
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
@@ -189,9 +197,22 @@
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
@@ -217,9 +238,22 @@
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
@@ -245,10 +279,23 @@
 	$1 = &temp;
 }
 
-%typemap(argout) semanage_user_t *** {
-	$result = t_output_helper($result, SWIG_NewPointerObj(*$1, SWIGTYPE_p_p_semanage_user, 0));
-}
+%typemap(argout) (
+	semanage_handle_t* handle,
+	semanage_user_t*** records,
+	unsigned int* count) {
 
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
 %typemap(in, numinputs=0) semanage_user_t **(semanage_user_t *temp) {
 	$1 = &temp;
 }
@@ -273,9 +320,22 @@
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
--- old/policycoreutils/scripts/genhomedircon	2006-02-14 05:42:08.000000000 -0500
+++ new/policycoreutils/scripts/genhomedircon	2006-02-14 05:57:04.000000000 -0500
@@ -133,7 +133,7 @@ class selinuxConfig:
 		self.semanaged=semanage_is_managed(self.semanageHandle)
 		if self.semanaged:
 			semanage_connect(self.semanageHandle)
-			(status, self.ulist, self.usize) = semanage_user_list(self.semanageHandle)
+			(status, self.ulist) = semanage_user_list(self.semanageHandle)
 		self.type=type
 		self.selinuxdir=selinuxdir +"/"
 		self.contextdir="/contexts"
@@ -174,11 +174,11 @@ class selinuxConfig:
 		return ret
 
 	def get_default_prefix(self, name):
-		for idx in range(self.usize):
-			user = semanage_user_by_idx(self.ulist, idx)
+		for user in self.ulist:
 			if semanage_user_get_name(user) == name:
 				return semanage_user_get_prefix(user)
 		return name
+
 	def get_old_prefix(self, user):
 		rc=grep(self.selinuxdir+self.type+"/users/system.users", "^user %s" % user)
 		if rc == "":					    
@@ -219,10 +219,9 @@ class selinuxConfig:
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
 				self.adduser(udict, semanage_seuser_get_name(seuser), seusername, self.get_default_prefix(seusername))
 				
diff -Naurp --exclude-from excludes old/policycoreutils/semanage/seobject.py new/policycoreutils/semanage/seobject.py
--- old/policycoreutils/semanage/seobject.py	2006-02-14 05:41:35.000000000 -0500
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

--------------020109000604030807040902--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
