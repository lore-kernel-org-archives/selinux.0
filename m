Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4ACk2P7015840
	for <selinux@tycho.nsa.gov>; Fri, 10 May 2013 08:46:03 -0400
From: Laurent Bigonville <bigon@debian.org>
To: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: [PATCH 02/16] policycoreutils: Create correct man directory for run_init manpages
Date: Fri, 10 May 2013 14:45:10 +0200
Message-Id: <1368189924-8501-3-git-send-email-bigon@debian.org>
In-Reply-To: <1368189924-8501-1-git-send-email-bigon@debian.org>
References: <1368189924-8501-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Russell Coker <russell@coker.com.au>

---
 policycoreutils/run_init/Makefile | 2 +-
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
1.8.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
