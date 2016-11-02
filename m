Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA2D4olX024465
 for <selinux@tycho.nsa.gov>; Wed, 2 Nov 2016 09:04:51 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id EDC741A1A8
 for <selinux@tycho.nsa.gov>; Wed,  2 Nov 2016 14:04:44 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id yDkaPmlIeC8K for <selinux@tycho.nsa.gov>;
 Wed,  2 Nov 2016 14:04:38 +0100 (CET)
Received: from valinor.bigon.be (d54c71dba.static.telenet.be [84.199.29.186])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 352E41A06E
 for <selinux@tycho.nsa.gov>; Wed,  2 Nov 2016 14:04:38 +0100 (CET)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils: Use "new" sepolicy icon in .desktop file for
 sepolicy gui
Date: Wed,  2 Nov 2016 14:04:37 +0100
Message-Id: <20161102130437.15464-1-bigon@debian.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <bigon@bigon.be>

New hires icons have been added to the repository end 2013 but the
sepolicy .desktop file is not using it, let's fix that.
---
 policycoreutils/sepolicy/sepolicy.desktop | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/sepolicy/sepolicy.desktop b/policycoreutils/sepolicy/sepolicy.desktop
index f9d0cec..181a1c5 100644
--- a/policycoreutils/sepolicy/sepolicy.desktop
+++ b/policycoreutils/sepolicy/sepolicy.desktop
@@ -1,7 +1,7 @@
 [Desktop Entry]
 Name=SELinux Policy Management Tool
 Comment=Generate SELinux policy modules
-Icon=system-config-selinux
+Icon=sepolicy
 Exec=/usr/bin/sepolicy gui
 Type=Application
 Terminal=false
-- 
2.10.2
