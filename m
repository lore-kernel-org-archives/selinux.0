Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502E1C433E0
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 13:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C7312311E
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 13:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbhAFN2C (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 08:28:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60630 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726439AbhAFN2C (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 08:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609939595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wHE6P1TOGG+8RzuUTOU60xBKbgs5tAYorI9d4Iv36Dw=;
        b=VO4x5yDGouQPbQxXxp9Ss7QsjFvKYrcNmtT9u3LA3ek/I1pxKv+c7TQy1dZk7sSbU2g1/n
        AkkNJCFNEuSR4QFossDET3h84+zCXHul6nPZFqy4OoCVRRvYXfPTah6G/wijrCfd7k9kwF
        1223oImYY58PdbB6xYYGSqoEqNiQF9c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-N1865SQ2Pfi3Q3Gr-N6opg-1; Wed, 06 Jan 2021 08:26:34 -0500
X-MC-Unique: N1865SQ2Pfi3Q3Gr-N6opg-1
Received: by mail-ed1-f70.google.com with SMTP id e11so1916173edn.11
        for <selinux@vger.kernel.org>; Wed, 06 Jan 2021 05:26:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wHE6P1TOGG+8RzuUTOU60xBKbgs5tAYorI9d4Iv36Dw=;
        b=onDCWhz0ATqW2Cq0eHVba5l5of5FK2fCAvpAdKWqpSjaaOQSeLFahOWUTOngZBhEKo
         J7dqBjGbiqgmOoFQjhrH9aYbBvJDtFW8U+7ixO3+qJcqrR6wjvQHRcGwMBA/kvr+02ew
         SjkSLiQ+4AfzDGWFKUXVkVtTNJzlw33IzYoUkWrjxWgNl+Zh2QYCwdLHqsqtJF36v5/F
         lbkV4hPDmMw1PJh+izyylmVk9AtqNh2WIlJcu1emU6Tc6U76v60sNDA+ROX/DH3Vsk00
         fAEwpk3bMXv7G6KAnTznZAllsPLHlHdDnvht0HltCdMBMXRzDHKnXKUVLnaocpatdQQS
         z9PA==
X-Gm-Message-State: AOAM5327UfPsuNw/uP7oMSOoR2F42IxzZCIAh1mHTTv1PDNQ211sxGwY
        kEZQF4AbWkwN6UMatKbgReaGI7BRmW1yhUaBCeIN/qO4xaBPFc/BX0q+Kwjiy0UhedkSBR6skEH
        N1flEkjn5eVOTHSU2/yscvsVZypVRHwTYbHueIfrkFqug0yoU/eu97GYIqllOgOjd5w7MGA==
X-Received: by 2002:a05:6402:4d6:: with SMTP id n22mr4078307edw.27.1609939592906;
        Wed, 06 Jan 2021 05:26:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6GK9bdOMluUJ7AMc9lfyHlADCM3UvVQglRsdwQOaKZlblrVHp5X04eRYmFicWyVhP7vm0tw==
X-Received: by 2002:a05:6402:4d6:: with SMTP id n22mr4078295edw.27.1609939592659;
        Wed, 06 Jan 2021 05:26:32 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id bm12sm1225893ejb.117.2021.01.06.05.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 05:26:32 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 3/5] selinux: make selinuxfs_mount static
Date:   Wed,  6 Jan 2021 14:26:20 +0100
Message-Id: <20210106132622.1122033-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106132622.1122033-1-omosnace@redhat.com>
References: <20210106132622.1122033-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It is not referenced outside selinuxfs.c, so remove its extern header
declaration and make it static.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/include/security.h | 1 -
 security/selinux/selinuxfs.c        | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 3cc8bab31ea85..765a258a899ef 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -436,7 +436,6 @@ extern void selinux_complete_init(void);
 extern int selinux_disable(struct selinux_state *state);
 extern void exit_sel_fs(void);
 extern struct path selinux_null;
-extern struct vfsmount *selinuxfs_mount;
 extern void selnl_notify_setenforce(int val);
 extern void selnl_notify_policyload(u32 seqno);
 extern int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm);
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 4bde570d56a2c..4fdfe7b67df89 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -2204,7 +2204,7 @@ static struct file_system_type sel_fs_type = {
 	.kill_sb	= sel_kill_sb,
 };
 
-struct vfsmount *selinuxfs_mount;
+static struct vfsmount *selinuxfs_mount;
 struct path selinux_null;
 
 static int __init init_sel_fs(void)
-- 
2.29.2

