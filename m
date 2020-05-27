Return-Path: <SRS0=EYrt=7J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED525C433E0
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 16:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C93B720776
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 16:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGxkG7z5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388797AbgE0QCP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 May 2020 12:02:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57083 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388395AbgE0QCP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 May 2020 12:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590595333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NDotd2QTTWfxGfPxoSS/0DkiwnhHRI7ydQ8UgcxclFw=;
        b=OGxkG7z5f/9ag7De0iSpQO3A75RT29Xpw7rGQg2QeTo7wZzmiqOnZbPj8h0AZ57kp9yDzX
        tcjGGtB8rhUpaXUYDOptURdgyNVyju0RPfNXvU4WNWip2SxIJOPOpfgZ3YRWYU/a7lr71C
        f8AYOSr+43L5sbkPI+dDoxkw/SIVF/I=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-XmlvdxiEOoiJEIdtMJhvDA-1; Wed, 27 May 2020 12:01:51 -0400
X-MC-Unique: XmlvdxiEOoiJEIdtMJhvDA-1
Received: by mail-qt1-f199.google.com with SMTP id n33so26160581qtd.10
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 09:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NDotd2QTTWfxGfPxoSS/0DkiwnhHRI7ydQ8UgcxclFw=;
        b=AV1nzFQtBS1PexppVU+WTCbaKx1opv05it4NmiXLW4QGNgnVx3uQxWZvq1THl0oLeK
         M1HMNvTPuNfGC0XgJHubdoVlKnxiUfUsxFXbQO4lSm1XkTslUkhL+2866OAEPkyLcx6l
         bNrevEf8HD6Bql+xTfVgvW2K49TsitBfuciqJDVSuqzzFvZRAznc0s8k6e0kq4zo2T8i
         aZfrSNYmElIe0+3e2vuUxR/XIvCxgGqKbm2FQs5J9BEHQcKjCZAIw6L/FYp72QmSXFQO
         JBDg+GhIKvyNzZcNKa5tDDlJN71PcmCgBko2UT2IRyFkhIER6TMo2tw1YZzLTtilUNCY
         n+sQ==
X-Gm-Message-State: AOAM532dan5zAeLscGznthMxdM4swFDtCRiWBkAVgjBk7anyKc92cCL3
        oLOMS5uz2LCbs6EdaHYd5sckQ5BQyXscEKnzVJjJ28Lsorm1PL17/GIdApmZdAnJYTNvzjRtMJb
        TNN/KmyPLD8Z9BUmZBg==
X-Received: by 2002:a37:dd6:: with SMTP id 205mr4571506qkn.323.1590595310259;
        Wed, 27 May 2020 09:01:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/2gHYZ0UTA7lt+QYJLkNoiALzJtrGOoCvSneXl6e3kz8tIv8CkiLSnnl9Gdn2mnqx+Nz0kw==
X-Received: by 2002:a37:dd6:: with SMTP id 205mr4571473qkn.323.1590595309960;
        Wed, 27 May 2020 09:01:49 -0700 (PDT)
Received: from pet.redhat.com (107-190-106-186.cpe.teksavvy.com. [107.190.106.186])
        by smtp.gmail.com with ESMTPSA id i94sm2717460qtd.2.2020.05.27.09.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 09:01:47 -0700 (PDT)
From:   Jonathan Lebon <jlebon@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Jonathan Lebon <jlebon@redhat.com>
Subject: [PATCH v2] selinux: allow reading labels before policy is loaded
Date:   Wed, 27 May 2020 11:56:12 -0400
Message-Id: <20200527155610.156633-1-jlebon@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch does for `getxattr` what 3e3e24b4204 did for `setxattr`; it
allows querying the current SELinux label on disk before the policy is
loaded.

One of the motivations described in that commit message also drives this
patch: for Fedora CoreOS (and eventually RHEL CoreOS), we want to be
able to move the root filesystem for example, from xfs to ext4 on RAID,
on first boot, at initrd time.[1]

Because such an operation works at the filesystem level, we need to be
able to read the SELinux labels first from the original root, and apply
them to the files of the new root. Commit 3e3e24b4204 enabled the second
part of this process; this patch enables the first part.

[1] https://github.com/coreos/fedora-coreos-tracker/issues/94

Signed-off-by: Jonathan Lebon <jlebon@redhat.com>
---
 security/selinux/hooks.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0b4e32161b7..67ee2cfc25b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3334,7 +3334,9 @@ static int selinux_inode_getsecurity(struct inode *inode, const char *name, void
 	char *context = NULL;
 	struct inode_security_struct *isec;
 
-	if (strcmp(name, XATTR_SELINUX_SUFFIX))
+	/* If we're not initialized yet, then we can't validate contexts,
+	 * so just let vfs_getxattr fall back to using the on-disk xattr. */
+	if (strcmp(name, XATTR_SELINUX_SUFFIX) || !selinux_state.initialized)
 		return -EOPNOTSUPP;
 
 	/*
-- 
2.25.4

