Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA21053
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 05:22:29 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id KAA12807
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 10:21:24 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id KAA12800 for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 10:21:23 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 045C692443
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 21:22:23 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 9DEB4232E
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 11:22:15 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: uses_shlib
Date: Wed, 20 Mar 2002 11:04:19 +0100
MIME-Version: 1.0
Message-Id: <20020320102215.9DEB4232E@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The libc on my system uses a file named /etc/ld.so.preload.
I have added the following line to my file_contexts:
/etc/ld.so.preload              system_u:object_r:ld_so_t

Also I added the following to uses_shlib():
allow $1 ld_so_cache_t:file r_file_perms;


-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
