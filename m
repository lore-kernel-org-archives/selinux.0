Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA02177
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 14:10:27 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA09339
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 19:09:25 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id TAA09329 for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 19:09:23 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id BE3B392449
	for <selinux@tycho.nsa.gov>; Thu,  7 Mar 2002 06:10:16 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id AB1B41F08D
	for <selinux@tycho.nsa.gov>; Wed,  6 Mar 2002 20:10:08 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: invalid contaxt
Date: Wed, 6 Mar 2002 19:20:51 +0100
MIME-Version: 1.0
Message-Id: <20020306191008.AB1B41F08D@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am running SE Linux in debugging mode as I have not yet got the policies 
working properly.

When I load a new policy I get the following message in syslog:
Mar  6 19:18:05 lyta kernel: security:  context 
system_u:system_r:sysadm_ssh_t is invalid

Here is how I try and find the cause of the message:
root@lyta:/etc/flask# list_sids |grep sysadm_ssh_t
SID 256 -> Scontext  system_u:system_r:sysadm_ssh_t
root@lyta:/etc/flask# ps ax --secsid  | grep 256
13654    248 grep 256
root@lyta:/etc/flask#

So it seems that I have not process using SID 256!

What am I doing wrong?

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
