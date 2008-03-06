Date: Thu, 6 Mar 2008 17:02:39 -0500
From: "Todd C. Miller" <tmiller@tresys.com>
Message-Id: <200803062202.m26M2ddO026165@cadmus.columbia.tresys.com>
To: selinux@tycho.nsa.gov
Subject: PATCH: fix libsepol tests build error
Cc: jbrindle@tresys.com, sds@tycho.nsa.gov, tmiller@tresys.com
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Now that the bulk of policy_parse.y has been split out into
policy_define.c, libsepol/tests/Makefile needs to link against
policy_define.o too.

Signed-off-by: Todd C. Miller <tmiller@tresys.com>

 Makefile |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: trunk/libsepol/tests/Makefile
===================================================================
--- trunk/libsepol/tests/Makefile	(revision 2843)
+++ trunk/libsepol/tests/Makefile	(working copy)
@@ -16,8 +16,9 @@
 
 # test program object files
 objs := $(patsubst %.c,%.o,$(wildcard *.c))
-parserobjs := $(CHECKPOLICY)queue.o $(CHECKPOLICY)y.tab.o $(CHECKPOLICY)parse_util.o $(CHECKPOLICY)lex.yy.o \
-	$(CHECKPOLICY)module_compiler.o
+parserobjs := $(CHECKPOLICY)queue.o $(CHECKPOLICY)y.tab.o \
+	$(CHECKPOLICY)parse_util.o $(CHECKPOLICY)lex.yy.o \
+	$(CHECKPOLICY)policy_define.o $(CHECKPOLICY)module_compiler.o
 
 # test policy pieces
 m4support := $(wildcard policies/support/*.spt)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
