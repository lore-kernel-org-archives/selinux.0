Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q65GihKX003070
	for <selinux@tycho.nsa.gov>; Thu, 5 Jul 2012 12:44:44 -0400
Message-ID: <1341506681.15140.YahooMailClassic@web87703.mail.ir2.yahoo.com>
Date: Thu, 5 Jul 2012 17:44:41 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: [V3] [PATCH 1/1] XSELinux: When SELinux is enabled the xserver seg faults
To: xorg-devel@lists.x.org, ewalsh@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch was created using xorg-server-1.12.2 source.

When using Fedora 17 with xorg-server-1.12.2 and SELinux is enabled
('setsebool xserver_object_manager on') the xserver will not load. The 
Xlog file has a seg fault pointing to XACE/SELinux. Bug 50641 was raised
(https://bugs.freedesktop.org/show_bug.cgi?id=50641).

The bug is caused by X calling XaceHook(XACE_DEVICE_ACCESS, client, ...)
with a device ID of '1' that is XIAllMasterDevices. It would also happen if
the device ID = 0 (XIAllDevices).

The fix is to return if device is XIAll*Devices and let the permission be
determined when a real device ID is presented.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 Xext/xselinux_hooks.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Xext/xselinux_hooks.c b/Xext/xselinux_hooks.c
index e9c7e93..82d3892 100644
--- a/Xext/xselinux_hooks.c
+++ b/Xext/xselinux_hooks.c
@@ -336,7 +336,15 @@ SELinuxDevice(CallbackListPtr *pcbl, pointer unused, pointer calldata)
     int rc;
 
     subj = dixLookupPrivate(&rec->client->devPrivates, subjectKey);
-    obj = dixLookupPrivate(&rec->dev->devPrivates, objectKey);
+    /*
+     * The XIAllMasterDevices or XIAllDevices do not have devPrivates
+     * entries. If they are requested we just return as each device access
+     * will be checked individually.
+     */
+    if (rec->dev->id != XIAllDevices && rec->dev->id != XIAllMasterDevices)
+        obj = dixLookupPrivate(&rec->dev->devPrivates, objectKey);
+    else 
+        return;
 
     /* If this is a new object that needs labeling, do it now */
     if (rec->access_mode & DixCreateAccess) {
-- 
1.7.10.4



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
