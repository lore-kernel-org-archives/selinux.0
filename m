Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6911C433ED
	for <selinux@archiver.kernel.org>; Fri,  7 May 2021 11:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 891A461443
	for <selinux@archiver.kernel.org>; Fri,  7 May 2021 11:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbhEGLm6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 May 2021 07:42:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56722 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234817AbhEGLm5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 May 2021 07:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620387718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0zmbYpIxO+tqIx9tDKPAbmZ+lvrUpQZvE1lV/asn3qo=;
        b=FsjveeURp2CTUBW3kb4tmMXhZSl7cBtuywtb79Tr2ynis4qVWWPXucgJjC+xr34Un0yW0g
        anJhVQ3jE9DU/T9ONmSnyM3Ivf3llS+QKJckTXkoQEAoA9HtIeJPv9iPQtQbtG4WtC0uE8
        YLmidtvGu2HsYnMce7P1N+gy2ld2IFI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-zpiMjvbyO--U95h21dM0Vg-1; Fri, 07 May 2021 07:41:56 -0400
X-MC-Unique: zpiMjvbyO--U95h21dM0Vg-1
Received: by mail-ed1-f72.google.com with SMTP id y15-20020aa7d50f0000b02903885ee98723so4280055edq.16
        for <selinux@vger.kernel.org>; Fri, 07 May 2021 04:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0zmbYpIxO+tqIx9tDKPAbmZ+lvrUpQZvE1lV/asn3qo=;
        b=PuJUkHdWvlAmOotD9GbKDnA3BINYST8I6UmFUsNaLpUn5BWWhV3iqcmj7CcxziHyir
         Pm7f1N96bGIhtLSZ/PWZPSATUO6fDHcw52kNQs67tZxh6PGu4Z7vGG2jMp/CRzwg0fjl
         G29drIDw8XeSJJK5XBuXcl5RtNMWc3A/JDbnPUQNMPr1pyCLIS3sztDCk8se7hzN2KrI
         SJUrNeO2eMv74cTWYJBkDMBhIXa2vtOjO0q5MuXApJFhiW5avtMTGXjGy13Cq6gLlgq5
         R1cygo2KtmgZj6iM0B3HDtQ0j2CMc6xPZpm7aG+SvBiCNZWZ04PeMGzhVvV/dPcWMYF6
         a2vg==
X-Gm-Message-State: AOAM531Z+IIQqQwyk8LWNK4HwSbJIwpY3vdatAaO29nQ2nN9p85u+Hmh
        s6fDyAjHlqQt+qRFmwEexMcuG/LtEat09nvbCUmpcrO7MjGezZ0IPVO7gkcb7ad81HQHP/OuBc1
        jfGln/DuE6n3QE6I8rw==
X-Received: by 2002:a17:906:a2d1:: with SMTP id by17mr10007694ejb.426.1620387715166;
        Fri, 07 May 2021 04:41:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxe+4tEBSZQpT+iheN+fbqzfk3Ilvhkxits1eJbgq0XcZH2UeBxRoLPxQpaOHsaIcs/iRz58w==
X-Received: by 2002:a17:906:a2d1:: with SMTP id by17mr10007682ejb.426.1620387715042;
        Fri, 07 May 2021 04:41:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id v19sm3356083ejy.78.2021.05.07.04.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 04:41:54 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] debugfs: fix security_locked_down() call for SELinux
Date:   Fri,  7 May 2021 13:41:50 +0200
Message-Id: <20210507114150.139102-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Make sure that security_locked_down() is checked last so that a bogus
denial is not reported by SELinux when (ia->ia_valid & (ATTR_MODE |
ATTR_UID | ATTR_GID)) is zero.

Note: this was introduced by commit 5496197f9b08 ("debugfs: Restrict
debugfs when the kernel is locked down"), but it didn't matter at that
time, as the SELinux support came in later.

Fixes: 59438b46471a ("security,lockdown,selinux: implement SELinux lockdown")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
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

