Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA13266
	for <selinux@tycho.nsa.gov>; Sun, 24 Mar 2002 15:02:01 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA24531
	for <selinux@tycho.nsa.gov>; Sun, 24 Mar 2002 20:00:57 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id UAA24527 for <selinux@tycho.nsa.gov>; Sun, 24 Mar 2002 20:00:55 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 224B5924C4
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 07:01:56 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id B0AB4F749
	for <selinux@tycho.nsa.gov>; Sun, 24 Mar 2002 21:01:46 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: /dev/null and /dev/zero
Date: Sun, 24 Mar 2002 20:03:58 +0100
MIME-Version: 1.0
Message-Id: <20020324200146.B0AB4F749@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In what situations would you want to deny access to /dev/null and /dev/zero?  

It would make more sense to me to grant global access to these devices via:
allow domain { zero_device_t null_device_t }:chr_file rw_file_perms;

The reason for allowing /dev/null globally is that some programs will 
deliberately open /dev/null so that programs they run will have file handles 
0, 1, and 2 open to avoid possible confusion (and the potential for data loss 
and/or security holes) in child processes.

As for /dev/zero, it is mmap'd by programs in some situations (dependant on 
program input in some cases, seems harmless, and could potentially be 
excluded from programs that need it.

Also this would simplify policy, which I think is always a good thing.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
