Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1RLITRb014054
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 16:18:29 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1RLIQQQ006972
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 21:18:26 GMT
Received: from mail.idtweb.com (mail.idtweb.com [63.140.241.100])
        by jazzband.ncsc.mil  with ESMTP id i1RLIPP0006964 for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 21:18:25 GMT
Subject: Re: Proposed patch to policy file_contexts
From: Karl MacMillan <kmacmillan@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <403E52AD.5090103@redhat.com>
References: <403E52AD.5090103@redhat.com>
Content-Type: multipart/mixed; boundary="=-K4F/agBkq4AMf5iiZNwI"
Message-Id: <1077916703.11720.274.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Fri, 27 Feb 2004 16:18:24 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-K4F/agBkq4AMf5iiZNwI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Dan,

We have been looking at this lately and come up with a solution that
modifies the genhomedircon script (which is attached). It looks like
your changes don't address all of the file contexts - just what is in
types.fc. Our genhomedircon handles 2 main cases:

1. For policy users it generates specific file_contexts entries
including those in modules (i.e. not just in types.fc).
2. It generates generic entries for all home directory prefixes based on
the contents /etc/passwd and /etc/defaults/useradd.

It does this by replacing /home with the magic string HOME_ROOT,
/home/[^/] with HOME_DIR, and user_* with ROLE_* in the file contexts
file. Those strings are then replaced with the correct entries. For
example, the gpg entry:

/home/[^/]+/\.gnupg(/.+)?       system_u:object_r:user_gpg_secret_t
/root/\.gnupg(/.+)?             system_u:object_r:sysadm_gpg_secret_t

would be replaced with:

HOME_DIR/\.gnupg(/.+)?  system_u:object_r:ROLE_gpg_secret_t

The genhomedircon script would then replace the strings appropriately
with information from the policy and system. Let me know what you think.
I can send a patch that includes the policy changes if this change looks
good.

Karl

On Thu, 2004-02-26 at 15:10, Daniel J Walsh wrote:
> Since the file_contexts file is now being build with m4, I am proposing 
> this patch to allow for simpler specifications of alternate 
> homedirectories or staff users.
> 
> As we are roling this out we are finding many users placing their 
> homedirectories in the non standard location.
> 
> What do you think?
> 
> Dan
> 
> ______________________________________________________________________
> --- policy-1.6/file_contexts/users.fc.homedir	2004-02-26 15:03:53.957826373 -0500
> +++ policy-1.6/file_contexts/users.fc	2004-02-26 15:03:07.283167405 -0500
> @@ -0,0 +1,9 @@
> +#
> +# If you have an alternate homedir you would specify it here
> +#
> +#home_dir(user, /local_home)
> +#
> +#  If you have alternate members of staff you would specify it here
> +#
> +#home_dir(staff, /home,jadmin)
> +#home_dir(staff, /local_home,jadmin)
> --- policy-1.6/file_contexts/types.fc.homedir	2004-02-26 14:57:19.071019536 -0500
> +++ policy-1.6/file_contexts/types.fc	2004-02-26 14:59:04.624938026 -0500
> @@ -82,9 +82,7 @@
>  # 
>  # Ordinary user home directories.
>  #
> -/home			-d	system_u:object_r:home_root_t
> -/home/[^/]+		-d	system_u:object_r:user_home_dir_t
> -/home/[^/]+/.+			system_u:object_r:user_home_t
> +home_dir(user,/home)
>  
>  #
>  # /bin
> @@ -418,7 +416,8 @@
>  /lost\+found(/.*)?		system_u:object_r:lost_found_t
>  /usr/lost\+found(/.*)?		system_u:object_r:lost_found_t
>  /boot/lost\+found(/.*)?		system_u:object_r:lost_found_t
> -/home/lost\+found(/.*)?		system_u:object_r:lost_found_t
> +# moved to home.fc 
> +# /home/lost\+found(/.*)?		system_u:object_r:lost_found_t
>  /var/lost\+found(/.*)?		system_u:object_r:lost_found_t
>  /tmp/lost\+found(/.*)?		system_u:object_r:lost_found_t
>  /usr/local/lost\+found(/.*)?	system_u:object_r:lost_found_t
> --- policy-1.6/file_contexts/homedir.homedir	2004-02-26 14:57:07.079392137 -0500
> +++ policy-1.6/file_contexts/homedir	2004-02-26 14:56:33.529232470 -0500
> @@ -0,0 +1,14 @@
> +define(`home_dir',`
> +$2			-d	system_u:object_r:home_root_t
> +ifelse($3,`',`
> +$2/[^/]+		-d	system_u:object_r:$1_home_dir_t
> +$2/[^/]+/.+			system_u:object_r:$1_home_t
> +$2/\.journal			<<none>>
> +$2/lost\+found(/.*)?		system_u:object_r:lost_found_t
> +', `
> +$2/$3/[^/]+		-d	system_u:object_r:$1_home_dir_t
> +$2/$3/[^/]+/.+			system_u:object_r:$1_home_t
> +$2/$3/\.journal			<<none>>
> +$2/$3/lost\+found(/.*)?		system_u:object_r:lost_found_t
> +')
> +')
> --- policy-1.6/Makefile.homedir	2004-02-26 15:00:50.902774628 -0500
> +++ policy-1.6/Makefile	2004-02-26 15:01:16.167883200 -0500
> @@ -51,7 +51,7 @@
>  UNUSED_TE_FILES := $(wildcard domains/program/unused/*.te)
>  
>  FC = file_contexts/file_contexts
> -FCFILES=file_contexts/types.fc $(wildcard file_contexts/misc/*.fc) $(patsubst domains/program/%.te,file_contexts/program/%.fc, $(wildcard domains/program/*.te))
> +FCFILES=file_contexts/homedir file_contexts/types.fc file_contexts/users.fc $(wildcard file_contexts/misc/*.fc) $(patsubst domains/program/%.te,file_contexts/program/%.fc, $(wildcard domains/program/*.te))
>  
>  APPDIR=$(DESTDIR)/etc/security
>  APPFILES = $(addprefix $(APPDIR)/,default_contexts default_type initrc_context failsafe_context)
-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com
(410) 290-1411 x134

--=-K4F/agBkq4AMf5iiZNwI
Content-Disposition: attachment; filename=genhomedircon
Content-Type: text/plain; name=genhomedircon; charset=UTF-8
Content-Transfer-Encoding: 7bit

#!/usr/bin/python
# Copyright (C) 2004 Tresys Technology, LLC
# see file 'COPYING' for use and warranty information

#
# genhomedircon - Replace HOME_ROOT, HOME_DIR, and ROLE macros in .fc files
#  with generic and user-specific values.
#
# ASSUMPTIONS:
#
# If a user has more than one role in FILECONTEXTDIR/users, genhomedircon uses
#  the first role in the list.
#
# If a user is not listed in FILECONTEXTDIR/users, genhomedircon assumes that
#  the user's home dir will be found in one of the HOME_ROOTs.
#
# "Real" users (as opposed to system users) are those whose UID is greater than
#  or equal STARTING_UID (usually 100) and whose login is not a member of
#  EXCLUDE_LOGINS.  Users who are explicitly defined in FILECONTEXTDIR/users
#  are always "real" (including root, in the default configuration).
#

import commands, sys, os, pwd, string

FILECONTEXTDIR="/etc/security/selinux/src/policy/"
EXCLUDE_LOGINS=["/sbin/nologin", "/bin/false"]
STARTING_UID=100

def getPrefixes():
	ulist = pwd.getpwall()
	prefixes = {}
	for u in ulist:
		if u[2] >= STARTING_UID and \
		   not u[6] in EXCLUDE_LOGINS and \
		   u[5] != "/" and \
		   string.count(u[5], "/") > 1:
			prefix = u[5][:string.rfind(u[5], "/")]
			if not prefixes.has_key(prefix):
				prefixes[prefix] = ""
	return prefixes

def getUsers():
	rc = commands.getstatusoutput("grep ^user %s/users" % FILECONTEXTDIR)
	udict = {}
	if rc[0] == 0:
		ulist = rc[1].strip().split("\n")
		for u in ulist:
			user = u.split()
			try:
				if user[1] == "user_u" or user[1] == "system_u":
					continue
				# !!! chooses first role in the list to use in the file context !!!
				role = user[4].split("_r")[0]
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

def usage(error = ""):
	if error != "":
		sys.stderr.write("%s\n" % (error,))
	sys.stderr.write("Usage: %s FILE_CONTEXTS\n" % sys.argv[0])
	sys.stderr.flush()
	sys.exit(1)

def update(filecontext, user, prefs):
	rc=commands.getstatusoutput("grep -h '^HOME_DIR' %s | grep -v vmware | sed -e 's|HOME_DIR|%s|g' -e 's/ROLE/%s/' -e 's/system_u/%s/'" % (filecontext, prefs["home"], prefs["role"], user))
	if rc[0] == 0:
		print rc[1]
	else:
		usage(rc[1])
	return rc

try:
	prefixes = getPrefixes()

	rc=commands.getstatusoutput("grep -h '^HOME' /etc/default/useradd")
	if rc[0] == 0:
		homedir = rc[1].split("=")[1]
	else:
		sys.stderr.write("%s\n" % (rc[1],))
		sys.stderr.write("Do you have access to /etc/default/useradd?\n")
		sys.stderr.flush()
		sys.exit(1)

	if not prefixes.has_key(homedir):
		prefixes[homedir] = ""

	if len(prefixes) == 1:
		regex_root = prefixes.keys()[0]
	else:
		regex_root = "(%s)" % (string.join(prefixes, "\|"),)
	regex_dir = "%s/[^/]+" % (regex_root,)

	# Fill in HOME_ROOT, HOME_DIR, and ROLE for users not explicitly defined in /etc/security/selinux/src/policy/users
	rc=commands.getstatusoutput("sed -e 's|^HOME_ROOT|%s|g' -e 's|^HOME_DIR|%s|g' -e 's/ROLE_/user_/' %s" % (regex_root, regex_dir, sys.argv[1]))
	if rc[0] == 0:
		print rc[1]
	else:
		usage(rc[1])

	users = getUsers()
	print "\n#\n# User-specific file contexts\n#\n"

	# Fill in HOME and ROLE for users that are defined
	for u in users.keys():
		update(sys.argv[1], u, users[u])

except ValueError, error:
	usage(error)
except IndexError, error:
	usage()

--=-K4F/agBkq4AMf5iiZNwI--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
