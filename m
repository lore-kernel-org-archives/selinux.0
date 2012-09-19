Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8JNQfB8003862
	for <selinux@tycho.nsa.gov>; Wed, 19 Sep 2012 19:26:43 -0400
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <jbrindle@tresys.com>
Subject: [RFC frameworks/base] Initial implementation of colored stripe.
Date: Wed, 19 Sep 2012 19:26:31 -0400
Message-Id: <1348097191-31374-1-git-send-email-jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

To use this there must be a file in /etc/security or /data/system/ called label_trans.xml with contents like:

<trans label="u:r:tresys_app" color="#aaaa0000" translated="Tresys" />
<trans label="u:r:untrusted_app" color="#ff111111" translated="untrusted" />

The label attribute is the SELinux context, and is the longest matched, per TreeMap. I did this so that we would not have to deal with categories, though some smarter way is surely necessary. I was avoiding tokenizing the security context.

There are still many unanswered questions about this. Code to disable fullscreen mode may be required. It seems to work well though, when there is a popup the bar changes to the correct color, including when the notification shade is swiped down. OpenGL games do not appear to be able to render over it and the WindowManager is ultimately trusted since it is part of SystemUI with the input manager.

You'll notice the translated="..." in the XML, that is not yet implemented but the intention is to put it in the top status bar on phones and in the navigation bar on tablets.

Change-Id: Ib4df961a11b7d7dff3455506cf56613bd4f9254d

Signed-off-by: Joshua Brindle <jbrindle@tresys.com>
---
 core/java/android/view/IWindowSession.aidl         |    2 +
 core/java/android/view/WindowManagerPolicy.java    |   10 ++
 .../com/android/internal/statusbar/IStatusBar.aidl |    2 +-
 .../internal/statusbar/IStatusBarService.aidl      |    2 +-
 .../android/systemui/statusbar/BaseStatusBar.java  |  142 +++++++++++++++++++-
 .../android/systemui/statusbar/CommandQueue.java   |    8 +-
 .../systemui/statusbar/phone/PhoneStatusBar.java   |   23 +++-
 .../systemui/statusbar/tablet/TabletStatusBar.java |   23 +++-
 .../internal/policy/impl/PhoneWindowManager.java   |    3 +-
 .../android/server/StatusBarManagerService.java    |    6 +-
 services/java/com/android/server/wm/Session.java   |   10 +-
 .../java/com/android/server/wm/WindowState.java    |    4 +
 .../bridge/android/BridgeWindowSession.java        |    6 +
 13 files changed, 228 insertions(+), 13 deletions(-)

diff --git a/core/java/android/view/IWindowSession.aidl b/core/java/android/view/IWindowSession.aidl
index d4a03ce..89c016e 100644
--- a/core/java/android/view/IWindowSession.aidl
+++ b/core/java/android/view/IWindowSession.aidl
@@ -120,6 +120,8 @@ interface IWindowSession {
      */
     void getDisplayFrame(IWindow window, out Rect outDisplayFrame);
     
+    String getSecurityLabel();
+
     void finishDrawing(IWindow window);
     
     void setInTouchMode(boolean showFocus);
diff --git a/core/java/android/view/WindowManagerPolicy.java b/core/java/android/view/WindowManagerPolicy.java
index 09948b8..4aeff55 100644
--- a/core/java/android/view/WindowManagerPolicy.java
+++ b/core/java/android/view/WindowManagerPolicy.java
@@ -25,6 +25,7 @@ import android.os.IBinder;
 import android.os.LocalPowerManager;
 import android.os.Looper;
 import android.view.animation.Animation;
+import android.view.IWindowSession;
 
 import java.io.PrintWriter;
 
@@ -339,6 +340,15 @@ public interface WindowManagerPolicy {
          * Check whether the process hosting this window is currently alive.
          */
         public boolean isAlive();
+
+        /**
+         * Return the session for the application (actually activity) that owns
+         * this window.
+         *
+         * @return An IWindowSession identifying the owning activity.
+         */
+        public IWindowSession getSession();
+
     }
 
     /**
diff --git a/core/java/com/android/internal/statusbar/IStatusBar.aidl b/core/java/com/android/internal/statusbar/IStatusBar.aidl
index 294d4c4..14f210c 100644
--- a/core/java/com/android/internal/statusbar/IStatusBar.aidl
+++ b/core/java/com/android/internal/statusbar/IStatusBar.aidl
@@ -31,7 +31,7 @@ oneway interface IStatusBar
     void animateExpand();
     void animateCollapse();
     void setSystemUiVisibility(int vis, int mask);
-    void topAppWindowChanged(boolean menuVisible);
+    void topAppWindowChanged(boolean menuVisible, String securityLabel);
     void setImeWindowStatus(in IBinder token, int vis, int backDisposition);
     void setHardKeyboardStatus(boolean available, boolean enabled);
     void toggleRecentApps();
diff --git a/core/java/com/android/internal/statusbar/IStatusBarService.aidl b/core/java/com/android/internal/statusbar/IStatusBarService.aidl
index c64f170..1f9bc78 100644
--- a/core/java/com/android/internal/statusbar/IStatusBarService.aidl
+++ b/core/java/com/android/internal/statusbar/IStatusBarService.aidl
@@ -30,7 +30,7 @@ interface IStatusBarService
     void setIcon(String slot, String iconPackage, int iconId, int iconLevel, String contentDescription);
     void setIconVisibility(String slot, boolean visible);
     void removeIcon(String slot);
-    void topAppWindowChanged(boolean menuVisible);
+    void topAppWindowChanged(boolean menuVisible, String securityLabel);
     void setImeWindowStatus(in IBinder token, int vis, int backDisposition);
 
     // ---- Methods below are for use by the status bar policy services ----
diff --git a/packages/SystemUI/src/com/android/systemui/statusbar/BaseStatusBar.java b/packages/SystemUI/src/com/android/systemui/statusbar/BaseStatusBar.java
index 1204a89..90ddef6 100644
--- a/packages/SystemUI/src/com/android/systemui/statusbar/BaseStatusBar.java
+++ b/packages/SystemUI/src/com/android/systemui/statusbar/BaseStatusBar.java
@@ -16,7 +16,14 @@
 
 package com.android.systemui.statusbar;
 
+import java.io.FileNotFoundException;
+import java.io.IOException;
+import java.io.File;
+import java.io.FileReader;
 import java.util.ArrayList;
+import java.util.HashMap;
+import java.util.HashSet;
+import java.util.TreeMap;
 
 import android.app.ActivityManagerNative;
 import android.app.KeyguardManager;
@@ -27,9 +34,11 @@ import android.content.Intent;
 import android.content.pm.ApplicationInfo;
 import android.content.pm.PackageManager.NameNotFoundException;
 import android.database.ContentObserver;
+import android.graphics.Color;
 import android.graphics.Rect;
 import android.net.Uri;
 import android.os.Build;
+import android.os.Environment;
 import android.os.Handler;
 import android.os.IBinder;
 import android.os.Message;
@@ -39,6 +48,7 @@ import android.provider.Settings;
 import android.text.TextUtils;
 import android.util.Log;
 import android.util.Slog;
+import android.util.Xml;
 import android.view.Display;
 import android.view.IWindowManager;
 import android.view.LayoutInflater;
@@ -58,6 +68,7 @@ import com.android.internal.statusbar.IStatusBarService;
 import com.android.internal.statusbar.StatusBarIcon;
 import com.android.internal.statusbar.StatusBarIconList;
 import com.android.internal.statusbar.StatusBarNotification;
+import com.android.internal.util.XmlUtils;
 import com.android.internal.widget.SizeAdaptiveLayout;
 import com.android.systemui.SearchPanelView;
 import com.android.systemui.SystemUI;
@@ -70,6 +81,9 @@ import com.android.systemui.statusbar.policy.NotificationRowLayout;
 import com.android.systemui.statusbar.tablet.StatusBarPanel;
 
 import com.android.systemui.R;
+import org.xmlpull.v1.XmlPullParserException;
+import org.xmlpull.v1.XmlSerializer;
+import org.xmlpull.v1.XmlPullParser;
 
 public abstract class BaseStatusBar extends SystemUI implements
     CommandQueue.Callbacks, RecentsPanelView.OnRecentsPanelVisibilityChangedListener {
@@ -115,6 +129,11 @@ public abstract class BaseStatusBar extends SystemUI implements
 
     protected PopupMenu mNotificationBlamePopup;
 
+    // Security label translation
+    protected Boolean mIsLabelTransEnabled = false;
+    protected TreeMap<String, LabelTrans> mLabelTrans =
+            new TreeMap<String, LabelTrans>();
+
     // UI-specific methods
 
     /**
@@ -218,7 +237,7 @@ public abstract class BaseStatusBar extends SystemUI implements
 
         disable(switches[0]);
         setSystemUiVisibility(switches[1], 0xffffffff);
-        topAppWindowChanged(switches[2] != 0);
+        topAppWindowChanged(switches[2] != 0, null);
         // StatusBarManagerService has a back up of IME token and it's restored here.
         setImeWindowStatus(binders.get(0), switches[3], switches[4]);
         setHardKeyboardStatus(switches[5] != 0, switches[6] != 0);
@@ -255,6 +274,11 @@ public abstract class BaseStatusBar extends SystemUI implements
                    switches[3]
                    ));
         }
+
+        if (!loadLabelTrans()) {
+            Slog.d(TAG, "Loading translations failed");
+        }
+
     }
 
     protected View updateNotificationVetoButton(View row, StatusBarNotification n) {
@@ -962,4 +986,120 @@ public abstract class BaseStatusBar extends SystemUI implements
         KeyguardManager km = (KeyguardManager) mContext.getSystemService(Context.KEYGUARD_SERVICE);
         return km.inKeyguardRestrictedInputMode();
     }
+
+    boolean loadLabelTrans() {
+        File dataDir = Environment.getDataDirectory();
+        File rootDir = Environment.getRootDirectory();
+
+        File[] transFileLocations = new File[]{
+            new File(dataDir, "system/label_trans.xml"),
+            new File(rootDir, "etc/security/label_trans.xml"),
+            null};
+
+        FileReader transFile = null;
+        int i = 0;
+        while (transFile == null && transFileLocations[i] != null) {
+            try {
+                transFile = new FileReader(transFileLocations[i]);
+                break;
+            } catch (FileNotFoundException e) {
+                Slog.d(TAG,"Couldn't find translation file " + transFileLocations[i]);
+            }
+            i++;
+        }
+
+        if (transFile == null) {
+            Slog.d(TAG, "No label_trans.xml file.");
+            return false;
+        }
+
+        Slog.d(TAG, "Loading translations from " + transFileLocations[i]);
+
+        try {
+            XmlPullParser parser = Xml.newPullParser();
+            parser.setInput(transFile);
+
+            XmlUtils.beginDocument(parser, "translations");
+            int eventType = parser.getEventType();
+            String tagName;
+
+            while ((eventType = parser.getEventType()) != XmlPullParser.END_DOCUMENT) {
+                if (eventType == XmlPullParser.START_TAG) {
+                    tagName = parser.getName();
+                    //parser.next();
+                } else {
+                    XmlUtils.nextElement(parser);
+                    continue;
+                }
+                if ("trans".equals(tagName)) {
+                    String label = parser.getAttributeValue(null, "label");
+                    if (label == null) {
+                        Slog.w(TAG, "<trans> without label at "
+                               + parser.getPositionDescription() + ". Skipping tag.");
+                        XmlUtils.skipCurrentTag(parser);
+                        continue;
+                    }
+
+                    LabelTrans newTrans = new LabelTrans();
+                    String colorString = parser.getAttributeValue(null, "color");
+                    newTrans.translated = parser.getAttributeValue(null, "translated");
+                    if (colorString == null && newTrans.translated == null) {
+                        Slog.w(TAG, "<trans> without color or translation"
+                               + parser.getPositionDescription() + ". Skipping tag.");
+                        XmlUtils.skipCurrentTag(parser);
+                    }
+
+                    if (colorString == null) {
+                        newTrans.color = Color.parseColor("black");
+                    } else {
+                        try {
+                            int color = Color.parseColor(colorString);
+                            newTrans.color = color;
+                        } catch (IllegalArgumentException e) {
+                            Slog.e(TAG, "Invalid Color " + colorString + " skipping tag: " +
+                                        parser.getPositionDescription());
+                            XmlUtils.skipCurrentTag(parser);
+                        }
+                    }
+                    mLabelTrans.put(label, newTrans);
+                    Slog.d(TAG, "Added translation for " + label + " to color " + newTrans.color + " translation " + newTrans.translated);
+                } else {
+                    Slog.w(TAG, "unknown translation tag " + tagName + " "
+                           + parser.getPositionDescription() + ". Skipping tag." + eventType + " eventType");
+                }
+		XmlUtils.nextElement(parser);
+            }
+        } catch (XmlPullParserException e) {
+            // how to handle the extreme cases....most likely kill all policy
+            // but what if a policy is not already in place..
+            Slog.w(TAG, "Got exception parsing label_trans.xml." + e);
+            return false;
+        } catch (IOException e) {
+            // how to handle the extreme cases....
+            Slog.w(TAG, "Got exception parsing label_trans.xml." + e);
+            return false;
+        }
+
+    Slog.d(TAG, "Label translation enabled.");
+    mIsLabelTransEnabled = true;
+
+    return true;
+    }
+
+    public class LabelTrans
+    {
+      public String translated;
+      public int color;
+
+      LabelTrans() {
+          this.translated = null;
+          this.color = -1;
+      }
+
+      LabelTrans(String translated, int color) {
+          this.translated = translated;
+          this.color = color;
+      }
+    }
+
 }
diff --git a/packages/SystemUI/src/com/android/systemui/statusbar/CommandQueue.java b/packages/SystemUI/src/com/android/systemui/statusbar/CommandQueue.java
index a00d95a..4ba11e5 100644
--- a/packages/SystemUI/src/com/android/systemui/statusbar/CommandQueue.java
+++ b/packages/SystemUI/src/com/android/systemui/statusbar/CommandQueue.java
@@ -97,7 +97,7 @@ public class CommandQueue extends IStatusBar.Stub {
         public void animateExpand();
         public void animateCollapse(int flags);
         public void setSystemUiVisibility(int vis, int mask);
-        public void topAppWindowChanged(boolean visible);
+        public void topAppWindowChanged(boolean visible, String securityLabel);
         public void setImeWindowStatus(IBinder token, int vis, int backDisposition);
         public void setHardKeyboardStatus(boolean available, boolean enabled);
         public void toggleRecentApps();
@@ -185,11 +185,11 @@ public class CommandQueue extends IStatusBar.Stub {
         }
     }
 
-    public void topAppWindowChanged(boolean menuVisible) {
+    public void topAppWindowChanged(boolean menuVisible, String securityLabel) {
         synchronized (mList) {
             mHandler.removeMessages(MSG_TOP_APP_WINDOW_CHANGED);
             mHandler.obtainMessage(MSG_TOP_APP_WINDOW_CHANGED, menuVisible ? 1 : 0, 0,
-                    null).sendToTarget();
+                    securityLabel).sendToTarget();
         }
     }
 
@@ -295,7 +295,7 @@ public class CommandQueue extends IStatusBar.Stub {
                     mCallbacks.setSystemUiVisibility(msg.arg1, msg.arg2);
                     break;
                 case MSG_TOP_APP_WINDOW_CHANGED:
-                    mCallbacks.topAppWindowChanged(msg.arg1 != 0);
+                    mCallbacks.topAppWindowChanged(msg.arg1 != 0, (String)msg.obj);
                     break;
                 case MSG_SHOW_IME_BUTTON:
                     mCallbacks.setImeWindowStatus((IBinder)msg.obj, msg.arg1, msg.arg2);
diff --git a/packages/SystemUI/src/com/android/systemui/statusbar/phone/PhoneStatusBar.java b/packages/SystemUI/src/com/android/systemui/statusbar/phone/PhoneStatusBar.java
index b9e88a4..65050bd 100644
--- a/packages/SystemUI/src/com/android/systemui/statusbar/phone/PhoneStatusBar.java
+++ b/packages/SystemUI/src/com/android/systemui/statusbar/phone/PhoneStatusBar.java
@@ -35,6 +35,7 @@ import android.content.IntentFilter;
 import android.content.res.Configuration;
 import android.content.res.Resources;
 import android.graphics.Canvas;
+import android.graphics.Color;
 import android.graphics.ColorFilter;
 import android.graphics.PixelFormat;
 import android.graphics.PorterDuff;
@@ -94,6 +95,7 @@ import com.android.systemui.statusbar.policy.NotificationRowLayout;
 import java.io.FileDescriptor;
 import java.io.PrintWriter;
 import java.util.ArrayList;
+import java.util.Map;
 
 public class PhoneStatusBar extends BaseStatusBar {
     static final String TAG = "PhoneStatusBar";
@@ -1764,16 +1766,35 @@ public class PhoneStatusBar extends BaseStatusBar {
         }
     }
 
-    public void topAppWindowChanged(boolean showMenu) {
+    public void topAppWindowChanged(boolean showMenu, String securityLabel) {
         if (DEBUG) {
             Slog.d(TAG, (showMenu?"showing":"hiding") + " the MENU button");
         }
+
         if (mNavigationBarView != null) {
             mNavigationBarView.setMenuVisibility(showMenu);
         }
 
         // See above re: lights-out policy for legacy apps.
         if (showMenu) setLightsOn(true);
+
+        if (!mIsLabelTransEnabled)
+            return;
+
+        Slog.d(TAG, "SecurityLabel is " + securityLabel);
+
+        Map.Entry <String, LabelTrans> trans = mLabelTrans.floorEntry(securityLabel);
+        if (trans == null) {
+            int color = Color.parseColor("black");
+            Slog.e(TAG, "Found no translated label for " + securityLabel);
+            mNavigationBarView.setBackgroundColor(color);
+            mStatusBarView.setBackgroundColor(color);
+        } else {
+            Slog.e(TAG, "Found color: " + trans.getValue().color + " translated: " + trans.getValue().translated + " for " + securityLabel);
+            mNavigationBarView.setBackgroundColor(trans.getValue().color);
+            mStatusBarView.setBackgroundColor(trans.getValue().color);
+        }
+
     }
 
     @Override
diff --git a/packages/SystemUI/src/com/android/systemui/statusbar/tablet/TabletStatusBar.java b/packages/SystemUI/src/com/android/systemui/statusbar/tablet/TabletStatusBar.java
index f947369..d57da66 100644
--- a/packages/SystemUI/src/com/android/systemui/statusbar/tablet/TabletStatusBar.java
+++ b/packages/SystemUI/src/com/android/systemui/statusbar/tablet/TabletStatusBar.java
@@ -30,6 +30,7 @@ import android.content.IntentFilter;
 import android.content.SharedPreferences;
 import android.content.res.Configuration;
 import android.content.res.Resources;
+import android.graphics.Color;
 import android.graphics.PixelFormat;
 import android.graphics.Point;
 import android.graphics.drawable.Drawable;
@@ -84,6 +85,7 @@ import com.android.systemui.statusbar.policy.Prefs;
 import java.io.FileDescriptor;
 import java.io.PrintWriter;
 import java.util.ArrayList;
+import java.util.Map;
 
 public class TabletStatusBar extends BaseStatusBar implements
         InputMethodsPanel.OnHardKeyboardEnabledChangeListener,
@@ -189,6 +191,8 @@ public class TabletStatusBar extends BaseStatusBar implements
 
     private int mShowSearchHoldoff = 0;
 
+    private int mCurrentColor = 0;
+
     public Context getContext() { return mContext; }
 
     private Runnable mShowSearchPanel = new Runnable() {
@@ -1111,9 +1115,10 @@ public class TabletStatusBar extends BaseStatusBar implements
         } else {
             setSystemUiVisibility(View.SYSTEM_UI_FLAG_LOW_PROFILE, View.SYSTEM_UI_FLAG_LOW_PROFILE);
         }
+        mStatusBarView.setBackgroundColor(mCurrentColor);
     }
 
-    public void topAppWindowChanged(boolean showMenu) {
+    public void topAppWindowChanged(boolean showMenu, String securityLabel) {
         if (DEBUG) {
             Slog.d(TAG, (showMenu?"showing":"hiding") + " the MENU button");
         }
@@ -1132,6 +1137,22 @@ public class TabletStatusBar extends BaseStatusBar implements
             hideCompatibilityHelp();
             mCompatModePanel.closePanel();
         }
+
+        Slog.d(TAG, "securityLabel is " + securityLabel);
+
+        int color;
+        Map.Entry <String, LabelTrans> trans = mLabelTrans.floorEntry(securityLabel);
+        if (trans == null) {
+            color = Color.parseColor("black");
+            Slog.e(TAG, "Found no security label for " + securityLabel);
+            mCurrentColor = color;
+        } else {
+            color = trans.getValue().color;
+            Slog.d(TAG, "Found color: " + trans.getValue().color + " translated: " + trans.getValue().translated + " for " + securityLabel);
+            mCurrentColor = color;
+        }
+        mStatusBarView.setBackgroundColor(color);
+
     }
 
     private void showCompatibilityHelp() {
diff --git a/policy/src/com/android/internal/policy/impl/PhoneWindowManager.java b/policy/src/com/android/internal/policy/impl/PhoneWindowManager.java
index 25da642..3e235a3 100755
--- a/policy/src/com/android/internal/policy/impl/PhoneWindowManager.java
+++ b/policy/src/com/android/internal/policy/impl/PhoneWindowManager.java
@@ -4377,7 +4377,8 @@ public class PhoneWindowManager implements WindowManagerPolicy {
                         IStatusBarService statusbar = getStatusBarService();
                         if (statusbar != null) {
                             statusbar.setSystemUiVisibility(visibility, 0xffffffff);
-                            statusbar.topAppWindowChanged(needsMenu);
+                            statusbar.topAppWindowChanged(needsMenu, mFocusedWindow.getSession().
+                            		getSecurityLabel());
                         }
                     } catch (RemoteException e) {
                         // re-acquire status bar service next time it is needed.
diff --git a/services/java/com/android/server/StatusBarManagerService.java b/services/java/com/android/server/StatusBarManagerService.java
index 78c0c12..21b9f7f 100644
--- a/services/java/com/android/server/StatusBarManagerService.java
+++ b/services/java/com/android/server/StatusBarManagerService.java
@@ -245,18 +245,20 @@ public class StatusBarManagerService extends IStatusBarService.Stub
      * Hide or show the on-screen Menu key. Only call this from the window manager, typically in
      * response to a window with FLAG_NEEDS_MENU_KEY set.
      */
-    public void topAppWindowChanged(final boolean menuVisible) {
+    public void topAppWindowChanged(final boolean menuVisible, final String securityLabel) {
         enforceStatusBar();
 
         if (SPEW) Slog.d(TAG, (menuVisible?"showing":"hiding") + " MENU key");
 
+        Slog.d(TAG, "securityLabel is " + securityLabel);
+
         synchronized(mLock) {
             mMenuVisible = menuVisible;
             mHandler.post(new Runnable() {
                     public void run() {
                         if (mBar != null) {
                             try {
-                                mBar.topAppWindowChanged(menuVisible);
+                                mBar.topAppWindowChanged(menuVisible, securityLabel);
                             } catch (RemoteException ex) {
                             }
                         }
diff --git a/services/java/com/android/server/wm/Session.java b/services/java/com/android/server/wm/Session.java
index 61c0e9c..d52cdac 100644
--- a/services/java/com/android/server/wm/Session.java
+++ b/services/java/com/android/server/wm/Session.java
@@ -31,6 +31,7 @@ import android.os.Bundle;
 import android.os.IBinder;
 import android.os.Parcel;
 import android.os.RemoteException;
+import android.os.SELinux;
 import android.os.ServiceManager;
 import android.util.Slog;
 import android.view.IWindow;
@@ -53,6 +54,7 @@ final class Session extends IWindowSession.Stub
     final IInputContext mInputContext;
     final int mUid;
     final int mPid;
+    final String mSecurityLabel;
     final String mStringName;
     SurfaceSession mSurfaceSession;
     int mNumWindow = 0;
@@ -65,6 +67,7 @@ final class Session extends IWindowSession.Stub
         mInputContext = inputContext;
         mUid = Binder.getCallingUid();
         mPid = Binder.getCallingPid();
+        mSecurityLabel = SELinux.getPidContext(mPid);
         StringBuilder sb = new StringBuilder();
         sb.append("Session{");
         sb.append(Integer.toHexString(System.identityHashCode(this)));
@@ -204,6 +207,10 @@ final class Session extends IWindowSession.Stub
         }
     }
 
+    public String getSecurityLabel() {
+        return mSecurityLabel;
+    }
+
     public boolean performHapticFeedback(IWindow window, int effectId,
             boolean always) {
         synchronized(mService.mWindowMap) {
@@ -437,4 +444,5 @@ final class Session extends IWindowSession.Stub
     public String toString() {
         return mStringName;
     }
-}
\ No newline at end of file
+}
+
diff --git a/services/java/com/android/server/wm/WindowState.java b/services/java/com/android/server/wm/WindowState.java
index a00e8a5..f799eee 100644
--- a/services/java/com/android/server/wm/WindowState.java
+++ b/services/java/com/android/server/wm/WindowState.java
@@ -541,6 +541,10 @@ final class WindowState implements WindowManagerPolicy.WindowState {
         return mAttrs;
     }
 
+    public Session getSession() {
+        return mSession;
+    }
+
     public boolean getNeedsMenuLw(WindowManagerPolicy.WindowState bottom) {
         int index = -1;
         WindowState ws = this;
diff --git a/tools/layoutlib/bridge/src/com/android/layoutlib/bridge/android/BridgeWindowSession.java b/tools/layoutlib/bridge/src/com/android/layoutlib/bridge/android/BridgeWindowSession.java
index 6fb599d..b20f10d 100644
--- a/tools/layoutlib/bridge/src/com/android/layoutlib/bridge/android/BridgeWindowSession.java
+++ b/tools/layoutlib/bridge/src/com/android/layoutlib/bridge/android/BridgeWindowSession.java
@@ -91,6 +91,12 @@ public final class BridgeWindowSession implements IWindowSession {
     }
 
     @Override
+    public String getSecurityLabel() {
+        // pass for now.
+	return "";
+    }
+
+    @Override
     public void remove(IWindow arg0) throws RemoteException {
         // pass for now.
     }
-- 
1.7.9.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
