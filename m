Message-ID: <475840BE.20200@redhat.com>
Date: Thu, 06 Dec 2007 13:34:38 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: policycoreutils patch
Content-Type: multipart/mixed;
 boundary="------------050706000705080003030505"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050706000705080003030505
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The first patch to fixfiles, eliminates the verbose updates when doing a
diff with an old file context.  This was potentially causing lots of
messages in yum updates and caused an error during update.

Also better handling of arguments when passed into fixfiles.

The second patch adds better handling of boolean to semanage.  The
biggest improvement is the tool now extracts out the boolean description
when listing, making searching for a boolean easier.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHWEC9rlYvE4MpobMRAq3gAJ94UxlJ7lwij+WtkYkp0r4PmfB9cwCglprd
SgvCBh97RlQtNpS6QYoHr+c=
=s0k6
-----END PGP SIGNATURE-----

--------------050706000705080003030505
Content-Type: text/plain;
 name="policycoreutils-rhat.patch.part001"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch.part001"

--- nsapolicycoreutils/scripts/fixfiles	2007-08-23 16:52:26.000000000 -0400
+++ policycoreutils-2.0.31/scripts/fixfiles	2007-11-16 16:30:21.000000000 -0500
@@ -92,7 +92,7 @@
 		      ! \( -fstype ext2 -o -fstype ext3 -o -fstype jfs -o -fstype xfs \) -prune  -o \
 		      \( -wholename /home -o -wholename /root -o -wholename /tmp -wholename /dev \) -prune -o -print; \
 		      done 2> /dev/null | \
-	 ${RESTORECON} $2 -v -f - 
+	 ${RESTORECON} $2 -f - 
 	rm -f ${TEMPFILE} ${PREFCTEMPFILE}
 fi
 }
@@ -189,21 +189,27 @@
     case "$i" in
 	f)
 		fullFlag=1
+		shift 1
 		;;
         R)
 		RPMFILES=$OPTARG
+		shift 2
 		;;
         o)
 		OUTFILES=$OPTARG
+		shift 2
 		;;
         l)
 		LOGFILE=$OPTARG
+		shift 2
 		;;
         C)
 		PREFC=$OPTARG
+		shift 2
 		;;
 	F)
 		FORCEFLAG="-F"
+		shift 1
 		;;
 	*)
 	    usage
@@ -211,10 +217,8 @@
 esac
 done
 
-
 # Check for the command
-eval command=\$${OPTIND}
-let OPTIND=$OPTIND+1
+command=$1
 if [ -z $command ]; then
     usage
 fi
@@ -223,17 +227,15 @@
 # check if they specified both DIRS and RPMFILES
 #
 
+shift 1
 if [ ! -z "$RPMFILES" ]; then
-    if [ $OPTIND -le $# ]; then
+    if [ $# -gt 0 ]; then
 	    usage
     fi
 else
-    while [ $OPTIND -le $# ]; do
-	eval DIR=\$${OPTIND}
-	DIRS="$DIRS $DIR"
-	let OPTIND=$OPTIND+1
-    done
+    DIRS=$*
 fi
+
 #
 # Make sure they specified one of the three valid commands
 #

--------------050706000705080003030505
Content-Type: text/plain;
 name="policycoreutils-rhat.patch.part002"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch.part002"

--- nsapolicycoreutils/semanage/seobject.py	2007-10-07 21:46:43.000000000 -0400
+++ policycoreutils-2.0.31/semanage/seobject.py	2007-11-19 17:35:04.000000000 -0500
@@ -1,5 +1,5 @@
 #! /usr/bin/python -E
-# Copyright (C) 2005 Red Hat 
+# Copyright (C) 2005, 2006, 2007 Red Hat 
 # see file 'COPYING' for use and warranty information
 #
 # semanage is a tool for managing SELinux configuration files
@@ -88,6 +88,35 @@
 			
 mylog = logger()		
 
+import sys, os
+import re
+import xml.etree.ElementTree
+
+booleans_dict={}
+try:
+       tree=xml.etree.ElementTree.parse("/usr/share/selinux/devel/policy.xml")
+       for l in  tree.findall("layer"):
+              for m in  l.findall("module"):
+                     for b in  m.findall("tunable"):
+                            desc = b.find("desc").find("p").text.strip("\n")
+                            desc = re.sub("\n", " ", desc)
+                            booleans_dict[b.get('name')] = (m.get("name"), b.get('dftval'), desc)
+                     for b in  m.findall("bool"):
+                            desc = b.find("desc").find("p").text.strip("\n")
+                            desc = re.sub("\n", " ", desc)
+                            booleans_dict[b.get('name')] = (m.get("name"), b.get('dftval'), desc)
+              for i in  tree.findall("bool"):
+                     desc = i.find("desc").find("p").text.strip("\n")
+                     desc = re.sub("\n", " ", desc)
+                     booleans_dict[i.get('name')] = (_("global"), i.get('dftval'), desc)
+       for i in  tree.findall("tunable"):
+              desc = i.find("desc").find("p").text.strip("\n")
+              desc = re.sub("\n", " ", desc)
+              booleans_dict[i.get('name')] = (_("global"), i.get('dftval'), desc)
+except IOError, e:
+       #print _("Failed to translate booleans.\n%s") % e
+       pass
+
 def validate_level(raw):
 	sensitivity = "s[0-9]*"
 	category = "c[0-9]*"
@@ -1095,7 +1121,13 @@
 
                 return con
                
+        def validate(self, target):
+               if target == "" or target.find("\n") >= 0:
+                      raise ValueError(_("Invalid file specification"))
+                      
 	def add(self, target, type, ftype = "", serange = "", seuser = "system_u"):
+                self.validate(target)
+
 		if is_mls_enabled == 1:
                        serange = untranslate(serange)
 			
@@ -1154,6 +1186,7 @@
 	def modify(self, target, setype, ftype, serange, seuser):
 		if serange == "" and setype == "" and seuser == "":
 			raise ValueError(_("Requires setype, serange or seuser"))
+                self.validate(target)
 
 		(rc,k) = semanage_fcontext_key_create(self.sh, target, file_types[ftype])
 		if rc < 0:
@@ -1328,11 +1362,14 @@
 		if value != "":
 			nvalue = int(value)
 			semanage_bool_set_value(b, nvalue)
+                else:
+                       raise ValueError(_("You must specify a value"))
 
 		rc = semanage_begin_transaction(self.sh)
 		if rc < 0:
 			raise ValueError(_("Could not start semanage transaction"))
 
+                rc = semanage_bool_set_active(self.sh, k, b)
 		rc = semanage_bool_modify_local(self.sh, k, b)
 		if rc < 0:
 			raise ValueError(_("Could not modify boolean %s") % name)
@@ -1416,11 +1453,25 @@
 
 		return ddict
 			
+        def get_desc(self, boolean):
+               if boolean in booleans_dict:
+                      return _(booleans_dict[boolean][2])
+               else:
+                      return boolean
+
+        def get_category(self, boolean):
+               if boolean in booleans_dict:
+                      return _(booleans_dict[boolean][0])
+               else:
+                      return _("unknown")
+
 	def list(self, heading = 1, locallist = 0):
+                on_off = (_("off"),_("on")) 
 		if heading:
-			print "%-50s %7s %7s %7s\n" % (_("SELinux boolean"), _("value"), _("pending"),  _("active") )
+			print "%-40s %s\n" % (_("SELinux boolean"), _("Description"))
 		ddict = self.get_all(locallist)
 		keys = ddict.keys()
 		for k in keys:
 			if ddict[k]:
-				print "%-50s %7d %7d %7d " % (k, ddict[k][0],ddict[k][1], ddict[k][2])
+				print "%-30s -> %-5s %s" %  (k, on_off[ddict[k][2]], self.get_desc(k))
+

--------------050706000705080003030505
Content-Type: application/octet-stream;
 name="policycoreutils-rhat.patch.part001.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="policycoreutils-rhat.patch.part001.sig"

iD8DBQBHWEC9rlYvE4MpobMRAta8AJ9ToAgE1KV+6wuEbac6xAQO0MdxIQCfeOyPLseLvYJu
+JihxLKJHtxZkYk=
--------------050706000705080003030505
Content-Type: application/octet-stream;
 name="policycoreutils-rhat.patch.part002.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="policycoreutils-rhat.patch.part002.sig"

iD8DBQBHWEC9rlYvE4MpobMRAsw8AJ93bjk9M6ICZ0ZjFD7wErtO6vUKEACfduqwqSrZkRh+
jMevmSndq4g2nWc=
--------------050706000705080003030505--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
