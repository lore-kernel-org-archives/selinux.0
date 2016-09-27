Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8RCduuk026639
 for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2016 08:39:56 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 9D51B1A1A8
 for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2016 14:39:52 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 8sCqjJccyKMa for <selinux@tycho.nsa.gov>;
 Tue, 27 Sep 2016 14:39:50 +0200 (CEST)
Received: from valinor.bigon.be (unknown [193.53.238.201])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 3CDF41A06E
 for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2016 14:39:50 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [Patch v3] sandbox: Use dbus-run-session instead of dbus-launch when
 available
Date: Tue, 27 Sep 2016 14:39:49 +0200
Message-Id: <20160927123949.24440-1-bigon@debian.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <bigon@bigon.be>

According to dbus upstream: "dbus-launch is fairly horrible code,
complicated by the historical need for it to support X11 autolaunching,
so the D-Bus maintainers would like to move it out of the critical path
and minimize its use."

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=836289

Signed-off-by: Laurent Bigonville <bigon@bigon.be>
---
 policycoreutils/sandbox/sandbox | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/sandbox
index b6bc805..4010e83 100644
--- a/policycoreutils/sandbox/sandbox
+++ b/policycoreutils/sandbox/sandbox
@@ -285,9 +285,13 @@ class Sandbox:
 # /usr/bin/test -r ~/.xmodmap && /usr/bin/xmodmap ~/.xmodmap
 %s &
 WM_PID=$!
-dbus-launch --exit-with-session %s
+if which dbus-run-session >/dev/null 2>&1; then
+    dbus-run-session -- %s
+else
+    dbus-launch --exit-with-session %s
+fi
 kill -TERM $WM_PID  2> /dev/null
-""" % (command, wm, command))
+""" % (command, wm, command, command))
         fd.close()
         os.chmod(execfile, 0o700)
 
-- 
2.9.3
