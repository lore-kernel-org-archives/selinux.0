Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBDNbnIi008376
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2004 18:37:51 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBDNbZX4018480
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2004 23:37:47 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id B405961AFD
	for <selinux@tycho.nsa.gov>; Tue, 14 Dec 2004 10:37:16 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 27424-08 for <selinux@tycho.nsa.gov>;
	Tue, 14 Dec 2004 10:37:16 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 329ED61AF6
	for <selinux@tycho.nsa.gov>; Tue, 14 Dec 2004 10:37:15 +1100 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 99DB5DC
	for <selinux@tycho.nsa.gov>; Tue, 14 Dec 2004 03:50:07 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: dhcpc.te patch
Date: Tue, 14 Dec 2004 03:50:05 +1100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+gcvBuwCtXsQpMM"
Message-Id: <200412140350.07001.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_+gcvBuwCtXsQpMM
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch removes some redundant dontaudit rules from dhcpc.te.

It seems that Dan fixed the bugs some months ago but we didn't get around to 
fixing the policy to match.

If other distributions don't have the patch then it's still appropriate to 
apply this patch so people can discover the problem and get Dan's patches 
applied.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_+gcvBuwCtXsQpMM
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- /usr/src/se/policy/domains/program/unused/dhcpc.te	2004-12-13 09:55:23.000000000 +1100
+++ domains/program/unused/dhcpc.te	2004-12-14 03:38:39.000000000 +1100
@@ -58,10 +58,6 @@
 # for the dhcp client to run ping to check IP addresses
 ifdef(`ping.te', `
 domain_auto_trans(dhcpc_t, ping_exec_t, ping_t)
-# because dhcpc is buggy and leaves file handles open...
-dontaudit ping_t dhcpc_state_t:file read;
-dontaudit ping_t dhcpc_t:packet_socket { read write };
-dontaudit ping_t dhcpc_t:udp_socket { read write };
 ifdef(`hotplug.te', `
 allow ping_t hotplug_t:fd use;
 ') dnl end if hotplug
@@ -109,11 +105,6 @@
 ')
 ifdef(`ifconfig.te', `
 domain_auto_trans(dhcpc_t, ifconfig_exec_t, ifconfig_t)
-# because dhclient is buggy and does not close file handles
-ifdef(`hide_broken_symptoms', `
-dontaudit ifconfig_t dhcpc_t:{ packet_socket udp_socket } { read write };
-dontaudit ifconfig_t dhcpc_state_t:file { read write };
-')dnl end broken symptoms
 ')dnl end if def ifconfig
 
 

--Boundary-00=_+gcvBuwCtXsQpMM--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
