Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA09015
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 16:28:53 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA00225
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 21:27:30 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA00211
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 21:27:28 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 3E31392443
	for <selinux@tycho.nsa.gov>; Sat, 23 Mar 2002 08:28:48 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id CF3FE108F
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 22:28:40 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: strange failure
Date: Fri, 22 Mar 2002 22:28:40 +0100
MIME-Version: 1.0
Message-Id: <20020322212840.CF3FE108F@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have the following in my policy:
allow devfsd_t domain:dir_file_class_set getattr;

But I get the following logged:
Mar 22 22:26:22 test kernel: avc:  denied  { getattr } for  pid=394 
exe=/sbin/devfsd path=/vc/2 dev=00:07 ino=20 
scontext=system_u:system_r:devfsd_t 
tcontext=root:object_r:sysadm_tty_device_t tclass=chr_file

What am I missing?

I've tried this many times, read the macro expansion, reloaded the config and 
restarted the daemon etc.  I'm pretty sure that I haven't made the obvious 
mistakes of not saving the file or not loading the policy etc.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
