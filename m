Return-Path: <SRS0=VxLC=ZD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3641DC43331
	for <selinux@archiver.kernel.org>; Mon, 11 Nov 2019 11:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29A421655
	for <selinux@archiver.kernel.org>; Mon, 11 Nov 2019 11:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfKKLxz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Nov 2019 06:53:55 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:37906 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfKKLxz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Nov 2019 06:53:55 -0500
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 3894156471A;
        Mon, 11 Nov 2019 12:53:47 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Cc:     Michael Shigorin <mike@altlinux.org>
Subject: [PATCH 3/3] libselinux,libsemanage: check in python_exception.i files
Date:   Mon, 11 Nov 2019 12:53:15 +0100
Message-Id: <20191111115315.1173097-3-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111115315.1173097-1-nicolas.iooss@m4x.org>
References: <20191111115315.1173097-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Nov 11 12:53:47 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Generating selinuxswig_python_exception.i and
semanageswig_python_exception.i requires gcc, which appears to be
unavailable on some platform. Work around this issue by adding the
generated files to the git repository.

While at it, remove a stray space in the generated
selinuxswig_python_exception.i.

Original thread: https://lore.kernel.org/selinux/20191012172357.GB19655@imap.altlinux.org/T/#ma78bd7fe71fb5784387a8c0cebd867d6c02ee6e4

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: Michael Shigorin <mike@altlinux.org>
---
 libselinux/src/.gitignore                     |    1 -
 libselinux/src/exception.sh                   |    2 +-
 libselinux/src/selinuxswig_python_exception.i |  954 +++++++
 libsemanage/src/.gitignore                    |    1 -
 .../src/semanageswig_python_exception.i       | 2385 +++++++++++++++++
 5 files changed, 3340 insertions(+), 3 deletions(-)
 create mode 100644 libselinux/src/selinuxswig_python_exception.i
 create mode 100644 libsemanage/src/semanageswig_python_exception.i

diff --git a/libselinux/src/.gitignore b/libselinux/src/.gitignore
index 428afe5ae7d9..001f20b01e39 100644
--- a/libselinux/src/.gitignore
+++ b/libselinux/src/.gitignore
@@ -1,4 +1,3 @@
 selinux.py
 selinuxswig_python_wrap.c
-selinuxswig_python_exception.i
 selinuxswig_ruby_wrap.c
diff --git a/libselinux/src/exception.sh b/libselinux/src/exception.sh
index 1a21e651c42f..33ceef804af5 100755
--- a/libselinux/src/exception.sh
+++ b/libselinux/src/exception.sh
@@ -5,7 +5,7 @@ case $1 in
     *)
 echo "
 %exception $1 {
-  \$action 
+  \$action
   if (result < 0) {
      PyErr_SetFromErrno(PyExc_OSError);
      SWIG_fail;
diff --git a/libselinux/src/selinuxswig_python_exception.i b/libselinux/src/selinuxswig_python_exception.i
new file mode 100644
index 000000000000..cf6582595ee7
--- /dev/null
+++ b/libselinux/src/selinuxswig_python_exception.i
@@ -0,0 +1,954 @@
+
+%exception is_selinux_enabled {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception is_selinux_mls_enabled {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception getcon {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception getcon_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception setcon {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception setcon_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception getpidcon {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception getpidcon_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception getprevcon {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception getprevcon_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception getexeccon {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception getexeccon_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception setexeccon {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception setexeccon_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception getfscreatecon {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception getfscreatecon_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception setfscreatecon {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception setfscreatecon_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception getkeycreatecon {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception getkeycreatecon_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception setkeycreatecon {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception setkeycreatecon_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception getsockcreatecon {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception getsockcreatecon_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception setsockcreatecon {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception setsockcreatecon_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception getfilecon {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception getfilecon_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception lgetfilecon {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception lgetfilecon_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception fgetfilecon {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception fgetfilecon_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception setfilecon {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception setfilecon_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception lsetfilecon {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception lsetfilecon_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception fsetfilecon {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception fsetfilecon_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception getpeercon {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception getpeercon_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_compute_av {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_compute_av_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_compute_av_flags {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_compute_av_flags_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_compute_create {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_compute_create_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_compute_create_name {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_compute_create_name_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_compute_relabel {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_compute_relabel_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_compute_member {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_compute_member_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_compute_user {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_compute_user_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_validatetrans {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_validatetrans_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_load_policy {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_get_initial_context {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_get_initial_context_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception selinux_mkload_policy {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception selinux_init_load_policy {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_set_boolean_list {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_load_booleans {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_check_context {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_check_context_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_canonicalize_context {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_canonicalize_context_raw {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_getenforce {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_setenforce {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_reject_unknown {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_deny_unknown {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_get_checkreqprot {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_disable {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_policyvers {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_get_boolean_names {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_get_boolean_pending {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_get_boolean_active {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_set_boolean {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_commit_booleans {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception selinux_set_mapping {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception security_av_string {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception matchpathcon_init {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception matchpathcon_init_prefix {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception realpath_not_final {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception matchpathcon {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception matchpathcon_index {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception matchpathcon_filespec_add {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception matchmediacon {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception selinux_getenforcemode {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception selinux_getpolicytype {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception selinux_set_policy_root {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception selinux_check_access {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception selinux_check_passwd_access {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception checkPasswdAccess {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception selinux_check_securetty_context {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception selinuxfs_exists {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception setexecfilecon {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception rpm_execcon {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception is_context_customizable {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception selinux_trans_to_raw_context {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception selinux_raw_to_trans_context {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception selinux_raw_context_to_color {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception getseuserbyname {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception getseuser {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception selinux_file_context_verify {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception selinux_lsetfilecon_default {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
diff --git a/libsemanage/src/.gitignore b/libsemanage/src/.gitignore
index dc87c598e659..b4d4bb328aad 100644
--- a/libsemanage/src/.gitignore
+++ b/libsemanage/src/.gitignore
@@ -1,4 +1,3 @@
 semanageswig_wrap.c
-semanageswig_python_exception.i
 semanage.py
 semanageswig_ruby_wrap.c
diff --git a/libsemanage/src/semanageswig_python_exception.i b/libsemanage/src/semanageswig_python_exception.i
new file mode 100644
index 000000000000..06c60267e265
--- /dev/null
+++ b/libsemanage/src/semanageswig_python_exception.i
@@ -0,0 +1,2385 @@
+
+%exception semanage_reload_policy {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_get_hll_compiler_path {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_get_disable_dontaudit {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_set_default_priority {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_is_managed {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_connect {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_disconnect {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_begin_transaction {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_commit {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_access_check {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_is_connected {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_mls_enabled {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_set_root {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_get_preserve_tunables {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_get_ignore_module_cache {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception select {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception pselect {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_module_install {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_module_install_file {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_module_remove {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_module_extract {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_module_list {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_module_info_create {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_module_info_destroy {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_module_info_get_priority {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_module_info_get_name {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_module_info_get_lang_ext {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_module_info_get_enabled {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_module_info_set_priority {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_module_info_set_name {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_module_info_set_lang_ext {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_module_info_set_enabled {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_module_key_create {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_module_key_destroy {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_module_key_get_name {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_module_key_get_priority {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_module_key_set_name {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_module_key_set_priority {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_module_set_enabled {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_module_get_module_info {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_module_list_all {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_module_install_info {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_module_remove_key {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_module_get_enabled {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_msg_get_level {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_bool_key_create {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_bool_key_extract {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_bool_compare {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_bool_compare2 {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_bool_set_name {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_bool_get_value {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_bool_create {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_bool_clone {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_user_key_create {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_user_key_extract {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_user_compare {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_user_compare2 {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_user_set_name {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_user_set_prefix {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_user_set_mlslevel {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_user_set_mlsrange {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_user_get_num_roles {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_user_add_role {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_user_has_role {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_user_get_roles {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_user_set_roles {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_user_create {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_user_clone {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_seuser_key_create {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_seuser_key_extract {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_seuser_compare {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_seuser_compare2 {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_seuser_set_name {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_seuser_set_sename {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_seuser_set_mlsrange {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_seuser_create {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_seuser_clone {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_context_set_user {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_context_set_role {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_context_set_type {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_context_set_mls {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_context_create {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_context_clone {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_context_from_string {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_context_to_string {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_iface_compare {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_iface_compare2 {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_iface_key_create {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_iface_key_extract {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_iface_set_name {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_iface_set_ifcon {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_iface_set_msgcon {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_iface_create {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_iface_clone {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_port_compare {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_port_compare2 {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_port_key_create {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_port_key_extract {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_port_get_proto {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_port_get_low {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_port_get_high {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_port_set_con {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_port_create {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_port_clone {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibpkey_compare {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibpkey_compare2 {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibpkey_key_create {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibpkey_key_extract {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibpkey_get_subnet_prefix {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibpkey_set_subnet_prefix {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibpkey_get_low {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibpkey_get_high {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibpkey_set_con {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibpkey_create {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibpkey_clone {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibendport_compare {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibendport_compare2 {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibendport_key_create {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibendport_key_extract {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibendport_get_ibdev_name {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibendport_set_ibdev_name {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibendport_get_port {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibendport_set_con {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibendport_create {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibendport_clone {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_compare {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_compare2 {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_key_create {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_key_extract {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_get_addr {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_get_addr_bytes {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_set_addr {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_set_addr_bytes {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_get_mask {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_get_mask_bytes {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_set_mask {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_set_mask_bytes {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_get_proto {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_set_con {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_create {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_clone {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_bool_modify_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_bool_del_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_bool_query_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_bool_exists_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_bool_count_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_bool_iterate_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_bool_list_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_bool_query {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_bool_exists {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_bool_count {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_bool_iterate {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_bool_list {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_bool_set_active {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_bool_query_active {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_bool_exists_active {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_bool_count_active {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_bool_iterate_active {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_bool_list_active {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_user_modify_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_user_del_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_user_query_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_user_exists_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_user_count_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_user_iterate_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_user_list_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_user_query {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_user_exists {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_user_count {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_user_iterate {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_user_list {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_fcontext_compare {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_fcontext_compare2 {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_fcontext_key_create {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_fcontext_key_extract {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_fcontext_set_expr {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_fcontext_get_type {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_fcontext_set_con {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_fcontext_create {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_fcontext_clone {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_fcontext_modify_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_fcontext_del_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_fcontext_query_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_fcontext_exists_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_fcontext_count_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_fcontext_iterate_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_fcontext_list_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_fcontext_query {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_fcontext_exists {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_fcontext_count {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_fcontext_iterate {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_fcontext_list {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_fcontext_list_homedirs {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_seuser_modify_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_seuser_del_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_seuser_query_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_seuser_exists_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_seuser_count_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_seuser_iterate_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_seuser_list_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_seuser_query {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_seuser_exists {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_seuser_count {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_seuser_iterate {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_seuser_list {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_port_modify_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_port_del_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_port_query_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_port_exists_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_port_count_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_port_iterate_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_port_list_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_port_query {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_port_exists {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_port_count {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_port_iterate {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_port_list {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibpkey_modify_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibpkey_del_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibpkey_query_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibpkey_exists_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibpkey_count_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibpkey_iterate_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibpkey_list_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibendport_modify_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibendport_del_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibendport_query_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibendport_exists_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibendport_count_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibendport_iterate_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibendport_list_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibendport_query {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibendport_exists {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibendport_count {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibendport_iterate {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibendport_list {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibpkey_query {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibpkey_exists {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibpkey_count {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibpkey_iterate {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_ibpkey_list {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_iface_modify_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_iface_del_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_iface_query_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_iface_exists_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_iface_count_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_iface_iterate_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_iface_list_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_iface_query {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_iface_exists {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_iface_count {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_iface_iterate {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_iface_list {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_modify_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_del_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_query_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_exists_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_count_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_iterate_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_list_local {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_query {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_exists {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_count {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_iterate {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
+
+%exception semanage_node_list {
+  $action
+  if (result < 0) {
+     PyErr_SetFromErrno(PyExc_OSError);
+     SWIG_fail;
+  }
+}
+
-- 
2.24.0

