Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA16273
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 19:21:43 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id XAA02676
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 23:20:31 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id XAA02672 for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 23:20:29 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id DFC9492457
	for <selinux@tycho.nsa.gov>; Fri, 26 Apr 2002 09:22:04 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id C32464646
	for <selinux@tycho.nsa.gov>; Fri, 26 Apr 2002 01:21:29 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: crond_domain()
Date: Fri, 26 Apr 2002 01:21:29 +0200
MIME-Version: 1.0
Message-Id: <20020425232129.C32464646@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In the crond_domain() macro, shouldn't we have the following line?

file_type_auto_trans($1_crond_t, tmp_t, $1_tmp_t)

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
