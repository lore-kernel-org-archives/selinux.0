Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA7Ekc3U011148
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:46:39 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mA7EivQi010596
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 14:44:58 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id mA7Ekcbe005375
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:46:38 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id mA7EkbFN001630
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:46:37 -0500
Received: from holycross.boston.devel.redhat.com (holycross.boston.devel.redhat.com [10.16.60.79])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id mA7EkaDk016396
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:46:37 -0500
Message-ID: <491454CC.3000708@redhat.com>
Date: Fri, 07 Nov 2008 09:46:36 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: seobject_fcontext patch allows you to modify a preexisting file context.
Content-Type: multipart/mixed;
 boundary="------------050209040608080802050401"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050209040608080802050401
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Currently semanage is not allowed to change a file context mapping if it
matches exactly,  this patch allows you to modify the file context.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkkUVMwACgkQrlYvE4MpobONMgCgi6UbaQXR2yK+tXzh6ouLNtfY
PFQAn38zI31rZtdBqKTS34SaEfQ5K4VG
=6jM8
-----END PGP SIGNATURE-----

--------------050209040608080802050401
Content-Type: text/plain;
 name="seobject_fcontext.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="seobject_fcontext.patch"

--- nsapolicycoreutils/semanage/seobject.py	2008-09-12 11:48:15.000000000 -0400
+++ policycoreutils-2.0.57/semanage/seobject.py	2008-10-28 15:48:14.000000000 -0400
@@ -1433,8 +1433,14 @@
 		(rc,exists) = semanage_fcontext_exists(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not check if file context for %s is defined") % target)
-		if exists:
-			raise ValueError(_("File context for %s already defined") % target)
+
+		if not exists:
+                       (rc,exists) = semanage_fcontext_exists_local(self.sh, k)
+                       if rc < 0:
+                              raise ValueError(_("Could not check if file context for %s is defined") % target)
+
+                if exists:
+                       raise ValueError(_("File context for %s already defined") % target)
 
 		(rc,fcontext) = semanage_fcontext_create(self.sh)
 		if rc < 0:
@@ -1481,15 +1487,19 @@
 		if rc < 0:
 			raise ValueError(_("Could not create a key for %s") % target)
 
-		(rc,exists) = semanage_fcontext_exists_local(self.sh, k)
+		(rc,exists) = semanage_fcontext_exists(self.sh, k)
 		if rc < 0:
 			raise ValueError(_("Could not check if file context for %s is defined") % target)
 		if not exists:
-			raise ValueError(_("File context for %s is not defined") % target)
+                       (rc,exists) = semanage_fcontext_exists_local(self.sh, k)
+                       if not exists:
+                              raise ValueError(_("File context for %s is not defined") % target)
 		
 		(rc,fcontext) = semanage_fcontext_query_local(self.sh, k)
 		if rc < 0:
-			raise ValueError(_("Could not query file context for %s") % target)
+                       (rc,fcontext) = semanage_fcontext_query(self.sh, k)
+                       if rc < 0:
+                              raise ValueError(_("Could not query file context for %s") % target)
 
                 if setype != "<<none>>":
                        con = semanage_fcontext_get_con(fcontext)
@@ -1591,30 +1601,33 @@
 
                        self.flist += fclocal
 
+                ddict = {}
 		for fcontext in self.flist:
 			expr = semanage_fcontext_get_expr(fcontext)
 			ftype = semanage_fcontext_get_type(fcontext)
 			ftype_str = semanage_fcontext_get_type_str(ftype)
 			con = semanage_fcontext_get_con(fcontext)
 			if con:
-				l.append((expr, ftype_str, semanage_context_get_user(con), semanage_context_get_role(con), semanage_context_get_type(con), semanage_context_get_mls(con)))
+                               ddict[(expr, ftype_str)] = (semanage_context_get_user(con), semanage_context_get_role(con), semanage_context_get_type(con), semanage_context_get_mls(con))
 			else:
-				l.append((expr, ftype_str, con))
+				ddict[(expr, ftype_str)] = con
 
-		return l
+		return ddict
 			
 	def list(self, heading = 1, locallist = 0 ):
 		if heading:
 			print "%-50s %-18s %s\n" % (_("SELinux fcontext"), _("type"), _("Context"))
-		fcon_list = self.get_all(locallist)
-		for fcon in fcon_list:
-			if len(fcon) > 3:
+		fcon_dict = self.get_all(locallist)
+                keys = fcon_dict.keys()
+                keys.sort()
+		for k in keys:
+			if fcon_dict[k]:
 				if is_mls_enabled:
-					print "%-50s %-18s %s:%s:%s:%s " % (fcon[0], fcon[1], fcon[2], fcon[3], fcon[4], translate(fcon[5],False))
+					print "%-50s %-18s %s:%s:%s:%s " % (k[0], k[1], fcon_dict[k][0], fcon_dict[k][1], fcon_dict[k][2], translate(fcon_dict[k][3],False))
 				else:
-					print "%-50s %-18s %s:%s:%s " % (fcon[0], fcon[1], fcon[2], fcon[3],fcon[4])
+					print "%-50s %-18s %s:%s:%s " % (k[0], k[1], fcon_dict[k][0], fcon_dict[k][1],fcon_dict[k][2])
 			else:
-				print "%-50s %-18s <<None>>" % (fcon[0], fcon[1])
+				print "%-50s %-18s <<None>>" % (k[0], k[1])
 				
 class booleanRecords(semanageRecords):
 	def __init__(self, store = ""):

--------------050209040608080802050401
Content-Type: application/octet-stream;
 name="seobject_fcontext.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="seobject_fcontext.patch.sig"

iEYEABECAAYFAkkUVMwACgkQrlYvE4MpobP0xQCgmVTs5S2iYdc4JR3Z5R5wTWKDV/gAn0at
BDgBD+CAs8lgWw/1b0SWxI1O
--------------050209040608080802050401--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
