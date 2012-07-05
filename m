Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q65Gr0O7003563
	for <selinux@tycho.nsa.gov>; Thu, 5 Jul 2012 12:53:01 -0400
Message-ID: <1341506779.56665.YahooMailClassic@web87705.mail.ir2.yahoo.com>
Date: Thu, 5 Jul 2012 17:46:19 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 1/1] dix: Check whether grab allowed by security provider
To: xorg-devel@lists.x.org, ewalsh@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch was created using xorg-server-1.12.2 source.

Call XACE to verify if grab access is allowed.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 dix/events.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/dix/events.c b/dix/events.c
index 86336fe..0ce2140 100644
--- a/dix/events.c
+++ b/dix/events.c
@@ -3807,7 +3807,11 @@ CheckPassiveGrab(DeviceIntPtr device, GrabPtr grab, InternalEvent *event,
             return FALSE;
     }
 
-    return TRUE;
+    /* Finally check whether grab allowed by security provider */
+    if (XaceHook(XACE_DEVICE_ACCESS, rClient(grab), device, DixGrabAccess) == 0)
+        return TRUE;
+    else
+        return FALSE;
 }
 
 /**
-- 
1.7.10.4



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
