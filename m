Message-ID: <43724F25.1000502@redhat.com>
Date: Wed, 09 Nov 2005 14:33:57 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: FIrst pass at genhomedircon patch
Content-Type: multipart/mixed;
 boundary="------------070002030307010101080908"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070002030307010101080908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is just using the seusers file and will use the python bindings 
when they are available.
Just truncating off the _u and using this as the role, for now

No longer using users.local, system.users and also removed backwards 
compatibility with FC3.

Dan

-- 



--------------070002030307010101080908
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/genhomedircon policycoreutils-1.27.26/scripts/genhomedircon
--- nsapolicycoreutils/scripts/genhomedircon	2005-09-12 16:33:30.000000000 -0400
+++ policycoreutils-1.27.26/scripts/genhomedircon	2005-11-09 14:11:49.000000000 -0500
@@ -15,30 +15,16 @@
 # The file CONTEXTDIR/files/homedir_template exists.  This file is used to
 # set up the home directory context for each real user.
 # 
-# If a user has more than one role in CONTEXTDIR/local.users, genhomedircon uses
-#  the first role in the list.
+# If a user has more than one role, genhomedircon uses the first role in the list.
 #
-# If a user is not listed in CONTEXTDIR/local.users, he will default to user_u, role user
+# If a user is not listed in CONTEXTDIR/seusers, he will default to user_u, role user
 #
 # "Real" users (as opposed to system users) are those whose UID is greater than
 #  or equal STARTING_UID (usually 500) and whose login is not a member of
-#  EXCLUDE_LOGINS.  Users who are explicitly defined in CONTEXTDIR/local.users
+#  EXCLUDE_LOGINS.  Users who are explicitly defined in CONTEXTDIR/seusers
 #  are always "real" (including root, in the default configuration).
 #
 #  
-# Old ASSUMPTIONS:
-#
-# If a user has more than one role in FILECONTEXTDIR/users, genhomedircon uses
-#  the first role in the list.
-#
-# If a user is not listed in FILECONTEXTDIR/users, genhomedircon assumes that
-#  the user's home dir will be found in one of the HOME_ROOTs.
-#
-# "Real" users (as opposed to system users) are those whose UID is greater than
-#  or equal STARTING_UID (usually 500) and whose login is not a member of
-#  EXCLUDE_LOGINS.  Users who are explicitly defined in FILECONTEXTDIR/users
-#  are always "real" (including root, in the default configuration).
-#
 
 import commands, sys, os, pwd, string, getopt, re
 
@@ -67,169 +53,6 @@
 		starting_uid = 500
 	return starting_uid
 
-#############################################################################
-#
-# This section is just for backwards compatability
-#
-#############################################################################
-def getPrefixes():
-	ulist = pwd.getpwall()
-	STARTING_UID=getStartingUID()
-	prefixes = {}
-	for u in ulist:
-		if u[2] >= STARTING_UID and \
-				not u[6] in EXCLUDE_LOGINS and \
-				u[5] != "/" and \
-				string.count(u[5], "/") > 1:
-			prefix = u[5][:string.rfind(u[5], "/")]
-			if not prefixes.has_key(prefix):
-				prefixes[prefix] = ""
-	return prefixes
- 
-def getUsers(filecontextdir):
-	rc = commands.getstatusoutput("grep ^user %s/users" % filecontextdir)
-	udict = {}
-	if rc[0] == 0:
-		ulist = rc[1].strip().split("\n")
-		for u in ulist:
-			user = u.split()
-			try:
-				if user[1] == "user_u" or user[1] == "system_u":
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
-				sys.stderr.write("The user \"%s\" is not present in the passwd file, skipping...\n" % user[1])
-	return udict
-
-def update(filecontext, user, prefs):
-	rc=commands.getstatusoutput("grep -h '^HOME_DIR' %s | grep -v vmware | sed -e 's|HOME_DIR|%s|' -e 's/ROLE/%s/' -e 's/system_u/%s/'" % (filecontext, prefs["home"], prefs["role"], user))
-	if rc[0] == 0:
-		print rc[1]
-	else:
-		errorExit(string.join("grep/sed error ", rc[1]))
-	return rc
-
-def oldgenhomedircon(filecontextdir, filecontext):
-	sys.stderr.write("Using genhomedircon in this fashion is supported for backwards compatability\n")
-	sys.stderr.write("Please update to the latest policy\n")
-	sys.stderr.flush()
-
-	if os.path.isdir(filecontextdir) == 0:
-		sys.stderr.write("New usage is the following\n")
-		usage()
-        #We are going to define home directory used by libuser and show-utils as a home directory root
-        prefixes = {}
-        rc=commands.getstatusoutput("grep -h '^HOME' /etc/default/useradd")
-        if rc[0] == 0:
-                homedir = rc[1].split("=")[1]
-                homedir = homedir.split("#")[0]
-                homedir = homedir.strip()
-                if not prefixes.has_key(homedir):
-                        prefixes[homedir] = ""
-        else:
-                #rc[0] == 256 means the file was there, we read it, but the grep didn't match
-                if rc[0] != 256:
-                        sys.stderr.write("%s\n" % rc[1])
-                        sys.stderr.write("You do not have access to /etc/default/useradd HOME=\n")
-                        sys.stderr.flush()
-
-
-        rc=commands.getstatusoutput("grep -h '^LU_HOMEDIRECTORY' /etc/libuser.conf")
-        if rc[0] == 0:
-                homedir = rc[1].split("=")[1]
-                homedir = homedir.split("#")[0]
-                homedir = homedir.strip()
-                homedir = re.sub(r"[^/a-zA-Z0-9].*$", "", homedir)
-                if not prefixes.has_key(homedir):
-                        prefixes[homedir] = ""
-        else:
-                if rc[0] != 256:
-                        sys.stderr.write("%s\n" % rc[1])
-                        sys.stderr.write("You do not have access to /etc/libuser.conf LU_HOMEDIRECTORY=\n")
-                        sys.stderr.flush()
-
-        #the idea is that we need to find all of the home_root_t directories we do this by just accepting
-        #any default home directory defined by either /etc/libuser.conf or /etc/default/useradd
-        #we then get the potential home directory roots from /etc/passwd or nis or whereever and look at
-        #the defined homedir for all users with UID > STARTING_UID.  This list of possible root homedirs
-        #is then checked to see if it has an explicite context defined in the file_contexts.  Explicit
-        #is any regex that would match it which does not end with .*$ or .+$ since those are general
-        #recursive matches.  We then take any regex which ends with [pattern](/.*)?$ and just check against
-        #[pattern]
-        potential_prefixes = getPrefixes()
-        prefix_regex = {}
-        #this works by grepping the file_contexts for
-        # 1. ^/ makes sure this is not a comment
-        # 2. prints only the regex in the first column first cut on \t then on space
-        rc=commands.getstatusoutput("grep \"^/\" %s | cut -f 1 | cut -f 1 -d \" \" " %  (sys.argv[2]) )
-        if rc[0] == 0:
-                prefix_regex = rc[1].split("\n")
-        else:
-                sys.stderr.write("%s\n" % rc[1])
-                sys.stderr.write("You do not have access to grep/cut/the file contexts\n")
-                sys.stderr.flush()
-        for potential in potential_prefixes.keys():
-                addme = 1
-                for regex in prefix_regex:
-                        #match a trailing (/*)? which is actually a bug in rpc_pipefs
-                        regex = re.sub("\(/\*\)\?$", "", regex)
-                        #match a trailing .+
-                        regex = re.sub("\.+$", "", regex)
-                        #match a trailing .*
-                        regex = re.sub("\.\*$", "", regex)
-                        #strip a (/.*)? which matches anything trailing to a /*$ which matches trailing /'s
-                        regex = re.sub("\(\/\.\*\)\?", "", regex)
-                        regex = regex + "/*$"
-                        if re.search(regex, potential, 0):
-                                addme = 0
-                if addme == 1:
-                        if not prefixes.has_key(potential):
-                                prefixes[potential] = ""
-
-
-        if prefixes.__eq__({}):
-                sys.stderr.write("LU_HOMEDIRECTORY not set in /etc/libuser.conf\n")
-                sys.stderr.write("HOME= not set in /etc/default/useradd\n")
-                sys.stderr.write("And no users with a reasonable homedir found in passwd/nis/ldap/etc...\n")
-                sys.stderr.write("Assuming /home is the root of home directories\n")
-                sys.stderr.flush()
-                prefixes["/home"] = ""
-
-	# There may be a more elegant sed script to expand a macro to multiple lines, but this works
-	sed_root = "h; s|^HOME_ROOT|%s|" % (string.join(prefixes.keys(), "|; p; g; s|^HOME_ROOT|"),)
-	sed_dir = "h; s|^HOME_DIR|%s/[^/]+|; s|ROLE_|user_|" % (string.join(prefixes.keys(), "/[^/]+|; s|ROLE_|user_|; p; g; s|^HOME_DIR|"),)
-
-	# Fill in HOME_ROOT, HOME_DIR, and ROLE for users not explicitly defined in /etc/security/selinux/src/policy/users
-	rc=commands.getstatusoutput("sed -e \"/^HOME_ROOT/{%s}\" -e \"/^HOME_DIR/{%s}\" %s" % (sed_root, sed_dir, filecontext))
-	if rc[0] == 0:
-		print rc[1]
-	else:
-		errorExit(string.join("sed error ", rc[1]))
-
-	users = getUsers(filecontextdir)
-	print "\n#\n# User-specific file contexts\n#\n"
-
-	# Fill in HOME and ROLE for users that are defined
-	for u in users.keys():
-		update(filecontext, u, users[u]) 
-
-#############################################################################
-#
-# End of backwards compatability section
-#
-#############################################################################
-
 def getDefaultHomeDir():
 	ret = []
 	rc=commands.getstatusoutput("grep -h '^HOME' /etc/default/useradd")
@@ -313,11 +136,8 @@
 			errorExit(string.join("sed error ", rc[1]))
 
 	def getUsersFile(self):
-		return self.selinuxdir+self.type+"/users/local.users"
+		return self.selinuxdir+self.type+"/seusers"
 
-	def getSystemUsersFile(self):
-		return self.selinuxdir+self.type+"/users/system.users"
-		
 	def heading(self):
 		ret = "\n#\n#\n# User-specific file contexts, generated via %s\n" % sys.argv[0]
 		ret += "# edit %s to change file_context\n#\n#\n" % self.getUsersFile()
@@ -325,10 +145,7 @@
 
 	def getUsers(self):
 		users=""
-		rc = commands.getstatusoutput('grep "^user" %s' % self.getSystemUsersFile())
-		if rc[0] == 0:
-			users+=rc[1]+"\n"
-		rc = commands.getstatusoutput("grep ^user %s" % self.getUsersFile())
+		rc = commands.getstatusoutput("grep -v '^ *#' %s" % self.getUsersFile())
 		if rc[0] == 0:
 			users+=rc[1]
 		udict = {}
@@ -336,24 +153,24 @@
 		if users != "":
 			ulist = users.split("\n")
 			for u in ulist:
-				user = u.split()
+				if len(u)==0:
+					continue
+				user = u.split(":")
 				try:
-					if len(user)==0 or user[1] == "user_u" or user[1] == "system_u":
+					if len(user)==0 or user[1] == "user_u" or user[1] == "root":
 						continue
 					# !!! chooses first role in the list to use in the file context !!!
-					role = user[3]
-					if role == "{":
-						role = user[4]
-					role = role.split("_r")[0]
-					home = pwd.getpwnam(user[1])[5]
+					role = user[1]
+					role = role.split("_u")[0]
+					home = pwd.getpwnam(user[0])[5]
 					if home == "/":
 						continue
 					prefs = {}
 					prefs["role"] = role
 					prefs["home"] = home
-					udict[user[1]] = prefs
+					udict[user[0]] = prefs
 				except KeyError:
-					sys.stderr.write("The user \"%s\" is not present in the passwd file, skipping...\n" % user[1])
+					sys.stderr.write("The user \"%s\" is not present in the passwd file, skipping...\n" % user[0])
 		return udict
 
 	def getHomeDirContext(self, user, home, role):
@@ -478,10 +295,6 @@
 	if type==None:
 		type=getSELinuxType(directory)
 
-	if len(cmds) == 2:
-		oldgenhomedircon(cmds[0], cmds[1])
-		sys.exit(0)
-
 	if len(cmds) != 0:
 		usage()
 	selconf=selinuxConfig(directory, type, usepwd)

--------------070002030307010101080908--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
