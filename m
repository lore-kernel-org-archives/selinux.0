MIME-Version: 1.0
In-Reply-To: <1342049596-11196-1-git-send-email-bill.c.roberts@gmail.com>
References: <1342049596-11196-1-git-send-email-bill.c.roberts@gmail.com>
Date: Wed, 11 Jul 2012 16:38:24 -0700
Message-ID: <CAFftDdoz_Mv7JX0t0LxvDrd6uG-qKb+mQC-3XdDVzpin9px2Bw@mail.gmail.com>
Subject: Re: [PATCH] Support for ocontexts per device.
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, hqjiang1988@gmail.com
Content-Type: multipart/alternative; boundary=f46d042f9eb0ce289f04c49657bc
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d042f9eb0ce289f04c49657bc
Content-Type: text/plain; charset=ISO-8859-1

Disregard the LAST PATCH, it has some clutter in it.

On Wed, Jul 11, 2012 at 4:33 PM, William Roberts
<bill.c.roberts@gmail.com>wrote:

> ocontexts was split up into 4 files:
> 1.fs_use
> 2.genfs_contexts
> 3.initial_sid_contexts
> 4.port_contexts
>
> Each file has their respective declerations in them.
> Devices, in their respective device directory, can now specify
> sepolicy.fs_use, sepolicy.genfs_contexts, sepolicy.port_contexts, and
> sepolicy.initial_sid_contexts. These declerations will be added right
> behind their respective sepolicy counterparts in the concatenated
> configuration file.
> ---
>  Android.mk           |    6 ++++-
>  fs_use               |   21 ++++++++++++++++
>  genfs_contexts       |   14 ++++++++++
>  initial_sid_contexts |   27 ++++++++++++++++++++
>  ocontexts            |   66
> --------------------------------------------------
>  port_contexts        |    3 ++
>  6 files changed, 70 insertions(+), 67 deletions(-)
>  create mode 100644 fs_use
>  create mode 100644 genfs_contexts
>  create mode 100644 initial_sid_contexts
>  delete mode 100644 ocontexts
>  create mode 100644 port_contexts
>
> diff --git a/Android.mk b/Android.mk
> index 002a656..ff46937 100644
> --- a/Android.mk
> +++ b/Android.mk
> @@ -16,6 +16,10 @@ LOCAL_POLICY_DIRS :=
> $(SRC_TARGET_DIR)/board/$(TARGET_DEVICE)/ device/*/$(TARGET
>  LOCAL_POLICY_FC := $(wildcard $(addsuffix sepolicy.fc,
> $(LOCAL_POLICY_DIRS)))
>  LOCAL_POLICY_TE := $(wildcard $(addsuffix sepolicy.te,
> $(LOCAL_POLICY_DIRS)))
>  LOCAL_POLICY_PC := $(wildcard $(addsuffix sepolicy.pc,
> $(LOCAL_POLICY_DIRS)))
> +LOCAL_POLICY_FS_USE := $(wildcard $(addsuffix sepolicy.fs_use,
> $(LOCAL_POLICY_DIRS)))
> +LOCAL_POLICY_PORT_CONTEXTS := $(wildcard $(LOCAL_FUCK))
> +LOCAL_POLICY_GENFS_CONTEXTS := $(wildcard $(addsuffix
> sepolicy.genfscontexts, $(LOCAL_POLICY_DIRS)))
> +LOCAL_POLICY_INITIAL_SID_CONTEXTS := $(wildcard $(addsuffix
> sepolicy.initial_sid_contexts, $(LOCAL_POLICY_DIRS)))
>
>  ##################################
>  include $(CLEAR_VARS)
> @@ -31,7 +35,7 @@ include $(BUILD_SYSTEM)/base_rules.mk
>  sepolicy_policy.conf := $(intermediates)/policy.conf
>  $(sepolicy_policy.conf): PRIVATE_MLS_SENS := $(MLS_SENS)
>  $(sepolicy_policy.conf): PRIVATE_MLS_CATS := $(MLS_CATS)
> -$(sepolicy_policy.conf) : $(wildcard $(addprefix
> $(LOCAL_PATH)/,security_classes initial_sids access_vectors global_macros
> mls_macros mls policy_capabilities te_macros attributes *.te)
> $(LOCAL_POLICY_TE) $(addprefix $(LOCAL_PATH)/, roles users ocontexts))
> +$(sepolicy_policy.conf) : $(wildcard $(addprefix
> $(LOCAL_PATH)/,security_classes initial_sids access_vectors global_macros
> mls_macros mls policy_capabilities te_macros attributes *.te)
> $(LOCAL_POLICY_TE) $(addprefix $(LOCAL_PATH)/, roles users
> initial_sid_contexts) $(LOCAL_POLICY_INITIAL_SID_CONTEXTS) $(addprefix
> $(LOCAL_PATH)/,fs_use) $(LOCAL_POLICY_FS_USE) $(addprefix
> $(LOCAL_PATH)/,genfs_contexts) $(LOCAL_POLICY_GENFS_CONTEXTS) $(addprefix
> $(LOCAL_PATH)/,port_contexts) $(LOCAL_POLICY_PORT_CONTEXTS))
>         @mkdir -p $(dir $@)
>         $(hide) m4 -D mls_num_sens=$(PRIVATE_MLS_SENS) -D
> mls_num_cats=$(PRIVATE_MLS_CATS) -s $^ > $@
>
> diff --git a/fs_use b/fs_use
> new file mode 100644
> index 0000000..6516046
> --- /dev/null
> +++ b/fs_use
> @@ -0,0 +1,21 @@
> +# Label inodes via getxattr.
> +fs_use_xattr yaffs2 u:object_r:labeledfs:s0;
> +fs_use_xattr jffs2 u:object_r:labeledfs:s0;
> +fs_use_xattr ext2 u:object_r:labeledfs:s0;
> +fs_use_xattr ext3 u:object_r:labeledfs:s0;
> +fs_use_xattr ext4 u:object_r:labeledfs:s0;
> +fs_use_xattr xfs u:object_r:labeledfs:s0;
> +fs_use_xattr btrfs u:object_r:labeledfs:s0;
> +
> +# Label inodes from task label.
> +fs_use_task pipefs u:object_r:pipefs:s0;
> +fs_use_task sockfs u:object_r:sockfs:s0;
> +
> +# Label inodes from combination of task label and fs label.
> +# Define type_transition rules if you want per-domain types.
> +fs_use_trans devpts u:object_r:devpts:s0;
> +fs_use_trans tmpfs u:object_r:tmpfs:s0;
> +fs_use_trans devtmpfs u:object_r:device:s0;
> +fs_use_trans shm u:object_r:shm:s0;
> +fs_use_trans mqueue u:object_r:mqueue:s0;
> +
> diff --git a/genfs_contexts b/genfs_contexts
> new file mode 100644
> index 0000000..103136c
> --- /dev/null
> +++ b/genfs_contexts
> @@ -0,0 +1,14 @@
> +# Label inodes with the fs label.
> +genfscon rootfs / u:object_r:rootfs:s0
> +# proc labeling can be further refined (longest matching prefix).
> +genfscon proc / u:object_r:proc:s0
> +genfscon proc /net/xt_qtaguid/ctrl u:object_r:qtaguid:s0
> +# selinuxfs booleans can be individually labeled.
> +genfscon selinuxfs / u:object_r:selinuxfs:s0
> +genfscon cgroup / u:object_r:cgroup:s0
> +# sysfs labels can be set by userspace.
> +genfscon sysfs / u:object_r:sysfs:s0
> +genfscon inotifyfs / u:object_r:inotify:s0
> +genfscon vfat / u:object_r:sdcard:s0
> +genfscon debugfs / u:object_r:debugfs:s0
> +genfscon fuse / u:object_r:sdcard:s0
> diff --git a/initial_sid_contexts b/initial_sid_contexts
> new file mode 100644
> index 0000000..a8d2c19
> --- /dev/null
> +++ b/initial_sid_contexts
> @@ -0,0 +1,27 @@
> +sid kernel u:r:kernel:s0
> +sid security u:object_r:kernel:s0
> +sid unlabeled u:object_r:unlabeled:s0
> +sid fs u:object_r:labeledfs:s0
> +sid file u:object_r:unlabeled:s0
> +sid file_labels u:object_r:unlabeled:s0
> +sid init u:object_r:unlabeled:s0
> +sid any_socket u:object_r:unlabeled:s0
> +sid port u:object_r:port:s0
> +sid netif u:object_r:netif:s0
> +sid netmsg u:object_r:unlabeled:s0
> +sid node u:object_r:node:s0
> +sid igmp_packet u:object_r:unlabeled:s0
> +sid icmp_socket u:object_r:unlabeled:s0
> +sid tcp_socket u:object_r:unlabeled:s0
> +sid sysctl_modprobe u:object_r:unlabeled:s0
> +sid sysctl u:object_r:proc:s0
> +sid sysctl_fs u:object_r:unlabeled:s0
> +sid sysctl_kernel u:object_r:unlabeled:s0
> +sid sysctl_net u:object_r:unlabeled:s0
> +sid sysctl_net_unix u:object_r:unlabeled:s0
> +sid sysctl_vm u:object_r:unlabeled:s0
> +sid sysctl_dev u:object_r:unlabeled:s0
> +sid kmod u:object_r:unlabeled:s0
> +sid policy u:object_r:unlabeled:s0
> +sid scmp_packet u:object_r:unlabeled:s0
> +
> diff --git a/ocontexts b/ocontexts
> deleted file mode 100644
> index 7cbb989..0000000
> --- a/ocontexts
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -sid kernel u:r:kernel:s0
> -sid security u:object_r:kernel:s0
> -sid unlabeled u:object_r:unlabeled:s0
> -sid fs u:object_r:labeledfs:s0
> -sid file u:object_r:unlabeled:s0
> -sid file_labels u:object_r:unlabeled:s0
> -sid init u:object_r:unlabeled:s0
> -sid any_socket u:object_r:unlabeled:s0
> -sid port u:object_r:port:s0
> -sid netif u:object_r:netif:s0
> -sid netmsg u:object_r:unlabeled:s0
> -sid node u:object_r:node:s0
> -sid igmp_packet u:object_r:unlabeled:s0
> -sid icmp_socket u:object_r:unlabeled:s0
> -sid tcp_socket u:object_r:unlabeled:s0
> -sid sysctl_modprobe u:object_r:unlabeled:s0
> -sid sysctl u:object_r:proc:s0
> -sid sysctl_fs u:object_r:unlabeled:s0
> -sid sysctl_kernel u:object_r:unlabeled:s0
> -sid sysctl_net u:object_r:unlabeled:s0
> -sid sysctl_net_unix u:object_r:unlabeled:s0
> -sid sysctl_vm u:object_r:unlabeled:s0
> -sid sysctl_dev u:object_r:unlabeled:s0
> -sid kmod u:object_r:unlabeled:s0
> -sid policy u:object_r:unlabeled:s0
> -sid scmp_packet u:object_r:unlabeled:s0
> -sid devnull u:object_r:null_device:s0
> -
> -# Label inodes via getxattr.
> -fs_use_xattr yaffs2 u:object_r:labeledfs:s0;
> -fs_use_xattr jffs2 u:object_r:labeledfs:s0;
> -fs_use_xattr ext2 u:object_r:labeledfs:s0;
> -fs_use_xattr ext3 u:object_r:labeledfs:s0;
> -fs_use_xattr ext4 u:object_r:labeledfs:s0;
> -fs_use_xattr xfs u:object_r:labeledfs:s0;
> -fs_use_xattr btrfs u:object_r:labeledfs:s0;
> -
> -# Label inodes from task label.
> -fs_use_task pipefs u:object_r:pipefs:s0;
> -fs_use_task sockfs u:object_r:sockfs:s0;
> -
> -# Label inodes from combination of task label and fs label.
> -# Define type_transition rules if you want per-domain types.
> -fs_use_trans devpts u:object_r:devpts:s0;
> -fs_use_trans tmpfs u:object_r:tmpfs:s0;
> -fs_use_trans devtmpfs u:object_r:device:s0;
> -fs_use_trans shm u:object_r:shm:s0;
> -fs_use_trans mqueue u:object_r:mqueue:s0;
> -
> -# Label inodes with the fs label.
> -genfscon rootfs / u:object_r:rootfs:s0
> -# proc labeling can be further refined (longest matching prefix).
> -genfscon proc / u:object_r:proc:s0
> -genfscon proc /net/xt_qtaguid/ctrl u:object_r:qtaguid:s0
> -# selinuxfs booleans can be individually labeled.
> -genfscon selinuxfs / u:object_r:selinuxfs:s0
> -genfscon cgroup / u:object_r:cgroup:s0
> -# sysfs labels can be set by userspace.
> -genfscon sysfs / u:object_r:sysfs:s0
> -genfscon inotifyfs / u:object_r:inotify:s0
> -genfscon vfat / u:object_r:sdcard:s0
> -genfscon debugfs / u:object_r:debugfs:s0
> -genfscon fuse / u:object_r:sdcard:s0
> -
> -# portcon statements go here, e.g.
> -# portcon tcp 80 u:object_r:http_port:s0
> diff --git a/port_contexts b/port_contexts
> new file mode 100644
> index 0000000..b473c0c
> --- /dev/null
> +++ b/port_contexts
> @@ -0,0 +1,3 @@
> +# portcon statements go here, e.g.
> +# portcon tcp 80 u:object_r:http_port:s0
> +
> --
> 1.7.0.4
>
>


-- 
Respectfully,

William C Roberts

--f46d042f9eb0ce289f04c49657bc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Disregard the LAST PATCH, it has some clutter in it.<br><br><div class=3D"g=
mail_quote">On Wed, Jul 11, 2012 at 4:33 PM, William Roberts <span dir=3D"l=
tr">&lt;<a href=3D"mailto:bill.c.roberts@gmail.com" target=3D"_blank">bill.=
c.roberts@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">ocontexts was split up into 4 files:<br>
1.fs_use<br>
2.genfs_contexts<br>
3.initial_sid_contexts<br>
4.port_contexts<br>
<br>
Each file has their respective declerations in them.<br>
Devices, in their respective device directory, can now specify sepolicy.fs_=
use, sepolicy.genfs_contexts, sepolicy.port_contexts, and sepolicy.initial_=
sid_contexts. These declerations will be added right behind their respectiv=
e sepolicy counterparts in the concatenated configuration file.<br>

---<br>
=A0Android.mk =A0 =A0 =A0 =A0 =A0 | =A0 =A06 ++++-<br>
=A0fs_use =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 21 ++++++++++++++++<br>
=A0genfs_contexts =A0 =A0 =A0 | =A0 14 ++++++++++<br>
=A0initial_sid_contexts | =A0 27 ++++++++++++++++++++<br>
=A0ocontexts =A0 =A0 =A0 =A0 =A0 =A0| =A0 66 ------------------------------=
--------------------<br>
=A0port_contexts =A0 =A0 =A0 =A0| =A0 =A03 ++<br>
=A06 files changed, 70 insertions(+), 67 deletions(-)<br>
=A0create mode 100644 fs_use<br>
=A0create mode 100644 genfs_contexts<br>
=A0create mode 100644 initial_sid_contexts<br>
=A0delete mode 100644 ocontexts<br>
=A0create mode 100644 port_contexts<br>
<br>
diff --git a/Android.mk b/Android.mk<br>
index 002a656..ff46937 100644<br>
--- a/Android.mk<br>
+++ b/Android.mk<br>
@@ -16,6 +16,10 @@ LOCAL_POLICY_DIRS :=3D $(SRC_TARGET_DIR)/board/$(TARGET_=
DEVICE)/ device/*/$(TARGET<br>
=A0LOCAL_POLICY_FC :=3D $(wildcard $(addsuffix sepolicy.fc, $(LOCAL_POLICY_=
DIRS)))<br>
=A0LOCAL_POLICY_TE :=3D $(wildcard $(addsuffix sepolicy.te, $(LOCAL_POLICY_=
DIRS)))<br>
=A0LOCAL_POLICY_PC :=3D $(wildcard $(addsuffix sepolicy.pc, $(LOCAL_POLICY_=
DIRS)))<br>
+LOCAL_POLICY_FS_USE :=3D $(wildcard $(addsuffix sepolicy.fs_use, $(LOCAL_P=
OLICY_DIRS)))<br>
+LOCAL_POLICY_PORT_CONTEXTS :=3D $(wildcard $(LOCAL_FUCK))<br>
+LOCAL_POLICY_GENFS_CONTEXTS :=3D $(wildcard $(addsuffix sepolicy.genfscont=
exts, $(LOCAL_POLICY_DIRS)))<br>
+LOCAL_POLICY_INITIAL_SID_CONTEXTS :=3D $(wildcard $(addsuffix sepolicy.ini=
tial_sid_contexts, $(LOCAL_POLICY_DIRS)))<br>
<br>
=A0##################################<br>
=A0include $(CLEAR_VARS)<br>
@@ -31,7 +35,7 @@ include $(BUILD_SYSTEM)/<a href=3D"http://base_rules.mk" =
target=3D"_blank">base_rules.mk</a><br>
=A0sepolicy_policy.conf :=3D $(intermediates)/policy.conf<br>
=A0$(sepolicy_policy.conf): PRIVATE_MLS_SENS :=3D $(MLS_SENS)<br>
=A0$(sepolicy_policy.conf): PRIVATE_MLS_CATS :=3D $(MLS_CATS)<br>
-$(sepolicy_policy.conf) : $(wildcard $(addprefix $(LOCAL_PATH)/,security_c=
lasses initial_sids access_vectors global_macros mls_macros mls policy_capa=
bilities te_macros attributes *.te) $(LOCAL_POLICY_TE) $(addprefix $(LOCAL_=
PATH)/, roles users ocontexts))<br>

+$(sepolicy_policy.conf) : $(wildcard $(addprefix $(LOCAL_PATH)/,security_c=
lasses initial_sids access_vectors global_macros mls_macros mls policy_capa=
bilities te_macros attributes *.te) $(LOCAL_POLICY_TE) $(addprefix $(LOCAL_=
PATH)/, roles users initial_sid_contexts) $(LOCAL_POLICY_INITIAL_SID_CONTEX=
TS) $(addprefix $(LOCAL_PATH)/,fs_use) $(LOCAL_POLICY_FS_USE) $(addprefix $=
(LOCAL_PATH)/,genfs_contexts) $(LOCAL_POLICY_GENFS_CONTEXTS) $(addprefix $(=
LOCAL_PATH)/,port_contexts) $(LOCAL_POLICY_PORT_CONTEXTS))<br>

=A0 =A0 =A0 =A0 @mkdir -p $(dir $@)<br>
=A0 =A0 =A0 =A0 $(hide) m4 -D mls_num_sens=3D$(PRIVATE_MLS_SENS) -D mls_num=
_cats=3D$(PRIVATE_MLS_CATS) -s $^ &gt; $@<br>
<br>
diff --git a/fs_use b/fs_use<br>
new file mode 100644<br>
index 0000000..6516046<br>
--- /dev/null<br>
+++ b/fs_use<br>
@@ -0,0 +1,21 @@<br>
+# Label inodes via getxattr.<br>
+fs_use_xattr yaffs2 u:object_r:labeledfs:s0;<br>
+fs_use_xattr jffs2 u:object_r:labeledfs:s0;<br>
+fs_use_xattr ext2 u:object_r:labeledfs:s0;<br>
+fs_use_xattr ext3 u:object_r:labeledfs:s0;<br>
+fs_use_xattr ext4 u:object_r:labeledfs:s0;<br>
+fs_use_xattr xfs u:object_r:labeledfs:s0;<br>
+fs_use_xattr btrfs u:object_r:labeledfs:s0;<br>
+<br>
+# Label inodes from task label.<br>
+fs_use_task pipefs u:object_r:pipefs:s0;<br>
+fs_use_task sockfs u:object_r:sockfs:s0;<br>
+<br>
+# Label inodes from combination of task label and fs label.<br>
+# Define type_transition rules if you want per-domain types.<br>
+fs_use_trans devpts u:object_r:devpts:s0;<br>
+fs_use_trans tmpfs u:object_r:tmpfs:s0;<br>
+fs_use_trans devtmpfs u:object_r:device:s0;<br>
+fs_use_trans shm u:object_r:shm:s0;<br>
+fs_use_trans mqueue u:object_r:mqueue:s0;<br>
+<br>
diff --git a/genfs_contexts b/genfs_contexts<br>
new file mode 100644<br>
index 0000000..103136c<br>
--- /dev/null<br>
+++ b/genfs_contexts<br>
@@ -0,0 +1,14 @@<br>
+# Label inodes with the fs label.<br>
+genfscon rootfs / u:object_r:rootfs:s0<br>
+# proc labeling can be further refined (longest matching prefix).<br>
+genfscon proc / u:object_r:proc:s0<br>
+genfscon proc /net/xt_qtaguid/ctrl u:object_r:qtaguid:s0<br>
+# selinuxfs booleans can be individually labeled.<br>
+genfscon selinuxfs / u:object_r:selinuxfs:s0<br>
+genfscon cgroup / u:object_r:cgroup:s0<br>
+# sysfs labels can be set by userspace.<br>
+genfscon sysfs / u:object_r:sysfs:s0<br>
+genfscon inotifyfs / u:object_r:inotify:s0<br>
+genfscon vfat / u:object_r:sdcard:s0<br>
+genfscon debugfs / u:object_r:debugfs:s0<br>
+genfscon fuse / u:object_r:sdcard:s0<br>
diff --git a/initial_sid_contexts b/initial_sid_contexts<br>
new file mode 100644<br>
index 0000000..a8d2c19<br>
--- /dev/null<br>
+++ b/initial_sid_contexts<br>
@@ -0,0 +1,27 @@<br>
+sid kernel u:r:kernel:s0<br>
+sid security u:object_r:kernel:s0<br>
+sid unlabeled u:object_r:unlabeled:s0<br>
+sid fs u:object_r:labeledfs:s0<br>
+sid file u:object_r:unlabeled:s0<br>
+sid file_labels u:object_r:unlabeled:s0<br>
+sid init u:object_r:unlabeled:s0<br>
+sid any_socket u:object_r:unlabeled:s0<br>
+sid port u:object_r:port:s0<br>
+sid netif u:object_r:netif:s0<br>
+sid netmsg u:object_r:unlabeled:s0<br>
+sid node u:object_r:node:s0<br>
+sid igmp_packet u:object_r:unlabeled:s0<br>
+sid icmp_socket u:object_r:unlabeled:s0<br>
+sid tcp_socket u:object_r:unlabeled:s0<br>
+sid sysctl_modprobe u:object_r:unlabeled:s0<br>
+sid sysctl u:object_r:proc:s0<br>
+sid sysctl_fs u:object_r:unlabeled:s0<br>
+sid sysctl_kernel u:object_r:unlabeled:s0<br>
+sid sysctl_net u:object_r:unlabeled:s0<br>
+sid sysctl_net_unix u:object_r:unlabeled:s0<br>
+sid sysctl_vm u:object_r:unlabeled:s0<br>
+sid sysctl_dev u:object_r:unlabeled:s0<br>
+sid kmod u:object_r:unlabeled:s0<br>
+sid policy u:object_r:unlabeled:s0<br>
+sid scmp_packet u:object_r:unlabeled:s0<br>
+<br>
diff --git a/ocontexts b/ocontexts<br>
deleted file mode 100644<br>
index 7cbb989..0000000<br>
--- a/ocontexts<br>
+++ /dev/null<br>
@@ -1,66 +0,0 @@<br>
-sid kernel u:r:kernel:s0<br>
-sid security u:object_r:kernel:s0<br>
-sid unlabeled u:object_r:unlabeled:s0<br>
-sid fs u:object_r:labeledfs:s0<br>
-sid file u:object_r:unlabeled:s0<br>
-sid file_labels u:object_r:unlabeled:s0<br>
-sid init u:object_r:unlabeled:s0<br>
-sid any_socket u:object_r:unlabeled:s0<br>
-sid port u:object_r:port:s0<br>
-sid netif u:object_r:netif:s0<br>
-sid netmsg u:object_r:unlabeled:s0<br>
-sid node u:object_r:node:s0<br>
-sid igmp_packet u:object_r:unlabeled:s0<br>
-sid icmp_socket u:object_r:unlabeled:s0<br>
-sid tcp_socket u:object_r:unlabeled:s0<br>
-sid sysctl_modprobe u:object_r:unlabeled:s0<br>
-sid sysctl u:object_r:proc:s0<br>
-sid sysctl_fs u:object_r:unlabeled:s0<br>
-sid sysctl_kernel u:object_r:unlabeled:s0<br>
-sid sysctl_net u:object_r:unlabeled:s0<br>
-sid sysctl_net_unix u:object_r:unlabeled:s0<br>
-sid sysctl_vm u:object_r:unlabeled:s0<br>
-sid sysctl_dev u:object_r:unlabeled:s0<br>
-sid kmod u:object_r:unlabeled:s0<br>
-sid policy u:object_r:unlabeled:s0<br>
-sid scmp_packet u:object_r:unlabeled:s0<br>
-sid devnull u:object_r:null_device:s0<br>
-<br>
-# Label inodes via getxattr.<br>
-fs_use_xattr yaffs2 u:object_r:labeledfs:s0;<br>
-fs_use_xattr jffs2 u:object_r:labeledfs:s0;<br>
-fs_use_xattr ext2 u:object_r:labeledfs:s0;<br>
-fs_use_xattr ext3 u:object_r:labeledfs:s0;<br>
-fs_use_xattr ext4 u:object_r:labeledfs:s0;<br>
-fs_use_xattr xfs u:object_r:labeledfs:s0;<br>
-fs_use_xattr btrfs u:object_r:labeledfs:s0;<br>
-<br>
-# Label inodes from task label.<br>
-fs_use_task pipefs u:object_r:pipefs:s0;<br>
-fs_use_task sockfs u:object_r:sockfs:s0;<br>
-<br>
-# Label inodes from combination of task label and fs label.<br>
-# Define type_transition rules if you want per-domain types.<br>
-fs_use_trans devpts u:object_r:devpts:s0;<br>
-fs_use_trans tmpfs u:object_r:tmpfs:s0;<br>
-fs_use_trans devtmpfs u:object_r:device:s0;<br>
-fs_use_trans shm u:object_r:shm:s0;<br>
-fs_use_trans mqueue u:object_r:mqueue:s0;<br>
-<br>
-# Label inodes with the fs label.<br>
-genfscon rootfs / u:object_r:rootfs:s0<br>
-# proc labeling can be further refined (longest matching prefix).<br>
-genfscon proc / u:object_r:proc:s0<br>
-genfscon proc /net/xt_qtaguid/ctrl u:object_r:qtaguid:s0<br>
-# selinuxfs booleans can be individually labeled.<br>
-genfscon selinuxfs / u:object_r:selinuxfs:s0<br>
-genfscon cgroup / u:object_r:cgroup:s0<br>
-# sysfs labels can be set by userspace.<br>
-genfscon sysfs / u:object_r:sysfs:s0<br>
-genfscon inotifyfs / u:object_r:inotify:s0<br>
-genfscon vfat / u:object_r:sdcard:s0<br>
-genfscon debugfs / u:object_r:debugfs:s0<br>
-genfscon fuse / u:object_r:sdcard:s0<br>
-<br>
-# portcon statements go here, e.g.<br>
-# portcon tcp 80 u:object_r:http_port:s0<br>
diff --git a/port_contexts b/port_contexts<br>
new file mode 100644<br>
index 0000000..b473c0c<br>
--- /dev/null<br>
+++ b/port_contexts<br>
@@ -0,0 +1,3 @@<br>
+# portcon statements go here, e.g.<br>
+# portcon tcp 80 u:object_r:http_port:s0<br>
+<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.7.0.4<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r>Respectfully,<br><br>William C Roberts<br><br><br>

--f46d042f9eb0ce289f04c49657bc--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
