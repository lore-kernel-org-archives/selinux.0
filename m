Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA03026
	for <selinux@tycho.nsa.gov>; Sun, 14 Jul 2002 16:44:00 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA22675
	for <selinux@tycho.nsa.gov>; Sun, 14 Jul 2002 20:42:30 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id UAA22671 for <selinux@tycho.nsa.gov>; Sun, 14 Jul 2002 20:42:28 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id F3FAC92462
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 06:43:55 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 597BFF0A
	for <selinux@tycho.nsa.gov>; Sun, 14 Jul 2002 22:43:44 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: shellutils
Date: Sun, 14 Jul 2002 22:43:43 +0200
MIME-Version: 1.0
Message-Id: <20020714204344.597BFF0A@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've built a new Debian package of shellutils and put it on my web site.  
It's updated to sh-utils-2.0.12, and I changed the id program to not display 
the SID and context if you specify a different UID.

EG: if you type "id nobody" it should not say root:sysaadm_r:sysadm_r.

http://www.coker.com.au/selinux/shellutils/

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
