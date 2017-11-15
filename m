Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAFDeCVU026220
 for <selinux@tycho.nsa.gov>; Wed, 15 Nov 2017 08:40:12 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 58AED4A6FF
 for <selinux@tycho.nsa.gov>; Wed, 15 Nov 2017 13:26:03 +0000 (UTC)
From: Lukas Vrabec <lvrabec@redhat.com>
To: selinux@tycho.nsa.gov
Date: Wed, 15 Nov 2017 14:25:53 +0100
Message-Id: <20171115132553.17599-1-lvrabec@redhat.com>
Subject: [PATCH] python/sepolicy: Fix sepolicy manpage.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Arguments generate and gui was mixed together and information didn't make sense. This fix split gui and generate sections.

Signed-off-by: Lukas Vrabec <lvrabec@redhat.com>
---
 python/sepolicy/sepolicy.8 | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/python/sepolicy/sepolicy.8 b/python/sepolicy/sepolicy.8
index 79005866..09d2b247 100644
--- a/python/sepolicy/sepolicy.8
+++ b/python/sepolicy/sepolicy.8
@@ -22,14 +22,15 @@ Query SELinux policy to see if domains can communicate with each other
 .br
 
 .B    generate
-.br 
 .br
 Generate SELinux Policy module template
-.B    gui
+.B sepolicy-generate(8)
 .br
+
+.B    gui
 .br
 Launch Graphical User Interface for SELinux Policy, requires policycoreutils-gui package.
-.B sepolicy-generate(8)
+.B sepolicy-gui(8)
 .br
 
 .B    interface
-- 
2.13.6
