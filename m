Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA00084
	for <selinux@tycho.nsa.gov>; Wed, 27 Mar 2002 17:47:27 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA25410
	for <selinux@tycho.nsa.gov>; Wed, 27 Mar 2002 22:46:22 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id WAA25406 for <selinux@tycho.nsa.gov>; Wed, 27 Mar 2002 22:46:19 GMT
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: SE support in tar 1.3.25?
Date: Wed, 27 Mar 2002 23:47:01 +0100
Cc: bdale@gag.com
MIME-Version: 1.0
Message-Id: <20020327224702.1317F420EE@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've just made a quick attempt at getting tar 1.3.25 working with SE support. 
The code has changed enough since the 1.3.19 version that the SE patch is 
against that not only do patches not apply in a working fashion, but I can't 
figure out what the code is actually doing.

If the NSA person who originally wrote the tar support could port it to the 
latest version of tar then that would be great.

Otherwise if someone else feels like giving it a go then that would be good 
too.

I've cc'd this message to Bdale, the Debian package maintainer for tar, I 
expect he could knock this up in 10 minutes if he's interested...

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
