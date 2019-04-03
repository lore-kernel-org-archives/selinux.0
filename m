Return-Path: <SRS0=YsfU=SF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D1FC4360F
	for <selinux@archiver.kernel.org>; Wed,  3 Apr 2019 12:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5227420830
	for <selinux@archiver.kernel.org>; Wed,  3 Apr 2019 12:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="sXskqnKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfDCMnI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:43:08 -0400
Received: from rgout0107.bt.lon5.cpcloud.co.uk ([65.20.0.127]:52101 "EHLO
        rgout01.bt.lon5.cpcloud.co.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726064AbfDCMnI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Apr 2019 08:43:08 -0400
X-OWM-Source-IP: 86.147.204.167 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrtdefgddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpthignhdrthgrrhhgvghtpdhtgihnrdgurghtrgenucfkphepkeeirddugeejrddvtdegrdduieejnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugeejrddvtdegrdduieejpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeothhkjhhoshesghhoohhglhgvrdgtohhmqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrtdefgddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpthignhdrthgrrhhgvghtpdhtgihnrdgurghtrgenucfkphepkeeirddugeejrddvtdegrdduieejnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugeejrddvtdegrdduieejpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrtdefgddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpthignhdrthgrrhhgvghtpdhtgihnrdgurghtrgenucfkphepkeeirddugeejrddvtdegrdduieejnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugeejrddvtdegrdduieejpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrtdefgddvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpthignhdrthgrrhhgvghtpdhtgihnrdgurghtrgenucfkphepkeeirddugeejrddvtdegrdduieejnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugeejrddvtdegrdduieejpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrtdefgddvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpthignhdrthgrrhhgvghtpdhtgihnrdgurghtrgenucfkphepkeeirddugeejrddvtdegrdduieejnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugeejrddvtdegrdduieejpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
Received: from localhost.localdomain (86.147.204.167) by rgout01.bt.lon5.cpcloud.co.uk (9.0.019.26-1) (authenticated as richard_c_haines@btinternet.com)
        id 5B321EA01A0F53FB; Wed, 3 Apr 2019 13:26:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btcpcloud; t=1554295387; 
        bh=QttDkwDaUMe8hdiWLDhNkKRChaeQz5A7kZotkZvvZFE=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=sXskqnKWfXiQMOPEWofPnlK8Kqpy+ndAHbd0HMdK4QIhxuFpPDj7s0WjMiNY0P3OmIGsBVnTdvzQL7DJN1oDknRUJnrWYVYiKft22iYQm82pjOx3Z6yWx+w1oeuowecIba4LE0EfG1DGLg4EyeFMOJr+7hZVa0jQ3qh9usLL92E=
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     tkjos@google.com, Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 1/1] selinux-testsuite: Update binder test applications
Date:   Wed,  3 Apr 2019 13:26:11 +0100
Message-Id: <20190403122611.6543-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Replace binder_test.c with separate manager, client and service provider.
This works in the same way as a service provider/client interacts
with a service manager in the Android world. It passes the service
providers binder file descriptor to the client for the impersonate
permission check.

Also added tests for Dynamically Allocated Binder Devices and passing
the sender SELinux security context on binder transactions.

Note that the tests require a minimum kernel of 4.16, else some tests may
fail. To run successfully the "binder: Add thread->process_todo flag"
patch may be required that is available from:
https://lore.kernel.org/patchwork/patch/851324/
This patch has been backported to some earlier kernels.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 defconfig                       |   3 +
 policy/test_binder.te           | 176 ++++----
 tests/binder/.gitignore         |   6 +-
 tests/binder/Makefile           |  13 +-
 tests/binder/binder_common.c    | 155 +++++++
 tests/binder/binder_common.h    |  37 ++
 tests/binder/check_binder.c     |  27 +-
 tests/binder/check_binderfs.c   |  53 +++
 tests/binder/client.c           | 450 ++++++++++++++++++++
 tests/binder/manager.c          | 362 ++++++++++++++++
 tests/binder/service_provider.c | 404 ++++++++++++++++++
 tests/binder/test               | 257 ++++++++++--
 tests/binder/test_binder.c      | 705 --------------------------------
 13 files changed, 1785 insertions(+), 863 deletions(-)
 create mode 100644 tests/binder/binder_common.c
 create mode 100644 tests/binder/binder_common.h
 create mode 100644 tests/binder/check_binderfs.c
 create mode 100644 tests/binder/client.c
 create mode 100644 tests/binder/manager.c
 create mode 100644 tests/binder/service_provider.c
 delete mode 100644 tests/binder/test_binder.c

diff --git a/defconfig b/defconfig
index ff0704f..d7f0ea5 100644
--- a/defconfig
+++ b/defconfig
@@ -59,3 +59,6 @@ CONFIG_OVERLAY_FS=m
 CONFIG_ANDROID=y
 CONFIG_ANDROID_BINDER_DEVICES="binder"
 CONFIG_ANDROID_BINDER_IPC=y
+# This will configure the Dynamically Allocated Binder Devices added
+# to 5.0+ kernels:
+CONFIG_ANDROID_BINDERFS=y
diff --git a/policy/test_binder.te b/policy/test_binder.te
index 47992b2..c160ec0 100644
--- a/policy/test_binder.te
+++ b/policy/test_binder.te
@@ -1,126 +1,118 @@
-
 attribute binderdomain;
 
 #
-################################## Manager ###################################
+################################## Manager ##################################
 #
 type test_binder_mgr_t;
 domain_type(test_binder_mgr_t)
 unconfined_runs_test(test_binder_mgr_t)
 typeattribute test_binder_mgr_t testdomain;
 typeattribute test_binder_mgr_t binderdomain;
-allow test_binder_mgr_t self:binder { set_context_mgr call };
-allow test_binder_mgr_t test_binder_provider_t:binder call;
+allow test_binder_mgr_t test_binder_client_t:binder { transfer };
 allow test_binder_mgr_t device_t:chr_file { ioctl open read write };
 allow_map(test_binder_mgr_t, device_t, chr_file)
-allow test_binder_mgr_t self:capability { sys_nice };
-allow test_binder_provider_t test_binder_mgr_t:fd use;
-fs_getattr_tmpfs(test_binder_mgr_t)
-allow test_binder_mgr_t tmpfs_t:file { read write open };
-allow_map(test_binder_mgr_t, tmpfs_t, file)
-fs_manage_tmpfs_dirs(test_binder_mgr_t)
-fs_manage_tmpfs_files(test_binder_mgr_t)
-
+allow test_binder_mgr_t self:binder { set_context_mgr };
 # For writing to flag file:
 allow test_binder_mgr_t test_file_t:fifo_file rw_file_perms;
 
 #
-########################## Manager no fd {use} ###############################
-#
-type test_binder_mgr_no_fd_t;
-domain_type(test_binder_mgr_no_fd_t)
-unconfined_runs_test(test_binder_mgr_no_fd_t)
-typeattribute test_binder_mgr_no_fd_t testdomain;
-typeattribute test_binder_mgr_no_fd_t binderdomain;
-allow test_binder_mgr_no_fd_t self:binder { set_context_mgr call };
-allow test_binder_mgr_no_fd_t test_binder_provider_t:binder { call };
-allow test_binder_mgr_no_fd_t device_t:chr_file { ioctl open read write };
-allow_map(test_binder_mgr_no_fd_t, device_t, chr_file)
-allow test_binder_provider_t test_binder_mgr_no_fd_t:binder { call transfer impersonate };
-fs_getattr_tmpfs(test_binder_mgr_no_fd_t)
-allow test_binder_mgr_no_fd_t tmpfs_t:file { read write open };
-allow_map(test_binder_mgr_no_fd_t, tmpfs_t, file)
-fs_manage_tmpfs_dirs(test_binder_mgr_no_fd_t)
-fs_manage_tmpfs_files(test_binder_mgr_no_fd_t)
-
-# For writing to flag file:
-allow test_binder_mgr_no_fd_t test_file_t:fifo_file rw_file_perms;
-
-#
-########################## Service Provider ################################
+########################### Service Provider ################################
 #
 type test_binder_provider_t;
 domain_type(test_binder_provider_t)
 unconfined_runs_test(test_binder_provider_t)
 typeattribute test_binder_provider_t testdomain;
 typeattribute test_binder_provider_t binderdomain;
-allow test_binder_provider_t self:binder { call };
-allow test_binder_provider_t test_binder_mgr_t:binder { call transfer impersonate };
+allow test_binder_provider_t test_binder_mgr_t:binder { call transfer };
 allow test_binder_provider_t device_t:chr_file { ioctl open read write };
 allow_map(test_binder_provider_t, device_t, chr_file)
-# For fstat:
-allow test_binder_provider_t device_t:chr_file getattr;
-fs_getattr_tmpfs(test_binder_provider_t)
-allow test_binder_provider_t tmpfs_t:file { read write open };
-allow_map(test_binder_provider_t, tmpfs_t, file)
-fs_manage_tmpfs_dirs(test_binder_provider_t)
-fs_manage_tmpfs_files(test_binder_provider_t)
+# For writing to flag file:
+allow test_binder_provider_t test_file_t:fifo_file rw_file_perms;
 
 #
-#################### Service Provider no call ################################
-#
-type test_binder_provider_no_call_t;
-domain_type(test_binder_provider_no_call_t)
-unconfined_runs_test(test_binder_provider_no_call_t)
-typeattribute test_binder_provider_no_call_t testdomain;
-typeattribute test_binder_provider_no_call_t binderdomain;
-allow test_binder_provider_no_call_t device_t:chr_file { ioctl open read write };
-allow_map(test_binder_provider_no_call_t, device_t, chr_file)
-fs_getattr_tmpfs(test_binder_provider_no_call_t)
-allow test_binder_provider_no_call_t tmpfs_t:file { read write open };
-allow_map(test_binder_provider_no_call_t, tmpfs_t, file)
-fs_manage_tmpfs_dirs(test_binder_provider_no_call_t)
-fs_manage_tmpfs_files(test_binder_provider_no_call_t)
+#################### Service Provider no fd {use} ###########################
+# test 7
+type test_binder_provider_no_fd_t;
+domain_type(test_binder_provider_no_fd_t)
+unconfined_runs_test(test_binder_provider_no_fd_t)
+typeattribute test_binder_provider_no_fd_t testdomain;
+typeattribute test_binder_provider_no_fd_t binderdomain;
+allow test_binder_provider_no_fd_t test_binder_mgr_t:binder { call transfer };
+allow test_binder_client_t test_binder_provider_no_fd_t:binder { call impersonate };
+allow test_binder_provider_no_fd_t device_t:chr_file { ioctl open read write };
+allow_map(test_binder_provider_no_fd_t, device_t, chr_file)
+# For writing to flag file:
+allow test_binder_provider_no_fd_t test_file_t:fifo_file rw_file_perms;
 
 #
-#################### Service Provider no transfer #############################
-#
-type test_binder_provider_no_transfer_t;
-domain_type(test_binder_provider_no_transfer_t)
-unconfined_runs_test(test_binder_provider_no_transfer_t)
-typeattribute test_binder_provider_no_transfer_t testdomain;
-typeattribute test_binder_provider_no_transfer_t binderdomain;
-allow test_binder_provider_no_transfer_t test_binder_mgr_t:binder { call };
-allow test_binder_provider_no_transfer_t device_t:chr_file { ioctl open read write };
-allow_map(test_binder_provider_no_transfer_t, device_t, chr_file)
-fs_getattr_tmpfs(test_binder_provider_no_transfer_t)
-allow test_binder_provider_no_transfer_t tmpfs_t:file { read write open };
-allow_map(test_binder_provider_no_transfer_t, tmpfs_t, file)
-fs_manage_tmpfs_dirs(test_binder_provider_no_transfer_t)
-fs_manage_tmpfs_files(test_binder_provider_no_transfer_t)
+################################# Client ####################################
+#
+type test_binder_client_t;
+domain_type(test_binder_client_t)
+unconfined_runs_test(test_binder_client_t)
+typeattribute test_binder_client_t testdomain;
+typeattribute test_binder_client_t binderdomain;
+allow test_binder_client_t test_binder_provider_t:binder { call impersonate };
+allow test_binder_client_t test_binder_mgr_t:binder { call };
+allow test_binder_client_t test_binder_provider_t:fd { use };
+allow test_binder_client_t device_t:chr_file { getattr ioctl open read write };
+allow_map(test_binder_client_t, device_t, chr_file)
 
 #
-#################### Service Provider no impersonate ##########################
-#
-type test_binder_provider_no_im_t;
-domain_type(test_binder_provider_no_im_t)
-unconfined_runs_test(test_binder_provider_no_im_t)
-typeattribute test_binder_provider_no_im_t testdomain;
-typeattribute test_binder_provider_no_im_t binderdomain;
-allow test_binder_provider_no_im_t self:binder { call };
-allow test_binder_provider_no_im_t test_binder_mgr_t:binder { call transfer };
-allow test_binder_provider_no_im_t device_t:chr_file { ioctl open read write };
-allow_map(test_binder_provider_no_im_t, device_t, chr_file)
-allow test_binder_provider_no_im_t test_binder_mgr_t:fd use;
-allow test_binder_provider_no_im_t device_t:chr_file getattr;
-fs_getattr_tmpfs(test_binder_provider_no_im_t)
-allow test_binder_provider_no_im_t tmpfs_t:file { read write open };
-allow_map(test_binder_provider_no_im_t, tmpfs_t, file)
-fs_manage_tmpfs_dirs(test_binder_provider_no_im_t)
-fs_manage_tmpfs_files(test_binder_provider_no_im_t)
+######################## Client No call Manager #############################
+#
+type test_binder_client_no_call_mgr_t;
+domain_type(test_binder_client_no_call_mgr_t)
+unconfined_runs_test(test_binder_client_no_call_mgr_t)
+typeattribute test_binder_client_no_call_mgr_t testdomain;
+typeattribute test_binder_client_no_call_mgr_t binderdomain;
+allow test_binder_client_no_call_mgr_t test_binder_provider_t:binder { call impersonate };
+allow test_binder_client_no_call_mgr_t device_t:chr_file { getattr ioctl open read write };
+allow_map(test_binder_client_no_call_mgr_t, device_t, chr_file)
+
+#
+################## Client No call Service Provider ##########################
+#
+type test_binder_client_no_call_sp_t;
+domain_type(test_binder_client_no_call_sp_t)
+unconfined_runs_test(test_binder_client_no_call_sp_t)
+typeattribute test_binder_client_no_call_sp_t testdomain;
+typeattribute test_binder_client_no_call_sp_t binderdomain;
+allow test_binder_mgr_t test_binder_client_no_call_sp_t:binder { transfer };
+allow test_binder_client_no_call_sp_t test_binder_mgr_t:binder { call };
+allow test_binder_client_no_call_sp_t device_t:chr_file { getattr ioctl open read write };
+allow_map(test_binder_client_no_call_sp_t, device_t, chr_file)
+
+#
+######################## Client No impersonate ##############################
+#
+type test_binder_client_no_im_t;
+domain_type(test_binder_client_no_im_t)
+unconfined_runs_test(test_binder_client_no_im_t)
+typeattribute test_binder_client_no_im_t testdomain;
+typeattribute test_binder_client_no_im_t binderdomain;
+allow test_binder_mgr_t test_binder_client_no_im_t:binder { transfer };
+allow test_binder_client_no_im_t test_binder_provider_t:binder { call };
+allow test_binder_client_no_im_t test_binder_mgr_t:binder { call };
+allow test_binder_client_no_im_t test_binder_provider_t:fd { use };
+allow test_binder_client_no_im_t device_t:chr_file { getattr ioctl open read write };
+allow_map(test_binder_client_no_im_t, device_t, chr_file)
+
+#
+########################## Client No transfer ###############################
+#
+type test_binder_client_no_transfer_t;
+domain_type(test_binder_client_no_transfer_t)
+unconfined_runs_test(test_binder_client_no_transfer_t)
+typeattribute test_binder_client_no_transfer_t testdomain;
+typeattribute test_binder_client_no_transfer_t binderdomain;
+allow test_binder_client_no_transfer_t test_binder_mgr_t:binder { call };
+allow test_binder_client_no_transfer_t test_binder_provider_t:binder { call impersonate };
+allow test_binder_client_no_transfer_t device_t:chr_file { getattr ioctl open read write };
+allow_map(test_binder_client_no_transfer_t, device_t, chr_file)
 
 #
-############ Allow these domains to be entered from sysadm domain ############
+########### Allow these domains to be entered from sysadm domain ############
 #
 miscfiles_domain_entry_test_files(binderdomain)
 userdom_sysadm_entry_spec_domtrans_to(binderdomain)
diff --git a/tests/binder/.gitignore b/tests/binder/.gitignore
index 37a2dd7..dc6ce20 100644
--- a/tests/binder/.gitignore
+++ b/tests/binder/.gitignore
@@ -1,3 +1,5 @@
 check_binder
-test_binder
-thread
+check_binderfs
+manager
+service_provider
+client
diff --git a/tests/binder/Makefile b/tests/binder/Makefile
index 0d76723..32f9a83 100644
--- a/tests/binder/Makefile
+++ b/tests/binder/Makefile
@@ -1,7 +1,18 @@
-TARGETS = check_binder test_binder
+# Required for local building
+INCLUDEDIR ?= /usr/include
 
+TARGETS = check_binder client manager service_provider
 LDLIBS += -lselinux -lrt
+DEPS = binder_common.c binder_common.h
+
+ifeq ($(shell test -e $(INCLUDEDIR)/linux/android/binderfs.h && echo true),true)
+CFLAGS += -DHAVE_BINDERFS
+TARGETS += check_binderfs
+endif
 
 all: $(TARGETS)
+
 clean:
 	rm -f $(TARGETS)
+
+$(TARGETS): $(DEPS)
diff --git a/tests/binder/binder_common.c b/tests/binder/binder_common.c
new file mode 100644
index 0000000..a240453
--- /dev/null
+++ b/tests/binder/binder_common.c
@@ -0,0 +1,155 @@
+/*
+ * This is a simple binder Service Manager/Service Provider that only uses
+ * the raw ioctl commands to test the SELinux binder permissions:
+ *     set_context_mgr, call, transfer, impersonate.
+ *
+ * Using binder test policy the following will be validated:
+ *    security_binder_set_context_mgr() binder { set_context_mgr }
+ *    security_binder_transaction()     binder { call impersonate }
+ *    security_binder_transfer_binder() binder { transfer }
+ *    security_binder_transfer_file()   fd { use }
+ *
+ * TODO security_binder_transfer_file() uses BPF if configured in kernel.
+ */
+
+#include "binder_common.h"
+
+const char *cmd_name(uint32_t cmd)
+{
+	switch (cmd) {
+	case BR_NOOP:
+		return "BR_NOOP";
+	case BR_TRANSACTION_COMPLETE:
+		return "BR_TRANSACTION_COMPLETE";
+	case BR_INCREFS:
+		return "BR_INCREFS";
+	case BR_ACQUIRE:
+		return "BR_ACQUIRE";
+	case BR_RELEASE:
+		return "BR_RELEASE";
+	case BR_DECREFS:
+		return "BR_DECREFS";
+	case BR_TRANSACTION:
+		return "BR_TRANSACTION";
+#if HAVE_BINDERFS
+	case BR_TRANSACTION_SEC_CTX:
+		return "BR_TRANSACTION_SEC_CTX";
+#endif
+	case BR_REPLY:
+		return "BR_REPLY";
+	case BR_FAILED_REPLY:
+		return "BR_FAILED_REPLY";
+	case BR_DEAD_REPLY:
+		return "BR_DEAD_REPLY";
+	case BR_DEAD_BINDER:
+		return "BR_DEAD_BINDER";
+	case BR_ERROR:
+		return "BR_ERROR";
+	/* fallthrough */
+	default:
+		return "Unknown Binder return code";
+	}
+}
+
+void print_trans_data(const struct binder_transaction_data *txn_in)
+{
+	const struct flat_binder_object *obj;
+	binder_size_t *offs = (binder_size_t *)
+			      (binder_uintptr_t)txn_in->data.ptr.offsets;
+	size_t count = txn_in->offsets_size / sizeof(binder_size_t);
+
+	printf("\thandle: %d\n", (uint32_t)txn_in->target.handle);
+	printf("\tcookie: %lld\n", txn_in->cookie);
+	switch (txn_in->code) {
+	case TEST_SERVICE_ADD:
+		printf("\tcode: TEST_SERVICE_ADD\n");
+		break;
+	case TEST_SERVICE_GET:
+		printf("\tcode: TEST_SERVICE_GET\n");
+		break;
+	case TEST_SERVICE_SEND_CLIENT_SP_FD:
+		printf("\tcode: TEST_SERVICE_SEND_CLIENT_SP_FD\n");
+		break;
+	default:
+		printf("Unknown binder_transaction_data->code: %x\n",
+		       txn_in->code);
+		return;
+	}
+
+	switch (txn_in->flags) {
+	case TF_ONE_WAY:
+		printf("\tflag: TF_ONE_WAY\n");
+		break;
+	case TF_ROOT_OBJECT:
+		printf("\tflag: TF_ROOT_OBJECT\n");
+		break;
+	case TF_STATUS_CODE:
+		printf("\tflag: TF_STATUS_CODE\n");
+		break;
+	case TF_ACCEPT_FDS:
+		printf("\tflag: TF_ACCEPT_FDS\n");
+		break;
+	default:
+		printf("Unknown flag: %x\n", txn_in->flags);
+		return;
+	}
+	printf("\tsender pid: %u\n", txn_in->sender_pid);
+	printf("\tsender euid: %u\n", txn_in->sender_euid);
+	printf("\tdata_size: %llu\n", txn_in->data_size);
+	printf("\toffsets_size: %llu\n", txn_in->offsets_size);
+
+	while (count--) {
+		obj = (const struct flat_binder_object *)
+		      (((char *)(binder_uintptr_t)txn_in->data.ptr.buffer) + *offs++);
+
+		switch (obj->hdr.type) {
+		case BINDER_TYPE_BINDER:
+			printf("\thdr: BINDER_TYPE_BINDER\n");
+			printf("\tbinder: %llx\n", obj->binder);
+			break;
+		case BINDER_TYPE_HANDLE:
+			printf("\thdr: BINDER_TYPE_HANDLE\n");
+			printf("\thandle: %x\n", obj->handle);
+			break;
+		case BINDER_TYPE_FD:
+			printf("\thdr: BINDER_TYPE_FD\n");
+			printf("\tfd: %x\n", obj->handle);
+			break;
+		default:
+			printf("Unknown header: %u\n", obj->hdr.type);
+			return;
+		}
+#if HAVE_BINDERFS
+		printf("\tflags: priority: 0x%x accept FDS: %s request security CTX: %s\n",
+		       obj->flags & FLAT_BINDER_FLAG_PRIORITY_MASK,
+		       obj->flags & FLAT_BINDER_FLAG_ACCEPTS_FDS ? "YES" : "NO",
+		       obj->flags & FLAT_BINDER_FLAG_TXN_SECURITY_CTX ? "YES" : "NO");
+#else
+		printf("\tflags: priority: 0x%x accept FDS: %s\n",
+		       obj->flags & FLAT_BINDER_FLAG_PRIORITY_MASK,
+		       obj->flags & FLAT_BINDER_FLAG_ACCEPTS_FDS ? "YES" : "NO");
+#endif
+		printf("\tcookie: %llx\n", obj->cookie);
+	}
+	fflush(stdout);
+}
+
+int binder_write(int fd, void *data, size_t len)
+{
+	struct binder_write_read bwr;
+	int result;
+
+	bwr.write_size = len;
+	bwr.write_consumed = 0;
+	bwr.write_buffer = (binder_uintptr_t)data;
+	bwr.read_size = 0;
+	bwr.read_consumed = 0;
+	bwr.read_buffer = 0;
+
+	result = ioctl(fd, BINDER_WRITE_READ, &bwr);
+	if (result < 0) {
+		fprintf(stderr, "binder_write ioctl BINDER_WRITE_READ error: %s\n",
+			strerror(errno));
+	}
+	return result;
+}
diff --git a/tests/binder/binder_common.h b/tests/binder/binder_common.h
new file mode 100644
index 0000000..bcf9e0c
--- /dev/null
+++ b/tests/binder/binder_common.h
@@ -0,0 +1,37 @@
+#include <errno.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdbool.h>
+#include <signal.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <sys/ioctl.h>
+#include <selinux/selinux.h>
+#include <linux/android/binder.h>
+#if HAVE_BINDERFS
+#include <linux/android/binderfs.h>
+#endif
+
+#define BINDER_DEV "/dev/binder"
+#define BINDERFS_DEV "/dev/binderfs"
+#define BINDERFS_NAME "binder-test"
+#define BINDERFS_CONTROL "/dev/binderfs/binder-control"
+#define BINDER_MMAP_SIZE 1024
+
+#define TEST_SERVICE_MANAGER_HANDLE 0
+/* These are the Binder txn->code values used by the Service Provider, Client
+ * and Manager to request/retrieve a binder handle or file descriptor.
+ */
+#define TEST_SERVICE_ADD		240616 /* Sent by Service Provider */
+#define TEST_SERVICE_GET		290317 /* Sent by Client */
+#define TEST_SERVICE_SEND_CLIENT_SP_FD	120419 /* Sent by Client */
+
+bool verbose;
+
+const char *cmd_name(uint32_t cmd);
+void print_trans_data(const struct binder_transaction_data *txn_in);
+int binder_write(int fd, void *data, size_t len);
diff --git a/tests/binder/check_binder.c b/tests/binder/check_binder.c
index 7b81a3d..2fc8d77 100644
--- a/tests/binder/check_binder.c
+++ b/tests/binder/check_binder.c
@@ -1,13 +1,4 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <stdbool.h>
-#include <sys/mman.h>
-#include <sys/ioctl.h>
-#include <linux/android/binder.h>
+#include "binder_common.h"
 
 static void usage(char *progname)
 {
@@ -21,10 +12,8 @@ static void usage(char *progname)
 int main(int argc, char **argv)
 {
 	int opt, result, fd;
-	char *driver = "/dev/binder";
-	bool verbose;
 	void *mapped;
-	size_t mapsize = 1024;
+	size_t mapsize = BINDER_MMAP_SIZE;
 	struct binder_version vers;
 
 	while ((opt = getopt(argc, argv, "v")) != -1) {
@@ -37,14 +26,15 @@ int main(int argc, char **argv)
 		}
 	}
 
-	fd = open(driver, O_RDWR | O_CLOEXEC);
+	fd = open(BINDER_DEV, O_RDWR | O_CLOEXEC);
 	if (fd < 0) {
 		fprintf(stderr, "Cannot open: %s error: %s\n",
-			driver, strerror(errno));
-		exit(1);
+			BINDER_DEV, strerror(errno));
+		result = 1;
+		return result;
 	}
 
-	/* Need this or no VMA error from kernel */
+	/* Need this or 'no VMA error' from kernel */
 	mapped = mmap(NULL, mapsize, PROT_READ, MAP_PRIVATE, fd, 0);
 	if (mapped == MAP_FAILED) {
 		fprintf(stderr, "mmap error: %s\n", strerror(errno));
@@ -69,8 +59,7 @@ int main(int argc, char **argv)
 	}
 
 	if (verbose)
-		fprintf(stderr, "Binder kernel version: %d\n",
-			vers.protocol_version);
+		printf("Binder kernel version: %d\n", vers.protocol_version);
 
 brexit:
 	munmap(mapped, mapsize);
diff --git a/tests/binder/check_binderfs.c b/tests/binder/check_binderfs.c
new file mode 100644
index 0000000..b016755
--- /dev/null
+++ b/tests/binder/check_binderfs.c
@@ -0,0 +1,53 @@
+#include "binder_common.h"
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-v]\n"
+		"Where:\n\t"
+		"-v Print new device information.\n", progname);
+	exit(-1);
+}
+
+int main(int argc, char *argv[])
+{
+	int opt, fd, result;
+	size_t len;
+	struct binderfs_device device = { 0 };
+
+	while ((opt = getopt(argc, argv, "v")) != -1) {
+		switch (opt) {
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	len = strlen(BINDERFS_NAME);
+	memcpy(device.name, BINDERFS_NAME, len);
+
+	fd = open(BINDERFS_CONTROL, O_RDONLY | O_CLOEXEC);
+	if (fd < 0) {
+		fprintf(stderr, "Failed to open binder-control device: %s\n",
+			strerror(errno));
+		return 1;
+	}
+
+	result = ioctl(fd, BINDER_CTL_ADD, &device);
+	if (result < 0) {
+		fprintf(stderr, "Failed to allocate new binder device: %s\n",
+			strerror(errno));
+		result = 2;
+		goto brexit;
+	}
+
+	if (verbose)
+		printf("Allocated new binder device: major %d minor %d"
+		       " with name \"%s\"\n", device.major, device.minor,
+		       device.name);
+brexit:
+	close(fd);
+	return result;
+}
diff --git a/tests/binder/client.c b/tests/binder/client.c
new file mode 100644
index 0000000..e4e2a61
--- /dev/null
+++ b/tests/binder/client.c
@@ -0,0 +1,450 @@
+#include "binder_common.h"
+
+static int binder_parse(int fd, binder_uintptr_t ptr, binder_size_t size);
+static int transactions_complete;
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-c] [-n] [-r replies] [-v]\n"
+		"Where:\n\t"
+		"-c  Use the number of replies for the BR_TRANSACTION_COMPLETE"
+		" count.\n\t"
+		"-n  Use the /dev/binderfs name service.\n\t"
+		"-r  Number of replies expected that depends on the test.\n\t"
+		"    It can be the number of BR_TRANSACTION_COMPLETE if\n\t"
+		"    the -c option is set or number of times to issue the\n\t"
+		"    ioctl - BINDER_WRITE_READ command if -c not set.\n\t"
+		"-v  Print context and command information.\n\t"
+		"\nNote: Ensure this boolean command is run when "
+		"testing after a reboot:\n\t"
+		"setsebool allow_domain_fd_use=0\n", progname);
+	exit(-1);
+}
+
+static void client_alarm(int sig)
+{
+	fprintf(stderr, "Client timer expired waiting for Binder reply\n");
+	exit(-1);
+}
+
+/* This retrieves the Service Providers file descriptor, then using this
+ * sends a simple transaction to trigger the impersonate permission.
+ */
+static void extract_fd_and_respond(const struct binder_transaction_data *txn_in)
+{
+	int result;
+	uint32_t cmd;
+	struct stat sb;
+	struct binder_write_read bwr;
+	const struct binder_fd_object *obj;
+	struct {
+		uint32_t cmd;
+		struct binder_transaction_data txn;
+	} __attribute__((packed)) writebuf;
+	unsigned int readbuf[32];
+
+	binder_size_t *offs = (binder_size_t *)
+			      (binder_uintptr_t)txn_in->data.ptr.offsets;
+
+	/* Get the binder_fd_object that contains the Service Providers
+	 * binder file descriptor.
+	 */
+	obj = (const struct binder_fd_object *)
+	      (((char *)(binder_uintptr_t)txn_in->data.ptr.buffer) + *offs);
+
+	if (obj->hdr.type != BINDER_TYPE_FD) {
+		fprintf(stderr, "Header not BINDER_TYPE_FD: %d\n",
+			obj->hdr.type);
+		exit(130);
+	}
+
+	/* fstat this just to see if a valid fd */
+	result = fstat(obj->fd, &sb);
+	if (result < 0) {
+		fprintf(stderr, "Not a valid fd: %s\n", strerror(errno));
+		exit(131);
+	}
+
+	if (verbose)
+		printf("Client retrieved Service Providers fd: %d st_dev: %ld\n",
+		       obj->fd, sb.st_dev);
+
+	memset(&writebuf, 0, sizeof(writebuf));
+	memset(readbuf, 0, sizeof(readbuf));
+	memset(&bwr, 0, sizeof(bwr));
+
+	/* Send response using Service Providers fd to trigger
+	 * impersonate check.
+	 */
+	writebuf.cmd = BC_TRANSACTION;
+	writebuf.txn.target.handle = txn_in->target.handle;
+	writebuf.txn.cookie = txn_in->cookie;
+	writebuf.txn.code = txn_in->code;
+	writebuf.txn.flags = TF_ONE_WAY;
+
+	writebuf.txn.data_size = 0;
+	writebuf.txn.data.ptr.buffer = (binder_uintptr_t)NULL;
+	writebuf.txn.data.ptr.offsets = (binder_uintptr_t)NULL;
+	writebuf.txn.offsets_size = 0;
+
+	bwr.write_size = sizeof(writebuf);
+	bwr.write_consumed = 0;
+	bwr.write_buffer = (binder_uintptr_t)&writebuf;
+	bwr.read_size = sizeof(readbuf);
+	bwr.read_consumed = 0;
+	bwr.read_buffer = (binder_uintptr_t)readbuf;
+
+	result = ioctl(obj->fd, BINDER_WRITE_READ, &bwr);
+	if (result < 0) {
+		fprintf(stderr,
+			"Client ioctl BINDER_WRITE_READ error: %s\n",
+			strerror(errno));
+		exit(132);
+	}
+
+	if (verbose)
+		printf("Client read_consumed: %lld\n",
+		       bwr.read_consumed);
+
+	cmd = binder_parse(obj->fd, (binder_uintptr_t)readbuf,
+			   bwr.read_consumed);
+
+	if (cmd == BR_FAILED_REPLY ||
+	    cmd == BR_DEAD_REPLY ||
+	    cmd == BR_DEAD_BINDER) {
+		fprintf(stderr, "Client %s() failing command %s, exiting.\n",
+			__func__, cmd_name(cmd));
+		exit(133);
+	}
+
+	if (verbose)
+		printf("Client sent transaction using Service Providers FD: %d\n",
+		       obj->fd);
+}
+
+static void request_service_provider_fd(int fd, uint32_t handle)
+{
+	int result;
+	uint32_t cmd;
+	struct binder_write_read bwr;
+	struct {
+		uint32_t cmd;
+		struct binder_transaction_data txn;
+	} __attribute__((packed)) writebuf;
+	unsigned int readbuf[32];
+
+	memset(&writebuf, 0, sizeof(writebuf));
+	memset(readbuf, 0, sizeof(readbuf));
+	memset(&bwr, 0, sizeof(bwr));
+
+	writebuf.cmd = BC_TRANSACTION;
+	writebuf.txn.target.handle = handle;
+	writebuf.txn.cookie = 0;
+	writebuf.txn.code = TEST_SERVICE_SEND_CLIENT_SP_FD;
+	writebuf.txn.flags = TF_ACCEPT_FDS;
+
+	writebuf.txn.data_size = 0;
+	writebuf.txn.data.ptr.buffer = (binder_uintptr_t)NULL;
+	writebuf.txn.data.ptr.offsets = (binder_uintptr_t)NULL;
+	writebuf.txn.offsets_size = 0;
+
+	bwr.write_size = sizeof(writebuf);
+	bwr.write_consumed = 0;
+	bwr.write_buffer = (binder_uintptr_t)&writebuf;
+	bwr.read_size = sizeof(readbuf);
+	bwr.read_consumed = 0;
+	bwr.read_buffer = (binder_uintptr_t)readbuf;
+
+	if (verbose)
+		printf("Client sending transaction SEND_CLIENT_YOUR_BINDER_FD to handle: %d\n",
+		       handle);
+
+	result = ioctl(fd, BINDER_WRITE_READ, &bwr);
+	if (result < 0) {
+		fprintf(stderr, "Client ioctl BINDER_WRITE_READ error: %s\n",
+			strerror(errno));
+		exit(140);
+	}
+
+	cmd = binder_parse(fd, (binder_uintptr_t)readbuf, bwr.read_consumed);
+	if (cmd == BR_FAILED_REPLY ||
+	    cmd == BR_DEAD_REPLY ||
+	    cmd == BR_DEAD_BINDER) {
+		fprintf(stderr, "Client %s() failing command %s, exiting.\n",
+			__func__, cmd_name(cmd));
+		exit(141);
+	}
+}
+
+static void extract_handle_and_acquire(int fd,
+				       struct binder_transaction_data *txn_in)
+{
+	int result;
+	uint32_t acmd[2];
+	struct binder_write_read bwr;
+	const struct flat_binder_object *obj;
+	binder_size_t *offs = (binder_size_t *)
+			      (binder_uintptr_t)txn_in->data.ptr.offsets;
+
+	/* Get the fbo that contains the Service Provider's Handle. */
+	obj = (const struct flat_binder_object *)
+	      (((char *)(binder_uintptr_t)txn_in->data.ptr.buffer) + *offs);
+
+	if (obj->hdr.type != BINDER_TYPE_HANDLE) {
+		fprintf(stderr, "Client - Header not BINDER_TYPE_HANDLE: %d\n",
+			obj->hdr.type);
+		exit(150);
+	}
+
+	acmd[0] = BC_ACQUIRE;
+	acmd[1] = obj->handle;
+
+	memset(&bwr, 0, sizeof(bwr));
+	bwr.write_buffer = (binder_uintptr_t)&acmd;
+	bwr.write_size = sizeof(acmd);
+
+	result = ioctl(fd, BINDER_WRITE_READ, &bwr);
+	if (result < 0) {
+		fprintf(stderr,
+			"Client ioctl BINDER_WRITE_READ error: %s\n",
+			strerror(errno));
+		exit(151);
+	}
+
+	if (verbose)
+		printf("Client acquired binder handle: %d for Service Provider\n",
+		       obj->handle);
+
+	/* Now get their fd */
+	request_service_provider_fd(fd, obj->handle);
+
+}
+
+/* Parse response, reply as required and then return last CMD */
+static int binder_parse(int fd, binder_uintptr_t ptr, binder_size_t size)
+{
+	binder_uintptr_t end = ptr + size;
+	uint32_t cmd;
+
+	while (ptr < end) {
+		cmd = *(uint32_t *)ptr;
+		ptr += sizeof(uint32_t);
+
+		if (verbose)
+			printf("Client command: %s\n", cmd_name(cmd));
+
+		switch (cmd) {
+		case BR_NOOP:
+			break;
+		case BR_TRANSACTION_COMPLETE:
+			transactions_complete++;
+			break;
+		case BR_INCREFS:
+		case BR_ACQUIRE:
+		case BR_RELEASE:
+		case BR_DECREFS:
+			ptr += sizeof(const struct binder_ptr_cookie);
+			break;
+		case BR_TRANSACTION: {
+			struct binder_transaction_data *txn =
+				(struct binder_transaction_data *)ptr;
+
+			if (verbose) {
+				printf("Client BR_TRANSACTION data:\n");
+				print_trans_data(txn);
+			}
+
+			ptr += sizeof(*txn);
+			break;
+		}
+		case BR_REPLY: {
+			struct binder_transaction_data *txn =
+				(struct binder_transaction_data *)ptr;
+
+			if (verbose) {
+				printf("Client BR_REPLY data:\n");
+				print_trans_data(txn);
+			}
+
+			if (txn->code == TEST_SERVICE_GET)
+				extract_handle_and_acquire(fd, txn);
+
+			if (txn->code == TEST_SERVICE_SEND_CLIENT_SP_FD)
+				extract_fd_and_respond(txn);
+
+			ptr += sizeof(*txn);
+			break;
+		}
+		case BR_DEAD_BINDER:
+		case BR_FAILED_REPLY:
+		case BR_DEAD_REPLY:
+			break;
+		case BR_ERROR:
+			ptr += sizeof(uint32_t);
+			break;
+		default:
+			if (verbose)
+				printf("Client parsed unknown command: %d\n",
+				       cmd);
+			exit(160);
+		}
+	}
+	fflush(stdout);
+	return cmd;
+}
+
+int main(int argc, char **argv)
+{
+	int opt, result, fd, client_replies = 0, ioctl_wr = 0;
+	bool name = false;
+	bool use_transactions_complete = false;
+	uint32_t cmd;
+	pid_t pid;
+	char *context;
+	char dev_str[128];
+	void *map_base;
+	size_t map_size = BINDER_MMAP_SIZE;
+	struct binder_write_read bwr;
+	struct {
+		uint32_t cmd;
+		struct binder_transaction_data txn;
+	} __attribute__((packed)) writebuf;
+	unsigned int readbuf[32];
+
+	transactions_complete = 0;
+
+	while ((opt = getopt(argc, argv, "cnr:v")) != -1) {
+		switch (opt) {
+		case 'c':
+			use_transactions_complete = true;
+			break;
+		case 'n':
+			name = true;
+			break;
+		case 'r':
+			client_replies = atoi(optarg);
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	/* Get our context and pid */
+	result = getcon(&context);
+	if (result < 0) {
+		fprintf(stderr, "Client failed to obtain SELinux context\n");
+		exit(120);
+	}
+	pid = getpid();
+
+	if (verbose) {
+		printf("Client PID: %d Process context:\n\t%s\n",
+		       pid, context);
+	}
+	free(context);
+
+	if (name)
+		result = sprintf(dev_str, "%s/%s", BINDERFS_DEV, BINDERFS_NAME);
+	else
+		result = sprintf(dev_str, "%s", BINDER_DEV);
+
+	if (result < 0) {
+		fprintf(stderr, "Manager failed to obtain Binder dev name\n");
+		exit(121);
+	}
+
+	fd = open(dev_str, O_RDWR | O_CLOEXEC);
+	if (fd < 0) {
+		fprintf(stderr, "Cannot open %s error: %s\n", dev_str,
+			strerror(errno));
+		exit(122);
+	}
+
+	map_base = mmap(NULL, map_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (map_base == MAP_FAILED) {
+		fprintf(stderr, "mmap error: %s\n", strerror(errno));
+		close(fd);
+		exit(123);
+	}
+
+	memset(&bwr, 0, sizeof(bwr));
+	memset(&writebuf, 0, sizeof(writebuf));
+	memset(readbuf, 0, sizeof(readbuf));
+
+	writebuf.cmd = BC_TRANSACTION;
+	writebuf.txn.target.handle = TEST_SERVICE_MANAGER_HANDLE;
+	writebuf.txn.cookie = 0;
+	writebuf.txn.code = TEST_SERVICE_GET;
+	writebuf.txn.flags = TF_ACCEPT_FDS;
+
+	writebuf.txn.data_size = 0;
+	writebuf.txn.offsets_size = 0;
+
+	writebuf.txn.data.ptr.buffer = (binder_uintptr_t)NULL;
+	writebuf.txn.data.ptr.offsets = (binder_uintptr_t)NULL;
+
+	bwr.write_buffer = (binder_uintptr_t)&writebuf;
+	bwr.write_size = sizeof(writebuf);
+	bwr.write_consumed = 0;
+
+	if (verbose)
+		printf("Client sending transaction to Manager - TEST_SERVICE_GET\n");
+
+	/* Set an alarm just in case Binder does not reply when sitting
+	 * on the ioctl BINDER_WRITE_READ
+	 */
+	signal(SIGALRM, client_alarm);
+	alarm(10);
+
+	/* Each Client test expects a different number of replies */
+	while (true) {
+		memset(readbuf, 0, sizeof(readbuf));
+		bwr.read_size = sizeof(readbuf);
+		bwr.read_consumed = 0;
+		bwr.read_buffer = (binder_uintptr_t)readbuf;
+
+		result = ioctl(fd, BINDER_WRITE_READ, &bwr);
+		if (result < 0) {
+			fprintf(stderr,
+				"Client ioctl BINDER_WRITE_READ error: %s\n",
+				strerror(errno));
+			result = 124;
+			goto brexit;
+		}
+		ioctl_wr++;
+
+		if (verbose)
+			printf("Client read_consumed: %lld\n",
+			       bwr.read_consumed);
+
+		cmd = binder_parse(fd, (binder_uintptr_t)readbuf,
+				   bwr.read_consumed);
+
+		if (cmd == BR_FAILED_REPLY ||
+		    cmd == BR_DEAD_REPLY ||
+		    cmd == BR_DEAD_BINDER) {
+			fprintf(stderr, "Client %s() failing command %s, exiting.\n",
+				__func__, cmd_name(cmd));
+			result = 125;
+			goto brexit;
+		}
+
+		result = 0;
+		if (use_transactions_complete &&
+		    transactions_complete == client_replies)
+			break;
+		else if (!use_transactions_complete &&
+			 ioctl_wr == client_replies)
+			break;
+	}
+
+brexit:
+	munmap(map_base, map_size);
+	close(fd);
+
+	return result;
+}
diff --git a/tests/binder/manager.c b/tests/binder/manager.c
new file mode 100644
index 0000000..9922183
--- /dev/null
+++ b/tests/binder/manager.c
@@ -0,0 +1,362 @@
+#include "binder_common.h"
+
+/* Store the only service provider handle here. */
+uint32_t sp_handle;
+
+static int binder_parse(int fd, binder_uintptr_t ptr, binder_size_t size);
+static void reply_with_handle(int fd, struct binder_transaction_data *txn_in);
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-f file] [-n] [-v]\n"
+		"Where:\n\t"
+		"-f  Write a line to the file when listening starts.\n\t"
+		"-n  Use the /dev/binderfs name service.\n\t"
+		"-v  Print context and command information.\n\t"
+		"\nNote: Ensure this boolean command is run when "
+		"testing after a reboot:\n\t"
+		"setsebool allow_domain_fd_use=0\n", progname);
+	exit(-1);
+}
+
+static void do_service_manager(int fd, struct binder_transaction_data *txn_in)
+{
+	int result;
+	const struct flat_binder_object *obj;
+	struct binder_write_read bwr;
+	uint32_t acmd[2];
+	binder_size_t *offs;
+
+	struct {
+		uint32_t cmd_reply;
+		struct binder_transaction_data txn;
+	} __attribute__((packed)) reply;
+
+	switch (txn_in->code) {
+	case TEST_SERVICE_ADD:
+		offs = (binder_size_t *)(binder_uintptr_t)txn_in->data.ptr.offsets;
+
+		/* Get fbo that contains the Service Providers handle. */
+		obj = (const struct flat_binder_object *)
+		      (((char *)(binder_uintptr_t)txn_in->data.ptr.buffer) + *offs);
+
+		if (obj->hdr.type == BINDER_TYPE_HANDLE) {
+			sp_handle = obj->handle;
+
+			if (verbose)
+				printf("Manager has TEST_SERVICE_ADD obj->handle: %d\n",
+				       sp_handle);
+		} else {
+			fprintf(stderr, "Manager failed to obtain a handle\n");
+			exit(20);
+		}
+
+		acmd[0] = BC_ACQUIRE;
+		acmd[1] = obj->handle;
+
+		memset(&bwr, 0, sizeof(bwr));
+		bwr.write_buffer = (binder_uintptr_t)&acmd;
+		bwr.write_size = sizeof(acmd);
+
+		result = ioctl(fd, BINDER_WRITE_READ, &bwr);
+		if (result < 0) {
+			fprintf(stderr,
+				"Manager ioctl BINDER_WRITE_READ error: %s\n",
+				strerror(errno));
+			exit(21);
+		}
+
+		if (verbose)
+			printf("Manager acquired binder handle: %d for Service Provider\n",
+			       sp_handle);
+
+		/* Inform the Service Provider of outcome. */
+		reply.cmd_reply = BC_REPLY;
+		reply.txn.target.ptr = 0;
+		reply.txn.cookie = txn_in->cookie;
+		reply.txn.code = txn_in->code;
+		reply.txn.flags = TF_STATUS_CODE;
+		reply.txn.data_size = sizeof(int);
+		reply.txn.offsets_size = 0;
+		reply.txn.data.ptr.buffer = (binder_uintptr_t)&result;
+		reply.txn.data.ptr.offsets = 0;
+		binder_write(fd, &reply, sizeof(reply));
+		break;
+	case TEST_SERVICE_GET:
+		if (verbose)
+			printf("Manager has TEST_SERVICE_GET handle: %d\n",
+			       sp_handle);
+
+		reply_with_handle(fd, txn_in);
+
+		break;
+	case TEST_SERVICE_SEND_CLIENT_SP_FD:
+		if (verbose)
+			printf("Manager Rx'ed SEND_CLIENT_YOUR_BINDER_FD for handle: %d\n",
+			       txn_in->target.handle);
+		break;
+	default:
+		fprintf(stderr, "Manager unknown txn->code: %d for handle: %d\n",
+			txn_in->code, txn_in->target.handle);
+		exit(22);
+	}
+}
+
+static void reply_with_handle(int fd, struct binder_transaction_data *txn_in)
+{
+	int result;
+	unsigned int writebuf[1024];
+	binder_size_t offset = 0;
+	struct flat_binder_object obj;
+	struct binder_write_read bwr;
+	struct binder_transaction_data *txn;
+
+	if (verbose)
+		printf("Manager sending BC_REPLY to Client with handle\n");
+
+	memset(&writebuf, 0, sizeof(writebuf));
+	memset(&obj, 0, sizeof(obj));
+	memset(&bwr, 0, sizeof(bwr));
+
+	writebuf[0] = BC_REPLY;
+	txn = (struct binder_transaction_data *)(&writebuf[1]);
+	memset(txn, 0, sizeof(*txn));
+	txn->target.handle = txn_in->target.handle;
+	txn->cookie = txn_in->cookie;
+	txn->code = txn_in->code;
+	txn->flags = TF_ACCEPT_FDS;
+
+	obj.flags = 0x7f | FLAT_BINDER_FLAG_ACCEPTS_FDS;
+	obj.hdr.type = BINDER_TYPE_HANDLE;
+	obj.handle = sp_handle;
+	obj.cookie = 0;
+
+	txn->data_size = sizeof(obj);
+	txn->data.ptr.buffer = (binder_uintptr_t)&obj;
+	txn->data.ptr.offsets = (binder_uintptr_t)&offset;
+	txn->offsets_size = sizeof(offset);
+
+	bwr.write_buffer = (binder_uintptr_t)writebuf;
+	bwr.write_size = sizeof(writebuf[0]) + sizeof(*txn);
+
+	result = ioctl(fd, BINDER_WRITE_READ, &bwr);
+	if (result < 0) {
+		fprintf(stderr, "Manager ioctl BINDER_WRITE_READ error: %s\n",
+			strerror(errno));
+		exit(30);
+	}
+
+	if (verbose)
+		printf("Manager sent Service Provider handle: %d to Client\n",
+		       sp_handle);
+}
+
+/* Parse response, reply as required and then return last CMD */
+static int binder_parse(int fd, binder_uintptr_t ptr, binder_size_t size)
+{
+	binder_uintptr_t end = ptr + size;
+	uint32_t cmd;
+
+	while (ptr < end) {
+		cmd = *(uint32_t *)ptr;
+		ptr += sizeof(uint32_t);
+
+		if (verbose)
+			printf("Manager command: %s\n", cmd_name(cmd));
+
+		switch (cmd) {
+		case BR_NOOP:
+			break;
+		case BR_TRANSACTION_COMPLETE:
+			break;
+		case BR_INCREFS:
+		case BR_ACQUIRE:
+		case BR_RELEASE:
+		case BR_DECREFS:
+			ptr += sizeof(const struct binder_ptr_cookie);
+			break;
+		case BR_TRANSACTION: {
+			struct binder_transaction_data *txn =
+				(struct binder_transaction_data *)ptr;
+
+			if (verbose) {
+				printf("Manager BR_TRANSACTION data:\n");
+				print_trans_data(txn);
+			}
+
+			do_service_manager(fd, txn);
+			ptr += sizeof(*txn);
+			break;
+		}
+		case BR_REPLY: {
+			struct binder_transaction_data *txn =
+				(struct binder_transaction_data *)ptr;
+
+			if (verbose) {
+				printf("Manager BR_REPLY data:\n");
+				print_trans_data(txn);
+			}
+
+			ptr += sizeof(*txn);
+			break;
+		}
+		case BR_DEAD_BINDER:
+		case BR_FAILED_REPLY:
+		case BR_DEAD_REPLY:
+			break;
+		case BR_ERROR:
+			ptr += sizeof(uint32_t);
+			break;
+		default:
+			if (verbose)
+				printf("Manager parsed unknown command: %d\n",
+				       cmd);
+			exit(40);
+		}
+	}
+	fflush(stdout);
+	return cmd;
+}
+
+int main(int argc, char **argv)
+{
+	int opt, result, fd;
+	bool name = false;
+	pid_t pid;
+	char *context;
+	char *flag_file = NULL;
+	char dev_str[128];
+	FILE *flag_fd;
+	void *map_base;
+	size_t map_size = BINDER_MMAP_SIZE;
+	struct binder_write_read bwr;
+	unsigned int readbuf[32];
+
+	while ((opt = getopt(argc, argv, "f:nv")) != -1) {
+		switch (opt) {
+		case 'f':
+			flag_file = optarg;
+			break;
+		case 'n':
+			name = true;
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	/* Get our context and pid */
+	result = getcon(&context);
+	if (result < 0) {
+		fprintf(stderr, "Manager failed to obtain SELinux context\n");
+		exit(10);
+	}
+	pid = getpid();
+
+	if (verbose) {
+		printf("Manager PID: %d Process context:\n\t%s\n",
+		       pid, context);
+	}
+	free(context);
+
+	if (name)
+		result = sprintf(dev_str, "%s/%s", BINDERFS_DEV, BINDERFS_NAME);
+	else
+		result = sprintf(dev_str, "%s", BINDER_DEV);
+
+	if (result < 0) {
+		fprintf(stderr, "Manager failed to obtain Binder dev name\n");
+		exit(11);
+	}
+
+	fd = open(dev_str, O_RDWR | O_CLOEXEC);
+	if (fd < 0) {
+		fprintf(stderr, "Manager cannot open %s error: %s\n",
+			dev_str, strerror(errno));
+		exit(12);
+	}
+
+	map_base = mmap(NULL, map_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (map_base == MAP_FAILED) {
+		fprintf(stderr, "Manager mmap error: %s\n", strerror(errno));
+		close(fd);
+		exit(13);
+	}
+
+	result = ioctl(fd, BINDER_SET_CONTEXT_MGR, 0);
+	if (result < 0) {
+		fprintf(stderr,
+			"Manager failed to become context manager: %s\n",
+			strerror(errno));
+		result = 14;
+		goto brexit;
+	}
+
+	if (flag_file) {
+		flag_fd = fopen(flag_file, "w");
+		if (!flag_fd) {
+			fprintf(stderr,
+				"Manager failed to open %s: %s\n",
+				flag_file, strerror(errno));
+			result = 15;
+			goto brexit;
+		}
+		fprintf(flag_fd, "listening\n");
+		fclose(flag_fd);
+	}
+
+	memset(readbuf, 0, sizeof(readbuf));
+	memset(&bwr, 0, sizeof(bwr));
+
+	readbuf[0] = BC_ENTER_LOOPER;
+	bwr.write_size = sizeof(readbuf[0]);
+	bwr.write_consumed = 0;
+	bwr.write_buffer = (binder_uintptr_t)readbuf;
+	bwr.read_size = 0;
+	bwr.read_consumed = 0;
+	bwr.read_buffer = 0;
+
+	result = ioctl(fd, BINDER_WRITE_READ, &bwr);
+	if (result < 0) {
+		fprintf(stderr,
+			"Manager ioctl BINDER_WRITE_READ error: %s\n",
+			strerror(errno));
+		result = 16;
+		goto brexit;
+	}
+
+	while (true) {
+		memset(readbuf, 0, sizeof(readbuf));
+		bwr.read_size = sizeof(readbuf);
+		bwr.read_consumed = 0;
+		bwr.read_buffer = (binder_uintptr_t)readbuf;
+
+		result = ioctl(fd, BINDER_WRITE_READ, &bwr);
+		if (result < 0) {
+			fprintf(stderr,
+				"Manager ioctl BINDER_WRITE_READ error: %s\n",
+				strerror(errno));
+			result = 17;
+			goto brexit;
+		}
+
+		if (bwr.read_consumed == 0)
+			continue;
+
+		if (verbose)
+			printf("Manager read_consumed: %lld\n",
+			       bwr.read_consumed);
+
+		binder_parse(fd, (binder_uintptr_t)readbuf, bwr.read_consumed);
+	}
+
+brexit:
+	munmap(map_base, map_size);
+	close(fd);
+
+	return result;
+}
diff --git a/tests/binder/service_provider.c b/tests/binder/service_provider.c
new file mode 100644
index 0000000..2873af8
--- /dev/null
+++ b/tests/binder/service_provider.c
@@ -0,0 +1,404 @@
+#include "binder_common.h"
+
+static char *expected_ctx;
+static int binder_parse(int fd, binder_uintptr_t ptr, binder_size_t size);
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-e expected_ctx] [-f file] [-n] [-v]\n"
+		"Where:\n\t"
+		"-e  Expected security context.\n\t"
+		"-f  Write a line to the file when listening starts.\n\t"
+		"-n  Use the /dev/binderfs name service.\n\t"
+		"-v  Print context and command information.\n\t"
+		"\nNote: Ensure this boolean command is run when "
+		"testing after a reboot:\n\t"
+		"setsebool allow_domain_fd_use=0\n", progname);
+	exit(-1);
+}
+
+static void request_service_provider_fd(int fd,
+					struct binder_transaction_data *txn_in)
+{
+	int result;
+	unsigned int writebuf[1024];
+	struct binder_fd_object obj;
+	binder_size_t offset = 0;
+	struct binder_write_read bwr;
+	struct binder_transaction_data *txn;
+
+	if (txn_in->flags == TF_ONE_WAY && verbose) {
+		printf("Service Provider no reply to BC_TRANSACTION as flags = TF_ONE_WAY\n");
+		return;
+	}
+
+	if (verbose)
+		printf("Service Provider sending BC_REPLY with its FD\n");
+
+	memset(writebuf, 0, sizeof(writebuf));
+	memset(&bwr, 0, sizeof(bwr));
+	memset(&obj, 0, sizeof(obj));
+
+	writebuf[0] = BC_REPLY;
+	txn = (struct binder_transaction_data *)(&writebuf[1]);
+	memset(txn, 0, sizeof(*txn));
+	txn->target.handle = txn_in->target.handle;
+	txn->cookie = txn_in->cookie;
+	txn->code = txn_in->code;
+	txn->flags = TF_ACCEPT_FDS;
+
+	obj.hdr.type = BINDER_TYPE_FD;
+#if HAVE_BINDERFS
+	obj.pad_flags = 0x7f | FLAT_BINDER_FLAG_ACCEPTS_FDS |
+			FLAT_BINDER_FLAG_TXN_SECURITY_CTX;
+#else
+	obj.pad_flags = 0x7f | FLAT_BINDER_FLAG_ACCEPTS_FDS;
+#endif
+	obj.cookie = txn->cookie;
+	/* The Service Providers binder fd is used for testing as it allows
+	 * policy to set whether the Service Provider and Client can be
+	 * allowed access (fd use) or not.
+	 * This also allows a check for the impersonate permission later as
+	 * the Client will use the Service Provider fd to send a transaction.
+	 */
+	obj.fd = fd;
+
+	if (verbose)
+		printf("Service Provider handle: %d and its FD: %d\n",
+		       txn->target.handle, fd);
+
+	txn->data_size = sizeof(obj);
+	txn->data.ptr.buffer = (binder_uintptr_t)&obj;
+	txn->data.ptr.offsets = (binder_uintptr_t)&offset;
+	txn->offsets_size = sizeof(offset);
+
+	bwr.write_buffer = (binder_uintptr_t)writebuf;
+	bwr.write_size = sizeof(writebuf[0]) + sizeof(*txn);
+
+	result = ioctl(fd, BINDER_WRITE_READ, &bwr);
+	if (result < 0) {
+		fprintf(stderr,
+			"Service Provider ioctl BINDER_WRITE_READ error: %s\n",
+			strerror(errno));
+		exit(70);
+	}
+}
+
+/* Parse response, reply as required and then return last CMD */
+static int binder_parse(int fd, binder_uintptr_t ptr, binder_size_t size)
+{
+	binder_uintptr_t end = ptr + size;
+	uint32_t cmd;
+
+	while (ptr < end) {
+		cmd = *(uint32_t *)ptr;
+		ptr += sizeof(uint32_t);
+
+		if (verbose)
+			printf("Service Provider command: %s\n",
+			       cmd_name(cmd));
+
+		switch (cmd) {
+		case BR_NOOP:
+			break;
+		case BR_TRANSACTION_COMPLETE:
+			break;
+		case BR_INCREFS:
+		case BR_ACQUIRE:
+		case BR_RELEASE:
+		case BR_DECREFS:
+			ptr += sizeof(const struct binder_ptr_cookie);
+			break;
+		case BR_TRANSACTION: {
+			struct binder_transaction_data *txn =
+				(struct binder_transaction_data *)ptr;
+
+			if (verbose) {
+				printf("Service Provider BR_TRANSACTION data:\n");
+				print_trans_data(txn);
+			}
+
+			if (txn->code == TEST_SERVICE_SEND_CLIENT_SP_FD)
+				request_service_provider_fd(fd, txn);
+
+			ptr += sizeof(*txn);
+			break;
+		}
+#if HAVE_BINDERFS
+		case BR_TRANSACTION_SEC_CTX: {
+			struct binder_transaction_data_secctx *txn_ctx =
+				(struct binder_transaction_data_secctx *)ptr;
+
+			if (verbose) {
+				printf("\tclient context:\n\t\t%s\n",
+				       (char *)txn_ctx->secctx);
+				print_trans_data(&txn_ctx->transaction_data);
+			}
+
+			if (expected_ctx) {
+				int result = strcmp(expected_ctx,
+						    (char *)txn_ctx->secctx);
+				if (result) {
+					fprintf(stderr, "Service Provider received incorrect context:\n");
+					fprintf(stderr, "Expected: %s\nReceived: %s\n",
+						expected_ctx,
+						(char *)txn_ctx->secctx);
+					exit(80);
+				}
+			}
+
+			if (txn_ctx->transaction_data.code ==
+			    TEST_SERVICE_SEND_CLIENT_SP_FD)
+				request_service_provider_fd(fd,
+							    &txn_ctx->transaction_data);
+
+			ptr += sizeof(*txn_ctx);
+			break;
+		}
+#endif
+		case BR_REPLY: {
+			struct binder_transaction_data *txn =
+				(struct binder_transaction_data *)ptr;
+
+			if (verbose) {
+				printf("Service Provider BR_REPLY data:\n");
+				print_trans_data(txn);
+			}
+
+			ptr += sizeof(*txn);
+			break;
+		}
+		case BR_DEAD_BINDER:
+		case BR_FAILED_REPLY:
+		case BR_DEAD_REPLY:
+			break;
+		case BR_ERROR:
+			ptr += sizeof(uint32_t);
+			break;
+		default:
+			if (verbose)
+				printf("Service Provider parsed unknown command: %d\n",
+				       cmd);
+			exit(81);
+		}
+	}
+	fflush(stdout);
+	return cmd;
+}
+
+int main(int argc, char **argv)
+{
+	int opt, result, fd;
+	bool name = false;
+	uint32_t cmd;
+	pid_t pid;
+	char *context;
+	char *flag_file = NULL;
+	char dev_str[128];
+	FILE *flag_fd;
+	void *map_base;
+	size_t map_size = BINDER_MMAP_SIZE;
+	binder_size_t offset = 0;
+	struct binder_write_read bwr;
+	struct flat_binder_object obj;
+	struct {
+		uint32_t cmd;
+		struct binder_transaction_data txn;
+	} __attribute__((packed)) writebuf;
+	unsigned int readbuf[32];
+
+	expected_ctx = NULL;
+
+	while ((opt = getopt(argc, argv, "e:f:nv")) != -1) {
+		switch (opt) {
+		case 'e':
+			expected_ctx = optarg;
+			break;
+		case 'f':
+			flag_file = optarg;
+			break;
+		case 'n':
+			name = true;
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	/* Get our context and pid */
+	result = getcon(&context);
+	if (result < 0) {
+		fprintf(stderr, "Service Provider failed to obtain SELinux context\n");
+		exit(60);
+	}
+	pid = getpid();
+
+	if (verbose) {
+		printf("Service Provider PID: %d Process context:\n\t%s\n",
+		       pid, context);
+	}
+	free(context);
+
+	if (name)
+		result = sprintf(dev_str, "%s/%s", BINDERFS_DEV, BINDERFS_NAME);
+	else
+		result = sprintf(dev_str, "%s", BINDER_DEV);
+
+	if (result < 0) {
+		fprintf(stderr, "Manager failed to obtain Binder dev name\n");
+		exit(61);
+	}
+
+	fd = open(dev_str, O_RDWR | O_CLOEXEC);
+	if (fd < 0) {
+		fprintf(stderr, "Cannot open %s error: %s\n", dev_str,
+			strerror(errno));
+		exit(62);
+	}
+
+	map_base = mmap(NULL, map_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (map_base == MAP_FAILED) {
+		fprintf(stderr, "mmap error: %s\n", strerror(errno));
+		close(fd);
+		exit(63);
+	}
+
+	if (flag_file) {
+		flag_fd = fopen(flag_file, "w");
+		if (!flag_fd) {
+			fprintf(stderr,
+				"Service Provider failed to open %s: %s\n",
+				flag_file, strerror(errno));
+			result = 64;
+			goto brexit;
+		}
+		fprintf(flag_fd, "listening\n");
+		fclose(flag_fd);
+	}
+
+	memset(&writebuf, 0, sizeof(writebuf));
+	memset(&obj, 0, sizeof(obj));
+	memset(readbuf, 0, sizeof(readbuf));
+
+	writebuf.cmd = BC_TRANSACTION;
+	writebuf.txn.target.handle = TEST_SERVICE_MANAGER_HANDLE;
+	writebuf.txn.cookie = 0;
+	writebuf.txn.code = TEST_SERVICE_ADD;
+	writebuf.txn.flags = TF_ROOT_OBJECT;
+
+	obj.hdr.type = BINDER_TYPE_BINDER;
+#if HAVE_BINDERFS
+	obj.flags = 0x7f | FLAT_BINDER_FLAG_ACCEPTS_FDS |
+		    FLAT_BINDER_FLAG_TXN_SECURITY_CTX;
+#else
+	obj.flags = 0x7f | FLAT_BINDER_FLAG_ACCEPTS_FDS;
+#endif
+	obj.binder = (binder_uintptr_t)NULL;
+	obj.cookie = 0;
+
+	writebuf.txn.data_size = sizeof(obj);
+	writebuf.txn.offsets_size = sizeof(offset);
+
+	writebuf.txn.data.ptr.buffer = (binder_uintptr_t)&obj;
+	writebuf.txn.data.ptr.offsets = (binder_uintptr_t)&offset;
+
+	bwr.write_buffer = (binder_uintptr_t)&writebuf;
+	bwr.write_size = sizeof(writebuf);
+	bwr.write_consumed = 0;
+
+	if (verbose)
+		printf("Service Provider sending transaction to Manager - TEST_SERVICE_ADD\n");
+
+	bwr.read_size = sizeof(readbuf);
+	bwr.read_consumed = 0;
+	bwr.read_buffer = (binder_uintptr_t)readbuf;
+
+	result = ioctl(fd, BINDER_WRITE_READ, &bwr);
+	if (result < 0) {
+		fprintf(stderr,
+			"Service Provider ioctl BINDER_WRITE_READ error: %s\n",
+			strerror(errno));
+		result = 65;
+		goto brexit;
+	}
+
+	if (verbose)
+		printf("Service Provider read_consumed: %lld\n",
+		       bwr.read_consumed);
+
+	cmd = binder_parse(fd, (binder_uintptr_t)readbuf,
+			   bwr.read_consumed);
+
+	if (cmd == BR_FAILED_REPLY ||
+	    cmd == BR_DEAD_REPLY ||
+	    cmd == BR_DEAD_BINDER) {
+		fprintf(stderr, "Service Provider %s() failing command %s, exiting.\n",
+			__func__, cmd_name(cmd));
+		result = 66;
+		goto brexit;
+	}
+
+	/* Service Provider loops on commands */
+	memset(readbuf, 0, sizeof(readbuf));
+	readbuf[0] = BC_ENTER_LOOPER;
+	bwr.write_size = sizeof(readbuf[0]);
+	bwr.write_consumed = 0;
+	bwr.write_buffer = (binder_uintptr_t)readbuf;
+
+	bwr.read_size = 0;
+	bwr.read_consumed = 0;
+	bwr.read_buffer = 0;
+
+	result = ioctl(fd, BINDER_WRITE_READ, &bwr);
+	if (result < 0) {
+		fprintf(stderr,
+			"Service Provider ioctl BINDER_WRITE_READ error: %s\n",
+			strerror(errno));
+		result = 67;
+		goto brexit;
+	}
+
+	while (true) {
+		memset(readbuf, 0, sizeof(readbuf));
+		bwr.read_size = sizeof(readbuf);
+		bwr.read_consumed = 0;
+		bwr.read_buffer = (binder_uintptr_t)readbuf;
+
+		result = ioctl(fd, BINDER_WRITE_READ, &bwr);
+		if (result < 0) {
+			fprintf(stderr,
+				"Service Provider ioctl BINDER_WRITE_READ error: %s\n",
+				strerror(errno));
+			result = 68;
+			goto brexit;
+		}
+
+		if (bwr.read_consumed == 0)
+			continue;
+
+		if (verbose)
+			printf("Service Provider read_consumed: %lld\n",
+			       bwr.read_consumed);
+
+		cmd = binder_parse(fd, (binder_uintptr_t)readbuf, bwr.read_consumed);
+
+		if (cmd == BR_FAILED_REPLY ||
+		    cmd == BR_DEAD_REPLY ||
+		    cmd == BR_DEAD_BINDER) {
+			fprintf(stderr, "Service Provider %s() failing command %s, exiting.\n",
+				__func__, cmd_name(cmd));
+			result = 69;
+			goto brexit;
+		}
+	}
+
+brexit:
+	munmap(map_base, map_size);
+	close(fd);
+
+	return result;
+}
diff --git a/tests/binder/test b/tests/binder/test
index e8aaec4..2ccaa23 100755
--- a/tests/binder/test
+++ b/tests/binder/test
@@ -5,7 +5,11 @@ BEGIN {
     $basedir = $0;
     $basedir =~ s|(.*)/[^/]*|$1|;
 
-    # allow binder info to be shown
+    $test_count      = 0;
+    $test_binderfs   = 0;
+    $test_binder_ctx = 0;
+
+    # Allow binder info to be shown.
     $v = $ARGV[0];
     if ($v) {
         if ( $v ne "-v" ) {
@@ -17,10 +21,10 @@ BEGIN {
     }
 
     # check if binder driver available and kernel/userspace versions.
-    $result = system("$basedir/check_binder 2> /dev/null");
+    $result = system("$basedir/check_binder $v 2>/dev/null");
 
     if ( $result >> 8 eq 0 ) {
-        plan tests => 6;
+        $test_count += 7;
     }
     elsif ( $result >> 8 eq 1 ) {
         plan skip_all => "Binder not supported by kernel";
@@ -31,73 +35,238 @@ BEGIN {
     else {
         plan skip_all => "Error checking Binder driver";
     }
+
+    # Check if kernel may have "binder: Add thread->process_todo flag" patch.
+    # This has been backported to some earlier kernels.
+    # Patch available from: https://lore.kernel.org/patchwork/patch/851324/
+    $kvercur = `uname -r`;
+    chomp($kvercur);
+    $kverminstream = "4.16";
+    $result        = `$basedir/../kvercmp $kvercur $kverminstream`;
+    if ( $result < 0 ) {
+        print "This $kvercur kernel may fail some tests, if so may require\n";
+        print
+          "\"binder: Add thread->process_todo flag\" patch available from:\n";
+        print "https://lore.kernel.org/patchwork/patch/851324/\n";
+    }
+
+    # Check if kernel supports binderfs and return of security context.
+    $kverminstream = "5.0";
+    $result        = `$basedir/../kvercmp $kvercur $kverminstream`;
+
+    if ( $result > 0 ) {
+        $test_binder_ctx = 1;
+        $test_count += 1;
+        system("mkdir /dev/binderfs 2>/dev/null");
+        system(
+"mount -t binder binder /dev/binderfs -o context=system_u:object_r:device_t:s0 2>/dev/null"
+        );
+        $result = system("$basedir/check_binderfs $v 2>/dev/null");
+        if ( $result == 0 ) {
+            $test_binderfs = 1;
+            $test_count += 8;
+        }
+        elsif ( $result >> 8 eq 1 or $result >> 8 eq 2 ) {
+            print
+"Error BINDERFS: May require kernel \"CONFIG_ANDROID_BINDERFS=y\" or test rebuild.\n";
+            system("umount binder 2>/dev/null");
+            system("rmdir /dev/binderfs 2>/dev/null");
+        }
+    }
+
+    plan tests => $test_count;
 }
 
-sub manager_start {
-    my ( $runcon_args, $args ) = @_;
+sub service_start {
+    my ( $service, $runcon_args, $args ) = @_;
     my $pid;
+    my $flag = $service . "_flag";
 
-    system("mkfifo $basedir/flag");
+    system("mkfifo $basedir/$flag");
 
     if ( ( $pid = fork() ) == 0 ) {
-        exec "runcon $runcon_args $basedir/test_binder -f $basedir/flag $args";
+        exec "runcon $runcon_args $basedir/$service -f $basedir/$flag $args";
     }
 
     # Wait for it to initialize.
-    system("cat $basedir/flag >/dev/null");
+    system("cat $basedir/$flag >/dev/null");
     return $pid;
 }
 
-sub manager_end {
-    my ($pid) = @_;
+sub service_end {
+    my ( $service, $pid ) = @_;
+    my $flag = $service . "_flag";
 
     kill KILL, $pid;
-    system("rm -f $basedir/flag");
+    system("rm -f $basedir/$flag");
 }
 
-$pid = manager_start( "-t test_binder_mgr_t", "$v manager" );
+$sm_pid = service_start( "manager", "-t test_binder_mgr_t", "$v" );
+$sp_pid =
+  service_start( "service_provider", "-t test_binder_provider_t", "$v" );
 
-# 1 Verify that authorized provider can transact with the manager.
-$result =
-  system
-  "runcon -t test_binder_provider_t $basedir/test_binder $v -r 1 provider";
+# 1 Verify that authorized client and service provider can communicate with the binder service manager.
+$result = system "runcon -t test_binder_client_t $basedir/client $v -c -r 3";
 ok( $result eq 0 );
 
-# 2 Verify that provider cannot call manager (no call perm).
-$result = system
-"runcon -t test_binder_provider_no_call_t $basedir/test_binder $v -r 2 provider 2>&1";
-ok( $result >> 8 eq 8 );
-
-# 3 Verify that provider cannot communicate with manager (no impersonate perm).
-$result = system
-"runcon -t test_binder_provider_no_im_t $basedir/test_binder $v -r 2 provider 2>&1";
-ok( $result >> 8 eq 103 );
-
-# 4 Verify that provider cannot communicate with manager (no transfer perm).
-$result = system
-"runcon -t test_binder_provider_no_transfer_t $basedir/test_binder $v -r 1 provider 2>&1";
-ok( $result >> 8 eq 8 );
-
-# Kill the manager.
-manager_end($pid);
+# 2 Verify that client cannot call manager (no call perm).
+$result =
+  system
+  "runcon -t test_binder_client_no_call_mgr_t $basedir/client $v -r 1 2>&1";
+ok( $result >> 8 eq 125 );
 
-# 5 Verify that provider cannot become a manager (no set_context_mgr perm).
+# 3 Verify that client cannot call service provider (no call perm).
 $result =
   system
-  "runcon -t test_binder_provider_t $basedir/test_binder $v manager 2>&1";
-ok( $result >> 8 eq 4 );
+  "runcon -t test_binder_client_no_call_sp_t $basedir/client $v -r 2 2>&1";
+ok( $result >> 8 eq 141 );
 
-# Start manager to test that selinux_binder_transfer_file() fails when fd { use } is denied by policy.
-$pid = manager_start( "-t test_binder_mgr_no_fd_t", "$v manager" );
+# 4 Verify that client cannot communicate with service provider (no impersonate perm).
+$result =
+  system "runcon -t test_binder_client_no_im_t $basedir/client $v -r 2 2>&1";
+ok( $result >> 8 eq 133 );
 
-# 6 Verify that authorized provider can communicate with the server, however the fd passed will not be valid for manager
-# domain and binder will return BR_FAILED_REPLY.
+# 5 Verify that client cannot communicate with service provider (no transfer perm).
 $result =
   system
-  "runcon -t test_binder_provider_t $basedir/test_binder $v provider -r 2 2>&1";
-ok( $result >> 8 eq 8 );
+  "runcon -t test_binder_client_no_transfer_t $basedir/client $v -r 2 2>&1";
+ok( $result >> 8 eq 125 );
+
+# Kill the service provider & manager before next tests:
+service_end( "service_provider", $sp_pid );
+service_end( "manager",          $sm_pid );
+
+# 6 Verify that provider domain cannot become a manager (no set_context_mgr perm).
+$result = system "runcon -t test_binder_provider_t $basedir/manager $v 2>&1";
+ok( $result >> 8 eq 14 );
+
+# 7 Test that selinux_binder_transfer_file() fails when fd { use } is denied by policy.
+#   Note that this test requires the Reference Policy boolean "allow_domain_fd_use" set to FALSE.
+#   (setsebool allow_domain_fd_use=0)
+# 7a Start Manager
+$sm_pid = service_start( "manager", "-t test_binder_mgr_t", "$v" );
+
+# 7b Start Service Provider
+$sp_pid =
+  service_start( "service_provider", "-t test_binder_provider_no_fd_t", "$v" );
+
+# 7c Verify that authorized client can communicate with the service provider, however the sp's binder fd passed
+#    to the client will not be valid for service provider domain and binder will return BR_FAILED_REPLY.
+$result = system "runcon -t test_binder_client_t $basedir/client $v -r2 2>&1";
+ok( $result >> 8 eq 141 );
 
-# Kill the manager
-manager_end($pid);
+# Kill the service provider & manager
+service_end( "service_provider", $sp_pid );
+service_end( "manager",          $sm_pid );
+
+if ($test_binder_ctx) {
+    #### Binder return security context test ######################
+    #
+    $sm_pid = service_start( "manager", "-t test_binder_mgr_t", "$v" );
+    $sp_pid = service_start(
+        "service_provider",
+        "-t test_binder_provider_t",
+        "$v -e unconfined_u:unconfined_r:test_binder_client_t:s0-s0:c0.c1023"
+    );
+
+# 8 Verify that authorized client and service provider can communicate with the binder service manager.
+#   Also check that the service provider can receive the Clients security context.
+    $result =
+      system "runcon -t test_binder_client_t $basedir/client $v -c -r 3";
+    ok( $result eq 0 );
+
+    # Kill the service provider & manager.
+    service_end( "service_provider", $sp_pid );
+    service_end( "manager",          $sm_pid );
+}
+
+if ($test_binderfs) {
+    #### Linux 5.0+ Test binder 'Dynamically Allocated Binder Devices'.
+    $sm_pid = service_start( "manager", "-t test_binder_mgr_t", "$v -n" );
+    $sp_pid =
+      service_start( "service_provider", "-t test_binder_provider_t", "$v -n" );
+
+# 9 Verify that authorized client and service provider can communicate with the binder service manager.
+    $result =
+      system "runcon -t test_binder_client_t $basedir/client $v -n -c -r 3";
+    ok( $result eq 0 );
+
+    # 10 Verify that client cannot call manager (no call perm).
+    $result =
+      system
+"runcon -t test_binder_client_no_call_mgr_t $basedir/client $v -n -r 1 2>&1";
+    ok( $result >> 8 eq 125 );
+
+    # 11 Verify that client cannot call service provider (no call perm).
+    $result =
+      system
+"runcon -t test_binder_client_no_call_sp_t $basedir/client $v -n -r 2 2>&1";
+    ok( $result >> 8 eq 141 );
+
+# 12 Verify that client cannot communicate with service provider (no impersonate perm).
+    $result =
+      system
+      "runcon -t test_binder_client_no_im_t $basedir/client $v -n -r 2 2>&1";
+    ok( $result >> 8 eq 133 );
+
+# 13 Verify that client cannot communicate with service provider (no transfer perm).
+    $result =
+      system
+"runcon -t test_binder_client_no_transfer_t $basedir/client $v -n -r 2 2>&1";
+    ok( $result >> 8 eq 125 );
+
+    # Kill the service provider & manager before next tests:
+    service_end( "service_provider", $sp_pid );
+    service_end( "manager",          $sm_pid );
+
+# 14 Verify that provider domain cannot become a manager (no set_context_mgr perm).
+    $result =
+      system "runcon -t test_binder_provider_t $basedir/manager $v -n 2>&1";
+    ok( $result >> 8 eq 14 );
+
+# 15 Test that selinux_binder_transfer_file() fails when fd { use } is denied by policy.
+#    Note that this test requires the Reference Policy boolean "allow_domain_fd_use" set to FALSE.
+#    (setsebool allow_domain_fd_use=0)
+# 15a Start Manager
+    $sm_pid = service_start( "manager", "-t test_binder_mgr_t", "$v -n" );
+
+    # 15b Start Service Provider
+    $sp_pid =
+      service_start( "service_provider", "-t test_binder_provider_no_fd_t",
+        "$v -n" );
+
+# 15c Verify that authorized client can communicate with the service provider, however the sp's binder fd passed
+#    to the client will not be valid for service provider domain and binder will return BR_FAILED_REPLY.
+    $result =
+      system "runcon -t test_binder_client_t $basedir/client $v -n -r2 2>&1";
+    ok( $result >> 8 eq 141 );
+
+    # Kill the service provider & manager
+    service_end( "service_provider", $sp_pid );
+    service_end( "manager",          $sm_pid );
+
+    #### Binder return security context test #########################
+    #
+    $sm_pid = service_start( "manager", "-t test_binder_mgr_t", "$v -n" );
+    $sp_pid = service_start(
+        "service_provider",
+        "-t test_binder_provider_t",
+        "$v -n -e unconfined_u:unconfined_r:test_binder_client_t:s0-s0:c0.c1023"
+    );
+
+# 16 Verify that authorized client and service provider can communicate with the binder service manager.
+#    Also check that the service provider can receive the Clients security context.
+    $result =
+      system "runcon -t test_binder_client_t $basedir/client $v -n -c -r 3";
+    ok( $result eq 0 );
+
+    # Kill the service provider & manager.
+    service_end( "service_provider", $sp_pid );
+    service_end( "manager",          $sm_pid );
+
+    # Cleanup binderfs stuff.
+    system("umount binder 2>/dev/null");
+    system("rmdir /dev/binderfs 2>/dev/null");
+}
 
 exit;
diff --git a/tests/binder/test_binder.c b/tests/binder/test_binder.c
deleted file mode 100644
index 62194bf..0000000
--- a/tests/binder/test_binder.c
+++ /dev/null
@@ -1,705 +0,0 @@
-/*
- * This is a simple binder Service Manager/Service Provider that only uses
- * the raw ioctl commands to test the SELinux binder permissions:
- *     set_context_mgr, call, transfer, impersonate.
- *
- * Using binder test policy the following will be validated:
- *    security_binder_set_context_mgr() binder { set_context_mgr }
- *    security_binder_transaction()     binder { call impersonate }
- *    security_binder_transfer_binder() binder { transfer }
- *    security_binder_transfer_file()   fd { use }
- *
- * TODO security_binder_transfer_file() uses BPF if configured in kernel.
- */
-
-#include <errno.h>
-#include <fcntl.h>
-#include <inttypes.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include <sys/stat.h>
-#include <stdbool.h>
-#include <sys/mman.h>
-#include <sys/ioctl.h>
-#include <selinux/selinux.h>
-#include <linux/android/binder.h>
-
-/* These are the Binder txn->code values used by the Service Provider and
- * Manager to request/retrieve a binder handle.
- */
-#define ADD_TEST_SERVICE 100 /* Sent by Service Provider */
-#define GET_TEST_SERVICE 101 /* Sent by Client */
-
-#define TEST_SERVICE_MANAGER_HANDLE 0
-
-static int binder_parse(int fd, uintptr_t ptr, size_t size, bool manager);
-
-static bool verbose;
-uint32_t sp_handle;
-static unsigned char *shm_base;
-static int shm_fd;
-static int shm_size = 32;
-
-static void usage(char *progname)
-{
-	fprintf(stderr,
-		"usage:  %s [-f file] [-r replies] [-v] manager | provider\n"
-		"Where:\n\t"
-		"-f       Write a line to the file when listening starts.\n\t"
-		"-r       Number of replies to expect from test - default 0.\n\t"
-		"-v       Print context and command information.\n\t"
-		"manager  Act as Service Manager.\n\t"
-		"service  Act as Service Provider.\n"
-		"\nNote: Ensure this boolean command is run when "
-		"testing after a reboot:\n\t"
-		"setsebool allow_domain_fd_use=0\n", progname);
-	exit(-1);
-}
-
-/* Create a small piece of shared memory between the Manager and Service
- * Provider to share a handle as explained in the do_service_manager()
- * function.
- */
-static void create_shm(bool manager)
-{
-	char *name =  "sp_handle";
-
-	if (manager)
-		shm_fd = shm_open(name, O_CREAT | O_RDWR, 0666);
-	else
-		shm_fd = shm_open(name, O_RDONLY, 0666);
-	if (shm_fd < 0) {
-		fprintf(stderr, "%s shm_open: %s\n", __func__, strerror(errno));
-		exit(-1);
-	}
-
-	ftruncate(shm_fd, shm_size);
-
-	if (manager)
-		shm_base = mmap(0, shm_size, PROT_READ | PROT_WRITE, MAP_SHARED,
-				shm_fd, 0);
-	else
-		shm_base = mmap(0, shm_size, PROT_READ, MAP_SHARED, shm_fd, 0);
-	if (shm_base == MAP_FAILED) {
-		fprintf(stderr, "%s mmap: %s\n", __func__, strerror(errno));
-		close(shm_fd);
-		exit(-1);
-	}
-}
-
-static const char *cmd_name(uint32_t cmd)
-{
-	switch (cmd) {
-	case BR_NOOP:
-		return "BR_NOOP";
-	case BR_TRANSACTION_COMPLETE:
-		return "BR_TRANSACTION_COMPLETE";
-	case BR_INCREFS:
-		return "BR_INCREFS";
-	case BR_ACQUIRE:
-		return "BR_ACQUIRE";
-	case BR_RELEASE:
-		return "BR_RELEASE";
-	case BR_DECREFS:
-		return "BR_DECREFS";
-	case BR_TRANSACTION:
-		return "BR_TRANSACTION";
-	case BR_REPLY:
-		return "BR_REPLY";
-	case BR_FAILED_REPLY:
-		return "BR_FAILED_REPLY";
-	case BR_DEAD_REPLY:
-		return "BR_DEAD_REPLY";
-	case BR_DEAD_BINDER:
-		return "BR_DEAD_BINDER";
-	case BR_ERROR:
-		return "BR_ERROR";
-	/* fallthrough */
-	default:
-		return "Unknown command";
-	}
-}
-
-static void print_trans_data(struct binder_transaction_data *txn_in)
-{
-	struct flat_binder_object *obj;
-	binder_size_t *offs = (binder_size_t *)
-			      (uintptr_t)txn_in->data.ptr.offsets;
-	size_t count = txn_in->offsets_size / sizeof(binder_size_t);
-
-	printf("\thandle: %ld\n", (unsigned long)txn_in->target.handle);
-	printf("\tcookie: %lld\n", txn_in->cookie);
-	printf("\tcode: %d\n", txn_in->code);
-	switch (txn_in->flags) {
-	case TF_ONE_WAY:
-		printf("\tflag: TF_ONE_WAY\n");
-		break;
-	case TF_ROOT_OBJECT:
-		printf("\tflag: TF_ROOT_OBJECT\n");
-		break;
-	case TF_STATUS_CODE:
-		printf("\tflag: TF_STATUS_CODE\n");
-		break;
-	case TF_ACCEPT_FDS:
-		printf("\tflag: TF_ACCEPT_FDS\n");
-		break;
-	default:
-		printf("Unknown flag: %x\n", txn_in->flags);
-		return;
-	}
-	printf("\tsender pid: %u\n", txn_in->sender_pid);
-	printf("\tsender euid: %u\n", txn_in->sender_euid);
-	printf("\tdata_size: %llu\n", txn_in->data_size);
-	printf("\toffsets_size: %llu\n", txn_in->offsets_size);
-
-	while (count--) {
-		obj = (struct flat_binder_object *)
-		      (((char *)(uintptr_t)txn_in->data.ptr.buffer) + *offs++);
-
-		switch (obj->hdr.type) {
-		case BINDER_TYPE_BINDER:
-			printf("\thdr: BINDER_TYPE_BINDER\n");
-			printf("\tbinder: %llx\n", obj->binder);
-			break;
-		case BINDER_TYPE_HANDLE:
-			printf("\thdr: BINDER_TYPE_HANDLE\n");
-			printf("\thandle: %x\n", obj->handle);
-			break;
-		case BINDER_TYPE_FD:
-			printf("\thdr: BINDER_TYPE_FD\n");
-			printf("\tfd: %x\n", obj->handle);
-			break;
-		default:
-			printf("Unknown header: %u\n", obj->hdr.type);
-			return;
-		}
-		printf("\tflags: priority: 0x%x accept FDS: %s\n",
-		       obj->flags & FLAT_BINDER_FLAG_PRIORITY_MASK,
-		       obj->flags & FLAT_BINDER_FLAG_ACCEPTS_FDS ? "YES" : "NO");
-		printf("\tcookie: %llx\n", obj->cookie);
-	}
-}
-
-/* If add a service provider, then obtain a handle for it and store in
- * shared memory. The handle will then be used by the service provider
- * process to contact the Manager for its file descriptor, thus triggering
- * the 'impersonate' permission (as current_sid() != task_sid(from))
- * It is done this way as being a cheapskate it saved adding code to the
- * GET_TEST_SERVICE process plus running a Client as well. This achieves
- * the same objective.
- */
-static void do_service_manager(int fd, struct binder_transaction_data *txn_in)
-{
-	int result;
-	struct flat_binder_object *obj;
-	struct binder_write_read bwr;
-	uint32_t acmd[2];
-	binder_size_t *offs;
-
-	switch (txn_in->code) {
-	case ADD_TEST_SERVICE:
-		offs = (binder_size_t *)(uintptr_t)txn_in->data.ptr.offsets;
-
-		/* Get fbo that contains the Managers binder file descriptor. */
-		obj = (struct flat_binder_object *)
-		      (((char *)(uintptr_t)txn_in->data.ptr.buffer) + *offs);
-
-		if (obj->hdr.type == BINDER_TYPE_HANDLE) {
-			sp_handle = obj->handle;
-			memcpy(shm_base, &sp_handle, sizeof(sp_handle));
-			if (verbose)
-				printf("Manager has BINDER_TYPE_HANDLE obj->handle: %d\n",
-				       sp_handle);
-		} else {
-			fprintf(stderr, "Failed to obtain a handle\n");
-			exit(-1);
-		}
-
-		acmd[0] = BC_ACQUIRE;
-		acmd[1] = obj->handle;
-
-		memset(&bwr, 0, sizeof(bwr));
-		bwr.write_buffer = (uintptr_t)&acmd;
-		bwr.write_size = sizeof(acmd);
-
-		result = ioctl(fd, BINDER_WRITE_READ, &bwr);
-		if (result < 0) {
-			fprintf(stderr,
-				"ServiceProvider ioctl BINDER_WRITE_READ: %s\n",
-				strerror(errno));
-			exit(-1);
-		}
-
-		if (verbose)
-			printf("Manager acquired handle: %d for Service Provider\n",
-			       sp_handle);
-		break;
-
-	case GET_TEST_SERVICE:
-		if (verbose)
-			printf("GET_TEST_SERVICE not supported\n");
-		break;
-	default:
-		fprintf(stderr, "Unknown txn->code: %d\n", txn_in->code);
-		exit(-1);
-	}
-}
-
-static void request_manager_fd(int fd, struct binder_transaction_data *txn_in)
-{
-	int result;
-	unsigned int writebuf[1024];
-	struct binder_fd_object obj;
-	binder_size_t offset = 0;
-	struct binder_write_read bwr;
-	struct binder_transaction_data *txn;
-
-	if (txn_in->flags == TF_ONE_WAY) {
-		if (verbose)
-			printf("Manager no reply to BC_TRANSACTION as flags = TF_ONE_WAY\n");
-		return;
-	}
-
-	if (verbose)
-		printf("Manager sending BC_REPLY to obtain its FD\n");
-
-	writebuf[0] = BC_REPLY;
-	txn = (struct binder_transaction_data *)(&writebuf[1]);
-
-	memset(txn, 0, sizeof(*txn));
-	txn->target.handle = txn_in->target.handle;
-	txn->cookie = txn_in->cookie;
-	txn->code = txn_in->code;
-	txn->flags = TF_ACCEPT_FDS;
-	memset(&obj, 0, sizeof(obj));
-	obj.hdr.type = BINDER_TYPE_FD;
-	obj.pad_flags = 0x7f | FLAT_BINDER_FLAG_ACCEPTS_FDS;
-	obj.cookie = txn->cookie;
-	/* The binder fd is used for testing as it allows policy to set
-	 * whether the Service and Manager can be allowed access (fd use)
-	 * or not. For example test_binder_mgr_t has:
-	 *        allow test_binder_service_t test_binder_mgr_t:fd use;
-	 * whereas test_binder_mgr_no_fd_t does not allow this fd use.
-	 *
-	 * This also allows a check for the impersonate permission later
-	 * as the Service Provider will use this (the Managers fd) to
-	 * send a transaction.
-	 */
-	obj.fd = fd;
-
-	if (verbose)
-		printf("Manager handle: %d and its FD: %d\n",
-		       txn->target.handle, fd);
-
-	txn->data_size = sizeof(obj);
-	txn->offsets_size = sizeof(offset);
-	txn->data.ptr.buffer = (uintptr_t)&obj;
-	txn->data.ptr.offsets = (uintptr_t)&offset;
-
-	memset(&bwr, 0, sizeof(bwr));
-	bwr.write_buffer = (uintptr_t)writebuf;
-	bwr.write_size = sizeof(writebuf[0]) + sizeof(*txn);
-
-	result = ioctl(fd, BINDER_WRITE_READ, &bwr);
-	if (result < 0) {
-		fprintf(stderr, "%s ioctl BINDER_WRITE_READ: %s\n",
-			__func__, strerror(errno));
-		exit(-1);
-	}
-}
-
-/* This retrieves the requested Managers file descriptor, then using this
- * sends a simple transaction to trigger the impersonate permission.
- */
-static void extract_fd_and_respond(struct binder_transaction_data *txn_in,
-				   bool manager)
-{
-	int result;
-	uint32_t cmd;
-	struct stat sb;
-	struct binder_write_read bwr;
-	struct binder_fd_object *obj;
-	struct {
-		uint32_t cmd;
-		struct binder_transaction_data txn;
-	} __attribute__((packed)) writebuf;
-	unsigned int readbuf[32];
-
-	memset(readbuf, 0, sizeof readbuf);
-
-	binder_size_t *offs = (binder_size_t *)
-			      (uintptr_t)txn_in->data.ptr.offsets;
-
-	/* Get the bfdo that contains the Managers binder file descriptor. */
-	obj = (struct binder_fd_object *)
-	      (((char *)(uintptr_t)txn_in->data.ptr.buffer) + *offs);
-
-	if (obj->hdr.type != BINDER_TYPE_FD) {
-		fprintf(stderr, "Header not BINDER_TYPE_FD: %d\n",
-			obj->hdr.type);
-		exit(100);
-	}
-
-	/* fstat this just to see if a valid fd */
-	result = fstat(obj->fd, &sb);
-	if (result < 0) {
-		fprintf(stderr, "Not a valid fd: %s\n", strerror(errno));
-		exit(101);
-	}
-
-	if (verbose)
-		printf("Service Provider retrieved Managers fd: %d st_dev: %ld\n",
-		       obj->fd, sb.st_dev);
-
-	/* Send response using Managers fd to trigger impersonate check. */
-	writebuf.cmd = BC_TRANSACTION;
-	memcpy(&writebuf.txn.target.handle, shm_base, sizeof(uint32_t));
-
-	writebuf.txn.cookie = 0;
-	writebuf.txn.code = 0;
-	writebuf.txn.flags = TF_ONE_WAY;
-
-	writebuf.txn.data_size = 0;
-	writebuf.txn.data.ptr.buffer = (uintptr_t)NULL;
-	writebuf.txn.data.ptr.offsets = (uintptr_t)NULL;
-	writebuf.txn.offsets_size = 0;
-
-	memset(&bwr, 0, sizeof(bwr));
-	bwr.write_size = sizeof(writebuf);
-	bwr.write_consumed = 0;
-	bwr.write_buffer = (uintptr_t)&writebuf;
-	bwr.read_size = sizeof(readbuf);
-	bwr.read_consumed = 0;
-	bwr.read_buffer = (uintptr_t)readbuf;
-
-	result = ioctl(obj->fd, BINDER_WRITE_READ, &bwr);
-	if (result < 0) {
-		fprintf(stderr,
-			"Service Provider ioctl BINDER_WRITE_READ: %s\n",
-			strerror(errno));
-		exit(102);
-	}
-
-	if (verbose)
-		printf("Service Provider read_consumed: %lld\n",
-		       bwr.read_consumed);
-
-	cmd = binder_parse(obj->fd, (uintptr_t)readbuf,
-			   bwr.read_consumed, manager);
-
-	if (verbose)
-		printf("Service Provider using Managers FD\n");
-
-	if (cmd == BR_FAILED_REPLY ||
-	    cmd == BR_DEAD_REPLY ||
-	    cmd == BR_DEAD_BINDER) {
-		fprintf(stderr,
-			"Failed response from Service Provider using Managers FD\n");
-		exit(103);
-	}
-}
-
-/* Parse response, reply as required and then return last CMD */
-static int binder_parse(int fd, uintptr_t ptr, size_t size, bool manager)
-{
-	uintptr_t end = ptr + (uintptr_t)size;
-	uint32_t cmd;
-
-	while (ptr < end) {
-		cmd = *(uint32_t *)ptr;
-		ptr += sizeof(uint32_t);
-
-		if (verbose)
-			printf("%s command: %s\n",
-			       manager ? "Manager" : "Service Provider",
-			       cmd_name(cmd));
-
-		switch (cmd) {
-		case BR_NOOP:
-			break;
-		case BR_TRANSACTION_COMPLETE:
-			break;
-		case BR_INCREFS:
-		case BR_ACQUIRE:
-		case BR_RELEASE:
-		case BR_DECREFS:
-			ptr += sizeof(struct binder_ptr_cookie);
-			break;
-		case BR_TRANSACTION: {
-			struct binder_transaction_data *txn =
-				(struct binder_transaction_data *)ptr;
-
-			if (verbose) {
-				printf("%s BR_TRANSACTION data:\n",
-				       manager ? "Manager" : "Service Provider");
-				print_trans_data(txn);
-			}
-
-			if (manager) {
-				do_service_manager(fd, txn);
-				request_manager_fd(fd, txn);
-			}
-
-			ptr += sizeof(*txn);
-			break;
-		}
-		case BR_REPLY: {
-			struct binder_transaction_data *txn =
-				(struct binder_transaction_data *)ptr;
-
-			if (verbose) {
-				printf("%s BR_REPLY data:\n",
-				       manager ? "Manager" : "Service Provider");
-				print_trans_data(txn);
-			}
-
-			/* Service Provider extracts the Manager fd, and responds */
-			if (!manager)
-				extract_fd_and_respond(txn, manager);
-
-			ptr += sizeof(*txn);
-			break;
-		}
-		case BR_DEAD_BINDER:
-			break;
-		case BR_FAILED_REPLY:
-			break;
-		case BR_DEAD_REPLY:
-			break;
-		case BR_ERROR:
-			ptr += sizeof(uint32_t);
-			break;
-		default:
-			if (verbose)
-				printf("%s Parsed unknown command: %d\n",
-				       manager ? "Manager" : "Service Provider",
-				       cmd);
-			exit(-1);
-		}
-	}
-
-	return cmd;
-}
-
-int main(int argc, char **argv)
-{
-	int opt, result, binder_fd, provider_replies = 0;
-	uint32_t cmd;
-	bool manager;
-	pid_t pid;
-	char *driver = "/dev/binder";
-	char *context;
-	char *flag_file = NULL;
-	void *map_base;
-	size_t map_size = 1024 * 8;
-	struct binder_write_read bwr;
-	struct flat_binder_object obj;
-	binder_size_t offset = 0;
-	struct {
-		uint32_t cmd;
-		struct binder_transaction_data txn;
-	} __attribute__((packed)) writebuf;
-	unsigned int readbuf[32];
-
-	verbose = false;
-
-	while ((opt = getopt(argc, argv, "f:vr:")) != -1) {
-		switch (opt) {
-		case 'f':
-			flag_file = optarg;
-			break;
-		case 'v':
-			verbose = true;
-			break;
-		case 'r':
-			provider_replies = atoi(optarg);
-			break;
-		default:
-			usage(argv[0]);
-		}
-	}
-
-	if ((argc - optind) != 1)
-		usage(argv[0]);
-
-	if (!strcmp(argv[optind], "manager"))
-		manager = true;
-	else if (!strcmp(argv[optind], "provider"))
-		manager = false;
-	else
-		usage(argv[0]);
-
-	binder_fd = open(driver, O_RDWR | O_CLOEXEC);
-	if (binder_fd < 0) {
-		fprintf(stderr, "Cannot open %s error: %s\n", driver,
-			strerror(errno));
-		exit(1);
-	}
-
-	map_base = mmap(NULL, map_size, PROT_READ, MAP_PRIVATE, binder_fd, 0);
-	if (map_base == MAP_FAILED) {
-		fprintf(stderr, "mmap error: %s\n", strerror(errno));
-		close(binder_fd);
-		exit(2);
-	}
-
-	/* Create the appropriate shared memory for passing the Service
-	 * Providers handle from the Manager to the Service Provider for
-	 * use in the impersonate tests. This saves adding a Client to
-	 * do this job.
-	 */
-	create_shm(manager);
-
-	/* Get our context and pid */
-	result = getcon(&context);
-	if (result < 0) {
-		fprintf(stderr, "Failed to obtain SELinux context\n");
-		result = 3;
-		goto brexit;
-	}
-	pid = getpid();
-
-	if (manager) { /* Service Manager */
-		if (verbose) {
-			printf("Manager PID: %d Process context:\n\t%s\n",
-			       pid, context);
-		}
-
-		result = ioctl(binder_fd, BINDER_SET_CONTEXT_MGR, 0);
-		if (result < 0) {
-			fprintf(stderr,
-				"Failed to become context manager: %s\n",
-				strerror(errno));
-			result = 4;
-			goto brexit;
-		}
-
-		writebuf.cmd = BC_ENTER_LOOPER;
-		bwr.write_size = sizeof(writebuf.cmd);
-		bwr.write_consumed = 0;
-		bwr.write_buffer = (uintptr_t)&writebuf;
-
-		bwr.read_size = 0;
-		bwr.read_consumed = 0;
-		bwr.read_buffer = 0;
-
-		result = ioctl(binder_fd, BINDER_WRITE_READ, &bwr);
-		if (result < 0) {
-			fprintf(stderr,
-				"Manager ioctl BINDER_WRITE_READ: %s\n",
-				strerror(errno));
-			result = 5;
-			goto brexit;
-		}
-
-		if (flag_file) {
-			FILE *f = fopen(flag_file, "w");
-			if (!f) {
-				perror("Flag file open");
-				result = 9;
-				goto brexit;
-			}
-			fprintf(f, "listening\n");
-			fclose(f);
-		}
-
-		while (true) {
-			memset(readbuf, 0, sizeof readbuf);
-			bwr.read_size = sizeof(readbuf);
-			bwr.read_consumed = 0;
-			bwr.read_buffer = (uintptr_t)readbuf;
-
-			result = ioctl(binder_fd, BINDER_WRITE_READ, &bwr);
-			if (result < 0) {
-				fprintf(stderr,
-					"Manager ioctl BINDER_WRITE_READ: %s\n",
-					strerror(errno));
-				result = 6;
-				goto brexit;
-			}
-
-			if (bwr.read_consumed == 0)
-				continue;
-
-			if (verbose)
-				printf("Manager read_consumed: %lld\n",
-				       bwr.read_consumed);
-
-			cmd = binder_parse(binder_fd, (uintptr_t)readbuf,
-					   bwr.read_consumed, manager);
-		}
-	} else { /* Service Provider */
-		if (verbose) {
-			printf("Service Provider PID: %d Process context:\n\t%s\n",
-			       pid, context);
-		}
-
-		writebuf.cmd = BC_TRANSACTION;
-		writebuf.txn.target.handle = TEST_SERVICE_MANAGER_HANDLE;
-		writebuf.txn.cookie = 0;
-		writebuf.txn.code = ADD_TEST_SERVICE;
-		writebuf.txn.flags = TF_ACCEPT_FDS;
-
-		memset(&obj, 0, sizeof(obj));
-		obj.hdr.type = BINDER_TYPE_BINDER;
-		obj.flags = 0x7f | FLAT_BINDER_FLAG_ACCEPTS_FDS;
-		obj.binder = (uintptr_t)NULL;
-		obj.cookie = 0;
-
-		writebuf.txn.data_size = sizeof(obj);
-		writebuf.txn.offsets_size = sizeof(offset);
-
-		writebuf.txn.data.ptr.buffer = (uintptr_t)&obj;
-		writebuf.txn.data.ptr.offsets = (uintptr_t)&offset;
-
-		bwr.write_buffer = (uintptr_t)&writebuf;
-		bwr.write_size = sizeof(writebuf);
-		bwr.write_consumed = 0;
-
-		if (verbose)
-			printf("Service Provider sending transaction to Manager - ADD_TEST_SERVICE\n");
-
-		/* Each test will expect a different number of replies */
-		while (provider_replies) {
-			memset(readbuf, 0, sizeof readbuf);
-			bwr.read_size = sizeof(readbuf);
-			bwr.read_consumed = 0;
-			bwr.read_buffer = (uintptr_t)readbuf;
-
-			result = ioctl(binder_fd, BINDER_WRITE_READ, &bwr);
-			if (result < 0) {
-				fprintf(stderr,
-					"xxService Provider ioctl BINDER_WRITE_READ: %s\n",
-					strerror(errno));
-				result = 7;
-				goto brexit;
-			}
-
-			if (verbose)
-				printf("Service Provider read_consumed: %lld\n",
-				       bwr.read_consumed);
-
-			cmd = binder_parse(binder_fd, (uintptr_t)readbuf,
-					   bwr.read_consumed, manager);
-
-			if (cmd == BR_FAILED_REPLY ||
-			    cmd == BR_DEAD_REPLY ||
-			    cmd == BR_DEAD_BINDER) {
-				result = 8;
-				goto brexit;
-			}
-			provider_replies--;
-		}
-	}
-
-brexit:
-	free(context);
-	munmap(shm_base, shm_size);
-	close(shm_fd);
-	munmap(map_base, map_size);
-	close(binder_fd);
-
-	return result;
-}
-- 
2.20.1

