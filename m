Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA16021
	for <selinux@tycho.nsa.gov>; Wed, 31 Jul 2002 15:28:26 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA00803
	for <selinux@tycho.nsa.gov>; Wed, 31 Jul 2002 19:27:35 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id TAA00797
	for <selinux@tycho.nsa.gov>; Wed, 31 Jul 2002 19:27:33 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 3909B92469
	for <selinux@tycho.nsa.gov>; Thu,  1 Aug 2002 05:28:11 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 4D94C2EF
	for <selinux@tycho.nsa.gov>; Wed, 31 Jul 2002 21:28:02 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: new Debian packages
Date: Wed, 31 Jul 2002 21:28:01 +0200
MIME-Version: 1.0
Message-Id: <20020731192802.4D94C2EF@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have put a new version of logcheck online, it has a minor logcheck package 
change (but nothing significant).

I have also put on a new version of my modified cron package online, it has a 
minor change to the checksecurity script (which needs a matching change to 
cron.fc) and a change to the postinst to allow it to start correctly.

http://www.coker.com.au/selinux/

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
