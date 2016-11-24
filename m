Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAO2lMdx008801
 for <selinux@tycho.nsa.gov>; Wed, 23 Nov 2016 21:47:22 -0500
Received: by mail-pg0-f52.google.com with SMTP id p66so12780990pga.2
 for <selinux@tycho.nsa.gov>; Wed, 23 Nov 2016 18:47:19 -0800 (PST)
From: Nick Kralevich <nnk@google.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] procattr.c: Use __ANDROID__ instead of ANDROID
Date: Wed, 23 Nov 2016 18:47:10 -0800
Message-Id: <1479955630-85378-1-git-send-email-nnk@google.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When code is compiled within the Android tree, the resulting binaries
are intended to run either on the "host" (the machine doing the
building) or the "target" (the machine running the Android operating
system).

"ANDROID" is defined if the code is being compiled for the host or the
target, whereas "__ANDROID__" is only defined for code being compiled for
the target. (yes, I agree, this is not obvious).

gettid() is only declared in the target environment, not the host
environment, so adjust the #ifdef to properly emit the gettid()
definition for binaries targeting the host.

Signed-off-by: Nick Kralevich <nnk@google.com>
---
 libselinux/src/procattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
index 7efcd7e..8cd59af 100644
--- a/libselinux/src/procattr.c
+++ b/libselinux/src/procattr.c
@@ -22,7 +22,7 @@ static pthread_key_t destructor_key;
 static int destructor_key_initialized = 0;
 static __thread char destructor_initialized;
 
-#ifndef ANDROID
+#ifndef __ANDROID__
 /* Android declares this in unistd.h and has a definition for it */
 static pid_t gettid(void)
 {
-- 
2.8.0.rc3.226.g39d4020
