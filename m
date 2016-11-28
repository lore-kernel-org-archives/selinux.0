Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uASLf6X9026162
 for <selinux@tycho.nsa.gov>; Mon, 28 Nov 2016 16:41:08 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 052445605F6
 for <selinux@tycho.nsa.gov>; Mon, 28 Nov 2016 22:40:55 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/4] libsepol/tests: use LDFLAGS when linking
Date: Mon, 28 Nov 2016 22:40:16 +0100
Message-Id: <20161128214018.7861-2-nicolas.iooss@m4x.org>
In-Reply-To: <20161128214018.7861-1-nicolas.iooss@m4x.org>
References: <20161128214018.7861-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/tests/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/tests/Makefile b/libsepol/tests/Makefile
index 60b3e836cc94..6ae8ad2a507d 100644
--- a/libsepol/tests/Makefile
+++ b/libsepol/tests/Makefile
@@ -32,7 +32,7 @@ all: $(EXE) $(policies)
 policies: $(policies)
 
 $(EXE): $(objs) $(parserobjs) $(LIBSEPOL)
-	$(CC) $(CFLAGS) $(CPPFLAGS) $(objs) $(parserobjs) -lfl -lcunit -lcurses $(LIBSEPOL) -o $@
+	$(CC) $(LDFLAGS) $(objs) $(parserobjs) -lcunit -lcurses $(LIBSEPOL) -o $@
 
 %.conf.std: $(m4support) %.conf
 	$(M4) $(M4PARAMS) $^ > $@
-- 
2.10.2
