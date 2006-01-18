Message-ID: <43CE13D2.2090402@cornell.edu>
Date: Wed, 18 Jan 2006 03:09:22 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Improve tests
Content-Type: multipart/mixed;
 boundary="------------080208090505060103050508"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080208090505060103050508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changelog:
- audit all status values, and throw Error on them.
Strangely this doesn't reduce the valgrind error kind at all, but it's 
still the right thing to do.

- add free() calls in a number of places, and more importantly, add 
disconnect() and handle_destroy().

- stop shadowing builtin variables, and call Exception.__init__ to quiet 
down pychecker.

before:
==25927== ERROR SUMMARY: 68203 errors from 128 contexts (suppressed: 38 
from 1)
==25927== malloc/free: in use at exit: 1,831,661 bytes in 25,765 blocks.
==25927== malloc/free: 6,942,006 allocs, 6,916,241 frees, 153,432,895 
bytes allocated.
==25927== For counts of detected errors, rerun with: -v
==25927== searching for pointers to 25,765 not-freed blocks.
==25927== checked 1,611,584 bytes.

after:
==26453== ERROR SUMMARY: 68249 errors from 127 contexts (suppressed: 38 
from 1)
==26453== malloc/free: in use at exit: 1,799,439 bytes in 1,755 blocks.
==26453== malloc/free: 6,941,962 allocs, 6,940,207 frees, 153,643,269 
bytes allocated.
==26453== For counts of detected errors, rerun with: -v
==26453== searching for pointers to 1,755 not-freed blocks.
==26453== checked 1,547,696 bytes.

Yeah, it's not much of a change, but it's a start. I see the number of 
blocks in use went down significantly, and that seems like a good 
thing.  On the other hand the number of errors actually went up, and I 
have no idea why..
Maybe 68249 errors later pywrap-test.py will be valgrind-able... :)



--------------080208090505060103050508
Content-Type: text/x-patch;
 name="libsemanage.pywrap_update.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.pywrap_update.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/pywrap-test.py new/libsemanage/src/pywrap-test.py
--- old/libsemanage/src/pywrap-test.py	2006-01-17 11:17:09.000000000 -0700
+++ new/libsemanage/src/pywrap-test.py	2006-01-18 02:47:51.000000000 -0700
@@ -27,10 +27,17 @@ Other options:\n\
 
 class Usage(Exception):
 	def __init__(self, msg):
+		Exception.__init__(self)
         	self.msg = msg
 
 class Status(Exception):
 	def __init__(self, msg):
+		Exception.__init__(self)
+		self.msg = msg
+
+class Error(Exception):
+	def __init__(self, msg):
+		Exception.__init__(self)
 		self.msg = msg
 
 class Tests:
@@ -105,55 +112,63 @@ class Tests:
 
 	def test_modules(self,sh):
 		print "Testing modules..."
-		(trans_cnt, list, list_size) = semanage.semanage_module_list(sh)
+
+		(trans_cnt, mlist, mlist_size) = semanage.semanage_module_list(sh)
 		
 		print "Transaction number: ", trans_cnt
-		print "Module list size: ", list_size
-		if self.verbose: print "List reference: ",  list
+		print "Module list size: ", mlist_size
+		if self.verbose: print "List reference: ", mlist
 
-		if (list_size == 0):
+		if (mlist_size == 0):
 			print "No modules installed!"
 			print "This is not necessarily a test failure."
 			return
-		for idx in range(list_size):
-			module = semanage.semanage_module_list_nth(list, idx)
+		for idx in range(mlist_size):
+			module = semanage.semanage_module_list_nth(mlist, idx)
 			if self.verbose: print "Module reference: ", module 
 			print "Module name: ", semanage.semanage_module_get_name(module)
 			print "   Module version: ", semanage.semanage_module_get_version(module)
 
 	def test_seusers(self,sh):
 		print "Testing seusers..."
-		(status, list, list_size) = semanage.semanage_seuser_list(sh)
 
+		(status, slist, slist_size) = semanage.semanage_seuser_list(sh)
+		if status < 0:
+			raise Error("Could not list seusers")
 		print "Query status (commit number): ", status
-		print "SEUser list size: ", list_size
-		if self.verbose: print "List reference: ",  list
 
-		if (list_size == 0):
+		print "SEUser list size: ", slist_size
+		if self.verbose: print "List reference: ", slist
+
+		if (slist_size == 0):
 			print "No seusers found!"
 			print "This is not necessarily a test failure."
 			return
-		for idx in range(list_size):
-			seuser = semanage.semanage_seuser_by_idx(list, idx)
+		for idx in range(slist_size):
+			seuser = semanage.semanage_seuser_by_idx(slist, idx)
 			if self.verbose: print "seseuser reference: ", seuser 
 			print "seuser name: ", semanage.semanage_seuser_get_name(seuser)
 			print "   seuser mls range: ", semanage.semanage_seuser_get_mlsrange(seuser)
 			print "   seuser sename: ", semanage.semanage_seuser_get_sename(seuser)
-		
+			semanage.semanage_seuser_free(seuser)		
+
 	def test_users(self,sh):
 		print "Testing users..."
-		(status, list, list_size) = semanage.semanage_user_list(sh)
 
+		(status, ulist, ulist_size) = semanage.semanage_user_list(sh)
+		if status < 0:
+			raise Error("Could not list users")
 		print "Query status (commit number): ", status
-		print "User list size: ", list_size
-		if self.verbose: print "List reference: ",  list
 
-		if (list_size == 0):
+		print "User list size: ", ulist_size
+		if self.verbose: print "List reference: ", ulist
+
+		if (ulist_size == 0):
 			print "No users found!"
 			print "This is not necessarily a test failure."
 			return
-		for idx in range(list_size):
-			user = semanage.semanage_user_by_idx(list, idx)
+		for idx in range(ulist_size):
+			user = semanage.semanage_user_by_idx(ulist, idx)
 			if self.verbose: print "User reference: ", user 
 			print "User name: ", semanage.semanage_user_get_name(user)
 			print "   User labeling prefix: ", semanage.semanage_user_get_prefix(user)
@@ -162,23 +177,30 @@ class Tests:
 			print "   User number of roles: ", semanage.semanage_user_get_num_roles(user)
 			print "   User roles: "
 			(status, rlist, rlist_size) = semanage.semanage_user_get_roles(sh, user)
+			if status < 0:
+				raise Error("Could not get user roles")
+
 			for ridx in range (rlist_size):
-				print "      ", semanage.char_by_idx(rlist, ridx) 
+				print "      ", semanage.char_by_idx(rlist, ridx)
+			semanage.semanage_user_free(user)
 
 	def test_ports(self,sh):
 		print "Testing ports..."
-		(status, list, list_size) = semanage.semanage_port_list(sh)
-		
+
+		(status, plist, plist_size) = semanage.semanage_port_list(sh)
+		if status < 0:
+			raise Error("Could not list ports")
 		print "Query status (commit number): ", status
-		print "Port list size: ", list_size
-		if self.verbose: print "List reference: ",  list
 
-		if (list_size == 0):
+		print "Port list size: ", plist_size
+		if self.verbose: print "List reference: ", plist
+
+		if (plist_size == 0):
 			print "No ports found!"
 			print "This is not necessarily a test failure."
 			return
-		for idx in range(list_size):
-			port = semanage.semanage_port_by_idx(list, idx)
+		for idx in range(plist_size):
+			port = semanage.semanage_port_by_idx(plist, idx)
 			if self.verbose: print "Port reference: ", port
 			low = semanage.semanage_port_get_low(port)
 			high = semanage.semanage_port_get_high(port)
@@ -191,21 +213,25 @@ class Tests:
 			(rc, con_str) = semanage.semanage_context_to_string(sh,con)
 			if rc < 0: con_str = ""
 			print "Port: ", range_str, " ", proto_str, " Context: ", con_str
+			semanage.semanage_port_free(port)
 
 	def test_fcontexts(self,sh):
 		print "Testing file contexts..."
-		(status, list, list_size) = semanage.semanage_fcontext_list(sh)
 
+		(status, flist, flist_size) = semanage.semanage_fcontext_list(sh)
+		if status < 0:
+			raise Error("Could not list file contexts")
 		print "Query status (commit number): ", status
-		print "File Context list size: ", list_size
-		if self.verbose: print "List reference: ",  list
 
-		if (list_size == 0):
+		print "File Context list size: ", flist_size
+		if self.verbose: print "List reference: ", flist
+
+		if (flist_size == 0):
 			print "No file contexts found!"
 			print "This is not necessarily a test failure."
 			return
-		for idx in range(list_size):
-			fcon = semanage.semanage_fcontext_by_idx(list, idx)
+		for idx in range(flist_size):
+			fcon = semanage.semanage_fcontext_by_idx(flist, idx)
 			if self.verbose: print "File Context reference: ", fcon
 			expr = semanage.semanage_fcontext_get_expr(fcon)
 			type_str = semanage.semanage_fcontext_get_type_str(fcon)
@@ -216,21 +242,25 @@ class Tests:
 				(rc, con_str) = semanage.semanage_context_to_string(sh,con)
 				if rc < 0: con_str = ""
 			print "File Expr: ", expr, " [", type_str, "] Context: ", con_str
+			semanage.semanage_fcontext_free(fcon)
 
 	def test_interfaces(self,sh):
 		print "Testing network interfaces..."
-		(status, list, list_size) = semanage.semanage_iface_list(sh)
 
+		(status, ilist, ilist_size) = semanage.semanage_iface_list(sh)
+		if status < 0:
+			raise Error("Could not list interfaces")
 		print "Query status (commit number): ", status
-		print "Interfaces list size: ", list_size
-		if self.verbose: print "List reference: ", list
 
-		if (list_size == 0):
+		print "Interfaces list size: ", ilist_size
+		if self.verbose: print "List reference: ", ilist
+
+		if (ilist_size == 0):
 			print "No network interfaces found!"
 			print "This is not necessarily a test failure."
 			return
-		for idx in range(list_size):
-			iface = semanage.semanage_iface_by_idx(list, idx)
+		for idx in range(ilist_size):
+			iface = semanage.semanage_iface_by_idx(ilist, idx)
 			if self.verbose: print "Interface reference: ", iface
 			name = semanage.semanage_iface_get_name(iface)
 			msg_con = semanage.semanage_iface_get_msgcon(iface)
@@ -240,138 +270,227 @@ class Tests:
 			(rc, if_con_str) = semanage.semanage_context_to_string(sh, if_con)
 			if rc < 0: if_con_str = ""
 			print "Interface: ", name, " Context: ", if_con_str, " Message Context: ", msg_con_str
+			semanage.semanage_iface_free(iface)
 
 	def test_booleans(self,sh):
 		print "Testing booleans..."
-		(status, list, list_size) = semanage.semanage_bool_list(sh)
 
+		(status, blist, blist_size) = semanage.semanage_bool_list(sh)
+		if status < 0:
+			raise Error("Could not list booleans")
 		print "Query status (commit number): ", status
-		print "Booleans list size: ", list_size
-		if self.verbose: print "List reference: ", list
 
-		if (list_size == 0):
+		print "Booleans list size: ", blist_size
+		if self.verbose: print "List reference: ", blist
+
+		if (blist_size == 0):
 			print "No booleans found!"
 			print "This is not necessarily a test failure."
 			return
-		for idx in range(list_size):
-			bool = semanage.semanage_bool_by_idx(list, idx)
-			if self.verbose: print "Boolean reference: ", bool
-			name = semanage.semanage_bool_get_name(bool)
-			value = semanage.semanage_bool_get_value(bool)	
+		for idx in range(blist_size):
+			pbool = semanage.semanage_bool_by_idx(blist, idx)
+			if self.verbose: print "Boolean reference: ", pbool
+			name = semanage.semanage_bool_get_name(pbool)
+			value = semanage.semanage_bool_get_value(pbool)	
 			print "Boolean: ", name, " Value: ", value
+			semanage.semanage_bool_free(pbool)
 
 	def test_abooleans(self,sh):
 		print "Testing active booleans..."
-		(status, list, list_size) = semanage.semanage_bool_list_active(sh)
 
+		(status, ablist, ablist_size) = semanage.semanage_bool_list_active(sh)
+		if status < 0:
+			raise Error("Could not list active booleans")
 		print "Query status (commit number): ", status
-		print "Active Booleans list size: ", list_size
-		if self.verbose: print "List reference: ", list
 
-		if (list_size == 0):
+		print "Active Booleans list size: ", ablist_size
+		if self.verbose: print "List reference: ", ablist
+
+		if (ablist_size == 0):
                         print "No active booleans found!"
 			print "This is not necessarily a test failure."
 			return
-		for idx in range(list_size):
-			abool = semanage.semanage_bool_by_idx(list, idx)
+		for idx in range(ablist_size):
+			abool = semanage.semanage_bool_by_idx(ablist, idx)
 			if self.verbose: print "Active boolean reference: ", abool
 			name = semanage.semanage_bool_get_name(abool)
 			value = semanage.semanage_bool_get_value(abool)
 			print "Active Boolean: ", name, " Value: ", value
+			semanage.semanage_bool_free(abool)
 
 	def test_writeuser(self,sh):
-                print "Testing user write..."
-                
+		print "Testing user write..."
+
 		(status, user) = semanage.semanage_user_create(sh)
-                if self.verbose: print "User object created."
+		if status < 0:
+			raise Error("Could not create user object")
+		if self.verbose: print "User object created"
 
 		status = semanage.semanage_user_set_name(sh,user, "testPyUser")
-               	if self.verbose: print "User name set: ", semanage.semanage_user_get_name(user)
+		if status < 0:
+			raise Error("Could not set user name")
+		if self.verbose: print "User name set: ", semanage.semanage_user_get_name(user)
                 
 		status = semanage.semanage_user_add_role(sh, user, "user_r")	
+		if status < 0:
+			raise Error("Could not add role")
 
 		status = semanage.semanage_user_set_prefix(sh,user, "user")
+		if status < 0:
+			raise Error("Could not set labeling prefix")
 		if self.verbose: print "User prefix set: ", semanage.semanage_user_get_prefix(user)
 	
 		status = semanage.semanage_user_set_mlsrange(sh, user, "s0")
-                if self.verbose: print "User mlsrange: ", semanage.semanage_user_get_mlsrange(user)
+		if status < 0:
+			raise Error("Could not set MLS range")
+		if self.verbose: print "User mlsrange: ", semanage.semanage_user_get_mlsrange(user)
 
 		status = semanage.semanage_user_set_mlslevel(sh, user, "s0")
-                if self.verbose: print "User mlslevel: ", semanage.semanage_user_get_mlslevel(user)
+		if status < 0:
+			raise Error("Could not set MLS level")
+		if self.verbose: print "User mlslevel: ", semanage.semanage_user_get_mlslevel(user)
                 
 		(status,key) = semanage.semanage_user_key_extract(sh,user)
-                if self.verbose: print "User key extracted: ", key
+		if status < 0:
+			raise Error("Could not extract user key")
+		if self.verbose: print "User key extracted: ", key
 	
 		(status,exists) = semanage.semanage_user_exists_local(sh,key)
+		if status < 0:
+			raise Error("Could not check if user exists")
 		if self.verbose: print "Exists status (commit number): ", status
+
 		if exists: 
 			(status, old_user) = semanage.semanage_user_query_local(sh, key)
+			if status < 0:
+				raise Error("Could not query old user")
 			if self.verbose: print "Query status (commit number): ", status
 
-		print "Starting transaction..."
-                status = semanage.semanage_begin_transaction(sh)
-                status = semanage.semanage_user_modify_local(sh,key,user)
-                status = semanage.semanage_commit(sh)
-                print "Commit status (transaction number): ", status
+		print "Starting transaction.."
+		status = semanage.semanage_begin_transaction(sh)
+		if status < 0:
+			raise Error("Could not start semanage transaction")
+
+		status = semanage.semanage_user_modify_local(sh,key,user)
+		if status < 0:
+			raise Error("Could not modify user")
+
+		status = semanage.semanage_commit(sh)
+		if status < 0:
+			raise Error("Could not commit test transaction")
+		print "Commit status (transaction number): ", status
 
 		status = semanage.semanage_begin_transaction(sh)
+		if status < 0:
+			raise Error("Could not start semanage transaction")
+ 
 		if not exists:
 			print "Removing user..."
 			status = semanage.semanage_user_del_local(sh, key)
-                	if self.verbose: print "User delete: ", status
+			if status < 0:
+				raise Error("Could not delete test user")
+			if self.verbose: print "User delete: ", status
 		else:
 			print "Resetting user..."
 			status = semanage.semanage_user_modify_local(sh, key, old_user)
+			if status < 0:
+				raise Error("Could not reset test user")
 			if self.verbose: print "User modify: ", status
+
 		status = semanage.semanage_commit(sh)
+		if status < 0:
+			raise Error("Could not commit reset transaction")
 		print "Commit status (transaction number): ", status
 
+		semanage.semanage_user_key_free(key)
+		semanage.semanage_user_free(user)
+		if exists: semanage.semanage_user_free(old_user)
+
 	def test_writeseuser(self,sh):
                 print "Testing seuser write..."
                 
 		(status, seuser) = semanage.semanage_seuser_create(sh)
-                if self.verbose: print "SEUser object created."
+		if status < 0:
+			raise Error("Could not create SEUser object")
+		if self.verbose: print "SEUser object created."
 
 		status = semanage.semanage_seuser_set_name(sh,seuser, "testPySEUser")
-               	if self.verbose: print "SEUser name set: ", semanage.semanage_seuser_get_name(seuser)
+		if status < 0:
+			raise Error("Could not set name")
+		if self.verbose: print "SEUser name set: ", semanage.semanage_seuser_get_name(seuser)
                 
 		status = semanage.semanage_seuser_set_sename(sh, seuser, "root")
+		if status < 0:
+			raise Error("Could not set sename")
                 if self.verbose: print "SEUser seuser: ", semanage.semanage_seuser_get_sename(seuser)
 		
 		status = semanage.semanage_seuser_set_mlsrange(sh, seuser, "s0:c0.c255")
+		if status < 0:
+			raise Error("Could not set MLS range")
                 if self.verbose: print "SEUser mlsrange: ", semanage.semanage_seuser_get_mlsrange(seuser)
                 
 		(status,key) = semanage.semanage_seuser_key_extract(sh,seuser)
+		if status < 0:
+			raise Error("Could not extract SEUser key")
                 if self.verbose: print "SEUser key extracted: ", key
 	
                 (status,exists) = semanage.semanage_seuser_exists(sh,key)
+		if status < 0:
+			raise Error("Could not check if SEUser exists")
 		if self.verbose: print "Exists status (commit number): ", status
+
 		if exists:
 			(status, old_seuser) = semanage.semanage_seuser_query(sh, key)
+			if status < 0:
+				raise Error("Could not query old SEUser")
 			if self.verbose: print "Query status (commit number): ", status
 
 		print "Starting transaction..."
-                status = semanage.semanage_begin_transaction(sh)
-                status = semanage.semanage_seuser_modify(sh,key,seuser)
-                status = semanage.semanage_commit(sh)
+		status = semanage.semanage_begin_transaction(sh)
+		if status < 0:
+			raise Error("Could not start semanage transaction")
+
+		status = semanage.semanage_seuser_modify(sh,key,seuser)
+		if status < 0:
+			raise Error("Could not modify SEUser")
+
+		status = semanage.semanage_commit(sh)
+		if status < 0:
+			raise Error("Could not commit test transaction")
                 print "Commit status (transaction number): ", status
 
 		status = semanage.semanage_begin_transaction(sh)
+		if status < 0:
+			raise Error("Could not start semanage transaction")
+
 		if not exists:
 			print "Removing seuser..."
 			status = semanage.semanage_seuser_del(sh, key)
+			if status < 0:
+				raise Error("Could not delete test SEUser")
 			if self.verbose: print "Seuser delete: ", status
 		else:
 			print "Resetting seuser..."
 			status = semanage.semanage_seuser_modify(sh, key, old_seuser)
+			if status < 0:
+				raise Error("Could not reset test SEUser")
 			if self.verbose: print "Seuser modify: ", status
+
                 status = semanage.semanage_commit(sh)
+		if status < 0:
+			raise Error("Could not commit reset transaction")
                 print "Commit status (transaction number): ", status
 
+		semanage.semanage_seuser_key_free(key)
+		semanage.semanage_seuser_free(seuser)
+		if exists: semanage.semanage_seuser_free(old_seuser)
+
 	def test_writeport(self,sh):
 		print "Testing port write..."
 
 		(status, port) = semanage.semanage_port_create(sh)
+		if status < 0:
+			raise Error("Could not create SEPort object")
 		if self.verbose: print "SEPort object created."
 
 		semanage.semanage_port_set_range(port,150,200)
@@ -383,231 +502,408 @@ class Tests:
 		if self.verbose: print "SEPort protocol set: ", semanage.semanage_port_get_proto_str(port)
 		
 		(status, con) = semanage.semanage_context_create(sh)
+		if status < 0:
+			raise Error("Could not create SEContext object")
 		if self.verbose: print "SEContext object created (for port)."
 		
 		status = semanage.semanage_context_set_user(sh, con, "system_u")
+		if status < 0:
+			raise Error("Could not set context user")
 		if self.verbose: print "SEContext user: ", semanage.semanage_context_get_user(con)
 		
 		status = semanage.semanage_context_set_role(sh, con, "object_r")
+		if status < 0:
+			raise Error("Could not set context role")
 		if self.verbose: print "SEContext role: ", semanage.semanage_context_get_role(con)
 		
 		status = semanage.semanage_context_set_type(sh, con, "http_port_t")
+		if status < 0:
+			raise Error("Could not set context type")
 		if self.verbose: print "SEContext type: ", semanage.semanage_context_get_type(con)
 
 		status = semanage.semanage_context_set_mls(sh, con, "s0:c0.c255")
+		if status < 0:
+			raise Error("Could not set context MLS fields")
 		if self.verbose: print "SEContext mls: ", semanage.semanage_context_get_mls(con)
 
 		semanage.semanage_port_set_con(port, con)
 		if self.verbose: print "SEPort context set: ", con
 
                 (status,key) = semanage.semanage_port_key_extract(sh,port)
-                if self.verbose: print "SEPort key extracted: ", key
+		if status < 0:
+			raise Error("Could not extract SEPort key")
+		if self.verbose: print "SEPort key extracted: ", key
 
 		(status,exists) = semanage.semanage_port_exists_local(sh,key)
+		if status < 0:
+			raise Error("Could not check if SEPort exists")
 		if self.verbose: print "Exists status (commit number): ", status
+
 		if exists:
 			(status, old_port) = semanage.semanage_port_query_local(sh, key)
+			if status < 0:
+				raise Error("Could not query old SEPort")
 			if self.verbose: print "Query status (commit number): ", status
 
 		print "Starting transaction..."
 		status = semanage.semanage_begin_transaction(sh)
+		if status < 0:
+			raise Error("Could not start semanage transaction")	
+
 		status = semanage.semanage_port_modify_local(sh,key,port)
+		if status < 0:
+			raise Error("Could not modify SEPort")
+
 		status = semanage.semanage_commit(sh)
+		if status < 0:
+			raise Error("Could not commit test transaction")
 		print "Commit status (transaction number): ", status
 
 		status = semanage.semanage_begin_transaction(sh)
+		if status < 0:
+			raise Error("Could not start semanage transaction")
+
 		if not exists:
 			print "Removing port range..."
                         status = semanage.semanage_port_del_local(sh, key)
+			if status < 0:
+				raise Error("Could not delete test SEPort")
                         if self.verbose: print "Port range delete: ", status
                 else:
 			print "Resetting port range..."
 			status = semanage.semanage_port_modify_local(sh, key, old_port)
+			if status < 0:
+				raise Error("Could not reset test SEPort")
 			if self.verbose: print "Port range modify: ", status
+
 		status = semanage.semanage_commit(sh)
+		if status < 0:
+			raise Error("Could not commit reset transaction")
 		print "Commit status (transaction number): ", status
 
+		semanage.semanage_port_key_free(key)
+		semanage.semanage_port_free(port)
+		if exists: semanage.semanage_port_free(old_port)
+
 	def test_writefcontext(self,sh):
 		print "Testing file context write..."
 
 		(status, fcon) = semanage.semanage_fcontext_create(sh)
+		if status < 0:
+			raise Error("Could not create SEFcontext object")
 		if self.verbose: print "SEFcontext object created."
 	
 		status = semanage.semanage_fcontext_set_expr(sh, fcon, "/test/fcontext(/.*)?")
+		if status < 0:
+			raise Error("Could not set expression")
 		if self.verbose: print "SEFContext expr set: ", semanage.semanage_fcontext_get_expr(fcon)
 
 		semanage.semanage_fcontext_set_type(fcon, semanage.SEMANAGE_FCONTEXT_REG)
 		if self.verbose: print "SEFContext type set: ", semanage.semanage_fcontext_get_type_str(fcon)
 
 		(status, con) = semanage.semanage_context_create(sh)
+		if status < 0:
+			raise Error("Could not create SEContext object")
 		if self.verbose: print "SEContext object created (for file context)."
 
 		status = semanage.semanage_context_set_user(sh, con, "system_u")
+		if status < 0:
+			raise Error("Could not set context user")
 		if self.verbose: print "SEContext user: ", semanage.semanage_context_get_user(con)
 
 		status = semanage.semanage_context_set_role(sh, con, "object_r")
+		if status < 0:
+			raise Error("Could not set context role")
 		if self.verbose: print "SEContext role: ", semanage.semanage_context_get_role(con)
 
 		status = semanage.semanage_context_set_type(sh, con, "default_t")
+		if status < 0:
+			raise Error("Could not set context type")
 		if self.verbose: print "SEContext type: ", semanage.semanage_context_get_type(con)
 
 		status = semanage.semanage_context_set_mls(sh, con, "s0:c0.c255")
+		if status < 0:
+			raise Error("Could not set context MLS fields")
 		if self.verbose: print "SEContext mls: ", semanage.semanage_context_get_mls(con)
 
 		semanage.semanage_fcontext_set_con(fcon, con)
 		if self.verbose: print "SEFcontext context set: ", con
 
 		(status,key) = semanage.semanage_fcontext_key_extract(sh,fcon)
+		if status < 0:
+			raise Error("Could not extract SEFcontext key")
 		if self.verbose: print "SEFcontext key extracted: ", key
 
 		(status,exists) = semanage.semanage_fcontext_exists_local(sh,key)
+		if status < 0:
+			raise Error("Could not check if SEFcontext exists")
+
 		if self.verbose: print "Exists status (commit number): ", status
 		if exists:
 			(status, old_fcontext) = semanage.semanage_fcontext_query_local(sh, key)
+			if status < 0:
+				raise Error("Could not query old SEFcontext")
 			if self.verbose: print "Query status (commit number): ", status
 
 		print "Starting transaction..."
 		status = semanage.semanage_begin_transaction(sh)
+		if status < 0:
+			raise Error("Could not start semanage transaction")
+
 		status = semanage.semanage_fcontext_modify_local(sh,key,fcon)
+		if status < 0:
+			raise Error("Could not modify SEFcontext")
+
 		status = semanage.semanage_commit(sh)
+		if status < 0:
+			raise Error("Could not commit test transaction")
 		print "Commit status (transaction number): ", status
 
 		status = semanage.semanage_begin_transaction(sh)
+		if status < 0:
+			raise Error("Could not start semanage transaction")
+
 		if not exists:
 			print "Removing file context..."
 			status = semanage.semanage_fcontext_del_local(sh, key)
+			if status < 0:
+				raise Error("Could not delete test SEFcontext")
 			if self.verbose: print "File context delete: ", status
 		else:
 			print "Resetting file context..."
 			status = semanage.semanage_fcontext_modify_local(sh, key, old_fcontext)
+			if status < 0:
+				raise Error("Could not reset test FContext")
 			if self.verbose: print "File context modify: ", status
+
 		status = semanage.semanage_commit(sh)
+		if status < 0:
+			raise Error("Could not commit reset transaction")
 		print "Commit status (transaction number): ", status
 	
+		semanage.semanage_fcontext_key_free(key)
+		semanage.semanage_fcontext_free(fcon)
+		if exists: semanage.semanage_fcontext_free(old_fcontext)
+
 	def test_writeinterface(self,sh):
 		print "Testing network interface write..."
 
 		(status, iface) = semanage.semanage_iface_create(sh)
+		if status < 0:
+			raise Error("Could not create SEIface object")	
 		if self.verbose: print "SEIface object created."
 
 		status = semanage.semanage_iface_set_name(sh, iface, "test_iface")
+		if status < 0:
+			raise Error("Could not set SEIface name")
 		if self.verbose: print "SEIface name set: ", semanage.semanage_iface_get_name(iface)	
 
 		(status, con) = semanage.semanage_context_create(sh)
+		if status < 0:
+			raise Error("Could not create SEContext object")
 		if self.verbose: print "SEContext object created (for network interface)"
 
 		status = semanage.semanage_context_set_user(sh, con, "system_u")
+		if status < 0:
+			raise Error("Could not set interface context user")
 		if self.verbose: print "SEContext user: ", semanage.semanage_context_get_user(con)
 
 		status = semanage.semanage_context_set_role(sh, con, "object_r")
+		if status < 0:
+			raise Error("Could not set interface context role")
 		if self.verbose: print "SEContext role: ", semanage.semanage_context_get_role(con)
 
 		status = semanage.semanage_context_set_type(sh, con, "default_t")
+		if status < 0:
+			raise Error("Could not set interface context type")
 		if self.verbose: print "SEContext type: ", semanage.semanage_context_get_type(con)
 
 		status = semanage.semanage_context_set_mls(sh, con, "s0:c0.c255")
+		if status < 0:
+			raise Error("Could not set interface context MLS fields")
 		if self.verbose: print "SEContext mls: ", semanage.semanage_context_get_mls(con)
 
 		semanage.semanage_iface_set_ifcon(iface, con)
 		if self.verbose: print "SEIface interface context set: ", con
 
 		(status, con) = semanage.semanage_context_create(sh)
+		if status < 0:
+			raise Error("Could not create SEContext object")
 		if self.verbose: print "SEContext object created (for network interface)"
 
 		status = semanage.semanage_context_set_user(sh, con, "system_u")
+		if status < 0:
+			raise Error("Could not set message context user")
 		if self.verbose: print "SEContext user: ", semanage.semanage_context_get_user(con)
 
 		status = semanage.semanage_context_set_role(sh, con, "object_r")
+		if status < 0:
+			raise Error("Could not set message context role")
 		if self.verbose: print "SEContext role: ", semanage.semanage_context_get_role(con)
 
 		status = semanage.semanage_context_set_type(sh, con, "default_t")
+		if status < 0:
+			raise Error("Could not set message context type")
 		if self.verbose: print "SEContext type: ", semanage.semanage_context_get_type(con)
 
 		status = semanage.semanage_context_set_mls(sh, con, "s0:c0.c255")
+		if status < 0:
+			raise Error("Could not set message context MLS fields")
 		if self.verbose: print "SEContext mls: ", semanage.semanage_context_get_mls(con)
 
 		semanage.semanage_iface_set_msgcon(iface, con)
 		if self.verbose: print "SEIface message context set: ", con
 
 		(status,key) = semanage.semanage_iface_key_extract(sh,iface)
+		if status < 0:
+			raise Error("Could not extract SEIface key")
 		if self.verbose: print "SEIface key extracted: ", key
 
 		(status,exists) = semanage.semanage_iface_exists_local(sh,key)
+		if status < 0:
+			raise Error("Could not check if SEIface exists")
 		if self.verbose: print "Exists status (commit number): ", status
+
 		if exists:
 			(status, old_iface) = semanage.semanage_iface_query_local(sh, key)
+			if status < 0:
+				raise Error("Could not query old SEIface")
 			if self.verbose: print "Query status (commit number): ", status
 
 		print "Starting transaction..."
 		status = semanage.semanage_begin_transaction(sh)
+		if status < 0:
+			raise Error("Could not begin semanage transaction")
+
 		status = semanage.semanage_iface_modify_local(sh,key,iface)
+		if status < 0:
+			raise Error("Could not modify SEIface")
+
 		status = semanage.semanage_commit(sh)
+		if status < 0:
+			raise Error("Could not commit test transaction")
 		print "Commit status (transaction number): ", status
 
 		status = semanage.semanage_begin_transaction(sh)
+		if status < 0:
+			raise Error("Could not begin semanage transaction")
+
 		if not exists:
 			print "Removing interface..."
 			status = semanage.semanage_iface_del_local(sh, key)
+			if status < 0:
+				raise Error("Could not delete test SEIface")
 			if self.verbose: print "Interface delete: ", status
 		else:
 			print "Resetting interface..."
 			status = semanage.semanage_iface_modify_local(sh, key, old_iface)
+			if status < 0:
+				raise Error("Could not reset test SEIface")
 			if self.verbose: print "Interface modify: ", status
+
 		status = semanage.semanage_commit(sh)
+		if status < 0:
+			raise Error("Could not commit reset transaction")
 		print "Commit status (transaction number): ", status
 
+		semanage.semanage_iface_key_free(key)
+		semanage.semanage_iface_free(iface)
+		if exists: semanage.semanage_iface_free(old_iface)
+
         def test_writeboolean(self,sh):
 		print "Testing boolean write..."
 
-		(status, bool) = semanage.semanage_bool_create(sh)
+		(status, pbool) = semanage.semanage_bool_create(sh)
+		if status < 0:
+			raise Error("Could not create SEBool object")
 		if self.verbose: print "SEBool object created."
 
-		status = semanage.semanage_bool_set_name(sh, bool, "allow_execmem")
-		if self.verbose: print "SEBool name set: ", semanage.semanage_bool_get_name(bool)
-
-		semanage.semanage_bool_set_value(bool, 0)
-		if self.verbose: print "SEbool value set: ", semanage.semanage_bool_set_value(bool)
-
-		(status,key) = semanage.semanage_bool_key_extract(sh,bool)
+		status = semanage.semanage_bool_set_name(sh, pbool, "allow_execmem")
+		if status < 0:
+			raise Error("Could not set name")
+		if self.verbose: print "SEBool name set: ", semanage.semanage_bool_get_name(pbool)
+
+		semanage.semanage_bool_set_value(pbool, 0)
+		if self.verbose: print "SEbool value set: ", semanage.semanage_bool_set_value(pbool)
+
+		(status,key) = semanage.semanage_bool_key_extract(sh, pbool)
+		if status < 0:
+			raise Error("Could not extract SEBool key")
 		if self.verbose: print "SEBool key extracted: ", key
 
 		(status,exists) = semanage.semanage_bool_exists_local(sh,key)
+		if status < 0:
+			raise Error("Could not check if SEBool exists")
 		if self.verbose: print "Exists status (commit number): ", status
+
 		if exists:
 			(status, old_bool) = semanage.semanage_bool_query_local(sh, key)
+			if status < 0:
+				raise Error("Could not query old SEBool")
 			if self.verbose: print "Query status (commit number): ", status
 
 		print "Starting transaction..."
 		status = semanage.semanage_begin_transaction(sh)
-		status = semanage.semanage_bool_modify_local(sh,key,bool)
+		if status < 0:
+			raise Error("Could not start semanage transaction")
+
+		status = semanage.semanage_bool_modify_local(sh, key, pbool)
+
+		if status < 0:
+			raise Error("Could not modify SEBool")
+
 		status = semanage.semanage_commit(sh)
+		if status < 0:
+			raise Error("Could not commit test transaction")
 		print "Commit status (transaction number): ", status
 
 		status = semanage.semanage_begin_transaction(sh)
+		if status < 0:
+			raise Error("Could not start semanage transaction")
+
 		if not exists:
 			print "Removing boolean..."
 			status = semanage.semanage_bool_del_local(sh, key)
+			if status < 0:
+				raise Error("Could not delete test SEBool")
 			if self.verbose: print "Boolean delete: ", status
 		else:
 			print "Resetting boolean..."
 			status = semanage.semanage_bool_modify_local(sh, key, old_bool)
+			if status < 0:
+				raise Error("Could not reset test SEBool")
 			if self.verbose: print "Boolean modify: ", status
+
 		status = semanage.semanage_commit(sh)
+		if status < 0:
+			raise Error("Could not commit reset transaction")
 		print "Commit status (transaction number): ", status
 
+		semanage.semanage_bool_key_free(key)
+		semanage.semanage_bool_free(pbool)
+		if exists: semanage.semanage_bool_free(old_bool)
+
 	def test_writeaboolean(self,sh):
 		print "Testing active boolean write..."
 
 		(status, key) = semanage.semanage_bool_key_create(sh, "allow_execmem")
+		if status < 0:
+			raise Error("Could not create SEBool key")
 		if self.verbose: print "SEBool key created: ", key
 
 		(status, old_bool) = semanage.semanage_bool_query_active(sh, key)
+		if status < 0:
+			raise Error("Could not query old SEBool")
 		if self.verbose: print "Query status (commit number): ", status
 
 		(status, abool) = semanage.semanage_bool_create(sh)
+		if status < 0:
+			raise Error("Could not create SEBool object")
 		if self.verbose: print "SEBool object created."
 
 		status = semanage.semanage_bool_set_name(sh, abool, "allow_execmem")
+		if status < 0:
+			raise Error("Could not set name")
 		if self.verbose: print "SEBool name set: ", semanage.semanage_bool_get_name(abool)
 
 		semanage.semanage_bool_set_value(abool, 0)
@@ -615,17 +911,36 @@ class Tests:
 
 		print "Starting transaction..."
 		status = semanage.semanage_begin_transaction(sh)
+		if status < 0:
+			raise Error("Could not start semanage transaction")
+
 		status = semanage.semanage_bool_set_active(sh,key,abool)
+		if status < 0:
+			raise Error("Could not modify SEBool")
+
 		status = semanage.semanage_commit(sh)
+		if status < 0:
+			raise Error("Could not commit test transaction")
 		print "Commit status (transaction number): ", status
 
 		print "Resetting old active boolean..."
 		status = semanage.semanage_begin_transaction(sh)
+		if status < 0:
+			raise Error("Could not start semanage transaction")
+
 		status = semanage.semanage_bool_set_active(sh, key,old_bool)
+		if status < 0:
+			raise Error("Could not reset test SEBool")
 		if self.verbose: print "SEBool active reset: ", status
+
 		status = semanage.semanage_commit(sh)
+		if status < 0:
+			raise Error("Could not commit reset transaction")
 		print "Commit status (transaction number): ", status
 
+		semanage.semanage_bool_key_free(key)
+		semanage.semanage_bool_free(abool)
+		semanage.semanage_bool_free(old_bool)
 
 def main(argv=None):
 	if argv is None:
@@ -684,14 +999,25 @@ def main(argv=None):
 		if (semanage.semanage_is_managed(sh) != 1):
 			raise Status("Unmanaged!")
 		
-		semanage.semanage_connect(sh)
-		
+		status = semanage.semanage_connect(sh)
+		if status < 0:
+			raise Error("Could not establish semanage connection")
+
 		tests.run(sh)
 
+		status = semanage.semanage_disconnect(sh)
+		if status < 0:
+			raise Error("Could not disconnect")
+
+		semanage.semanage_handle_destroy(sh)
+
 	except Usage, err:
         	print >>sys.stderr, err.msg
 	except Status, err:
         	print >>sys.stderr, err.msg
+	except Error, err:
+		print >>sys.stderr, err.msg
+
         return 2
 
 if __name__ == "__main__":

--------------080208090505060103050508--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
