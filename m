Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA22404
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 17:04:58 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA04574
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 21:03:39 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id VAA04570 for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 21:03:37 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 0DF8E92452
	for <selinux@tycho.nsa.gov>; Sat, 25 May 2002 07:04:46 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 2313E15EB
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 23:04:38 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: devfs mysterious relabelling
Date: Fri, 24 May 2002 23:04:37 +0200
MIME-Version: 1.0
Message-Id: <20020524210438.2313E15EB@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On my systems I have devfsd do most of the device node labelling.

I have noticed that often the system_u:object_r:fixed_disk_device_t labels 
(for /dev/ide/host0/bus0/target0/lun0/*) will get changed to 
system_u:object_r:devfs_t (the default context for devfs).

It doesn't happen to the device node for the entire file system 
/dev/ide/host0/bus0/target0/lun0/disc and the device node 
/dev/ide/host0/bus0/target0/lun0/part5 (an extended partition).

I believe that this is not a user-land issue, and it's something in the 
kernel (but I have not proven this yet).

Also it seems to happen more often when under load (setfiles on the root file 
system usually does the job).

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
