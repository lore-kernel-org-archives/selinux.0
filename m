Return-Path: <SRS0=ftCu=3G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328A1C33C9E
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 20:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0596E20748
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 20:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="IuyXj1qP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgAQUXc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jan 2020 15:23:32 -0500
Received: from UHIL19PA39.eemsg.mail.mil ([214.24.21.198]:60686 "EHLO
        UHIL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgAQUXc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jan 2020 15:23:32 -0500
X-EEMSG-check-017: 67645103|UHIL19PA39_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,331,1574121600"; 
   d="scan'208";a="67645103"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA39.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Jan 2020 20:23:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579292610; x=1610828610;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+jHmceLI8UX4tj0NlEyg0qaKPvedbB11HH7iGKMYn5Q=;
  b=IuyXj1qPlzRQCcj380BpmDXhAsyonbRIx/7P8nl1n83HwxI3pF3QRj42
   IThqFjLow0m9AU2mMqAKMnEVNAnhjyu9Owh2WesPuJ0wxdVd76PHDgrt+
   6NgACi9+KFGFPIA/PCh92U7G7qYTrvT2UqXdiWuKZfqmc/tqPpMJWcm0s
   /ChqGa7myaMNmsLLQ8PVPcdWNzjE0jCW6LzYzEFM1KW8FY6hgBpkbkNy2
   ysxtSj1xNhjdtnBCOONlzD0Dt27WXBBu/YWX/UUvml/1U5yvBd3vJp4Wn
   7jNRh8g2mEQdshvX/MpCXBMv44YeRWugLbneGhIozHUrs8bj2bescRY3O
   A==;
X-IronPort-AV: E=Sophos;i="5.70,331,1574121600"; 
   d="scan'208";a="32092806"
IronPort-PHdr: =?us-ascii?q?9a23=3AJXKiph8om6UybP9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0+oWIJqq85mqBkHD//Il1AaPAdyHraoUwLaP++C4ACpcuM3H6ChDOLV3FD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjeu8UMnYdvKak9xx?=
 =?us-ascii?q?TUrnBVf+ha2X5kKUickhrh6Mq85oJv/zhVt/k868NOTKL2crgiQ7dFFjomKW?=
 =?us-ascii?q?c15MPqtRnHUwSC42YXX3sVnBRVHQXL9Qn2UZjtvCT0sOp9wzSaMtbtTb8oQz?=
 =?us-ascii?q?Si7rxkRwHuhSwaKjM26mDXish3jKJGvBKsogF0zoDIbI2JMvd1Y63SfckeRW?=
 =?us-ascii?q?FcQMhfUSJPCZ64Y4cWD+cMOeNUoo/grFUMsBS+HxGhCuPxxDFViHH43qo03O?=
 =?us-ascii?q?suHwzdwAAtHMgDvGjOodnpKKsfV/2+wqnSzTXEavNbwSrz6JTWfRA5ofGDQ7?=
 =?us-ascii?q?RwetfMx0kqDQzFilGQppLlPjiI0ekNqHWU7/F7WOKzi28otwFxoj+1yscqkY?=
 =?us-ascii?q?nGnJgZyl/D9SVn2Ys4I8CzRkB8Yd6hCpRQtieaOpN2QsMlRGFouzw2yqYYtp?=
 =?us-ascii?q?GnYSgK0pUnxwLfavGBboOG4QrjWf6MLTp3i39pYrKyiwuo/US+xeDwSNO43E?=
 =?us-ascii?q?tMoyFYiNfDrGoN2AbW6sWfT/t9+Vqu1iiX2gDI7+FEPVg0la3GK5492rIwlo?=
 =?us-ascii?q?QcsUDEHiLuhEX5lrWWdkQ5+uiz8ejnY7PmppGbN49vlA7xLr4imtC/AOskMg?=
 =?us-ascii?q?gOWHKX+eKg27344UL1WrBKjvwykqXBsZDaI9oUprKhDgNI3Ysu5AyzAje73N?=
 =?us-ascii?q?gCg3UKI0xJdAiag4TxPlHBOvH4DfOxg1S2lzdrwujLPqb8DZXWNXXDjLfgcq?=
 =?us-ascii?q?p9605b0gYzy8tf6IhOBrEOJ/LzRFf9tMbEAR8hLwy03+HnBc1g2YMeXmKODL?=
 =?us-ascii?q?GWMKfWsV+T/e8vOfeDa5IVuDnnN/gp/eLhjXg8mVUFZ6mmwYMXaGykHvRhO0?=
 =?us-ascii?q?iZZn/sgtAaEWcMpAUxUPLlhUaYUTFNenmyX7gz5i0hBI26CofDQ5ingKad0y?=
 =?us-ascii?q?ejAp1WemdGB0iXEXj2c4WEWvEMaD+dI8J6jDwEWqauS5U72RGtqgD60bxnIf?=
 =?us-ascii?q?TQ+iECspLjztd17fXJlR4u7Tx0E9id02aVQmFshGwIWjs20btnoUNn11eD1b?=
 =?us-ascii?q?F0g/lfFdxU/fNGTB02OoLbz+x/WJjOXVfZd8qNYE6vX9HjBDY2VN93yNgLMG?=
 =?us-ascii?q?hnHND3tQzOxyqnBfcukrWPAJEluvbH02PZO9d2y3GA0rIoyVYhXJ0cZiWdmq?=
 =?us-ascii?q?dj+l2LVMbymEKDmvPvKPUR?=
X-IPAS-Result: =?us-ascii?q?A2AvAABLFyJe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWcHA?=
 =?us-ascii?q?QELAYF8gg0SKow0YIZoiyWPToF7CQEBAQEBAQEBARscAQGEQIIwNAkOAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIVDgjspgzMBRoFRgmc/glclry+Ie4E+gTYBhzqEc3mBB?=
 =?us-ascii?q?4FHgxuBBAGEEYUhBI1pig2XVoJDgkmTWwwbmnItqy45gVgrCAIYCCEPgydQG?=
 =?us-ascii?q?A2IDQwLgQQBAY07IwMwjWcBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 17 Jan 2020 20:23:29 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00HKMnNq040145;
        Fri, 17 Jan 2020 15:22:50 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com, dhowells@redhat.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v2] selinux: fix regression introduced by move_mount(2) syscall
Date:   Fri, 17 Jan 2020 15:24:07 -0500
Message-Id: <20200117202407.12344-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

commit 2db154b3ea8e ("vfs: syscall: Add move_mount(2) to move mounts around")
introduced a new move_mount(2) system call and a corresponding new LSM
security_move_mount hook but did not implement this hook for any existing
LSM.  This creates a regression for SELinux with respect to consistent
checking of mounts; the existing selinux_mount hook checks mounton
permission to the mount point path.  Provide a SELinux hook
implementation for move_mount that applies this same check for
consistency.  In the future we may wish to add a new move_mount
filesystem permission and check as well, but this addresses
the immediate regression.

Fixes: 2db154b3ea8e ("vfs: syscall: Add move_mount(2) to move mounts around")
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
v2 drops the RFC prefix, changes the subject to make it more evident that
this is a regression fix, and drops the TBD comment from the hook.

 security/selinux/hooks.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f9224866d60a..b35b5c6ad8be 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2724,6 +2724,14 @@ static int selinux_mount(const char *dev_name,
 		return path_has_perm(cred, path, FILE__MOUNTON);
 }
 
+static int selinux_move_mount(const struct path *from_path,
+			      const struct path *to_path)
+{
+	const struct cred *cred = current_cred();
+
+	return path_has_perm(cred, to_path, FILE__MOUNTON);
+}
+
 static int selinux_umount(struct vfsmount *mnt, int flags)
 {
 	const struct cred *cred = current_cred();
@@ -6913,6 +6921,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_set_mnt_opts, selinux_set_mnt_opts),
 	LSM_HOOK_INIT(sb_clone_mnt_opts, selinux_sb_clone_mnt_opts),
 
+	LSM_HOOK_INIT(move_mount, selinux_move_mount),
+
 	LSM_HOOK_INIT(dentry_init_security, selinux_dentry_init_security),
 	LSM_HOOK_INIT(dentry_create_files_as, selinux_dentry_create_files_as),
 
-- 
2.24.1

