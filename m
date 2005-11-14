Message-ID: <4378D636.3090408@redhat.com>
Date: Mon, 14 Nov 2005 13:23:50 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux-dev@tresys.com, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: rawhide targeted vs. refpolicy rpm
References: <BF9A263D.7FFA%csellers@tresys.com>	 <4374BDEC.4050600@redhat.com> <200511111717.16542.csellers@tresys.com>	 <200511141041.49643.csellers@tresys.com>	 <1131983537.5415.137.camel@moss-spartans.epoch.ncsc.mil>	 <4378B88B.6040003@redhat.com> <1131987091.5415.180.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1131987091.5415.180.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------010502010606000503000705"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010502010606000503000705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:
> On Mon, 2005-11-14 at 11:17 -0500, Daniel J Walsh wrote:
>   
>> policycoreutils patch to genhomedircon to use libsemanage to read 
>> seusers file.
>>     
>
> A couple of concerns about upstreaming this patch as is:
> 1) Compatibility.  In addition to dropping compatibility with the older
> usage of genhomedircon from FC3, the patch also doesn't provide any
> backward compatibility for the older system.users/local.users-based
> generation, and requires that the new seusers file be present.  Is that
> ok?  I suppose that genhomedircon is somewhat of an SELinux-internal
> helper at this point (only used by other core SELinux components like
> the policy Makefile and libsemanage), so as long as people don't try to
> install the latest policycoreutils on earlier systems without also
> updating their policy to a corresponding version, they shouldn't have a
> problem.
>   
I don't believe anyone uses this method at present other than the 
developers so I didn't see this as a necessity to maintain.
> 2) Targeted policy specialization.  defaultrole() has a hack for
> targeted policy to remap system_r to user_r as the default role for a
> user when system_r is returned by semanage, and getUsers() has a
> targeted policy-specific hack to handle the root entry in seusers when
> not using semanage.  The latter will break anyone with strict policy
> that isn't converted to using semanage.
>
>   
I thought in strict policy this would be a bug also.  Since it should be 
returning something like staff_r or user_r. 
The previous patch had a problem on non libsemanaged machines.


-- 



--------------010502010606000503000705
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/genhomedircon policycoreutils-1.27.27/scripts/genhomedircon
--- nsapolicycoreutils/scripts/genhomedircon	2005-09-12 16:33:30.000000000 -0400
+++ policycoreutils-1.27.27/scripts/genhomedircon	2005-11-14 12:58:49.000000000 -0500
@@ -15,32 +15,19 @@
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
+from semanage import *;
 
 EXCLUDE_LOGINS=["/sbin/nologin", "/bin/false"]
 
@@ -67,169 +54,6 @@
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
@@ -287,6 +111,11 @@
 
 class selinuxConfig:
 	def __init__(self, selinuxdir="/etc/selinux", type="targeted", usepwd=1):
+		self.semanageHandle=semanage_handle_create()
+		self.semanaged=semanage_is_managed(self.semanageHandle)
+		if self.semanaged:
+			semanage_connect(self.semanageHandle)
+			(status, self.ulist, self.usize) = semanage_user_list(self.semanageHandle)
 		self.type=type
 		self.selinuxdir=selinuxdir +"/"
 		self.contextdir="/contexts"
@@ -313,47 +142,70 @@
 			errorExit(string.join("sed error ", rc[1]))
 
 	def getUsersFile(self):
-		return self.selinuxdir+self.type+"/users/local.users"
+		if self.semanaged:
+			return self.selinuxdir+self.type+"module/active/seusers"
+		else:
+			return self.selinuxdir+self.type+"/seusers"
 
-	def getSystemUsersFile(self):
-		return self.selinuxdir+self.type+"/users/system.users"
-		
 	def heading(self):
 		ret = "\n#\n#\n# User-specific file contexts, generated via %s\n" % sys.argv[0]
 		ret += "# edit %s to change file_context\n#\n#\n" % self.getUsersFile()
 		return ret
 
+
+	def defaultrole(self, name):
+		for idx in range(self.usize):
+			user = semanage_user_by_idx(self.ulist, idx)
+			if semanage_user_get_name(user) == name:
+				role=semanage_user_get_defrole(user)
+				if role=="system_r":
+					# targeted policy
+					return "user_r"
+				else:
+					return  role
+		return name
+	def adduser(self, udict, user, seuser, role):
+		try:
+			if seuser == "user_u" or user == "__default__":
+				return
+			# !!! chooses first role in the list to use in the file context !!!
+			if role[-2:] == "_r" or role[-2:] == "_u":
+				role = role[:-2]
+			home = pwd.getpwnam(user)[5]
+			if home == "/":
+				return
+			prefs = {}
+			prefs["role"] = role
+			prefs["home"] = home
+			udict[seuser] = prefs
+		except KeyError:
+			sys.stderr.write("The user \"%s\" is not present in the passwd file, skipping...\n" % user)
+
 	def getUsers(self):
-		users=""
-		rc = commands.getstatusoutput('grep "^user" %s' % self.getSystemUsersFile())
-		if rc[0] == 0:
-			users+=rc[1]+"\n"
-		rc = commands.getstatusoutput("grep ^user %s" % self.getUsersFile())
-		if rc[0] == 0:
-			users+=rc[1]
 		udict = {}
-		prefs = {}
-		if users != "":
-			ulist = users.split("\n")
-			for u in ulist:
-				user = u.split()
-				try:
-					if len(user)==0 or user[1] == "user_u" or user[1] == "system_u":
+		if self.semanaged:
+			(status, list, lsize) = semanage_seuser_list(self.semanageHandle)
+			for idx in range(lsize):
+				user=[]
+				seuser = semanage_seuser_by_idx(list, idx)
+				seusername=semanage_seuser_get_sename(seuser)
+				self.adduser(udict, semanage_seuser_get_name(seuser), seusername, self.defaultrole(seusername))
+				
+		else:
+			rc = commands.getstatusoutput("grep -v '^ *#' %s" % self.getUsersFile())
+			if rc[0] == 0 and rc[1] != "":
+				ulist = rc[1].split("\n")
+				for u in ulist:
+					if len(u)==0:
 						continue
-					# !!! chooses first role in the list to use in the file context !!!
-					role = user[3]
-					if role == "{":
-						role = user[4]
-					role = role.split("_r")[0]
-					home = pwd.getpwnam(user[1])[5]
-					if home == "/":
+					user = u.split(":")
+					if len(user) < 3:
 						continue
-					prefs = {}
-					prefs["role"] = role
-					prefs["home"] = home
-					udict[user[1]] = prefs
-				except KeyError:
-					sys.stderr.write("The user \"%s\" is not present in the passwd file, skipping...\n" % user[1])
+					if user[0] == "root":
+						role="user"
+					else:
+						role=user[0]
+						self.adduser(udict, user[0], user[1], role)
 		return udict
 
 	def getHomeDirContext(self, user, home, role):
@@ -362,9 +214,8 @@
 		return ret + rc[1] + "\n"
 
 	def getUserContext(self, user, sel_user, role):
-		ret="\n\n#\n# Other Context for user %s\n#\n\n" % user
 		rc=commands.getstatusoutput("grep 'USER' %s | sed -e 's/USER/%s/' -e 's/ROLE/%s/' -e 's/system_u/%s/'" % (self.getHomeDirTemplate(), user, role, sel_user))
-		return ret + rc[1] + "\n"
+		return rc[1] + "\n"
 
 	def genHomeDirContext(self):
 		users = self.getUsers()
@@ -478,10 +329,6 @@
 	if type==None:
 		type=getSELinuxType(directory)
 
-	if len(cmds) == 2:
-		oldgenhomedircon(cmds[0], cmds[1])
-		sys.exit(0)
-
 	if len(cmds) != 0:
 		usage()
 	selconf=selinuxConfig(directory, type, usepwd)

--------------010502010606000503000705--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
