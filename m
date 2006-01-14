Message-ID: <43C89A43.3020105@cornell.edu>
Date: Fri, 13 Jan 2006 23:29:23 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: [SEMANAGE(tool)] Fix many issues
Content-Type: multipart/mixed;
 boundary="------------060403090406070403070503"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060403090406070403070503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Okay, it's my turn to patch semanage (tool).

Changes:

1) Stephen, you changed add -> modify in the places my earlier patch 
changed them, but Dan had added new records, which were left unchanged. 
This fixes the rest of them.

2) Fixes use of semanage_seuser_modify_local -> semanage_seuser_modify, 
the seuser functions don't have _local suffixes.

3) pass ftype to fcontext delete function, as it is part of the key, 
otherwise variable is undefined

4) fix backwards existence check in selinux user add()

5) fix bug where the same context is passed on interface set_ifcon and 
set_msgcon - it needs to be cloned, or it will crash - the context 
passed to those functions is not cloned internally, it is used as the 
master copy

6) The boolean code incorrectly duplicates fcontext code. I see it's 
currently disabled, I guess it's work in progress. Fix most of it 
regardless (but keep it disabled)

7) audit rc values for:
      - object set functions that can fail (which is most of them)
      - dbase modify, delete, and list calls
      - semanage_begin_transaction

8) fix rc handling:
      - do not presume to know why commit failed ("is not defined" -> 
"Failed to do ...") Commit can fail for many reasons.
      - remove rc messages following a get_con() call. It can't fail, 
and does not update the rc value

9) restructure code:
     - I don't like all those if/else statements that increase the 
indentation level - move the failure case first, which is handled via an 
exception, so no indentation is needed below
     - push any code that sets record fields out of the transaction

10) improve error messages:
    - fcontext -> "file context for"
    - correct SELinux user vs login mapping inconsistencies
    - "not defined localy, can not be deleted" -> "defined in policy, 
cannot be deleted"
    - remove trailing dot to improve consistency
    - "Can't" - > "Could not" for consistency
    - "Requires," -> "Requires"
    - print the object key on failure of modify/delete/add/commit

11) Rename variables:
    - status -> rc for consistency

Further notes:
- Multiple roles don't seem to work - I get the usage() printout
- Modifying with -R doesn't work properly - it adds roles on top of the 
current ones, when it should clear the current role set first - you can 
use the del_role function, or better, the set_roles function (not sure 
if it will work, let joshua know if the swig typemaps create problems 
for that case).
- I would recommend a message be printed out after a delete() that 
leaves a policy object behind (do exists check again), that says: 
"Deleted local modifications to <object>, falling back to policy 
default". This describes what the delete function really does in that case.




--------------060403090406070403070503
Content-Type: text/x-patch;
 name="semanage.bugfix_patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="semanage.bugfix_patch.diff"

diff -Naurp --exclude-from excludes old/policycoreutils/semanage/semanage new/policycoreutils/semanage/semanage
--- old/policycoreutils/semanage/semanage	2006-01-13 06:39:11.000000000 -0700
+++ new/policycoreutils/semanage/semanage	2006-01-13 22:59:58.000000000 -0700
@@ -186,6 +186,7 @@ semanage fcontext [-admhfst] INTERFACE\n
 
 			if object == "fcontext":
 				OBJECT.add(target, setype, ftype, serange, seuser)
+
 			sys.exit(0);
 			
 		if modify:
@@ -210,8 +211,13 @@ semanage fcontext [-admhfst] INTERFACE\n
 		if delete:
 			if object == "port":
 				OBJECT.delete(target, proto)
+
+			if object == "fcontext":
+				OBJECT.delete(target, ftype)
+
 			else:
 				OBJECT.delete(target)
+
 			sys.exit(0);
 		usage()
 			
diff -Naurp --exclude-from excludes old/policycoreutils/semanage/seobject.py new/policycoreutils/semanage/seobject.py
--- old/policycoreutils/semanage/seobject.py	2006-01-13 21:06:14.000000000 -0700
+++ new/policycoreutils/semanage/seobject.py	2006-01-13 22:57:41.000000000 -0700
@@ -46,7 +46,7 @@ class loginRecords(semanageRecords):
 
 		(rc,exists) = semanage_seuser_exists(self.sh, k)
 		if exists:
-			raise ValueError("SELinux User %s mapping already defined" % name)
+			raise ValueError("Login mapping for %s is already defined" % name)
 		try:
 			pwd.getpwnam(name)
 		except:
@@ -54,40 +54,65 @@ class loginRecords(semanageRecords):
 			
 		(rc,u) = semanage_seuser_create(self.sh)
 		if rc < 0:
-			raise ValueError("Could not create seuser for %s" % name)
+			raise ValueError("Could not create login mapping for %s" % name)
 
-		semanage_seuser_set_name(self.sh, u, name)
-		semanage_seuser_set_mlsrange(self.sh, u, serange)
-		semanage_seuser_set_sename(self.sh, u, sename)
-		semanage_begin_transaction(self.sh)
-		semanage_seuser_add(self.sh, k, u)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Failed to add SELinux user mapping")
+		rc = semanage_seuser_set_name(self.sh, u, name)
+		if rc < 0:
+			raise ValueError("Could not set name for %s" % name)
+
+		rc = semanage_seuser_set_mlsrange(self.sh, u, serange)
+		if rc < 0:
+			raise ValueError("Could not set MLS range for %s" % name)
+
+		rc = semanage_seuser_set_sename(self.sh, u, sename)
+		if rc < 0:
+			raise ValueError("Could not set SELinux user for %s" % name)
+
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_seuser_modify(self.sh, k, u)
+		if rc < 0:
+			raise ValueError("Failed to add login mapping for %s" % name)
+
+		rc = semanage_commit(self.sh) 
+		if rc < 0:
+			raise ValueError("Failed to add login mapping for %s" % name)
 
 	def modify(self, name, sename = "", serange = ""):
+		if sename == "" and serange == "":
+			raise ValueError("Requires seuser or serange")
+
 		(rc,k) = semanage_seuser_key_create(self.sh, name)
 		if rc < 0:
 			raise ValueError("Could not create a key for %s" % name)
 
-		if sename == "" and serange == "":
-			raise ValueError("Requires, seuser or serange")
-
 		(rc,exists) = semanage_seuser_exists(self.sh, k)
-		if exists:
-			(rc,u) = semanage_seuser_query(self.sh, k)
-			if rc < 0:
-				raise ValueError("Could not query seuser for %s" % name)
-		else:
-			raise ValueError("SELinux user %s mapping is not defined." % name)
+		if not exists:
+			raise ValueError("Login mapping for %s is not defined" % name)
+
+		(rc,u) = semanage_seuser_query(self.sh, k)
+		if rc < 0:
+			raise ValueError("Could not query seuser for %s" % name)
 
 		if serange != "":
 			semanage_seuser_set_mlsrange(self.sh, u, serange)
 		if sename != "":
 			semanage_seuser_set_sename(self.sh, u, sename)
-		semanage_begin_transaction(self.sh)
-		semanage_seuser_modify_local(self.sh, k, u)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Failed to modify SELinux user mapping")
+
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not srart semanage transaction")
+
+		rc = semanage_seuser_modify(self.sh, k, u)
+		if rc < 0:
+			raise ValueError("Failed to modify login mapping for %s" % name)
+	
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to modify login mapping for %s" % name)
+
 	def delete(self, name):
 		(rc,k) = semanage_seuser_key_create(self.sh, name)
 		if rc < 0:
@@ -95,15 +120,26 @@ class loginRecords(semanageRecords):
 
 		(rc,exists) = semanage_seuser_exists(self.sh, k)
 		if not exists:
-			raise ValueError("SELinux user %s mapping is not defined." % name)
-		semanage_begin_transaction(self.sh)
-		semanage_seuser_del(self.sh, k)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("SELinux User %s mapping not defined" % name)
+			raise ValueError("Login mapping for %s is not defined" % name)
+
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_seuser_del(self.sh, k)
+		if rc < 0:
+			raise ValueError("Failed to delete login mapping for %s" % name)
+
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to delete login mapping for %s" % name)
 		
 	def get_all(self):
 		dict={}
-		(status, self.ulist, self.usize) = semanage_seuser_list(self.sh)
+		(rc, self.ulist, self.usize) = semanage_seuser_list(self.sh)
+		if rc < 0:
+			raise ValueError("Could not list login mappings")
+
 		for idx in range(self.usize):
 			u = semanage_seuser_by_idx(self.ulist, idx)
 			name = semanage_seuser_get_name(u)
@@ -134,40 +170,59 @@ class seluserRecords(semanageRecords):
 			raise ValueError("Could not create a key for %s" % name)
 
 		(rc,exists) = semanage_user_exists(self.sh, k)
-		if not exists:
-			raise ValueError("SELinux user %s is already defined." % name)
+		if exists:
+			raise ValueError("SELinux user %s is already defined" % name)
 
 		(rc,u) = semanage_user_create(self.sh)
 		if rc < 0:
-			raise ValueError("Could not create login mapping for %s" % name)
+			raise ValueError("Could not create SELinux user for %s" % name)
+
+		rc = semanage_user_set_name(self.sh, u, name)
+		if rc < 0:
+			raise ValueError("Could not set name for %s" % name)
 
-		semanage_user_set_name(self.sh, u, name)
 		for r in roles:
-			semanage_user_add_role(self.sh, u, r)
-		semanage_user_set_mlsrange(self.sh, u, serange)
-		semanage_user_set_mlslevel(self.sh, u, selevel)
+			rc = semanage_user_add_role(self.sh, u, r)
+			if rc < 0:
+				raise ValueError("Could not add role %s for %s" % (r, name))
+
+		rc = semanage_user_set_mlsrange(self.sh, u, serange)
+		if rc < 0:
+			raise ValueError("Could not set MLS range for %s" % name)
+
+		rc = semanage_user_set_mlslevel(self.sh, u, selevel)
+		if rc < 0:
+			raise ValueError("Could not set MLS level for %s" % name)
+
 		(rc,key) = semanage_user_key_extract(self.sh,u)
 		if rc < 0:
 			raise ValueError("Could not extract key for %s" % name)
 
-		semanage_begin_transaction(self.sh)
-		semanage_user_modify_local(self.sh, k, u)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Failed to add SELinux user")
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_user_modify_local(self.sh, k, u)
+		if rc < 0:
+			raise ValueError("Failed to add SELinux user %s" % name)
+
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to add SELinux user %s" % name)
 
 	def modify(self, name, roles = [], selevel = "", serange = ""):
 		if len(roles) == 0  and serange == "" and selevel == "":
-			raise ValueError("Requires, roles, level  or range")
+			raise ValueError("Requires roles, level or range")
 
 		(rc,k) = semanage_user_key_create(self.sh, name)
 		if rc < 0:
 			raise ValueError("Could not create a key for %s" % name)
 
 		(rc,exists) = semanage_user_exists(self.sh, k)
-		if exists:
-			(rc,u) = semanage_user_query(self.sh, k)
-		else:
-			raise ValueError("SELinux user %s mapping is not defined locally." % name)
+		if not exists:
+			raise ValueError("SELinux user %s is not defined" % name)
+		
+		(rc,u) = semanage_user_query(self.sh, k)
 		if rc < 0:
 			raise ValueError("Could not query user for %s" % name)
 
@@ -178,35 +233,57 @@ class seluserRecords(semanageRecords):
 		if len(roles) != 0:
 			for r in roles:
 				semanage_user_add_role(self.sh, u, r)
-		semanage_begin_transaction(self.sh)
-		semanage_user_modify_local(self.sh, k, u)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Failed to modify SELinux user")
+
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_user_modify_local(self.sh, k, u)
+		if rc < 0:
+			raise ValueError("Failed to modify SELinux user %s" % name)
+
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to modify SELinux user %s" % name)
 		
 	def delete(self, name):
 		(rc,k) = semanage_user_key_create(self.sh, name)
 		if rc < 0:
-			raise ValueError("Could not crpppeate a key for %s" % name)
+			raise ValueError("Could not create a key for %s" % name)
+
 		(rc,exists) = semanage_user_exists(self.sh, k)
 		if not exists:
-			raise ValueError("user %s is not defined" % name)
-		else:
-			(rc,exists) = semanage_user_exists_local(self.sh, k)
-			if not exists:
-				raise ValueError("user %s is not defined locally, can not delete " % name)
-			
-		semanage_begin_transaction(self.sh)
-		semanage_user_del_local(self.sh, k)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Login User %s not defined" % name)
+			raise ValueError("SELinux user %s is not defined" % name)
+
+		(rc,exists) = semanage_user_exists_local(self.sh, k)
+		if not exists:
+			raise ValueError("SELinux user %s is defined in policy, cannot be deleted" % name)
+			
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_user_del_local(self.sh, k)
+		if rc < 0:
+			raise ValueError("Failed to delete SELinux user %s" % name)
+
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to delete SELinux user %s" % name)
 		
 	def get_all(self):
 		dict={}
-		(status, self.ulist, self.usize) = semanage_user_list(self.sh)
+		(rc, self.ulist, self.usize) = semanage_user_list(self.sh)
+		if rc < 0:
+			raise ValueError("Could not list SELinux users")
+
 		for idx in range(self.usize):
 			u = semanage_user_by_idx(self.ulist, idx)
 			name = semanage_user_get_name(u)
-			(status, rlist, rlist_size) = semanage_user_get_roles(self.sh, u)
+			(rc, rlist, rlist_size) = semanage_user_get_roles(self.sh, u)
+			if rc < 0:
+				raise ValueError("Could not list roles for user %s" % name)
+
 			roles = ""
 
 			if rlist_size:
@@ -278,62 +355,97 @@ class portRecords(semanageRecords):
 		if rc < 0:
 			raise ValueError("Could not create context for %s/%s" % (proto, port))
 
-		semanage_context_set_user(self.sh, con, "system_u")
-		semanage_context_set_role(self.sh, con, "object_r")
-		semanage_context_set_type(self.sh, con, type)
-		semanage_context_set_mls(self.sh, con, serange)
-		semanage_begin_transaction(self.sh)
+		rc = semanage_context_set_user(self.sh, con, "system_u")
+		if rc < 0:
+			raise ValueError("Could not set user in port context for %s/%s" % (proto, port))
+
+		rc = semanage_context_set_role(self.sh, con, "object_r")
+		if rc < 0:
+			raise ValueError("Could not set role in port context for %s/%s" % (proto, port))
+
+		rc = semanage_context_set_type(self.sh, con, type)
+		if rc < 0:
+			raise ValueError("Could not set type in port context for %s/%s" % (proto, port))
+
+		rc = semanage_context_set_mls(self.sh, con, serange)
+		if rc < 0:
+			raise ValueError("Could not set mls fields in port context for %s/%s" % (proto, port))
+
 		semanage_port_set_con(p, con)
-		semanage_port_modify_local(self.sh, k, p)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Failed to add port")
+
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_port_modify_local(self.sh, k, p)
+		if rc < 0:
+			raise ValueError("Failed to add port %s/%s" % (proto, port))
+	
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to add port %s/%s" % (proto, port))
 
 	def modify(self, port, proto, serange, setype):
 		if serange == "" and setype == "":
-			raise ValueError("Requires, setype or serange")
+			raise ValueError("Requires setype or serange")
 
 		( k, proto_d, low, high ) = self.__genkey(port, proto)
 
 		(rc,exists) = semanage_port_exists(self.sh, k)
-		if exists:
-			(rc,p) = semanage_port_query(self.sh, k)
-		else:
-			raise ValueError("port %s/%s is not defined." % (proto,port))
-
+		if not exists:
+			raise ValueError("Port %s/%s is not defined" % (proto,port))
+	
+		(rc,p) = semanage_port_query(self.sh, k)
 		if rc < 0:
-			raise ValueError("Could not query port for %s/%s" % (proto, port))
+			raise ValueError("Could not query port %s/%s" % (proto, port))
 
 		con = semanage_port_get_con(p)
-		if rc < 0:
-			raise ValueError("Could not get port context for %s/%s" % (proto, port))
 			
 		if serange != "":
 			semanage_context_set_mls(self.sh, con, serange)	
 		if setype != "":
 			semanage_context_set_type(self.sh, con, setype)
-		semanage_begin_transaction(self.sh)
-		semanage_port_modify_local(self.sh, k, p)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Failed to add port")
+
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_port_modify_local(self.sh, k, p)
+		if rc < 0:
+			raise ValueError("Failed to modify port %s/%s" % (proto, port))
+
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to add port %s/%s" % (proto, port))
 		
 	def delete(self, port, proto):
 		( k, proto_d, low, high ) = self.__genkey(port, proto)
 		(rc,exists) = semanage_port_exists(self.sh, k)
 		if not exists:
-			raise ValueError("port %s/%s is not defined." % (proto,port))
-		else:
-			(rc,exists) = semanage_port_exists_local(self.sh, k)
-			if not exists:
-				raise ValueError("port %s/%s is not defined localy, can not be deleted." % (proto,port))
-
-		semanage_begin_transaction(self.sh)
-		semanage_port_del_local(self.sh, k)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Port %s/%s not defined" % (proto,port))
+			raise ValueError("Port %s/%s is not defined" % (proto, port))
+		
+		(rc,exists) = semanage_port_exists_local(self.sh, k)
+		if not exists:
+			raise ValueError("Port %s/%s is defined in policy, cannot be deleted" % (proto, port))
+
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_port_del_local(self.sh, k)
+		if rc < 0:
+			raise ValueError("Could not delete port %s/%s" % (proto, port))
+
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Could not delete port %s/%s" % (proto, port))
 		
 	def get_all(self):
 		dict={}
-		(status, self.plist, self.psize) = semanage_port_list(self.sh)
+		(rc, self.plist, self.psize) = semanage_port_list(self.sh)
+		if rc < 0:
+			raise ValueError("Could not list ports")
+
 		for idx in range(self.psize):
 			u = semanage_port_by_idx(self.plist, idx)
 			con = semanage_port_get_con(u)
@@ -375,83 +487,122 @@ class interfaceRecords(semanageRecords):
 
 		(rc,k) = semanage_iface_key_create(self.sh, interface)
 		if rc < 0:
-			raise ValueError("Can't create key for %s" % interface)
+			raise ValueError("Could not create key for %s" % interface)
+
 		(rc,exists) = semanage_iface_exists(self.sh, k)
 		if exists:
 			raise ValueError("Interface %s already defined" % interface)
 
 		(rc,iface) = semanage_iface_create(self.sh)
 		if rc < 0:
-			raise ValueError("Could not create interface for %s" % (interface))
+			raise ValueError("Could not create interface for %s" % interface)
 		
 		rc = semanage_iface_set_name(self.sh, iface, interface)
 		(rc, con) = semanage_context_create(self.sh)
 		if rc < 0:
 			raise ValueError("Could not create context for %s" % interface)
 
-		semanage_context_set_user(self.sh, con, "system_u")
-		semanage_context_set_role(self.sh, con, "object_r")
-		semanage_context_set_type(self.sh, con, type)
-		semanage_context_set_mls(self.sh, con, serange)
-		semanage_begin_transaction(self.sh)
+		rc = semanage_context_set_user(self.sh, con, "system_u")
+		if rc < 0:
+			raise ValueError("Could not set user in interface context for %s" % interface)
+
+		rc = semanage_context_set_role(self.sh, con, "object_r")
+		if rc < 0:
+			raise ValueError("Could not set role in interface context for %s" % interface)
+
+		rc = semanage_context_set_type(self.sh, con, type)
+		if rc < 0:
+			raise ValueError("Could not set type in interface context for %s" % interface)
+
+		rc = semanage_context_set_mls(self.sh, con, serange)
+		if rc < 0:
+			raise ValueError("Could not set mls fields in interface context for %s" % interface)
+
+		(rc, con2) = semanage_context_clone(self.sh, con)
+		if rc < 0:
+			raise ValueError("Could not clone interface context for %s" % interface)
+
 		semanage_iface_set_ifcon(iface, con)
-		semanage_iface_set_msgcon(iface, con)
-		semanage_iface_add_local(self.sh, k, iface)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Failed to add interface")
+		semanage_iface_set_msgcon(iface, con2)
+
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_iface_modify_local(self.sh, k, iface)
+		if rc < 0:
+			raise ValueError("Failed to add interface %s" % interface)
+
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to add interface %s" % interface)
 
 	def modify(self, interface, serange, setype):
 		if serange == "" and setype == "":
-			raise ValueError("Requires, setype or serange")
+			raise ValueError("Requires setype or serange")
 
 		(rc,k) = semanage_iface_key_create(self.sh, interface)
 		if rc < 0:
-			raise ValueError("Can't creater key for %s" % interface)
-		(rc,exists) = semanage_iface_exists(self.sh, k)
-		if exists:
-			(rc,p) = semanage_iface_query(self.sh, k)
-		else:
-			raise ValueError("interface %s is not defined." % interface)
+			raise ValueError("Could not create key for %s" % interface)
 
+		(rc,exists) = semanage_iface_exists(self.sh, k)
+		if not exists:
+			raise ValueError("Interface %s is not defined" % interface)
+	
+		(rc,p) = semanage_iface_query(self.sh, k)
 		if rc < 0:
-			raise ValueError("Could not query interface for %s" % interface)
+			raise ValueError("Could not query interface %s" % interface)
 
 		con = semanage_iface_get_ifcon(p)
-		if rc < 0:
-			raise ValueError("Could not get interface context for %s" % interface)
 			
 		if serange != "":
 			semanage_context_set_mls(self.sh, con, serange)	
 		if setype != "":
 			semanage_context_set_type(self.sh, con, setype)
 
-		semanage_begin_transaction(self.sh)
-		semanage_iface_modify_local(self.sh, k, p)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Failed to add interface")
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_iface_modify_local(self.sh, k, p)
+		if rc < 0:
+			raise ValueError("Failed to modify interface %s" % interface)
 		
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to add interface %s" % interface)
+
 	def delete(self, interface):
 		(rc,k) = semanage_iface_key_create(self.sh, interface)
 		if rc < 0:
-			raise ValueError("Can't create key for %s" % interface)
+			raise ValueError("Could not create key for %s" % interface)
+
 		(rc,exists) = semanage_iface_exists(self.sh, k)
 		if not exists:
-			raise ValueError("interface %s is not defined." % interface)
-		else:
-			(rc,exists) = semanage_iface_exists_local(self.sh, k)
-			if not exists:
-				raise ValueError("interface %s is not defined localy, can not be deleted." % interface)
-
-		semanage_begin_transaction(self.sh)
-		semanage_iface_del_local(self.sh, k)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Interface %s not defined" % interface)
+			raise ValueError("Interface %s is not defined" % interface)
+
+		(rc,exists) = semanage_iface_exists_local(self.sh, k)
+		if not exists:
+			raise ValueError("Interface %s is defined in policy, cannot be deleted" % interface)
+
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_iface_del_local(self.sh, k)
+		if rc < 0:
+			raise ValueError("Failed to delete interface %s" % interface)
+
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to delete interface %s" % interface)
 		
 	def get_all(self):
 		dict={}
-		(status, self.plist, self.psize) = semanage_iface_list(self.sh)
-		if status < 0:
-			raise ValueError("Unable to list interfaces")
+		(rc, self.plist, self.psize) = semanage_iface_list(self.sh)
+		if rc < 0:
+			raise ValueError("Could not list interfaces")
+
 		for idx in range(self.psize):
 			interface = semanage_iface_by_idx(self.plist, idx)
 			con = semanage_iface_get_ifcon(interface)
@@ -501,48 +652,69 @@ class fcontextRecords(semanageRecords):
 
 		(rc,k) = semanage_fcontext_key_create(self.sh, target, self.file_types[ftype])
 		if rc < 0:
-			raise ValueError("Can't create key for %s" % target)
+			raise ValueError("Could not create key for %s" % target)
+
 		(rc,exists) = semanage_fcontext_exists(self.sh, k)
-		print (rc, exists, target)
 		if exists:
-			raise ValueError("fcontext %s already defined" % target)
+			raise ValueError("File context for %s already defined" % target)
+
 		(rc,fcontext) = semanage_fcontext_create(self.sh)
 		if rc < 0:
-			raise ValueError("Could not create fcontext for %s" % target)
+			raise ValueError("Could not create file context for %s" % target)
 		
 		rc = semanage_fcontext_set_expr(self.sh, fcontext, target)
 		(rc, con) = semanage_context_create(self.sh)
 		if rc < 0:
 			raise ValueError("Could not create context for %s" % target)
 
-		semanage_context_set_user(self.sh, con, seuser)
-		semanage_context_set_role(self.sh, con, "object_r")
-		semanage_context_set_type(self.sh, con, type)
-		semanage_context_set_mls(self.sh, con, serange)
+		rc = semanage_context_set_user(self.sh, con, seuser)
+		if rc < 0:
+			raise ValueError("Could not set user in file context for %s" % target)
+		
+		rc = semanage_context_set_role(self.sh, con, "object_r")
+		if rc < 0:
+			raise ValueError("Could not set role in file context for %s" % target)
+
+		rc = semanage_context_set_type(self.sh, con, type)
+		if rc < 0:
+			raise ValueError("Could not set type in file context for %s" % target)
+
+		rc = semanage_context_set_mls(self.sh, con, serange)
+		if rc < 0:
+			raise ValueError("Could not set mls fields in file context for %s" % target)
+
 		semanage_fcontext_set_type(fcontext, self.file_types[ftype])
-		semanage_begin_transaction(self.sh)
 		semanage_fcontext_set_con(fcontext, con)
-		semanage_fcontext_add_local(self.sh, k, fcontext)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Failed to add fcontext")
+
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_fcontext_modify_local(self.sh, k, fcontext)
+		if rc < 0:
+			raise ValueError("Failed to add file context for %s" % target)
+
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to add file context for %s" % target)
 
 	def modify(self, target, setype, ftype, serange, seuser):
 		if serange == "" and setype == "" and seuser == "":
-			raise ValueError("Requires, setype, serange or seuser")
+			raise ValueError("Requires setype, serange or seuser")
 
 		(rc,k) = semanage_fcontext_key_create(self.sh, target, self.file_types[ftype])
 		if rc < 0:
-			raise ValueError("Can't creater key for %s" % target)
+			raise ValueError("Could not create a key for %s" % target)
+
 		(rc,exists) = semanage_fcontext_exists(self.sh, k)
-		if exists:
-			(rc,p) = semanage_fcontext_query(self.sh, k)
-		else:
-			raise ValueError("fcontext %s is not defined." % target)
+		if not exists:
+			raise ValueError("File context for %s is not defined" % target)
+		
+		(rc,p) = semanage_fcontext_query(self.sh, k)
 		if rc < 0:
-			raise ValueError("Could not query fcontext for %s" % target)
+			raise ValueError("Could not query file context for %s" % target)
+
 		con = semanage_fcontext_get_con(p)
-		if rc < 0:
-			raise ValueError("Could not get fcontext context for %s" % target)
 			
 		if serange != "":
 			semanage_context_set_mls(self.sh, con, serange)	
@@ -551,33 +723,48 @@ class fcontextRecords(semanageRecords):
 		if setype != "":
 			semanage_context_set_type(self.sh, con, setype)
 
-		semanage_begin_transaction(self.sh)
-		semanage_fcontext_modify_local(self.sh, k, p)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Failed to add fcontext")
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_fcontext_modify_local(self.sh, k, p)
+		if rc < 0:
+			raise ValueError("Failed to modify file context for %s" % target)
+
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to add file context for %s" % target)
 		
-	def delete(self, target):
+	def delete(self, target, ftype):
 		(rc,k) = semanage_fcontext_key_create(self.sh, target, self.file_types[ftype])
 		if rc < 0:
-			raise ValueError("Can't create key for %s" % target)
+			raise ValueError("Could not create a key for %s" % target)
+
 		(rc,exists) = semanage_fcontext_exists(self.sh, k)
 		if not exists:
-			raise ValueError("fcontext %s is not defined." % target)
-		else:
-			(rc,exists) = semanage_fcontext_exists_local(self.sh, k)
-			if not exists:
-				raise ValueError("fcontext %s is not defined localy, can not be deleted." % target)
-
-		semanage_begin_transaction(self.sh)
-		semanage_fcontext_del_local(self.sh, k)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("fcontext %s not defined" % target)
+			raise ValueError("File context for %s is not defined" % target)
+		
+		(rc,exists) = semanage_fcontext_exists_local(self.sh, k)
+		if not exists:
+			raise ValueError("File context for %s is defined in policy, cannot be deleted" % target)
+
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_fcontext_del_local(self.sh, k)
+		if rc < 0:
+			raise ValueError("Failed to delete file context for %s" % target)
+
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to delete file context for %s" % target)
 		
 	def get_all(self):
 		dict={}
-		(status, self.plist, self.psize) = semanage_fcontext_list(self.sh)
-		if status < 0:
-			raise ValueError("Unable to list fcontexts")
+		(rc, self.plist, self.psize) = semanage_fcontext_list(self.sh)
+		if rc < 0:
+			raise ValueError("Could not list file contexts")
 
 		for idx in range(self.psize):
 			fcontext = semanage_fcontext_by_idx(self.plist, idx)
@@ -606,117 +793,82 @@ class booleanRecords(semanageRecords):
 	def __init__(self):
 		semanageRecords.__init__(self)
 		
-	def add(self, target, type, ftype="", serange="s0", seuser="system_u"):
-		if seuser == "":
-			seuser="system_u"
-			
-		if serange == "":
-			serange="s0"
-			
-		if type == "":
-			raise ValueError("SELinux Type is required")
+	def modify(self, name, value = ""):
+		if value == "":
+			raise ValueError("Requires value")
 
-		(rc,k) = semanage_fcontext_key_create(self.sh, target, self.file_types[ftype])
-		if rc < 0:
-			raise ValueError("Can't create key for %s" % target)
-		(rc,exists) = semanage_fcontext_exists(self.sh, k)
-		print (rc, exists, target)
-		if exists:
-			raise ValueError("fcontext %s already defined" % target)
-		(rc,fcontext) = semanage_fcontext_create(self.sh)
+		(rc,k) = semanage_bool_key_create(self.sh, name)
 		if rc < 0:
-			raise ValueError("Could not create fcontext for %s" % target)
-		
-		rc = semanage_fcontext_set_expr(self.sh, fcontext, target)
-		(rc, con) = semanage_context_create(self.sh)
-		if rc < 0:
-			raise ValueError("Could not create context for %s" % target)
-
-		semanage_context_set_user(self.sh, con, seuser)
-		semanage_context_set_role(self.sh, con, "object_r")
-		semanage_context_set_type(self.sh, con, type)
-		semanage_context_set_mls(self.sh, con, serange)
-		semanage_fcontext_set_type(fcontext, self.file_types[ftype])
-		semanage_begin_transaction(self.sh)
-		semanage_fcontext_set_con(fcontext, con)
-		semanage_fcontext_add_local(self.sh, k, fcontext)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Failed to add fcontext")
+			raise ValueError("Could not create a key for %s" % name)
 
-	def modify(self, target, setype, ftype, serange, seuser):
-		if serange == "" and setype == "" and seuser == "":
-			raise ValueError("Requires, setype, serange or seuser")
+		(rc,exists) = semanage_bool_exists(self.sh, k)
+		if not exists:
+			raise ValueError("Boolean %s is not defined" % name)	
 
-		(rc,k) = semanage_fcontext_key_create(self.sh, target, self.file_types[ftype])
+		(rc,b) = semanage_bool_query(self.sh, k)
 		if rc < 0:
-			raise ValueError("Can't creater key for %s" % target)
-		(rc,exists) = semanage_fcontext_exists(self.sh, k)
-		if exists:
-			(rc,p) = semanage_fcontext_query(self.sh, k)
-		else:
-			raise ValueError("fcontext %s is not defined." % target)
+			raise ValueError("Could not query file context %s" % name)
+
+		if value != "":
+			nvalue = string.atoi(value)
+			semanage_bool_set_value(b, nvalue)
+
+		rc = semanage_begin_transaction(self.sh)
 		if rc < 0:
-			raise ValueError("Could not query fcontext for %s" % target)
-		con = semanage_fcontext_get_con(p)
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_bool_modify_local(self.sh, k, b)
 		if rc < 0:
-			raise ValueError("Could not get fcontext context for %s" % target)
-			
-		if serange != "":
-			semanage_context_set_mls(self.sh, con, serange)	
-		if seuser != "":
-			semanage_context_set_user(self.sh, con, seuser)	
-		if setype != "":
-			semanage_context_set_type(self.sh, con, setype)
+			raise ValueError("Failed to modify boolean %s" % name)
 
-		semanage_begin_transaction(self.sh)
-		semanage_fcontext_modify_local(self.sh, k, p)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("Failed to add fcontext")
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to modify boolean %s" % name)
 		
-	def delete(self, target):
-		(rc,k) = semanage_fcontext_key_create(self.sh, target, self.file_types[ftype])
+	def delete(self, name):
+		(rc,k) = semanage_bool_key_create(self.sh, name)
 		if rc < 0:
-			raise ValueError("Can't create key for %s" % target)
-		(rc,exists) = semanage_fcontext_exists(self.sh, k)
+			raise ValueError("Could not create a key for %s" % name)
+
+		(rc,exists) = semanage_bool_exists(self.sh, k)
 		if not exists:
-			raise ValueError("fcontext %s is not defined." % target)
-		else:
-			(rc,exists) = semanage_fcontext_exists_local(self.sh, k)
-			if not exists:
-				raise ValueError("fcontext %s is not defined localy, can not be deleted." % target)
-
-		semanage_begin_transaction(self.sh)
-		semanage_fcontext_del_local(self.sh, k)
-		if semanage_commit(self.sh) < 0:
-			raise ValueError("fcontext %s not defined" % target)
+			raise ValueError("Boolean %s is not defined" % name)
+	
+		(rc,exists) = semanage_bool_exists_local(self.sh, k)
+		if not exists:
+			raise ValueError("Boolean %s is defined in policy, cannot be deleted" % name)
+
+		rc = semanage_begin_transaction(self.sh)
+		if rc < 0:
+			raise ValueError("Could not start semanage transaction")
+
+		rc = semanage_fcontext_del_local(self.sh, k)
+		if rc < 0:
+			raise ValueError("Failed to delete boolean %s" % name)
+	
+		rc = semanage_commit(self.sh)
+		if rc < 0:
+			raise ValueError("Failed to delete boolean %s" % name)
 		
 	def get_all(self):
 		dict={}
-		(status, self.plist, self.psize) = semanage_fcontext_list(self.sh)
-		if status < 0:
-			raise ValueError("Unable to list fcontexts")
+		(rc, self.blist, self.bsize) = semanage_bool_list(self.sh)
+		if rc < 0:
+			raise ValueError("Could not list booleans")
 
-		for idx in range(self.psize):
-			fcontext = semanage_fcontext_by_idx(self.plist, idx)
-			expr=semanage_fcontext_get_expr(fcontext)
-			ftype=semanage_fcontext_get_type_str(fcontext)
-			con = semanage_fcontext_get_con(fcontext)
-			if con:
-				dict[expr, ftype]=(semanage_context_get_user(con), semanage_context_get_role(con), semanage_context_get_type(con), semanage_context_get_mls(con))
-			else:
-				dict[expr, ftype]=con
+		for idx in range(self.bsize):
+			boolean = semanage_bool_by_idx(self.blist, idx)
+			name = semanage_bool_get_name(boolean)
+			value = semanage_bool_get_value(boolean)
+			dict[name] = value
 
 		return dict
 			
 	def list(self, heading=1):
 		if heading:
-			print "%-50s %-18s %s\n" % ("SELinux fcontext", "type", "Context")
+			print "%-50s %-18s\n" % ("SELinux boolean", "value")
 		dict=self.get_all()
 		keys=dict.keys()
 		for k in keys:
 			if dict[k]:
-				print "%-50s %-18s %s:%s:%s:%s " % (k[0], k[1], dict[k][0], dict[k][1],dict[k][2], dict[k][3])
-			else:
-				print "%-50s %-18s <<None>>" % (k[0], k[1])
-				
-			
+				print "%-50s %-18s " % (k[0], dict[k][0])

--------------060403090406070403070503--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
