Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8UJlAmZ031717
	for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2009 15:47:10 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n8UJmgWi023934
	for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2009 19:48:42 GMT
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8UJl7mE022631
	for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2009 15:47:08 -0400
Received: from localhost.localdomain (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8UJl6YE009833
	for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2009 15:47:07 -0400
Message-ID: <4AC3B5BB.1090708@redhat.com>
Date: Wed, 30 Sep 2009 15:47:07 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: semanage Equal.patch
Content-Type: multipart/mixed;
 boundary="------------020604040600020008090409"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020604040600020008090409
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This is a patch that provides the fcontext equial to semanage.

--------------020604040600020008090409
Content-Type: text/plain;
 name="equal.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="equal.patch"

diff --git a/policycoreutils/semanage/semanage b/policycoreutils/semanage/semanage
index 128ab47..e974d33 100644
--- a/policycoreutils/semanage/semanage
+++ b/policycoreutils/semanage/semanage
@@ -84,6 +84,7 @@ Object-specific Options (see above):
 
         -F, --file       Treat target as an input file for command, change multiple settings
 	-p, --proto      Port protocol (tcp or udp) or internet protocol version of node (ipv4 or ipv6)
+        -e, --equal      Make target equal to this paths labeling
 	-M, --mask       Netmask
 	-P, --prefix     Prefix for home directory labeling
 	-L, --level      Default SELinux Level (MLS/MCS Systems only)
@@ -193,6 +194,7 @@ Object-specific Options (see above):
 		locallist = False
 		use_file = False
                 store = ""
+                equal=""
                 enable = False
                 disable = False
 			
@@ -208,6 +210,7 @@ Object-specific Options (see above):
 					    ['add',
 					     'delete',
 					     'deleteall',
+					     'equal=',
 					     'ftype=',
 					     'file',
 					     'help',
@@ -248,6 +251,9 @@ Object-specific Options (see above):
                                        raise ValueError(_("%s bad option") % o)
 				deleteall = True
 
+			if o == "-e"  or o == "--equal":
+				equal = a
+
 			if o == "--enable":
                                 if disable:
                                        raise ValueError(_("You can't disable and enable at the same time"))
@@ -384,7 +390,11 @@ Object-specific Options (see above):
 				OBJECT.add(target, mask, proto, serange, setype)
 
 			if object == "fcontext":
-				OBJECT.add(target, setype, ftype, serange, seuser)
+                                if equal == "":
+                                       OBJECT.add(target, setype, ftype, serange, seuser)
+                                else:
+                                       OBJECT.add_equal(target, equal)
+
 			if object == "permissive":
 				OBJECT.add(target)
 
@@ -419,7 +429,10 @@ Object-specific Options (see above):
 				OBJECT.modify(target, mask, proto, serange, setype)
 
 			if object == "fcontext":
-				OBJECT.modify(target, setype, ftype, serange, seuser)
+                                if equal == "":
+                                       OBJECT.modify(target, setype, ftype, serange, seuser)
+                                else:
+                                       OBJECT.modify_equal(target, equal)
 
                         return
 
diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index 4d36660..d702f2f 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -1409,6 +1409,48 @@ class interfaceRecords(semanageRecords):
 class fcontextRecords(semanageRecords):
 	def __init__(self, store = ""):
 		semanageRecords.__init__(self, store)
+                self.equiv = {}
+                self.equal_ind = False
+                try:
+                       fd = open(selinux.selinux_file_context_subs_path(), "r")
+                       for i in fd.readlines():
+                              src, dst = i.split()
+                              self.equiv[src] = dst
+                       fd.close()
+                except IOError:
+                       pass
+
+        def commit(self):
+                if self.equal_ind:
+                       subs_file = selinux.selinux_file_context_subs_path()
+                       tmpfile = "%s.tmp" % subs_file
+                       fd = open(tmpfile, "w")
+                       for src in self.equiv.keys():
+                              fd.write("%s %s\n" % (src, self.equiv[src]))
+                       fd.close()
+                       try:
+                              os.chmod(tmpfile, os.stat(subs_file)[stat.ST_MODE])
+                       except:
+                              pass
+                       os.rename(tmpfile,subs_file)
+                       self.equal_ind = False
+		semanageRecords.commit(self)
+
+        def add_equal(self, src, dst):
+                self.begin()
+                if src in self.equiv.keys():
+                       raise ValueError(_("Equivalence class for %s already exists") % src)
+                self.equiv[src] = dst
+                self.equal_ind = True
+                self.commit()
+
+        def modify_equal(self, src, dst):
+                self.begin()
+                if src not in self.equiv.keys():
+                       raise ValueError(_("Equivalence class for %s does not exists") % src)
+                self.equiv[src] = dst
+                self.equal_ind = True
+                self.commit()
 
         def createcon(self, target, seuser = "system_u"):
                 (rc, con) = semanage_context_create(self.sh)
@@ -1575,9 +1617,16 @@ class fcontextRecords(semanageRecords):
                               raise ValueError(_("Could not delete the file context %s") % target)
                        semanage_fcontext_key_free(k)
 	
+                self.equiv = {}
+                self.equal_ind = True
                 self.commit()
 
 	def __delete(self, target, ftype):
+                if target in self.equiv.keys():
+                       self.equiv.pop(target)
+                       self.equal_ind = True
+                       return
+
 		(rc,k) = semanage_fcontext_key_create(self.sh, target, file_types[ftype])
 		if rc < 0:
 			raise ValueError(_("Could not create a key for %s") % target)
@@ -1633,11 +1682,12 @@ class fcontextRecords(semanageRecords):
 		return ddict
 			
 	def list(self, heading = 1, locallist = 0 ):
-		if heading:
-			print "%-50s %-18s %s\n" % (_("SELinux fcontext"), _("type"), _("Context"))
 		fcon_dict = self.get_all(locallist)
                 keys = fcon_dict.keys()
                 keys.sort()
+                if len(keys) > 0 and heading:
+			print "%-50s %-18s %s\n" % (_("SELinux fcontext"), _("type"), _("Context"))
+
 		for k in keys:
 			if fcon_dict[k]:
 				if is_mls_enabled:

--------------020604040600020008090409--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
