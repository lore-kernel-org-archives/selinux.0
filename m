Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8GDXNKX025716
 for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2016 09:33:28 -0400
Received: by mail-wm0-f50.google.com with SMTP id 1so42047776wmz.1
 for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2016 06:33:22 -0700 (PDT)
From: Janis Danisevskis <jdanis@android.com>
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov,
 jwcart2@tycho.nsa.gov
Subject: [PATCH] sefcontext_compile: cleanup confusing usage message
Date: Fri, 16 Sep 2016 14:33:17 +0100
Message-Id: <1474032797-32638-1-git-send-email-jdanis@android.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Janis Danisevskis <jdanis@google.com>

Signed-off-by: Janis Danisevskis <jdanis@google.com>
---
 libselinux/utils/sefcontext_compile.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index 770ec4c..70853e7 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -267,8 +267,6 @@ static void usage(const char *progname)
 	    "         (PCRE2 only. Compiled PCRE2 regular expressions are\n\t"
 	    "         not portable across architectures. When linked against\n\t"
 	    "         PCRE this flag is ignored)\n\t"
-	    "         Omit precompiled regular expressions (only meaningful\n\t"
-	    "         when using PCRE2 regular expression back-end).\n\t"
 	    "fc_file  The text based file contexts file to be processed.\n",
 	    progname);
 		exit(EXIT_FAILURE);
-- 
2.8.0.rc3.226.g39d4020
