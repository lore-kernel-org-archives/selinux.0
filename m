Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA05105
	for <selinux@tycho.nsa.gov>; Mon, 27 May 2002 17:10:26 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA11057
	for <selinux@tycho.nsa.gov>; Mon, 27 May 2002 21:10:21 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA11053
	for <selinux@tycho.nsa.gov>; Mon, 27 May 2002 21:10:19 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 90A1792460
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 07:10:17 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 4988625DF
	for <selinux@tycho.nsa.gov>; Mon, 27 May 2002 23:10:06 +0200 (CEST)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Fwd: kmail socket
Date: Mon, 27 May 2002 23:10:05 +0200
MIME-Version: 1.0
Message-Id: <20020527211006.4988625DF@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



----------  Forwarded Message  ----------

Subject: kmail socket
Date: Mon, 27 May 2002 22:43:59 +0200
From: Russell Coker <russell@coker.com.au>
To: Debian Kde <debian-kde@lists.debian.org>

When reading gpg signed email in kmail on SE Linux I am seeing messages such
as the following:
May 27 22:32:54 lyta kernel: avc:  denied  { read write } for  pid=26638
exe=/usr/bin/gpg path=socket:[519039] dev=00:00 ino=519039
scontext=rjc:user_r:user_gpg_t tcontext=rjc:user_r:user_t tclass=udp_socket

This indicates that gpg has inherited a file handle from kmail, here's the
lsof output:

root@lyta:/etc/selinux# lsof | grep 519039
kmail     21368   rjc   24u  sock        0,0              519039 can't
identify protocol

So, what might this be?  Where did this file handle get opened?

Naturally it should have been set to close on exec...


--
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
