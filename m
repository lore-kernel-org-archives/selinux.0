Return-Path: <SRS0=wTGR=6U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A7EC47247
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 00:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50D47206A5
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 00:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apTUxClg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbgEFAyN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 May 2020 20:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729332AbgEFAyN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 May 2020 20:54:13 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88B2C061A0F
        for <selinux@vger.kernel.org>; Tue,  5 May 2020 17:54:12 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f13so349999qkh.2
        for <selinux@vger.kernel.org>; Tue, 05 May 2020 17:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HsxbPHKVMKTDIPZkMbrluF5/0b0wPdsS0WVQbmQZmug=;
        b=apTUxClgjsKvgmAHyuN+dPi/AUYFkxJUFOJd+44dFS43r3AESFwr5jr/YtYHuON6FC
         hRsCXGj2TWhl7feNBF3BiqPbzCtlCkO3SeEyag2lES5S31NnKYS3nBXrA+HMPgUq6PdM
         +yz/oRUWz30O2+4dIqoG7YPOUwFXi/XWMkPXJ4tyS4aMYHHWm2bLXJUg/azT4Nd0ynF7
         jxGX/mb4S2VORA/R6tm/52Ts7LlnqTusTP1/61doR2dmFI4A0ZNhckzJYbbIX4C0mq1g
         RwMSpKtTVlvspX8CiNPBAcYsWdL/I/VohPMFkyxyzpdmPMxL+00yuzNq4/TbJofjHOIW
         94ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HsxbPHKVMKTDIPZkMbrluF5/0b0wPdsS0WVQbmQZmug=;
        b=Di3wSjht5hvf+lQz4QbUe5lwPYno4aAEufYqBRhh5MiH+weNNf+ux1+sw1bSLV+l34
         DkJjlV8iyBJu7ejKqOrWcUGdkK88vYxMOBLFOnrQlqkknzOhoxEGyMZsqNHT9Q6rrolP
         RyDf49rTThxalNOGMjdzMAYdMc8xSMIkfeJdU54n3OncxIlZ+9MZUIlSeD2kzQrf1DJ5
         4Bc9utcLj48Hsn+r73BMIdkYfH+Jz2TQWRrRuFwwChBFuL5+hpyd1QJmdxD0hH+OFUs6
         /QdhOWrpAZ/weY5zyB2/tJ/78Imxvnap7sOkJOVX9J95lMnfytIHkB8g76p1DlGEk8nG
         UfEA==
X-Gm-Message-State: AGi0PuZlR4xWjWJzIwDkcC8/prAqQ025WUOF3HnEMqkoArBfxe+zzn0c
        buSi4FU0K6iWYcqsNlCr4ZUJP3s6
X-Google-Smtp-Source: APiQypJ+4Dy8RX6t9c/hhxp97Y2d2ogJ0shVfGbvDfaeNNqs3d11xsBf/gADvaWYSCN64sUrLEUocA==
X-Received: by 2002:a37:57c4:: with SMTP id l187mr5875289qkb.303.1588726449609;
        Tue, 05 May 2020 17:54:09 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id l186sm475200qkf.89.2020.05.05.17.54.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 17:54:08 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] selinux-testsuite: update to work on Debian
Date:   Tue,  5 May 2020 20:53:39 -0400
Message-Id: <20200506005339.13641-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.23.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Update the testsuite policy and code so that it builds and
runs on Debian unstable and stable successfully (if one has
already enabled SELinux on Debian).  Provide the necessary
dependencies and instructions in the README.

The labeled networking tests relies on specific mlsconstrain
statements that exist in Fedora policy but not in Debian so
add them to the test policy as a CIL module; on Fedora this is
redundant but harmless.  The SCTP tests also assumed that
netlabel_peer_t was already marked mcs_constrained() in the
base policy which doesn't appear to be true in Debian, so mark
it so in the test policy.

The filesystem tests assume the defaultrange rules in the Fedora
policy for file MLS/MCS label inheritance, so add those rules as
a CIL module to the test policy to get the expected results.
Again, on Fedora this is a no-op.

Debian has no allow_domain_fd_use boolean so conditionalize the
setting of it.  The real boolean name in policy in Fedora is
domain_fd_use; allow_domain_fd_use was an old name that was being
mapped by userspace.

corenet_tcp/udp_sendrecv_all_ports() is an obsolete interface
that no longer exists in refpolicy.

mmap_file_perms is an obsolete macro that is deprecated in refpolicy
and removed in Debian policy; switch to mmap_exec_file_perms.

Rather than forcing the process user identity to system_u in the
filesystem tests (which broke in Debian due to not being authorized
for unconfined_r), grant the test_filesystem_fscontext_t domain
the ability to create objects in other user identities.  This is
cleaner.

Switch the Infiniband test policy to use the appropriate policy
interface if defined rather than hardcoding a reference to the
type, neither of which exist in Debian policy.  Drop the dead
hardcoded reference on bin_t since it is no longer used anywhere
outside of an interface.

Convert the network test policies from using bind/connect_generic_port()
to using bind/connect_all_unreserved_ports(), since the actual port
being used falls in the unreserved port range and the _generic_port()
interfaces do not allow access in Debian and likely refpolicy.

Update the overlayfs policy to allow the test_overlay_mounter_t
domain to read a shell-created temporary file that ends up being
labeled user_tmp_t in Debian; this occurs during setup-overlayfs
and otherwise breaks mounting.

Replace the reference to unconfined_devpts_t which does not exist
in Debian policy with the more general ptynode attribute.

Debian does not allow unprivileged user namespace clones by default,
so update the test to enable it when running the test to avoid requiring
sys_admin permission to the capability class during the cap_userns tests.

Debian unstable is mounting devtmpfs as noexec which breaks
testing of mmap/mprotect PROT_EXEC /dev/zero, so skip those tests
if so mounted.

Fixes: https://github.com/SELinuxProject/selinux-testsuite/issues/73
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 README.md                            | 62 +++++++++++++++++++++++++++-
 policy/Makefile                      | 10 ++++-
 policy/test_capable_net.te           |  2 -
 policy/test_execute_no_trans.te      |  2 +-
 policy/test_filesystem.te            |  1 +
 policy/test_global.te                |  1 +
 policy/test_ibendport.te             |  9 ++--
 policy/test_inet_socket.te           | 22 +++++-----
 policy/test_mlsconstrain.cil         |  2 +
 policy/test_overlay_defaultrange.cil |  7 ++++
 policy/test_overlayfs.te             |  1 +
 policy/test_policy.if                |  4 +-
 policy/test_sctp.te                  |  1 +
 tests/cap_userns/test                |  8 ++++
 tests/filesystem/test                |  2 +-
 tests/fs_filesystem/test             |  2 +-
 tests/mmap/test                      | 49 ++++++++++++++--------
 17 files changed, 141 insertions(+), 44 deletions(-)
 create mode 100644 policy/test_mlsconstrain.cil
 create mode 100644 policy/test_overlay_defaultrange.cil

diff --git a/README.md b/README.md
index b36494e..0d3f060 100644
--- a/README.md
+++ b/README.md
@@ -36,6 +36,8 @@ one primary security module may be active at a time.
 
 ### Userland and Base Policy
 
+#### Fedora or RHEL
+
 On a Fedora/RHEL based system the testsuite has the following userspace
 dependencies beyond a minimal install (other Linux distributions should have
 similar dependencies):
@@ -77,8 +79,66 @@ following command:
 		xfsprogs-devel \
 		libuuid-devel
 
+#### Debian
+
+On Debian, you must first take steps to install and activate SELinux since
+it is not enabled in the default install.  Be sure to backup your system first
+if you care about any local data.
+
+	# apt-get install selinux-basics selinux-policy-default auditd
+	# selinux-activate
+	# reboot
+
+After activating, make sure that your login shell is running in the correct context:
+
+	# id -Z
+
+If this shows something other than "unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023",
+you will need to first fix labeling or policy problems in your base system before proceeding.
+Be sure that your shell context is correct and you can switch to enforcing mode without
+breaking your system before proceeding.
+
+On Debian, you can install the userspace dependencies with the following
+command:
+
+	# apt-get install perl \
+		gcc \
+		selinux-policy-dev \
+		libselinux1-dev \
+		net-tools \
+		iptables \
+		libsctp-dev \
+		attr \
+		libbpf-dev \
+		libkeyutils-dev \
+		linux-headers-$(uname -r) \
+		quota \
+		xfsprogs \
+		xfslibs-dev \
+		uuid-dev
+
+On Debian, you need to build and install netlabel_tools manually since it is not
+yet packaged for Debian (https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=959806):
+
+    # git clone https://github.com/netlabel/netlabel_tools
+    # cd netlabel_tools
+    # sudo apt-get install autotools-dev autoconf automake libtool pkg-config libnl-3-dev libnl-genl-3-dev
+    # ./autogen.sh
+    # ./configure --prefix=/usr
+    # make
+    # sudo make install
+
+Debian further requires reconfiguring the default /bin/sh to be bash
+to support bashisms employed in the testsuite Makefiles and scripts:
+
+    # dpkg-reconfigure dash
+
+Select No when asked if you want to use dash as the default system shell.
+
+#### Other Distributions
+
 The testsuite requires a pre-existing base policy configuration of SELinux,
-using either the old example policy or the reference policy as the baseline.
+using the reference policy as the baseline.
 It also requires the core SELinux userland packages (`libsepol`, `checkpolicy`,
 `libselinux`, `policycoreutils`, and if using modular policy, `libsemanage`)
 to be installed.  The test scripts also rely upon the SELinux extensions being
diff --git a/policy/Makefile b/policy/Makefile
index dfe601b..f86aac4 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -40,6 +40,8 @@ CIL_TARGETS = test_add_levels.cil test_glblub.cil
 endif
 endif # GLBLUB
 
+CIL_TARGETS += test_mlsconstrain.cil test_overlay_defaultrange.cil
+
 ifeq ($(shell [ $(POL_VERS) -ge 24 ] && echo true),true)
 TARGETS += test_bounds.te test_nnp_nosuid.te
 endif
@@ -161,12 +163,16 @@ build: $(TARGETS)
 
 load: expand_check all
 	# General policy load
-	@-/usr/sbin/setsebool allow_domain_fd_use=0
+	@if [ -e /sys/fs/selinux/booleans/domain_fd_use ]; then \
+		/usr/sbin/setsebool domain_fd_use=0; \
+	fi
 	$(SEMODULE) -i test_policy/test_policy.pp $(CIL_TARGETS)
 
 unload:
 	# General policy unload
-	@-/usr/sbin/setsebool allow_domain_fd_use=1
+	@if [ -e /sys/fs/selinux/booleans/domain_fd_use ]; then \
+		/usr/sbin/setsebool domain_fd_use=1; \
+	fi
 	$(SEMODULE) -r test_policy $(subst .cil,,$(CIL_TARGETS))
 
 clean:
diff --git a/policy/test_capable_net.te b/policy/test_capable_net.te
index 80559f6..2255a14 100644
--- a/policy/test_capable_net.te
+++ b/policy/test_capable_net.te
@@ -28,8 +28,6 @@ corenet_raw_sendrecv_generic_if(capabledomain)
 corenet_tcp_sendrecv_all_nodes(capabledomain)
 corenet_udp_sendrecv_all_nodes(capabledomain)
 corenet_raw_sendrecv_all_nodes(capabledomain)
-corenet_tcp_sendrecv_all_ports(capabledomain)
-corenet_udp_sendrecv_all_ports(capabledomain)
 corenet_all_recvfrom_unlabeled(test_ncap_t)
 corenet_all_recvfrom_unlabeled(test_resncap_t)
 corenet_tcp_bind_all_nodes(capabledomain)
diff --git a/policy/test_execute_no_trans.te b/policy/test_execute_no_trans.te
index 79ba868..f699f56 100644
--- a/policy/test_execute_no_trans.te
+++ b/policy/test_execute_no_trans.te
@@ -24,4 +24,4 @@ userdom_sysadm_entry_spec_domtrans_to(test_execute_notrans_t)
 
 #Allow test_execute_notrans permissions to the allowed type
 can_exec(test_execute_notrans_t,test_execute_notrans_allowed_t)
-allow test_execute_notrans_t test_execute_notrans_denied_t:file mmap_file_perms;
+allow test_execute_notrans_t test_execute_notrans_denied_t:file mmap_exec_file_perms;
diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
index 7d73cbf..4e27134 100644
--- a/policy/test_filesystem.te
+++ b/policy/test_filesystem.te
@@ -350,6 +350,7 @@ allow test_filesystem_fscontext_t test_filesystem_filecon_t:file { getattr open
 allow test_filesystem_fscontext_t test_filesystem_fscontext_fs_t:dir { add_name search write };
 allow test_filesystem_fscontext_t test_filesystem_fscontext_fs_t:file { create getattr open relabelfrom write };
 allow test_filesystem_fscontext_t test_filesystem_fscontext_fs_t:filesystem { mount relabelto unmount };
+domain_obj_id_change_exemption(test_filesystem_fscontext_t)
 fs_relabelfrom_all_fs(test_filesystem_fscontext_t)
 files_search_all(test_filesystem_fscontext_t)
 allow test_filesystem_filecon_t test_filesystem_fscontext_fs_t:filesystem { associate };
diff --git a/policy/test_global.te b/policy/test_global.te
index c9520ec..d19b4be 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -83,6 +83,7 @@ domain_use_interactive_fds(testdomain)
 seutil_read_config(testdomain)
 
 # can getsecurity
+selinux_getattr_fs(testdomain)
 selinux_validate_context(testdomain)
 selinux_compute_access_vector(testdomain)
 selinux_compute_create_context(testdomain)
diff --git a/policy/test_ibendport.te b/policy/test_ibendport.te
index 2a02c57..b909b4f 100644
--- a/policy/test_ibendport.te
+++ b/policy/test_ibendport.te
@@ -3,11 +3,6 @@
 # Policy for testing Infiniband Pkey access.
 #
 
-gen_require(`
-	type bin_t;
-	type infiniband_mgmt_device_t;
-')
-
 attribute ibendportdomain;
 
 # Domain for process.
@@ -27,7 +22,9 @@ dev_rw_sysfs(test_ibendport_manage_subnet_t)
 
 corecmd_bin_entry_type(test_ibendport_manage_subnet_t)
 
-allow test_ibendport_manage_subnet_t infiniband_mgmt_device_t:chr_file { read write open ioctl};
+ifdef(`dev_rw_infiniband_mgmt_dev', `
+dev_rw_infiniband_mgmt_dev(test_ibendport_manage_subnet_t)
+')
 
 ifdef(`corenet_ib_access_unlabeled_pkeys',`
 corenet_ib_access_unlabeled_pkeys(test_ibendport_manage_subnet_t)
diff --git a/policy/test_inet_socket.te b/policy/test_inet_socket.te
index bf839df..0fff2da 100644
--- a/policy/test_inet_socket.te
+++ b/policy/test_inet_socket.te
@@ -26,8 +26,8 @@ typeattribute test_inet_server_t testdomain;
 typeattribute test_inet_server_t inetsocketdomain;
 allow test_inet_server_t self:tcp_socket create_stream_socket_perms;
 allow test_inet_server_t self:udp_socket create_socket_perms;
-corenet_tcp_bind_generic_port(test_inet_server_t)
-corenet_udp_bind_generic_port(test_inet_server_t)
+corenet_tcp_bind_all_unreserved_ports(test_inet_server_t)
+corenet_udp_bind_all_unreserved_ports(test_inet_server_t)
 corenet_tcp_bind_all_nodes(test_inet_server_t)
 corenet_udp_bind_all_nodes(test_inet_server_t)
 corenet_inout_generic_if(test_inet_server_t)
@@ -54,7 +54,7 @@ typeattribute test_inet_client_t testdomain;
 typeattribute test_inet_client_t inetsocketdomain;
 allow test_inet_client_t self:tcp_socket create_stream_socket_perms;
 allow test_inet_client_t self:udp_socket create_socket_perms;
-corenet_tcp_connect_generic_port(test_inet_client_t)
+corenet_tcp_connect_all_unreserved_ports(test_inet_client_t)
 corenet_inout_generic_if(test_inet_client_t)
 corenet_inout_generic_node(test_inet_client_t)
 
@@ -71,7 +71,7 @@ typeattribute test_inet_bad_client_t testdomain;
 typeattribute test_inet_bad_client_t inetsocketdomain;
 allow test_inet_bad_client_t self:tcp_socket create_stream_socket_perms;
 allow test_inet_bad_client_t self:udp_socket create_socket_perms;
-corenet_tcp_connect_generic_port(test_inet_bad_client_t)
+corenet_tcp_connect_all_unreserved_ports(test_inet_bad_client_t)
 corenet_inout_generic_if(test_inet_bad_client_t)
 corenet_inout_generic_node(test_inet_bad_client_t)
 
@@ -87,8 +87,8 @@ typeattribute test_inet_bind_t testdomain;
 typeattribute test_inet_bind_t inetsocketdomain;
 allow test_inet_bind_t self:tcp_socket create_stream_socket_perms;
 allow test_inet_bind_t self:udp_socket create_socket_perms;
-corenet_tcp_bind_generic_port(test_inet_bind_t)
-corenet_udp_bind_generic_port(test_inet_bind_t)
+corenet_tcp_bind_all_unreserved_ports(test_inet_bind_t)
+corenet_udp_bind_all_unreserved_ports(test_inet_bind_t)
 corenet_tcp_bind_all_nodes(test_inet_bind_t)
 corenet_udp_bind_all_nodes(test_inet_bind_t)
 
@@ -111,8 +111,8 @@ typeattribute test_inet_no_node_bind_t testdomain;
 typeattribute test_inet_no_node_bind_t inetsocketdomain;
 allow test_inet_no_node_bind_t self:tcp_socket create_stream_socket_perms;
 allow test_inet_no_node_bind_t self:udp_socket create_socket_perms;
-corenet_tcp_bind_generic_port(test_inet_no_node_bind_t)
-corenet_udp_bind_generic_port(test_inet_no_node_bind_t)
+corenet_tcp_bind_all_unreserved_ports(test_inet_no_node_bind_t)
+corenet_udp_bind_all_unreserved_ports(test_inet_no_node_bind_t)
 
 # Domain for a process allowed to connect(2).
 type test_inet_connect_t;
@@ -122,8 +122,8 @@ typeattribute test_inet_connect_t testdomain;
 typeattribute test_inet_connect_t inetsocketdomain;
 allow test_inet_connect_t self:tcp_socket create_stream_socket_perms;
 allow test_inet_connect_t self:udp_socket create_socket_perms;
-corenet_tcp_connect_generic_port(test_inet_connect_t)
-corenet_tcp_bind_generic_port(test_inet_connect_t)
+corenet_tcp_connect_all_unreserved_ports(test_inet_connect_t)
+corenet_tcp_bind_all_unreserved_ports(test_inet_connect_t)
 corenet_tcp_bind_all_nodes(test_inet_connect_t)
 corenet_inout_generic_if(test_inet_connect_t)
 corenet_inout_generic_node(test_inet_connect_t)
@@ -136,7 +136,7 @@ typeattribute test_inet_no_name_connect_t testdomain;
 typeattribute test_inet_no_name_connect_t inetsocketdomain;
 allow test_inet_no_name_connect_t self:tcp_socket create_stream_socket_perms;
 allow test_inet_no_name_connect_t self:udp_socket create_socket_perms;
-corenet_tcp_bind_generic_port(test_inet_no_name_connect_t)
+corenet_tcp_bind_all_unreserved_ports(test_inet_no_name_connect_t)
 corenet_tcp_bind_all_nodes(test_inet_no_name_connect_t)
 corenet_inout_generic_if(test_inet_no_name_connect_t)
 corenet_inout_generic_node(test_inet_no_name_connect_t)
diff --git a/policy/test_mlsconstrain.cil b/policy/test_mlsconstrain.cil
new file mode 100644
index 0000000..1412f91
--- /dev/null
+++ b/policy/test_mlsconstrain.cil
@@ -0,0 +1,2 @@
+(mlsconstrain (peer (recv)) (or (dom l1 l2) (and (neq t1 mcs_constrained_type) (neq t2 mcs_constrained_type))))
+(mlsconstrain (packet (recv)) (or (dom l1 l2) (and (neq t1 mcs_constrained_type) (neq t2 mcs_constrained_type))))
diff --git a/policy/test_overlay_defaultrange.cil b/policy/test_overlay_defaultrange.cil
new file mode 100644
index 0000000..d1c18db
--- /dev/null
+++ b/policy/test_overlay_defaultrange.cil
@@ -0,0 +1,7 @@
+(defaultrange file target low)
+(defaultrange dir target low)
+(defaultrange lnk_file target low)
+(defaultrange chr_file target low)
+(defaultrange blk_file target low)
+(defaultrange sock_file target low)
+(defaultrange fifo_file target low)
diff --git a/policy/test_overlayfs.te b/policy/test_overlayfs.te
index 6f1756e..b29621e 100644
--- a/policy/test_overlayfs.te
+++ b/policy/test_overlayfs.te
@@ -52,6 +52,7 @@ corecmd_exec_bin(test_overlay_mounter_t)
 
 userdom_search_admin_dir(test_overlay_mounter_t)
 userdom_search_user_home_content(test_overlay_mounter_t)
+userdom_read_user_tmp_files(test_overlay_mounter_t)
 
 mount_exec(test_overlay_mounter_t)
 mount_rw_pid_files(test_overlay_mounter_t)
diff --git a/policy/test_policy.if b/policy/test_policy.if
index cefc8fb..f0400f5 100644
--- a/policy/test_policy.if
+++ b/policy/test_policy.if
@@ -29,7 +29,7 @@
 interface(`unconfined_runs_test',`
 	gen_require(`
 		type unconfined_t;
-               type unconfined_devpts_t;
+               attribute ptynode;
 		role unconfined_r;
 	')
 
@@ -38,7 +38,7 @@ interface(`unconfined_runs_test',`
 	role unconfined_r types $1;
       # Report back from the test domain to the caller.
       allow $1 unconfined_t:fd use;
-      allow $1 unconfined_devpts_t:chr_file { read write ioctl getattr };
+      allow $1 ptynode:chr_file { read write ioctl getattr };
       allow $1 unconfined_t:fifo_file { read write ioctl getattr };
       allow $1 unconfined_t:process { sigchld };
 
diff --git a/policy/test_sctp.te b/policy/test_sctp.te
index df8606e..3b16db1 100644
--- a/policy/test_sctp.te
+++ b/policy/test_sctp.te
@@ -25,6 +25,7 @@ allow nfsd_t netlabel_sctp_peer_t:peer recv;
 gen_require(`
 	type netlabel_peer_t;
 ')
+mcs_constrained(netlabel_peer_t)
 
 #
 ############### Declare an attribute that will hold all peers ###############
diff --git a/tests/cap_userns/test b/tests/cap_userns/test
index 9eafba6..917da00 100755
--- a/tests/cap_userns/test
+++ b/tests/cap_userns/test
@@ -6,6 +6,10 @@ BEGIN {
     $basedir = $0;
     $basedir =~ s|(.*)/[^/]*|$1|;
 
+    if ( -e '/proc/sys/kernel/unprivileged_userns_clone' ) {
+        system(
+            "echo 1 > /proc/sys/kernel/unprivileged_userns_clone 2> /dev/null");
+    }
     if ( system("$basedir/userns_child_exec -t -U > /dev/null 2>&1") == 0 ) {
         plan tests => 2;
     }
@@ -27,3 +31,7 @@ $result = system(
 "runcon -t test_no_cap_userns_t -- $basedir/userns_child_exec -p -m -U -M '0 0 1' -G '0 0 1' -- true 2>&1"
 );
 ok($result);
+
+if ( -e '/proc/sys/kernel/unprivileged_userns_clone' ) {
+    system("echo 0 > /proc/sys/kernel/unprivileged_userns_clone 2> /dev/null");
+}
diff --git a/tests/filesystem/test b/tests/filesystem/test
index 149cc29..7d4654d 100755
--- a/tests/filesystem/test
+++ b/tests/filesystem/test
@@ -1116,7 +1116,7 @@ if ( not $nfs_enabled ) {
         #   system_u:object_r:test_filesystem_context_file_t:s0 from $test_opts
         print "Creating test file $basedir/mntpoint/mp1/test_file\n";
         $result = system(
-"runcon -u system_u -t test_filesystem_fscontext_t $basedir/create_file -f $basedir/mntpoint/mp1/test_file -e test_filesystem_context_file_t $v"
+"runcon -t test_filesystem_fscontext_t $basedir/create_file -f $basedir/mntpoint/mp1/test_file -e test_filesystem_context_file_t $v"
         );
         ok( $result eq 0 );
 
diff --git a/tests/fs_filesystem/test b/tests/fs_filesystem/test
index 5dcc89d..5dedf83 100755
--- a/tests/fs_filesystem/test
+++ b/tests/fs_filesystem/test
@@ -1145,7 +1145,7 @@ if ( not $nfs_enabled ) {
         #   system_u:object_r:test_filesystem_context_file_t:s0 from $test_opts
         print "Creating test file $basedir/mntpoint/mp1/test_file\n";
         $result = system(
-"runcon -u system_u -t test_filesystem_fscontext_t $filesystem_dir/create_file -f $basedir/mntpoint/mp1/test_file -e test_filesystem_context_file_t $v"
+"runcon -t test_filesystem_fscontext_t $filesystem_dir/create_file -f $basedir/mntpoint/mp1/test_file -e test_filesystem_context_file_t $v"
         );
         ok( $result eq 0 );
 
diff --git a/tests/mmap/test b/tests/mmap/test
index fe6f184..850b24f 100755
--- a/tests/mmap/test
+++ b/tests/mmap/test
@@ -3,10 +3,11 @@
 use Test;
 
 BEGIN {
-    $test_count         = 34;
-    $test_hugepages     = 0;
-    $test_exec_checking = 0;
-    $test_map_checking  = 0;
+    $test_count            = 30;
+    $test_hugepages        = 0;
+    $test_exec_checking    = 0;
+    $test_map_checking     = 0;
+    $test_devzero_checking = 0;
 
     system("echo 1 > /proc/sys/vm/nr_hugepages 2> /dev/null");
     if ( system("grep -q 1 /proc/sys/vm/nr_hugepages 2> /dev/null") == 0 ) {
@@ -19,6 +20,13 @@ BEGIN {
         $test_count += 4;
     }
 
+    if (
+        system("grep -q devtmpfs.*noexec /proc/self/mounts 2> /dev/null") != 0 )
+    {
+        $test_devzero_checking = 1;
+        $test_count += 4;
+    }
+
     if ( -e '/sys/fs/selinux/class/file/perms/map' ) {
         $test_map_checking = 1;
         $test_count += 1;
@@ -62,13 +70,17 @@ ok( $result, 0 );
 $result = system "runcon -t test_no_execmem_t $basedir/mmap_anon_shared 2>&1";
 ok($result);
 
-# Test success and failure for mmap /dev/zero.
-$result =
-  system "runcon -t test_mmap_dev_zero_t $basedir/mmap_file_shared /dev/zero";
-ok( $result, 0 );
-$result = system
-  "runcon -t test_no_mmap_dev_zero_t $basedir/mmap_file_shared /dev/zero 2>&1";
-ok($result);
+if ($test_devzero_checking) {
+
+    # Test success and failure for mmap /dev/zero.
+    $result =
+      system
+      "runcon -t test_mmap_dev_zero_t $basedir/mmap_file_shared /dev/zero";
+    ok( $result, 0 );
+    $result = system
+"runcon -t test_no_mmap_dev_zero_t $basedir/mmap_file_shared /dev/zero 2>&1";
+    ok($result);
+}
 
 # Test success and failure for mprotect w/ anonymous shared memory.
 # In old kernels, this triggers a tmpfs file execute check.
@@ -80,13 +92,16 @@ $result = system
   "runcon -t test_no_mprotect_anon_shared_t $basedir/mprotect_anon_shared 2>&1";
 ok($result);
 
-# Test success and failure for mprotect /dev/zero.
-$result = system
-  "runcon -t test_mprotect_dev_zero_t $basedir/mprotect_file_shared /dev/zero";
-ok( $result, 0 );
-$result = system
+if ($test_devzero_checking) {
+
+    # Test success and failure for mprotect /dev/zero.
+    $result = system
+"runcon -t test_mprotect_dev_zero_t $basedir/mprotect_file_shared /dev/zero";
+    ok( $result, 0 );
+    $result = system
 "runcon -t test_no_mprotect_dev_zero_t $basedir/mprotect_file_shared /dev/zero 2>&1";
-ok($result);
+    ok($result);
+}
 
 # Test success and failure for execheap, independent of execmem.
 $result = system "runcon -t test_execheap_t $basedir/mprotect_heap";
-- 
2.23.1

