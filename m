Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA12663
	for <selinux@tycho.nsa.gov>; Wed, 14 Aug 2002 07:35:47 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA25781
	for <selinux@tycho.nsa.gov>; Wed, 14 Aug 2002 11:34:47 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id LAA25777
	for <selinux@tycho.nsa.gov>; Wed, 14 Aug 2002 11:34:45 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 8EA6D92466
	for <selinux@tycho.nsa.gov>; Wed, 14 Aug 2002 21:35:42 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 0DCBF18C
	for <selinux@tycho.nsa.gov>; Wed, 14 Aug 2002 13:35:34 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: logcheck
Date: Wed, 14 Aug 2002 13:35:33 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_970U60JHF8QAU08IPE9T"
Message-Id: <20020814113534.0DCBF18C@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_970U60JHF8QAU08IPE9T
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I have attached the /etc/logcheck/ignore.d.server/selinux and the 
/etc/logcheck/violations.ignore.d/selinux that I am using.

This makes SE Linux messages only appear in the violations section (I don't 
need to see them twice), skips the messages about unlabeled_t on a network 
socket (which appear to have stopped so I'll probably remove it from the next 
version), skips devfsd messages about nodes that are already labelled, and 
those messages about "denied null" that you get when running Apache.

These files will be automatically installed as part of my next Debian package.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--------------Boundary-00=_970U60JHF8QAU08IPE9T
Content-Type: text/plain;
  charset="us-ascii";
  name="ignore"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ignore"

IGRldmZzZC4qOiBOb2RlLiogYWxyZWFkeSBoYXMgYSBzZWN1cml0eSBjb250ZXh0CiBkZW5pZWQg
LiByYXdpcF9zZW5kLip1bmxhYmVsZWRfdAoga2VybmVsOiAkCiBrZXJuZWw6IGF2YzogIGRlbmll
ZAo=

--------------Boundary-00=_970U60JHF8QAU08IPE9T
Content-Type: text/plain;
  charset="us-ascii";
  name="violations.ignore"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="violations.ignore"

IGtlcm5lbDogYXZjOiAgZGVuaWVkICBudWxsIGZvciAgcGlkCg==

--------------Boundary-00=_970U60JHF8QAU08IPE9T--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
