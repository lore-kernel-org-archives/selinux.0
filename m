Message-ID: <42C3010B.5040108@redhat.com>
Date: Wed, 29 Jun 2005 16:14:03 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <SELinux@tycho.nsa.gov>
Subject: policycoreutils-rhat.patch
Content-Type: multipart/mixed;
 boundary="------------070008020704070109010204"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070008020704070109010204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fix load_policy booleans warning to not say error.

Fix newrole to handle pam better.

Fix genhomedircon to work properly with Ivan's changes.

-- 



--------------070008020704070109010204
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/load_policy/load_policy.c policycoreutils-1.23.11/load_policy/load_policy.c
--- nsapolicycoreutils/load_policy/load_policy.c	2005-04-14 07:22:16.000000000 -0400
+++ policycoreutils-1.23.11/load_policy/load_policy.c	2005-05-28 01:25:28.000000000 -0400
@@ -103,7 +103,7 @@
 			if (errno == ENOENT || errno == EINVAL) {
 				/* No booleans file or stale booleans in the file; non-fatal. */
 				if (! quiet) 
-					fprintf(stderr, _("%s:  Warning!  Error while setting booleans from %s:  %s\n"), argv[0], boolpath, strerror(errno));
+					fprintf(stderr, _("%s:  Warning while setting booleans from %s\n"), argv[0], boolpath);
 			} else {
 				fprintf(stderr, _("%s:  Error while setting booleans from %s:  %s\n"), argv[0], boolpath, strerror(errno));
 				exit(2);
@@ -115,7 +115,7 @@
 		if (ret) {
 			/* Possibly ok, as there may be no booleans. */
 			if (! quiet) 
-				fprintf(stderr, _("%s:  Warning!  Error while getting boolean names:  %s\n"), argv[0], strerror(errno));
+				fprintf(stderr, _("%s:  Warning! unable to get boolean names:  %s\n"), argv[0], strerror(errno));
 			goto load;
 		}
 		if (!len)
@@ -137,7 +137,7 @@
 			if (errno == EINVAL) {
 				/* Stale booleans in the file; non-fatal. */
 				if (! quiet) 
-					fprintf(stderr, _("%s:  Warning!  Error while setting booleans:  %s\n"), argv[0], strerror(errno));
+					fprintf(stderr, _("%s:  Warning!  Unable to reset all booleans\n"), argv[0]);
 			} else {
 				fprintf(stderr, _("%s:  Error while setting booleans:  %s\n"), argv[0], strerror(errno));
 				exit(2);
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/newrole/newrole.c policycoreutils-1.23.11/newrole/newrole.c
--- nsapolicycoreutils/newrole/newrole.c	2005-05-20 13:15:12.000000000 -0400
+++ policycoreutils-1.23.11/newrole/newrole.c	2005-05-28 01:25:28.000000000 -0400
@@ -198,6 +198,11 @@
     result = 0;  /* user authenticated OK! */
   }
 
+  /* Ask PAM to verify acct_mgmt */
+  if( PAM_SUCCESS != pam_acct_mgmt(pam_handle,0) ) {
+    result = 0;  /* user authenticated OK! */
+  }
+
   /* We're done with PAM.  Free `pam_handle'. */
   pam_end( pam_handle, PAM_SUCCESS );
  
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/genhomedircon policycoreutils-1.23.11/scripts/genhomedircon
--- nsapolicycoreutils/scripts/genhomedircon	2005-04-14 07:22:16.000000000 -0400
+++ policycoreutils-1.23.11/scripts/genhomedircon	2005-06-14 13:01:12.000000000 -0400
@@ -357,16 +357,22 @@
 		return udict
 
 	def getHomeDirContext(self, user, home, role):
-		ret="\n\n#\n# Context for user %s\n#\n\n" % user
+		ret="\n\n#\n# Home Context for user %s\n#\n\n" % user
 		rc=commands.getstatusoutput("grep '^HOME_DIR' %s | sed -e 's|HOME_DIR|%s|' -e 's/ROLE/%s/' -e 's/system_u/%s/'" % (self.getHomeDirTemplate(), home, role, user))
 		return ret + rc[1] + "\n"
 
+	def getUserContext(self, user, sel_user, role):
+		ret="\n\n#\n# Other Context for user %s\n#\n\n" % user
+		rc=commands.getstatusoutput("grep 'USER' %s | sed -e 's/USER/%s/' -e 's/ROLE/%s/' -e 's/system_u/%s/'" % (self.getHomeDirTemplate(), user, role, sel_user))
+		return ret + rc[1] + "\n"
+
 	def genHomeDirContext(self):
 		users = self.getUsers()
 		ret=""
 		# Fill in HOME and ROLE for users that are defined
 		for u in users.keys():
 			ret += self.getHomeDirContext (u, users[u]["home"], users[u]["role"])
+			ret += self.getUserContext (u, u, users[u]["role"])
 		return ret+"\n"
 
 	def checkExists(self, home):
@@ -429,6 +435,7 @@
 		for h in self.getHomeDirs():
 			ret += self.getHomeDirContext ("user_u" , h+'/[^/]*', "user")
 			ret += self.getHomeRootContext(h)
+		ret += self.getUserContext(".*", "user_u", "user") + "\n"
 		ret += self.genHomeDirContext()
 		return ret
 

--------------070008020704070109010204--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
