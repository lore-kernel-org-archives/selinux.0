Message-ID: <43CE91FC.7040205@redhat.com>
Date: Wed, 18 Jan 2006 14:07:40 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, Joshua Brindle <jbrindle@tresys.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest policycoreutils patch
References: <43CD54B9.4030307@redhat.com> <43CD9BDE.8010005@tresys.com>	 <43CDB89C.4030608@redhat.com> <43CDB8DF.9070100@tresys.com>	 <43CDBA95.8020308@redhat.com> <43CDBB35.6020209@tresys.com>	 <43CDE7ED.4020908@cornell.edu> <43CE6261.8030204@redhat.com>	 <43CE824E.6010904@cornell.edu>  <43CE8520.5050008@cornell.edu>	 <1137609022.8926.194.camel@moss-spartans.epoch.ncsc.mil>	 <43CE8AB3.1070103@cornell.edu> <1137610343.8926.202.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1137610343.8926.202.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------000906020508060607080202"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000906020508060607080202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

chcat -L -l  now uses getseuserbyname.

chcat verifies all users exist

cut and paste errors in error messages in seobject.py

Fixes to seobject.py to return ports in two different formats for use 
with system-config-selinux ...

Better error reporting with setsebool



--------------000906020508060607080202
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/chcat policycoreutils-1.29.8/scripts/chcat
--- nsapolicycoreutils/scripts/chcat	2006-01-18 11:12:43.000000000 -0500
+++ policycoreutils-1.29.8/scripts/chcat	2006-01-18 13:52:39.000000000 -0500
@@ -281,6 +281,7 @@
 	print "Usage %s -d File ..." % sys.argv[0]
 	print "Usage %s -l -d user ..." % sys.argv[0]
 	print "Usage %s -L" % sys.argv[0]
+	print "Usage %s -L -l user" % sys.argv[0]
         print "Use -- to end option list.  For example"
         print "chcat -- -CompanyConfidential /docs/businessplan.odt"
         print "chcat -l +CompanyConfidential juser"
@@ -298,12 +299,8 @@
     return 0
     
 def listusercats(users):
-    seusers = seobject.loginRecords().get_all()
     for u in users:
-        if u in seusers.keys():
-            cats=seobject.translate(seusers[u][1])
-        else:
-            cats=seobject.translate(seusers["__default__"][1])
+        cats=seobject.translate(selinux.getseuserbyname(u)[2])
         cats=cats.split("-")
         if len(cats) > 1 and cats[1] != "s0":
             print "%s: %s" % (u, cats[1])
@@ -350,10 +347,17 @@
     if delete_ind:
         sys.exit(chcat_replace(["s0"], ["s0"], cmds, login_ind))
 
+    if login_ind:
+        if len(cmds) >= 1:
+            for u in cmds:
+                try:
+                    pwd.getpwnam(u)
+                except KeyError, e:
+                    error( "User %s does not exist" % u)
+        else:
+            cmds.append(os.getlogin())
     if list_ind:
         if login_ind:
-            if len(cmds) < 1:
-                usage()
             sys.exit(listusercats(cmds))
         else:
             if len(cmds) > 0:
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/semanage/seobject.py policycoreutils-1.29.8/semanage/seobject.py
--- nsapolicycoreutils/semanage/seobject.py	2006-01-18 11:12:43.000000000 -0500
+++ policycoreutils-1.29.8/semanage/seobject.py	2006-01-18 13:26:43.000000000 -0500
@@ -421,11 +421,11 @@
 
 		rc = semanage_port_modify_local(self.sh, k, p)
 		if rc < 0:
-			raise ValueError("Failed to add port %s/%s" % (proto, port))
+			raise ValueError("Failed to modify port %s/%s" % (proto, port))
 	
 		rc = semanage_commit(self.sh)
 		if rc < 0:
-			raise ValueError("Failed to add port %s/%s" % (proto, port))
+			raise ValueError("Failed to modify port %s/%s" % (proto, port))
 
 	def modify(self, port, proto, serange, setype):
 		if serange == "" and setype == "":
@@ -458,7 +458,7 @@
 
 		rc = semanage_commit(self.sh)
 		if rc < 0:
-			raise ValueError("Failed to add port %s/%s" % (proto, port))
+			raise ValueError("Failed to modify port %s/%s" % (proto, port))
 		
 	def delete(self, port, proto):
 		( k, proto_d, low, high ) = self.__genkey(port, proto)
@@ -491,22 +491,44 @@
 		for idx in range(self.psize):
 			u = semanage_port_by_idx(self.plist, idx)
 			con = semanage_port_get_con(u)
-			name = semanage_context_get_type(con)
+			type = semanage_context_get_type(con)
+			if type == "reserved_port_t":
+				continue
+			level = semanage_context_get_mls(con)
 			proto=semanage_port_get_proto_str(u)
 			low=semanage_port_get_low(u)
 			high = semanage_port_get_high(u)
-			if (name, proto) not in dict.keys():
-				dict[(name,proto)]=[]
+			dict[(low, high)]=(type, proto, level)
+		return dict
+
+	def get_all_by_type(self):
+		dict={}
+		(rc, self.plist, self.psize) = semanage_port_list(self.sh)
+		if rc < 0:
+			raise ValueError("Could not list ports")
+
+		for idx in range(self.psize):
+			u = semanage_port_by_idx(self.plist, idx)
+			con = semanage_port_get_con(u)
+			type = semanage_context_get_type(con)
+			if type == "reserved_port_t":
+				continue
+			level = semanage_context_get_mls(con)
+			proto=semanage_port_get_proto_str(u)
+			low=semanage_port_get_low(u)
+			high = semanage_port_get_high(u)
+			if (type, proto) not in dict.keys():
+				dict[(type,proto)]=[]
 			if low == high:
-				dict[(name,proto)].append("%d" % low)
+				dict[(type,proto)].append("%d" % low)
 			else:
-				dict[(name,proto)].append("%d-%d" % (low, high))
+				dict[(type,proto)].append("%d-%d" % (low, high))
 		return dict
 
 	def list(self, heading=1):
 		if heading:
-			print "%-30s %-8s %s\n" % ("SELinux Port Name", "Proto", "Port Number")
-		dict=self.get_all()
+			print "%-30s %-8s %s\n" % ("SELinux Port Type", "Proto", "Port Number")
+		dict=self.get_all_by_type()
 		keys=dict.keys()
 		keys.sort()
 		for i in keys:
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/setsebool/setsebool.c policycoreutils-1.29.8/setsebool/setsebool.c
--- nsapolicycoreutils/setsebool/setsebool.c	2006-01-04 13:07:46.000000000 -0500
+++ policycoreutils-1.29.8/setsebool/setsebool.c	2006-01-18 13:27:42.000000000 -0500
@@ -130,7 +130,7 @@
 
 	for (j = 0; j < boolcnt; j++) {
 		
-		if (semanage_bool_create(handle, &boolean) < 0)
+		if (semanage_bool_create(handle, &boolean) < 0) 
 			goto err;
 
 		if (semanage_bool_set_name(handle, boolean, boollist[j].name) < 0)
@@ -144,9 +144,10 @@
 		if (permanent && semanage_bool_modify_local(handle, bool_key, boolean) < 0)
 			goto err;
 
-		if (semanage_bool_set_active(handle, bool_key, boolean) < 0)
+		if (semanage_bool_set_active(handle, bool_key, boolean) < 0) {
+			fprintf(stderr, "Could not change boolean %s\n", boollist[j].name);
 			goto err;
-
+		}
 		semanage_bool_key_free(bool_key);
 		semanage_bool_free(boolean);
 		bool_key = NULL;

--------------000906020508060607080202--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
