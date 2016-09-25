Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8PCGdhO015441
 for <selinux@tycho.nsa.gov>; Sun, 25 Sep 2016 08:16:40 -0400
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id F1981564E1D
 for <selinux@tycho.nsa.gov>; Sun, 25 Sep 2016 14:16:37 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/3] libsemanage/tests: do not force using gcc
Date: Sun, 25 Sep 2016 14:16:08 +0200
Message-Id: <20160925121609.14516-2-nicolas.iooss@m4x.org>
In-Reply-To: <20160925121609.14516-1-nicolas.iooss@m4x.org>
References: <20160925121609.14516-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Allow using other compilers such as clang. Without this, the build fails
when $(CFLAGS) contains clang-specific flags:

    gcc: error: unrecognized command line option '-Weverything'

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/tests/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index fec96ffd282b..4b81fed70660 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -10,7 +10,6 @@ LIBS = ../src/libsemanage.a ../../libselinux/src/libselinux.a ../../libsepol/src
 ###########################################################################
 
 EXECUTABLE = libsemanage-tests
-CC = gcc
 CFLAGS += -g -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter
 INCLUDE = -I$(TESTSRC) -I$(TESTSRC)/../include
 LDFLAGS += -lcunit -lustr -lbz2 -laudit
-- 
2.10.0
