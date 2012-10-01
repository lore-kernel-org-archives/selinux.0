Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q91GWubh017392
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2012 12:32:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 752441A095
	for <selinux@tycho.nsa.gov>; Mon,  1 Oct 2012 18:32:23 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 917v5EJe6zEM for <selinux@tycho.nsa.gov>;
	Mon,  1 Oct 2012 18:32:21 +0200 (CEST)
Received: from eldamar.bigon.be (d54C6D43E.access.telenet.be [84.198.212.62])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id CC97F1AAEC
	for <selinux@tycho.nsa.gov>; Mon,  1 Oct 2012 18:32:20 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 05/15] checkpolicy: Allow overriding LIBDIR in test/Makefile
Date: Mon,  1 Oct 2012 18:31:47 +0200
Message-Id: <1349109117-593-6-git-send-email-bigon@debian.org>
In-Reply-To: <1349109117-593-1-git-send-email-bigon@debian.org>
References: <1349109117-593-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

---
 checkpolicy/test/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/checkpolicy/test/Makefile b/checkpolicy/test/Makefile
index 0731e89..63b4d24 100644
--- a/checkpolicy/test/Makefile
+++ b/checkpolicy/test/Makefile
@@ -3,7 +3,7 @@
 #
 PREFIX ?= $(DESTDIR)/usr
 BINDIR=$(PREFIX)/bin
-LIBDIR=$(PREFIX)/lib
+LIBDIR ?= $(PREFIX)/lib
 INCLUDEDIR ?= $(PREFIX)/include
 
 CFLAGS ?= -g -Wall -W -Werror -O2 -pipe
-- 
1.7.10.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
