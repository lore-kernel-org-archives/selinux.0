Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FD3C433DB
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 17:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D5DE64F17
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 17:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhCPRct (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Mar 2021 13:32:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53967 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238711AbhCPRcc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Mar 2021 13:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615915951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5AId5vG2TVOeo8m549ZwO+E0JsBnovD7rLmlFTc7A5s=;
        b=gg7bx+613GGnLr/vCFHPg3K7DoG+Yt08av30xirYjr3TF6s9aBrxNw33W/gpM0GQ+eWQkn
        gzH2pFHmb1LBlds7OJApRUF1w8X6VlDh/7vZ/gN9DkMcfG11DP88gG2sjNAockIKB873pZ
        JWARmNM5xfIWIxFO+8seFKy5OlacT1k=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-3rBj4kPFPWGn4lUO9gXR8Q-1; Tue, 16 Mar 2021 13:32:30 -0400
X-MC-Unique: 3rBj4kPFPWGn4lUO9gXR8Q-1
Received: by mail-ed1-f69.google.com with SMTP id w16so18020625edc.22
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 10:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5AId5vG2TVOeo8m549ZwO+E0JsBnovD7rLmlFTc7A5s=;
        b=qVkZz7BQeuYBgIxpQ3sfG1+CQul9YN8rRlAwITnbJl8jnapr4Da+I4QMZf6kaCihwL
         Zd+THAZOj2Y+rwtFTT0NVfx5P6S17bXEyRll0r2EXR+J34qe1DbTWOV3gJkAVgkdTo0e
         5BxUIrMN+3PTr1cgWGUi+NcmVU5hjfX7b9omNW2f9p0VcS2MATgAc/smOu5YFj0C4MtL
         BYcTHqxpiv9RBjtYdK7hUhKdRQzXhdT3ebCbda1PNpsIs3XdhR6Fc6dkcGTfDmedsctf
         E7wDmOzbYV0oT1bEBRxDF+TqrdHGSbsu18iKEu0kLdu+68aMDS/MhMZavXxjoNB7YPJ5
         J9qQ==
X-Gm-Message-State: AOAM533we6EV+bE6Ksr7IgV3bsYEEjq+rAFpchrkilQDq0//juOAF40k
        ZitLinsJK+7q4LqX1x6Twr3T3H4s/JjrPGD/c/mI9effv5V7YbK+ctJ4p02Ib2LNf9URDR0pipv
        fscZTGZQFTqcfL44jSg==
X-Received: by 2002:a17:906:4107:: with SMTP id j7mr14812378ejk.185.1615915948780;
        Tue, 16 Mar 2021 10:32:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxy72OaCt395g1j1vbcWykD2mZ7XNXhxeIpmOZq445d0B0Zjj/QF98NlqH/ld16pJ+Jex7WpA==
X-Received: by 2002:a17:906:4107:: with SMTP id j7mr14812361ejk.185.1615915948621;
        Tue, 16 Mar 2021 10:32:28 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id bt14sm11175862edb.92.2021.03.16.10.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 10:32:28 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: [PATCH] xfs: use has_capability_noaudit() instead of capable() where appropriate
Date:   Tue, 16 Mar 2021 18:32:26 +0100
Message-Id: <20210316173226.2220046-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In cases when a negative result of a capability check doesn't lead to an
immediate, user-visible error, only a subtle difference in behavior, it
is better to use has_capability_noaudit(current, ...), so that LSMs
(e.g. SELinux) don't generate a denial record in the audit log each time
the capability status is queried. This patch should cover all such cases
in fs/xfs/.

Note that I kept the capable(CAP_FSETID) checks, since these will only
be executed if the user explicitly tries to set the SUID/SGID bit, and
it likely makes sense to log such attempts even if the syscall doesn't
fail and just ignores the bits.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/xfs/xfs_fsmap.c | 4 ++--
 fs/xfs/xfs_ioctl.c | 5 ++++-
 fs/xfs/xfs_iops.c  | 6 ++++--
 fs/xfs/xfs_xattr.c | 2 +-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_fsmap.c b/fs/xfs/xfs_fsmap.c
index 9ce5e7d5bf8f..14672e7ee535 100644
--- a/fs/xfs/xfs_fsmap.c
+++ b/fs/xfs/xfs_fsmap.c
@@ -842,8 +842,8 @@ xfs_getfsmap(
 	    !xfs_getfsmap_is_valid_device(mp, &head->fmh_keys[1]))
 		return -EINVAL;
 
-	use_rmap = capable(CAP_SYS_ADMIN) &&
-		   xfs_sb_version_hasrmapbt(&mp->m_sb);
+	use_rmap = xfs_sb_version_hasrmapbt(&mp->m_sb) &&
+		   has_capability_noaudit(current, CAP_SYS_ADMIN);
 	head->fmh_entries = 0;
 
 	/* Set up our device handlers. */
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 3fbd98f61ea5..3cfc1a25069c 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1470,8 +1470,11 @@ xfs_ioctl_setattr(
 
 	if (XFS_IS_QUOTA_RUNNING(mp) && XFS_IS_PQUOTA_ON(mp) &&
 	    ip->i_d.di_projid != fa->fsx_projid) {
+		int flags = has_capability_noaudit(current, CAP_FOWNER) ?
+			XFS_QMOPT_FORCE_RES : 0;
+
 		code = xfs_qm_vop_chown_reserve(tp, ip, NULL, NULL, pdqp,
-				capable(CAP_FOWNER) ?  XFS_QMOPT_FORCE_RES : 0);
+				flags);
 		if (code)	/* out of quota */
 			goto error_trans_cancel;
 	}
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 67c8dc9de8aa..abbb417c4fbd 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -729,10 +729,12 @@ xfs_setattr_nonsize(
 		if (XFS_IS_QUOTA_RUNNING(mp) &&
 		    ((XFS_IS_UQUOTA_ON(mp) && !uid_eq(iuid, uid)) ||
 		     (XFS_IS_GQUOTA_ON(mp) && !gid_eq(igid, gid)))) {
+			int flags = has_capability_noaudit(current, CAP_FOWNER) ?
+				XFS_QMOPT_FORCE_RES : 0;
+
 			ASSERT(tp);
 			error = xfs_qm_vop_chown_reserve(tp, ip, udqp, gdqp,
-						NULL, capable(CAP_FOWNER) ?
-						XFS_QMOPT_FORCE_RES : 0);
+						NULL, flags);
 			if (error)	/* out of quota */
 				goto out_cancel;
 		}
diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c
index bca48b308c02..a99d19c2c11f 100644
--- a/fs/xfs/xfs_xattr.c
+++ b/fs/xfs/xfs_xattr.c
@@ -164,7 +164,7 @@ xfs_xattr_put_listent(
 		 * Only show root namespace entries if we are actually allowed to
 		 * see them.
 		 */
-		if (!capable(CAP_SYS_ADMIN))
+		if (!has_capability_noaudit(current, CAP_SYS_ADMIN))
 			return;
 
 		prefix = XATTR_TRUSTED_PREFIX;
-- 
2.30.2

