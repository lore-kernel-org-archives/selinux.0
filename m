Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8LFe1PA027621
 for <selinux@tycho.nsa.gov>; Wed, 21 Sep 2016 11:40:01 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 923488E003
 for <selinux@tycho.nsa.gov>; Wed, 21 Sep 2016 15:39:58 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] sandbox: do not run xmodmap in a new X session
Date: Wed, 21 Sep 2016 17:39:53 +0200
Message-Id: <1474472393-2208-1-git-send-email-plautrba@redhat.com>
In-Reply-To: <45d0fdf5-48ad-242c-fa77-314bdf052bb7@tycho.nsa.gov>
References: <45d0fdf5-48ad-242c-fa77-314bdf052bb7@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

xmodmap causes Xephyr X server to reset itself when it's run before wm
and even right after wm. It causes termination of the server as we use
-terminate. The -terminate option seems be important enough in order not
to left running the server when the last client connection is closed.

This patch drops the execution of xmodmap from .sandboxrc until there's
a better solution.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/sandbox/sandbox | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/sandbox
index 726ba9b..4ed57c1 100644
--- a/policycoreutils/sandbox/sandbox
+++ b/policycoreutils/sandbox/sandbox
@@ -282,7 +282,7 @@ class Sandbox:
                 command += "'%s' " % p
             fd.write("""#! /bin/sh
 #TITLE: %s
-/usr/bin/test -r ~/.xmodmap && /usr/bin/xmodmap ~/.xmodmap
+# /usr/bin/test -r ~/.xmodmap && /usr/bin/xmodmap ~/.xmodmap
 %s &
 WM_PID=$!
 dbus-launch --exit-with-session %s
-- 
1.8.3.1
