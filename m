Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5KFwFNn011795
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2012 11:58:16 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <jbrindle@tresys.com>
Subject: [PATCH external/sepolicy] Add selinux network script to policy
Date: Wed, 20 Jun 2012 11:58:01 -0400
Message-Id: <1340207887-30359-1-git-send-email-jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Joshua Brindle <jbrindle@tresys.com>

Signed-off-by: Joshua Brindle <jbrindle@tresys.com>
---
 Android.mk         |   13 +++++++++++++
 selinux-network.sh |   18 ++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100755 selinux-network.sh

diff --git a/Android.mk b/Android.mk
index 68f4c69..002a656 100644
--- a/Android.mk
+++ b/Android.mk
@@ -85,4 +85,17 @@ $(property_contexts): $(LOCAL_PATH)/property_contexts $(LOCAL_POLICY_PC)
 property_contexts :=
 ##################################
 
+##################################
+include $(CLEAR_VARS)
+
+LOCAL_MODULE := selinux-network.sh
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
diff --git a/selinux-network.sh b/selinux-network.sh
new file mode 100755
index 0000000..7d38623
--- /dev/null
+++ b/selinux-network.sh
@@ -0,0 +1,18 @@
+#!/system/bin/sh
+
+IPTABLES="/system/bin/iptables"
+
+#$IPTABLES -t security -A INPUT -i wlan0 -j SECMARK --selctx u:object_r:packet:s0
+#$IPTABLES -t security -A INPUT -i lo -j SECMARK --selctx u:object_r:lo_packet:s0
+#$IPTABLES -t security -A INPUT -i ppp0 -j SECMARK --selctx u:object_r:ppp0_packet:s0
+#$IPTABLES -t security -A INPUT -i ppp1 -j SECMARK --selctx u:object_r:ppp1_packet:s0
+#$IPTABLES -t security -A INPUT -i ppp2 -j SECMARK --selctx u:object_r:ppp2_packet:s0
+#$IPTABLES -t security -A INPUT -i ppp3 -j SECMARK --selctx u:object_r:ppp3_packet:s0
+
+#$IPTABLES -t security -A OUTPUT -o wlan0 -j SECMARK --selctx u:object_r:packet:s0
+#$IPTABLES -t security -A OUTPUT -o lo -j SECMARK --selctx u:object_r:lo_packet:s0
+#$IPTABLES -t security -A OUTPUT -o ppp0 -j SECMARK --selctx u:object_r:ppp0_packet:s0
+#$IPTABLES -t security -A OUTPUT -o ppp1 -j SECMARK --selctx u:object_r:ppp1_packet:s0
+#$IPTABLES -t security -A OUTPUT -o ppp2 -j SECMARK --selctx u:object_r:ppp2_packet:s0
+#$IPTABLES -t security -A OUTPUT -o ppp3 -j SECMARK --selctx u:object_r:ppp3_packet:s0
+
-- 
1.7.9.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
