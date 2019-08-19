Return-Path: <SRS0=MkDT=WP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7B7C3A5A0
	for <selinux@archiver.kernel.org>; Mon, 19 Aug 2019 19:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A720206C1
	for <selinux@archiver.kernel.org>; Mon, 19 Aug 2019 19:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfHSTbk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:31:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728486AbfHSTbj (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 19 Aug 2019 15:31:39 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 39E6E5117D
        for <selinux@vger.kernel.org>; Mon, 19 Aug 2019 19:31:39 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id e18so4519111qkl.17
        for <selinux@vger.kernel.org>; Mon, 19 Aug 2019 12:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qLvdylfXgti3P/ztAy6JihzFzEbKfpTFCiqhJA8iiEc=;
        b=NUK+ax90P2igSAv2p/t8RDRpEYqk9UpzPUBDrATqdU0+H5YUDykbJQOSZNv07ISl1X
         2DFEdGb5xP4Hbc2qNGNaClycLvfrHcUJ/JkIIk2hnpoC+Fa7u0Sg/ZeXRxjK4Rm1/Sr6
         Y07np9bq8nu8hMm3mR/fYk0Vx5anIVqCMPRot3lZUqNostod+DTsLImKcp/LwmhMBwy1
         DQr30lxfwEJ11tpxSkkfPldnUjWZpLlGXYO/y5Zbrp/TYZ+eNaBzu1zjGfzYPeXEXy8i
         b0YNldRnG/gEp5VlydXmrG7l1takJxBB37DKg/jecyP+5RQeEvl4ewmOQE8RHNJ1C+pp
         S6Dg==
X-Gm-Message-State: APjAAAVcffkZBOaChkKtbqeaHLPXIwtKkKaa3FtRVC3p/2wMEuBWZ2Os
        tueSeG6EISexJy3Bfl6Giv+HxVFVSfilVKVk2d/hwfm4c0z9zvfyjqkjYDrTE4TMtSoreLCGmQm
        5rtR/1AOo/6PRlRLhgQ==
X-Received: by 2002:ae9:e118:: with SMTP id g24mr22747018qkm.378.1566243098185;
        Mon, 19 Aug 2019 12:31:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzDo5asmd+cVT32FoXojmRSwxtCMfpz2ZAiILdlQk90+0mgsFMjBKXlN05iIaOuelAGxY2GFA==
X-Received: by 2002:ae9:e118:: with SMTP id g24mr22747002qkm.378.1566243098009;
        Mon, 19 Aug 2019 12:31:38 -0700 (PDT)
Received: from localhost.localdomain (107-190-106-197.cpe.teksavvy.com. [107.190.106.197])
        by smtp.gmail.com with ESMTPSA id p126sm7981257qkc.84.2019.08.19.12.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 12:31:37 -0700 (PDT)
From:   Jonathan Lebon <jlebon@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Jonathan Lebon <jlebon@redhat.com>,
        Victor Kamensky <kamensky@cisco.com>
Subject: [PATCH] selinux: allow labeling before policy is loaded
Date:   Mon, 19 Aug 2019 15:30:32 -0400
Message-Id: <20190819193032.848-1-jlebon@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently, the SELinux LSM prevents one from setting the
`security.selinux` xattr on an inode without a policy first being
loaded. However, this restriction is problematic: it makes it impossible
to have newly created files with the correct label before actually
loading the policy.

This is relevant in distributions like Fedora, where the policy is
loaded by systemd shortly after pivoting out of the initrd. In such
instances, all files created prior to pivoting will be unlabeled. One
then has to relabel them after pivoting, an operation which inherently
races with other processes trying to access those same files.

Going further, there are use cases for creating the entire root
filesystem on first boot from the initrd (e.g. Container Linux supports
this today[1], and we'd like to support it in Fedora CoreOS as well[2]).
One can imagine doing this in two ways: at the block device level (e.g.
laying down a disk image), or at the filesystem level. In the former,
labeling can simply be part of the image. But even in the latter
scenario, one still really wants to be able to set the right labels when
populating the new filesystem.

This patch enables this by changing behaviour in the following two ways:
1. allow `setxattr` on mounts without `SBLABEL_MNT` (which is all of
   them if no policy is loaded yet)
2. don't try to set the in-core inode SID if we're not initialized;
   instead leave it as `LABEL_INVALID` so that revalidation may be
   attempted at a later time

Note the first hunk of this patch is functionally the same as a
previously discussed one[3], though it was part of a larger series which
wasn't accepted.

Co-developed-by: Victor Kamensky <kamensky@cisco.com>
Signed-off-by: Victor Kamensky <kamensky@cisco.com>
Signed-off-by: Jonathan Lebon <jlebon@redhat.com>

[1] https://coreos.com/os/docs/latest/root-filesystem-placement.html
[2] https://github.com/coreos/fedora-coreos-tracker/issues/94
[3] https://www.spinics.net/lists/linux-initramfs/msg04593.html
---
 security/selinux/hooks.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 94de51628..faf93e9f8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3143,7 +3143,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 	}
 
 	sbsec = inode->i_sb->s_security;
-	if (!(sbsec->flags & SBLABEL_MNT))
+	if (!(sbsec->flags & SBLABEL_MNT) && selinux_state.initialized)
 		return -EOPNOTSUPP;
 
 	if (!inode_owner_or_capable(inode))
@@ -3225,6 +3225,15 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 		return;
 	}
 
+	if (!selinux_state.initialized) {
+		/* If we haven't even been initialized, then we can't validate
+		 * against a policy, so leave the label as invalid. It may
+		 * resolve to a valid label on the next revalidation try if
+		 * we've since initialized.
+		 */
+		return;
+	}
+
 	rc = security_context_to_sid_force(&selinux_state, value, size,
 					   &newsid);
 	if (rc) {
-- 
2.21.0

