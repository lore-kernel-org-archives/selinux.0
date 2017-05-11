Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4BNoKgN025888
 for <selinux@tycho.nsa.gov>; Thu, 11 May 2017 19:50:20 -0400
Received: by mail-pg0-f41.google.com with SMTP id u28so21719616pgn.1
 for <selinux@tycho.nsa.gov>; Thu, 11 May 2017 16:50:14 -0700 (PDT)
From: Tom Cherry <tomcherry@google.com>
To: selinux@tycho.nsa.gov
Cc: nnk@google.com, enh@google.com, Tom Cherry <tomcherry@google.com>
Subject: [PATCH] procattr.c: Use __BIONIC__ instead of __ANDROID__
Date: Thu, 11 May 2017 16:50:02 -0700
Message-Id: <20170511235002.26468-1-tomcherry@google.com>
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This check is not specific to Android devices. If libselinux were used
with Bionic on a normal Linux system this check would still be needed.

Signed-off-by: Tom Cherry <tomcherry@google.com>
---
 libselinux/src/procattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
index ebc0adec..48dd8aff 100644
--- a/libselinux/src/procattr.c
+++ b/libselinux/src/procattr.c
@@ -22,8 +22,8 @@ static pthread_key_t destructor_key;
 static int destructor_key_initialized = 0;
 static __thread char destructor_initialized;
 
-#ifndef __ANDROID__
-/* Android declares this in unistd.h and has a definition for it */
+#ifndef __BIONIC__
+/* Bionic declares this in unistd.h and has a definition for it */
 static pid_t gettid(void)
 {
 	return syscall(__NR_gettid);
-- 
2.13.0.rc2.291.g57267f2277-goog
