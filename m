Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA12188
	for <selinux@tycho.nsa.gov>; Thu, 25 Jul 2002 19:07:35 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA20440
	for <selinux@tycho.nsa.gov>; Thu, 25 Jul 2002 23:06:48 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id XAA20436
	for <selinux@tycho.nsa.gov>; Thu, 25 Jul 2002 23:06:46 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 9320692467
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 09:07:19 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 8353312AF
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 01:07:15 +0200 (CEST)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: I know it's a bit off-topic but it should be interesting to you.
Date: Fri, 26 Jul 2002 01:07:15 +0200
MIME-Version: 1.0
Message-Id: <20020725230715.8353312AF@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here's an article on MIM attacks that can be used against current ssh setups, 
I've changed all my ssh configurations to use ssh2 only, next I think I'll 
remove one of RSA or DSA support entirely from client and server.

http://www.phrack.org/phrack/59/p59-0x0b.txt


Also note that you don't need to intercept traffic to the IP address to do a 
MIM attack, there's some DNS tricks you can use too...


Russell Coker

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
