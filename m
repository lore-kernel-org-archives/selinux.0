Return-Path: <SRS0=XO28=EK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72606C2D0A3
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 12:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C26720786
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 12:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dwn+DzeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgKDMBS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Nov 2020 07:01:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35666 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728523AbgKDMBS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Nov 2020 07:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604491276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/2UMJz2HL0XZKFt2cP0dCjeH6o9eymroQgG7PjvYFLI=;
        b=Dwn+DzeCm1szvRXIawP8NrwC8hGXNJgKbddw7hXizigfQ9X8ApbQKQISIG+KNWL5wbwRhy
        egb8TtwErIGVqnTwTAArFUz1n7RYsRZ3zHGruTYJdBdFhEZK+mkhyF4DZPritSMIumjNO7
        JoLJEutun7AMdRRTxAKqVzrEOpgSZmI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-mZafruEKP5eZMugdAa8HHw-1; Wed, 04 Nov 2020 07:01:14 -0500
X-MC-Unique: mZafruEKP5eZMugdAa8HHw-1
Received: by mail-wr1-f69.google.com with SMTP id b6so9108168wrn.17
        for <selinux@vger.kernel.org>; Wed, 04 Nov 2020 04:01:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/2UMJz2HL0XZKFt2cP0dCjeH6o9eymroQgG7PjvYFLI=;
        b=n0PbZ5ntSkgYQX0of4apdZlm0Xy/zzQ55J/yU1vpSAOKSOfkZakjCMjcOPeU6lMmEi
         HAwnqCeGlKP5DEZse32YZ6CEUiN1qgjYdVQAyZEPQmYqKXIeU0VJOipHGkIlG/qUs5b7
         XHHw/2uhmQGYAo3m7OAGaSYyKM25UhoGl4dPMPh6u5Wz/N93e8T3A14lUjSiSsDZ1eoK
         KarMxvn+zoUKixXXbb0Z3TrpAFqiKBtOfECiRBkivwGrxSkvkmi6w4bbFLh1ybSzB2LE
         nHNx4x3iTet3U+nEbyB40JASFmyCrrPOjZ3xKloiA/eVSmJZ5mX++3u7vTPdqbRLr4/Y
         PX2w==
X-Gm-Message-State: AOAM532OR6lrRfDUUpl2RFwdofNdIJhCaHsPxBiHhoZS+hciSwxN/j2L
        kElbz5dqTMnu8ZRScDLz7dM5Xc+2UG4I5Hx2xJiLKPblTgLQJjltqp1eXgSIqU+/NqAHNPiRHUM
        kprlFU311KMHM3IrQWw==
X-Received: by 2002:a1c:6043:: with SMTP id u64mr4066956wmb.166.1604491272768;
        Wed, 04 Nov 2020 04:01:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy3lAMsz/ftsfORTkeBCWdrNJPREMS1rVdYeyqDTLttk69ONv6EIBuksyPI4v32C0WA66FC/Q==
X-Received: by 2002:a1c:6043:: with SMTP id u64mr4066933wmb.166.1604491272571;
        Wed, 04 Nov 2020 04:01:12 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b103:4000:9293:f330:b535:b530])
        by smtp.gmail.com with ESMTPSA id o10sm1916681wma.47.2020.11.04.04.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 04:01:12 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux: drop super_block backpointer from superblock_security_struct
Date:   Wed,  4 Nov 2020 13:01:10 +0100
Message-Id: <20201104120110.886431-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It appears to have been needed for selinux_complete_init() in the past,
but today it's useless.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/hooks.c          | 5 ++---
 security/selinux/include/objsec.h | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a340986aa92e1..714e7fa624ba8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -599,7 +599,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 {
 	const struct cred *cred = current_cred();
 	struct superblock_security_struct *sbsec = sb->s_security;
-	struct dentry *root = sbsec->sb->s_root;
+	struct dentry *root = sb->s_root;
 	struct selinux_mnt_opts *opts = mnt_opts;
 	struct inode_security_struct *root_isec;
 	u32 fscontext_sid = 0, context_sid = 0, rootcontext_sid = 0;
@@ -1079,7 +1079,7 @@ static int selinux_sb_show_options(struct seq_file *m, struct super_block *sb)
 			return rc;
 	}
 	if (sbsec->flags & ROOTCONTEXT_MNT) {
-		struct dentry *root = sbsec->sb->s_root;
+		struct dentry *root = sb->s_root;
 		struct inode_security_struct *isec = backing_inode_security(root);
 		seq_putc(m, ',');
 		seq_puts(m, ROOTCONTEXT_STR);
@@ -2559,7 +2559,6 @@ static int selinux_sb_alloc_security(struct super_block *sb)
 	mutex_init(&sbsec->lock);
 	INIT_LIST_HEAD(&sbsec->isec_head);
 	spin_lock_init(&sbsec->isec_lock);
-	sbsec->sb = sb;
 	sbsec->sid = SECINITSID_UNLABELED;
 	sbsec->def_sid = SECINITSID_FILE;
 	sbsec->mntpoint_sid = SECINITSID_UNLABELED;
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 330b7b6d44e0a..ca4d7ab6a8355 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -61,7 +61,6 @@ struct file_security_struct {
 };
 
 struct superblock_security_struct {
-	struct super_block *sb;		/* back pointer to sb object */
 	u32 sid;			/* SID of file system superblock */
 	u32 def_sid;			/* default SID for labeling */
 	u32 mntpoint_sid;		/* SECURITY_FS_USE_MNTPOINT context for files */
-- 
2.26.2

