Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id VAA17453
	for <selinux@tycho.nsa.gov>; Tue, 16 Jul 2002 21:07:27 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id BAA11119
	for <selinux@tycho.nsa.gov>; Wed, 17 Jul 2002 01:06:47 GMT
Received: from coffeesaur2.evoserve.com (evoworks.evoserve.com [210.16.10.5])
	by jazzswing.ncsc.mil  with ESMTP id BAA11115
	for <selinux@tycho.nsa.gov>; Wed, 17 Jul 2002 01:06:44 GMT
Received: from mail.laco-dnc.edu.ph (unknown [210.16.6.227])
	by coffeesaur2.evoserve.com (Postfix) with ESMTP id 4324D8142D
	for <selinux@tycho.nsa.gov>; Wed, 17 Jul 2002 09:07:13 +0800 (PHT)
Date: Wed, 17 Jul 2002 09:07:03 +0800 (PHT)
From: "Rogelio M. Serrano Jr." <rogelio@evoworks.evoserve.com>
To: selinux@tycho.nsa.gov
Subject: inetd and tcpd services
Message-ID: <Pine.LNX.4.44.0207170904280.559-100000@coffeesaur>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

im running imapd as an inetd service. in enforcing mode i cant access the
mail spool directory because tcpd_t does not have permissions to lock the
directory. should i create a new impadd_t or give tcpd_t permissions?


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9NMNA6r8UsQIvzXwRAqRmAJ9yI9dIbbNoSLv/CGTqa2+GZRJDIgCfSA/K
iEGEFyP98NvLWN9ojqXGC6s=
=wjOA
-----END PGP SIGNATURE-----



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
