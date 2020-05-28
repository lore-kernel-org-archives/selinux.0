Return-Path: <SRS0=TvmB=7K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB4BC433DF
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 14:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FCFF207D3
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 14:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPUjT7eK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgE1Otu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 May 2020 10:49:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53117 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728539AbgE1Otu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 May 2020 10:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590677388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pw+EZM5rJUIRvT1K/O018PMFtFbdr2vPCAL+yEc5v0c=;
        b=DPUjT7eKOY5BHJIeQdCrTHg/3G3WJxt1TNE4e7xJB7b9U85Flb7gRYsl3yy3So6Hxuvk+9
        BZf7lvUih1xs96MjU6XfxvizRZi45GaMmJ/ARukmnynjFr92cnPLhh3vBA7Ft8EJdPPUCU
        GWYe2sAU2gRI4DZr+ZVAhrGMqF52Tys=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-c4KD9GjVO4mlOyUjlSgs1A-1; Thu, 28 May 2020 10:49:44 -0400
X-MC-Unique: c4KD9GjVO4mlOyUjlSgs1A-1
Received: by mail-qv1-f71.google.com with SMTP id g15so26093348qvx.6
        for <selinux@vger.kernel.org>; Thu, 28 May 2020 07:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pw+EZM5rJUIRvT1K/O018PMFtFbdr2vPCAL+yEc5v0c=;
        b=UKngWMIznWke0J7OpWOuiZRyFCd6cnAyCnGu0BP3M3jtaGCbqDuxkfYIM7UB0ykgwk
         CCLMNnSVKzQVJvU0oHyjtKsqKdWraI18HHCfY0Fe04iLFbQuDBhEoZ7QHVFhHF8vs2do
         12YhvF5BVTDI6RHCsHa3zGzaHnOg3HBddP7JY24rbwjtaXGU0LoWGt+PFlRWN5GuGEru
         GCyFPYgTDQExvWcnyszXJltO9wMxWMgbXfBSYO2ze34OntHqiBSJrPOrLY5zS05MStiR
         aPbQzNmLiLEaE/ZqnEdsgG/VAIgcaTyLuA/N+NMN9sHx1fVv4xspGTiKh5NLMd+gRNN1
         1fzA==
X-Gm-Message-State: AOAM530QHD+wzPXzEdqT507iK1+MNWSlniG6XdsQf1v4TrXID8g8elh3
        9IrjVYn1agqBdutaxRog83cgWv/SQNBX3vb0U0stL8+tpwqBBAcerQit6uZvAkYdZU4G5K/j/lE
        pmA6LfVKeOoXUs4hadQ==
X-Received: by 2002:ac8:2679:: with SMTP id v54mr3475963qtv.130.1590677383179;
        Thu, 28 May 2020 07:49:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbK9OD9v4ZB9jzI/7qiYqLYABz7z4+kly0zf3M6GgArUvaqk/CIgcWzwvuNzd8oKW+bopPwA==
X-Received: by 2002:ac8:2679:: with SMTP id v54mr3475913qtv.130.1590677382661;
        Thu, 28 May 2020 07:49:42 -0700 (PDT)
Received: from pet.redhat.com (107-190-106-186.cpe.teksavvy.com. [107.190.106.186])
        by smtp.gmail.com with ESMTPSA id l9sm5236538qki.90.2020.05.28.07.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:49:42 -0700 (PDT)
From:   Jonathan Lebon <jlebon@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Jonathan Lebon <jlebon@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4] selinux: allow reading labels before policy is loaded
Date:   Thu, 28 May 2020 10:39:40 -0400
Message-Id: <20200528143938.209364-1-jlebon@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch does for `getxattr` what commit 3e3e24b42043 ("selinux: allow
labeling before policy is loaded") did for `setxattr`; it allows
querying the current SELinux label on disk before the policy is loaded.

One of the motivations described in that commit message also drives this
patch: for Fedora CoreOS (and eventually RHEL CoreOS), we want to be
able to move the root filesystem for example, from xfs to ext4 on RAID,
on first boot, at initrd time.[1]

Because such an operation works at the filesystem level, we need to be
able to read the SELinux labels first from the original root, and apply
them to the files of the new root. The previous commit enabled the
second part of this process; this commit enables the first part.

[1] https://github.com/coreos/fedora-coreos-tracker/issues/94

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Jonathan Lebon <jlebon@redhat.com>
---
 security/selinux/hooks.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0b4e32161b7..25b3403711d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3334,7 +3334,12 @@ static int selinux_inode_getsecurity(struct inode *inode, const char *name, void
 	char *context = NULL;
 	struct inode_security_struct *isec;
 
-	if (strcmp(name, XATTR_SELINUX_SUFFIX))
+	/*
+	 * If we're not initialized yet, then we can't validate contexts, so
+	 * just let vfs_getxattr fall back to using the on-disk xattr.
+	 */
+	if (!selinux_initialized(&selinux_state) ||
+	    strcmp(name, XATTR_SELINUX_SUFFIX))
 		return -EOPNOTSUPP;
 
 	/*
-- 
2.25.4

