Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBNDx0Ii003573
	for <selinux@tycho.nsa.gov>; Thu, 23 Dec 2004 08:59:00 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBNDvCiX002410
	for <selinux@tycho.nsa.gov>; Thu, 23 Dec 2004 13:57:13 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: cpuspeed and powernow
Date: Fri, 24 Dec 2004 00:58:53 +1100
Cc: Thomas Bleher <ThomasBleher@gmx.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_g8syBVhG22X54Et"
Message-Id: <200412240058.56587.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_g8syBVhG22X54Et
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I don't believe that we need separate policies for cpuspeed and powernow.  
They both perform the same function but for different CPUs so there is no 
possibility of them both running at the same time (AFAIK) and therefore no 
benefit in having separate domains.

I have attached a patch that adds the appropriate functionality to cpuspeed.te 
and cpuspeed.fc.  James please add this patch and remove powernowd.te and 
powernowd.fc.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_g8syBVhG22X54Et
Content-Type: text/x-diff;
  charset="us-ascii";
  name="cpuspeed.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cpuspeed.diff"

--- /usr/src/se/policy/domains/program/unused/cpuspeed.te	2004-11-13 03:56:01.000000000 +1100
+++ domains/program/unused/cpuspeed.te	2004-12-23 19:57:33.000000000 +1100
@@ -1,12 +1,17 @@
-#DESC cpuspeed - domain for microcode_ctl and other programs to speed CPU
+#DESC cpuspeed - domain for microcode_ctl, powernowd, etc
 #
-# Author:  Russell Coker <russell@coker.com.au>
+# Authors:  Russell Coker <russell@coker.com.au>
+#           Thomas Bleher <ThomasBleher@gmx.de>
 #
 
 daemon_base_domain(cpuspeed)
+read_locale(cpuspeed_t)
+
 allow cpuspeed_t sysfs_t:dir search;
 allow cpuspeed_t sysfs_t:file rw_file_perms;
 allow cpuspeed_t proc_t:dir r_dir_perms;
 allow cpuspeed_t proc_t:file { getattr read };
-allow cpuspeed_t etc_runtime_t:file { getattr read };
-allow cpuspeed_t etc_t:file { getattr read };
+allow cpuspeed_t { etc_t etc_runtime_t }:file { getattr read };
+
+allow cpuspeed_t self:process setsched;
+allow cpuspeed_t self:unix_dgram_socket create_socket_perms;
--- /usr/src/se/policy/file_contexts/program/cpuspeed.fc	2004-03-18 05:26:06.000000000 +1100
+++ file_contexts/program/cpuspeed.fc	2004-12-23 19:57:06.000000000 +1100
@@ -1,2 +1,3 @@
 # cpuspeed
 /usr/sbin/cpuspeed	--	system_u:object_r:cpuspeed_exec_t
+/usr/sbin/powernowd	--	system_u:object_r:cpuspeed_exec_t

--Boundary-00=_g8syBVhG22X54Et--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
