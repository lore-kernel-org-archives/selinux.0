Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5KKdCdi004381
 for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2017 16:39:12 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 7EB185648B5
 for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2017 22:30:11 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/3] python/sepolicy: remove definition of SYSCONFDIR
Date: Tue, 20 Jun 2017 22:29:55 +0200
Message-Id: <20170620202955.11587-3-nicolas.iooss@m4x.org>
In-Reply-To: <20170620202955.11587-1-nicolas.iooss@m4x.org>
References: <20170620202955.11587-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This variable is not used in any Makefile in python/.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolicy/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
index 0d2bec2042b0..5a56e6c8122e 100644
--- a/python/sepolicy/Makefile
+++ b/python/sepolicy/Makefile
@@ -2,7 +2,6 @@ PYTHON ?= python
 
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
-SYSCONFDIR ?= $(DESTDIR)/etc/sysconfig
 LIBDIR ?= $(PREFIX)/lib
 BINDIR ?= $(PREFIX)/bin
 DATADIR ?= $(PREFIX)/share
-- 
2.13.1
