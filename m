Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA07231
	for <selinux@tycho.nsa.gov>; Wed, 19 Jun 2002 07:37:52 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA20974
	for <selinux@tycho.nsa.gov>; Wed, 19 Jun 2002 11:36:29 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id LAA20970 for <selinux@tycho.nsa.gov>; Wed, 19 Jun 2002 11:36:27 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 96F2D92461
	for <selinux@tycho.nsa.gov>; Wed, 19 Jun 2002 21:37:48 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 9045569D
	for <selinux@tycho.nsa.gov>; Wed, 19 Jun 2002 13:37:40 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: new policy changes
Date: Wed, 19 Jun 2002 13:37:40 +0200
MIME-Version: 1.0
Message-Id: <20020619113740.9045569D@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

/dev/nvram (/dev/misc/nvram) needs a context, I've given it memory_device_t 
for the moment.

Some of the users on my play box discovered this and wrote some random data 
to it.  They expressed the option that it won't complete it's next boot (I'm 
now discussing the matter with the hardware vendor).

I've changed /dev/console to be writable only by the admin domains not by 
every_domain().

This means of course that if you login at the console you have to do so as an 
administrator, this is fair IMHO, there's no cause for regular users to login 
at the console.



When's the next version due?

Is any progress being made to get devfs to maintain it's contexts?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
