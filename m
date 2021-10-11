Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A25C433F5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 19:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0047600EF
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 19:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbhJKTEU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 15:04:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40444 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbhJKTET (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 15:04:19 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 50BE12214A;
        Mon, 11 Oct 2021 19:02:18 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7020213BD1;
        Mon, 11 Oct 2021 19:02:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 10RjCziKZGGnMQAAMHmgww
        (envelope-from <dave@stgolabs.net>); Mon, 11 Oct 2021 19:02:16 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     paul@paul-moore.com
Cc:     stephen.smalley.work@gmail.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] selinux: consilidate comments from inode_doinit_with_dentry wrt !dentry
Date:   Mon, 11 Oct 2021 12:02:04 -0700
Message-Id: <20211011190204.123934-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Instead of having the same big comment twice for the same scenario,
just have it in out_invalid.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 security/selinux/hooks.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e7ebd45ca345..0e0013cc7ba8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1502,18 +1502,8 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			if (!dentry)
 				dentry = d_find_any_alias(inode);
 		}
-		if (!dentry) {
-			/*
-			 * this is can be hit on boot when a file is accessed
-			 * before the policy is loaded.  When we load policy we
-			 * may find inodes that have no dentry on the
-			 * sbsec->isec_head list.  No reason to complain as these
-			 * will get fixed up the next time we go through
-			 * inode_doinit with a dentry, before these inodes could
-			 * be used again by userspace.
-			 */
+		if (!dentry)
 			goto out_invalid;
-		}
 
 		rc = inode_doinit_use_xattr(inode, dentry, sbsec->def_sid,
 					    &sid);
@@ -1559,15 +1549,6 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 				if (!dentry)
 					dentry = d_find_any_alias(inode);
 			}
-			/*
-			 * This can be hit on boot when a file is accessed
-			 * before the policy is loaded.  When we load policy we
-			 * may find inodes that have no dentry on the
-			 * sbsec->isec_head list.  No reason to complain as
-			 * these will get fixed up the next time we go through
-			 * inode_doinit() with a dentry, before these inodes
-			 * could be used again by userspace.
-			 */
 			if (!dentry)
 				goto out_invalid;
 			rc = selinux_genfs_get_sid(dentry, sclass,
@@ -1607,6 +1588,15 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 	return rc;
 
 out_invalid:
+	/*
+	 * This is can be hit on boot when a file is accessed
+	 * before the policy is loaded.  When we load policy we
+	 * may find inodes that have no dentry on the
+	 * sbsec->isec_head list.  No reason to complain as these
+	 * will get fixed up the next time we go through
+	 * inode_doinit with a dentry, before these inodes could
+	 * be used again by userspace.
+	 */
 	spin_lock(&isec->lock);
 	if (isec->initialized == LABEL_PENDING) {
 		isec->initialized = LABEL_INVALID;
-- 
2.26.2

