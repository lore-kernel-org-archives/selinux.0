Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5CDntnq022365
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2012 09:49:55 -0400
Message-ID: <1339508992.8603.YahooMailClassic@web87701.mail.ir2.yahoo.com>
Date: Tue, 12 Jun 2012 14:49:52 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Subject: [PATCH 1/1] XSELinux: When SELinux is enabled the xserver seg faults
To: xorg-devel@lists.x.org, ewalsh@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch was created using xorg-server-1.12.0 source.

When using Fedora 17 with xorg-server-1.12.0 and SELinux is enabled
('setsebool xserver_object_manager on') the xserver will not load. The X
log file has a seg fault pointing to XACE/SELinux. Bug 50641 was raised
(https://bugs.freedesktop.org/show_bug.cgi?id=50641). The patch below is a
possible fix.

The bug is caused by X calling XaceHook(XACE_DEVICE_ACCESS, client, ...)
with a device ID of '1' that is XIAllMasterDevices. It would also happen
if the device ID = 0 (XIAllDevices).

The only places currently seen calling with a device id=1 are:
GrabKey - in Xi/exevents.c and AddPassiveGrabToList - in dix/grabs.c
These start life in ProcXIPassiveGrabDevice (in Xi/xipassivegrab.c) that
has been called by XIGrabKeycode.

The patch has been tested using the other XI calls that would also impact
this: XIGrabTouchBegin, XIGrabButton, XIGrabFocusIn and XIGrabEnter with
and without the correct permissions (grab and freeze) with no problems.

Both possible classes have to be checked (x_keyboard and x_pointer) as it
is not known whether it is a pointer or keyboard as this info is not
available. To get this info would require a change to the
XaceHook(XACE_DEVICE_ACCESS, client, ..) call to pass an additional
parameter stating the actual devices (that would defeat the objective of
the XIAllMasterDevices and XIAllDevices dev ids).

Note that there are other devices apart from the keyboard and pointer, for
example on the test system: DeviceID: 9 is the Integrated_Webcam_1.3M. As
it is classed as a slave keyboard it is checked.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 Xext/xselinux_hooks.c |   44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/Xext/xselinux_hooks.c b/Xext/xselinux_hooks.c
index 0d4c9ab..c2b21d6 100644
--- a/Xext/xselinux_hooks.c
+++ b/Xext/xselinux_hooks.c
@@ -336,9 +336,17 @@ SELinuxDevice(CallbackListPtr *pcbl, pointer unused, pointer calldata)
     SELinuxAuditRec auditdata = { .client = rec->client, .dev = rec->dev };
     security_class_t cls;
     int rc;
+    DeviceIntPtr dev = NULL;
+    int i = 0;
 
     subj = dixLookupPrivate(&rec->client->devPrivates, subjectKey);
-    obj = dixLookupPrivate(&rec->dev->devPrivates, objectKey);
+	/*
+	 * The XIAllMasterDevices or XIAllDevices do not have devPrivates
+	 * entries. Therefore dixLookupPrivate for the object is done later
+	 * for these device IDs.
+	 */
+	if (rec->dev->id != XIAllDevices && rec->dev->id != XIAllMasterDevices)
+    	obj = dixLookupPrivate(&rec->dev->devPrivates, objectKey);
 
     /* If this is a new object that needs labeling, do it now */
     if (rec->access_mode & DixCreateAccess) {
@@ -356,12 +364,38 @@ SELinuxDevice(CallbackListPtr *pcbl, pointer unused, pointer calldata)
 	}
     }
 
-    cls = IsPointerDevice(rec->dev) ? SECCLASS_X_POINTER : SECCLASS_X_KEYBOARD;
-    rc = SELinuxDoCheck(subj, obj, cls, rec->access_mode, &auditdata);
-    if (rc != Success)
-	rec->status = rc;
+	if (rec->dev->id != XIAllDevices && rec->dev->id != XIAllMasterDevices) {
+   		cls = IsPointerDevice(rec->dev) ? SECCLASS_X_POINTER : SECCLASS_X_KEYBOARD;
+	   	rc = SELinuxDoCheck(subj, obj, cls, rec->access_mode, &auditdata);
+   		if (rc != Success)
+			rec->status = rc;
+		return;
+	} else {
+		/*
+		 * Device ID must be 0 or 1
+		 * We have to check both possible classes as we don't know whether it
+		 * was a pointer or keyboard. Therefore all devices are checked for:
+		 * 		rec->dev->id == XIAllDevices
+		 * and only masters for:
+		 *		 rec->dev->id == XIAllMasterDevices
+		 *
+		 * An error is returned should any device fail SELinuxDoCheck
+		 */
+		for (dev = inputInfo.devices; dev; dev = dev->next, i++) {
+			if (!IsMaster(dev) && rec->dev->id == XIAllMasterDevices)
+				continue;
+  			cls = IsPointerDevice(dev) ? SECCLASS_X_POINTER : SECCLASS_X_KEYBOARD;
+			obj = dixLookupPrivate(&dev->devPrivates, objectKey);
+		    rc = SELinuxDoCheck(subj, obj, cls, rec->access_mode, &auditdata);
+		    if (rc != Success) {
+				rec->status = rc;
+				return;
+			}
+		}
+	}
 }
 
+
 static void
 SELinuxSend(CallbackListPtr *pcbl, pointer unused, pointer calldata)
 {
-- 
1.7.10.2



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
