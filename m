Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA03818
	for <selinux@tycho.nsa.gov>; Sun, 2 Jun 2002 18:23:03 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA27081
	for <selinux@tycho.nsa.gov>; Sun, 2 Jun 2002 22:22:53 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA27077
	for <selinux@tycho.nsa.gov>; Sun, 2 Jun 2002 22:22:51 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id AEE1F92461
	for <selinux@tycho.nsa.gov>; Mon,  3 Jun 2002 08:22:47 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 747AC4A0
	for <selinux@tycho.nsa.gov>; Mon,  3 Jun 2002 00:22:34 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: domain_auto_trans_read() macro
Date: Mon, 3 Jun 2002 00:22:34 +0200
MIME-Version: 1.0
Message-Id: <20020602222234.747AC4A0@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I suggest that we have a domain_auto_trans_read() macro which does the same 
as the domain_auto_trans() but adds the following rule:
allow $1 $2:file read;

I've written a line like that following a domain_auto_trans() about 100 times 
and I think that the macro is necessary to save needless typing...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
