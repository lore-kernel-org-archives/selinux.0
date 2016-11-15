From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: jwcart2@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libsepol: cil_lexer: make warnings non-fatal for building
Date: Tue, 15 Nov 2016 17:21:07 -0500
Message-Id: <1479248467-24209-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The flex skeleton often triggers compiler warnings; make these
non-fatal for building.  We already do likewise for checkpolicy.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsepol/src/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index 7856213..7272458 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -60,6 +60,12 @@ else
 endif
 
 ifneq ($(DISABLE_CIL),y)
+$(CILDIR)/src/cil_lexer.o: $(CILDIR)/src/cil_lexer.c
+	$(CC) $(filter-out -Werror, $(CFLAGS)) -fPIC -c -o $@ $<
+
+$(CILDIR)/src/cil_lexer.lo: $(CILDIR)/src/cil_lexer.c
+	$(CC) $(filter-out -Werror, $(CFLAGS)) -fPIC -DSHARED -c -o $@ $<
+
 $(CILDIR)/src/cil_lexer.c: $(CILDIR)/src/cil_lexer.l
 	$(LEX) -t $< > $@
 endif
-- 
2.7.4
