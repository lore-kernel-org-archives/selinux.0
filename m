Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870B9C433DB
	for <selinux@archiver.kernel.org>; Fri, 12 Feb 2021 19:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC9B64EAA
	for <selinux@archiver.kernel.org>; Fri, 12 Feb 2021 19:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhBLTBH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Feb 2021 14:01:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48099 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229832AbhBLTBG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Feb 2021 14:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613156379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4LUfGL6TLJG5ZdNl4cme7DmlyrOQ07Muy5r+tBAoBbU=;
        b=AJAISZHuxANQ3I7DeCpaL+0a4Teod2qGmfB0n0nNdCjaTdRYoBItXx3lYumeMj3FuiLzVU
        G8I+Uxo3NYpvKHQjOp+x89FkLQMbyxfX0pAi4oAKZyK3LuaEJkBGM38yDe7SUNZYI6Gemo
        JCQYtb8zCrNdD/rG/rkjZLAW4AsJZNM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-IjF2zCsdMvKHp1t-j6vkWg-1; Fri, 12 Feb 2021 13:59:38 -0500
X-MC-Unique: IjF2zCsdMvKHp1t-j6vkWg-1
Received: by mail-ej1-f71.google.com with SMTP id m4so326233ejc.14
        for <selinux@vger.kernel.org>; Fri, 12 Feb 2021 10:59:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4LUfGL6TLJG5ZdNl4cme7DmlyrOQ07Muy5r+tBAoBbU=;
        b=Et7SjhN1h75GSS4+u4egCdA+PtH+OdorRBOTzs1/lSEqaw24T32ZKpoleNvG0e/LSR
         F2JDjDZlMvn0MSN1sN2/1fP/fKf4uyBOghbVwUS79dsvWdRLUHNsXUu28AuXmX48FGIy
         ezfxDskVu++9j/6H8tgRfLs/QEouc4zXWV4an/Oji6w18OEsD8LxlRON67mK2qqLIis/
         +ag5uXHdwmWhn2Vtq35fgeuxs5WP2KLWM7Khk1/yrtR+GHQfNnYwa9xsYxGfYXJ+iV1B
         xm24RG/YzcU7fZy9dNwTjSajmtaDqTVvND1NChN9CkM9NPNMJx+9r7OAfh2XtrIoHp5C
         VTNA==
X-Gm-Message-State: AOAM532C/7JWSksHkK6R+3tHNvUynxsC5jYigNiufpcOimlru2R+8Wfg
        Ehy4hcnbG7kOvtIQnzmLzEVeK0fSG1F4GQXXJLJf7MyC6Fa1QelzGZa7P7HfCbQhqS8qAeI0Z4L
        VU2Ow1NU11jWuDA409RmQAAc1Phltvy6OXv6ZGRt1EOVxVzTFRuyl5Ws8YgsSXu46pd79YQ==
X-Received: by 2002:aa7:ce13:: with SMTP id d19mr4968398edv.208.1613156376841;
        Fri, 12 Feb 2021 10:59:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6I7FUO1Vcq+ZlMR9k8n7wUrpW382Hk7L1gXDHIuyAwSwg/uo4E6DZNBIo1/dOoUafN0x1Cw==
X-Received: by 2002:aa7:ce13:: with SMTP id d19mr4968381edv.208.1613156376596;
        Fri, 12 Feb 2021 10:59:36 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id u23sm6351128edt.87.2021.02.12.10.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 10:59:35 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 1/2] selinux: don't log MAC_POLICY_LOAD record on failed policy load
Date:   Fri, 12 Feb 2021 19:59:29 +0100
Message-Id: <20210212185930.130477-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210212185930.130477-1-omosnace@redhat.com>
References: <20210212185930.130477-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

If sel_make_policy_nodes() fails, we should jump to 'out', not 'out1',
as the latter would incorrectly log an MAC_POLICY_LOAD audit record,
even though the policy hasn't actually been reloaded. The 'out1' jump
label now becomes unused and can be removed.

Fixes: 02a52c5c8c3b ("selinux: move policy commit after updating selinuxfs")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/selinuxfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 01a7d50ed39b..340711e3dc9a 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -651,14 +651,13 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	length = sel_make_policy_nodes(fsi, newpolicy);
 	if (length) {
 		selinux_policy_cancel(fsi->state, newpolicy);
-		goto out1;
+		goto out;
 	}
 
 	selinux_policy_commit(fsi->state, newpolicy);
 
 	length = count;
 
-out1:
 	audit_log(audit_context(), GFP_KERNEL, AUDIT_MAC_POLICY_LOAD,
 		"auid=%u ses=%u lsm=selinux res=1",
 		from_kuid(&init_user_ns, audit_get_loginuid(current)),
-- 
2.29.2

