Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA25005
	for <selinux@tycho.nsa.gov>; Sat, 25 May 2002 15:56:53 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA11450
	for <selinux@tycho.nsa.gov>; Sat, 25 May 2002 19:55:34 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id TAA11446 for <selinux@tycho.nsa.gov>; Sat, 25 May 2002 19:55:33 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 7888992452
	for <selinux@tycho.nsa.gov>; Sun, 26 May 2002 05:56:47 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 734D015EB
	for <selinux@tycho.nsa.gov>; Sat, 25 May 2002 21:56:38 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: new Debian package
Date: Sat, 25 May 2002 21:56:37 +0200
MIME-Version: 1.0
Message-Id: <20020525195638.734D015EB@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've just uploaded a new Debian package, this one has the latest patches and 
new policy that works a lot better.  I now have a Debian machine running in 
enforcing mode with a policy that is not much different from the default in 
my package.  It's running as an ADSL gateway machine (pppoatm with SpeedTouch 
USB driver), a web server, and has the courier POP server running.

As the basic stuff is working it won't be too difficult for you to add 
support for other daemons etc.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
