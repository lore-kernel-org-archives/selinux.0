Subject: [Fwd: Re: [Fwd: Re: genhomedircon is causing policycoreutils and
	matchpathcon to fail]]
From: Karl MacMillan <kmacmillan@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>
Content-Type: multipart/mixed; boundary="=-upS5log0MeXNCk/XDqiL"
Message-Id: <1079110151.8603.3.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Fri, 12 Mar 2004 11:49:12 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-upS5log0MeXNCk/XDqiL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-03-10 at 11:32, Stephen Smalley wrote:
> FYI.  The new genhomedircon is generating lines that are extremely long
> if lots of different home directory roots are listed in /etc/passwd
> (e.g. a NIS map for a distributed enterprise), and setfiles and
> matchpathcon currently use a fixed size buffer for reading lines from
> file_contexts.  We can certainly change that to allow for dynamic
> sizing, but it might be best to have genhomedircon generate separate
> lines for each home directory root rather than merging them into a
> single line with |'s.  
> 

Patch to fix this (by generating separate lines for each prefix) is
attached.

Karl

> -----Forwarded Message-----
> From: Daniel J Walsh <Dan-Walsh@comcast.net>
> To: Stephen Smalley <sds@epoch.ncsc.mil>
> Subject: Re: genhomedircon is causing policycoreutils and matchpathcon to fail
> Date: Wed, 10 Mar 2004 11:22:34 -0500
> 
> Stephen Smalley wrote:
> 
> >On Wed, 2004-03-10 at 11:11, Daniel J Walsh wrote:
> >  
> >
> >>You have too small a bufsize for reading in entries from the 
> >>file_contexts file. 
> >>
> >>I increased the size to BUFSIZ, but we probably need a better scheme, in 
> >>the future.
> >>    
> >>
> >
> >When do you end up with a file_contexts line > 255 characters?  Very
> >long path to home directory?  I suppose we should be using PATHMAX +
> >some size for the context.
> >
> >  
> >
> No even longer.  The genhomedircon is getting all possible homedirs out 
> of the password file, in our case we are using nis and getting a 
> different homedir for each side.
> 
> /home/boston, /home/atlanta ...  It appends them all on the same line using
> 
> (/home/boston|/home/atlanta ...) system_u:object_r:home_user_t;
-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com
(410) 290-1411 x134

--=-upS5log0MeXNCk/XDqiL
Content-Disposition: attachment; filename=genhomedircon-3-12-2004.patch
Content-Type: text/x-patch; name=genhomedircon-3-12-2004.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- genhomedircon.orig	2004-03-11 16:41:09.000000000 -0500
+++ genhomedircon	2004-03-11 16:48:08.000000000 -0500
@@ -70,7 +70,7 @@
 	sys.exit(1)
 
 def update(filecontext, user, prefs):
-	rc=commands.getstatusoutput("grep -h '^HOME_DIR' %s | grep -v vmware | sed -e 's|HOME_DIR|%s|g' -e 's/ROLE/%s/' -e 's/system_u/%s/'" % (filecontext, prefs["home"], prefs["role"], user))
+	rc=commands.getstatusoutput("grep -h '^HOME_DIR' %s | grep -v vmware | sed -e 's|HOME_DIR|%s|' -e 's/ROLE/%s/' -e 's/system_u/%s/'" % (filecontext, prefs["home"], prefs["role"], user))
 	if rc[0] == 0:
 		print rc[1]
 	else:
@@ -92,14 +92,12 @@
 	if not prefixes.has_key(homedir):
 		prefixes[homedir] = ""
 
-	if len(prefixes) == 1:
-		regex_root = prefixes.keys()[0]
-	else:
-		regex_root = "(%s)" % (string.join(prefixes, "\|"),)
-	regex_dir = "%s/[^/]+" % (regex_root,)
+	# There may be a more elegant sed script to expand a macro to multiple lines, but this works
+	sed_root = "h; s|^HOME_ROOT|%s|" % (string.join(prefixes.keys(), "|; p; g; s|^HOME_ROOT|"),)
+	sed_dir = "h; s|^HOME_DIR|%s/[^/]+|; s|ROLE_|user_|" % (string.join(prefixes.keys(), "/[^/]+|; s|ROLE_|user_|; p; g; s|^HOME_DIR|"),)
 
 	# Fill in HOME_ROOT, HOME_DIR, and ROLE for users not explicitly defined in /etc/security/selinux/src/policy/users
-	rc=commands.getstatusoutput("sed -e 's|^HOME_ROOT|%s|g' -e 's|^HOME_DIR|%s|g' -e 's/ROLE_/user_/' %s" % (regex_root, regex_dir, sys.argv[1]))
+	rc=commands.getstatusoutput("sed -e \"/^HOME_ROOT/{%s}\" -e \"/^HOME_DIR/{%s}\" %s" % (sed_root, sed_dir, sys.argv[1]))
 	if rc[0] == 0:
 		print rc[1]
 	else:

--=-upS5log0MeXNCk/XDqiL--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
