Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8PDY2rT023537
	for <selinux@tycho.nsa.gov>; Sat, 25 Sep 2004 09:34:02 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8PDY0Ak020743
	for <selinux@tycho.nsa.gov>; Sat, 25 Sep 2004 13:34:00 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: dhclient from hotplug
Date: Sat, 25 Sep 2004 23:33:58 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GPXVB0SI6pQ/Qo0"
Message-Id: <200409252333.58602.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_GPXVB0SI6pQ/Qo0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is necessary for when dhclient is started from hotplug.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_GPXVB0SI6pQ/Qo0
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- /usr/src/se/policy/domains/program/unused/dhcpc.te	2004-09-11 16:21:44.000000000 +1000
+++ ./domains/program/unused/dhcpc.te	2004-09-22 00:47:50.000000000 +1000
@@ -48,7 +48,10 @@
 allow hotplug_t dhcpc_var_run_t:file { getattr read };
 allow hotplug_t dhcp_etc_t:file rw_file_perms;
 allow dhcpc_t hotplug_etc_t:dir { getattr search };
+ifdef(`distro_redhat', `
+domain_auto_trans(dhcpc_t, syslogd_exec_t, syslogd_t)
 ')
+')dnl end hotplug.te
 
 # for the dhcp client to run ping to check IP addresses
 ifdef(`ping.te', `

--Boundary-00=_GPXVB0SI6pQ/Qo0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
