Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA03555
	for <selinux@tycho.nsa.gov>; Sun, 18 Aug 2002 06:39:42 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id KAA10786
	for <selinux@tycho.nsa.gov>; Sun, 18 Aug 2002 10:38:05 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id KAA10782 for <selinux@tycho.nsa.gov>; Sun, 18 Aug 2002 10:38:02 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id F10A192466
	for <selinux@tycho.nsa.gov>; Sun, 18 Aug 2002 20:39:36 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 9B51260B
	for <selinux@tycho.nsa.gov>; Sun, 18 Aug 2002 12:39:27 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: user_crond_domain attribute
Date: Sun, 18 Aug 2002 12:39:27 +0200
MIME-Version: 1.0
Message-Id: <20020818103927.9B51260B@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In my tree I have just added a new attribute user_crond_domain to identify 
all user crond domains (default user_crond_t and sysadm_crond_t).

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
