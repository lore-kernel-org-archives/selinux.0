Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA08240
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 14:05:34 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA10911
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 19:04:30 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id TAA10904 for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 19:04:28 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 6D94392443
	for <selinux@tycho.nsa.gov>; Sat, 23 Mar 2002 06:05:29 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 21A218B1
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 20:05:22 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: new macro suggestion
Date: Fri, 22 Mar 2002 20:05:21 +0100
MIME-Version: 1.0
Message-Id: <20020322190522.21A218B1@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

define(`r_dir_file', `
allow $1 $2:dir r_dir_perms;
allow $1 $2:file r_file_perms;
')

define(`rw_dir_file', `
allow $1 $2:dir rw_dir_perms;
allow $1 $2:file rw_file_perms;
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
