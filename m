Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA23810
	for <selinux@tycho.nsa.gov>; Sat, 25 May 2002 03:55:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id HAA23365
	for <selinux@tycho.nsa.gov>; Sat, 25 May 2002 07:53:48 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id HAA23361 for <selinux@tycho.nsa.gov>; Sat, 25 May 2002 07:53:46 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 134A792452
	for <selinux@tycho.nsa.gov>; Sat, 25 May 2002 17:55:02 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id B76C715EB
	for <selinux@tycho.nsa.gov>; Sat, 25 May 2002 09:54:54 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: ACPI
Date: Sat, 25 May 2002 09:54:54 +0200
MIME-Version: 1.0
Message-Id: <20020525075454.B76C715EB@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Anyone tried out ACPI with SE Linux?  Does it have any requirements different 
from APM?

If not then perhaps the apm policy in the sample policy for apm should be 
renamed to "power"?

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
