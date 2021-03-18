Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC41C433E6
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 21:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE8A364F4D
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 21:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhCRVxj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Mar 2021 17:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35297 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230333AbhCRVxN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Mar 2021 17:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616104392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cnkhRFB2ZB47AqZDLrLttdQHFRYzL4MxjNvQeyEkIyc=;
        b=OZQ6UWYpoMbJ11qFDhVjFisAV9ZZDqUisiI8EzdrzY5UKGuK1nX3S0mydp7IawBCLLkuLT
        At/Cm/d7w0RAJCpEmsvSbpSd2ksCYDhFjI+mCDNZ2rjNYJADavsb79+3p+kxTdfODVDl4k
        p54xDR1Bl6Np1xw/EMUnNPVHGiavA2s=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-J7VdAl4UPrCUp1_ZjsV2hQ-1; Thu, 18 Mar 2021 17:53:09 -0400
X-MC-Unique: J7VdAl4UPrCUp1_ZjsV2hQ-1
Received: by mail-ed1-f71.google.com with SMTP id y10so9597723edr.20
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 14:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cnkhRFB2ZB47AqZDLrLttdQHFRYzL4MxjNvQeyEkIyc=;
        b=l5FppNreWrN9SHrKFDbjnb0zNrAFlaaD52Axu9qOgGAg2fSdH1E86YALvA9DOFn1w7
         cu2/0FRf5sq9octxiCpwXm8h2FEAl8n6SYyP8JMApYIxrkv8UlzOp7rNgK1KinaA44xL
         rUKtk1y/a7MUNdHKL9sp2+eciK/LA0xQWnvnnNg7/2S8TSVdrc1P2KTNPerxRnEoy43M
         W5Xg/Z5ck2IvlHnFSK1DEHrEF4m8Gh8Ioa/35Cab1C0cWT0UrCEd5oSeN5gJhvXSuTLN
         ZhO3FfHW59pb7q2URTJdahOYyDXinnwAy0WKGKwxsz5lvCO3i625QpfZQK5uI4Ts5kiL
         2c5Q==
X-Gm-Message-State: AOAM533R2t2YNeJzcnMp1QvGmT4VbeTpETeXAUNoI3RdkyY+/v6nD1CO
        +CcF4myIofIwgCpJDfiK2ALfIVG53SYZQpGjdCdxlVMrDEa6k9+6lNis4hdUnHk/yUTVVrMlga8
        KYBIttwPaMM5co6AF2JltTkckOMJxhv6pY9/nnzVH6GlnKTUB5IMTSY+rWZG+MT1ttHkhZQ==
X-Received: by 2002:aa7:c551:: with SMTP id s17mr6175975edr.291.1616104387745;
        Thu, 18 Mar 2021 14:53:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8y53lyt1FcPexUfkNy+UGGapNITkk0VdAM81CjiDWZmPCLy3M3ruqB41QZCfEIjgoiW3sIw==
X-Received: by 2002:aa7:c551:: with SMTP id s17mr6175964edr.291.1616104387588;
        Thu, 18 Mar 2021 14:53:07 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id a17sm2620255ejf.20.2021.03.18.14.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 14:53:06 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 1/3] selinux: don't log MAC_POLICY_LOAD record on failed policy load
Date:   Thu, 18 Mar 2021 22:53:01 +0100
Message-Id: <20210318215303.2578052-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210318215303.2578052-1-omosnace@redhat.com>
References: <20210318215303.2578052-1-omosnace@redhat.com>
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
index dc9d7674f592..37b32b0035f6 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -654,14 +654,13 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
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
2.30.2

