Message-ID: <4564AD82.5080300@redhat.com>
Date: Wed, 22 Nov 2006 15:05:22 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: More  small fixes to policycoreutils
References: <6FE441CD9F0C0C479F2D88F959B015885C7D9F@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015885C7D9F@exchange.columbia.tresys.com>
Content-Type: multipart/mixed;
 boundary="------------010401030400090008020600"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010401030400090008020600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fixes to make sure module name is all alphabet charaters.

Fixes to generate Reference Policy modules correctly.



--------------010401030400090008020600
Content-Type: text/x-patch;
 name="audit2allow.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audit2allow.diff"

diff --exclude-from=exclude --exclude='*.po' --exclude='*.pot' -N -u -r nsapolicycoreutils/audit2allow/audit2allow policycoreutils-1.33.4/audit2allow/audit2allow
--- nsapolicycoreutils/audit2allow/audit2allow	2006-11-16 17:14:29.000000000 -0500
+++ policycoreutils-1.33.4/audit2allow/audit2allow	2006-11-22 14:51:29.000000000 -0500
@@ -25,6 +25,7 @@
 #
 #  
 from avc import *
+import re
 
 if __name__ == '__main__':
 	import commands, sys, os, getopt, selinux
@@ -59,6 +60,11 @@
 			print msg
 		sys.exit(1)
 		
+	def verify_module(module):
+		m = re.findall("[^a-zA-Z]", module)
+		if len(m) != 0:
+			usage(_("Alphabetic Charaters Only"))
+		
 	def errorExit(error):
 		sys.stderr.write("%s: " % sys.argv[0])
 		sys.stderr.write("%s\n" % error)
@@ -125,10 +131,12 @@
 				if module != "" or a[0] == "-":
 					usage()
 				module = a
+				verify_module(module)
 			if o == "-M":
 				if module != "" or output_ind  or a[0] == "-":
 					usage()
 				module = a
+				verify_module(module)
 				outfile = a+".te"
 				buildPP = 1
 				if not os.path.exists("/usr/bin/checkmodule"):
@@ -184,22 +192,26 @@
 		output.write(serules.out(requires, module))
 		output.flush()
 		if buildPP:
-			cmd = "checkmodule %s -m -o %s.mod %s.te" % (get_mls_flag(), module, module)
-			print _("Compiling policy")
-			print cmd
-			rc = commands.getstatusoutput(cmd)
-			if rc[0] == 0:
-				cmd = "semodule_package -o %s.pp -m %s.mod" % (module, module)
-				if fc_file != "":
-					cmd = "%s -f %s" % (cmd, fc_file)
-					
+			if ref_ind:
+				cmd = "make -f /usr/share/selinux/devel/Makefile %s.pp" % module
+				print _("Compiling policy")
+				print cmd
+				rc = commands.getstatusoutput(cmd)
+			else:
+				cmd = "checkmodule %s -m -o %s.mod %s.te" % (get_mls_flag(), module, module)
+				print _("Compiling policy")
 				print cmd
 				rc = commands.getstatusoutput(cmd)
 				if rc[0] == 0:
-					print _("\n******************** IMPORTANT ***********************\n")
-					print (_("In order to load this newly created policy package into the kernel,\nyou are required to execute \n\nsemodule -i %s.pp\n\n") % module)
-				else:
-					errorExit(rc[1])
+					cmd = "semodule_package -o %s.pp -m %s.mod" % (module, module)
+					if fc_file != "":
+						cmd = "%s -f %s" % (cmd, fc_file)
+					
+					print cmd
+					rc = commands.getstatusoutput(cmd)
+			if rc[0] == 0:
+				print _("\n******************** IMPORTANT ***********************\n")
+				print (_("In order to load this newly created policy package into the kernel,\nyou are required to execute \n\nsemodule -i %s.pp\n\n") % module)
 			else:
 				errorExit(rc[1])
 

--------------010401030400090008020600--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
