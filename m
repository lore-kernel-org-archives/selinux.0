Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA16953
	for <selinux@tycho.nsa.gov>; Sun, 14 Apr 2002 16:43:37 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA29515
	for <selinux@tycho.nsa.gov>; Sun, 14 Apr 2002 20:42:28 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id UAA29511 for <selinux@tycho.nsa.gov>; Sun, 14 Apr 2002 20:42:26 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id EE94E92453
	for <selinux@tycho.nsa.gov>; Mon, 15 Apr 2002 06:43:31 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 0561A22A7A
	for <selinux@tycho.nsa.gov>; Sun, 14 Apr 2002 22:43:23 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: network policy problems
Date: Sun, 14 Apr 2002 22:43:22 +0200
MIME-Version: 1.0
Message-Id: <20020414204323.0561A22A7A@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm getting messages similar to this for a number of daemons.

It seems that the dhcp daemon has claimed the eth0 interface in some way, and 
a number of daemons think that they are receiving from it when (AFAIK) they 
aren't.

avc:  denied  { recvfrom } for  pid=1250 exe=/usr/sbin/radvd netif=eth0 
scontext=system_u:system_r:dhcpd_t tcontext=system_u:system_r:radvd_t 
tclass=packet_socket


Actually I'm a bit unclear on the more technical aspects of network policy, 
is there any published document describing it clearly and in detail?

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
