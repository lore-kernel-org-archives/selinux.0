Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA00114
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 10:23:15 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA27130
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 15:22:12 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id PAA27124 for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 15:22:11 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 3FB0092443
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 02:23:11 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 1441765C
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 16:23:04 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: addition for xdm.te
Date: Thu, 21 Mar 2002 16:23:03 +0100
MIME-Version: 1.0
Message-Id: <20020321152304.1441765C@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

domain_auto_trans(initrc_t, xdm_exec_t, xdm_t)


-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
