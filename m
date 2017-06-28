Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5SLgrDu027330
 for <selinux@tycho.nsa.gov>; Wed, 28 Jun 2017 17:42:54 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 72C8A561357
 for <selinux@tycho.nsa.gov>; Wed, 28 Jun 2017 23:42:50 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/3] libsepol/tests: override CPPFLAGS too
Date: Wed, 28 Jun 2017 23:42:20 +0200
Message-Id: <20170628214221.9288-2-nicolas.iooss@m4x.org>
In-Reply-To: <20170628214221.9288-1-nicolas.iooss@m4x.org>
References: <20170628214221.9288-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

A build toolchain may override CPPFLAGS on the command line of "make".
Doing so currently breaks libsepol/tests compilation, as it requires
"-I../include/ -I$(CHECKPOLICY)" to be provided in gcc's arguments.

This completes commit 15f274073322 ("Makefiles: override *FLAGS and
*LIBS").

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/tests/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/tests/Makefile b/libsepol/tests/Makefile
index 1bd96db9b7b2..e7e305e8150b 100644
--- a/libsepol/tests/Makefile
+++ b/libsepol/tests/Makefile
@@ -12,7 +12,7 @@ LIBSEPOL := ../src/libsepol.a
 # This is less than ideal, but it makes the tests easier to maintain by allowing source policies
 # to be loaded directly.
 CHECKPOLICY := ../../checkpolicy/
-CPPFLAGS += -I../include/ -I$(CHECKPOLICY)
+override CPPFLAGS += -I../include/ -I$(CHECKPOLICY)
 
 # test program object files
 objs := $(patsubst %.c,%.o,$(sort $(wildcard *.c)))
-- 
2.13.1
