Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6ILUIbT023322
	for <selinux@tycho.nsa.gov>; Wed, 18 Jul 2012 17:30:22 -0400
Received: by yenl3 with SMTP id l3so2215332yen.12
        for <selinux@tycho.nsa.gov>; Wed, 18 Jul 2012 14:30:20 -0700 (PDT)
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Cc: William Roberts <w.roberts@sta.samsung.com>
Subject: [PATCH] Initial support for translatable SEAndroid strings
Date: Wed, 18 Jul 2012 14:29:38 -0700
Message-Id: <1342646978-8919-2-git-send-email-w.roberts@sta.samsung.com>
In-Reply-To: <1342646978-8919-1-git-send-email-w.roberts@sta.samsung.com>
References: <1342646978-8919-1-git-send-email-w.roberts@sta.samsung.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 res/values/strings.xml                           |    5 +++++
 src/com/android/settings/DeviceInfoSettings.java |   14 +++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/res/values/strings.xml b/res/values/strings.xml
index fb70aa2..2d2f028 100644
--- a/res/values/strings.xml
+++ b/res/values/strings.xml
@@ -3785,5 +3785,10 @@ found in the list of installed apps.</string>
     from their cell phone carrier. The use of the string is similar to the string
     "system_update_settings_list_item_title" in this project. [CHAR LIMIT=25] -->
     <string name="additional_system_update_settings_list_item_title">Additional system updates</string>
+    <!-- SELinux statuses that are displayed if the user has a SE Android enabled
+    device. These are displayed by the settings app in the about section. -->
+    <string name="selinux_status_disabled">"Disabled"</string>
+    <string name="selinux_status_permissive">"Permissive"</string>
+    <string name="selinux_status_enforcing">"Enforcing"</string>
 
 </resources>
diff --git a/src/com/android/settings/DeviceInfoSettings.java b/src/com/android/settings/DeviceInfoSettings.java
index c2418b6..a8a5510 100644
--- a/src/com/android/settings/DeviceInfoSettings.java
+++ b/src/com/android/settings/DeviceInfoSettings.java
@@ -55,6 +55,7 @@ public class DeviceInfoSettings extends SettingsPreferenceFragment {
     private static final String KEY_COPYRIGHT = "copyright";
     private static final String KEY_SYSTEM_UPDATE_SETTINGS = "system_update_settings";
     private static final String PROPERTY_URL_SAFETYLEGAL = "ro.url.safetylegal";
+    private static final String PROPERTY_SELINUX_STATUS = "ro.build.selinux";
     private static final String KEY_KERNEL_VERSION = "kernel_version";
     private static final String KEY_BUILD_NUMBER = "build_number";
     private static final String KEY_DEVICE_MODEL = "device_model";
@@ -77,14 +78,21 @@ public class DeviceInfoSettings extends SettingsPreferenceFragment {
         setStringSummary(KEY_DEVICE_MODEL, Build.MODEL + getMsvSuffix());
         setStringSummary(KEY_BUILD_NUMBER, Build.DISPLAY);
         findPreference(KEY_KERNEL_VERSION).setSummary(getFormattedKernelVersion());
+
         if (!SELinux.isSELinuxEnabled()) {
-            setStringSummary(KEY_SELINUX_STATUS, "disabled");
+            String status = getResources().getString(R.string.selinux_status_disabled);
+            setStringSummary(KEY_SELINUX_STATUS, status);
         } else if (!SELinux.isSELinuxEnforced()) {
-            setStringSummary(KEY_SELINUX_STATUS, "permissive");
+            String status = getResources().getString(R.string.selinux_status_permissive);
+            setStringSummary(KEY_SELINUX_STATUS, status);
         } else {
-            setStringSummary(KEY_SELINUX_STATUS, "enforcing");
+            String status = getResources().getString(R.string.selinux_status_enforcing);
+            setStringSummary(KEY_SELINUX_STATUS, status);
         }
 
+        // Remove selinux information if property is not present
+        removePreferenceIfPropertyMissing(getPreferenceScreen(), "selinux_status", PROPERTY_SELINUX_STATUS);
+
         // Remove Safety information preference if PROPERTY_URL_SAFETYLEGAL is not set
         removePreferenceIfPropertyMissing(getPreferenceScreen(), "safetylegal",
                 PROPERTY_URL_SAFETYLEGAL);
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
