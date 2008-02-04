Date: Mon, 4 Feb 2008 11:55:46 -0500
From: "Todd C. Miller" <tmiller@tresys.com>
Message-Id: <200802041655.m14GtkPo016740@cadmus.columbia.tresys.com>
To: selinux@tycho.nsa.gov
Subject: checkpolicy patch: avoid warning in rawhide
Cc: jbrindle@tresys.com, sds@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A build of trunk on rawhide (with an updated bison) dies in checkpolicy
due to the input() function being defined but not used.  Fix is simple,
define YY_NO_INPUT to prevent input() from being compiled.

Signed-off-by: Todd C. Miller <tmiller@tresys.com>

 - todd

Index: trunk/checkpolicy/Makefile
===================================================================
--- trunk/checkpolicy/Makefile	(revision 2783)
+++ trunk/checkpolicy/Makefile	(working copy)
@@ -12,7 +12,7 @@
 
 CFLAGS ?= -g -Wall -Werror -O2 -pipe -fno-strict-aliasing
 
-override CFLAGS += -I. -I${INCLUDEDIR}
+override CFLAGS += -I. -I${INCLUDEDIR} -DYY_NO_INPUT
 
 CHECKOBJS = y.tab.o lex.yy.o queue.o module_compiler.o parse_util.o
 CHECKPOLOBJS = $(CHECKOBJS) checkpolicy.o

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
