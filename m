Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA10766
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 16:31:33 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA07764
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 20:30:29 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id UAA07754
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 20:30:28 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 0D3B59246F
	for <selinux@tycho.nsa.gov>; Tue, 20 Aug 2002 06:31:28 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 82719129F
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 22:31:19 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: tcp_socket messages
Date: Mon, 19 Aug 2002 22:31:16 +0200
MIME-Version: 1.0
Message-Id: <20020819203119.82719129F@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've started getting the following messages recently, I think it's from a 
kernel upgrade but as I've been changing my policy so much recently.

It doesn't seem to stop anything from working...

Aug 19 21:02:30 lyta kernel: avc: ?denied ?{ connectto } for ?pid=13505 
exe=/usr/bin/kdeinit saddr=127.0.0.1 source=8080 daddr=127.0.0.1 dest=34572 
netif=lo scontext=rjc:user_r:user_t tcontext=system_u:system_r:tcp_socket_t 
tclass=tcp_socket
Aug 19 21:02:30 lyta kernel: avc: ?denied ?{ connectto } for ?pid=13506 
exe=/usr/bin/kdeinit saddr=127.0.0.1 source=8080 daddr=127.0.0.1 dest=34573 
netif=lo scontext=rjc:user_r:user_t tcontext=system_u:system_r:tcp_socket_t 
tclass=tcp_socket
Aug 19 21:02:34 lyta kernel: avc: ?denied ?{ connectto } for ?pid=13505 
exe=/usr/bin/kdeinit saddr=127.0.0.1 source=8080 daddr=127.0.0.1 dest=34582 
netif=lo scontext=rjc:user_r:user_t tcontext=system_u:system_r:tcp_socket_t 
tclass=tcp_socket

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
