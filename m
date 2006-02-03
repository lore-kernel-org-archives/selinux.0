Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k13AAgXf029493
	for <selinux@tycho.nsa.gov>; Fri, 3 Feb 2006 05:10:42 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k13A9Fnm023068
	for <selinux@tycho.nsa.gov>; Fri, 3 Feb 2006 10:09:18 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 7BDD961B03
	for <selinux@tycho.nsa.gov>; Fri,  3 Feb 2006 21:10:25 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 15273-01 for <selinux@tycho.nsa.gov>;
	Fri, 3 Feb 2006 21:10:25 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id EB84A61AE3
	for <selinux@tycho.nsa.gov>; Fri,  3 Feb 2006 21:10:24 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux List <selinux@tycho.nsa.gov>, Tung U <tungu@redhat.com>
Subject: RHEL4 and module loading
Date: Fri, 3 Feb 2006 21:10:17 +1100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Pwy4DMuUcWzLH0x"
Message-Id: <200602032110.23156.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_Pwy4DMuUcWzLH0x
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch against the policy source for RHEL4 adds two new booleans, 
secure_mode_insmod and secure_mode_policyload.

secure_mode_insmod prevents loading kernel modules if it is set to the value 
1, the command "setsebool -P secure_mode_insmod 1" does this.

secure_mode_policyload prevents loading a new policy and changing the values 
of booleans (can't escape this without a reboot), the command 
"setsebool -P secure_mode_policyload 1" does this.

These booleans are a standard feature in recent versions of the policy, I just 
back-ported them to RHEL4.

Note that if you have secure_mode_insmod enabled then you need to have ALL 
modules that you will use configured in the initrd.  The command mkinitrd has 
the --with=module option for this, you may need 20 or more --with= options to 
get all the modules.

Some customers apparently want to compile their own kernels to prevent loading 
modules and other things.  A custom kernel can not be supported by GSS, but a 
standard Red Hat kernel with some custom SE Linux policy will get a degree of 
support (the amount of support is determined by the problem in question and 
the significance of the policy changes).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_Pwy4DMuUcWzLH0x
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru policy.orig/domains/unconfined.te policy/domains/unconfined.te
--- policy.orig/domains/unconfined.te	2005-11-10 02:28:52.000000000 +1100
+++ policy/domains/unconfined.te	2006-02-03 20:18:01.000000000 +1100
@@ -42,6 +42,13 @@
 allow unconfined_t unlabeled_t:filesystem *;
 allow unlabeled_t unlabeled_t:filesystem associate;
 
+# Disable loading modules
+bool secure_mode_insmod false;
+
+# Disable loading policy, putting the machine in permissive mode, or
+# setting booleans
+bool secure_mode_policyload false;
+
 # Support NFS home directories
 bool use_nfs_home_dirs false;
 
diff -ru policy.orig/macros/global_macros.te policy/macros/global_macros.te
--- policy.orig/macros/global_macros.te	2005-11-10 02:28:52.000000000 +1100
+++ policy/macros/global_macros.te	2006-02-03 20:15:57.000000000 +1100
@@ -594,14 +594,22 @@
 allow $1 domain:msg  { send receive };
 
 # Access the security API.
+if (secure_mode_policyload) {
+allow $1 security_t:security ~{ load_policy setenforce setbool };
+} else {
 allow $1 security_t:security *;
+}
 auditallow $1 security_t:security { load_policy setenforce setbool };
 
 # Perform certain system operations that lacked individual capabilities.
 allow $1 kernel_t:system *;
 
 # Use any Linux capability.
+if (secure_mode_insmod) {
+allow $1 self:capability ~sys_module;
+} else {
 allow $1 self:capability *;
+}
 
 # Set user information and skip authentication.
 allow $1 self:passwd *;

--Boundary-00=_Pwy4DMuUcWzLH0x--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
