Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA26444
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 04:35:24 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id JAA09552
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 09:33:31 GMT
Received: from nox.lemuria.org ([213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id JAA09548
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 09:33:30 GMT
Date: Wed, 30 Oct 2002 10:35:22 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: mysql policy
Message-ID: <20021030103522.A9801@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

What is the best-practice on labelling script files? Should they be
treated with more care than binaries?

I'm asking because I have largely tossed Russell's mysqld domain and
started a new one from scratch, not because Russell's was in any way
bad but because doing so allows me to better understand what is
happening and what permissions it needs.
This way I found out that the wrapper (safe_mysqld) that the init
script uses to start mysqld requires some more and other permissions
than the daemon itself, so I'm thinking about putting it into a
different domain so that the daemon, once running, doesn't have all
those unneeded priviledges.

safe_mysqld is a shell script. I can't see a problem with that from the
pure "hacking" perspective (modifying a shell script is not that much
easier than modifying a binary), but maybe its reliance on /bin/sh
makes it a different game?


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
