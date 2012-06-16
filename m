Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5GIvsug006847
	for <selinux@tycho.nsa.gov>; Sat, 16 Jun 2012 14:57:54 -0400
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux@tycho.nsa.gov, method@manicmethod.com
Cc: Joshua Brindle <jbrindle@tresys.com>
Subject: [PATCH external/sepolicy] Add iptables script to policy
Date: Sat, 16 Jun 2012 14:56:34 -0400
Message-Id: <1339872999-30243-1-git-send-email-jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Signed-off-by: Joshua Brindle <jbrindle@tresys.com>
---
 Android.mk          |   13 +++++++++++++
 iptables-selinux.sh |   18 ++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100755 iptables-selinux.sh

diff --git a/Android.mk b/Android.mk
index 68f4c69..0b744b0 100644
--- a/Android.mk
+++ b/Android.mk
@@ -85,4 +85,17 @@ $(property_contexts): $(LOCAL_PATH)/property_contexts $(LOCAL_POLICY_PC)
 property_contexts :=
 ##################################
 
+##################################
+include $(CLEAR_VARS)
+
+LOCAL_MODULE := iptables-selinux.sh
+LOCAL_SRC_FILES := $(LOCAL_MODULE)
+LOCAL_MODULE_CLASS := EXECUTABLES
+LOCAL_MODULE_TAGS := optional
+LOCAL_MODULE_PATH := $(TARGET_OUT_EXECUTABLES)
+
+include $(BUILD_PREBUILT)
+
+##################################
+
 endif #ifeq ($(HAVE_SELINUX),true)
diff --git a/iptables-selinux.sh b/iptables-selinux.sh
new file mode 100755
index 0000000..e9ac7d1
--- /dev/null
+++ b/iptables-selinux.sh
@@ -0,0 +1,18 @@
+#!/system/bin/sh
+
+IPTABLES="/system/bin/iptables"
+
+#$IPTABLES -t mangle -A INPUT -i wlan0 -j SECMARK --selctx u:object_r:packet:s0
+#$IPTABLES -t mangle -A INPUT -i lo -j SECMARK --selctx u:object_r:lo_packet:s0
+#$IPTABLES -t mangle -A INPUT -i ppp0 -j SECMARK --selctx u:object_r:ppp0_packet:s0
+#$IPTABLES -t mangle -A INPUT -i ppp1 -j SECMARK --selctx u:object_r:ppp1_packet:s0
+#$IPTABLES -t mangle -A INPUT -i ppp2 -j SECMARK --selctx u:object_r:ppp2_packet:s0
+#$IPTABLES -t mangle -A INPUT -i ppp3 -j SECMARK --selctx u:object_r:ppp3_packet:s0
+
+#$IPTABLES -t mangle -A OUTPUT -o wlan0 -j SECMARK --selctx u:object_r:packet:s0
+#$IPTABLES -t mangle -A OUTPUT -o lo -j SECMARK --selctx u:object_r:lo_packet:s0
+#$IPTABLES -t mangle -A OUTPUT -o ppp0 -j SECMARK --selctx u:object_r:ppp0_packet:s0
+#$IPTABLES -t mangle -A OUTPUT -o ppp1 -j SECMARK --selctx u:object_r:ppp1_packet:s0
+#$IPTABLES -t mangle -A OUTPUT -o ppp2 -j SECMARK --selctx u:object_r:ppp2_packet:s0
+#$IPTABLES -t mangle -A OUTPUT -o ppp3 -j SECMARK --selctx u:object_r:ppp3_packet:s0
+
-- 
1.7.9.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
