Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA22379
	for <selinux@tycho.nsa.gov>; Thu, 15 Aug 2002 14:57:40 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA03237
	for <selinux@tycho.nsa.gov>; Thu, 15 Aug 2002 18:56:02 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id SAA03233 for <selinux@tycho.nsa.gov>; Thu, 15 Aug 2002 18:56:00 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 510B592466
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 04:57:36 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 0FBA019A9
	for <selinux@tycho.nsa.gov>; Thu, 15 Aug 2002 20:57:28 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: pump.te
Date: Thu, 15 Aug 2002 20:44:48 +0200
MIME-Version: 1.0
Message-Id: <20020815185728.0FBA019A9@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Do we need both pump.te and dhcpc.te?

It seems that dhcpc.te allows slightly more access than pump, not enough 
extra that you want to lock pump down and deny it that access, but enough to 
make it a super-set of pump.te.

Therefore we could just run pump in the dhcpc_t domain, which means that 
there's less .te files to manage.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
