Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7111C433ED
	for <selinux@archiver.kernel.org>; Fri,  7 May 2021 12:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C37961466
	for <selinux@archiver.kernel.org>; Fri,  7 May 2021 12:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbhEGMyj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 May 2021 08:54:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54851 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236566AbhEGMyM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 May 2021 08:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620391992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ekkd3oyzogIptalBe2cpy9zc9ReWtKldN7D44gkdUnI=;
        b=FeeqIKQUJ5oDBp/JRTcOr+LSGe4ow5VsWwzx+If8zMACjpxMVsLtywSGQTiZlMILLkSyFx
        oqyU0+XKxbwKgfiQ0ewpqFFPXeBaatj0PoY0TXgMYlRdhAedwi+zLbPYWL++Cn9i2Sg66q
        KYqZqPTIefzylh3jkB6RQad2ElD6FOA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-7OXlardDOMGKqmODlFijhw-1; Fri, 07 May 2021 08:53:10 -0400
X-MC-Unique: 7OXlardDOMGKqmODlFijhw-1
Received: by mail-ed1-f72.google.com with SMTP id w20-20020aa7dcd40000b02903886b9b0013so4389342edu.22
        for <selinux@vger.kernel.org>; Fri, 07 May 2021 05:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ekkd3oyzogIptalBe2cpy9zc9ReWtKldN7D44gkdUnI=;
        b=cD0CH7TaNSqfG1lEuHlmqupPdCDhEeyxsLS1pEmMXhmigmuMSfRGLIrfsOc+H5Trqi
         9zrPgfeB8W/6gTqicupC7sPTvJXU6eiOPaEZQQRqaCbN8M6A1NOkbXYzmfxZgK75Rwza
         qrTT2vxMjBuu1cX4CejIzcf4Ybq8OdsXQykRfMO9NaVNd7yOFb46wxOu8YxVIkKSi3Z4
         r8JJCzljDP368BP4HN53JxbJDdH+YpPRNZ7tgm+6/qtdotf/ma2AyELRMzG1SysHljLI
         bx+Z4GnZ4IQh5TjBAyPbyqPYXBJpQKGmOUB00U4QxJabK2IadWrQch9eGCZ5ZmRN6KOj
         97jA==
X-Gm-Message-State: AOAM533kLsjtiTzzukD0AkTNJq+JAOYIYUP7sRK0hylPRF/9ZUQVAxMA
        udTg62cWyvGDxwtZlkvnhM9nmc6JC4HFbruEaYfKXGnO6PAVvfYGkjabwLxgqg1JyAzmeF343Dc
        o5e7rB8W/6hmCN3XVCw==
X-Received: by 2002:a17:906:2511:: with SMTP id i17mr9662200ejb.198.1620391989175;
        Fri, 07 May 2021 05:53:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzx3Z+9lizDuJOODp1PHOn4ynHaHjZttKyHDznmtmt2QFV4vRXq1H+M273vfCF/TzadAicR/g==
X-Received: by 2002:a17:906:2511:: with SMTP id i17mr9662180ejb.198.1620391988967;
        Fri, 07 May 2021 05:53:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id qh12sm3415986ejb.109.2021.05.07.05.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 05:53:08 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] debugfs: fix security_locked_down() call for SELinux
Date:   Fri,  7 May 2021 14:53:04 +0200
Message-Id: <20210507125304.144394-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When (ia->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)) is zero, then
the SELinux implementation of the locked_down hook might report a denial
even though the operation would actually be allowed.

To fix this, make sure that security_locked_down() is called only when
the return value will be taken into account (i.e. when changing one of
the problematic attributes).

Note: this was introduced by commit 5496197f9b08 ("debugfs: Restrict
debugfs when the kernel is locked down"), but it didn't matter at that
time, as the SELinux support came in later.

Fixes: 59438b46471a ("security,lockdown,selinux: implement SELinux lockdown")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

v2: try to explain the problem better in the description

 fs/debugfs/inode.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 22e86ae4dd5a..bbfc7898c1aa 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -45,10 +45,13 @@ static unsigned int debugfs_allow = DEFAULT_DEBUGFS_ALLOW_BITS;
 static int debugfs_setattr(struct user_namespace *mnt_userns,
 			   struct dentry *dentry, struct iattr *ia)
 {
-	int ret = security_locked_down(LOCKDOWN_DEBUGFS);
+	int ret;
 
-	if (ret && (ia->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)))
-		return ret;
+	if (ia->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)) {
+		ret = security_locked_down(LOCKDOWN_DEBUGFS);
+		if (ret)
+			return ret;
+	}
 	return simple_setattr(&init_user_ns, dentry, ia);
 }
 
-- 
2.31.1

