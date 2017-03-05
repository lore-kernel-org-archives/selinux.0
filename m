Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v25HDPOW026457
 for <selinux@tycho.nsa.gov>; Sun, 5 Mar 2017 12:13:29 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id AD6085613BA
 for <selinux@tycho.nsa.gov>; Sun,  5 Mar 2017 18:13:27 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/6] mcstrans: add noreturn attribute to usage()
Date: Sun,  5 Mar 2017 18:13:03 +0100
Message-Id: <20170305171305.23170-4-nicolas.iooss@m4x.org>
In-Reply-To: <20170305171305.23170-1-nicolas.iooss@m4x.org>
References: <20170305171305.23170-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 mcstrans/utils/transcon.c   | 2 +-
 mcstrans/utils/untranscon.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mcstrans/utils/transcon.c b/mcstrans/utils/transcon.c
index 5189f0fa8712..f4ded53e9609 100644
--- a/mcstrans/utils/transcon.c
+++ b/mcstrans/utils/transcon.c
@@ -7,7 +7,7 @@
 #include <selinux/selinux.h>
 #include "mcstrans.h"
 
-void usage(const char *progname) 
+static __attribute__((__noreturn__)) void usage(const char *progname)
 {
 	fprintf(stderr, "usage:  %s context\n", progname);
 	exit(1);
diff --git a/mcstrans/utils/untranscon.c b/mcstrans/utils/untranscon.c
index f47b6ea81b14..85cea294e88d 100644
--- a/mcstrans/utils/untranscon.c
+++ b/mcstrans/utils/untranscon.c
@@ -7,7 +7,7 @@
 #include <selinux/selinux.h>
 #include "mcstrans.h"
 
-void usage(const char *progname) 
+static __attribute__((__noreturn__)) void usage(const char *progname)
 {
 	fprintf(stderr, "usage:  %s context\n", progname);
 	exit(1);
-- 
2.11.1
