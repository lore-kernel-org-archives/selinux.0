Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA15336
	for <selinux@tycho.nsa.gov>; Sat, 20 Apr 2002 06:01:39 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id JAA07663
	for <selinux@tycho.nsa.gov>; Sat, 20 Apr 2002 09:59:56 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id JAA07652
	for <selinux@tycho.nsa.gov>; Sat, 20 Apr 2002 09:59:54 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 981F992452
	for <selinux@tycho.nsa.gov>; Sat, 20 Apr 2002 20:01:34 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id B49DC19141
	for <selinux@tycho.nsa.gov>; Sat, 20 Apr 2002 12:01:26 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: nested {}
Date: Sat, 20 Apr 2002 12:01:26 +0200
MIME-Version: 1.0
Message-Id: <20020420100126.B49DC19141@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I would like to be able to do { file devfile_class_set } but such things 
currently don't work because checkpolicy doesn't like nested {}.

Could this be changed?

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
