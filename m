Message-ID: <45A644DF.9050005@redhat.com>
Date: Thu, 11 Jan 2007 09:08:31 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Translation patch for seobject.py
Content-Type: multipart/mixed;
 boundary="------------040108080008040009000307"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040108080008040009000307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------040108080008040009000307
Content-Type: text/x-patch;
 name="policycoreuitls-seobject.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreuitls-seobject.patch"

diff --exclude-from=exclude --exclude POTFILES.in --exclude='*.po' --exclude='*.pot' -N -u -r nsapolicycoreutils/semanage/seobject.py policycoreutils-1.33.10/semanage/seobject.py
--- nsapolicycoreutils/semanage/seobject.py	2007-01-11 08:56:30.000000000 -0500
+++ policycoreutils-1.33.10/semanage/seobject.py	2007-01-09 11:56:46.000000000 -0500
@@ -23,13 +23,16 @@
 
 import pwd, string, selinux, tempfile, os, re, sys
 from semanage import *;
-import gettext
+PROGNAME="policycoreutils"
 
+import gettext
+gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
+gettext.textdomain(PROGNAME)
 try:
-       t = gettext.translation('policycoreutils', '/usr/share/locale')
-       _ = t.ugettext
-except:
-       pass
+       gettext.install(PROGNAME, localedir="/usr/share/locale", unicode=1)
+except IOError:
+       import __builtin__
+       __builtin__.__dict__['_'] = unicode
 
 is_mls_enabled = selinux.is_selinux_mls_enabled()
 
@@ -168,7 +171,7 @@
 	
 	def list(self,heading = 1):
 		if heading:
-			print "\n%-25s %s\n" % ("Level", "Translation")
+			print "\n%-25s %s\n" % (_("Level"), _("Translation"))
 		keys = self.ddict.keys()
 		keys.sort()
 		for k in keys:
@@ -288,10 +289,10 @@
 				raise ValueError(_("Could not add login mapping for %s") % name)
 
 		except ValueError, error:
-			mylog.log(0, "add SELinux user mapping", name, sename, "", serange);
+			mylog.log(0, _("add SELinux user mapping"), name, sename, "", serange);
 			raise error
 		
-		mylog.log(1, "add SELinux user mapping", name, sename, "", serange);
+		mylog.log(1, _("add SELinux user mapping"), name, sename, "", serange);
 		semanage_seuser_key_free(k)
 		semanage_seuser_free(u)
 
@@ -403,12 +404,12 @@
 		keys.sort()
 		if is_mls_enabled == 1:
 			if heading:
-				print "\n%-25s %-25s %-25s\n" % ("Login Name", "SELinux User", "MLS/MCS Range")
+				print "\n%-25s %-25s %-25s\n" % (_("Login Name"), _("SELinux User"), _("MLS/MCS Range"))
 			for k in keys:
 				print "%-25s %-25s %-25s" % (k, ddict[k][0], translate(ddict[k][1]))
 		else:
 			if heading:
-				print "\n%-25s %-25s\n" % ("Login Name", "SELinux User")
+				print "\n%-25s %-25s\n" % (_("Login Name"), _("SELinux User"))
 			for k in keys:
 				print "%-25s %-25s" % (k, ddict[k][0])
 
@@ -617,13 +621,13 @@
 		keys.sort()
 		if is_mls_enabled == 1:
 			if heading:
-				print "\n%-15s %-10s %-10s %-30s" % ("", "Labeling", "MLS/", "MLS/")
-				print "%-15s %-10s %-10s %-30s %s\n" % ("SELinux User", "Prefix", "MCS Level", "MCS Range", "SELinux Roles")
+				print "\n%-15s %-10s %-10s %-30s" % ("", _("Labeling"), _("MLS/"), _("MLS/"))
+				print "%-15s %-10s %-10s %-30s %s\n" % (_("SELinux User"), _("Prefix"), _("MCS Level"), _("MCS Range"), _("SELinux Roles"))
 			for k in keys:
 				print "%-15s %-10s %-10s %-30s %s" % (k, ddict[k][0], translate(ddict[k][1]), translate(ddict[k][2]), ddict[k][3])
 		else:
 			if heading:
-				print "%-15s %s\n" % ("SELinux User", "SELinux Roles")
+				print "%-15s %s\n" % (_("SELinux User"), _("SELinux Roles"))
 			for k in keys:
 				print "%-15s %s" % (k, ddict[k][3])
 
@@ -832,7 +836,7 @@
 
 	def list(self, heading = 1):
 		if heading:
-			print "%-30s %-8s %s\n" % ("SELinux Port Type", "Proto", "Port Number")
+			print "%-30s %-8s %s\n" % (_("SELinux Port Type"), _("Proto"), _("Port Number"))
 		ddict = self.get_all_by_type()
 		keys = ddict.keys()
 		keys.sort()
@@ -1002,7 +1006,7 @@
 			
 	def list(self, heading = 1):
 		if heading:
-			print "%-30s %s\n" % ("SELinux Interface", "Context")
+			print "%-30s %s\n" % (_("SELinux Interface"), _("Context"))
 		ddict = self.get_all()
 		keys = ddict.keys()
 		keys.sort()
@@ -1186,7 +1190,7 @@
 			
 	def list(self, heading = 1):
 		if heading:
-			print "%-50s %-18s %s\n" % ("SELinux fcontext", "type", "Context")
+			print "%-50s %-18s %s\n" % (_("SELinux fcontext"), _("type"), _("Context"))
 		fcon_list = self.get_all()
 		for fcon in fcon_list:
 			if len(fcon) > 3:
@@ -1284,7 +1288,7 @@
 			
 	def list(self, heading = 1):
 		if heading:
-			print "%-50s %-18s\n" % ("SELinux boolean", "value")
+			print "%-50s %-18s\n" % (_("SELinux boolean"), _("value"))
 		ddict = self.get_all()
 		keys = ddict.keys()
 		for k in keys:

--------------040108080008040009000307--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
