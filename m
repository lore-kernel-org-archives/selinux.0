Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u15Kuq2J031606
 for <selinux@tycho.nsa.gov>; Fri, 5 Feb 2016 15:56:52 -0500
Received: from iosakhe.localdomain (32.206.133.77.rev.sfr.net [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 953FE5647AE
 for <selinux@tycho.nsa.gov>; Fri,  5 Feb 2016 21:56:49 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/3] libsemanage: tests: do not overwrite CFLAGS and LDFLAGS
Date: Fri,  5 Feb 2016 21:55:51 +0100
Message-Id: <1454705751-1448-3-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1454705751-1448-1-git-send-email-nicolas.iooss@m4x.org>
References: <1454705751-1448-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

libsemanage/tests/Makefile currently overwrites CFLAGS and LDFLAGS
contents.  This makes building with custom flags (e.g. with address
sanitizer) harder.  Append flags to these variables instead.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/tests/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index 59067acc6ab4..fec96ffd282b 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -11,9 +11,9 @@ LIBS = ../src/libsemanage.a ../../libselinux/src/libselinux.a ../../libsepol/src
 
 EXECUTABLE = libsemanage-tests
 CC = gcc
-CFLAGS = -c -g -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter
+CFLAGS += -g -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter
 INCLUDE = -I$(TESTSRC) -I$(TESTSRC)/../include
-LDFLAGS = -lcunit -lustr -lbz2 -laudit
+LDFLAGS += -lcunit -lustr -lbz2 -laudit
 OBJECTS = $(SOURCES:.c=.o) 
 
 all: $(EXECUTABLE) 
@@ -22,7 +22,7 @@ $(EXECUTABLE): $(OBJECTS)
 	$(CC) $(OBJECTS) $(LIBS) $(LDFLAGS) -o $@
 
 %.o: %.c
-	$(CC) $(CFLAGS) $(INCLUDE) $*.c -o $*.o
+	$(CC) $(CFLAGS) $(INCLUDE) -c $*.c -o $*.o
 
 clean distclean: 
 	rm -rf $(OBJECTS) $(EXECUTABLE)
-- 
2.7.0
