Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7GHtmk6015143
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2012 13:55:48 -0400
Received: by yhp3 with SMTP id 3so3455777yhp.12
        for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2012 10:55:46 -0700 (PDT)
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Cc: William Roberts <w.roberts@sta.samsung.com>
Subject: [PATCH] per device seapp_context support
Date: Thu, 16 Aug 2012 10:55:05 -0700
Message-Id: <1345139705-1337-1-git-send-email-w.roberts@sta.samsung.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 Android.mk |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Android.mk b/Android.mk
index 119c6ef..5eb3925 100644
--- a/Android.mk
+++ b/Android.mk
@@ -20,6 +20,7 @@ LOCAL_POLICY_FS_USE := $(wildcard $(addsuffix sepolicy.fs_use, $(LOCAL_POLICY_DI
 LOCAL_POLICY_PORT_CONTEXTS := $(wildcard $(addsuffix sepolicy.port_contexts, $(LOCAL_POLICY_DIRS)))
 LOCAL_POLICY_GENFS_CONTEXTS := $(wildcard $(addsuffix sepolicy.genfs_contexts, $(LOCAL_POLICY_DIRS)))
 LOCAL_POLICY_INITIAL_SID_CONTEXTS := $(wildcard $(addsuffix sepolicy.initial_sid_contexts, $(LOCAL_POLICY_DIRS)))
+LOCAL_POLICY_SC := $(wildcard $(addsuffix seapp_contexts, $(LOCAL_POLICY_DIRS)))
 
 ##################################
 include $(CLEAR_VARS)
@@ -60,16 +61,22 @@ $(file_contexts): $(LOCAL_PATH)/file_contexts $(LOCAL_POLICY_FC)
 	$(hide) m4 -s $^ > $@
 
 file_contexts :=
+
 ##################################
 include $(CLEAR_VARS)
-
 LOCAL_MODULE := seapp_contexts
-LOCAL_SRC_FILES := $(LOCAL_MODULE)
 LOCAL_MODULE_CLASS := ETC
 LOCAL_MODULE_TAGS := optional
 LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)
 
-include $(BUILD_PREBUILT)
+include $(BUILD_SYSTEM)/base_rules.mk
+
+seapp_contexts := $(intermediates)/seapp_contexts
+$(seapp_contexts): $(LOCAL_PATH)/seapp_contexts $(LOCAL_POLICY_SC)
+	@mkdir -p $(dir $@)
+	$(hide) m4 -s $^ > $@
+
+seapp_contexts :=
 
 ##################################
 include $(CLEAR_VARS)
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
