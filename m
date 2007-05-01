Message-ID: <463744AA.3020502@redhat.com>
Date: Tue, 01 May 2007 09:46:18 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: patch to allow modification of prefix via semanage
Content-Type: multipart/mixed;
 boundary="------------070708040208020203050105"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070708040208020203050105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------070708040208020203050105
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude --exclude=sepolgen-1.0.8 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/semanage policycoreutils-2.0.14/semanage/semanage
--- nsapolicycoreutils/semanage/semanage	2007-01-16 15:08:21.000000000 -0500
+++ policycoreutils-2.0.14/semanage/semanage	2007-05-01 09:31:57.000000000 -0400
@@ -279,7 +279,7 @@
 
 			if object == "user":
 				rlist = roles.split()
-				OBJECT.modify(target, rlist, selevel, serange)
+				OBJECT.modify(target, rlist, selevel, serange, prefix)
 
 			if object == "port":
 				OBJECT.modify(target, proto, serange, setype)

--------------070708040208020203050105--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
