Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C771C433E6
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 13:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 123E52311C
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 13:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbhAFN2B (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 08:28:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52597 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726430AbhAFN2B (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 08:28:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609939594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wTI5SKw4scWN+HP6705lJF5/x9BwGfvJaifgReVSZ+U=;
        b=C8cU1XeMpIqzOhIhdS0puzC9MUrqS0i0HHCpi3W7xhM6qb7TrHc5djPmPvueqSh+1RaVik
        6TWNEEbl2dd8cGGzxvr8IqSfE44Wt/dGqTsTQcrZlAIDZuEw3oqyvdLElIVZ6Zj4CVQv5Z
        mUs+P0sc4RqwDwGnE8NL/4jd4BFpbf0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-2MjxFX2lNpSVBuIEygthRg-1; Wed, 06 Jan 2021 08:26:33 -0500
X-MC-Unique: 2MjxFX2lNpSVBuIEygthRg-1
Received: by mail-ej1-f70.google.com with SMTP id y14so1296058ejf.11
        for <selinux@vger.kernel.org>; Wed, 06 Jan 2021 05:26:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wTI5SKw4scWN+HP6705lJF5/x9BwGfvJaifgReVSZ+U=;
        b=s6nrZ7jA7hC8WprsUq8gX4SxqbHkjIdHqfn/IPJtlM0g4fyP6f5XubQCrZ5GTuPQrY
         Nuw3adF3BBmPcw1HXUDdu25lg0ZPm0+dzXBHYXdkvK093LmwsmQbtY5foufonFbWSM30
         CjALVRnAzHx/zYCZ9LzAfvu/it6QH8izdfq9DBpu44bB95Pb88e6EyJ8onol8MMYxnW6
         9ORXOnzQd8iclpZnrkFi2DfmFIWum/xWwNV+hWPNZ09TuA4QCi5W0Hxajtdq/bcBPMet
         6TtfEc3P3ArlDVBUiz93BFYK4hE+zNd84RCMjyMpWLXo0MW5zodZ8hVHFGTzxQdW+5bo
         RX/A==
X-Gm-Message-State: AOAM532imHMGt7vXetdAftojqLCyAoRJhFa9/Dow8rP1reUoeMebTMtc
        +zUeOxMs9OfyfIozS6j/xS1KU7OC2U/3mXvp7ENApQVes8EyKLdiDdFacvx1ZaNa1gSK5CstGY+
        djKeuPGjhyVtGSx6LfrUX+z/UzoWQzUWhf2bEkkmoesDUfq5odt7xLH8hGm1/P9ieZ1eFew==
X-Received: by 2002:a17:907:4332:: with SMTP id ni2mr2917253ejb.422.1609939592084;
        Wed, 06 Jan 2021 05:26:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZ0n6e65n30Q56GF374U+UFHw/QtpKk8regNmVE7jb66jKrfQBOKcd3/IZwb+RKj+BAsa7NA==
X-Received: by 2002:a17:907:4332:: with SMTP id ni2mr2917238ejb.422.1609939591871;
        Wed, 06 Jan 2021 05:26:31 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id bm12sm1225893ejb.117.2021.01.06.05.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 05:26:31 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 2/5] selinux: drop the unnecessary aurule_callback variable
Date:   Wed,  6 Jan 2021 14:26:19 +0100
Message-Id: <20210106132622.1122033-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106132622.1122033-1-omosnace@redhat.com>
References: <20210106132622.1122033-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Its value is actually not changed anywhere, so it can be substituted for
a direct call to audit_update_lsm_rules().

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/services.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 597b79703584e..5e08ce2c5994a 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3693,15 +3693,11 @@ out:
 	return match;
 }
 
-static int (*aurule_callback)(void) = audit_update_lsm_rules;
-
 static int aurule_avc_callback(u32 event)
 {
-	int err = 0;
-
-	if (event == AVC_CALLBACK_RESET && aurule_callback)
-		err = aurule_callback();
-	return err;
+	if (event == AVC_CALLBACK_RESET)
+		return audit_update_lsm_rules();
+	return 0;
 }
 
 static int __init aurule_init(void)
-- 
2.29.2

