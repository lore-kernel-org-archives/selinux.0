Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA23999
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 07:03:22 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA04426
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 11:01:42 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id LAA04422
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 11:01:41 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 47C1392457
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 21:03:18 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 805362413
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 13:03:10 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: server ports
Date: Tue, 16 Apr 2002 13:03:10 +0200
MIME-Version: 1.0
Message-Id: <20020416110310.805362413@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Below is my changes to the port configuration.  You may already have some of 
this, I've send most of it a port at a time.

--- selinux-small-2002031409.orig/policy/types/network.te
+++ selinux-small-2002031409/policy/types/network.te
@@ -42,7 +42,11 @@
 type rlogin_port_t, port_type;
 type rsh_port_t, port_type;
 type printer_port_t, port_type;
+type ipp_port_t, port_type;
 type named_port_t,port_type;
+type radius_port_t, port_type;
+type radacct_port_t, port_type;
+type dict_port_t, port_type;

 #
 # netif_t is the default type of network interfaces.
--- selinux-small-2002031409.orig/policy/net_contexts
+++ selinux-small-2002031409/policy/net_contexts
@@ -18,8 +18,14 @@
 tcp 513 system_u:object_r:rlogin_port_t
 tcp 514 system_u:object_r:rsh_port_t
 tcp 515 system_u:object_r:printer_port_t
+tcp 631 system_u:object_r:ipp_port_t
 tcp 8080  system_u:object_r:http_cache_port_t
 udp 53 system_u:object_r:named_port_t
+udp 1645 system_u:object_r:radius_port_t
+udp 1646 system_u:object_r:radacct_port_t
+udp 1812 system_u:object_r:radius_port_t
+udp 1813 system_u:object_r:radacct_port_t
+tcp 2628 system_u:object_r:dict_port_t


 # Network interfaces (default = initial SID 'netif' and 'netmsg')

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
