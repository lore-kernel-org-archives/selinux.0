Return-Path: <SRS0=uPJ/=PY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B761C43387
	for <selinux@archiver.kernel.org>; Wed, 16 Jan 2019 20:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FA320840
	for <selinux@archiver.kernel.org>; Wed, 16 Jan 2019 20:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfAPU5a (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Jan 2019 15:57:30 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:49851 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfAPU5a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Jan 2019 15:57:30 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id F1C03561260
        for <selinux@vger.kernel.org>; Wed, 16 Jan 2019 21:57:27 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/1] libselinux: do not dereference symlink with statfs in selinux_restorecon
Date:   Wed, 16 Jan 2019 21:57:10 +0100
Message-Id: <20190116205710.30659-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Jan 16 21:57:28 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When selinux_restorecon() is used to relabel symlinks, it performs the
following syscalls (as seen by running strace on restorecond):

    lstat("/root/symlink", {st_mode=S_IFLNK|0777, st_size=6, ...}) = 0
    statfs("/root/symlink", 0x7ffd6bb4d090) = -1 ENOENT (No such file or directory)
    lstat("/root/symlink", {st_mode=S_IFLNK|0777, st_size=6, ...}) = 0
    lgetxattr("/root/symlink", "security.selinux", "sysadm_u:object_r:user_home_t", 255) = 30

The second one triggers a SELinux check for lnk_file:read, as statfs()
dereferences symbolic links. This call to statfs() is only used to find
out whether "restoreconlast" xattr can be ignored, which is always the
case for non-directory files (the first syscall, lstat(), is actually
used to perform this check).

Skip the call to statfs() when setrestoreconlast is already false.

This silences an AVC denial that would otherwise be reported to
audit.log (cf. https://github.com/SELinuxProject/refpolicy/pull/22).

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/selinux_restorecon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 3df2d382d50b..42a48f5a1b0b 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -881,7 +881,7 @@ int selinux_restorecon(const char *pathname_orig,
 		setrestoreconlast = false;
 
 	/* Ignore restoreconlast on in-memory filesystems */
-	if (statfs(pathname, &sfsb) == 0) {
+	if (setrestoreconlast && statfs(pathname, &sfsb) == 0) {
 		if (sfsb.f_type == RAMFS_MAGIC || sfsb.f_type == TMPFS_MAGIC)
 			setrestoreconlast = false;
 	}
-- 
2.20.1

