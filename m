Message-ID: <43D0383C.8010404@cornell.edu>
Date: Thu, 19 Jan 2006 18:09:16 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Further bugfixes
Content-Type: multipart/mixed;
 boundary="------------060105070804010002060303"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060105070804010002060303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changelog:

- UI:
      - fix Usage() for file contexts, rename some other things
      - document -P --proto option
      - "Failed to" -> "Could not" for consistency in error messages

- CLEANUP:
       - remove statement with no effect in validate_level(), and some 
unused variables
       - make pychecker happy - don't shadow "dict", "type", and "range"
       - rename p variable according to the object - only use p for ports

- IMPROVEMENTS:
       - audit rc value for exists funtions, semanage_connect()
       - free key and object on add/modify/delete

- BUGFIX:
        - fix delete if/else bug I introduced with my last patch

Notes:
- there's more memory management to be added, particularly disconnect() 
and handle_destroy() need to be called as Joshua noted, list() probably 
leaks lots of memory
- role modifications still don't clear the previous roles
- -R with multiple roles does not work
- port ranges do not work

--------------060105070804010002060303
Content-Type: text/x-patch;
 name="semanage.bugfixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="semanage.bugfixes.diff"

diff -Naurp --exclude-from excludes old/policycoreutils/semanage/semanage new/policycoreutils/semanage/semanage
--- old/policycoreutils/semanage/semanage	2006-01-19 16:49:47.000000000 -0700
+++ new/policycoreutils/semanage/semanage	2006-01-19 17:50:27.000000000 -0700
@@ -30,10 +30,10 @@ if __name__ == '__main__':
 
 	def usage(message = ""):
 		print '\
-semanage fcontext [-admhfrst] INTERFACE\n\
-semanage interface [-admtr] INTERFACE\n\
+semanage fcontext [-admhfrst] CONTEXT_EXPRESSION\n\
+semanage interface [-admtr] INTERFACE_NAME\n\
 semanage login [-admsr] LOGIN_NAME\n\
-semanage port [-admtpr] PORT | PORTRANGE\n\
+semanage port [-admtpr] PORT | PORT_RANGE\n\
 semanage translation [-adm] LEVEL\n\
 semanage user [-admLRr] SELINUX_USER\n\
 	-a, --add        Add a OBJECT record NAME\n\
@@ -44,6 +44,7 @@ semanage user [-admLRr] SELINUX_USER\n\
 	-L, --level      Default SELinux Level\n\
 	-n, --noheading  Do not print heading when listing OBJECTS\n\
 	-m, --modify     Modify a OBJECT record NAME\n\
+	-P, --proto      Port protocol\n\
 	-r, --range      MLS/MCS Security Range\n\
 	-R, --roles      SELinux Roles (Separate by spaces)\n\
 	-s, --seuser     SELinux user name\n\
@@ -235,7 +236,7 @@ semanage user [-admLRr] SELINUX_USER\n\
 			if object == "port":
 				OBJECT.delete(target, proto)
 
-			if object == "fcontext":
+			elif object == "fcontext":
 				OBJECT.delete(target, ftype)
 
 			else:
diff -Naurp --exclude-from excludes old/policycoreutils/semanage/seobject.py new/policycoreutils/semanage/seobject.py
--- old/policycoreutils/semanage/seobject.py	2006-01-19 16:49:47.000000000 -0700
+++ new/policycoreutils/semanage/seobject.py	2006-01-19 17:58:36.000000000 -0700
@@ -27,9 +27,8 @@ from semanage import *;
 def validate_level(raw):
 	sensitivity="s([0-9]|1[0-5])"
 	category="c(1?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])"
-	range=category + "(\." + category +")?"
-	categories = range + "(\," + range + ")*"
-	sensitivity + "(:categies)?"
+	cat_range=category + "(\." + category +")?"
+	categories = cat_range + "(\," + cat_range + ")*"
 	reg = sensitivity + "(-" + sensitivity + ")?" + "(:" + categories + ")?"
 	return re.search("^" + reg +"$",raw)
 
@@ -52,7 +51,8 @@ def untranslate(trans, prepend=1):
  	if prepend == 1:
 		context="a:b:c:%s" % trans
 	else:
-		context=raw
+		context = trans
+
 	(rc, raw)=selinux.selinux_trans_to_raw_context(context)
 	if rc != 0:
 		return trans
@@ -69,7 +69,7 @@ class setransRecords:
 		fd=open(self.filename, "r")
 		translations=fd.read().split('\n')
 		fd.close()
-		self.dict={}
+		self.ddict={}
 		self.comments=[]
 		for r in translations:
 			if len(r) == 0:
@@ -82,28 +82,28 @@ class setransRecords:
 			if len(i) != 2:
 				self.comments.append(r)
 				continue
-			self.dict[i[0]] = i[1]
+			self.ddict[i[0]] = i[1]
 
 	def get_all(self):
-		return self.dict
+		return self.ddict
 
 	def out(self):
 		rec=""
 		for c in self.comments:
 			rec+=c +"\n"
-		keys=self.dict.keys()
+		keys=self.ddict.keys()
 		keys.sort()
 		for k in keys:
-			rec += "%s=%s\n" %  (k, self.dict[k])
+			rec += "%s=%s\n" %  (k, self.ddict[k])
 		return rec
 	
 	def list(self,heading=1):
 		if heading:
 			print "\n%-25s %s\n" % ("Level", "Translation")
-		keys=self.dict.keys()
+		keys=self.ddict.keys()
 		keys.sort()
 		for k in keys:
-			print "%-25s %s" % (k, self.dict[k])
+			print "%-25s %s" % (k, self.ddict[k])
 		
 	def add(self, raw, trans):
 		if trans.find(" ") >= 0:
@@ -112,24 +112,24 @@ class setransRecords:
 		if validate_level(raw)  == None:
 			raise ValueError("Invalid Level '%s' " % raw)
 		
-		if self.dict.has_key(raw):
+		if self.ddict.has_key(raw):
 			raise ValueError("%s already defined in translations" % raw)
 		else:
-			self.dict[raw]=trans
+			self.ddict[raw]=trans
 		self.save()
 	
 	def modify(self, raw, trans):
 		if trans.find(" ") >= 0:
 
 			raise ValueError("Translations can not contain spaces '%s' " % trans)
-		if self.dict.has_key(raw):
-			self.dict[raw]=trans
+		if self.ddict.has_key(raw):
+			self.ddict[raw]=trans
 		else:
 			raise ValueError("%s not defined in translations" % raw)
 		self.save()
 		
 	def delete(self, raw):
-		self.dict.pop(raw)
+		self.ddict.pop(raw)
 		self.save()
 
 	def save(self):
@@ -144,7 +144,9 @@ class semanageRecords:
 		self.sh = semanage_handle_create()
 		self.semanaged = semanage_is_managed(self.sh)
 		if self.semanaged:
-			semanage_connect(self.sh)
+			rc = semanage_connect(self.sh)
+			if rc < 0:
+				raise ValueError("Could not establish semanage connection")
 
 class loginRecords(semanageRecords):
 	def __init__(self):
@@ -164,6 +166,8 @@ class loginRecords(semanageRecords):
 			raise ValueError("Could not create a key for %s" % name)
 
 		(rc,exists) = semanage_seuser_exists(self.sh, k)
+		if rc < 0:
+			raise ValueError("Could not check if login mapping for %s is defined" % name)
 		if exists:
 			raise ValueError("Login mapping for %s is already defined" % name)
 		try:
@@ -193,11 +197,14 @@ class loginRecords(semanageRecords):
 
 		rc = semanage_seuser_modify(self.sh, k, u)
 		if rc < 0:
-			raise ValueError("Failed to add login mapping for %s" % name)
+			raise ValueError("Could not add login mapping for %s" % name)
 
 		rc = semanage_commit(self.sh) 
 		if rc < 0:
-			raise ValueError("Failed to add login mapping for %s" % name)
+			raise ValueError("Could not add login mapping for %s" % name)
+
+		semanage_seuser_key_free(k)
+		semanage_seuser_free(u)
 
 	def modify(self, name, sename = "", serange = ""):
 		if sename == "" and serange == "":
@@ -208,6 +215,8 @@ class loginRecords(semanageRecords):
 			raise ValueError("Could not create a key for %s" % name)
 
 		(rc,exists) = semanage_seuser_exists(self.sh, k)
+		if rc < 0:
+			raise ValueError("Could not check if login mapping for %s is defined" % name)
 		if not exists:
 			raise ValueError("Login mapping for %s is not defined" % name)
 
@@ -226,11 +235,14 @@ class loginRecords(semanageRecords):
 
 		rc = semanage_seuser_modify(self.sh, k, u)
 		if rc < 0:
-			raise ValueError("Failed to modify login mapping for %s" % name)
+			raise ValueError("Could not modify login mapping for %s" % name)
 	
 		rc = semanage_commit(self.sh)
 		if rc < 0:
-			raise ValueError("Failed to modify login mapping for %s" % name)
+			raise ValueError("Could not modify login mapping for %s" % name)
+
+		semanage_seuser_key_free(k)
+		semanage_seuser_free(u)
 
 	def delete(self, name):
 		(rc,k) = semanage_seuser_key_create(self.sh, name)
@@ -238,6 +250,8 @@ class loginRecords(semanageRecords):
 			raise ValueError("Could not create a key for %s" % name)
 
 		(rc,exists) = semanage_seuser_exists(self.sh, k)
+		if rc < 0:
+			raise ValueError("Could not check if login mapping for %s is defined" % name)
 		if not exists:
 			raise ValueError("Login mapping for %s is not defined" % name)
 
@@ -247,14 +261,17 @@ class loginRecords(semanageRecords):
 
 		rc = semanage_seuser_del(self.sh, k)
 		if rc < 0:
-			raise ValueError("Failed to delete login mapping for %s" % name)
+			raise ValueError("Could not delete login mapping for %s" % name)
 
 		rc = semanage_commit(self.sh)
 		if rc < 0:
-			raise ValueError("Failed to delete login mapping for %s" % name)
+			raise ValueError("Could not delete login mapping for %s" % name)
+	
+		semanage_seuser_key_free(k)
+
 		
 	def get_all(self):
-		dict={}
+		ddict={}
 		(rc, self.ulist, self.usize) = semanage_seuser_list(self.sh)
 		if rc < 0:
 			raise ValueError("Could not list login mappings")
@@ -262,17 +279,17 @@ class loginRecords(semanageRecords):
 		for idx in range(self.usize):
 			u = semanage_seuser_by_idx(self.ulist, idx)
 			name = semanage_seuser_get_name(u)
-			dict[name]=(semanage_seuser_get_sename(u), semanage_seuser_get_mlsrange(u))
-		return dict
+			ddict[name]=(semanage_seuser_get_sename(u), semanage_seuser_get_mlsrange(u))
+		return ddict
 
 	def list(self,heading=1):
 		if heading:
 			print "\n%-25s %-25s %-25s\n" % ("Login Name", "SELinux User", "MLS/MCS Range")
-		dict=self.get_all()
-		keys=dict.keys()
+		ddict=self.get_all()
+		keys=ddict.keys()
 		keys.sort()
 		for k in keys:
-			print "%-25s %-25s %-25s" % (k, dict[k][0], translate(dict[k][1]))
+			print "%-25s %-25s %-25s" % (k, ddict[k][0], translate(ddict[k][1]))
 
 class seluserRecords(semanageRecords):
 	def __init__(self):
@@ -294,6 +311,8 @@ class seluserRecords(semanageRecords):
 			raise ValueError("Could not create a key for %s" % name)
 
 		(rc,exists) = semanage_user_exists(self.sh, k)
+		if rc < 0:
+			raise ValueError("Could not check if SELinux user %s is defined" % name)
 		if exists:
 			raise ValueError("SELinux user %s is already defined" % name)
 
@@ -328,11 +347,14 @@ class seluserRecords(semanageRecords):
 
 		rc = semanage_user_modify_local(self.sh, k, u)
 		if rc < 0:
-			raise ValueError("Failed to add SELinux user %s" % name)
+			raise ValueError("Could not add SELinux user %s" % name)
 
 		rc = semanage_commit(self.sh)
 		if rc < 0:
-			raise ValueError("Failed to add SELinux user %s" % name)
+			raise ValueError("Could not add SELinux user %s" % name)
+
+		semanage_user_key_free(k)
+		semanage_user_free(u)
 
 	def modify(self, name, roles = [], selevel = "", serange = ""):
 		if len(roles) == 0  and serange == "" and selevel == "":
@@ -343,6 +365,8 @@ class seluserRecords(semanageRecords):
 			raise ValueError("Could not create a key for %s" % name)
 
 		(rc,exists) = semanage_user_exists(self.sh, k)
+		if rc < 0:
+			raise ValueError("Could not check if SELinux user %s is defined" % name)
 		if not exists:
 			raise ValueError("SELinux user %s is not defined" % name)
 		
@@ -365,22 +389,29 @@ class seluserRecords(semanageRecords):
 
 		rc = semanage_user_modify_local(self.sh, k, u)
 		if rc < 0:
-			raise ValueError("Failed to modify SELinux user %s" % name)
+			raise ValueError("Could not modify SELinux user %s" % name)
 
 		rc = semanage_commit(self.sh)
 		if rc < 0:
-			raise ValueError("Failed to modify SELinux user %s" % name)
+			raise ValueError("Could not modify SELinux user %s" % name)
 		
+		semanage_user_key_free(k)
+		semanage_user_free(u)
+
 	def delete(self, name):
 		(rc,k) = semanage_user_key_create(self.sh, name)
 		if rc < 0:
 			raise ValueError("Could not create a key for %s" % name)
 
 		(rc,exists) = semanage_user_exists(self.sh, k)
+		if rc < 0:
+			raise ValueError("Could not check if SELinux user %s is defined" % name)		
 		if not exists:
 			raise ValueError("SELinux user %s is not defined" % name)
 
 		(rc,exists) = semanage_user_exists_local(self.sh, k)
+		if rc < 0:
+			raise ValueError("Could not check if SELinux user %s is defined" % name)
 		if not exists:
 			raise ValueError("SELinux user %s is defined in policy, cannot be deleted" % name)
 			
@@ -390,14 +421,16 @@ class seluserRecords(semanageRecords):
 
 		rc = semanage_user_del_local(self.sh, k)
 		if rc < 0:
-			raise ValueError("Failed to delete SELinux user %s" % name)
+			raise ValueError("Could not delete SELinux user %s" % name)
 
 		rc = semanage_commit(self.sh)
 		if rc < 0:
-			raise ValueError("Failed to delete SELinux user %s" % name)
+			raise ValueError("Could not delete SELinux user %s" % name)
 		
+		semanage_user_key_free(k)		
+
 	def get_all(self):
-		dict={}
+		ddict={}
 		(rc, self.ulist, self.usize) = semanage_user_list(self.sh)
 		if rc < 0:
 			raise ValueError("Could not list SELinux users")
@@ -415,19 +448,19 @@ class seluserRecords(semanageRecords):
 				roles += char_by_idx(rlist, 0)
 				for ridx in range (1,rlist_size):
 					roles += " " + char_by_idx(rlist, ridx)
-			dict[semanage_user_get_name(u)] = (semanage_user_get_mlslevel(u), semanage_user_get_mlsrange(u), roles)
+			ddict[semanage_user_get_name(u)] = (semanage_user_get_mlslevel(u), semanage_user_get_mlsrange(u), roles)
 
-		return dict
+		return ddict
 
 	def list(self, heading=1):
 		if heading:
 			print "\n%-15s %-10s %-30s" % ("", "MLS/", "MLS/")
 			print "%-15s %-10s %-30s %s\n" % ("SELinux User", "MCS Level", "MCS Range", "SELinux Roles")
-		dict=self.get_all()
-		keys=dict.keys()
+		ddict=self.get_all()
+		keys=ddict.keys()
 		keys.sort()
 		for k in keys:
-			print "%-15s %-10s %-30s %s" % (k, translate(dict[k][0]), translate(dict[k][1]), dict[k][2])
+			print "%-15s %-10s %-30s %s" % (k, translate(ddict[k][0]), translate(ddict[k][1]), ddict[k][2])
 
 class portRecords(semanageRecords):
 	def __init__(self):
@@ -469,6 +502,8 @@ class portRecords(semanageRecords):
 		( k, proto_d, low, high ) = self.__genkey(port, proto)			
 
 		(rc,exists) = semanage_port_exists(self.sh, k)
+		if rc < 0:
+			raise ValueError("Could not check if port %s/%s is defined" % (proto, port))
 		if exists:
 			raise ValueError("Port %s/%s already defined" % (proto, port))
 
@@ -506,11 +541,14 @@ class portRecords(semanageRecords):
 
 		rc = semanage_port_modify_local(self.sh, k, p)
 		if rc < 0:
-			raise ValueError("Failed to add port %s/%s" % (proto, port))
+			raise ValueError("Could not add port %s/%s" % (proto, port))
 	
 		rc = semanage_commit(self.sh)
 		if rc < 0:
-			raise ValueError("Failed to add port %s/%s" % (proto, port))
+			raise ValueError("Could not add port %s/%s" % (proto, port))
+
+		semanage_port_key_free(k)
+		semanage_port_free(p)
 
 	def modify(self, port, proto, serange, setype):
 		if serange == "" and setype == "":
@@ -519,6 +557,8 @@ class portRecords(semanageRecords):
 		( k, proto_d, low, high ) = self.__genkey(port, proto)
 
 		(rc,exists) = semanage_port_exists(self.sh, k)
+		if rc < 0:
+			raise ValueError("Could not check if port %s/%s is defined" % (proto, port))
 		if not exists:
 			raise ValueError("Port %s/%s is not defined" % (proto,port))
 	
@@ -539,19 +579,26 @@ class portRecords(semanageRecords):
 
 		rc = semanage_port_modify_local(self.sh, k, p)
 		if rc < 0:
-			raise ValueError("Failed to modify port %s/%s" % (proto, port))
+			raise ValueError("Could not modify port %s/%s" % (proto, port))
 
 		rc = semanage_commit(self.sh)
 		if rc < 0:
-			raise ValueError("Failed to modify port %s/%s" % (proto, port))
+			raise ValueError("Could not modify port %s/%s" % (proto, port))
 		
+		semanage_port_key_free(k)
+		semanage_port_free(p)
+
 	def delete(self, port, proto):
 		( k, proto_d, low, high ) = self.__genkey(port, proto)
 		(rc,exists) = semanage_port_exists(self.sh, k)
+		if rc < 0:
+			raise ValueError("Could not check if port %s/%s is defined" % (proto, port))
 		if not exists:
 			raise ValueError("Port %s/%s is not defined" % (proto, port))
 		
 		(rc,exists) = semanage_port_exists_local(self.sh, k)
+		if rc < 0:
+			raise ValueError("Could not check if port %s/%s is defined" % (proto, port))
 		if not exists:
 			raise ValueError("Port %s/%s is defined in policy, cannot be deleted" % (proto, port))
 
@@ -567,8 +614,10 @@ class portRecords(semanageRecords):
 		if rc < 0:
 			raise ValueError("Could not delete port %s/%s" % (proto, port))
 		
+		semanage_port_key_free(k)
+
 	def get_all(self):
-		dict={}
+		ddict={}
 		(rc, self.plist, self.psize) = semanage_port_list(self.sh)
 		if rc < 0:
 			raise ValueError("Could not list ports")
@@ -576,18 +625,18 @@ class portRecords(semanageRecords):
 		for idx in range(self.psize):
 			u = semanage_port_by_idx(self.plist, idx)
 			con = semanage_port_get_con(u)
-			type = semanage_context_get_type(con)
-			if type == "reserved_port_t":
+			ctype = semanage_context_get_type(con)
+			if ctype == "reserved_port_t":
 				continue
 			level = semanage_context_get_mls(con)
 			proto=semanage_port_get_proto_str(u)
 			low=semanage_port_get_low(u)
 			high = semanage_port_get_high(u)
-			dict[(low, high)]=(type, proto, level)
-		return dict
+			ddict[(low, high)]=(ctype, proto, level)
+		return ddict
 
 	def get_all_by_type(self):
-		dict={}
+		ddict={}
 		(rc, self.plist, self.psize) = semanage_port_list(self.sh)
 		if rc < 0:
 			raise ValueError("Could not list ports")
@@ -595,31 +644,30 @@ class portRecords(semanageRecords):
 		for idx in range(self.psize):
 			u = semanage_port_by_idx(self.plist, idx)
 			con = semanage_port_get_con(u)
-			type = semanage_context_get_type(con)
-			if type == "reserved_port_t":
+			ctype = semanage_context_get_type(con)
+			if ctype == "reserved_port_t":
 				continue
-			level = semanage_context_get_mls(con)
-			proto=semanage_port_get_proto_str(u)
-			low=semanage_port_get_low(u)
+			proto = semanage_port_get_proto_str(u)
+			low = semanage_port_get_low(u)
 			high = semanage_port_get_high(u)
-			if (type, proto) not in dict.keys():
-				dict[(type,proto)]=[]
+			if (ctype, proto) not in ddict.keys():
+				ddict[(ctype,proto)]=[]
 			if low == high:
-				dict[(type,proto)].append("%d" % low)
+				ddict[(ctype,proto)].append("%d" % low)
 			else:
-				dict[(type,proto)].append("%d-%d" % (low, high))
-		return dict
+				ddict[(ctype,proto)].append("%d-%d" % (low, high))
+		return ddict
 
 	def list(self, heading=1):
 		if heading:
 			print "%-30s %-8s %s\n" % ("SELinux Port Type", "Proto", "Port Number")
-		dict=self.get_all_by_type()
-		keys=dict.keys()
+		ddict=self.get_all_by_type()
+		keys=ddict.keys()
 		keys.sort()
 		for i in keys:
 			rec = "%-30s %-8s " % i
-			rec += "%s" % dict[i][0]
-			for p in dict[i][1:]:
+			rec += "%s" % ddict[i][0]
+			for p in ddict[i][1:]:
 				rec += ", %s" % p
 			print rec
 
@@ -627,13 +675,13 @@ class interfaceRecords(semanageRecords):
 	def __init__(self):
 		semanageRecords.__init__(self)
 
-	def add(self, interface, serange, type):
+	def add(self, interface, serange, ctype):
 		if serange == "":
 			serange="s0"
 		else:
 			serange=untranslate(serange)
 			
-		if type == "":
+		if ctype == "":
 			raise ValueError("SELinux Type is required")
 
 		(rc,k) = semanage_iface_key_create(self.sh, interface)
@@ -641,6 +689,8 @@ class interfaceRecords(semanageRecords):
 			raise ValueError("Could not create key for %s" % interface)
 
 		(rc,exists) = semanage_iface_exists(self.sh, k)
+		if rc < 0:
+			raise ValueError("Could not check if interface %s is defined" % interface)
 		if exists:
 			raise ValueError("Interface %s already defined" % interface)
 
@@ -661,7 +711,7 @@ class interfaceRecords(semanageRecords):
 		if rc < 0:
 			raise ValueError("Could not set role in interface context for %s" % interface)
 
-		rc = semanage_context_set_type(self.sh, con, type)
+		rc = semanage_context_set_type(self.sh, con, ctype)
 		if rc < 0:
 			raise ValueError("Could not set type in interface context for %s" % interface)
 
@@ -682,11 +732,14 @@ class interfaceRecords(semanageRecords):
 
 		rc = semanage_iface_modify_local(self.sh, k, iface)
 		if rc < 0:
-			raise ValueError("Failed to add interface %s" % interface)
+			raise ValueError("Could not add interface %s" % interface)
 
 		rc = semanage_commit(self.sh)
 		if rc < 0:
-			raise ValueError("Failed to add interface %s" % interface)
+			raise ValueError("Could not add interface %s" % interface)
+
+		semanage_iface_key_free(k)
+		semanage_iface_free(iface)
 
 	def modify(self, interface, serange, setype):
 		if serange == "" and setype == "":
@@ -697,14 +750,16 @@ class interfaceRecords(semanageRecords):
 			raise ValueError("Could not create key for %s" % interface)
 
 		(rc,exists) = semanage_iface_exists(self.sh, k)
+		if rc < 0:
+			raise ValueError("Could not check if interface %s is defined" % interface)
 		if not exists:
 			raise ValueError("Interface %s is not defined" % interface)
 	
-		(rc,p) = semanage_iface_query(self.sh, k)
+		(rc,iface) = semanage_iface_query(self.sh, k)
 		if rc < 0:
 			raise ValueError("Could not query interface %s" % interface)
 
-		con = semanage_iface_get_ifcon(p)
+		con = semanage_iface_get_ifcon(iface)
 			
 		if serange != "":
 			semanage_context_set_mls(self.sh, con, untranslate(serange))
@@ -715,13 +770,16 @@ class interfaceRecords(semanageRecords):
 		if rc < 0:
 			raise ValueError("Could not start semanage transaction")
 
-		rc = semanage_iface_modify_local(self.sh, k, p)
+		rc = semanage_iface_modify_local(self.sh, k, iface)
 		if rc < 0:
-			raise ValueError("Failed to modify interface %s" % interface)
+			raise ValueError("Could not modify interface %s" % interface)
 		
 		rc = semanage_commit(self.sh)
 		if rc < 0:
-			raise ValueError("Failed to modify interface %s" % interface)
+			raise ValueError("Could not modify interface %s" % interface)
+
+		semanage_iface_key_free(k)
+		semanage_iface_free(iface)
 
 	def delete(self, interface):
 		(rc,k) = semanage_iface_key_create(self.sh, interface)
@@ -729,10 +787,14 @@ class interfaceRecords(semanageRecords):
 			raise ValueError("Could not create key for %s" % interface)
 
 		(rc,exists) = semanage_iface_exists(self.sh, k)
+		if rc < 0:
+			raise ValueError("Could not check if interface %s is defined" % interface)
 		if not exists:
 			raise ValueError("Interface %s is not defined" % interface)
 
 		(rc,exists) = semanage_iface_exists_local(self.sh, k)
+		if rc < 0:
+			raise ValueError("Could not check if interface %s is defined" % interface)
 		if not exists:
 			raise ValueError("Interface %s is defined in policy, cannot be deleted" % interface)
 
@@ -742,14 +804,16 @@ class interfaceRecords(semanageRecords):
 
 		rc = semanage_iface_del_local(self.sh, k)
 		if rc < 0:
-			raise ValueError("Failed to delete interface %s" % interface)
+			raise ValueError("Could not delete interface %s" % interface)
 
 		rc = semanage_commit(self.sh)
 		if rc < 0:
-			raise ValueError("Failed to delete interface %s" % interface)
+			raise ValueError("Could not delete interface %s" % interface)
 		
+		semanage_iface_key_free(k)
+
 	def get_all(self):
-		dict={}
+		ddict={}
 		(rc, self.plist, self.psize) = semanage_iface_list(self.sh)
 		if rc < 0:
 			raise ValueError("Could not list interfaces")
@@ -757,18 +821,18 @@ class interfaceRecords(semanageRecords):
 		for idx in range(self.psize):
 			interface = semanage_iface_by_idx(self.plist, idx)
 			con = semanage_iface_get_ifcon(interface)
-			dict[semanage_iface_get_name(interface)]=(semanage_context_get_user(con), semanage_context_get_role(con), semanage_context_get_type(con), semanage_context_get_mls(con))
+			ddict[semanage_iface_get_name(interface)]=(semanage_context_get_user(con), semanage_context_get_role(con), semanage_context_get_type(con), semanage_context_get_mls(con))
 
-		return dict
+		return ddict
 			
 	def list(self, heading=1):
 		if heading:
 			print "%-30s %s\n" % ("SELinux Interface", "Context")
-		dict=self.get_all()
-		keys=dict.keys()
+		ddict=self.get_all()
+		keys=ddict.keys()
 		keys.sort()
 		for k in keys:
-			print "%-30s %s:%s:%s:%s " % (k,dict[k][0], dict[k][1],dict[k][2], translate(dict[k][3], False))
+			print "%-30s %s:%s:%s:%s " % (k,ddict[k][0], ddict[k][1],ddict[k][2], translate(ddict[k][3], False))
 			
 class fcontextRecords(semanageRecords):
 	def __init__(self):
@@ -808,6 +872,8 @@ class fcontextRecords(semanageRecords):
 			raise ValueError("Could not create key for %s" % target)
 
 		(rc,exists) = semanage_fcontext_exists(self.sh, k)
+		if rc < 0:
+			raise ValueError("Could not check if file context for %s is defined" % target)
 		if exists:
 			raise ValueError("File context for %s already defined" % target)
 
@@ -845,11 +911,14 @@ class fcontextRecords(semanageRecords):
 
 		rc = semanage_fcontext_modify_local(self.sh, k, fcontext)
 		if rc < 0:
-			raise ValueError("Failed to add file context for %s" % target)
+			raise ValueError("Could not add file context for %s" % target)
 
 		rc = semanage_commit(self.sh)
 		if rc < 0:
-			raise ValueError("Failed to add file context for %s" % target)
+			raise ValueError("Could not add file context for %s" % target)
+
+		semanage_fcontext_key_free(k)
+		semanage_fcontext_free(fcontext)
 
 	def modify(self, target, setype, ftype, serange, seuser):
 		if serange == "" and setype == "" and seuser == "":
@@ -860,14 +929,16 @@ class fcontextRecords(semanageRecords):
 			raise ValueError("Could not create a key for %s" % target)
 
 		(rc,exists) = semanage_fcontext_exists(self.sh, k)
+		if rc < 0:
+			raise ValueError("Could not check if file context for %s is defined" % target)
 		if not exists:
 			raise ValueError("File context for %s is not defined" % target)
 		
-		(rc,p) = semanage_fcontext_query(self.sh, k)
+		(rc,fcontext) = semanage_fcontext_query(self.sh, k)
 		if rc < 0:
 			raise ValueError("Could not query file context for %s" % target)
 
-		con = semanage_fcontext_get_con(p)
+		con = semanage_fcontext_get_con(fcontext)
 			
 		if serange != "":
 			semanage_context_set_mls(self.sh, con, untranslate(serange))
@@ -880,24 +951,31 @@ class fcontextRecords(semanageRecords):
 		if rc < 0:
 			raise ValueError("Could not start semanage transaction")
 
-		rc = semanage_fcontext_modify_local(self.sh, k, p)
+		rc = semanage_fcontext_modify_local(self.sh, k, fcontext)
 		if rc < 0:
-			raise ValueError("Failed to modify file context for %s" % target)
+			raise ValueError("Could not modify file context for %s" % target)
 
 		rc = semanage_commit(self.sh)
 		if rc < 0:
-			raise ValueError("Failed to modify file context for %s" % target)
+			raise ValueError("Could not modify file context for %s" % target)
 		
+		semanage_fcontext_key_free(k)
+		semanage_fcontext_free(fcontext)
+
 	def delete(self, target, ftype):
 		(rc,k) = semanage_fcontext_key_create(self.sh, target, self.file_types[ftype])
 		if rc < 0:
 			raise ValueError("Could not create a key for %s" % target)
 
 		(rc,exists) = semanage_fcontext_exists(self.sh, k)
+		if rc < 0:
+			raise ValueError("Could not check if file context for %s is defined" % target)
 		if not exists:
 			raise ValueError("File context for %s is not defined" % target)
 		
 		(rc,exists) = semanage_fcontext_exists_local(self.sh, k)
+		if rc < 0:
+			raise ValueError("Could not check if file context for %s is defined" % target)
 		if not exists:
 			raise ValueError("File context for %s is defined in policy, cannot be deleted" % target)
 
@@ -907,14 +985,16 @@ class fcontextRecords(semanageRecords):
 
 		rc = semanage_fcontext_del_local(self.sh, k)
 		if rc < 0:
-			raise ValueError("Failed to delete file context for %s" % target)
+			raise ValueError("Could not delete file context for %s" % target)
 
 		rc = semanage_commit(self.sh)
 		if rc < 0:
-			raise ValueError("Failed to delete file context for %s" % target)
+			raise ValueError("Could not delete file context for %s" % target)
 		
+		semanage_fcontext_key_free(k)		
+
 	def get_all(self):
-		dict={}
+		ddict={}
 		(rc, self.plist, self.psize) = semanage_fcontext_list(self.sh)
 		if rc < 0:
 			raise ValueError("Could not list file contexts")
@@ -925,20 +1005,20 @@ class fcontextRecords(semanageRecords):
 			ftype=semanage_fcontext_get_type_str(fcontext)
 			con = semanage_fcontext_get_con(fcontext)
 			if con:
-				dict[expr, ftype]=(semanage_context_get_user(con), semanage_context_get_role(con), semanage_context_get_type(con), semanage_context_get_mls(con))
+				ddict[expr, ftype]=(semanage_context_get_user(con), semanage_context_get_role(con), semanage_context_get_type(con), semanage_context_get_mls(con))
 			else:
-				dict[expr, ftype]=con
+				ddict[expr, ftype]=con
 
-		return dict
+		return ddict
 			
 	def list(self, heading=1):
 		if heading:
 			print "%-50s %-18s %s\n" % ("SELinux fcontext", "type", "Context")
-		dict=self.get_all()
-		keys=dict.keys()
+		ddict=self.get_all()
+		keys=ddict.keys()
 		for k in keys:
-			if dict[k]:
-				print "%-50s %-18s %s:%s:%s:%s " % (k[0], k[1], dict[k][0], dict[k][1],dict[k][2], translate(dict[k][3],False))
+			if ddict[k]:
+				print "%-50s %-18s %s:%s:%s:%s " % (k[0], k[1], ddict[k][0], ddict[k][1],ddict[k][2], translate(ddict[k][3],False))
 			else:
 				print "%-50s %-18s <<None>>" % (k[0], k[1])
 				
@@ -955,6 +1035,8 @@ class booleanRecords(semanageRecords):
 			raise ValueError("Could not create a key for %s" % name)
 
 		(rc,exists) = semanage_bool_exists(self.sh, k)
+		if rc < 0:
+			raise ValueError("Could not check if boolean %s is defined" % name)
 		if not exists:
 			raise ValueError("Boolean %s is not defined" % name)	
 
@@ -972,22 +1054,29 @@ class booleanRecords(semanageRecords):
 
 		rc = semanage_bool_modify_local(self.sh, k, b)
 		if rc < 0:
-			raise ValueError("Failed to modify boolean %s" % name)
+			raise ValueError("Could not modify boolean %s" % name)
 
 		rc = semanage_commit(self.sh)
 		if rc < 0:
-			raise ValueError("Failed to modify boolean %s" % name)
+			raise ValueError("Could not modify boolean %s" % name)
 		
+		semanage_bool_key_free(k)
+		semanage_bool_free(b)
+
 	def delete(self, name):
 		(rc,k) = semanage_bool_key_create(self.sh, name)
 		if rc < 0:
 			raise ValueError("Could not create a key for %s" % name)
 
 		(rc,exists) = semanage_bool_exists(self.sh, k)
+		if rc < 0:
+			raise ValueError("Could not check if boolean %s is defined" % name)
 		if not exists:
 			raise ValueError("Boolean %s is not defined" % name)
 	
 		(rc,exists) = semanage_bool_exists_local(self.sh, k)
+		if rc < 0:
+			raise ValueError("Could not check if boolean %s is defined" % name)
 		if not exists:
 			raise ValueError("Boolean %s is defined in policy, cannot be deleted" % name)
 
@@ -997,14 +1086,16 @@ class booleanRecords(semanageRecords):
 
 		rc = semanage_fcontext_del_local(self.sh, k)
 		if rc < 0:
-			raise ValueError("Failed to delete boolean %s" % name)
+			raise ValueError("Could not delete boolean %s" % name)
 	
 		rc = semanage_commit(self.sh)
 		if rc < 0:
-			raise ValueError("Failed to delete boolean %s" % name)
+			raise ValueError("Could not delete boolean %s" % name)
 		
+		semanage_bool_key_free(k)
+
 	def get_all(self):
-		dict={}
+		ddict={}
 		(rc, self.blist, self.bsize) = semanage_bool_list(self.sh)
 		if rc < 0:
 			raise ValueError("Could not list booleans")
@@ -1013,15 +1104,15 @@ class booleanRecords(semanageRecords):
 			boolean = semanage_bool_by_idx(self.blist, idx)
 			name = semanage_bool_get_name(boolean)
 			value = semanage_bool_get_value(boolean)
-			dict[name] = value
+			ddict[name] = value
 
-		return dict
+		return ddict
 			
 	def list(self, heading=1):
 		if heading:
 			print "%-50s %-18s\n" % ("SELinux boolean", "value")
-		dict=self.get_all()
-		keys=dict.keys()
+		ddict=self.get_all()
+		keys=ddict.keys()
 		for k in keys:
-			if dict[k]:
-				print "%-50s %-18s " % (k[0], dict[k][0])
+			if ddict[k]:
+				print "%-50s %-18s " % (k[0], ddict[k][0])

--------------060105070804010002060303--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
