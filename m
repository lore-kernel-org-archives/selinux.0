Message-ID: <420C5497.4030407@redhat.com>
Date: Fri, 11 Feb 2005 01:45:43 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: genhomedircon again
Content-Type: multipart/mixed;
 boundary="------------040009080703000607010007"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040009080703000607010007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I figured it is easier to read as the file rather then the patch.
Continued working on it til late.
Had to add additional options so it would work for initial installs and 
in the build environment.

This is what the output looks like.  I have setup accounts on /foo 
/home/devel and /home.  As well as put an dwalsh in local.users as a 
staff user.
Still have a problem in that /foo has a context of default_t. 
#
#
# User-specific file contexts, generated via /usr/sbin/genhomedircon
# edit /etc/selinux/targeted/users/local.users to change file_context
#
#
# HOME_ROOT expands to all valid home directory prefixes found in 
/etc/passwd
#                  and to HOME_ROOT/[^/]+ for each HOME_ROOT.
/home           -d      system_u:object_r:home_root_t
/home/\.journal         <<none>>
/home/lost\+found(/.*)? system_u:object_r:lost_found_t

#
# Context for user user_u
#

/foo/baz/[A-z0-9]*              -d      user_u:object_r:user_home_dir_t
/foo/baz/[A-z0-9]*/.+                   user_u:object_r:user_home_t
/foo/baz/[A-z0-9]*/((www)|(web)|(public_html))(/.+)? 
user_u:object_r:httpd_user_content_t
/foo/baz/[A-z0-9]*/.*/plugins/libflashplayer\.so.*      -- 
user_u:object_r:texrel_shlib_t

#
# Context for user user_u
#

/home/[A-z0-9]*         -d      user_u:object_r:user_home_dir_t
/home/[A-z0-9]*/.+                      user_u:object_r:user_home_t
/home/[A-z0-9]*/((www)|(web)|(public_html))(/.+)? 
user_u:object_r:httpd_user_content_t
/home/[A-z0-9]*/.*/plugins/libflashplayer\.so.* -- 
user_u:object_r:texrel_shlib_t


#
# Context for user user_u
#

/home/devel/[A-z0-9]*           -d      user_u:object_r:user_home_dir_t
/home/devel/[A-z0-9]*/.+                        user_u:object_r:user_home_t
/home/devel/[A-z0-9]*/((www)|(web)|(public_html))(/.+)? 
user_u:object_r:httpd_user_content_t
/home/devel/[A-z0-9]*/.*/plugins/libflashplayer\.so.*   -- 
user_u:object_r:texrel_shlib_t

#
# Context for user dwalsh
#

/home/devel/dwalsh              -d      dwalsh:object_r:staff_home_dir_t
/home/devel/dwalsh/.+                   dwalsh:object_r:staff_home_t
/home/devel/dwalsh/((www)|(web)|(public_html))(/.+)? 
dwalsh:object_r:httpd_staff_content_t
/home/devel/dwalsh/.*/plugins/libflashplayer\.so.*      -- 
dwalsh:object_r:texrel_shlib_t







--------------040009080703000607010007
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

import commands, sys, os, pwd, string, getopt

rhplPath="/usr/lib/python%d.%d/site-packages/rhpl" % (sys.version_info[0], sys.version_info[1])
if not rhplPath in sys.path:
    sys.path.append(rhplPath)

rhplPath="/usr/lib64/python%d.%d/site-packages/rhpl" % (sys.version_info[0], sys.version_info[1])
if not rhplPath in sys.path:
    sys.path.append(rhplPath)

from Conf import *

EXCLUDE_LOGINS=["/sbin/nologin", "/bin/false"]

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

def usage(error = ""):
    if error != "":
        sys.stderr.write("%s\n" % (error,))
    sys.stderr.write("Usage: %s [ -d selinuxdir ] [-n] [-t selinuxtype ]\n" % sys.argv[0])
    sys.stderr.flush()
    sys.exit(1)
    
def errorExit(error):
    sys.stderr.write("%s exiting for: " % sys.argv[0])
    sys.stderr.write("%s\n" % error)
    sys.stderr.flush()
    sys.exit(1)
    
class selinuxConfig:
    def __init__(self, selinuxdir="/etc/selinux", type="targeted", usepwd=1):
	self.type=type
        self.selinuxdir=selinuxdir +"/"
        self.selinuxconfig=self.selinuxdir+"config"
        self.contextdir="/contexts"
        self.filecontextdir=self.contextdir+"/files"
        self.usepwd=usepwd
        if os.access(self.selinuxconfig, os.F_OK) == 1:
            conf=ConfShellVar(self.selinuxconfig)
            if conf.has_key("SELINUXTYPE"):
                self.type=conf.vars["SELINUXTYPE"]

    def getSelinuxType(self):
            return self.type
	    
    def getFileContextDir(self):
	    return self.selinuxdir+self.getSelinuxType()+self.filecontextdir

    def getContextDir(self):
	    return self.selinuxdir+self.getSelinuxType()+self.contextdir

    def getHomeDirTemplate(self):
	    return self.getFileContextDir()+"/homedir_template"

    def getHomeRootContext(self):
	    rc=commands.getstatusoutput("grep HOME_ROOT  %s | sed -e \"s|^HOME_ROOT|%s|\"" % ( self.getHomeDirTemplate(), getDefaultHomeDir()))
	    if rc[0] == 0:
		    return rc[1]
	    else:
		    errorExit(string.join("sed error ", rc[1]))

    def getUsersFile(self):
	    return self.selinuxdir+self.getSelinuxType()+"/users/local.users"

	    
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
	    return ret + rc[1] + "\n"
	    
	    
    def genHomeDirContext(self):
	users = self.getUsers()
	ret=""
	# Fill in HOME and ROLE for users that are defined
	for u in users.keys():
		ret += self.getHomeDirContext (u, users[u]["home"], users[u]["role"])
	return ret

    def getHomeDirs(self):
        homedirs = []
        homedirs.append(getDefaultHomeDir())
        starting_uid=getStartingUID()
        if self.usepwd==0:
            return homedirs
        ulist = pwd.getpwall()
        for u in ulist:
            if u[2] >= starting_uid and \
                   not u[6] in EXCLUDE_LOGINS and \
                   u[5] != "/" and \
                   string.count(u[5], "/") > 1:
                homedir = u[5][:string.rfind(u[5], "/")]
                print homedir
                if not homedir in homedirs:
                    homedirs.append(homedir)
                    
        homedirs.sort()
        return homedirs
 
    def genoutput(self):
	ret= self.heading()
	ret += self.getHomeRootContext()
        for h in self.getHomeDirs():
            ret += self.getHomeDirContext ("user_u" , h+'/[A-z0-9]*', "user")
        ret += self.genHomeDirContext()
        return ret
    
    def printout(self):
        print self.genoutput()
        
    def write(self):
        try:
            fd = open(self.getFileContextDir()+"/file_contexts.homedirs", "w")
            fd.write(self.genoutput())
            fd.close()
        except IOError, error:
            sys.stderr.write("%s: %s\n" % ( sys.argv[0], error ))
            
            
        
#
# This script will generate home dir file context
# based off the homedir_template file, entries in the password file, and
#
try:
    usepwd=1
    type="targeted"
    directory="/etc/selinux"
    gopts, cmds = getopt.getopt(sys.argv[1:], 'nd:t:', ['help',
                                                        'type=',
                                                        'nopasswd',
                                                        'dir='])
    for o,a in gopts:
        if o == '--type' or o == "-t":
            type=a
        if o == '--nopasswd'  or o == "-n":
            usepwd=0
        if o == '--dir'  or o == "-d":
            directory=a
        if o == '--help':
            usage()
        
            
    selconf=selinuxConfig(directory, type, usepwd)
    selconf.write()
        
except getopt.error, error:
    errorExit(string.join("Options Error ", error))
    
except ValueError, error:
    errorExit(string.join("ValueError ", error))
except IndexError, error:
    errorExit("IndexError")

--------------040009080703000607010007--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
