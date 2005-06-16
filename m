Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5GMb8gA005201
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 18:37:10 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5GMSPZm025714
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 22:28:27 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 86E9361AFA
	for <selinux@tycho.nsa.gov>; Fri, 17 Jun 2005 08:28:13 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 16643-02 for <selinux@tycho.nsa.gov>;
	Fri, 17 Jun 2005 08:28:13 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 1782361AEB
	for <selinux@tycho.nsa.gov>; Fri, 17 Jun 2005 08:28:13 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: mail_client_macros.te
Date: Fri, 17 Jun 2005 08:27:53 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_vzfsC6d/UAjT+Tb"
Message-Id: <200506170827.59180.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_vzfsC6d/UAjT+Tb
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is needed to compile a policy without innd.te.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_vzfsC6d/UAjT+Tb
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- macros/program/mail_client_macros.te.orig	2005-06-17 08:23:23.000000000 +1000
+++ macros/program/mail_client_macros.te	2005-06-17 08:24:19.000000000 +1000
@@ -25,8 +25,8 @@
 
 # Allow POP/IMAP/SMTP/NNTP/LDAP/IPP(printing)
 can_ypbind($1_t)
-can_network_client_tcp($1_t, { pop_port_t smtp_port_t innd_port_t ldap_port_t ipp_port_t })
-allow $1_t { pop_port_t smtp_port_t innd_port_t ldap_port_t ipp_port_t }:tcp_socket name_connect;
+can_network_client_tcp($1_t, { pop_port_t smtp_port_t ifdef(`innd.te', `innd_port_t') ldap_port_t ipp_port_t })
+allow $1_t { pop_port_t smtp_port_t ifdef(`innd.te', `innd_port_t') ldap_port_t ipp_port_t }:tcp_socket name_connect;
 
 # Allow printing the mail
 ifdef(`cups.te',`

--Boundary-00=_vzfsC6d/UAjT+Tb--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
