From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, Caleb Case <ccase@tresys.com>
Subject: [PATCH 01/13] libsemanage: fix typo in tests makefile -o -> -O
Date: Wed, 23 Dec 2009 18:25:48 -0500
Message-Id: <1261610760-4724-2-git-send-email-ccase@tresys.com>
In-Reply-To: <1261610760-4724-1-git-send-email-ccase@tresys.com>
References: <1261610760-4724-1-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fixed typo in the tests Makefile where '-o' should have been '-O'.
---
 libsemanage/tests/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index f92455c..46968d5 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -11,7 +11,7 @@ LIBS = ../src/libsemanage.a ../../libselinux/src/libselinux.a ../../libsepol/src
 
 EXECUTABLE = libsemanage-tests
 CC = gcc
-CFLAGS = -c -g -o0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter
+CFLAGS = -c -g -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter
 INCLUDE = -I$(TESTSRC) -I$(TESTSRC)/../include
 LDFLAGS = -lcunit -lustr -lbz2
 OBJECTS = $(SOURCES:.c=.o) 
-- 
1.6.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
