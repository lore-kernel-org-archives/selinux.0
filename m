Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4ACk2P8015840
	for <selinux@tycho.nsa.gov>; Fri, 10 May 2013 08:46:03 -0400
From: Laurent Bigonville <bigon@debian.org>
To: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: [PATCH 04/16] checkpolicy: Allow overriding LIBDIR in test/Makefile
Date: Fri, 10 May 2013 14:45:12 +0200
Message-Id: <1368189924-8501-5-git-send-email-bigon@debian.org>
In-Reply-To: <1368189924-8501-1-git-send-email-bigon@debian.org>
References: <1368189924-8501-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

---
 checkpolicy/test/Makefile | 2 +-
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
1.8.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
