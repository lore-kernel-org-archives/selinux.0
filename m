From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, hqjiang1988@gmail.com
Cc: William Roberts <bill.c.roberts@gmail.com>
Subject: [PATCH] Support for ocontexts per device.
Date: Wed, 11 Jul 2012 16:46:38 -0700
Message-Id: <1342050398-11896-1-git-send-email-bill.c.roberts@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ocontexts was split up into 4 files:
1.fs_use
2.genfs_contexts
3.initial_sid_contexts
4.port_contexts

Each file has their respective declerations in them.
Devices, in their respective device directory, can now specify sepolicy.fs_use, sepolicy.genfs_contexts, sepolicy.port_contexts, and sepolicy.initial_sid_contexts. These declerations will be added right behind their respective sepolicy counterparts in the concatenated configuration file.
---
 Android.mk           |    6 ++++-
 fs_use               |   21 ++++++++++++++++
 genfs_contexts       |   14 ++++++++++
 initial_sid_contexts |   27 ++++++++++++++++++++
 ocontexts            |   66 --------------------------------------------------
 port_contexts        |    3 ++
 6 files changed, 70 insertions(+), 67 deletions(-)
 create mode 100644 fs_use
 create mode 100644 genfs_contexts
 create mode 100644 initial_sid_contexts
 delete mode 100644 ocontexts
 create mode 100644 port_contexts

diff --git a/Android.mk b/Android.mk
index 002a656..190ec34 100644
--- a/Android.mk
+++ b/Android.mk
@@ -16,6 +16,10 @@ LOCAL_POLICY_DIRS := $(SRC_TARGET_DIR)/board/$(TARGET_DEVICE)/ device/*/$(TARGET
 LOCAL_POLICY_FC := $(wildcard $(addsuffix sepolicy.fc, $(LOCAL_POLICY_DIRS)))
 LOCAL_POLICY_TE := $(wildcard $(addsuffix sepolicy.te, $(LOCAL_POLICY_DIRS)))
 LOCAL_POLICY_PC := $(wildcard $(addsuffix sepolicy.pc, $(LOCAL_POLICY_DIRS)))
+LOCAL_POLICY_FS_USE := $(wildcard $(addsuffix sepolicy.fs_use, $(LOCAL_POLICY_DIRS)))
+LOCAL_POLICY_PORT_CONTEXTS := $(wildcard $(addsuffix sepolicy.port_contexts, $(LOCAL_POLICY_DIRS)))
+LOCAL_POLICY_GENFS_CONTEXTS := $(wildcard $(addsuffix sepolicy.genfs_contexts, $(LOCAL_POLICY_DIRS)))
+LOCAL_POLICY_INITIAL_SID_CONTEXTS := $(wildcard $(addsuffix sepolicy.initial_sid_contexts, $(LOCAL_POLICY_DIRS)))
 
 ##################################
 include $(CLEAR_VARS)
@@ -31,7 +35,7 @@ include $(BUILD_SYSTEM)/base_rules.mk
 sepolicy_policy.conf := $(intermediates)/policy.conf
 $(sepolicy_policy.conf): PRIVATE_MLS_SENS := $(MLS_SENS)
 $(sepolicy_policy.conf): PRIVATE_MLS_CATS := $(MLS_CATS)
-$(sepolicy_policy.conf) : $(wildcard $(addprefix $(LOCAL_PATH)/,security_classes initial_sids access_vectors global_macros mls_macros mls policy_capabilities te_macros attributes *.te) $(LOCAL_POLICY_TE) $(addprefix $(LOCAL_PATH)/, roles users ocontexts))
+$(sepolicy_policy.conf) : $(wildcard $(addprefix $(LOCAL_PATH)/,security_classes initial_sids access_vectors global_macros mls_macros mls policy_capabilities te_macros attributes *.te) $(LOCAL_POLICY_TE) $(addprefix $(LOCAL_PATH)/, roles users initial_sid_contexts) $(LOCAL_POLICY_INITIAL_SID_CONTEXTS) $(addprefix $(LOCAL_PATH)/,fs_use) $(LOCAL_POLICY_FS_USE) $(addprefix $(LOCAL_PATH)/,genfs_contexts) $(LOCAL_POLICY_GENFS_CONTEXTS) $(addprefix $(LOCAL_PATH)/,port_contexts) $(LOCAL_POLICY_PORT_CONTEXTS))
 	@mkdir -p $(dir $@)
 	$(hide) m4 -D mls_num_sens=$(PRIVATE_MLS_SENS) -D mls_num_cats=$(PRIVATE_MLS_CATS) -s $^ > $@
 
diff --git a/fs_use b/fs_use
new file mode 100644
index 0000000..6516046
--- /dev/null
+++ b/fs_use
@@ -0,0 +1,21 @@
+# Label inodes via getxattr.
+fs_use_xattr yaffs2 u:object_r:labeledfs:s0;
+fs_use_xattr jffs2 u:object_r:labeledfs:s0;
+fs_use_xattr ext2 u:object_r:labeledfs:s0;
+fs_use_xattr ext3 u:object_r:labeledfs:s0;
+fs_use_xattr ext4 u:object_r:labeledfs:s0;
+fs_use_xattr xfs u:object_r:labeledfs:s0;
+fs_use_xattr btrfs u:object_r:labeledfs:s0;
+
+# Label inodes from task label.
+fs_use_task pipefs u:object_r:pipefs:s0;
+fs_use_task sockfs u:object_r:sockfs:s0;
+
+# Label inodes from combination of task label and fs label.
+# Define type_transition rules if you want per-domain types.
+fs_use_trans devpts u:object_r:devpts:s0;
+fs_use_trans tmpfs u:object_r:tmpfs:s0;
+fs_use_trans devtmpfs u:object_r:device:s0;
+fs_use_trans shm u:object_r:shm:s0;
+fs_use_trans mqueue u:object_r:mqueue:s0;
+
diff --git a/genfs_contexts b/genfs_contexts
new file mode 100644
index 0000000..103136c
--- /dev/null
+++ b/genfs_contexts
@@ -0,0 +1,14 @@
+# Label inodes with the fs label.
+genfscon rootfs / u:object_r:rootfs:s0
+# proc labeling can be further refined (longest matching prefix).
+genfscon proc / u:object_r:proc:s0
+genfscon proc /net/xt_qtaguid/ctrl u:object_r:qtaguid:s0
+# selinuxfs booleans can be individually labeled.
+genfscon selinuxfs / u:object_r:selinuxfs:s0
+genfscon cgroup / u:object_r:cgroup:s0
+# sysfs labels can be set by userspace.
+genfscon sysfs / u:object_r:sysfs:s0
+genfscon inotifyfs / u:object_r:inotify:s0
+genfscon vfat / u:object_r:sdcard:s0
+genfscon debugfs / u:object_r:debugfs:s0
+genfscon fuse / u:object_r:sdcard:s0
diff --git a/initial_sid_contexts b/initial_sid_contexts
new file mode 100644
index 0000000..a8d2c19
--- /dev/null
+++ b/initial_sid_contexts
@@ -0,0 +1,27 @@
+sid kernel u:r:kernel:s0
+sid security u:object_r:kernel:s0
+sid unlabeled u:object_r:unlabeled:s0
+sid fs u:object_r:labeledfs:s0
+sid file u:object_r:unlabeled:s0
+sid file_labels u:object_r:unlabeled:s0
+sid init u:object_r:unlabeled:s0
+sid any_socket u:object_r:unlabeled:s0
+sid port u:object_r:port:s0
+sid netif u:object_r:netif:s0
+sid netmsg u:object_r:unlabeled:s0
+sid node u:object_r:node:s0
+sid igmp_packet u:object_r:unlabeled:s0
+sid icmp_socket u:object_r:unlabeled:s0
+sid tcp_socket u:object_r:unlabeled:s0
+sid sysctl_modprobe u:object_r:unlabeled:s0
+sid sysctl u:object_r:proc:s0
+sid sysctl_fs u:object_r:unlabeled:s0
+sid sysctl_kernel u:object_r:unlabeled:s0
+sid sysctl_net u:object_r:unlabeled:s0
+sid sysctl_net_unix u:object_r:unlabeled:s0
+sid sysctl_vm u:object_r:unlabeled:s0
+sid sysctl_dev u:object_r:unlabeled:s0
+sid kmod u:object_r:unlabeled:s0
+sid policy u:object_r:unlabeled:s0
+sid scmp_packet u:object_r:unlabeled:s0
+
diff --git a/ocontexts b/ocontexts
deleted file mode 100644
index 7cbb989..0000000
--- a/ocontexts
+++ /dev/null
@@ -1,66 +0,0 @@
-sid kernel u:r:kernel:s0
-sid security u:object_r:kernel:s0
-sid unlabeled u:object_r:unlabeled:s0
-sid fs u:object_r:labeledfs:s0
-sid file u:object_r:unlabeled:s0
-sid file_labels u:object_r:unlabeled:s0
-sid init u:object_r:unlabeled:s0
-sid any_socket u:object_r:unlabeled:s0
-sid port u:object_r:port:s0
-sid netif u:object_r:netif:s0
-sid netmsg u:object_r:unlabeled:s0
-sid node u:object_r:node:s0
-sid igmp_packet u:object_r:unlabeled:s0
-sid icmp_socket u:object_r:unlabeled:s0
-sid tcp_socket u:object_r:unlabeled:s0
-sid sysctl_modprobe u:object_r:unlabeled:s0
-sid sysctl u:object_r:proc:s0
-sid sysctl_fs u:object_r:unlabeled:s0
-sid sysctl_kernel u:object_r:unlabeled:s0
-sid sysctl_net u:object_r:unlabeled:s0
-sid sysctl_net_unix u:object_r:unlabeled:s0
-sid sysctl_vm u:object_r:unlabeled:s0
-sid sysctl_dev u:object_r:unlabeled:s0
-sid kmod u:object_r:unlabeled:s0
-sid policy u:object_r:unlabeled:s0
-sid scmp_packet u:object_r:unlabeled:s0
-sid devnull u:object_r:null_device:s0
-
-# Label inodes via getxattr.
-fs_use_xattr yaffs2 u:object_r:labeledfs:s0;
-fs_use_xattr jffs2 u:object_r:labeledfs:s0;
-fs_use_xattr ext2 u:object_r:labeledfs:s0;
-fs_use_xattr ext3 u:object_r:labeledfs:s0;
-fs_use_xattr ext4 u:object_r:labeledfs:s0;
-fs_use_xattr xfs u:object_r:labeledfs:s0;
-fs_use_xattr btrfs u:object_r:labeledfs:s0;
-
-# Label inodes from task label.
-fs_use_task pipefs u:object_r:pipefs:s0;
-fs_use_task sockfs u:object_r:sockfs:s0;
-
-# Label inodes from combination of task label and fs label.
-# Define type_transition rules if you want per-domain types.
-fs_use_trans devpts u:object_r:devpts:s0;
-fs_use_trans tmpfs u:object_r:tmpfs:s0;
-fs_use_trans devtmpfs u:object_r:device:s0;
-fs_use_trans shm u:object_r:shm:s0;
-fs_use_trans mqueue u:object_r:mqueue:s0;
-
-# Label inodes with the fs label.
-genfscon rootfs / u:object_r:rootfs:s0
-# proc labeling can be further refined (longest matching prefix).
-genfscon proc / u:object_r:proc:s0
-genfscon proc /net/xt_qtaguid/ctrl u:object_r:qtaguid:s0
-# selinuxfs booleans can be individually labeled.
-genfscon selinuxfs / u:object_r:selinuxfs:s0
-genfscon cgroup / u:object_r:cgroup:s0
-# sysfs labels can be set by userspace.
-genfscon sysfs / u:object_r:sysfs:s0
-genfscon inotifyfs / u:object_r:inotify:s0
-genfscon vfat / u:object_r:sdcard:s0
-genfscon debugfs / u:object_r:debugfs:s0
-genfscon fuse / u:object_r:sdcard:s0
-
-# portcon statements go here, e.g.
-# portcon tcp 80 u:object_r:http_port:s0
diff --git a/port_contexts b/port_contexts
new file mode 100644
index 0000000..b473c0c
--- /dev/null
+++ b/port_contexts
@@ -0,0 +1,3 @@
+# portcon statements go here, e.g.
+# portcon tcp 80 u:object_r:http_port:s0
+
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
