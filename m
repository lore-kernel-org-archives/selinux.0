Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA05170
	for <selinux@tycho.nsa.gov>; Mon, 27 May 2002 17:31:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA11672
	for <selinux@tycho.nsa.gov>; Mon, 27 May 2002 21:31:36 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA11668
	for <selinux@tycho.nsa.gov>; Mon, 27 May 2002 21:31:35 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 7C37692460
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 07:31:38 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 5FA6B37AF
	for <selinux@tycho.nsa.gov>; Mon, 27 May 2002 23:31:31 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: tmp_domain()
Date: Mon, 27 May 2002 23:31:31 +0200
MIME-Version: 1.0
Message-Id: <20020527213131.5FA6B37AF@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here's a handy little macro I'm experimenting with for global_macros.te:

define(`tmp_domain',
`type $1_tmp_t, file_type, sysadmfile, tmpfile;
file_type_auto_trans($1_t, tmp_t, $1_tmp_t)
')


-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
