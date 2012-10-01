Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q91GWva2017398
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2012 12:33:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 294BE1AAEC
	for <selinux@tycho.nsa.gov>; Mon,  1 Oct 2012 18:32:34 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id frtmtNNPKIkh for <selinux@tycho.nsa.gov>;
	Mon,  1 Oct 2012 18:32:29 +0200 (CEST)
Received: from eldamar.bigon.be (d54C6D43E.access.telenet.be [84.198.212.62])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 453FB1AAEE
	for <selinux@tycho.nsa.gov>; Mon,  1 Oct 2012 18:32:28 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 08/15] libselinux: Allow overriding LIBBASE in src/Makefile
Date: Mon,  1 Oct 2012 18:31:50 +0200
Message-Id: <1349109117-593-9-git-send-email-bigon@debian.org>
In-Reply-To: <1349109117-593-1-git-send-email-bigon@debian.org>
References: <1349109117-593-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

---
 libselinux/src/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index ac019df..7fe4207 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -18,7 +18,7 @@ RUBYLIBVER ?= $(shell $(RUBY) -e 'print RUBY_VERSION.split(".")[0..1].join(".")'
 RUBYPLATFORM ?= $(shell $(RUBY) -e 'print RUBY_PLATFORM')
 RUBYINC ?= $(shell pkg-config --cflags ruby-$(RUBYLIBVER))
 RUBYINSTALL ?= $(LIBDIR)/ruby/site_ruby/$(RUBYLIBVER)/$(RUBYPLATFORM)
-LIBBASE=$(shell basename $(LIBDIR))
+LIBBASE ?= $(shell basename $(LIBDIR))
 
 LDFLAGS ?= -lpcre
 
-- 
1.7.10.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
