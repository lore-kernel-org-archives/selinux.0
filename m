Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA16701
	for <selinux@tycho.nsa.gov>; Sun, 14 Apr 2002 14:53:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA26841
	for <selinux@tycho.nsa.gov>; Sun, 14 Apr 2002 18:52:24 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id SAA26835 for <selinux@tycho.nsa.gov>; Sun, 14 Apr 2002 18:52:22 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 5B6E192453
	for <selinux@tycho.nsa.gov>; Mon, 15 Apr 2002 04:53:20 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 6F3FD22A7A
	for <selinux@tycho.nsa.gov>; Sun, 14 Apr 2002 20:53:05 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: setfiles verbosity
Date: Sun, 14 Apr 2002 20:53:04 +0200
MIME-Version: 1.0
Message-Id: <20020414185305.6F3FD22A7A@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When running setfiles with the -v option I get messages such as the following:

setfiles:  relabeling /etc/ld.so.cache from rjc:object_r:ld_so_cache_t to 
system_u:object_r:ld_so_cache_t

I suggest that we change setfiles to have two levels of verbosity, one of 
which doesn't give messages such as the above.

What do you think?

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
