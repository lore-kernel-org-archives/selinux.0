Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA24370
	for <selinux@tycho.nsa.gov>; Thu, 2 May 2002 23:52:10 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id DAA21922
	for <selinux@tycho.nsa.gov>; Fri, 3 May 2002 03:50:19 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id DAA21918
	for <selinux@tycho.nsa.gov>; Fri, 3 May 2002 03:50:17 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 92D8392461
	for <selinux@tycho.nsa.gov>; Fri,  3 May 2002 13:51:37 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 08E4049
	for <selinux@tycho.nsa.gov>; Fri,  3 May 2002 13:09:05 +1000 (EST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: kmod.te
Date: Fri, 3 May 2002 13:09:04 +1000
MIME-Version: 1.0
Message-Id: <20020503030905.08E4049@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In the latest sample policy we have:
can_exec(kmod_t,modprobe_exec_t)
can_exec(kmod_t,insmod_exec_t)

I don't like that idea.  I have the following:
domain_auto_trans(kmod_t,insmod_exec_t,insmod_t)

My idea is that it's better to use domain_auto_trans to give access to the 
insmod_t domain than to give other domains extra privs (although kmod_t 
should be safe ;).

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
