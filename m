Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA29424
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 07:46:03 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA01107
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 12:44:51 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id MAA01103
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 12:44:50 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 67E3D92445
	for <selinux@tycho.nsa.gov>; Wed,  6 Mar 2002 23:45:59 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 782B719F80
	for <selinux@tycho.nsa.gov>; Wed,  6 Mar 2002 13:45:50 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: automatic type transitions for pts in devfs
Date: Wed, 6 Mar 2002 13:45:50 +0100
MIME-Version: 1.0
Message-Id: <20020306124550.782B719F80@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It seems that the automatic type transitions for /dev/pts don't work on 
devfs.  When the sshd (in sshd_t domain) opens /dev/pts/1 it does not get 
changed to sshd_devpts_t domain.

When I put the following in my devfs_contexts file it all works as desired 
(so my only problem is the sshd_t causing a transition of the /dev/pts/1 
device node to sshd_devpts_t.
/pts                    system_u:object_r:sshd_devpts_t

I'm using the default sshd configuration.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
