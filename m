Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rA2NE3ji005835
	for <selinux@tycho.nsa.gov>; Sat, 2 Nov 2013 19:14:05 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 691C01A1A5
	for <selinux@tycho.nsa.gov>; Sun,  3 Nov 2013 00:13:54 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
	by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id i4zAH_JhPJsh for <selinux@tycho.nsa.gov>;
	Sun,  3 Nov 2013 00:13:51 +0100 (CET)
Received: from fornost.bigon.be (unknown [IPv6:2a02:578:85fc:1:226:18ff:fe08:6073])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 3D7E31A00F
	for <selinux@tycho.nsa.gov>; Sun,  3 Nov 2013 00:13:51 +0100 (CET)
From: Laurent Bigonville <bigon@debian.org>
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH 1/2] Explicitly link libselinux against -lpthread
Date: Sun,  3 Nov 2013 00:13:49 +0100
Message-Id: <1383434030-5853-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

libselinux is using pthread functions internally without explicitly
linking against it.

If the executable is itself not linked against libpthread, this could
lead to some weird ld.so assertions, see:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=728529
---
 libselinux/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 02dd829..2a79b27 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -114,7 +114,7 @@ $(LIBA): $(OBJS)
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(CFLAGS) -shared -o $@ $^ -lpcre -ldl $(LDFLAGS) -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
+	$(CC) $(CFLAGS) -shared -o $@ $^ -lpcre -lpthread -ldl $(LDFLAGS) -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
 	ln -sf $@ $(TARGET) 
 
 $(LIBPC): $(LIBPC).in ../VERSION
-- 
1.8.4.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
