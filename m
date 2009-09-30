Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8UI7p6K015361
	for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2009 14:07:51 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8UI72j7004221
	for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2009 18:07:03 GMT
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8UI7nCq023108
	for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2009 14:07:49 -0400
Received: from localhost.localdomain (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8UI7mlC001053
	for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2009 14:07:48 -0400
Message-ID: <4AC39E75.9030907@redhat.com>
Date: Wed, 30 Sep 2009 14:07:49 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Remove setrans management from semanage
Content-Type: multipart/mixed;
 boundary="------------090402070203010208030707"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090402070203010208030707
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This will not work correctly using the current mcstrans code base.  I believe an admin has to edit this code directly and probably should have never been added to semanage.


--------------090402070203010208030707
Content-Type: text/plain;
 name="setrans.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="setrans.patch"

diff --git a/policycoreutils/semanage/semanage b/policycoreutils/semanage/semanage
index 2285489..ffaca5b 100644
--- a/policycoreutils/semanage/semanage
+++ b/policycoreutils/semanage/semanage
@@ -44,14 +44,13 @@ if __name__ == '__main__':
                text = _("""
 semanage [ -S store ] -i [ input_file | - ]
 
-semanage {boolean|login|user|port|interface|node|fcontext|translation} -{l|D} [-n]
+semanage {boolean|login|user|port|interface|node|fcontext} -{l|D} [-n]
 semanage login -{a|d|m} [-sr] login_name | %groupname
 semanage user -{a|d|m} [-LrRP] selinux_name
 semanage port -{a|d|m} [-tr] [ -p proto ] port | port_range
 semanage interface -{a|d|m} [-tr] interface_spec
 semanage node -{a|d|m} [-tr] [ -p protocol ] [-M netmask] addr
 semanage fcontext -{a|d|m} [-frst] file_spec
-semanage translation -{a|d|m} [-T] level
 semanage boolean -{d|m} [--on|--off|-1|-0] -F boolean | boolean_file
 semanage permissive -{d|a} type
 semanage dontaudit [ on | off ]
@@ -88,8 +87,6 @@ Object-specific Options (see above):
 	-P, --prefix     Prefix for home directory labeling
 	-L, --level      Default SELinux Level (MLS/MCS Systems only)
 	-R, --roles      SELinux Roles (ex: "sysadm_r staff_r")
-	-T, --trans      SELinux Level Translation (MLS/MCS Systems only)
-
 	-s, --seuser     SELinux User Name
 	-t, --type       SELinux Type for the object
 	-r, --range      MLS/MCS Security Range (MLS/MCS Systems only)
@@ -118,8 +115,6 @@ Object-specific Options (see above):
 		valid_option["fcontext"] = []
 		valid_option["fcontext"] += valid_everyone + [ '-f', '--ftype', '-s', '--seuser',  '-t', '--type', '-r', '--range'] 
 		valid_option["dontaudit"] = [ '-S', '--store' ]
-		valid_option["translation"] = []
-		valid_option["translation"] += valid_everyone + [ '-T', '--trans' ] 
 		valid_option["boolean"] = []
 		valid_option["boolean"] += valid_everyone + [ '--on', "--off", "-1", "-0", "-F", "--file"] 
 		valid_option["permissive"] = []
@@ -180,7 +175,6 @@ Object-specific Options (see above):
 		selevel = ""
 		setype = ""
 		ftype = ""
-		setrans = ""
 		roles = ""
 		seuser = ""
 		prefix = "user"
@@ -203,7 +197,7 @@ Object-specific Options (see above):
 		args = argv[1:]
 
 		gopts, cmds = getopt.getopt(args,
-					    '01adf:i:lhmnp:s:FCDR:L:r:t:T:P:S:M:',
+					    '01adf:i:lhmnp:s:FCDR:L:r:t:P:S:M:',
 					    ['add',
 					     'delete',
 					     'deleteall',
@@ -225,7 +219,6 @@ Object-specific Options (see above):
 					     'level=',
 					     'roles=',
 					     'type=',
-					     'trans=',
 					     'prefix=',
                                              'mask='
 					     ])
@@ -297,9 +290,6 @@ Object-specific Options (see above):
 			if o == "-t" or o == "--type":
 				setype = a
 
-			if o == "-T" or o == "--trans":
-				setrans = a
-
                         if o == "--on" or o == "-1":
                                value = "on"
                         if o == "--off" or o == "-0":
@@ -326,9 +316,6 @@ Object-specific Options (see above):
 		if object == "boolean":
 			OBJECT = seobject.booleanRecords(store)
 		
-		if object == "translation":
-			OBJECT = seobject.setransRecords()
-		
 		if object == "permissive":
 			OBJECT = seobject.permissiveRecords(store)
 		
@@ -358,9 +345,6 @@ Object-specific Options (see above):
 			if object == "login":
 				OBJECT.add(target, seuser, serange)
 
-			if object == "translation":
-				OBJECT.add(target, setrans)
-
 			if object == "user":
 				OBJECT.add(target, roles.split(), selevel, serange, prefix)
 
@@ -387,9 +371,6 @@ Object-specific Options (see above):
 			if object == "login":
 				OBJECT.modify(target, seuser, serange)
 
-			if object == "translation":
-				OBJECT.modify(target, setrans)
-
 			if object == "user":
 				rlist = roles.split()
 				OBJECT.modify(target, rlist, selevel, serange, prefix)
@@ -457,7 +438,6 @@ Object-specific Options (see above):
                                             'level=',
                                             'roles=',
                                             'type=',
-                                            'trans=',
                                             'prefix='
                                             ])
                for o, a in gopts:
diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index 3272a12..7c94da0 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -195,88 +195,6 @@ def untranslate(trans, prepend = 1):
 	else:
 		return raw
 	
-class setransRecords:
-	def __init__(self):
-		self.filename = selinux.selinux_translations_path()
-		try:
-			fd = open(self.filename, "r")
-			translations = fd.readlines()
-			fd.close()
-		except IOError, e:
-			raise ValueError(_("Unable to open %s: translations not supported on non-MLS machines: %s") % (self.filename, e) )
-			
-		self.ddict = {}
-		self.comments = []
-		for r in translations:
-			if len(r) == 0:
-				continue
-			i = r.strip()
-			if i == "" or i[0] == "#":
-				self.comments.append(r)
-				continue
-			i = i.split("=")
-			if len(i) != 2:
-				self.comments.append(r)
-				continue
-                        if self.ddict.has_key(i[0]) == 0:
-                               self.ddict[i[0]] = i[1]
-
-	def get_all(self):
-		return self.ddict
-
-	def out(self):
-		rec = ""
-		for c in self.comments:
-			rec += c
-		keys = self.ddict.keys()
-		keys.sort()
-		for k in keys:
-			rec += "%s=%s\n" %  (k, self.ddict[k])
-		return rec
-	
-	def list(self, heading = 1, locallist = 0):
-		if heading:
-			print "\n%-25s %s\n" % (_("Level"), _("Translation"))
-		keys = self.ddict.keys()
-		keys.sort()
-		for k in keys:
-			print "%-25s %s" % (k, self.ddict[k])
-		
-	def add(self, raw, trans):
-		if trans.find(" ") >= 0:
-			raise ValueError(_("Translations can not contain spaces '%s' ") % trans)
-
-		if validate_level(raw) == None:
-			raise ValueError(_("Invalid Level '%s' ") % raw)
-		
-		if self.ddict.has_key(raw):
-			raise ValueError(_("%s already defined in translations") % raw)
-		else:
-			self.ddict[raw] = trans
-		self.save()
-	
-	def modify(self, raw, trans):
-		if trans.find(" ") >= 0:
-
-			raise ValueError(_("Translations can not contain spaces '%s' ") % trans)
-		if self.ddict.has_key(raw):
-			self.ddict[raw] = trans
-		else:
-			raise ValueError(_("%s not defined in translations") % raw)
-		self.save()
-		
-	def delete(self, raw):
-		self.ddict.pop(raw)
-		self.save()
-
-	def save(self):
-		(fd, newfilename) = tempfile.mkstemp('', self.filename)
-		os.write(fd, self.out())
-		os.close(fd)
-		os.chmod(newfilename, os.stat(self.filename)[stat.ST_MODE])
-		os.rename(newfilename, self.filename)
-                os.system("/sbin/service mcstrans reload > /dev/null")
-
 class semanageRecords:
 	def __init__(self, store):
                global handle

--------------090402070203010208030707--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
