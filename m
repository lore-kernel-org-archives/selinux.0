Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA01400
	for <selinux@tycho.nsa.gov>; Sun, 26 May 2002 05:47:16 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id JAA19547
	for <selinux@tycho.nsa.gov>; Sun, 26 May 2002 09:47:11 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id JAA19543
	for <selinux@tycho.nsa.gov>; Sun, 26 May 2002 09:47:10 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id E368492452
	for <selinux@tycho.nsa.gov>; Sun, 26 May 2002 19:47:11 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 3993625BF
	for <selinux@tycho.nsa.gov>; Sun, 26 May 2002 11:47:02 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: controlling policy at a high level
Date: Sun, 26 May 2002 11:47:01 +0200
MIME-Version: 1.0
Message-Id: <20020526094702.3993625BF@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When configuring SE Linux there are a number of decisions which need to be 
made in the balance of security vs usability.

Here are some examples:

Can a regular user do "ps ax" and see everyone's processes?

Can a rgular user stat terminal device files from other users (needed for 
"w")?

These are essentially arbitary decisions, and decisions that are likely to be 
changed reasonably often.

So I am thinking of having a special configuration file to define macros for 
such things maybe called policy/config_settings.

Then it would have something like:
dnl define(`config_allow_ps_ax')
dnl define(`config_allow_stat_tty')


Plus anything else of a similar nature.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
