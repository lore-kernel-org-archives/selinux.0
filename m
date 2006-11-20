Message-ID: <4561E7B2.9030205@redhat.com>
Date: Mon, 20 Nov 2006 12:36:50 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: More  small fixes to policycoreutils
References: <6FE441CD9F0C0C479F2D88F959B015885C79BC@exchange.columbia.tresys.com> <455CE2F3.3070200@mentalrootkit.com> <455DA4E8.5050600@redhat.com> <4561E1A3.8070306@mentalrootkit.com>
In-Reply-To: <4561E1A3.8070306@mentalrootkit.com>
Content-Type: multipart/mixed;
 boundary="------------070108080609030305080605"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070108080609030305080605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

audit2allow was not generating reference policy correctly.  This patches 
fixes this and uses /usr/share/sleinux/devel/Makefile to create policy 
packages.


newrole has Amy Griffiths patch to make newrole return the status code 
of the shell it execs.


run_init needs to call pam_acct_mgmt, so that pam_tally will work correctly.

semanage does not have -v option, so man page should be fixed.

There is a bug in the translation code in seobject.py  Which ended up 
blowing up semanage, the strip command was being used in correctly.

Also after modifying translations the mcstrans needs to be signaled.

(I think it is time we break the mcstrans code out into a separate 
script, maybe executed by semanage, which would allow us to write 
tighter policy around this object and semanage.)


Lastly are you going to merge the translations? 

http://people.redhat.com/dwalsh/SELinux/pocicycoreutils-po.patch



--------------070108080609030305080605
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude --exclude='*.po' --exclude='*.pot' -N -u -r nsapolicycoreutils/audit2allow/audit2allow policycoreutils-1.33.1/audit2allow/audit2allow
--- nsapolicycoreutils/audit2allow/audit2allow	2006-11-16 17:14:29.000000000 -0500
+++ policycoreutils-1.33.1/audit2allow/audit2allow	2006-11-15 16:29:10.000000000 -0500
@@ -184,22 +184,26 @@
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
 
diff --exclude-from=exclude --exclude='*.po' --exclude='*.pot' -N -u -r nsapolicycoreutils/newrole/newrole.c policycoreutils-1.33.1/newrole/newrole.c
--- nsapolicycoreutils/newrole/newrole.c	2006-11-20 12:19:55.000000000 -0500
+++ policycoreutils-1.33.1/newrole/newrole.c	2006-11-17 11:55:39.000000000 -0500
@@ -1068,11 +1068,16 @@
 		 */
 		int rc;
 		int exit_code = 0;
+		int status;
 
 		do {
-			rc = wait(NULL);
+			rc = wait(&status);
 		} while (rc < 0 && errno == EINTR);
 
+		/* Preserve child exit status, unless there is another error. */
+		if (WIFEXITED(status))
+			exit_code = WEXITSTATUS(status);
+
 		if (restore_tty_label(fd, ttyn, tty_context, new_tty_context)) {
 			fprintf(stderr, _("Unable to restore tty label...\n"));
 			exit_code = -1;
diff --exclude-from=exclude --exclude='*.po' --exclude='*.pot' -N -u -r nsapolicycoreutils/run_init/run_init.c policycoreutils-1.33.1/run_init/run_init.c
--- nsapolicycoreutils/run_init/run_init.c	2006-11-16 17:14:27.000000000 -0500
+++ policycoreutils-1.33.1/run_init/run_init.c	2006-11-16 09:37:03.000000000 -0500
@@ -132,6 +132,14 @@
 		result = 1;	/* user authenticated OK! */
 	}
 
+	/* If we were successful, call pam_acct_mgmt() to reset the
+         * pam_tally failcount.
+         */
+	if (result && (PAM_SUCCESS != pam_acct_mgmt(pam_handle, 0)) ) {
+		fprintf(stderr, _("failed to get account information\n"));
+		exit(-1);
+	}	
+
 	/* We're done with PAM.  Free `pam_handle'. */
 	pam_end(pam_handle, PAM_SUCCESS);
 
diff --exclude-from=exclude --exclude='*.po' --exclude='*.pot' -N -u -r nsapolicycoreutils/semanage/semanage.8 policycoreutils-1.33.1/semanage/semanage.8
--- nsapolicycoreutils/semanage/semanage.8	2006-11-20 12:19:55.000000000 -0500
+++ policycoreutils-1.33.1/semanage/semanage.8	2006-11-17 09:57:31.000000000 -0500
@@ -82,9 +82,6 @@
 .TP
 .I                \-T, \-\-trans
 SELinux Translation
-.TP
-.I                \-v, \-\-verbose    
-verbose output
 
 .SH EXAMPLE
 .nf
diff --exclude-from=exclude --exclude='*.po' --exclude='*.pot' -N -u -r nsapolicycoreutils/semanage/seobject.py policycoreutils-1.33.1/semanage/seobject.py
--- nsapolicycoreutils/semanage/seobject.py	2006-11-16 17:14:26.000000000 -0500
+++ policycoreutils-1.33.1/semanage/seobject.py	2006-11-15 18:20:53.000000000 -0500
@@ -94,23 +94,25 @@
 	return re.search("^" + reg +"$",raw)
 
 def translate(raw, prepend = 1):
-	if prepend == 1:
-		context = "a:b:c:%s" % raw
+        filler="a:b:c:"
+        if prepend == 1:
+		context = "%s%s" % (filler,raw)
 	else:
 		context = raw
-	(rc, trans) = selinux.selinux_raw_to_trans_context(context)
+ 	(rc, trans) = selinux.selinux_raw_to_trans_context(context)
 	if rc != 0:
 		return raw
 	if prepend:
-		trans = trans.strip("a:b:c")
+		trans = trans[len(filler):]
 	if trans == "":
 		return raw
 	else:
 		return trans
 	
 def untranslate(trans, prepend = 1):
+        filler="a:b:c:"
  	if prepend == 1:
-		context = "a:b:c:%s" % trans
+		context = "%s%s" % (filler,trans)
 	else:
 		context = trans
 
@@ -118,7 +120,7 @@
 	if rc != 0:
 		return trans
 	if prepend:
-		raw = raw.strip("a:b:c")	
+		raw = raw[len(filler):]
 	if raw == "":
 		return trans
 	else:
@@ -157,7 +159,7 @@
 	def out(self):
 		rec = ""
 		for c in self.comments:
-			rec += c +"\n"
+			rec += c
 		keys = self.ddict.keys()
 		keys.sort()
 		for k in keys:
@@ -204,7 +206,8 @@
 		os.write(fd, self.out())
 		os.close(fd)
 		os.rename(newfilename, self.filename)
-
+                os.system("/sbin/service mcstrans reload > /dev/null")
+                
 class semanageRecords:
 	def __init__(self):
 		self.sh = semanage_handle_create()

--------------070108080609030305080605--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
