Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u45C3Cu9013308
 for <selinux@tycho.nsa.gov>; Thu, 5 May 2016 08:03:15 -0400
Received: from iosakhe.localdomain (32.206.133.77.rev.sfr.net [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 97A98564835
 for <selinux@tycho.nsa.gov>; Thu,  5 May 2016 14:03:04 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/3] sepolgen: remove additional files when cleaning
Date: Thu,  5 May 2016 14:02:39 +0200
Message-Id: <1462449760-9072-3-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1462449760-9072-1-git-send-email-nicolas.iooss@m4x.org>
References: <1462449760-9072-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Remove the files created by Python 3 and refpolicy building process.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 sepolgen/src/sepolgen/Makefile | 3 +--
 sepolgen/tests/Makefile        | 3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sepolgen/src/sepolgen/Makefile b/sepolgen/src/sepolgen/Makefile
index 9ac765151478..d3aa7715c488 100644
--- a/sepolgen/src/sepolgen/Makefile
+++ b/sepolgen/src/sepolgen/Makefile
@@ -11,5 +11,4 @@ install: all
 clean:
 	rm -f parser.out parsetab.py
 	rm -f *~ *.pyc
-
-
+	rm -rf __pycache__
diff --git a/sepolgen/tests/Makefile b/sepolgen/tests/Makefile
index 924a9bed6bcd..e17eef229ff3 100644
--- a/sepolgen/tests/Makefile
+++ b/sepolgen/tests/Makefile
@@ -4,8 +4,11 @@ clean:
 	rm -f *~ *.pyc
 	rm -f parser.out parsetab.py
 	rm -f out.txt
+	rm -f module_compile_test.fc
+	rm -f module_compile_test.if
 	rm -f module_compile_test.pp
 	rm -f output
+	rm -rf __pycache__ tmp
 
 test:
 	$(PYTHON) run-tests.py
-- 
2.8.2
