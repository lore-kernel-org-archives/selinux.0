Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA23974
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 10:36:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA26268
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 14:35:53 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA26264
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 14:35:51 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 836CA92462
	for <selinux@tycho.nsa.gov>; Sat, 13 Jul 2002 00:36:26 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 5BF33CAD
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 16:36:18 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: chattr
Date: Fri, 12 Jul 2002 16:36:18 +0200
MIME-Version: 1.0
Message-Id: <20020712143618.5BF33CAD@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It seems that chattr depends on the "write" permission and that lsattr 
depends on the "read" permission.  I think that they should depend on 
"setattr" and "getattr" permissions respectively.

jmorris@blackbird.intercode.com.au pointed out that it is possible to chattr 
/tmp on my SE play machine, "chattr +i /tmp /var/tmp /var/tmp/*" would be 
rather annoying...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
