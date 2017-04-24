Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3OI0Nbt026576
 for <selinux@tycho.nsa.gov>; Mon, 24 Apr 2017 14:00:41 -0400
Received: by mail-pg0-f67.google.com with SMTP id g2so6000780pge.2
 for <selinux@tycho.nsa.gov>; Mon, 24 Apr 2017 11:00:39 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 6/7] Add includes for DESTDIR only in root Makefile
Date: Tue, 25 Apr 2017 01:59:58 +0800
Message-Id: <20170424175959.20998-6-jason@perfinion.com>
In-Reply-To: <20170424175959.20998-1-jason@perfinion.com>
References: <20170424175959.20998-1-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Makefile b/Makefile
index 8df4ce3..7701e16 100644
--- a/Makefile
+++ b/Makefile
@@ -8,6 +8,13 @@ ifeq ($(DEBUG),1)
 	export LDFLAGS = -g
 endif
 
+ifneq ($(DESTDIR),)
+	CFLAGS += -I$(DESTDIR)/usr/include
+	LDFLAGS += -L$(DESTDIR)/usr/lib
+	export CFLAGS
+	export LDFLAGS
+endif
+
 all install relabel clean test indent:
 	@for subdir in $(SUBDIRS); do \
 		(cd $$subdir && $(MAKE) $@) || exit 1; \
-- 
2.10.2
