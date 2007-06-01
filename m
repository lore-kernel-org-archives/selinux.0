Message-ID: <46602E03.8080200@redhat.com>
Date: Fri, 01 Jun 2007 10:32:35 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: policycoreutils patch
Content-Type: multipart/mixed;
 boundary="------------010107040206070000010301"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010107040206070000010301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

policycoreutils should be checking if the user is the default_type not 
hard coded to user_u.

Also if selinux is not enabled, the verification step should not 
happen.  This is causing problems in chroot environments for the install.

Both these fixes should go into the new genhomedircon that is being 
added to semanage.

--------------010107040206070000010301
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude --exclude=sepolgen-1.0.8 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/scripts/genhomedircon policycoreutils-2.0.19/scripts/genhomedircon
--- nsapolicycoreutils/scripts/genhomedircon	2007-05-18 09:58:33.000000000 -0400
+++ policycoreutils-2.0.19/scripts/genhomedircon	2007-06-01 10:29:32.000000000 -0400
@@ -193,7 +193,7 @@
 		return prefix
 		
 	def adduser(self, udict, user, seuser, prefix):
-		if seuser == "user_u" or user == "__default__" or user == "system_u":
+		if seuser == self.default_user or user == "__default__" or user == "system_u":
 			return
 		# !!! chooses first prefix in the list to use in the file context !!!
 		try:
@@ -263,7 +263,7 @@
 				i = i.replace("system_u", seuser)
 				# Validate if the generated context exists.  Some user types may not exist
 				scon = i.split()[-1]
-				if selinux.security_check_context(scon) == 0:
+				if selinux.is_selinux_enabled() < 1 or selinux.security_check_context(scon) == 0:
 					ret = ret+i
 		fd.close()
 		return ret

--------------010107040206070000010301--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
