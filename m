Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA04694
	for <selinux@tycho.nsa.gov>; Sun, 18 Aug 2002 17:56:49 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA14947
	for <selinux@tycho.nsa.gov>; Sun, 18 Aug 2002 21:55:46 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA14943
	for <selinux@tycho.nsa.gov>; Sun, 18 Aug 2002 21:55:45 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id DBC5392466
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 07:56:45 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id B69868906
	for <selinux@tycho.nsa.gov>; Sun, 18 Aug 2002 23:56:37 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: type_change rules
Date: Sun, 18 Aug 2002 23:56:37 +0200
MIME-Version: 1.0
Message-Id: <20020818215637.B69868906@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In macros/user.te we have the following line:
type_change $1_t tty_device_t:chr_file $1_tty_device_t;

However the tty label seems to be that which matches the last usesr logged in 
(a security issue in itself).

However it also has the issue that when you create a new user role you must 
also create matching type_change rules to allow changes from all other user 
domains (IE the number of rules is proportional to the number of user domains 
squared).  Is there any reason for not doing the following?
type_change $1_t ttyfile:chr_file $1_tty_device_t;

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
