Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id BAA19456
	for <selinux@tycho.nsa.gov>; Thu, 9 May 2002 01:49:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id FAA17120
	for <selinux@tycho.nsa.gov>; Thu, 9 May 2002 05:47:44 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id FAA17110
	for <selinux@tycho.nsa.gov>; Thu, 9 May 2002 05:47:42 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id CB7E592462
	for <selinux@tycho.nsa.gov>; Thu,  9 May 2002 15:49:36 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 0704B6E05
	for <selinux@tycho.nsa.gov>; Thu,  9 May 2002 15:49:34 +1000 (EST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: setfiles -q option?
Date: Thu, 9 May 2002 14:53:49 +1000
MIME-Version: 1.0
Message-Id: <20020509054935.0704B6E05@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Could we have a "-q" option to setfiles to make it not write out messages 
such as the following?

/usr/sbin/setfiles:  Running on a SELinux kernel, using new system calls
/usr/sbin/setfiles:  read 450 specifications
/usr/sbin/setfiles:  Done.

Having it write out messages if it's not running on a SE Linux kernel would 
still be useful.  But when you install 100 new packages having the above 
three lines displayed 100 times is rather annoying...

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
