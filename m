Message-ID: <43BC9227.1020405@cornell.edu>
Date: Wed, 04 Jan 2006 22:27:35 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: [SEMANAGE] Add more tests
Content-Type: multipart/mixed;
 boundary="------------080504010301070208060302"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080504010301070208060302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi, this patch adds tests for booleans, active booleans, interfaces, 
ports, and file contexts.
It adds a pair of tests for each - write and list, and follows the exact 
same pattern as the other tests.

Some of those tests are pretty useless - like the write tests - you 
can't really tell if anything was written, or if the correct thing was 
written.... also I haven't tried hard at all to look at the status 
values - the existing tests didn't, and I'm following the pattern - will 
fix for all of them when it's fixed.

That said, they do have a positive side over my own testsuite:
- my tests are a mess, those new ones are pretty organized
- new tests are in python, so they test the bindings
- my tests use modify(), those tests test add() (which was recently broken)
- new tests also cover delete(), instead of forcing me to go clear the 
_local files every time (ugh)

This is by no means a complete testsuite - need to cover iterate(), 
query(), exists(), count(), other things... but it's a good starting 
point for future enhancements.

--------------080504010301070208060302
Content-Type: text/x-patch;
 name="libsemanage.more_tests.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.more_tests.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/pywrap-test.py new/libsemanage/src/pywrap-test.py
--- old/libsemanage/src/pywrap-test.py	2005-12-05 15:00:50.000000000 -0500
+++ new/libsemanage/src/pywrap-test.py	2006-01-04 22:16:49.000000000 -0500
@@ -6,10 +6,20 @@ import semanage
 usage = "\
 Choose one of the following tests:\n\
 -m for modules\n\
--u for users\n\n\
--U for add user (warning this will write!)\n\n\
--s for seusers\n\n\
--S for add seuser (warning this will write!)\n\n\
+-u for users\n\
+-U for add user (warning this will write!)\n\
+-s for seusers\n\
+-S for add seuser (warning this will write!)\n\
+-p for ports\n\
+-P for add port (warning this will write!)\n\
+-f for file contexts \n\
+-F for add file context (warning this will write!)\n\
+-i for network interfaces \n\
+-I for add network interface (warning this will write!)\n\
+-b for booleans \n\
+-B for add boolean (warning this will write!)\n\
+-c for aCtive booleans\n\
+-C for set aCtive boolean (warning this will write!)\n\n\
 Other options:\n\
 -h for this help\n\
 -v for verbose output\
@@ -30,11 +40,21 @@ class Tests:
 		self.writeuser = False
 		self.seusers = False
 		self.writeseuser = False
+		self.ports = False
+		self.writeport = False
+		self.fcontexts = False
+		self.writefcontext = False
+		self.interfaces = False
+		self.writeinterface = False
+		self.booleans = False
+		self.writeboolean = False
+		self.abooleans = False
+		self.writeaboolean = False
 		self.modules = False
 		self.verbose = False
 
 	def selected(self):
-		return (self.all or self.users or self.modules or self.seusers or self.writeuser or self.writeseuser)
+		return (self.all or self.users or self.modules or self.seusers or self.ports or self.fcontexts or self.interfaces or self.booleans or self.abooleans or self.writeuser or self.writeseuser or self.writeport or self.writefcontext or self.writeinterface or self.writeboolean or self.writeaboolean)
 
 	def run(self, handle):
 		if (self.users or self.all): 
@@ -43,15 +63,45 @@ class Tests:
 		if (self.seusers or self.all): 
 			self.test_seusers(handle)
 			print ""
+		if (self.ports or self.all):
+			self.test_ports(handle)
+			print ""
 		if (self.modules or self.all): 
 			self.test_modules(handle)
 			print ""
+		if (self.fcontexts or self.all):
+			self.test_fcontexts(handle)
+			print ""
+		if (self.interfaces or self.all):
+			self.test_interfaces(handle)
+			print ""
+		if (self.booleans or self.all):
+			self.test_booleans(handle)
+			print ""
+		if (self.abooleans or self.all):
+			self.test_abooleans(handle)
+			print ""
 		if (self.writeuser or self.all): 
 			self.test_writeuser(handle)
 			print ""
 		if (self.writeseuser or self.all): 
 			self.test_writeseuser(handle)
 			print ""
+		if (self.writeport or self.all):
+			self.test_writeport(handle)
+			print ""
+		if (self.writefcontext or self.all):
+			self.test_writefcontext(handle)
+			print ""
+		if (self.writeinterface or self.all):
+			self.test_writeinterface(handle)
+			print ""
+		if (self.writeboolean or self.all):
+			self.test_writeboolean(handle)
+			print ""
+		if (self.writeaboolean or self.all):
+			self.test_writeaboolean(handle)
+			print ""
 
 	def test_modules(self,sh):
 		print "Testing modules..."
@@ -75,7 +125,7 @@ class Tests:
 		print "Testing seusers..."
 		(status, list, list_size) = semanage.semanage_seuser_list(sh)
 
-		print "Query status (0 is good): ", status
+		print "Query status (commit number): ", status
 		print "SEUser list size: ", list_size
 		if self.verbose: print "List reference: ",  list
 
@@ -94,11 +144,10 @@ class Tests:
 		print "Testing users..."
 		(status, list, list_size) = semanage.semanage_user_list(sh)
 
-		print "Query status (0 is good): ", status
+		print "Query status (commit number): ", status
 		print "User list size: ", list_size
 		if self.verbose: print "List reference: ",  list
 
-
 		if (list_size == 0):
 			print "No users found!"
 			print "This is not necessarily a test failure."
@@ -115,6 +164,120 @@ class Tests:
 			for ridx in range (rlist_size):
 				print "      ", semanage.char_by_idx(rlist, ridx) 
 
+	def test_ports(self,sh):
+		print "Testing ports..."
+		(status, list, list_size) = semanage.semanage_port_list(sh)
+		
+		print "Query status (commit number): ", status
+		print "Port list size: ", list_size
+		if self.verbose: print "List reference: ",  list
+
+		if (list_size == 0):
+			print "No ports found!"
+			print "This is not necessarily a test failure."
+			return
+		for idx in range(list_size):
+			port = semanage.semanage_port_by_idx(list, idx)
+			if self.verbose: print "Port reference: ", port
+			low = semanage.semanage_port_get_low(port)
+			high = semanage.semanage_port_get_high(port)
+			con = semanage.semanage_port_get_con(port)
+			proto_str = semanage.semanage_port_get_proto_str(port)
+			if low == high:
+				range_str = str(low)
+			else:
+				range_str = str(low) + "-" + str(high)
+			(rc, con_str) = semanage.semanage_context_to_string(sh,con)
+			if rc < 0: con_str = ""
+			print "Port: ", range_str, " ", proto_str, " Context: ", con_str
+
+	def test_fcontexts(self,sh):
+		print "Testing file contexts..."
+		(status, list, list_size) = semanage.semanage_fcontext_list(sh)
+
+		print "Query status (commit number): ", status
+		print "File Context list size: ", list_size
+		if self.verbose: print "List reference: ",  list
+
+		if (list_size == 0):
+			print "No file contexts found!"
+			print "This is not necessarily a test failure."
+			return
+		for idx in range(list_size):
+			fcon = semanage.semanage_fcontext_by_idx(list, idx)
+			if self.verbose: print "File Context reference: ", fcon
+			expr = semanage.semanage_fcontext_get_expr(fcon)
+			type_str = semanage.semanage_fcontext_get_type_str(fcon)
+			con = semanage.semanage_fcontext_get_con(fcon)
+			if not con: 
+				con_str = "<<none>>"
+			else:
+				(rc, con_str) = semanage.semanage_context_to_string(sh,con)
+				if rc < 0: con_str = ""
+			print "File Expr: ", expr, " [", type_str, "] Context: ", con_str
+
+	def test_interfaces(self,sh):
+		print "Testing network interfaces..."
+		(status, list, list_size) = semanage.semanage_iface_list(sh)
+
+		print "Query status (commit number): ", status
+		print "Interfaces list size: ", list_size
+		if self.verbose: print "List reference: ", list
+
+		if (list_size == 0):
+			print "No network interfaces found!"
+			print "This is not necessarily a test failure."
+			return
+		for idx in range(list_size):
+			iface = semanage.semanage_iface_by_idx(list, idx)
+			if self.verbose: print "Interface reference: ", iface
+			name = semanage.semanage_iface_get_name(iface)
+			msg_con = semanage.semanage_iface_get_msgcon(iface)
+			if_con = semanage.semanage_iface_get_ifcon(iface)
+			(rc, msg_con_str) = semanage.semanage_context_to_string(sh,msg_con)
+			if rc < 0: msg_con_str = ""
+			(rc, if_con_str) = semanage.semanage_context_to_string(sh, if_con)
+			if rc < 0: if_con_str = ""
+			print "Interface: ", name, " Context: ", if_con_str, " Message Context: ", msg_con_str
+
+	def test_booleans(self,sh):
+		print "Testing booleans..."
+		(status, list, list_size) = semanage.semanage_bool_list(sh)
+
+		print "Query status (commit number): ", status
+		print "Booleans list size: ", list_size
+		if self.verbose: print "List reference: ", list
+
+		if (list_size == 0):
+			print "No booleans found!"
+			print "This is not necessarily a test failure."
+			return
+		for idx in range(list_size):
+			bool = semanage.semanage_bool_by_idx(list, idx)
+			if self.verbose: print "Boolean reference: ", bool
+			name = semanage.semanage_bool_get_name(bool)
+			value = semanage.semanage_bool_get_value(bool)	
+			print "Boolean: ", name, " Value: ", value
+
+	def test_abooleans(self,sh):
+		print "Testing active booleans..."
+		(status, list, list_size) = semanage.semanage_bool_list_active(sh)
+
+		print "Query status (commit number): ", status
+		print "Active Booleans list size: ", list_size
+		if self.verbose: print "List reference: ", list
+
+		if (list_size == 0):
+                        print "No active booleans found!"
+			print "This is not necessarily a test failure."
+			return
+		for idx in range(list_size):
+			abool = semanage.semanage_bool_by_idx(list, idx)
+			if self.verbose: print "Active boolean reference: ", abool
+			name = semanage.semanage_bool_get_name(abool)
+			value = semanage.semanage_bool_get_value(abool)
+			print "Active Boolean: ", name, " Value: ", value
+
 	def test_writeuser(self,sh):
                 print "Testing user write..."
                 
@@ -133,7 +296,7 @@ class Tests:
                 if self.verbose: print "User mlslevel: ", semanage.semanage_user_get_mlslevel(user)
                 
 		(status,key) = semanage.semanage_user_key_extract(sh,user)
-                if self.verbose: print "User key extracted : ", key
+                if self.verbose: print "User key extracted: ", key
 		
 		print "Starting transaction..."
                 status = semanage.semanage_begin_transaction(sh)
@@ -164,7 +327,7 @@ class Tests:
                 if self.verbose: print "SEUser mlsrange: ", semanage.semanage_seuser_get_mlsrange(seuser)
                 
 		(status,key) = semanage.semanage_seuser_key_extract(sh,seuser)
-                if self.verbose: print "SEUser key extracted : ", key
+                if self.verbose: print "SEUser key extracted: ", key
 		
 		print "Starting transaction..."
                 status = semanage.semanage_begin_transaction(sh)
@@ -178,13 +341,228 @@ class Tests:
                 if self.verbose: print "SEUser delete: ", status
                 status = semanage.semanage_commit(sh)
                 print "Commit status (transaction number): ", status
-			
+
+	def test_writeport(self,sh):
+		print "Testing port write..."
+
+		(status, port) = semanage.semanage_port_create(sh)
+		if self.verbose: print "SEPort object created."
+
+		semanage.semanage_port_set_range(port,150,200)
+		low = semanage.semanage_port_get_low(port)
+		high = semanage.semanage_port_get_high(port)
+		if self.verbose: print "SEPort range set: ", low, "-", high
+		
+		semanage.semanage_port_set_proto(port, semanage.SEMANAGE_PROTO_TCP);
+		if self.verbose: print "SEPort protocol set: ", semanage.semanage_port_get_proto_str(port)
+		
+		(status, con) = semanage.semanage_context_create(sh)
+		if self.verbose: print "SEContext object created (for port)."
+		
+		status = semanage.semanage_context_set_user(sh, con, "system_u")
+		if self.verbose: print "SEContext user: ", semanage.semanage_context_get_user(con)
+		
+		status = semanage.semanage_context_set_role(sh, con, "object_r")
+		if self.verbose: print "SEContext role: ", semanage.semanage_context_get_role(con)
+		
+		status = semanage.semanage_context_set_type(sh, con, "http_port_t")
+		if self.verbose: print "SEContext type: ", semanage.semanage_context_get_type(con)
+
+		status = semanage.semanage_context_set_mls(sh, con, "s0:c0.c255")
+		if self.verbose: print "SEContext mls: ", semanage.semanage_context_get_mls(con)
+
+		semanage.semanage_port_set_con(port, con)
+		if self.verbose: print "SEPort context set: ", con
+
+                (status,key) = semanage.semanage_port_key_extract(sh,port)
+                if self.verbose: print "SEPort key extracted: ", key
+
+		print "Starting transaction..."
+		status = semanage.semanage_begin_transaction(sh)
+		status = semanage.semanage_port_add_local(sh,key,port)
+		status = semanage.semanage_commit(sh)
+		print "Commit status (transaction number): ", status
+
+		print "Removing port range..."
+		status = semanage.semanage_begin_transaction(sh)
+		status = semanage.semanage_port_del_local(sh, key)
+                if self.verbose: print "SEPort delete: ", status
+		status = semanage.semanage_commit(sh)
+		print "Commit status (transaction number): ", status
+
+	def test_writefcontext(self,sh):
+		print "Testing file context write..."
+
+		(status, fcon) = semanage.semanage_fcontext_create(sh)
+		if self.verbose: print "SEFcontext object created."
+	
+		status = semanage.semanage_fcontext_set_expr(sh, fcon, "/test/fcontext(/.*)?")
+		if self.verbose: print "SEFContext expr set: ", semanage.semanage_fcontext_get_expr(fcon)
+
+		semanage.semanage_fcontext_set_type(fcon, semanage.SEMANAGE_FCONTEXT_REG)
+		if self.verbose: print "SEFContext type set: ", semanage.semanage_fcontext_get_type_str(fcon)
+
+		(status, con) = semanage.semanage_context_create(sh)
+		if self.verbose: print "SEContext object created (for file context)."
+
+		status = semanage.semanage_context_set_user(sh, con, "system_u")
+		if self.verbose: print "SEContext user: ", semanage.semanage_context_get_user(con)
+
+		status = semanage.semanage_context_set_role(sh, con, "object_r")
+		if self.verbose: print "SEContext role: ", semanage.semanage_context_get_role(con)
+
+		status = semanage.semanage_context_set_type(sh, con, "default_t")
+		if self.verbose: print "SEContext type: ", semanage.semanage_context_get_type(con)
+
+		status = semanage.semanage_context_set_mls(sh, con, "s0:c0.c255")
+		if self.verbose: print "SEContext mls: ", semanage.semanage_context_get_mls(con)
+
+		semanage.semanage_fcontext_set_con(fcon, con)
+		if self.verbose: print "SEFcontext context set: ", con
+
+		(status,key) = semanage.semanage_fcontext_key_extract(sh,fcon)
+		if self.verbose: print "SEFcontext key extracted: ", key
+
+		print "Starting transaction..."
+		status = semanage.semanage_begin_transaction(sh)
+		status = semanage.semanage_fcontext_add_local(sh,key,fcon)
+		status = semanage.semanage_commit(sh)
+		print "Commit status (transaction number): ", status
+
+		print "Removing file context..."
+		status = semanage.semanage_begin_transaction(sh)
+		status = semanage.semanage_fcontext_del_local(sh, key)
+		if self.verbose: print "SEFcontext delete: ", status
+		status = semanage.semanage_commit(sh)
+		print "Commit status (transaction number): ", status
+	
+	def test_writeinterface(self,sh):
+		print "Testing network interface write..."
+
+		(status, iface) = semanage.semanage_iface_create(sh)
+		if self.verbose: print "SEIface object created."
+
+		status = semanage.semanage_iface_set_name(sh, iface, "test_iface")
+		if self.verbose: print "SEIface name set: ", semanage.semanage_iface_get_name(iface)	
+
+		(status, con) = semanage.semanage_context_create(sh)
+		if self.verbose: print "SEContext object created (for network interface)"
+
+		status = semanage.semanage_context_set_user(sh, con, "system_u")
+		if self.verbose: print "SEContext user: ", semanage.semanage_context_get_user(con)
+
+		status = semanage.semanage_context_set_role(sh, con, "object_r")
+		if self.verbose: print "SEContext role: ", semanage.semanage_context_get_role(con)
+
+		status = semanage.semanage_context_set_type(sh, con, "default_t")
+		if self.verbose: print "SEContext type: ", semanage.semanage_context_get_type(con)
+
+		status = semanage.semanage_context_set_mls(sh, con, "s0:c0.c255")
+		if self.verbose: print "SEContext mls: ", semanage.semanage_context_get_mls(con)
+
+		semanage.semanage_iface_set_ifcon(iface, con)
+		if self.verbose: print "SEIface interface context set: ", con
+
+		(status, con) = semanage.semanage_context_create(sh)
+		if self.verbose: print "SEContext object created (for network interface)"
+
+		status = semanage.semanage_context_set_user(sh, con, "system_u")
+		if self.verbose: print "SEContext user: ", semanage.semanage_context_get_user(con)
+
+		status = semanage.semanage_context_set_role(sh, con, "object_r")
+		if self.verbose: print "SEContext role: ", semanage.semanage_context_get_role(con)
+
+		status = semanage.semanage_context_set_type(sh, con, "default_t")
+		if self.verbose: print "SEContext type: ", semanage.semanage_context_get_type(con)
+
+		status = semanage.semanage_context_set_mls(sh, con, "s0:c0.c255")
+		if self.verbose: print "SEContext mls: ", semanage.semanage_context_get_mls(con)
+
+		semanage.semanage_iface_set_msgcon(iface, con)
+		if self.verbose: print "SEIface message context set: ", con
+
+		(status,key) = semanage.semanage_iface_key_extract(sh,iface)
+		if self.verbose: print "SEIface key extracted: ", key
+
+		print "Starting transaction..."
+		status = semanage.semanage_begin_transaction(sh)
+		status = semanage.semanage_iface_add_local(sh,key,iface)
+		status = semanage.semanage_commit(sh)
+		print "Commit status (transaction number): ", status
+
+		print "Removing network interface..."
+		status = semanage.semanage_begin_transaction(sh)
+		status = semanage.semanage_iface_del_local(sh, key)
+		if self.verbose: print "SEIface delete: ", status
+		status = semanage.semanage_commit(sh)
+		print "Commit status (transaction number): ", status
+
+        def test_writeboolean(self,sh):
+		print "Testing boolean write..."
+
+		(status, bool) = semanage.semanage_bool_create(sh)
+		if self.verbose: print "SEBool object created."
+
+		status = semanage.semanage_bool_set_name(sh, bool, "allow_execmem")
+		if self.verbose: print "SEBool name set: ", semanage.semanage_bool_get_name(bool)
+
+		semanage.semanage_bool_set_value(bool, 0)
+		if self.verbose: print "SEbool value set: ", semanage.semanage_bool_set_value(bool)
+
+		(status,key) = semanage.semanage_bool_key_extract(sh,bool)
+		if self.verbose: print "SEBool key extracted: ", key
+
+		print "Starting transaction..."
+		status = semanage.semanage_begin_transaction(sh)
+		status = semanage.semanage_bool_add_local(sh,key,bool)
+		status = semanage.semanage_commit(sh)
+		print "Commit status (transaction number): ", status
+
+		print "Removing boolean..."
+		status = semanage.semanage_begin_transaction(sh)
+		status = semanage.semanage_bool_del_local(sh, key)
+		if self.verbose: print "SEBool delete: ", status
+		status = semanage.semanage_commit(sh)
+		print "Commit status (transaction number): ", status
+
+	def test_writeaboolean(self,sh):
+		print "Testing active boolean write..."
+
+		(status, key) = semanage.semanage_bool_key_create(sh, "allow_execmem")
+		if self.verbose: print "SEBool key created: ", key
+
+		(status, old_bool) = semanage.semanage_bool_query(sh, key)
+		if self.verbose: print "Query status (commit number): ", status
+
+		(status, abool) = semanage.semanage_bool_create(sh)
+		if self.verbose: print "SEBool object created."
+
+		status = semanage.semanage_bool_set_name(sh, abool, "allow_execmem")
+		if self.verbose: print "SEBool name set: ", semanage.semanage_bool_get_name(abool)
+
+		semanage.semanage_bool_set_value(abool, 0)
+		if self.verbose: print "SEbool value set: ", semanage.semanage_bool_set_value(abool)
+
+		print "Starting transaction..."
+		status = semanage.semanage_begin_transaction(sh)
+		status = semanage.semanage_bool_set_active(sh,key,abool)
+		status = semanage.semanage_commit(sh)
+		print "Commit status (transaction number): ", status
+
+		print "Resetting old active boolean..."
+		status = semanage.semanage_begin_transaction(sh)
+		status = semanage.semanage_bool_set_active(sh, key,old_bool)
+		if self.verbose: print "SEBool active reset: ", status
+		status = semanage.semanage_commit(sh)
+		print "Commit status (transaction number): ", status
+
+
 def main(argv=None):
 	if argv is None:
 		argv = sys.argv
 	try:
         	try:
-			opts, args = getopt.getopt(argv[1:], "hvmusUSa", ["help", "verbose", "modules", "users", "seusers", "writeuser", "writeseuser", "all"])
+			opts, args = getopt.getopt(argv[1:], "hvmuspfibcUSPFIBCa", ["help", "verbose", "modules", "users", "seusers", "ports", "file contexts", "network interfaces", "booleans", "active booleans" "writeuser", "writeseuser", "writeport", "writefcontext", "writeinterface", "writeboolean", "writeaboolean", "all"])
 			tests = Tests()
 			for o, a in opts:
         			if o == "-v":
@@ -200,6 +578,26 @@ def main(argv=None):
             				tests.seusers = True
         			if o == "-S":
             				tests.writeseuser = True
+				if o == "-p":
+					tests.ports = True
+				if o == "-P":
+					tests.writeport = True
+				if o == "-f":
+					tests.fcontexts = True
+				if o == "-F":
+					tests.writefcontext = True
+				if o == "-i":
+					tests.interfaces = True
+				if o == "-I":
+					tests.writeinterface = True
+				if o == "-b":
+					tests.booleans = True
+				if o == "-B":
+					tests.writeboolean = True
+				if o == "-c":
+					tests.abooleans = True
+				if o == "-C":
+					tests.writeaboolean = True
         			if o == "-m":
             				tests.modules = True
         			if o == "-h":

--------------080504010301070208060302--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
