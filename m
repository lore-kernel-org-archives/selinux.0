Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA11418
	for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 14:08:51 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA08395
	for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 18:07:16 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id SAA08391 for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 18:07:15 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 11D2B9246C
	for <selinux@tycho.nsa.gov>; Tue,  6 Aug 2002 04:08:48 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 59C7C7E
	for <selinux@tycho.nsa.gov>; Mon,  5 Aug 2002 20:08:40 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: New Debian packages
Date: Mon, 5 Aug 2002 20:08:40 +0200
MIME-Version: 1.0
Message-Id: <20020805180840.59C7C7E@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have put a new version of my Debian packages online.  It's mostly just 
incremental improvements and bug-fixes for what I've done before, plus the 
start of my new chroot support that will be the topic of my paper for Linux 
Kongress.

Also I have setup an experimental apt repository for my SE modified packages, 
add the following to your /etc/apt/sources.list file and dselect will offer 
to upgrade the regular versions of login, cron, kdm, etc to my SE versions.

deb http://www.coker.com.au selinux/


-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
