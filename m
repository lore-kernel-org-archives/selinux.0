Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8GBpwrT023931
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 07:51:58 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8GBox8m008189
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 11:51:01 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 4092A61AFE
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 21:51:54 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 08909-03 for <selinux@tycho.nsa.gov>;
	Thu, 16 Sep 2004 21:51:54 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id D02C361AFD
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 21:51:53 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 73C54B5A36
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 21:51:45 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: hald fix
Date: Thu, 16 Sep 2004 21:51:44 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Q5XSB1TBuBbOtjU"
Message-Id: <200409162151.44819.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_Q5XSB1TBuBbOtjU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch fixes a typo to make hald work with dbus and removes an 
unnecessary can_exec_any().

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_Q5XSB1TBuBbOtjU
Content-Type: text/x-diff;
  charset="us-ascii";
  name="hald.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hald.diff"

--- /usr/src/se/policy/domains/program/unused/hald.te	2004-09-16 18:06:49.000000000 +1000
+++ domains/program/unused/hald.te	2004-09-16 21:50:28.000000000 +1000
@@ -12,13 +12,13 @@
 #
 daemon_domain(hald, `, fs_domain, nscd_client_domain')
 
-can_exec_any(hald_t)
+can_exec(hald_t, hald_exec_t)
 
 allow hald_t { etc_t etc_runtime_t }:file { getattr read };
 allow hald_t self:unix_stream_socket create_stream_socket_perms;
 allow hald_t self:unix_dgram_socket create_socket_perms;
 
-ifdef(`dbus.te', `
+ifdef(`dbusd.te', `
 allow hald_t system_dbusd_t:dbus { acquire_svc };
 dbusd_client(system, hald_t)
 ')

--Boundary-00=_Q5XSB1TBuBbOtjU--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
