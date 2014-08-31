Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s7VHI1gW026239
 for <selinux@tycho.nsa.gov>; Sun, 31 Aug 2014 13:18:01 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 972671A05A
 for <selinux@tycho.nsa.gov>; Sun, 31 Aug 2014 19:18:03 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id c_DPHwt-vmZV for <selinux@tycho.nsa.gov>;
 Sun, 31 Aug 2014 19:18:01 +0200 (CEST)
Received: from fornost.bigon.be (unknown
 [IPv6:2a02:578:85fc:1:226:18ff:fe08:6073])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 5EC121A052
 for <selinux@tycho.nsa.gov>; Sun, 31 Aug 2014 19:18:01 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: man: Add missing manpage links to
 security_load_policy.3
Date: Sun, 31 Aug 2014 19:17:59 +0200
Message-Id: <1409505479-4875-1-git-send-email-bigon@debian.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <bigon@bigon.be>

Add the missing manpage link for selinux_init_load_policy(3) and
selinux_mkload_policy(3) to security_load_policy(3)

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=753803
---
 libselinux/man/man3/selinux_init_load_policy.3 | 1 +
 libselinux/man/man3/selinux_mkload_policy.3    | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 libselinux/man/man3/selinux_init_load_policy.3
 create mode 100644 libselinux/man/man3/selinux_mkload_policy.3

diff --git a/libselinux/man/man3/selinux_init_load_policy.3 b/libselinux/man/man3/selinux_init_load_policy.3
new file mode 100644
index 0000000..94e8117
--- /dev/null
+++ b/libselinux/man/man3/selinux_init_load_policy.3
@@ -0,0 +1 @@
+.so man3/security_load_policy.3
diff --git a/libselinux/man/man3/selinux_mkload_policy.3 b/libselinux/man/man3/selinux_mkload_policy.3
new file mode 100644
index 0000000..94e8117
--- /dev/null
+++ b/libselinux/man/man3/selinux_mkload_policy.3
@@ -0,0 +1 @@
+.so man3/security_load_policy.3
-- 
2.1.0
