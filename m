Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA24861
	for <selinux@tycho.nsa.gov>; Sun, 28 Apr 2002 16:00:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA28272
	for <selinux@tycho.nsa.gov>; Sun, 28 Apr 2002 19:59:21 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id TAA28268 for <selinux@tycho.nsa.gov>; Sun, 28 Apr 2002 19:59:19 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 6296092460
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 06:01:30 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 717963850
	for <selinux@tycho.nsa.gov>; Sun, 28 Apr 2002 22:00:27 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: "use"
Date: Sun, 28 Apr 2002 22:00:27 +0200
MIME-Version: 1.0
Message-Id: <20020428200027.717963850@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

What's the deal with the following section of the global macros file?  Why 
are there three things aliased to use?  Is the plan to actually enforce a 
distinction in a future version?  Or did a past version support a distinction 
and is this a compatability thing?

#
# Permissions to use file descriptions created by another domain.
#
define(`use_fd_perms', `use')
define(`inherit_fd_perms', `use')
define(`receive_fd_perms', `use')

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
