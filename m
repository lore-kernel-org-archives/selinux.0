Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8IMWWBU000501
 for <selinux@tycho.nsa.gov>; Sun, 18 Sep 2016 18:32:32 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 001F61A1A8
 for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2016 00:32:28 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id R8e3MutIdEIH for <selinux@tycho.nsa.gov>;
 Mon, 19 Sep 2016 00:32:27 +0200 (CEST)
Received: from fornost.bigon.be (unknown
 [IPv6:2a02:a03f:d9:8b00:faa3:456b:4d88:6dc7])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id D30DA1A06E
 for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2016 00:32:26 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] sandbox: Use dbus-launch instead of dbus-run-session
Date: Mon, 19 Sep 2016 00:32:26 +0200
Message-Id: <20160918223226.23000-1-bigon@debian.org>
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
---
 policycoreutils/sandbox/sandbox | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/sandbox
index 726ba9b..f537dc6 100644
--- a/policycoreutils/sandbox/sandbox
+++ b/policycoreutils/sandbox/sandbox
@@ -285,7 +285,7 @@ class Sandbox:
 /usr/bin/test -r ~/.xmodmap && /usr/bin/xmodmap ~/.xmodmap
 %s &
 WM_PID=$!
-dbus-launch --exit-with-session %s
+dbus-run-session -- %s
 kill -TERM $WM_PID  2> /dev/null
 """ % (command, wm, command))
         fd.close()
-- 
2.9.3
