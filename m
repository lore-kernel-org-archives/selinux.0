Message-ID: <47098D24.6030509@redhat.com>
Date: Sun, 07 Oct 2007 21:51:32 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: deleteall added for ports and fcontext in semanage
Content-Type: multipart/mixed;
 boundary="------------060701070106000406030605"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060701070106000406030605
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------060701070106000406030605
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude --exclude=sepolgen-1.0.10 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/seobject.py policycoreutils-2.0.28/semanage/seobject.py
--- nsapolicycoreutils/semanage/seobject.py	2007-10-07 21:46:43.000000000 -0400
+++ policycoreutils-2.0.28/semanage/seobject.py	2007-10-05 13:10:29.000000000 -0400
@@ -139,7 +139,7 @@
 			translations = fd.readlines()
 			fd.close()
 		except IOError, e:
-			raise ValueError(_("Unable to open %s: translations not supported on non-MLS machines: %s") % (self.filename, e) )
+			raise ValueError(_("Unable to open %s: translations not supported on non-MLS machines") % (self.filename) )
 			
 		self.ddict = {}
 		self.comments = []
@@ -236,9 +236,6 @@
 		if rc < 0:
 			semanage_handle_destroy(self.sh)
 			raise ValueError(_("Could not establish semanage connection"))
-        def deleteall(self):
-               raise ValueError(_("Not yet implemented"))
-               
 
 class loginRecords(semanageRecords):
 	def __init__(self, store = ""):
@@ -779,34 +776,6 @@
 		semanage_port_key_free(k)
 		semanage_port_free(p)
 
-	def deleteall(self):
-		(rc, plist) = semanage_port_list_local(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not list the ports"))
-
-		rc = semanage_begin_transaction(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not start semanage transaction"))
-
-		for port in plist:
-                       proto = semanage_port_get_proto(port)
-                       proto_str = semanage_port_get_proto_str(proto)
-                       low = semanage_port_get_low(port)
-                       high = semanage_port_get_high(port)
-                       port_str = "%s-%s" % (low, high)
-                       ( k, proto_d, low, high ) = self.__genkey(port_str , proto_str)
-                       if rc < 0:
-                              raise ValueError(_("Could not create a key for %s") % port_str)
-
-                       rc = semanage_port_del_local(self.sh, k)
-                       if rc < 0:
-                              raise ValueError(_("Could not delete the port %s") % port_str)
-                       semanage_port_key_free(k)
-	
-		rc = semanage_commit(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not delete the %s") % port_str)
-
 	def delete(self, port, proto):
 		( k, proto_d, low, high ) = self.__genkey(port, proto)
 		(rc,exists) = semanage_port_exists(self.sh, k)
@@ -1206,32 +1175,6 @@
 		semanage_fcontext_key_free(k)
 		semanage_fcontext_free(fcontext)
 
-	def deleteall(self):
-		(rc, flist) = semanage_fcontext_list_local(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not list the file contexts"))
-
-		rc = semanage_begin_transaction(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not start semanage transaction"))
-
-		for fcontext in flist:
-                       target = semanage_fcontext_get_expr(fcontext)
-                       ftype = semanage_fcontext_get_type(fcontext)
-                       ftype_str = semanage_fcontext_get_type_str(ftype)
-                       (rc,k) = semanage_fcontext_key_create(self.sh, target, file_types[ftype_str])
-                       if rc < 0:
-                              raise ValueError(_("Could not create a key for %s") % target)
-
-                       rc = semanage_fcontext_del_local(self.sh, k)
-                       if rc < 0:
-                              raise ValueError(_("Could not delete the file context %s") % target)
-                       semanage_fcontext_key_free(k)
-	
-		rc = semanage_commit(self.sh)
-		if rc < 0:
-			raise ValueError(_("Could not delete the file context %s") % target)
-
 	def delete(self, target, ftype):
 		(rc,k) = semanage_fcontext_key_create(self.sh, target, file_types[ftype])
 		if rc < 0:

--------------060701070106000406030605
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iD8DBQBHCY0jrlYvE4MpobMRAmoPAKDNy3wgDd3Fm2KNst/jX3DSAC+eKQCZAYq/YzWZkms4
BRwWC2X9cwF76yA=
--------------060701070106000406030605--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
