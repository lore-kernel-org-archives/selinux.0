Return-Path: <SRS0=HWnL=XN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9294C4CEC4
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 18:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8F3222BF
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 18:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="g8LT3DoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388878AbfIRS6c (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Sep 2019 14:58:32 -0400
Received: from UPDC19PA24.eemsg.mail.mil ([214.24.27.199]:25462 "EHLO
        UPDC19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387683AbfIRS6c (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Sep 2019 14:58:32 -0400
X-EEMSG-check-017: 15072318|UPDC19PA24_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,521,1559520000"; 
   d="scan'208";a="15072318"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Sep 2019 18:58:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568833109; x=1600369109;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/q1AZl5uHR3M63yaUbfIJX9PdZZWU/8yis20mLihiMs=;
  b=g8LT3DoU85eYS7NoUIe/Nrq+Fv++vrMOF/Cr2A7nEZUPKc4WRTkEEvka
   gBjhV/EQsuQ4R0u8yYa1MUSjmUSDKQ1MGpLnS8g+7Rm3z/isga7fKkfw3
   amiuGXRacz6cC8aTQ8GCfY365ZulkuBaHuLEo6O21jaBtGwYqK/XblR9o
   l3jIBFgjDACtKBAixn8pKivUgtjfQn2LBvycPgMcE6nm5890Dk7g40D2l
   zVVBm+accOoM5BmPJ9KLlhXJSgriqZ5Ntp0BSOJwbdtDhe/tn4a9h2o0Q
   55qWm9npGDjABKtzlsB603DrCJpVCtuavUKF4IGiKNZDYyO5xGZ8LVRnp
   Q==;
X-IronPort-AV: E=Sophos;i="5.64,521,1559520000"; 
   d="scan'208";a="33033430"
IronPort-PHdr: =?us-ascii?q?9a23=3Av4E9+BcCKCSOK+5Y9Covp65jlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcW4Yx7h7PlgxGXEQZ/co6odzbaP6Oa5CSdZu8nJ8ChbNsAVDV?=
 =?us-ascii?q?ld0YRetjdjKfbNMVf8Iv/uYn5yN+V5f3ghwUuGN1NIEt31fVzYry76xzcTHh?=
 =?us-ascii?q?LiKVg9fbytScbdgMutyu+95YDYbRlWizqhe7NyKwi9oRnMusUMjoZuN6g8xg?=
 =?us-ascii?q?HUrnZLdOha2H1kKFCOlBr4+su84YRv/itNt/4/7cJMTbn2c6ElRrFEEToqNH?=
 =?us-ascii?q?w46tf2vhfZVwuP4XUcUmQSkhVWBgXO8Q/3UJTsvCbkr+RxwCaVM9H4QrAyQj?=
 =?us-ascii?q?Si8rxkSAT0hycdNj4263/Yh8pth69Guh2hphh/w4nJYIGJMfd1Y63Qcc8GSW?=
 =?us-ascii?q?dHQ81eWTZBAoehZIURCeQPM/tTo43kq1YAqRayAA+hD/7txDBVnH/7xa003f?=
 =?us-ascii?q?o8Hw/I3wIuGN0BvnvPodnpN6ofS/y5wbPUwTnfaf5dxDfz6JLPchAkufyCQK?=
 =?us-ascii?q?5wftTJyUkvCQzFiEibp5HgPzyP0uQNt3aU7up9Xu+okG4othpxryOzxsYslo?=
 =?us-ascii?q?bJhoUVxkrC9SVi2ok5P9K4SEllYdO9FpZbqi+UN4xzQsw4QmFovj43yrIHuZ?=
 =?us-ascii?q?6nfCgK1Y8oywTDZPyAdoiF5A/oWuWJITpgmX5od72yiwyy/ES90OHwSMa53E?=
 =?us-ascii?q?hQoiZYlNTHq2oD2AbJ6sedT/tw5kKh2TGS2A/N8uxEOkU0lbbDK54m374wio?=
 =?us-ascii?q?IfsUTdES/yn0X7lLOWeV8++uip9uTnea/qpoOcNoBoigH+Nb4imsqjDuQjLg?=
 =?us-ascii?q?cCRW2b+eW41LH7/E35RqtFjuEun6XEv53XKt4Xq66kDwNPzIou5AizAy273N?=
 =?us-ascii?q?gAmHkINlNFeBaJj4jzPFHOJej1DeyijFS3izpr2/DHMaHhApXKNHTDlqzhcq?=
 =?us-ascii?q?xn505Tzwoz08hT54hIBbEZPPLzRkjxucTfDh88NAy02ODnB89h2YwAQm+PGL?=
 =?us-ascii?q?GWP77SsVCS+uIjOfWDZIgQuDzlMfgq++bujWMlmV8aZaSpxoUYaHS5HvRgPk?=
 =?us-ascii?q?WYbmHhgskOEWgUpAoyVu/qh0OYUT5VeXmyW7gw5jYhCIKpFY3DXJyigKSd3C?=
 =?us-ascii?q?enGZ1bfnhGBUqREXfsbIiEQ+0DaD+WIsN4lzwEUr+hS5U/2h20qAD6zL9nfa?=
 =?us-ascii?q?Lo/XgAvI/n/MB8+umWkBY17zEyBMOYgE+XSGQhpX8FXz872uhEpEV5zlqSmf?=
 =?us-ascii?q?xjj+dwCc1Y5/QPVBwzc5Hb0bopWJjJRgvdc4LRGx6dSdK8DGR0FYM8?=
X-IPAS-Result: =?us-ascii?q?A2C8AABpfYJd/wHyM5BmHQEBBQEHBQGBVAcBCwGBbSptU?=
 =?us-ascii?q?zIqlAABAQEBAQEGiyqKCYUkgXsJAQEBAQEBAQEBGxAJAQIBAYMsgRODBSM1C?=
 =?us-ascii?q?A4CDAEBAQQBAQEBAQUDAQFshS0MgjopgyABRoFRgmM/AYF2FA+yLYVMgyyBQ?=
 =?us-ascii?q?waBNAGHL4RZGHiBB4RhgmECgi6EdCIErH2CLIIuhFeNcwwbmSABLZVyknYBN?=
 =?us-ascii?q?oFYKwgCGAghD4MnUBAUhUCKbyQDMIEGAQGPbgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 18 Sep 2019 18:58:28 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8IIwQB7019098;
        Wed, 18 Sep 2019 14:58:26 -0400
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux-testsuite: drop use of userdom_read_inherited_user_tmp_files
Date:   Wed, 18 Sep 2019 14:58:25 -0400
Message-Id: <20190918185825.8012-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The overlay test policy had two calls to the
userdom_read_inherited_user_tmp_files() policy interface.
This is a Fedora-specific interface that is not present in
refpolicy and therefore prevents building the test policy on
other distributions.  Further, there is no clear reason why
the calls to this interface are needed for the overlay tests;
the tests are not inheriting open /tmp files.  Remove the
calls.

Fixes: https://github.com/SELinuxProject/selinux-testsuite/issues/57
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policy/test_overlayfs.te | 2 --
 1 file changed, 2 deletions(-)

diff --git a/policy/test_overlayfs.te b/policy/test_overlayfs.te
index 3be53fce0f9c..6f1756e9a118 100644
--- a/policy/test_overlayfs.te
+++ b/policy/test_overlayfs.te
@@ -50,7 +50,6 @@ fs_mount_xattr_fs(test_overlay_mounter_t)
 corecmd_shell_entry_type(test_overlay_mounter_t)
 corecmd_exec_bin(test_overlay_mounter_t)
 
-userdom_read_inherited_user_tmp_files(test_overlay_mounter_t)
 userdom_search_admin_dir(test_overlay_mounter_t)
 userdom_search_user_home_content(test_overlay_mounter_t)
 
@@ -123,7 +122,6 @@ corecmd_exec_bin(test_overlay_client_t)
 kernel_read_system_state(test_overlay_client_t)
 kernel_read_proc_symlinks(test_overlay_client_t)
 
-userdom_read_inherited_user_tmp_files(test_overlay_client_t)
 userdom_search_admin_dir(test_overlay_client_t)
 userdom_search_user_home_content(test_overlay_client_t)
 
-- 
2.21.0

