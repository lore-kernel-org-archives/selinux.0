Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1AKa4L9014226
	for <selinux@tycho.nsa.gov>; Thu, 10 Feb 2005 15:36:04 -0500 (EST)
Message-ID: <420BC588.4@redhat.com>
Date: Thu, 10 Feb 2005 15:35:20 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@epoch.ncsc.mil>,
   Nalin Dahyabhai <nalin@redhat.com>
Subject: Rewrite of genhomedircon
Content-Type: multipart/mixed;
 boundary="------------060308050402020203000404"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060308050402020203000404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I have rewritten genhomedircon to work with the new local.users strategy.
First off I have added a new file homedir_template.
homedir_template is generated in the makefile by grepping for all 
HOME_DIR, HOME_ROOT, ROLEs defined in the file_contexts.

genhomedircon will generate a file_contexts/file_contexts.homedirs file

genhomedircon will generate only one HOME_ROOT based off the location in 
the /etc/default/useradd.

It will then get all unigue homedirs from getpwd calls, and generate 
entries for each homedir by replace the   HOME_DIRS entries  in 
homedir_template.

It will then read the users/local.users file and for each user with a 
role other than  user_r; entries will be generated

I am modifying matchpathcon to read file_context, file_context.homedirs 
and file_context.local in that order.

Once this is in place you can use a combination of genpolusers,  
genhomedircon and useradd to manage your SELinux user roles without
source policy.

Comments?


Dan



--------------060308050402020203000404
Content-Type: text/plain;
 name="genhomedircon"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="genhomedircon"

#! /usr/bin/env python
# Copyright (C) 2004 Tresys Technology, LLC
# see file 'COPYING' for use and warranty information

#
# genhomedircon - this script is used to generate file context
# configuration entries for user home directories based on their
# default roles and is run when building the policy. Specifically, we
# replace HOME_ROOT, HOME_DIR, and ROLE macros in .fc files with
# generic and user-specific values.
#
# Based off original script by Dan Walsh, <dwalsh@redhat.com>
#
# ASSUMPTIONS:
#
# The file CONTEXTDIR/files/homedir_template exists.  This file is used to
# set up the home directory context for each real user.
# 
# If a user has more than one role in CONTEXTDIR/local.users, genhomedircon uses
#  the first role in the list.
#
# If a user is not listed in CONTEXTDIR/local.users, he will default to user_u, role user
#
# "Real" users (as opposed to system users) are those whose UID is greater than
#  or equal STARTING_UID (usually 500) and whose login is not a member of
#  EXCLUDE_LOGINS.  Users who are explicitly defined in CONTEXTDIR/local.users
#  are always "real" (including root, in the default configuration).
#
#  

import commands, sys, os, pwd, string

rhplPath="/usr/lib/python%d.%d/site-packages/rhpl" % (sys.version_info[0], sys.version_info[1])
if not rhplPath in sys.path:
    sys.path.append(rhplPath)

rhplPath="/usr/lib64/python%d.%d/site-packages/rhpl" % (sys.version_info[0], sys.version_info[1])
if not rhplPath in sys.path:
    sys.path.append(rhplPath)

from Conf import *

EXCLUDE_LOGINS=["/sbin/nologin", "/bin/false"]

SELINUXDIR="/etc/selinux/"
SELINUXCONFIG=SELINUXDIR+"config"
CONTEXTDIR="/contexts"
FILECONTEXTDIR=CONTEXTDIR+"/files"
HOMEDIRTEMPLATE="/homedir_template"
USERSFILE="/users/local.users"

def getStartingUID():
    conf=Conf("/etc/login.defs")
    while conf.findnextcodeline():
        if conf.getfields()[0] == "UID_MIN":
            return int(conf.getfields()[1])
                
        conf.nextline()
    return 500

def getDefaultHomeDir():
    conf=ConfShellVar("/etc/default/useradd")
    if conf.has_key("HOME"):
        return conf["HOME"]
    else:
        return "/home"

def getHomeDirs():
	ulist = pwd.getpwall()
	homedirs = []
        homedirs.append(getDefaultHomeDir())
        starting_uid=getStartingUID()
	for u in ulist:
		if u[2] >= starting_uid and \
		   not u[6] in EXCLUDE_LOGINS and \
		   u[5] != "/" and \
		   string.count(u[5], "/") > 1:
			homedir = u[5][:string.rfind(u[5], "/")]
			if not homedir in homedirs:
				homedirs.append(homedir)

        homedirs.sort()
	return homedirs
 
def usage(error = ""):
	if error != "":
		sys.stderr.write("%s\n" % (error,))
	sys.stderr.write("Usage: %s \n" % sys.argv[0])
	sys.stderr.flush()
	sys.exit(1)
	
def errorExit(error):
	sys.stderr.write("%s exiting for: " % sys.argv[0])
	sys.stderr.write("%s\n" % error)
	sys.stderr.flush()
	sys.exit(1)
	
class selinuxConfig:
    def __init__(self):
	self.type="targeted"
        self.types=[]
        if os.access(SELINUXDIR, os.F_OK) == 0:
            #File doesn't exist.  return
            return None

        conf=ConfShellVar(SELINUXCONFIG)
        if conf.has_key("SELINUXTYPE"):
            self.type=conf.vars["SELINUXTYPE"]

    def getSelinuxType(self):
            return self.type
	    
    def getFileContextDir(self):
	    return SELINUXDIR+self.getSelinuxType()+FILECONTEXTDIR

    def getContextDir(self):
	    return SELINUXDIR+self.getSelinuxType()+CONTEXTDIR

    def getHomeDirTemplate(self):
	    return self.getFileContextDir()+HOMEDIRTEMPLATE

    def getHomeRootContext(self):
	    rc=commands.getstatusoutput("grep HOME_ROOT  %s | sed -e \"s|^HOME_ROOT|%s|\"" % ( self.getHomeDirTemplate(), getDefaultHomeDir()))
	    if rc[0] == 0:
		    return rc[1]
	    else:
		    errorExit(string.join("sed error ", rc[1]))

    def getUsersFile(self):
	    return SELINUXDIR+self.getSelinuxType()+USERSFILE
	    
    def heading(self):
	ret = "\n#\n#\n# User-specific file contexts, generated via %s\n" % sys.argv[0]
	ret += "# edit %s to change file_context\n#\n#\n" % self.getUsersFile()
	return ret

    def getUsers(self):
	rc = commands.getstatusoutput("grep ^user %s" % self.getUsersFile())
	udict = {}
	prefs = {}
	if rc[0] == 0:
		ulist = rc[1].strip().split("\n")
		for u in ulist:
			user = u.split()
			try:
				if user[1] == "user_u" or user[1] == "system_u":
					continue
				# !!! chooses first role in the list to use in the file context !!!
				role = user[3]
				if role == "{":
					role = user[4]
				role = role.split("_r")[0]
				home = pwd.getpwnam(user[1])[5]
				if home == "/":
					continue
				prefs = {}
				prefs["role"] = role
				prefs["home"] = home
				udict[user[1]] = prefs
			except KeyError:
				sys.stderr.write("The user \"%s\" is not present in the passwd file, skipping...\n" % (user[1],))
	return udict

    def getHomeDirContext(self, user, home, role):
	    ret="\n\n#\n# Context for user %s\n#\n\n" % user
	    rc=commands.getstatusoutput("grep -e '^HOME_DIR' %s | sed -e 's|HOME_DIR|%s|' -e 's/ROLE/%s/' -e 's/system_u/%s/'" % (self.getHomeDirTemplate(), home, role, user))
	    return ret + rc[1]
	    
	    
    def genHomeDirContext(self):
	users = self.getUsers()
	ret=""
	# Fill in HOME and ROLE for users that are defined
	for u in users.keys():
		ret += self.getHomeDirContext (u, users[u]["home"], users[u]["role"])
	return ret

    def genoutput(self):
	ret= self.heading()
	ret += self.getHomeRootContext()
        for h in getHomeDirs():
            ret += self.getHomeDirContext ("user_u" , h, "user")
        ret += self.genHomeDirContext()
        return ret
    
    def printout(self):
        print self.genoutput()
        
    def write(self):
        fd = open(self.getFileContextDir()+"/file_context.homedirs", "w")
        fd.write(self.genoutput())
        fd.close()
        
#
# This script will generate home dir file context
# based off the homedir_template file, entries in the password file, and
#
try:
	selconf=selinuxConfig()
        selconf.write()
        
except ValueError, error:
	errorExit(string.join("ValueError ", error))
except IndexError, error:
	errorExit("IndexError")

--------------060308050402020203000404
Content-Type: text/plain;
 name="homedir_template"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="homedir_template"

# HOME_ROOT expands to all valid home directory prefixes found in /etc/passwd
# HOME_DIR expands to each user's home directory,
#                  and to HOME_ROOT/[^/]+ for each HOME_ROOT.
# ROLE expands to each user's role when role != user_r, and to "user" otherwise.
HOME_ROOT		-d	system_u:object_r:home_root_t
HOME_DIR		-d	system_u:object_r:ROLE_home_dir_t
HOME_DIR/.+			system_u:object_r:ROLE_home_t
HOME_ROOT/\.journal		<<none>>
HOME_ROOT/lost\+found(/.*)?	system_u:object_r:lost_found_t
HOME_DIR/((www)|(web)|(public_html))(/.+)? system_u:object_r:httpd_ROLE_content_t
HOME_DIR/.*/plugins/libflashplayer\.so.* -- system_u:object_r:texrel_shlib_t

--------------060308050402020203000404
Content-Type: text/plain;
 name="file_context.homedirs"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="file_context.homedirs"


#
#
# User-specific file contexts, generated via /usr/sbin/genhomedircon
# edit /etc/selinux/targeted/users/local.users to change file_context
#
#
# HOME_ROOT expands to all valid home directory prefixes found in /etc/passwd
#                  and to HOME_ROOT/[^/]+ for each HOME_ROOT.
/home		-d	system_u:object_r:home_root_t
/home/\.journal		<<none>>
/home/lost\+found(/.*)?	system_u:object_r:lost_found_t

#
# Context for user user_u
#

/foo/baz		-d	user_u:object_r:user_home_dir_t
/foo/baz/.+			user_u:object_r:user_home_t
/foo/baz/((www)|(web)|(public_html))(/.+)? user_u:object_r:httpd_user_content_t
/foo/baz/.*/plugins/libflashplayer\.so.* -- user_u:object_r:texrel_shlib_t

#
# Context for user user_u
#

/home		-d	user_u:object_r:user_home_dir_t
/home/.+			user_u:object_r:user_home_t
/home/((www)|(web)|(public_html))(/.+)? user_u:object_r:httpd_user_content_t
/home/.*/plugins/libflashplayer\.so.* -- user_u:object_r:texrel_shlib_t

#
# Context for user user_u
#

/home/devel		-d	user_u:object_r:user_home_dir_t
/home/devel/.+			user_u:object_r:user_home_t
/home/devel/((www)|(web)|(public_html))(/.+)? user_u:object_r:httpd_user_content_t
/home/devel/.*/plugins/libflashplayer\.so.* -- user_u:object_r:texrel_shlib_t

#
# Context for user dwalsh
#

/home/devel/dwalsh		-d	dwalsh:object_r:staff_home_dir_t
/home/devel/dwalsh/.+			dwalsh:object_r:staff_home_t
/home/devel/dwalsh/((www)|(web)|(public_html))(/.+)? dwalsh:object_r:httpd_staff_content_t
/home/devel/dwalsh/.*/plugins/libflashplayer\.so.* -- dwalsh:object_r:texrel_shlib_t
--------------060308050402020203000404--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
