Message-ID: <4230B536.7090902@redhat.com>
Date: Thu, 10 Mar 2005 15:59:34 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: genhomedircon cleanup
Content-Type: multipart/mixed;
 boundary="------------070206030504080404070800"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070206030504080404070800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


-- 



--------------070206030504080404070800
Content-Type: text/plain;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/genhomedircon policycoreutils-1.22/scripts/genhomedircon
--- nsapolicycoreutils/scripts/genhomedircon	2005-03-08 14:03:05.000000000 -0500
+++ policycoreutils-1.22/scripts/genhomedircon	2005-03-10 14:10:15.000000000 -0500
@@ -40,15 +40,32 @@
 #  are always "real" (including root, in the default configuration).
 #
 
-import commands, sys, os, pwd, string, getopt
+import commands, sys, os, pwd, string, getopt, re
 
 EXCLUDE_LOGINS=["/sbin/nologin", "/bin/false"]
 
 def getStartingUID():
-    rc=commands.getstatusoutput("grep ^UID_MIN /etc/login.defs | tail -1")
-    if rc[0]==0:
-        return int(rc[1].split()[-1])
-    return 500
+	starting_uid = sys.maxint
+	rc=commands.getstatusoutput("grep -h '^UID_MIN' /etc/login.defs")
+	if rc[0] == 0:
+		uid_min = re.sub("^UID_MIN[^0-9]*", "", rc[1])
+		#stip any comment from the end of the line
+		uid_min = uid_min.split("#")[0]
+		uid_min = uid_min.strip()
+		if int(uid_min) < starting_uid:
+			starting_uid = int(uid_min)
+	rc=commands.getstatusoutput("grep -h '^LU_UIDNUMBER' /etc/libuser.conf")
+	if rc[0] == 0:
+		lu_uidnumber = re.sub("^LU_UIDNUMBER[^0-9]*", "", rc[1])
+		#stip any comment from the end of the line
+		lu_uidnumber = re.sub("[ \t].*", "", lu_uidnumber)
+		lu_uidnumber = lu_uidnumber.split("#")[0]
+		lu_uidnumber = lu_uidnumber.strip()
+		if int(lu_uidnumber) < starting_uid:
+			starting_uid = int(lu_uidnumber)
+	if starting_uid == sys.maxint:
+		starting_uid = 500
+	return starting_uid
 
 #############################################################################
 #
@@ -57,13 +74,13 @@
 #############################################################################
 def getPrefixes():
 	ulist = pwd.getpwall()
-        STARTING_UID=getStartingUID()
+	STARTING_UID=getStartingUID()
 	prefixes = {}
 	for u in ulist:
 		if u[2] >= STARTING_UID and \
-		   not u[6] in EXCLUDE_LOGINS and \
-		   u[5] != "/" and \
-		   string.count(u[5], "/") > 1:
+				not u[6] in EXCLUDE_LOGINS and \
+				u[5] != "/" and \
+				string.count(u[5], "/") > 1:
 			prefix = u[5][:string.rfind(u[5], "/")]
 			if not prefixes.has_key(prefix):
 				prefixes[prefix] = ""
@@ -92,7 +109,7 @@
 				prefs["home"] = home
 				udict[user[1]] = prefs
 			except KeyError:
-				sys.stderr.write("The user \"%s\" is not present in the passwd file, skipping...\n" % (user[1],))
+				sys.stderr.write("The user \"%s\" is not present in the passwd file, skipping...\n" % user[1])
 	return udict
 
 def update(filecontext, user, prefs):
@@ -104,46 +121,108 @@
 	return rc
 
 def oldgenhomedircon(filecontextdir, filecontext):
-    sys.stderr.write("Using genhomedircon in this fashion is supported for backwards compatability\n")
-    sys.stderr.write("Please update to the latest policy\n")
-    sys.stderr.flush()
-
-    if os.path.isdir(filecontextdir) == 0:
-        sys.stderr.write("New usage is the following\n")
-        usage()
-
-    prefixes = getPrefixes()
-    
-    rc=commands.getstatusoutput("grep -h '^HOME' /etc/default/useradd")
-    if rc[0] == 0:
-        homedir = rc[1].split("=")[1]
-    else:
-        sys.stderr.write("%s\n" % (rc[1],))
-        sys.stderr.write("You do not have access to /etc/default/useradd, default /home\n")
-        sys.stderr.flush()
-        homedir = "/home"
-		
-		
-    if not prefixes.has_key(homedir):
-        prefixes[homedir] = ""
+	sys.stderr.write("Using genhomedircon in this fashion is supported for backwards compatability\n")
+	sys.stderr.write("Please update to the latest policy\n")
+	sys.stderr.flush()
+
+	if os.path.isdir(filecontextdir) == 0:
+		sys.stderr.write("New usage is the following\n")
+		usage()
+        #We are going to define home directory used by libuser and show-utils as a home directory root
+        prefixes = {}
+        rc=commands.getstatusoutput("grep -h '^HOME' /etc/default/useradd")
+        if rc[0] == 0:
+                homedir = rc[1].split("=")[1]
+                homedir = homedir.split("#")[0]
+                homedir = homedir.strip()
+                if not prefixes.has_key(homedir):
+                        prefixes[homedir] = ""
+        else:
+                #rc[0] == 256 means the file was there, we read it, but the grep didn't match
+                if rc[0] != 256:
+                        sys.stderr.write("%s\n" % rc[1])
+                        sys.stderr.write("You do not have access to /etc/default/useradd HOME=\n")
+                        sys.stderr.flush()
+
+
+        rc=commands.getstatusoutput("grep -h '^LU_HOMEDIRECTORY' /etc/libuser.conf")
+        if rc[0] == 0:
+                homedir = rc[1].split("=")[1]
+                homedir = homedir.split("#")[0]
+                homedir = homedir.strip()
+                homedir = re.sub(r"[^/a-zA-Z0-9].*$", "", homedir)
+                if not prefixes.has_key(homedir):
+                        prefixes[homedir] = ""
+        else:
+                if rc[0] != 256:
+                        sys.stderr.write("%s\n" % rc[1])
+                        sys.stderr.write("You do not have access to /etc/libuser.conf LU_HOMEDIRECTORY=\n")
+                        sys.stderr.flush()
+
+        #the idea is that we need to find all of the home_root_t directories we do this by just accepting
+        #any default home directory defined by either /etc/libuser.conf or /etc/default/useradd
+        #we then get the potential home directory roots from /etc/passwd or nis or whereever and look at
+        #the defined homedir for all users with UID > STARTING_UID.  This list of possible root homedirs
+        #is then checked to see if it has an explicite context defined in the file_contexts.  Explicit
+        #is any regex that would match it which does not end with .*$ or .+$ since those are general
+        #recursive matches.  We then take any regex which ends with [pattern](/.*)?$ and just check against
+        #[pattern]
+        potential_prefixes = getPrefixes()
+        prefix_regex = {}
+        #this works by grepping the file_contexts for
+        # 1. ^/ makes sure this is not a comment
+        # 2. prints only the regex in the first column first cut on \t then on space
+        rc=commands.getstatusoutput("grep \"^/\" %s | cut -f 1 | cut -f 1 -d \" \" " %  (sys.argv[2]) )
+        if rc[0] == 0:
+                prefix_regex = rc[1].split("\n")
+        else:
+                sys.stderr.write("%s\n" % rc[1])
+                sys.stderr.write("You do not have access to grep/cut/the file contexts\n")
+                sys.stderr.flush()
+        for potential in potential_prefixes.keys():
+                addme = 1
+                for regex in prefix_regex:
+                        #match a trailing (/*)? which is actually a bug in rpc_pipefs
+                        regex = re.sub("\(/\*\)\?$", "", regex)
+                        #match a trailing .+
+                        regex = re.sub("\.+$", "", regex)
+                        #match a trailing .*
+                        regex = re.sub("\.\*$", "", regex)
+                        #strip a (/.*)? which matches anything trailing to a /*$ which matches trailing /'s
+                        regex = re.sub("\(\/\.\*\)\?", "", regex)
+                        regex = regex + "/*$"
+                        if re.search(regex, potential, 0):
+                                addme = 0
+                if addme == 1:
+                        if not prefixes.has_key(potential):
+                                prefixes[potential] = ""
+
+
+        if prefixes.__eq__({}):
+                sys.stderr.write("LU_HOMEDIRECTORY not set in /etc/libuser.conf\n")
+                sys.stderr.write("HOME= not set in /etc/default/useradd\n")
+                sys.stderr.write("And no users with a reasonable homedir found in passwd/nis/ldap/etc...\n")
+                sys.stderr.write("Assuming /home is the root of home directories\n")
+                sys.stderr.flush()
+                prefixes["/home"] = ""
+
+	# There may be a more elegant sed script to expand a macro to multiple lines, but this works
+	sed_root = "h; s|^HOME_ROOT|%s|" % (string.join(prefixes.keys(), "|; p; g; s|^HOME_ROOT|"),)
+	sed_dir = "h; s|^HOME_DIR|%s/[^/]+|; s|ROLE_|user_|" % (string.join(prefixes.keys(), "/[^/]+|; s|ROLE_|user_|; p; g; s|^HOME_DIR|"),)
+
+	# Fill in HOME_ROOT, HOME_DIR, and ROLE for users not explicitly defined in /etc/security/selinux/src/policy/users
+	rc=commands.getstatusoutput("sed -e \"/^HOME_ROOT/{%s}\" -e \"/^HOME_DIR/{%s}\" %s" % (sed_root, sed_dir, filecontext))
+	if rc[0] == 0:
+		print rc[1]
+	else:
+		errorExit(string.join("sed error ", rc[1]))
+
+	users = getUsers(filecontextdir)
+	print "\n#\n# User-specific file contexts\n#\n"
 
-    # There may be a more elegant sed script to expand a macro to multiple lines, but this works
-    sed_root = "h; s|^HOME_ROOT|%s|" % (string.join(prefixes.keys(), "|; p; g; s|^HOME_ROOT|"),)
-    sed_dir = "h; s|^HOME_DIR|%s/[^/]+|; s|ROLE_|user_|" % (string.join(prefixes.keys(), "/[^/]+|; s|ROLE_|user_|; p; g; s|^HOME_DIR|"),)
-    
-    # Fill in HOME_ROOT, HOME_DIR, and ROLE for users not explicitly defined in /etc/security/selinux/src/policy/users
-    rc=commands.getstatusoutput("sed -e \"/^HOME_ROOT/{%s}\" -e \"/^HOME_DIR/{%s}\" %s" % (sed_root, sed_dir, filecontext))
-    if rc[0] == 0:
-        print rc[1]
-    else:
-        errorExit(string.join("sed error ", rc[1]))
-        
-    users = getUsers(filecontextdir)
-    print "\n#\n# User-specific file contexts\n#\n"
-
-    # Fill in HOME and ROLE for users that are defined
-    for u in users.keys():
-        update(filecontext, u, users[u]) 
+	# Fill in HOME and ROLE for users that are defined
+	for u in users.keys():
+		update(filecontext, u, users[u]) 
 
 #############################################################################
 #
@@ -152,203 +231,258 @@
 #############################################################################
 
 def getDefaultHomeDir():
-    rc=commands.getstatusoutput("grep ^HOME= /etc/default/useradd | tail -1")
-    if rc[0]==0:
-        return rc[1].split("=")[-1].strip()
-    return "/home"
+	ret = []
+	rc=commands.getstatusoutput("grep -h '^HOME' /etc/default/useradd")
+	if rc[0] == 0:
+		homedir = rc[1].split("=")[1]
+		homedir = homedir.split("#")[0]
+		homedir = homedir.strip()
+		if not homedir in ret:
+			ret.append(homedir)
+	else:
+		#rc[0] == 256 means the file was there, we read it, but the grep didn't match
+		if rc[0] != 256:
+			sys.stderr.write("%s\n" % rc[1])
+			sys.stderr.write("You do not have access to /etc/default/useradd HOME=\n")
+			sys.stderr.flush()
+	rc=commands.getstatusoutput("grep -h '^LU_HOMEDIRECTORY' /etc/libuser.conf")
+	if rc[0] == 0:
+		homedir = rc[1].split("=")[1]
+		homedir = homedir.split("#")[0]
+		homedir = homedir.strip()
+		if not homedir in ret:
+			ret.append(homedir)
+	else:
+		#rc[0] == 256 means the file was there, we read it, but the grep didn't match
+		if rc[0] != 256:
+			sys.stderr.write("%s\n" % rc[1])
+			sys.stderr.write("You do not have access to /etc/libuser.conf LU_HOMEDIRECTORY=\n")
+			sys.stderr.flush()
+	if ret == []:
+		ret.append("/home")
+	return ret
 
 def getSELinuxType(directory):
-    rc=commands.getstatusoutput("grep ^SELINUXTYPE= %s/config | tail -1" % directory)
-    if rc[0]==0:
-        return rc[1].split("=")[-1].strip()
-    return "targeted"
+	rc=commands.getstatusoutput("grep ^SELINUXTYPE= %s/config" % directory)
+	if rc[0]==0:
+		return rc[1].split("=")[-1].strip()
+	return "targeted"
 
 def usage(error = ""):
-    if error != "":
-        sys.stderr.write("%s\n" % (error,))
-    sys.stderr.write("Usage: %s [ -d selinuxdir ] [-n | --nopasswd] [-t selinuxtype ]\n" % sys.argv[0])
-    sys.stderr.flush()
-    sys.exit(1)
-    
+	if error != "":
+		sys.stderr.write("%s\n" % error)
+	sys.stderr.write("Usage: %s [ -d selinuxdir ] [-n | --nopasswd] [-t selinuxtype ]\n" % sys.argv[0])
+	sys.stderr.flush()
+	sys.exit(1)
+
 def warning(warning = ""):
-    sys.stderr.write("%s\n" % warning)
-    sys.stderr.flush()
-    
+	sys.stderr.write("%s\n" % warning)
+	sys.stderr.flush()
+	
 def errorExit(error):
-    sys.stderr.write("%s exiting for: " % sys.argv[0])
-    sys.stderr.write("%s\n" % error)
-    sys.stderr.flush()
-    sys.exit(1)
-    
+	sys.stderr.write("%s exiting for: " % sys.argv[0])
+	sys.stderr.write("%s\n" % error)
+	sys.stderr.flush()
+	sys.exit(1)
+
 class selinuxConfig:
-    def __init__(self, selinuxdir="/etc/selinux", type="targeted", usepwd=1):
-	self.type=type
-        self.selinuxdir=selinuxdir +"/"
-        self.contextdir="/contexts"
-        self.filecontextdir=self.contextdir+"/files"
-        self.usepwd=usepwd
-
-    def getFileContextDir(self):
-	    return self.selinuxdir+self.type+self.filecontextdir
-
-    def getFileContextFile(self):
-        return self.getFileContextDir()+"/file_contexts"
-    
-    def getContextDir(self):
-	    return self.selinuxdir+self.type+self.contextdir
-
-    def getHomeDirTemplate(self):
-	    return self.getFileContextDir()+"/homedir_template"
-
-    def getHomeRootContext(self, homedir):
-	    rc=commands.getstatusoutput("grep HOME_ROOT  %s | sed -e \"s|^HOME_ROOT|%s|\"" % ( self.getHomeDirTemplate(), homedir))
-	    if rc[0] == 0:
-		    return rc[1]+"\n"
-	    else:
-		    errorExit(string.join("sed error ", rc[1]))
-
-    def getUsersFile(self):
-	    return self.selinuxdir+self.type+"/users/local.users"
-
-    def getSystemUsersFile(self):
-	    return self.selinuxdir+self.type+"/users/system.users"
-	    
-    def heading(self):
-	ret = "\n#\n#\n# User-specific file contexts, generated via %s\n" % sys.argv[0]
-	ret += "# edit %s to change file_context\n#\n#\n" % self.getUsersFile()
-	return ret
+	def __init__(self, selinuxdir="/etc/selinux", type="targeted", usepwd=1):
+		self.type=type
+		self.selinuxdir=selinuxdir +"/"
+		self.contextdir="/contexts"
+		self.filecontextdir=self.contextdir+"/files"
+		self.usepwd=usepwd
+
+	def getFileContextDir(self):
+		return self.selinuxdir+self.type+self.filecontextdir
+
+	def getFileContextFile(self):
+		return self.getFileContextDir()+"/file_contexts"
+	
+	def getContextDir(self):
+		return self.selinuxdir+self.type+self.contextdir
+
+	def getHomeDirTemplate(self):
+		return self.getFileContextDir()+"/homedir_template"
+
+	def getHomeRootContext(self, homedir):
+		rc=commands.getstatusoutput("grep HOME_ROOT  %s | sed -e \"s|^HOME_ROOT|%s|\"" % ( self.getHomeDirTemplate(), homedir))
+		if rc[0] == 0:
+			return rc[1]+"\n"
+		else:
+			errorExit(string.join("sed error ", rc[1]))
 
-    def getUsers(self):
-        users=""
-	rc = commands.getstatusoutput('grep "^user" %s' % self.getSystemUsersFile())
-	if rc[0] == 0:
-                users+=rc[1]+"\n"
-	rc = commands.getstatusoutput("grep ^user %s" % self.getUsersFile())
-	if rc[0] == 0:
-                users+=rc[1]
-	udict = {}
-	prefs = {}
-	if users != "":
-		ulist = users.split("\n")
+	def getUsersFile(self):
+		return self.selinuxdir+self.type+"/users/local.users"
+
+	def getSystemUsersFile(self):
+		return self.selinuxdir+self.type+"/users/system.users"
+		
+	def heading(self):
+		ret = "\n#\n#\n# User-specific file contexts, generated via %s\n" % sys.argv[0]
+		ret += "# edit %s to change file_context\n#\n#\n" % self.getUsersFile()
+		return ret
+
+	def getUsers(self):
+		users=""
+		rc = commands.getstatusoutput('grep "^user" %s' % self.getSystemUsersFile())
+		if rc[0] == 0:
+			users+=rc[1]+"\n"
+		rc = commands.getstatusoutput("grep ^user %s" % self.getUsersFile())
+		if rc[0] == 0:
+			users+=rc[1]
+		udict = {}
+		prefs = {}
+		if users != "":
+			ulist = users.split("\n")
+			for u in ulist:
+				user = u.split()
+				try:
+					if len(user)==0 or user[1] == "user_u" or user[1] == "system_u":
+						continue
+					# !!! chooses first role in the list to use in the file context !!!
+					role = user[3]
+					if role == "{":
+						role = user[4]
+					role = role.split("_r")[0]
+					home = pwd.getpwnam(user[1])[5]
+					if home == "/":
+						continue
+					prefs = {}
+					prefs["role"] = role
+					prefs["home"] = home
+					udict[user[1]] = prefs
+				except KeyError:
+					sys.stderr.write("The user \"%s\" is not present in the passwd file, skipping...\n" % user[1])
+		return udict
+
+	def getHomeDirContext(self, user, home, role):
+		ret="\n\n#\n# Context for user %s\n#\n\n" % user
+		rc=commands.getstatusoutput("grep '^HOME_DIR' %s | sed -e 's|HOME_DIR|%s|' -e 's/ROLE/%s/' -e 's/system_u/%s/'" % (self.getHomeDirTemplate(), home, role, user))
+		return ret + rc[1] + "\n"
+
+	def genHomeDirContext(self):
+		users = self.getUsers()
+		ret=""
+		# Fill in HOME and ROLE for users that are defined
+		for u in users.keys():
+			ret += self.getHomeDirContext (u, users[u]["home"], users[u]["role"])
+		return ret+"\n"
+
+	def checkExists(self, home):
+		if commands.getstatusoutput("grep -E '^%s[^[:alnum:]_-]' %s" % (home, self.getFileContextFile()))[0] == 0:
+			return 0
+		#this works by grepping the file_contexts for
+		# 1. ^/ makes sure this is not a comment
+		# 2. prints only the regex in the first column first cut on \t then on space
+		rc=commands.getstatusoutput("grep \"^/\" %s | cut -f 1 | cut -f 1 -d \" \" " %  self.getFileContextFile() )
+		if rc[0] == 0:
+			prefix_regex = rc[1].split("\n")
+		else:
+			sys.stderr.write("%s\n" % rc[1])
+			sys.stderr.write("You do not have access to grep/cut/the file contexts\n")
+			sys.stderr.flush()
+		exists=1
+		for regex in prefix_regex:
+			#match a trailing (/*)? which is actually a bug in rpc_pipefs
+			regex = re.sub("\(/\*\)\?$", "", regex)
+			#match a trailing .+
+			regex = re.sub("\.+$", "", regex)
+			#match a trailing .*
+			regex = re.sub("\.\*$", "", regex)
+			#strip a (/.*)? which matches anything trailing to a /*$ which matches trailing /'s
+			regex = re.sub("\(\/\.\*\)\?", "", regex)
+			regex = regex + "/*$"
+			if re.search(regex, home, 0):
+				exists = 0
+				break
+		if exists == 1:
+			return 1
+		else:
+			return 0
+
+
+	def getHomeDirs(self):
+		homedirs = []
+		homedirs = homedirs + getDefaultHomeDir()
+		starting_uid=getStartingUID()
+		if self.usepwd==0:
+			return homedirs
+		ulist = pwd.getpwall()
 		for u in ulist:
-			user = u.split()
-			try:
-				if len(user)==0 or user[1] == "user_u" or user[1] == "system_u":
-					continue
-				# !!! chooses first role in the list to use in the file context !!!
-				role = user[3]
-				if role == "{":
-					role = user[4]
-				role = role.split("_r")[0]
-				home = pwd.getpwnam(user[1])[5]
-				if home == "/":
-					continue
-				prefs = {}
-				prefs["role"] = role
-				prefs["home"] = home
-				udict[user[1]] = prefs
-			except KeyError:
-				sys.stderr.write("The user \"%s\" is not present in the passwd file, skipping...\n" % (user[1],))
-	return udict
+			if u[2] >= starting_uid and \
+					not u[6] in EXCLUDE_LOGINS and \
+					u[5] != "/" and \
+					string.count(u[5], "/") > 1:
+				homedir = u[5][:string.rfind(u[5], "/")]
+				if not homedir in homedirs:
+					if self.checkExists(homedir)==0:
+						warning("%s is already defined in %s,\n%s will not create a new context." % (homedir, self.getFileContextFile(), sys.argv[0]))
+					else:
+						homedirs.append(homedir)
+
+		homedirs.sort()
+		return homedirs
+ 
+	def genoutput(self):
+		ret= self.heading()
+		for h in self.getHomeDirs():
+			ret += self.getHomeDirContext ("user_u" , h+'/[^/]*', "user")
+			ret += self.getHomeRootContext(h)
+		ret += self.genHomeDirContext()
+		return ret
+
+	def printout(self):
+		print self.genoutput()
+
+	def write(self):
+		try:
+			fd = open(self.getFileContextDir()+"/file_contexts.homedirs", "w")
+			fd.write(self.genoutput())
+			fd.close()
+		except IOError, error:
+			sys.stderr.write("%s: %s\n" % ( sys.argv[0], error ))
 
-    def getHomeDirContext(self, user, home, role):
-	    ret="\n\n#\n# Context for user %s\n#\n\n" % user
-            rc=commands.getstatusoutput("grep '^HOME_DIR' %s | sed -e 's|HOME_DIR|%s|' -e 's/ROLE/%s/' -e 's/system_u/%s/'" % (self.getHomeDirTemplate(), home, role, user))
-	    return ret + rc[1] + "\n"
-
-    def genHomeDirContext(self):
-	users = self.getUsers()
-	ret=""
-	# Fill in HOME and ROLE for users that are defined
-	for u in users.keys():
-		ret += self.getHomeDirContext (u, users[u]["home"], users[u]["role"])
-	return ret+"\n"
 
-    def checkExists(self, home):
-        return commands.getstatusoutput("grep -E '^%s[^[:alnum:]_-]' %s" % (home, self.getFileContextFile()))[0]
 
-    def getHomeDirs(self):
-        homedirs = []
-        homedirs.append(getDefaultHomeDir())
-        starting_uid=getStartingUID()
-        if self.usepwd==0:
-            return homedirs
-        ulist = pwd.getpwall()
-        for u in ulist:
-            if u[2] >= starting_uid and \
-                   not u[6] in EXCLUDE_LOGINS and \
-                   u[5] != "/" and \
-                   string.count(u[5], "/") > 1:
-                homedir = u[5][:string.rfind(u[5], "/")]
-                if not homedir in homedirs:
-                    if self.checkExists(homedir)==0:
-                        warning("%s is already defined in %s,\n%s will not create a new context." % (homedir, self.getFileContextFile(), sys.argv[0]))
-                    else:
-                        homedirs.append(homedir)
-                    
-        homedirs.sort()
-        return homedirs
- 
-    def genoutput(self):
-	ret= self.heading()
-        for h in self.getHomeDirs():
-            ret += self.getHomeDirContext ("user_u" , h+'/[^/]*', "user")
-            ret += self.getHomeRootContext(h)
-        ret += self.genHomeDirContext()
-        return ret
-    
-    def printout(self):
-        print self.genoutput()
-        
-    def write(self):
-        try:
-            fd = open(self.getFileContextDir()+"/file_contexts.homedirs", "w")
-            fd.write(self.genoutput())
-            fd.close()
-        except IOError, error:
-            sys.stderr.write("%s: %s\n" % ( sys.argv[0], error ))
-            
-            
-        
 #
 # This script will generate home dir file context
 # based off the homedir_template file, entries in the password file, and
 #
 try:
-    usepwd=1
-    directory="/etc/selinux"
-    type=None
-    gopts, cmds = getopt.getopt(sys.argv[1:], 'nd:t:', ['help',
-                                                        'type=',
-                                                        'nopasswd',
-                                                        'dir='])
-    for o,a in gopts:
-        if o == '--type' or o == "-t":
-            type=a
-        if o == '--nopasswd'  or o == "-n":
-            usepwd=0
-        if o == '--dir'  or o == "-d":
-            directory=a
-        if o == '--help':
-            usage()
-        
-            
-    if type==None:
-        type=getSELinuxType(directory)
-        
-    if len(cmds) == 2:
-        oldgenhomedircon(cmds[0], cmds[1])
-        sys.exit(0)
-        
-    if len(cmds) != 0:
-        usage()
-    selconf=selinuxConfig(directory, type, usepwd)
-    selconf.write()
-        
+	usepwd=1
+	directory="/etc/selinux"
+	type=None
+	gopts, cmds = getopt.getopt(sys.argv[1:], 'nd:t:', ['help',
+						'type=',
+						'nopasswd',
+						'dir='])
+	for o,a in gopts:
+		if o == '--type' or o == "-t":
+			type=a
+		if o == '--nopasswd'  or o == "-n":
+			usepwd=0
+		if o == '--dir'  or o == "-d":
+			directory=a
+		if o == '--help':
+			usage()
+
+
+	if type==None:
+		type=getSELinuxType(directory)
+
+	if len(cmds) == 2:
+		oldgenhomedircon(cmds[0], cmds[1])
+		sys.exit(0)
+
+	if len(cmds) != 0:
+		usage()
+	selconf=selinuxConfig(directory, type, usepwd)
+	selconf.write()
+
 except getopt.error, error:
-    errorExit(string.join("Options Error ", error))
-    
+	errorExit(string.join("Options Error ", error))
 except ValueError, error:
-    errorExit(string.join("ValueError ", error))
+	errorExit(string.join("ValueError ", error))
 except IndexError, error:
-    errorExit("IndexError")
+	errorExit("IndexError")

--------------070206030504080404070800--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
