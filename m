Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uASLf9fA026187
 for <selinux@tycho.nsa.gov>; Mon, 28 Nov 2016 16:41:09 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id E93435605F8
 for <selinux@tycho.nsa.gov>; Mon, 28 Nov 2016 22:40:59 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/4] libsepol,libsemanage: write file name in flex output
Date: Mon, 28 Nov 2016 22:40:18 +0100
Message-Id: <20161128214018.7861-4-nicolas.iooss@m4x.org>
In-Reply-To: <20161128214018.7861-1-nicolas.iooss@m4x.org>
References: <20161128214018.7861-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Tools like lcov (for code coverage) does not like files named
"<stdout>". For example it reports errors like:

    genhtml: ERROR: cannot read
    /usr/src/selinux/libsemanage/src/<stdout>

When using flex -o option, the output file name gets written in the
generated C code, which solves this issue.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/src/Makefile | 2 +-
 libsepol/src/Makefile    | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index ef25902bb019..df5809645a00 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -101,7 +101,7 @@ semanageswig_python_exception.i: ../include/semanage/semanage.h
 	bash -e exception.sh > $@ || (rm -f $@ ; false)
 
 conf-scan.c: conf-scan.l conf-parse.h
-	$(LEX) $(LFLAGS) -t $< > $@
+	$(LEX) $(LFLAGS) -o $@ $<
 
 conf-parse.c: conf-parse.y
 	$(YACC) $(YFLAGS) -o $@ $<
diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index 72724580eb98..497cd5675bd9 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -67,7 +67,8 @@ $(CILDIR)/src/cil_lexer.lo: $(CILDIR)/src/cil_lexer.c
 	$(CC) $(filter-out -Werror, $(CFLAGS)) -fPIC -DSHARED -c -o $@ $<
 
 $(CILDIR)/src/cil_lexer.c: $(CILDIR)/src/cil_lexer.l
-	$(LEX) -t $< > $@
+	$(LEX) -o $@ $<
+
 endif
 
 %.o:  %.c 
-- 
2.10.2
