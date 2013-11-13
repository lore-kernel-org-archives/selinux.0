From: Dan Walsh <dwalsh@redhat.com>
To: sds@tycho.nsa.gov, eparis@redhat.com
Cc: selinux@tycho.nsa.gov, Dan Walsh <dwalsh@redhat.com>
Subject: [PATCH 01/05] Make sure we do the polkit check on all dbus interfaces.
Date: Wed, 13 Nov 2013 10:38:08 -0500
Message-Id: <1384357088-21451-1-git-send-email-dwalsh@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Change policy kit to only allow access on the console.
---
 policycoreutils/sepolicy/org.selinux.policy | 36 +++++++++++++++--------------
 policycoreutils/sepolicy/selinux_server.py  |  7 +++++-
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/policycoreutils/sepolicy/org.selinux.policy b/policycoreutils/sepolicy/org.selinux.policy
index c0a730c..44ae625 100644
--- a/policycoreutils/sepolicy/org.selinux.policy
+++ b/policycoreutils/sepolicy/org.selinux.policy
@@ -11,8 +11,8 @@
         <description>SELinux write access</description>
         <message>System policy prevents restorecon access to SELinux</message>
         <defaults>
-            <allow_any>auth_admin_keep</allow_any>
-            <allow_inactive>auth_admin_keep</allow_inactive>
+            <allow_any>no</allow_any>
+            <allow_inactive>no</allow_inactive>
             <allow_active>auth_admin_keep</allow_active>
         </defaults>
     </action>
@@ -20,8 +20,8 @@
         <description>SELinux write access</description>
         <message>System policy prevents setenforce access to SELinux</message>
         <defaults>
-            <allow_any>auth_admin_keep</allow_any>
-            <allow_inactive>auth_admin_keep</allow_inactive>
+            <allow_any>no</allow_any>
+            <allow_inactive>no</allow_inactive>
             <allow_active>auth_admin_keep</allow_active>
         </defaults>
     </action>
@@ -29,8 +29,8 @@
         <description>SELinux write access</description>
         <message>System policy prevents semanage access to SELinux</message>
         <defaults>
-            <allow_any>auth_admin_keep</allow_any>
-            <allow_inactive>auth_admin_keep</allow_inactive>
+            <allow_any>no</allow_any>
+            <allow_inactive>no</allow_inactive>
             <allow_active>auth_admin_keep</allow_active>
         </defaults>
     </action>
@@ -38,8 +38,8 @@
         <description>SELinux Read access</description>
         <message>System policy prevents read access to SELinux</message>
         <defaults>
-	  <allow_any>yes</allow_any>
-	  <allow_inactive>yes</allow_inactive>
+          <allow_any>no</allow_any>
+          <allow_inactive>no</allow_inactive>
 	  <allow_active>yes</allow_active>
         </defaults>
     </action>
@@ -47,8 +47,8 @@
         <description>SELinux list modules access</description>
         <message>System policy prevents read access to SELinux modules</message>
         <defaults>
-	  <allow_any>yes</allow_any>
-	  <allow_inactive>yes</allow_inactive>
+          <allow_any>no</allow_any>
+          <allow_inactive>no</allow_inactive>
 	  <allow_active>yes</allow_active>
         </defaults>
     </action>
@@ -56,25 +56,27 @@
         <description>SELinux write access</description>
         <message>System policy prevents relabel_on_boot access to SELinux</message>
         <defaults>
-            <allow_any>yes</allow_any>
+          <allow_any>no</allow_any>
+          <allow_inactive>no</allow_inactive>
+	  <allow_active>auth_admin_keep</allow_active>
         </defaults>
     </action>
     <action id="org.selinux.change_default_policy">
         <description>SELinux write access</description>
         <message>System policy prevents change_default_policy access to SELinux</message>
         <defaults>
-            <allow_any>auth_admin_keep</allow_any>
-            <allow_inactive>auth_admin_keep</allow_inactive>
-            <allow_active>auth_admin_keep</allow_active>
+          <allow_any>no</allow_any>
+          <allow_inactive>no</allow_inactive>
+	  <allow_active>auth_admin_keep</allow_active>
         </defaults>
     </action>
     <action id="org.selinux.change_policy_type">
         <description>SELinux write access</description>
         <message>System policy prevents change_policy_type access to SELinux</message>
         <defaults>
-            <allow_any>auth_admin_keep</allow_any>
-            <allow_inactive>auth_admin_keep</allow_inactive>
-            <allow_active>auth_admin_keep</allow_active>
+          <allow_any>no</allow_any>
+          <allow_inactive>no</allow_inactive>
+	  <allow_active>auth_admin_keep</allow_active>
         </defaults>
     </action>
 </policyconfig>
diff --git a/policycoreutils/sepolicy/selinux_server.py b/policycoreutils/sepolicy/selinux_server.py
index 98dbff4..e94c38f 100644
--- a/policycoreutils/sepolicy/selinux_server.py
+++ b/policycoreutils/sepolicy/selinux_server.py
@@ -47,7 +47,7 @@ class selinux_server(slip.dbus.service.Object):
     # The semodule_list method will return the output of semodule -l, using the customized polkit,
     # since this is a readonly behaviour
     #
-    @slip.dbus.polkit.require_auth("org.selinux.customized")
+    @slip.dbus.polkit.require_auth("org.selinux.semodule_list")
     @dbus.service.method("org.selinux", in_signature='', out_signature='s')
     def semodule_list(self):
         p = Popen(["/usr/sbin/semodule", "-l"],stdout=PIPE, stderr=PIPE)
@@ -60,6 +60,7 @@ class selinux_server(slip.dbus.service.Object):
     #
     # The restorecon method modifies any file path to the default system label
     #
+    @slip.dbus.polkit.require_auth("org.selinux.restorecon")
     @dbus.service.method("org.selinux", in_signature='s')
     def restorecon(self, path):
         selinux.restorecon(str(path), recursive=1)
@@ -67,6 +68,7 @@ class selinux_server(slip.dbus.service.Object):
     #
     # The setenforce method turns off the current enforcement of SELinux
     #
+    @slip.dbus.polkit.require_auth("org.selinux.setenforce")
     @dbus.service.method("org.selinux", in_signature='i')
     def setenforce(self, value):
         selinux.security_setenforce(value)
@@ -74,6 +76,7 @@ class selinux_server(slip.dbus.service.Object):
     #
     # The setenforce method turns off the current enforcement of SELinux
     #
+    @slip.dbus.polkit.require_auth("org.selinux.relabel_on_boot")
     @dbus.service.method("org.selinux", in_signature='i')
     def relabel_on_boot(self, value):
         if value == 1:
@@ -103,6 +106,7 @@ class selinux_server(slip.dbus.service.Object):
     #
     # The change_default_enforcement modifies the current enforcement mode
     #
+    @slip.dbus.polkit.require_auth("org.selinux.change_default_mode")
     @dbus.service.method("org.selinux", in_signature='s')
     def change_default_mode(self, value):
         values = [ "enforcing", "permissive", "disabled" ]
@@ -114,6 +118,7 @@ class selinux_server(slip.dbus.service.Object):
     #
     # The change_default_policy method modifies the policy type
     #
+    @slip.dbus.polkit.require_auth("org.selinux.change_default_policy")
     @dbus.service.method("org.selinux", in_signature='s')
     def change_default_policy(self, value):
         path = selinux.selinux_path() + value
-- 
1.8.4.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
