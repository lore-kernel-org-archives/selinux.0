Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA21055
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 05:22:29 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id KAA12809
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 10:21:24 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id KAA12801 for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 10:21:23 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 33BB292444
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 21:22:24 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id A54A1232F
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 11:22:15 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux <selinux@tycho.nsa.gov>
Subject: general_file_read_access
Date: Wed, 20 Mar 2002 11:19:54 +0100
MIME-Version: 1.0
Message-Id: <20020320102215.A54A1232F@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Could this macro be split into a number of smaller macros?

I'd like to have a macro for reading the root directory, /usr, /usr/bin, 
/usr/sbin, /bin, and /sbin without allowing reading of any var_log_t files.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
