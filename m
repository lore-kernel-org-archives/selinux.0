Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA13678
	for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 12:07:04 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1JH73I27342
	for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 17:07:03 GMT
Received: from lappy.home.eternal-newbie.dk (213.237.70.59.adsl.vby.worldonline.dk [213.237.70.59])
        by jazzband.ncsc.mil  with ESMTP id h1JH72f27338 for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 17:07:02 GMT
Received: from localhost
	([127.0.0.1] helo=lappy.home.eternal-newbie.dk ident=ask)
	by lappy.home.eternal-newbie.dk with smtp (Exim 3.36 #1 (Debian))
	id 18lXfl-0006GB-00
	for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 18:06:17 +0100
Date: Wed, 19 Feb 2003 18:06:15 +0100
From: Ask Holme <ask@eternal-newbie.dk>
To: selinux@tycho.nsa.gov
Subject: passwd, sysadm_t access shadow_t:file
Message-Id: <20030219180615.23730649.ask@eternal-newbie.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hey

I just discovered that i can't use the passwd program an my debian --
the i get errors stating that the sysadm_t domain can't read/write/lock
the shadow file (shadow_t:file). However i fell that it's perfectly okay
that the sysadm can't do that, since only the passwd program should
could, a quick hack would be to edit the domain/programs/passwd.te file
and allow the sysadm_t domain access to the file however i would like to
just allow the passwd_t domain, but would i need a recode of passwd for
that ?

-- 
Regards

Ask Holme aka kVanQue
Half-time student - Fulltime geek
PGP/GPG keyid 58CE6FE4 - fetch it today, from your local keyserver

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
