Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA00574
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 20:21:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id AAA29937
	for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2002 00:20:23 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id AAA29933 for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2002 00:20:21 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 33B3592457
	for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2002 10:21:33 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id DB7432FF42
	for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2002 02:21:20 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: xserver_domain(xdm)
Date: Wed, 24 Apr 2002 02:21:20 +0200
MIME-Version: 1.0
Message-Id: <20020424002120.DB7432FF42@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently in my sample policy I have an "xdm" xserver domain which is entered 
when the xdm runs the X server.

The problem with this is that the X server needs to access resources from the 
X client programs and the client programs need to use X resources.  This 
means allowing access from the user_t to the xdm_server_t and from 
xdm_xserver_t for shared memory, which I don't like.

I am now thinking that to login to an X server as sysadm_t is probably a bad 
idea anyway, so maybe I should just have xdm run the X server as 
user_xserver_t.

What do you think?

Also is anyone looking into extra security hooks for X?  Is it at all 
possible to prevent keyboard snooping by any misbehaving X program?

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
