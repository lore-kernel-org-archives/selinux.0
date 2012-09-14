Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8EFORWY019065
	for <selinux@tycho.nsa.gov>; Fri, 14 Sep 2012 11:24:27 -0400
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <jbrindle@tresys.com>
Subject: [RFC] Add initial clipboard access control implementation
Date: Fri, 14 Sep 2012 11:24:16 -0400
Message-Id: <1347636256-4457-1-git-send-email-jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an RFC for clipboard access controls in Android. I still need to do non-SELinux system guards and check for permission when onPrimaryClipChanged() sends notifications to apps listening for clipboard updates. 

Change-Id: Ib0b6aeca59511ce71832aee1afd4150d1514a63c
---
 .../java/com/android/server/ClipboardService.java  |   25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/services/java/com/android/server/ClipboardService.java b/services/java/com/android/server/ClipboardService.java
index 8a6a550..5908224 100644
--- a/services/java/com/android/server/ClipboardService.java
+++ b/services/java/com/android/server/ClipboardService.java
@@ -36,6 +36,7 @@ import android.os.Parcel;
 import android.os.Process;
 import android.os.RemoteCallbackList;
 import android.os.RemoteException;
+import android.os.SELinux;
 import android.os.UserId;
 import android.util.Pair;
 import android.util.Slog;
@@ -62,6 +63,7 @@ public class ClipboardService extends IClipboard.Stub {
                 = new RemoteCallbackList<IOnPrimaryClipChangedListener>();
 
         ClipData primaryClip;
+        String securityLabel;
 
         final HashSet<String> activePermissionOwners
                 = new HashSet<String>();
@@ -145,6 +147,8 @@ public class ClipboardService extends IClipboard.Stub {
             clearActiveOwnersLocked();
             PerUserClipboard clipboard = getClipboard();
             clipboard.primaryClip = clip;
+            clipboard.securityLabel = SELinux.getPidContext(Binder.getCallingPid());
+            Slog.i(TAG, "Got clip for securityLabel=" + clipboard.securityLabel);
             final int n = clipboard.primaryClipListeners.beginBroadcast();
             for (int i = 0; i < n; i++) {
                 try {
@@ -162,6 +166,12 @@ public class ClipboardService extends IClipboard.Stub {
     public ClipData getPrimaryClip(String pkg) {
         synchronized (this) {
             addActiveOwnerLocked(Binder.getCallingUid(), pkg);
+
+            // Did not add this to addActiveOwnerLocked because throwing an exception
+            // for an SELinux violation kills the app and is generally not desirable 
+            if (!checkSELinuxAccess())
+                return null;
+
             return getClipboard().primaryClip;
         }
     }
@@ -169,12 +179,18 @@ public class ClipboardService extends IClipboard.Stub {
     public ClipDescription getPrimaryClipDescription() {
         synchronized (this) {
             PerUserClipboard clipboard = getClipboard();
+
+            if (!checkSELinuxAccess())
+                return null;
+
             return clipboard.primaryClip != null ? clipboard.primaryClip.getDescription() : null;
         }
     }
 
     public boolean hasPrimaryClip() {
         synchronized (this) {
+            if (!checkSELinuxAccess())
+                return false;
             return getClipboard().primaryClip != null;
         }
     }
@@ -193,6 +209,8 @@ public class ClipboardService extends IClipboard.Stub {
 
     public boolean hasClipboardText() {
         synchronized (this) {
+            if (!checkSELinuxAccess())
+                return false;
             PerUserClipboard clipboard = getClipboard();
             if (clipboard.primaryClip != null) {
                 CharSequence text = clipboard.primaryClip.getItemAt(0).getText();
@@ -308,4 +326,11 @@ public class ClipboardService extends IClipboard.Stub {
             revokeItemLocked(clipboard.primaryClip.getItemAt(i));
         }
     }
+
+    private final boolean checkSELinuxAccess() {
+            String securityLabel = SELinux.getPidContext(Binder.getCallingPid());
+            Slog.i(TAG, "Get clip for securityLabel=" + securityLabel);
+            return SELinux.checkSELinuxAccess(securityLabel, getClipboard().securityLabel, "x_application_data", "paste");
+    }
+
 }
-- 
1.7.9.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
