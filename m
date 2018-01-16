From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Tue, 16 Jan 2018 21:23:27 +0100
Message-Id: <20180116202327.23253-15-marcus.folkesson@gmail.com>
In-Reply-To: <20180116202327.23253-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180116202327.23253-1-marcus.folkesson@gmail.com>
Subject: [PATCH v2 14/14] build: add prefix for includes in top
 Makefile
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 6da7f7b7..74d662d4 100644
--- a/Makefile
+++ b/Makefile
@@ -19,8 +19,8 @@ else
 endif
 
 ifneq ($(DESTDIR),)
-	CFLAGS += -I$(DESTDIR)/usr/include
-	LDFLAGS += -L$(DESTDIR)/usr/lib
+	CFLAGS += -I$(DESTDIR)$(PREFIX)/include
+	LDFLAGS += -L$(DESTDIR)$(PREFIX)/lib
 	export CFLAGS
 	export LDFLAGS
 endif
-- 
2.15.1
