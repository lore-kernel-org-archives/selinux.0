Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i89IrdrT014033
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 14:53:39 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i89IrbVJ008138
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 18:53:38 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: cryptsetup
Date: Fri, 10 Sep 2004 04:53:34 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_uaKQBo3qU9MQH+J"
Message-Id: <200409100453.34904.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_uaKQBo3qU9MQH+J
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The location of cryptsetup in Fedora has changed, it seems that everyone is 
now putting it in /sbin.  The attached patch needs to be applied to lvm.fc.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_uaKQBo3qU9MQH+J
Content-Type: text/x-diff;
  charset="us-ascii";
  name="lvm.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lvm.diff"

--- /usr/src/se/policy/file_contexts/program/lvm.fc	2004-08-21 13:19:08.000000000 +1000
+++ file_contexts/program/lvm.fc	2004-09-10 04:52:28.000000000 +1000
@@ -54,12 +54,7 @@
 /sbin/vgscan.static	--	system_u:object_r:lvm_exec_t
 /sbin/vgsplit		--	system_u:object_r:lvm_exec_t
 /sbin/vgwrapper		--	system_u:object_r:lvm_exec_t
-ifdef(`distro_redhat', `
-/usr/bin/cryptsetup	--	system_u:object_r:lvm_exec_t
-')
-ifdef(`distro_debian', `
 /sbin/cryptsetup	--	system_u:object_r:lvm_exec_t
-')
 /sbin/dmsetup      --      system_u:object_r:lvm_exec_t
 /sbin/dmsetup.static --    system_u:object_r:lvm_exec_t
 /sbin/lvm          --      system_u:object_r:lvm_exec_t

--Boundary-00=_uaKQBo3qU9MQH+J--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
