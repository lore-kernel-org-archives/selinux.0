Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9ICdgrT020371
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 08:39:42 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9ICdehM022906
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 12:39:41 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id A1F9061AFB
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 22:39:37 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 27527-02 for <selinux@tycho.nsa.gov>;
	Mon, 18 Oct 2004 22:39:37 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 4A81261AF7
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 22:39:37 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 7AC74B5ACE
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 22:39:35 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: nscd policy
Date: Mon, 18 Oct 2004 22:39:34 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Gm7cBh1KmJwxf3q"
Message-Id: <200410182239.34875.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_Gm7cBh1KmJwxf3q
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is needed for nss_ldap.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_Gm7cBh1KmJwxf3q
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- /usr/src/se/policy/domains/program/unused/nscd.te	2004-10-14 10:09:58.000000000 +1000
+++ domains/program/unused/nscd.te	2004-10-18 22:16:45.000000000 +1000
@@ -73,5 +73,4 @@
 r_dir_file(nscd_t, selinux_config_t)
 can_getsecurity(nscd_t)
 allow nscd_t self:netlink_selinux_socket create_socket_perms;
-
-
+allow nscd_t self:netlink_route_socket r_netlink_socket_perms;

--Boundary-00=_Gm7cBh1KmJwxf3q--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
