Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA12921
	for <selinux@tycho.nsa.gov>; Sun, 24 Mar 2002 11:15:16 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA18677
	for <selinux@tycho.nsa.gov>; Sun, 24 Mar 2002 16:14:12 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id QAA18673 for <selinux@tycho.nsa.gov>; Sun, 24 Mar 2002 16:14:11 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 7463C9248B
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 03:15:09 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 1BD6427D13
	for <selinux@tycho.nsa.gov>; Sun, 24 Mar 2002 17:14:13 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: bug in checkpolicy
Date: Sun, 24 Mar 2002 17:14:13 +0100
MIME-Version: 1.0
Message-Id: <20020324161458.1BD6427D13@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The warnings about assertions given by checkpolicy seem slightly inaccurate.  
I think that the following shows what's going wrong.

/usr/bin/checkpolicy -o policy policy.conf
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
''''''security:  6 users, 5 roles, 454 types
security:  29 classes, 50164 rules
assertion on line 90811 violated by allow ldconfig_exec_t shlib_t:dir { 
add_name remove_name };
make: *** [policy] Error 1
root@lyta:/etc/selinux# grep allow.ldconfig_exec policy.conf
root@lyta:/etc/selinux# grep allow.ldconfig_t.shlib policy.conf
allow ldconfig_t shlib_t:{ file lnk_file sock_file fifo_file } { create ioctl 
read getattr access lock poll write setattr append link unlink rename };
allow ldconfig_t shlib_t:dir { create read getattr access poll setattr link 
unlink rename search add_name remove_name reparent write rmdir };
root@lyta:/etc/selinux#

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
