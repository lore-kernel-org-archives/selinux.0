Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA01437
	for <selinux@tycho.nsa.gov>; Sun, 26 May 2002 05:59:37 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id JAA19841
	for <selinux@tycho.nsa.gov>; Sun, 26 May 2002 09:59:33 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id JAA19837
	for <selinux@tycho.nsa.gov>; Sun, 26 May 2002 09:59:31 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 01ABD92452
	for <selinux@tycho.nsa.gov>; Sun, 26 May 2002 19:59:33 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 5C1852657
	for <selinux@tycho.nsa.gov>; Sun, 26 May 2002 11:59:25 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: can_tcp_connect_to() macro
Date: Sun, 26 May 2002 11:59:25 +0200
MIME-Version: 1.0
Message-Id: <20020526095926.5C1852657@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

What do you think about the following?

#################################
#
# can_tcp_connect_to(client, server)
#
# Permissions for establishing a TCP connection TO a domain.
#
define(`can_tcp_connect_to',`
allow $1 $2:tcp_socket connectto;
allow $2 $1:tcp_socket recvfrom;
')

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
