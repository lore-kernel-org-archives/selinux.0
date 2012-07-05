Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q65In11P009573
	for <selinux@tycho.nsa.gov>; Thu, 5 Jul 2012 14:49:01 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 626E11A145
	for <selinux@tycho.nsa.gov>; Thu,  5 Jul 2012 20:48:58 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6GNJJzCod1hp for <selinux@tycho.nsa.gov>;
	Thu,  5 Jul 2012 20:48:56 +0200 (CEST)
Received: from fornost.bigon.be (unknown [213.211.144.61])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 5D3A21A142
	for <selinux@tycho.nsa.gov>; Thu,  5 Jul 2012 20:48:55 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/3] Patches from the Debian policycoreutils package
Date: Thu,  5 Jul 2012 20:48:50 +0200
Message-Id: <cover.1341513795.git.bigon@bigon.be>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Please find here the patches that Russell Coker has applied to the debian
policycoreutils Debian package.

Could you please merge them.

Cheers

Laurent Bigonville

Laurent Bigonville (1):
  Remove policycoreutils/run_init/open_init_pty.c

Russell Coker (2):
  Patch for mcstrans to not abort when it sees a squeeze config file
  Add new open_init_pty that doesn't waste CPU time

 policycoreutils/mcstrans/src/mcstrans.c    |    7 +
 policycoreutils/run_init/Makefile          |   11 +-
 policycoreutils/run_init/open_init_pty.c   |  399 --------------------------
 policycoreutils/run_init/open_init_pty.cpp |  423 ++++++++++++++++++++++++++++
 4 files changed, 436 insertions(+), 404 deletions(-)
 delete mode 100644 policycoreutils/run_init/open_init_pty.c
 create mode 100644 policycoreutils/run_init/open_init_pty.cpp

-- 
1.7.10


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
