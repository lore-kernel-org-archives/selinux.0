Message-ID: <43FCAC3F.3010202@redhat.com>
Date: Wed, 22 Feb 2006 13:23:59 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: policycoreutils latest diffs.
Content-Type: multipart/mixed;
 boundary="------------090201010902060000070003"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090201010902060000070003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

audit2allow -

Added (-R/--reference) to audit2allow.  This basically greps through 
reference policy and finds all  matches for a particular
access.  Then outputs them.  It attempts to find the best match.  This 
makes updating reference policy a lot easier.

Changed load_policy to be looked at regardless of the granted flag.

Fixed some -M output so it is easier to cut and paste.

Fixed error handling output.

Handle "msg='avc:" as an AVC message also.  This is output by Userspace 
tools.

Add some checks to semanage and seobject.py to turn off processing on 
non MLS/MCS machines.
(These are untested on a Non MLS/MCS machine, since I do not have access.) 


--------------090201010902060000070003
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/audit2allow/audit2allow policycoreutils-1.29.26/audit2allow/audit2allow
--- nsapolicycoreutils/audit2allow/audit2allow	2005-12-08 12:52:44.000000000 -0500
+++ policycoreutils-1.29.26/audit2allow/audit2allow	2006-02-21 13:48:01.000000000 -0500
@@ -25,6 +25,118 @@
 #
 #  
 import commands, sys, os, pwd, string, getopt, re, selinux
+
+obj="(\{[^\}]*\}|[^ \t:]*)"
+allow_regexp="allow[ \t]+%s[ \t]*%s[ \t]*:[ \t]*%s[ \t]*%s" % (obj, obj, obj, obj)
+
+awk_script='/^[[:blank:]]*interface[[:blank:]]*\(/ {\n\
+        IFACEFILE=FILENAME\n\
+	IFACENAME = gensub("^[[:blank:]]*interface[[:blank:]]*\\\\(\`?","","g",$0);\n\
+	IFACENAME = gensub("\'?,.*$","","g",IFACENAME);\n\
+}\n\
+\n\
+/^[[:blank:]]*allow[[:blank:]]+.*;[[:blank:]]*$/ {\n\
+\n\
+  if ((length(IFACENAME) > 0) && (IFACEFILE == FILENAME)){\n\
+		ALLOW = gensub("^[[:blank:]]*","","g",$0)\n\
+		ALLOW = gensub(";[[:blank:]]*$","","g",$0)\n\
+		print FILENAME "\\t" IFACENAME "\\t" ALLOW;\n\
+	}\n\
+}\
+'
+
+class accessTrans:
+    def __init__(self):
+        self.dict={}
+	try:
+		fd=open("/usr/share/selinux/refpolicy/include/support/obj_perm_sets.spt")
+	except IOError, error:
+		raise IOError("Reference policy generation requires the policy development package.\n%s" % error)
+        records=fd.read().split("\n")
+        regexp="^define *\(`([^']*)' *, *` *\{([^}]*)}'"
+        for r in records:
+            m=re.match(regexp,r)
+            if m!=None:
+                self.dict[m.groups()[0]] = m.groups()[1].split()
+        fd.close()
+    def get(self, var):
+        l=[]
+        for v in var:
+            if v in self.dict.keys():
+                l += self.dict[v]
+            else:
+                if v not in ("{", "}"):
+                    l.append(v)
+        return l
+
+class interfaces:
+    def __init__(self):
+        self.dict={}
+        trans=accessTrans()
+	(input, output) = os.popen2("awk -f - /usr/share/selinux/refpolicy/include/*/*.if 2> /dev/null")
+	input.write(awk_script)
+	input.close()
+	records=output.read().split("\n")
+	input.close()
+        if len(records) > 0:
+            regexp="([^ \t]*)[ \t]+([^ \t]*)[ \t]+%s" % allow_regexp
+            for r in records:
+                m=re.match(regexp,r)
+                if m==None:
+                    continue
+                else:
+                    val=m.groups()
+                file=os.path.basename(val[0]).split(".")[0]
+                iface=val[1]
+                Scon=val[2].split()
+                Tcon=val[3].split()
+                Class=val[4].split()
+                Access=trans.get(val[5].split())
+                for s in Scon:
+                    for t in Tcon:
+                        for c in Class:
+                            if (s, t, c) not in self.dict.keys():
+                                self.dict[(s, t, c)]=[]
+                            self.dict[(s, t, c)].append((Access, file, iface))
+    def out(self):
+        keys=self.dict.keys()
+        keys.sort()
+        for k in keys:
+            print k
+            for i in self.dict[k]:
+                print "\t", i
+                
+    def match(self, Scon, Tcon, Class, Access):
+        keys=self.dict.keys()
+        ret=[]
+        if (Scon, Tcon, Class) in keys:
+            for i in self.dict[(Scon, Tcon, Class)]:
+                if Access in i[0]:
+                    if i[2].find(Access) >= 0:
+                        ret.insert(0, i)
+                    else:
+                        ret.append(i)
+            return ret
+        if ("$1", Tcon, Class) in keys:
+            for i in self.dict[("$1", Tcon, Class)]:
+                if Access in i[0]:
+                    if i[2].find(Access) >= 0:
+                        ret.insert(0, i)
+                    else:
+                        ret.append(i)
+            return ret
+        if (Scon, "$1", Class) in keys:
+            for i in self.dict[(Scon, "$1", Class)]:
+                if Access in i[0]:
+                    if i[2].find(Access) >= 0:
+                        ret.insert(0, i)
+                    else:
+                        ret.append(i)
+            return ret
+        else:
+            return ret
+        
+
 class serule:
 	def __init__(self, type, source, target, seclass):
 		self.type=type
@@ -32,6 +144,8 @@
 		self.target=target
 		self.seclass=seclass
 		self.avcinfo={}
+		self.iface=None
+		
 	def add(self, avc):
 		for a in avc[0]:
 			if a not in self.avcinfo.keys():
@@ -67,6 +181,33 @@
 					ret=ret + " : " + i 
 		return ret
 		
+	def gen_reference_policy(self, iface):
+		ret=""
+		Scon=self.source
+		Tcon=self.gettarget()
+		Class=self.seclass
+		Access=self.getAccess()
+		m=iface.match(Scon,Tcon,Class,Access)
+		if len(m)==0:
+			return self.out()
+		else:
+			file=m[0][1]
+			ret="\n#%s\n"% self.out()
+			ret += "optional_policy(`%s', `\n" % m[0][1]
+			first=True
+			for i in m:
+				if file != i[1]:
+					ret += "')\ngen_require(`%s', `\n" % i[1]
+					file = i[1]
+					first=True
+				if first:
+					ret += "\t%s(%s)\n" % (i[2], Scon)
+					first=False
+				else:
+					ret += "#\t%s(%s)\n" % (i[2], Scon)
+			ret += "');"
+		return ret
+		
 	def gettarget(self):
 		if self.source == self.target:
 			return "self"
@@ -81,7 +222,12 @@
 		self.types=[]
 		self.roles=[]
 		self.load(input, te_ind)
-		
+		self.gen_ref_policy = False
+
+	def gen_reference_policy(self):
+		self.gen_ref_policy = True
+		self.iface=interfaces()
+
 	def warning(self, error):
 		sys.stderr.write("%s: " % sys.argv[0])
 		sys.stderr.write("%s\n" % error)
@@ -104,7 +250,8 @@
 			while line:
 				rec=line.split()
 				for i in rec:
-					if i=="avc:" or i=="message=avc:":
+					if i=="avc:" or i=="message=avc:" or i=="msg='avc:":
+
 						found=1
 					else:
 						avc.append(i)
@@ -182,9 +329,10 @@
 		if "security_compute_sid" in avc:
 			return
 		
+		if "load_policy" in avc and self.last_reload:
+			self.seRules={}
+
 		if "granted" in avc:
-			if "load_policy" in avc and self.last_reload:
-				self.seRules={}
 			return
 		try:
 			for i in range (0, len(avc)):
@@ -292,7 +440,10 @@
 		keys=self.seRules.keys()
 		keys.sort()
 		for i in keys:
-			rec += self.seRules[i].out(verbose)+"\n"
+			if self.gen_ref_policy:
+				rec += self.seRules[i].gen_reference_policy(self.iface)+"\n"
+			else:
+				rec += self.seRules[i].out(verbose)+"\n"
 		return rec
 
 if __name__ == '__main__':
@@ -342,11 +493,12 @@
 		buildPP=0
 		input_ind=0
 		output_ind=0
+		ref_ind=False
 		te_ind=0
 
 		fc_file=""
 		gopts, cmds = getopt.getopt(sys.argv[1:],
-					    'adf:hi:lm:M:o:rtv',
+					    'adf:hi:lm:M:o:rtvR',
 					    ['all',
 					     'dmesg',
 					     'fcfile=',
@@ -356,6 +508,7 @@
 					     'module=',
 					     'output=',
 					     'requires',
+					     'reference',
 					     'tefile',
 					     'verbose'
 					     ])
@@ -397,6 +550,9 @@
 				if auditlogs:
 					usage()
 				te_ind=1
+			if o == "-R" or o == "--reference":
+				ref_ind=True
+				
 			if o == "-o" or o == "--output":
 				if module != ""  or a[0]=="-":
 					usage()
@@ -413,6 +569,10 @@
 			
 		out=seruleRecords(input, last_reload, verbose, te_ind)
 
+
+		if ref_ind:
+			out.gen_reference_policy()
+
 		if auditlogs:
 			input=os.popen("ausearch -m avc")
 			out.load(input)
@@ -423,15 +583,15 @@
 		output.flush()
 		if buildPP:
 			cmd="checkmodule %s -m -o %s.mod %s.te" % (get_mls_flag(), module, module)
-			print "Compiling policy: %s" % cmd
+			print "Compiling policy"
+			print cmd
 			rc=commands.getstatusoutput(cmd)
 			if rc[0]==0:
 				cmd="semodule_package -o %s.pp -m %s.mod" % (module, module)
-				print cmd
 				if fc_file != "":
 					cmd = "%s -f %s" % (cmd, fc_file)
 					
-				print "Building package: %s" % cmd
+				print cmd
 				rc=commands.getstatusoutput(cmd)
 				if rc[0]==0:
 					print ("\n******************** IMPORTANT ***********************\n")
@@ -446,6 +606,6 @@
 	except ValueError, error:
 		errorExit(error.args[0])
 	except IOError, error:
-		errorExit(error.args[1])
+		errorExit(error)
 	except KeyboardInterrupt, error:
 		sys.exit(0)
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/audit2allow/audit2allow.1 policycoreutils-1.29.26/audit2allow/audit2allow.1
--- nsapolicycoreutils/audit2allow/audit2allow.1	2005-12-01 10:11:27.000000000 -0500
+++ policycoreutils-1.29.26/audit2allow/audit2allow.1	2006-02-21 13:48:54.000000000 -0500
@@ -65,6 +65,9 @@
 .B "\-r" | "\-\-requires"
 Generate require output syntax for loadable modules.
 .TP
+.B "\-R" | "\-\-reference"
+Generate reference policy using installed macros
+.TP
 .B "\-t "  | "\-\-tefile"
 Indicates input file is a te (type enforcement) file.  This can be used to translate old te format to new policy format.
 .TP
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/semanage/semanage policycoreutils-1.29.26/semanage/semanage
--- nsapolicycoreutils/semanage/semanage	2006-02-16 13:35:28.000000000 -0500
+++ policycoreutils-1.29.26/semanage/semanage	2006-02-21 13:57:04.000000000 -0500
@@ -22,6 +22,9 @@
 #  
 import os, sys, getopt
 import seobject
+import selinux
+
+is_mls_enabled=selinux.is_selinux_mls_enabled()
 
 if __name__ == '__main__':
 
@@ -57,13 +60,13 @@
 		-p (named pipe) \n\n\
 \
 	-p, --proto      Port protocol (tcp or udp)\n\
-	-L, --level      Default SELinux Level\n\
+	-L, --level      Default SELinux Level (MLS/MCS Systems only)\n\
 	-R, --roles      SELinux Roles (ex: "sysadm_r staff_r")\n\
 	-T, --trans      SELinux Level Translation\n\n\
 \
 	-s, --seuser     SELinux User Name\n\
 	-t, --type       SELinux Type for the object\n\
-	-r, --range      MLS/MCS Security Range\n\
+	-r, --range      MLS/MCS Security Range (MLS/MCS Systems only\n\
 '
 		print message
 		sys.exit(1)
@@ -167,12 +170,16 @@
 				modify = 1
 				
 			if o == "-r" or o == '--range':
+				if is_mls_enabled == 0:
+					errorExit("range not supported on Non MLS machines")
 				serange = a
 
 			if o == "-l" or o == "--list":
 				list = 1
 
 			if o == "-L" or o == '--level':
+				if is_mls_enabled == 0:
+					errorExit("range not supported on Non MLS machines")
 				selevel = a
 
 			if o == "-p" or o == '--proto':
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/semanage/semanage.8 policycoreutils-1.29.26/semanage/semanage.8
--- nsapolicycoreutils/semanage/semanage.8	2006-01-27 01:16:33.000000000 -0500
+++ policycoreutils-1.29.26/semanage/semanage.8	2006-02-20 23:21:37.000000000 -0500
@@ -46,7 +46,7 @@
 List the OBJECTS
 .TP
 .I                \-L, \-\-level
-Default SELinux Level for SELinux use. (s0)
+Default SELinux Level for SELinux use, s0 Default. (MLS/MCS Systems only)
 .TP
 .I                \-m, \-\-modify     
 Modify a OBJECT record NAME
@@ -58,7 +58,7 @@
 Protocol for the specified port (tcp|udp).
 .TP
 .I                \-r, \-\-range      
-MLS/MCS Security Range
+MLS/MCS Security Range (MLS/MCS Systems only)
 .TP
 .I                \-R, \-\-role
 SELinux Roles.  You must enclose multiple roles within quotes, separate by spaces. Or specify \-R multiple times.
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/semanage/seobject.py policycoreutils-1.29.26/semanage/seobject.py
--- nsapolicycoreutils/semanage/seobject.py	2006-02-16 13:35:28.000000000 -0500
+++ policycoreutils-1.29.26/semanage/seobject.py	2006-02-20 23:21:42.000000000 -0500
@@ -21,9 +21,43 @@
 #
 #  
 
-import pwd, string, selinux, tempfile, os, re
+import pwd, string, selinux, tempfile, os, re, sys
 from semanage import *;
 
+is_mls_enabled=selinux.is_selinux_mls_enabled()
+import syslog
+try:
+	import audit
+	class logger:
+		def __init__(self):
+			self.audit_fd=audit.audit_open()
+
+		def log(self, success, msg, name="", sename="", serole="", serange="", old_sename="", old_serole="", old_serange=""):
+			audit.audit_log_semanage_message(self.audit_fd, audit.AUDIT_USER_ROLE_CHANGE, sys.argv[0],msg, name, 0, sename, serole, serange, old_sename, old_serole, old_serange, "", "", "", success);
+except:
+	class logger:
+		def log(self, success, msg, name="", sename="", serole="", serange="", old_sename="", old_serole="", old_serange=""):
+			if success == 1:
+				message = "Successful: "
+			else:
+				message = "Failed: "
+			message += " %s name=%s" % (msg,name)
+			if sename != "":
+				message += " sename=" + sename
+			if old_sename != "":
+				message += " old_sename=" + old_sename
+			if serole != "":
+				message += " role=" + serole
+			if old_serole != "":
+				message += " old_role=" + old_serole
+			if serange != "":
+				message += " MLSRange=" + serange
+			if old_serange != "":
+				message += " old_MLSRange=" + old_serange
+			syslog.syslog(message);
+			
+mylog=logger()		
+
 def validate_level(raw):
 	sensitivity="s([0-9]|1[0-5])"
 	category="c(1?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])"
@@ -143,6 +177,7 @@
 	def __init__(self):
 		self.sh = semanage_handle_create()
 		self.semanaged = semanage_is_managed(self.sh)
+
 		if not self.semanaged:
 			semanage_handle_destroy(self.sh)
 			raise ValueError("SELinux policy is not managed or store cannot be accessed.")
@@ -162,127 +197,154 @@
 		semanageRecords.__init__(self)
 
 	def add(self, name, sename, serange):
-		if serange == "":
-			serange = "s0"
-		else:
-			serange = untranslate(serange)
+		if is_mls_enabled == 1:
+			if serange == "":
+				serange = "s0"
+			else:
+				serange = untranslate(serange)
 			
 		if sename == "":
 			sename = "user_u"
 			
-		(rc,k) = semanage_seuser_key_create(self.sh, name)
-		if rc < 0:
-			raise ValueError("Could not create a key for %s" % name)
-
-		(rc,exists) = semanage_seuser_exists(self.sh, k)
-		if rc < 0:
-			raise ValueError("Could not check if login mapping for %s is defined" % name)
-		if exists:
-			raise ValueError("Login mapping for %s is already defined" % name)
 		try:
-			pwd.getpwnam(name)
-		except:
-			raise ValueError("Linux User %s does not exist" % name)
-			
-		(rc,u) = semanage_seuser_create(self.sh)
-		if rc < 0:
-			raise ValueError("Could not create login mapping for %s" % name)
+			(rc,k) = semanage_seuser_key_create(self.sh, name)
+			if rc < 0:
+				raise ValueError("Could not create a key for %s" % name)
 
-		rc = semanage_seuser_set_name(self.sh, u, name)
-		if rc < 0:
-			raise ValueError("Could not set name for %s" % name)
+			(rc,exists) = semanage_seuser_exists(self.sh, k)
+			if rc < 0:
+				raise ValueError("Could not check if login mapping for %s is defined" % name)
+			if exists:
+				raise ValueError("Login mapping for %s is already defined" % name)
+			try:
+				pwd.getpwnam(name)
+			except:
+				raise ValueError("Linux User %s does not exist" % name)
 
-		rc = semanage_seuser_set_mlsrange(self.sh, u, serange)
-		if rc < 0:
-			raise ValueError("Could not set MLS range for %s" % name)
+			(rc,u) = semanage_seuser_create(self.sh)
+			if rc < 0:
+				raise ValueError("Could not create login mapping for %s" % name)
 
-		rc = semanage_seuser_set_sename(self.sh, u, sename)
-		if rc < 0:
-			raise ValueError("Could not set SELinux user for %s" % name)
+			rc = semanage_seuser_set_name(self.sh, u, name)
+			if rc < 0:
+				raise ValueError("Could not set name for %s" % name)
 
-		rc = semanage_begin_transaction(self.sh)
-		if rc < 0:
-			raise ValueError("Could not start semanage transaction")
+			rc = semanage_seuser_set_mlsrange(self.sh, u, serange)
+			if rc < 0:
+				raise ValueError("Could not set MLS range for %s" % name)
 
-		rc = semanage_seuser_modify_local(self.sh, k, u)
-		if rc < 0:
-			raise ValueError("Could not add login mapping for %s" % name)
+			rc = semanage_seuser_set_sename(self.sh, u, sename)
+			if rc < 0:
+				raise ValueError("Could not set SELinux user for %s" % name)
 
-		rc = semanage_commit(self.sh) 
-		if rc < 0:
-			raise ValueError("Could not add login mapping for %s" % name)
+			rc = semanage_begin_transaction(self.sh)
+			if rc < 0:
+				raise ValueError("Could not start semanage transaction")
 
+			rc = semanage_seuser_modify_local(self.sh, k, u)
+			if rc < 0:
+				raise ValueError("Could not add login mapping for %s" % name)
+
+			rc = semanage_commit(self.sh) 
+			if rc < 0:
+				raise ValueError("Could not add login mapping for %s" % name)
+
+		except ValueError, error:
+			mylog.log(0, "add SELinux user mapping", name, sename, "", serange);
+			raise error
+		
+		mylog.log(1, "add SELinux user mapping", name, sename, "", serange);
 		semanage_seuser_key_free(k)
 		semanage_seuser_free(u)
 
 	def modify(self, name, sename = "", serange = ""):
-		if sename == "" and serange == "":
-			raise ValueError("Requires seuser or serange")
+		oldsename=""
+		oldserange=""
+		try:
+			if sename == "" and serange == "":
+				raise ValueError("Requires seuser or serange")
 
-		(rc,k) = semanage_seuser_key_create(self.sh, name)
-		if rc < 0:
-			raise ValueError("Could not create a key for %s" % name)
+			(rc,k) = semanage_seuser_key_create(self.sh, name)
+			if rc < 0:
+				raise ValueError("Could not create a key for %s" % name)
 
-		(rc,exists) = semanage_seuser_exists(self.sh, k)
-		if rc < 0:
-			raise ValueError("Could not check if login mapping for %s is defined" % name)
-		if not exists:
-			raise ValueError("Login mapping for %s is not defined" % name)
+			(rc,exists) = semanage_seuser_exists(self.sh, k)
+			if rc < 0:
+				raise ValueError("Could not check if login mapping for %s is defined" % name)
+			if not exists:
+				raise ValueError("Login mapping for %s is not defined" % name)
 
-		(rc,u) = semanage_seuser_query(self.sh, k)
-		if rc < 0:
-			raise ValueError("Could not query seuser for %s" % name)
+			(rc,u) = semanage_seuser_query(self.sh, k)
+			if rc < 0:
+				raise ValueError("Could not query seuser for %s" % name)
 
-		if serange != "":
-			semanage_seuser_set_mlsrange(self.sh, u, untranslate(serange))
-		if sename != "":
-			semanage_seuser_set_sename(self.sh, u, sename)
+			oldserange=semanage_seuser_get_mlsrange(u)
+			oldsename=semanage_seuser_get_sename(u)
+			if serange != "":
+				semanage_seuser_set_mlsrange(self.sh, u, untranslate(serange))
+			else:
+				serange=oldserange
+			if sename != "":
+				semanage_seuser_set_sename(self.sh, u, sename)
+			else:
+				sename=oldsename
 
-		rc = semanage_begin_transaction(self.sh)
-		if rc < 0:
-			raise ValueError("Could not srart semanage transaction")
+			rc = semanage_begin_transaction(self.sh)
+			if rc < 0:
+				raise ValueError("Could not srart semanage transaction")
 
-		rc = semanage_seuser_modify_local(self.sh, k, u)
-		if rc < 0:
-			raise ValueError("Could not modify login mapping for %s" % name)
-	
-		rc = semanage_commit(self.sh)
-		if rc < 0:
-			raise ValueError("Could not modify login mapping for %s" % name)
+			rc = semanage_seuser_modify_local(self.sh, k, u)
+			if rc < 0:
+				raise ValueError("Could not modify login mapping for %s" % name)
+
+			rc = semanage_commit(self.sh)
+			if rc < 0:
+				raise ValueError("Could not modify login mapping for %s" % name)
 
+		except ValueError, error:
+			mylog.log(0,"modify selinux user mapping", name, sename, "", serange, "", oldsename, "", oldserange);
+			raise error
+		
+		mylog.log(1,"modify selinux user mapping", name, sename, "", serange, "", oldsename, "", oldserange);
 		semanage_seuser_key_free(k)
 		semanage_seuser_free(u)
 
 	def delete(self, name):
-		(rc,k) = semanage_seuser_key_create(self.sh, name)
-		if rc < 0:
-			raise ValueError("Could not create a key for %s" % name)
+		try:
+			(rc,k) = semanage_seuser_key_create(self.sh, name)
+			if rc < 0:
+				raise ValueError("Could not create a key for %s" % name)
 
-		(rc,exists) = semanage_seuser_exists(self.sh, k)
-		if rc < 0:
-			raise ValueError("Could not check if login mapping for %s is defined" % name)
-		if not exists:
-			raise ValueError("Login mapping for %s is not defined" % name)
+			(rc,exists) = semanage_seuser_exists(self.sh, k)
+			if rc < 0:
+				raise ValueError("Could not check if login mapping for %s is defined" % name)
+			if not exists:
+				raise ValueError("Login mapping for %s is not defined" % name)
 
-		(rc,exists) = semanage_seuser_exists_local(self.sh, k)
-		if rc < 0:
-			raise ValueError("Could not check if login mapping for %s is defined" % name)
-		if not exists:
-			raise ValueError("Login mapping for %s is defined in policy, cannot be deleted" % name)
+			(rc,exists) = semanage_seuser_exists_local(self.sh, k)
+			if rc < 0:
+				raise ValueError("Could not check if login mapping for %s is defined" % name)
+			if not exists:
+				raise ValueError("Login mapping for %s is defined in policy, cannot be deleted" % name)
 
-		rc = semanage_begin_transaction(self.sh)
-		if rc < 0:
-			raise ValueError("Could not start semanage transaction")
+			rc = semanage_begin_transaction(self.sh)
+			if rc < 0:
+				raise ValueError("Could not start semanage transaction")
 
-		rc = semanage_seuser_del_local(self.sh, k)
+			rc = semanage_seuser_del_local(self.sh, k)
 
-		if rc < 0:
-			raise ValueError("Could not delete login mapping for %s" % name)
+			if rc < 0:
+				raise ValueError("Could not delete login mapping for %s" % name)
 
-		rc = semanage_commit(self.sh)
-		if rc < 0:
-			raise ValueError("Could not delete login mapping for %s" % name)
-	
+			rc = semanage_commit(self.sh)
+			if rc < 0:
+				raise ValueError("Could not delete login mapping for %s" % name)
+
+		except ValueError, error:
+			mylog.log(0,"delete SELinux user mapping", name);
+			raise error
+		
+		mylog.log(1,"delete SELinux user mapping", name);
 		semanage_seuser_key_free(k)
 
 		
@@ -298,150 +360,179 @@
 		return ddict
 
 	def list(self,heading=1):
-		if heading:
-			print "\n%-25s %-25s %-25s\n" % ("Login Name", "SELinux User", "MLS/MCS Range")
 		ddict=self.get_all()
 		keys=ddict.keys()
 		keys.sort()
-		for k in keys:
-			print "%-25s %-25s %-25s" % (k, ddict[k][0], translate(ddict[k][1]))
+		if is_mls_enabled == 1:
+			if heading:
+				print "\n%-25s %-25s %-25s\n" % ("Login Name", "SELinux User", "MLS/MCS Range")
+			for k in keys:
+				print "%-25s %-25s %-25s" % (k, ddict[k][0], translate(ddict[k][1]))
+		else:
+			if heading:
+				print "\n%-25s %-25s\n" % ("Login Name", "SELinux User")
+			for k in keys:
+				print "%-25s %-25s %-25s" % (k, ddict[k][0])
 
 class seluserRecords(semanageRecords):
 	def __init__(self):
 		semanageRecords.__init__(self)
 
 	def add(self, name, roles, selevel, serange):
-		if serange == "":
-			serange = "s0"
-		else:
-			serange = untranslate(serange)
+		if is_mls_enabled == 1:
+			if serange == "":
+				serange = "s0"
+			else:
+				serange = untranslate(serange)
 			
-		if selevel == "":
-			selevel = "s0"
-		else:
-			selevel = untranslate(selevel)
-
-		(rc,k) = semanage_user_key_create(self.sh, name)
-		if rc < 0:
-			raise ValueError("Could not create a key for %s" % name)
-
-		(rc,exists) = semanage_user_exists(self.sh, k)
-		if rc < 0:
-			raise ValueError("Could not check if SELinux user %s is defined" % name)
-		if exists:
-			raise ValueError("SELinux user %s is already defined" % name)
-
-		(rc,u) = semanage_user_create(self.sh)
-		if rc < 0:
-			raise ValueError("Could not create SELinux user for %s" % name)
+			if selevel == "":
+				selevel = "s0"
+			else:
+				selevel = untranslate(selevel)
+			
+		seroles=" ".join(roles)
+		try:
+			(rc,k) = semanage_user_key_create(self.sh, name)
+			if rc < 0:
+				raise ValueError("Could not create a key for %s" % name)
 
-		rc = semanage_user_set_name(self.sh, u, name)
-		if rc < 0:
-			raise ValueError("Could not set name for %s" % name)
+			(rc,exists) = semanage_user_exists(self.sh, k)
+			if rc < 0:
+				raise ValueError("Could not check if SELinux user %s is defined" % name)
+			if exists:
+				raise ValueError("SELinux user %s is already defined" % name)
 
-		for r in roles:
-			rc = semanage_user_add_role(self.sh, u, r)
+			(rc,u) = semanage_user_create(self.sh)
 			if rc < 0:
-				raise ValueError("Could not add role %s for %s" % (r, name))
+				raise ValueError("Could not create SELinux user for %s" % name)
 
-		rc = semanage_user_set_mlsrange(self.sh, u, serange)
-		if rc < 0:
-			raise ValueError("Could not set MLS range for %s" % name)
+			rc = semanage_user_set_name(self.sh, u, name)
+			if rc < 0:
+				raise ValueError("Could not set name for %s" % name)
 
-		rc = semanage_user_set_mlslevel(self.sh, u, selevel)
-		if rc < 0:
-			raise ValueError("Could not set MLS level for %s" % name)
+			for r in roles:
+				rc = semanage_user_add_role(self.sh, u, r)
+				if rc < 0:
+					raise ValueError("Could not add role %s for %s" % (r, name))
+
+			if is_mls_enabled == 1:
+				rc = semanage_user_set_mlsrange(self.sh, u, serange)
+				if rc < 0:
+					raise ValueError("Could not set MLS range for %s" % name)
+
+				rc = semanage_user_set_mlslevel(self.sh, u, selevel)
+				if rc < 0:
+					raise ValueError("Could not set MLS level for %s" % name)
 
-		(rc,key) = semanage_user_key_extract(self.sh,u)
-		if rc < 0:
-			raise ValueError("Could not extract key for %s" % name)
+			(rc,key) = semanage_user_key_extract(self.sh,u)
+			if rc < 0:
+				raise ValueError("Could not extract key for %s" % name)
 
-		rc = semanage_begin_transaction(self.sh)
-		if rc < 0:
-			raise ValueError("Could not start semanage transaction")
+			rc = semanage_begin_transaction(self.sh)
+			if rc < 0:
+				raise ValueError("Could not start semanage transaction")
 
-		rc = semanage_user_modify_local(self.sh, k, u)
-		if rc < 0:
-			raise ValueError("Could not add SELinux user %s" % name)
+			rc = semanage_user_modify_local(self.sh, k, u)
+			if rc < 0:
+				raise ValueError("Could not add SELinux user %s" % name)
 
-		rc = semanage_commit(self.sh)
-		if rc < 0:
-			raise ValueError("Could not add SELinux user %s" % name)
+			rc = semanage_commit(self.sh)
+			if rc < 0:
+				raise ValueError("Could not add SELinux user %s" % name)
 
+		except ValueError, error:
+			mylog.log(0,"add SELinux user record", name, name, seroles, serange)
+			raise error
+		
+		mylog.log(1,"add SELinux user record", name, name, seroles, serange)
 		semanage_user_key_free(k)
 		semanage_user_free(u)
 
 	def modify(self, name, roles = [], selevel = "", serange = ""):
-		if len(roles) == 0  and serange == "" and selevel == "":
-			raise ValueError("Requires roles, level or range")
+		try:
+			if len(roles) == 0  and serange == "" and selevel == "":
+				if is_mls_enabled == 1:
+					raise ValueError("Requires roles, level or range")
+				else:
+					raise ValueError("Requires roles")
 
-		(rc,k) = semanage_user_key_create(self.sh, name)
-		if rc < 0:
-			raise ValueError("Could not create a key for %s" % name)
+			(rc,k) = semanage_user_key_create(self.sh, name)
+			if rc < 0:
+				raise ValueError("Could not create a key for %s" % name)
 
-		(rc,exists) = semanage_user_exists(self.sh, k)
-		if rc < 0:
-			raise ValueError("Could not check if SELinux user %s is defined" % name)
-		if not exists:
-			raise ValueError("SELinux user %s is not defined" % name)
-		
-		(rc,u) = semanage_user_query(self.sh, k)
-		if rc < 0:
-			raise ValueError("Could not query user for %s" % name)
+			(rc,exists) = semanage_user_exists(self.sh, k)
+			if rc < 0:
+				raise ValueError("Could not check if SELinux user %s is defined" % name)
+			if not exists:
+				raise ValueError("SELinux user %s is not defined" % name)
 
-		if serange != "":
-			semanage_user_set_mlsrange(self.sh, u, untranslate(serange))
-		if selevel != "":
-			semanage_user_set_mlslevel(self.sh, u, untranslate(selevel))
-			
-		if len(roles) != 0:
-			for r in roles:
-				semanage_user_add_role(self.sh, u, r)
+			(rc,u) = semanage_user_query(self.sh, k)
+			if rc < 0:
+				raise ValueError("Could not query user for %s" % name)
 
-		rc = semanage_begin_transaction(self.sh)
-		if rc < 0:
-			raise ValueError("Could not start semanage transaction")
+			if serange != "":
+				semanage_user_set_mlsrange(self.sh, u, untranslate(serange))
+			if selevel != "":
+				semanage_user_set_mlslevel(self.sh, u, untranslate(selevel))
+
+			if len(roles) != 0:
+				for r in roles:
+					semanage_user_add_role(self.sh, u, r)
 
-		rc = semanage_user_modify_local(self.sh, k, u)
-		if rc < 0:
-			raise ValueError("Could not modify SELinux user %s" % name)
+			rc = semanage_begin_transaction(self.sh)
+			if rc < 0:
+				raise ValueError("Could not start semanage transaction")
 
-		rc = semanage_commit(self.sh)
-		if rc < 0:
-			raise ValueError("Could not modify SELinux user %s" % name)
+			rc = semanage_user_modify_local(self.sh, k, u)
+			if rc < 0:
+				raise ValueError("Could not modify SELinux user %s" % name)
+
+			rc = semanage_commit(self.sh)
+			if rc < 0:
+				raise ValueError("Could not modify SELinux user %s" % name)
+
+		except ValueError, error:
+			mylog.log(0,"modify SELinux user record", name, seuser, seroles, serange, oldseuser, oldseroles, olrserange)
+			raise error
 		
+		mylog.log(1,"modify SELinux user record", name, seuser, seroles, serange, oldseuser, oldseroles, olrserange)
 		semanage_user_key_free(k)
 		semanage_user_free(u)
 
 	def delete(self, name):
-		(rc,k) = semanage_user_key_create(self.sh, name)
-		if rc < 0:
-			raise ValueError("Could not create a key for %s" % name)
-
-		(rc,exists) = semanage_user_exists(self.sh, k)
-		if rc < 0:
-			raise ValueError("Could not check if SELinux user %s is defined" % name)		
-		if not exists:
-			raise ValueError("SELinux user %s is not defined" % name)
+		try:
+			(rc,k) = semanage_user_key_create(self.sh, name)
+			if rc < 0:
+				raise ValueError("Could not create a key for %s" % name)
+			
+			(rc,exists) = semanage_user_exists(self.sh, k)
+			if rc < 0:
+				raise ValueError("Could not check if SELinux user %s is defined" % name)		
+			if not exists:
+				raise ValueError("SELinux user %s is not defined" % name)
 
-		(rc,exists) = semanage_user_exists_local(self.sh, k)
-		if rc < 0:
-			raise ValueError("Could not check if SELinux user %s is defined" % name)
-		if not exists:
-			raise ValueError("SELinux user %s is defined in policy, cannot be deleted" % name)
+			(rc,exists) = semanage_user_exists_local(self.sh, k)
+			if rc < 0:
+				raise ValueError("Could not check if SELinux user %s is defined" % name)
+			if not exists:
+				raise ValueError("SELinux user %s is defined in policy, cannot be deleted" % name)
 			
-		rc = semanage_begin_transaction(self.sh)
-		if rc < 0:
-			raise ValueError("Could not start semanage transaction")
+			rc = semanage_begin_transaction(self.sh)
+			if rc < 0:
+				raise ValueError("Could not start semanage transaction")
 
-		rc = semanage_user_del_local(self.sh, k)
-		if rc < 0:
-			raise ValueError("Could not delete SELinux user %s" % name)
+			rc = semanage_user_del_local(self.sh, k)
+			if rc < 0:
+				raise ValueError("Could not delete SELinux user %s" % name)
 
-		rc = semanage_commit(self.sh)
-		if rc < 0:
-			raise ValueError("Could not delete SELinux user %s" % name)
+			rc = semanage_commit(self.sh)
+			if rc < 0:
+				raise ValueError("Could not delete SELinux user %s" % name)
+		except ValueError, error:
+			mylog.log(0,"delete SELinux user record", name)
+			raise error
 		
+		mylog.log(1,"delete SELinux user record", name)
 		semanage_user_key_free(k)		
 
 	def get_all(self):
@@ -462,14 +553,20 @@
 		return ddict
 
 	def list(self, heading=1):
-		if heading:
-			print "\n%-15s %-10s %-30s" % ("", "MLS/", "MLS/")
-			print "%-15s %-10s %-30s %s\n" % ("SELinux User", "MCS Level", "MCS Range", "SELinux Roles")
 		ddict=self.get_all()
 		keys=ddict.keys()
 		keys.sort()
-		for k in keys:
-			print "%-15s %-10s %-30s %s" % (k, translate(ddict[k][0]), translate(ddict[k][1]), ddict[k][2])
+		if is_mls_enabled == 1:
+			if heading:
+				print "\n%-15s %-10s %-30s" % ("", "MLS/", "MLS/")
+				print "%-15s %-10s %-30s %s\n" % ("SELinux User", "MCS Level", "MCS Range", "SELinux Roles")
+			for k in keys:
+				print "%-15s %-10s %-30s %s" % (k, translate(ddict[k][0]), translate(ddict[k][1]), ddict[k][2])
+		else:
+			if heading:
+				print "%-15s %s\n" % ("SELinux User", "SELinux Roles")
+			for k in keys:
+				print "%-15s %s" % (k, ddict[k][2])
 
 class portRecords(semanageRecords):
 	def __init__(self):
@@ -500,10 +597,11 @@
 		return ( k, proto_d, low, high )
 
 	def add(self, port, proto, serange, type):
-		if serange == "":
-			serange="s0"
-		else:
-			serange=untranslate(serange)
+		if is_mls_enabled == 1:
+			if serange == "":
+				serange="s0"
+			else:
+				serange=untranslate(serange)
 			
 		if type == "":
 			raise ValueError("Type is required")
@@ -564,7 +662,10 @@
 
 	def modify(self, port, proto, serange, setype):
 		if serange == "" and setype == "":
-			raise ValueError("Requires setype or serange")
+			if is_mls_enabled == 1:
+				raise ValueError("Requires setype or serange")
+			else:
+				raise ValueError("Requires setype")
 
 		( k, proto_d, low, high ) = self.__genkey(port, proto)
 
@@ -688,10 +789,11 @@
 		semanageRecords.__init__(self)
 
 	def add(self, interface, serange, ctype):
-		if serange == "":
-			serange="s0"
-		else:
-			serange=untranslate(serange)
+		if is_mls_enabled == 1:
+			if serange == "":
+				serange="s0"
+			else:
+				serange=untranslate(serange)
 			
 		if ctype == "":
 			raise ValueError("SELinux Type is required")
@@ -869,14 +971,14 @@
 		self.file_types["named pipe"] = SEMANAGE_FCONTEXT_PIPE;
 		
 		
-	def add(self, target, type, ftype="", serange="s0", seuser="system_u"):
+	def add(self, target, type, ftype="", serange="", seuser="system_u"):
 		if seuser == "":
 			seuser="system_u"
-			
-		if serange == "":
-			serange="s0"
-		else:
-			serange=untranslate(serange)
+		if is_mls_enabled == 1:
+			if serange == "":
+				serange="s0"
+			else:
+				serange=untranslate(serange)
 			
 		if type == "":
 			raise ValueError("SELinux Type is required")

--------------090201010902060000070003--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
