Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA21245
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 05:55:36 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id JAA04658
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 09:54:51 GMT
Received: from coffeesaur2.evoserve.com (evoworks.evoserve.com [210.16.10.5])
	by jazzswing.ncsc.mil  with ESMTP id JAA04654
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 09:54:49 GMT
Received: from evoworks.evoserve.com (evoworks.evoserve.com [210.16.10.5])
	by coffeesaur2.evoserve.com (Postfix) with ESMTP id 33DBF81456
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 17:55:31 +0800 (PHT)
Date: Tue, 23 Jul 2002 17:55:23 +0800 (PHT)
From: "Rogelio M. Serrano Jr." <rogelio@evoworks.evoserve.com>
To: selinux@tycho.nsa.gov
Subject: busybox policy and multicall binaries
Message-ID: <Pine.LNX.4.44.0207231743590.17801-100000@coffeesaur2.evoserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Whats the best way to handle multicall binaries like busybox? The basic
problem is that the context used in permission checking is the context of
the main binary instead of the links. The policy I have right now is a
little too permissive. I tried using wrappers for security relevant
applets but i find it too heavy in an embedded system. The average size of
the wrappers is 3k. I also tried hard links which looks promising but I
am not familiar with the issues related to links to executables. I am
considering modifying busybox to make it more of a shared library, so i
can create skeleton programs that get its functionality from the library.
That way I can assign permissions to the skeleton programs in a way thats
external to busybox.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9PSgSytnOHirK9T8RAmUNAJ47+JDrT9d4lJ2h9IKBHitTB8klhQCfVOOy
bBa1jxpAnfLISyaDGRVb/Os=
=cBbS
-----END PGP SIGNATURE-----



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
