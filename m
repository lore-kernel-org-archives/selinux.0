Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m69Cvuno000514
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2008 08:57:56 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m69Cvte1021554
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2008 12:57:55 GMT
Message-ID: <4874B5D1.9090805@redhat.com>
Date: Wed, 09 Jul 2008 08:57:53 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <karlwmacmillan@gmail.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: semanage patch to allow boolean files to be imported.
References: <4873C5B2.20009@redhat.com> <10143820807081315p2f2b12bx2754e157a640faeb@mail.gmail.com>
In-Reply-To: <10143820807081315p2f2b12bx2754e157a640faeb@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------080609060904070801010000"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080609060904070801010000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Karl MacMillan wrote:
> On Tue, Jul 8, 2008 at 3:53 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Added flag to semanage to be able to import and export boolean files
>> into the current system.
>>
> 
> [snip]
> 
>> +       def modify(self, name, value=False, use_file=False):
>> +
> 
Fixed
> I think it is more idiomatic to use None instead of False when the
> argument is a value rather than just a boolean.
> 
>>                rc = semanage_begin_transaction(self.sh)
>>                if rc < 0:
>>                        raise ValueError(_("Could not start semanage transaction"))
>> -
>> -               rc = semanage_bool_set_active(self.sh, k, b)
>> -               if rc < 0:
>> -                       raise ValueError(_("Could not set active value of boolean %s") % name)
>> -               rc = semanage_bool_modify_local(self.sh, k, b)
>> -               if rc < 0:
>> -                       raise ValueError(_("Could not modify boolean %s") % name)
>> +                if use_file:
> 
> And then "if use_file is not None:" here.
> 
>> +                       fd = open(name)
>> +                       for b in fd.read().split():
>> +                              bool, val = b.split("=")
> 
> I think you need a little more error checking here. For example, if
> the b.split("=") resulted in less than two items the split into the
> two variables would fail, raising an exception. I think that we would
> want it to be both more tolerant to malformed files and provide better
> error reporting to the user.
> 
> With those changes:
> 
> Acked-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

Added additional error checking and some better error messages.

Also fixed some indenting problems.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkh0tdAACgkQrlYvE4MpobPwngCgwnWEmSAzeCVW7FaD5djbhHg5
tMoAnAuFQMeSnxjZV0lIVUYfpwS33/vK
=d3ho
-----END PGP SIGNATURE-----

--------------080609060904070801010000
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude --exclude=sepolgen-1.0.12 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/semanage policycoreutils-2.0.52/semanage/semanage
--- nsapolicycoreutils/semanage/semanage	2008-07-02 17:19:15.000000000 -0400
+++ policycoreutils-2.0.52/semanage/semanage	2008-07-09 08:44:58.000000000 -0400
@@ -51,7 +51,7 @@
 semanage interface -{a|d|m} [-tr] interface_spec
 semanage fcontext -{a|d|m} [-frst] file_spec
 semanage translation -{a|d|m} [-T] level
-semanage boolean -{d|m} boolean
+semanage boolean -{d|m} [-F]  boolean | boolean_file
 semanage permissive -{d|a} type
 
 Primary Options:
@@ -79,6 +79,7 @@
 		-l (symbolic link) 
 		-p (named pipe) 
 
+        -F, --file       Treat target as an input file for command, change multiple settings
 	-p, --proto      Port protocol (tcp or udp)
 	-P, --prefix     Prefix for home directory labeling
 	-L, --level      Default SELinux Level (MLS/MCS Systems only)
@@ -114,7 +115,7 @@
 		valid_option["translation"] = []
 		valid_option["translation"] += valid_everyone + [ '-T', '--trans' ] 
 		valid_option["boolean"] = []
-		valid_option["boolean"] += valid_everyone + [ '--on', "--off", "-1", "-0" ] 
+		valid_option["boolean"] += valid_everyone + [ '--on', "--off", "-1", "-0", "-F", "--file"] 
 		valid_option["permissive"] = []
 		valid_option["permissive"] += [ '-a', '--add', '-d', '--delete', '-l', '--list', '-h', '--help', '-n', '--noheading', '-D', '--deleteall' ]
 		return valid_option
@@ -136,13 +137,14 @@
 		seuser = ""
 		prefix = ""
 		heading=1
-                value=0
-		add = 0
-		modify = 0
-		delete = 0
-		deleteall = 0
-		list = 0
-		locallist = 0
+                value = None
+		add = False
+		modify = False
+		delete = False
+		deleteall = False
+		list = False
+		locallist = False
+                use_file = False
                 store = ""
 		if len(sys.argv) < 3:
 			usage(_("Requires 2 or more arguments"))
@@ -155,11 +157,12 @@
 		args = sys.argv[2:]
 
 		gopts, cmds = getopt.getopt(args,
-					    '01adf:lhmnp:s:CDR:L:r:t:T:P:S:',
+					    '01adf:lhmnp:s:FCDR:L:r:t:T:P:S:',
 					    ['add',
 					     'delete',
 					     'deleteall',
 					     'ftype=',
+					     'file',
 					     'help',
 					     'list', 
 					     'modify',
@@ -185,18 +188,22 @@
 			if o == "-a" or o == "--add":
 				if modify or delete:
 					usage()
-				add = 1
+				add = True
 				
 			if o == "-d"  or o == "--delete":
 				if modify or add:
 					usage()
-				delete = 1
+				delete = True
 			if o == "-D"  or o == "--deleteall":
 				if modify:
                                        usage()
-				deleteall = 1
+				deleteall = True
 			if o == "-f"  or o == "--ftype":
 				ftype=a
+
+			if o == "-F"  or o == "--file":
+				use_file = True
+
 			if o == "-h" or o == "--help":
 				usage()
 
@@ -204,12 +211,12 @@
 				heading=0
 
 			if o == "-C" or o == "--locallist":
-				locallist=1
+				locallist = True
 
 			if o == "-m"or o == "--modify":
 				if delete or add:
 					usage()
-				modify = 1
+				modify = True
 				
 			if o == "-S" or o == '--store':
 				store = a
@@ -220,7 +227,7 @@
 				serange = a
 
 			if o == "-l" or o == "--list":
-				list = 1
+				list = True
 
 			if o == "-L" or o == '--level':
 				if is_mls_enabled == 0:
@@ -246,9 +253,9 @@
 				setrans = a
 
                         if o == "--on" or o == "-1":
-                               value = 1
+                               value = True
                         if o == "-off" or o == "-0":
-                               value = 0
+                               value = False
 
 		if object == "login":
 			OBJECT = seobject.loginRecords(store)
@@ -275,7 +282,10 @@
 			OBJECT = seobject.permissiveRecords(store)
 		
 		if list:
-			OBJECT.list(heading, locallist)
+                        if object == "boolean":
+                               OBJECT.list(heading, locallist, use_file)
+                        else:
+                               OBJECT.list(heading, locallist)
 			sys.exit(0);
 			
 		if deleteall:
@@ -298,8 +308,6 @@
 				rlist = roles.split()
 				if len(rlist) == 0:
 					raise ValueError(_("You must specify a role"))
-				if prefix == "":
-					raise ValueError(_("You must specify a prefix"))
 				OBJECT.add(target, rlist, selevel, serange, prefix)
 
 			if object == "port":
@@ -317,7 +325,7 @@
 			
 		if modify:
 			if object == "boolean":
-				OBJECT.modify(target, value)
+                               OBJECT.modify(target, value, use_file)
 
 			if object == "login":
 				OBJECT.modify(target, seuser, serange)
diff --exclude-from=exclude --exclude=sepolgen-1.0.12 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/semanage.8 policycoreutils-2.0.52/semanage/semanage.8
--- nsapolicycoreutils/semanage/semanage.8	2008-07-02 17:19:15.000000000 -0400
+++ policycoreutils-2.0.52/semanage/semanage.8	2008-07-09 08:44:40.000000000 -0400
@@ -3,9 +3,9 @@
 semanage \- SELinux Policy Management tool
 
 .SH "SYNOPSIS"
-.B semanage {boolean|login|user|port|interface|fcontext|translation} \-{l|lC|D} [\-n] 
+.B semanage {boolean|login|user|port|interface|fcontext|translation} \-{l|D} [\-n] [\-S store] 
 .br
-.B semanage boolean \-{d|m} [\-\-on|\-\-off|\-1|\-0] boolean
+.B semanage boolean \-{d|m} [\-\-on|\-\-off|\-1|\-0] -F boolean | boolean_file
 .br
 .B semanage login \-{a|d|m} [\-sr] login_name
 .br
@@ -54,6 +54,11 @@
 File Type.   This is used with fcontext.
 Requires a file type as shown in the mode field by ls, e.g. use -d to match only directories or -- to match only regular files.
 .TP
+.I                \-F, \-\-file
+Set multiple records from the input file.  When used with the \-l \-\-list, it will output the current settings to stdout in the proper format.
+
+Currently booleans only.
+.TP
 .I                \-h, \-\-help       
 display this message
 .TP
@@ -87,6 +92,9 @@
 .I                \-s, \-\-seuser     
 SELinux user name
 .TP
+.I                \-S, \-\-store
+Select and alternate SELinux store to manage
+.TP
 .I                \-t, \-\-type       
 SELinux Type for the object
 .TP
diff --exclude-from=exclude --exclude=sepolgen-1.0.12 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/seobject.py policycoreutils-2.0.52/semanage/seobject.py
--- nsapolicycoreutils/semanage/seobject.py	2008-07-02 17:19:15.000000000 -0400
+++ policycoreutils-2.0.52/semanage/seobject.py	2008-07-09 08:55:45.000000000 -0400
@@ -330,20 +330,15 @@
                       for name in dirs:
                              os.rmdir(os.path.join(root, name))
 
-               if rc != 0:
-                      raise ValueError(out)			
-
-
 	def delete(self, name):
 		for n in name.split():
 			rc = semanage_module_remove(self.sh, "permissive_%s" % n)
 			if rc < 0:
 	                        raise ValueError(_("Could not remove permissive domain %s (remove failed)") % name)
-               rc = semanage_commit(self.sh)
-               if rc < 0:
+                rc = semanage_commit(self.sh)
+                if rc < 0:
                        raise ValueError(_("Could not remove permissive domain %s (commit failed)") % name)
 			
-
 	def deleteall(self):
                l = self.get_all()
                if len(l) > 0:
@@ -1447,54 +1442,72 @@
 class booleanRecords(semanageRecords):
 	def __init__(self, store = ""):
 		semanageRecords.__init__(self, store)
+                self.dict={}
+                self.dict["TRUE"] = 1
+                self.dict["FALSE"] = 0
+                self.dict["ON"] = 1
+                self.dict["OFF"] = 0
+                self.dict["1"] = 1
+                self.dict["0"] = 0
 
-	def modify(self, name, value = ""):
-		if value == "":
-			raise ValueError(_("Requires value"))
-
-		(rc,k) = semanage_bool_key_create(self.sh, name)
-		if rc < 0:
-			raise ValueError(_("Could not create a key for %s") % name)
-
-		(rc,exists) = semanage_bool_exists(self.sh, k)
-		if rc < 0:
-			raise ValueError(_("Could not check if boolean %s is defined") % name)
-		if not exists:
-			raise ValueError(_("Boolean %s is not defined") % name)	
-
-		(rc,b) = semanage_bool_query(self.sh, k)
-		if rc < 0:
-			raise ValueError(_("Could not query file context %s") % name)
+	def __mod(self, name, value):
+                (rc,k) = semanage_bool_key_create(self.sh, name)
+                if rc < 0:
+                       raise ValueError(_("Could not create a key for %s") % name)
+                (rc,exists) = semanage_bool_exists(self.sh, k)
+                if rc < 0:
+                       raise ValueError(_("Could not check if boolean %s is defined") % name)
+                if not exists:
+                       raise ValueError(_("Boolean %s is not defined") % name)	
+                
+                (rc,b) = semanage_bool_query(self.sh, k)
+                if rc < 0:
+                       raise ValueError(_("Could not query file context %s") % name)
 
-		if value != "":
-			nvalue = int(value)
-			semanage_bool_set_value(b, nvalue)
+                if value.upper() in self.dict:
+                       semanage_bool_set_value(b, self.dict[value.upper()])
                 else:
-                       raise ValueError(_("You must specify a value"))
+                       raise ValueError(_("You must specify one of the following values: %s") % ", ".join(self.dict.keys()) )
+                
+                rc = semanage_bool_set_active(self.sh, k, b)
+                if rc < 0:
+                       raise ValueError(_("Could not set active value of boolean %s") % name)
+                rc = semanage_bool_modify_local(self.sh, k, b)
+                if rc < 0:
+                       raise ValueError(_("Could not modify boolean %s") % name)
+		semanage_bool_key_free(k)
+		semanage_bool_free(b)
 
+	def modify(self, name, value=None, use_file=False):
+                
 		rc = semanage_begin_transaction(self.sh)
 		if rc < 0:
 			raise ValueError(_("Could not start semanage transaction"))
-
-		rc = semanage_bool_set_active(self.sh, k, b)
-		if rc < 0:
-			raise ValueError(_("Could not set active value of boolean %s") % name)
-		rc = semanage_bool_modify_local(self.sh, k, b)
-		if rc < 0:
-			raise ValueError(_("Could not modify boolean %s") % name)
+                if use_file:
+                       fd = open(name)
+                       for b in fd.read().split("\n"):
+                              b = b.strip()
+                              if len(b) == 0:
+                                     continue
+
+                              try:
+                                     boolname, val = b.split("=")
+                              except ValueError, e:
+                                     raise ValueError(_("Bad format %s: Record %s" % ( name, b) ))
+                              self.__mod(boolname.strip(), val.strip())
+                       fd.close()
+                else:
+                       self.__mod(name, value)
 
 		rc = semanage_commit(self.sh)
 		if rc < 0:
 			raise ValueError(_("Could not modify boolean %s") % name)
 		
-		semanage_bool_key_free(k)
-		semanage_bool_free(b)
-
 	def delete(self, name):
-		(rc,k) = semanage_bool_key_create(self.sh, name)
-		if rc < 0:
-			raise ValueError(_("Could not create a key for %s") % name)
 
+                (rc,k) = semanage_bool_key_create(self.sh, name)
+                if rc < 0:
+                      raise ValueError(_("Could not create a key for %s") % name)
 		(rc,exists) = semanage_bool_exists(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not check if boolean %s is defined") % name)
@@ -1571,8 +1584,15 @@
                else:
                       return _("unknown")
 
-	def list(self, heading = 1, locallist = 0):
+	def list(self, heading = True, locallist = False, use_file = False):
                 on_off = (_("off"),_("on")) 
+		if use_file:
+                       ddict = self.get_all(locallist)
+                       keys = ddict.keys()
+                       for k in keys:
+                              if ddict[k]:
+                                     print "%s=%s" %  (k, ddict[k][2])
+                       return
 		if heading:
 			print "%-40s %s\n" % (_("SELinux boolean"), _("Description"))
 		ddict = self.get_all(locallist)

--------------080609060904070801010000
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iEYEABECAAYFAkh0tdAACgkQrlYvE4MpobP2iQCeJeZGDGz6JY/lLXRkIjYYFuSlC9wAn3uu
zC1voJuJZR24SA1NQmlX2SWX
--------------080609060904070801010000--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
