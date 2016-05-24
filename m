Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u4O82dxu017532
 for <selinux@tycho.nsa.gov>; Tue, 24 May 2016 04:02:39 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 269D6C09725F
 for <selinux@tycho.nsa.gov>; Tue, 24 May 2016 08:02:37 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils/semodule: Fix the documentation of -l,--list
Date: Tue, 24 May 2016 10:02:29 +0200
Message-Id: <1464076949-27068-1-git-send-email-plautrba@redhat.com>
In-Reply-To: <6a2dd3fa-1b9d-f2a8-a39d-7b72ac9570a0@tycho.nsa.gov>
References: <6a2dd3fa-1b9d-f2a8-a39d-7b72ac9570a0@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

It wasn't clear how to use -l option with full/standard KIND and the
example in semodule.8 man page was wrong.

Based on a patch by Laurent Bigonville <bigon@bigon.be>
Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/semodule/semodule.8 | 4 ++--
 policycoreutils/semodule/semodule.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
index 68e95ab..0c5fdf7 100644
--- a/policycoreutils/semodule/semodule.8
+++ b/policycoreutils/semodule/semodule.8
@@ -38,7 +38,7 @@ deprecated, alias for --install
 .B  \-r,\-\-remove=MODULE_NAME
 remove existing module
 .TP
-.B  \-l,\-\-list-modules=[KIND]
+.B  \-l[KIND],\-\-list-modules[=KIND]
 display list of installed modules (other than base)
 .TP
 .B  \-E,\-\-extract=MODULE_PKG
@@ -116,7 +116,7 @@ $ semodule \-d alsa
 # Install a module at a specific priority.
 $ semodule \-X 100 \-i alsa.pp
 # List all modules.
-$ semodule \-l full
+$ semodule \-\-list=full
 # Set an alternate path for the policy root
 $ semodule \-B \-p "/tmp"
 # Set an alternate path for the policy store root
diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index bcfaa2b..63900f4 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -127,7 +127,7 @@ static void usage(char *progname)
 	printf("  -B, --build		    build and reload policy\n");
 	printf("  -i,--install=MODULE_PKG   install a new module\n");
 	printf("  -r,--remove=MODULE_NAME   remove existing module\n");
-	printf("  -l,--list-modules=[KIND]  display list of installed modules\n");
+	printf("  -l[KIND],--list-modules[=KIND]  display list of installed modules\n");
 	printf("     KIND:  standard  list highest priority, enabled modules\n");
 	printf("            full      list all modules\n");
 	printf("  -X,--priority=PRIORITY    set priority for following operations (1-999)\n");
-- 
2.7.4
