Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q91GWubg017392
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2012 12:32:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 8566C1AAD9
	for <selinux@tycho.nsa.gov>; Mon,  1 Oct 2012 18:32:15 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CHZ5sfNSbrqJ for <selinux@tycho.nsa.gov>;
	Mon,  1 Oct 2012 18:32:14 +0200 (CEST)
Received: from eldamar.bigon.be (d54C6D43E.access.telenet.be [84.198.212.62])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 61F7C1A095
	for <selinux@tycho.nsa.gov>; Mon,  1 Oct 2012 18:32:13 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 02/15] policycoreutils: Create correct man directory for run_init manpages
Date: Mon,  1 Oct 2012 18:31:44 +0200
Message-Id: <1349109117-593-3-git-send-email-bigon@debian.org>
In-Reply-To: <1349109117-593-1-git-send-email-bigon@debian.org>
References: <1349109117-593-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Russell Coker <russell@coker.com.au>

---
 policycoreutils/run_init/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/run_init/Makefile b/policycoreutils/run_init/Makefile
index 12b39b4..5815a08 100644
--- a/policycoreutils/run_init/Makefile
+++ b/policycoreutils/run_init/Makefile
@@ -33,7 +33,7 @@ open_init_pty: open_init_pty.c
 
 install: all
 	test -d $(SBINDIR)      || install -m 755 -d $(SBINDIR)
-	test -d $(MANDIR)/man1 || install -m 755 -d $(MANDIR)/man1
+	test -d $(MANDIR)/man8 || install -m 755 -d $(MANDIR)/man8
 	install -m 755 run_init $(SBINDIR)
 	install -m 755 open_init_pty $(SBINDIR)
 	install -m 644 run_init.8 $(MANDIR)/man8/
-- 
1.7.10.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
