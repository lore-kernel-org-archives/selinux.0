Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6VBwErT002562
	for <selinux@tycho.nsa.gov>; Sat, 31 Jul 2004 07:58:14 -0400 (EDT)
Received: from smtp808.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6VBvgHs003095
	for <selinux@tycho.nsa.gov>; Sat, 31 Jul 2004 11:57:42 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp808.mail.ukl.yahoo.com with SMTP; 31 Jul 2004 11:58:13 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1Bqs1L-0001Oi-9y
	for selinux@tycho.nsa.gov; Sat, 31 Jul 2004 11:27:23 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1Bqsfv-00026K-3k
	for selinux@tycho.nsa.gov; Sat, 31 Jul 2004 13:09:19 +0100
Date: Sat, 31 Jul 2004 13:09:19 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: install on new machine fails due to no ln -s on default to current
Message-ID: <20040731120919.GM3378@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

an installation of selinux-policy-default failed because there was
no symlink from default to current.

as this is a "first-time" install, i would expect the symlink to
have been created.

l.

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility if acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
