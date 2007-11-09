Message-ID: <47349353.7080203@redhat.com>
Date: Fri, 09 Nov 2007 12:05:23 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: Patch to allow semanage to set boolean values and translate	booleans
 via policy.xml
References: <472B817D.3030400@redhat.com> <1194625539.624.57.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1194625539.624.57.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------000202000802020502020506"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000202000802020502020506
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Fri, 2007-11-02 at 15:58 -0400, Daniel J Walsh wrote:
> Also added translations of booleans to command line.
> 
>>>> /usr/sbin/semanage boolean -l  | grep nfs_export
>>>> nfs_export_all_rw              -> off   Allow nfs to be exported read/write.
>>>> nfs_export_all_ro              -> on    Allow nfs to be exported read only
>>>> sh-3.2# /usr/sbin/semanage boolean -l  | grep nfs
>>>> xen_use_nfs                    -> off   Allow xen to manage nfs files
>>>> use_nfs_home_dirs              -> on    Support NFS home directories
>>>> allow_ftpd_use_nfs             -> off   Allow ftp servers to use nfs used for public file transfer services.
>>>> cdrecord_read_content          -> off   Allow cdrecord to read various content. nfs, samba, removable devices, user temp and untrusted content files
>>>> httpd_use_nfs                  -> off   Allow httpd to read nfs files
>>>> samba_share_nfs                -> off   Allow samba to export NFS volumes.
>>>> mail_read_content              -> off   Allow email client to various content. nfs, samba, removable devices, user temp and untrusted content files
>>>> allow_nfsd_anon_write          -> off   Allow nfs servers to modify public files used for public file transfer services.
>>>> nfs_export_all_rw              -> off   Allow nfs to be exported read/write.
>>>> nfs_export_all_ro              -> on    Allow nfs to be exported read only
> 
> This time with the patch.  :^)
> 
>> Offhand, the only problem I see it that semanage boolean -l then fails
>> if /usr/share/selinux/devel/policy.xml doesn't exist, rather than just
>> falling back to displaying the untranslated booleans.
> 
>> Also, is /usr/share/selinux/devel/policy.xml created by upstream
>> refpolicy or is it Fedora-specific?
> 
> 
policy.xml is generated in the build procedure, so it is combined
reference polciy plus my patches.

Updated patch to do a fallback.

Two problems with policy.xml right now.

1.  Third parties have no way of updating it.
     semodule should automatically generate the XML and edit policy.xml
2.  Generated booleans within an interface do not get xml

semanage boolean -l | grep xguest
browser_write_xguest_data      -> off   browser_write_xguest_data
allow_xguest_exec_content      -> off   allow_xguest_exec_content
browser_confine_xguest         -> on    browser_confine_xguest

    We need to change a way to add documentation to booleans created
within an interface.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHNJNSrlYvE4MpobMRAqiyAJ9Mm/TKM393yIGp+vSNSKKYk+JZCgCdF+Bi
dxKEDLRVlIKlXvy10+QysUQ=
=UVHb
-----END PGP SIGNATURE-----

--------------000202000802020502020506
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude --exclude=sepolgen-1.0.10 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/semanage policycoreutils-2.0.31/semanage/semanage
--- nsapolicycoreutils/semanage/semanage	2007-10-05 13:09:53.000000000 -0400
+++ policycoreutils-2.0.31/semanage/semanage	2007-11-02 15:54:42.000000000 -0400
@@ -1,5 +1,5 @@
 #! /usr/bin/python -E
-# Copyright (C) 2005 Red Hat 
+# Copyright (C) 2005, 2006, 2007 Red Hat 
 # see file 'COPYING' for use and warranty information
 #
 # semanage is a tool for managing SELinux configuration files
@@ -115,7 +115,7 @@
 		valid_option["translation"] = []
 		valid_option["translation"] += valid_everyone + [ '-T', '--trans' ] 
 		valid_option["boolean"] = []
-		valid_option["boolean"] += valid_everyone 
+		valid_option["boolean"] += valid_everyone + [ '--on', "--off", "-1", "-0" ] 
 		return valid_option
 
 	#
@@ -135,7 +135,7 @@
 		seuser = ""
 		prefix = ""
 		heading=1
-
+                value=0
 		add = 0
 		modify = 0
 		delete = 0
@@ -154,7 +154,7 @@
 		args = sys.argv[2:]
 
 		gopts, cmds = getopt.getopt(args,
-					    'adf:lhmnp:s:CDR:L:r:t:T:P:S:',
+					    '01adf:lhmnp:s:CDR:L:r:t:T:P:S:',
 					    ['add',
 					     'delete',
 					     'deleteall',
@@ -164,6 +164,8 @@
 					     'modify',
 					     'noheading',
 					     'localist',
+                                             'off', 
+                                             'on', 
 					     'proto=',
 					     'seuser=',
 					     'store=',
@@ -242,6 +244,11 @@
 			if o == "-T" or o == "--trans":
 				setrans = a
 
+                        if o == "--on" or o == "-1":
+                               value = 1
+                        if o == "-off" or o == "-0":
+                               value = 0
+
 		if object == "login":
 			OBJECT = seobject.loginRecords(store)
 
diff --exclude-from=exclude --exclude=sepolgen-1.0.10 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/seobject.py policycoreutils-2.0.31/semanage/seobject.py
--- nsapolicycoreutils/semanage/seobject.py	2007-10-07 21:46:43.000000000 -0400
+++ policycoreutils-2.0.31/semanage/seobject.py	2007-11-09 12:00:35.000000000 -0500
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
+       print _("Failed to translate booleans.\n%s") % e
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

--------------000202000802020502020506
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iD8DBQBHNJNTrlYvE4MpobMRAmGoAJ9kpI1QtS4WEVHjIl5lySv3RZNQqACfRTsr5RhNYwXb
qpc4hqxd2TXVzLU=
--------------000202000802020502020506--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
