Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA24895
	for <selinux@tycho.nsa.gov>; Sun, 25 Aug 2002 09:05:46 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA09996
	for <selinux@tycho.nsa.gov>; Sun, 25 Aug 2002 13:04:38 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id NAA09992
	for <selinux@tycho.nsa.gov>; Sun, 25 Aug 2002 13:04:37 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id AB28D92466
	for <selinux@tycho.nsa.gov>; Sun, 25 Aug 2002 23:05:41 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 2DAC32B4
	for <selinux@tycho.nsa.gov>; Sun, 25 Aug 2002 15:05:31 +0200 (CEST)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: kernel patches from new release
Date: Sun, 25 Aug 2002 00:53:23 +0200
MIME-Version: 1.0
Message-Id: <20020825130531.2DAC32B4@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 24 Aug 2002 19:16, Russell Coker wrote:
> In the past we have been advised not to use the system calls for
> determining the SID of the process at the other end of a socket due to the
> code being incomplete.

I've just seen Howard's message, it seems that this is OK.


Russell Coker

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
