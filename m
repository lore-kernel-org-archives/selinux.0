Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA07746
	for <selinux@tycho.nsa.gov>; Mon, 6 May 2002 19:36:38 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id XAA26446
	for <selinux@tycho.nsa.gov>; Mon, 6 May 2002 23:35:24 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id XAA26442 for <selinux@tycho.nsa.gov>; Mon, 6 May 2002 23:35:23 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 2C11992452
	for <selinux@tycho.nsa.gov>; Tue,  7 May 2002 09:38:56 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 8198F312B
	for <selinux@tycho.nsa.gov>; Tue,  7 May 2002 09:35:51 +1000 (EST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: ppp
Date: Tue, 7 May 2002 08:23:07 +1000
MIME-Version: 1.0
Message-Id: <20020506233551.8198F312B@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It is common to install pppd in such a fashion that it can be run as 
"pppd call server" by a regular user.

The problem is that it often starts daemons from it's ip-up script once it 
connects, and such daemons aren't allowed to be in user_r!

I notice that the policy directive for doing an automatic role transition is 
now deprecated.

I am thinking of writing a pppd wrapper program which runs it as 
"system_u:system_r:pppd_t", what do you think?

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
