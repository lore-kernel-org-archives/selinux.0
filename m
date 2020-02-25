Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82963C35E14
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A7A21556
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpUJ675x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731712AbgBYUCv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:02:51 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33846 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731709AbgBYUCv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 15:02:51 -0500
Received: by mail-pl1-f194.google.com with SMTP id j7so256163plt.1
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2020 12:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JPfhyaVGjlncBwrhSSr7GTZqxFHYwwKsyDxbfAgBSBg=;
        b=jpUJ675xBCjCSN2PKHXB0o2OdOgY2zoB+Y7/tXybHrubLTB8Hjk1LdcdQNsV3TWLMF
         fGFX+qGDyBhehYn5Y/ZKcwdaAIPMFlc2JZDkD145p5Jq/pMqMAbgjgLc6+HAY9Y7e/va
         EdmQIY3yQcpfDedyFwW1L5hvAH1UopGUk002gcXvYPGxnCsdYFPRpU3RTwqfIsUM7U+J
         7IbKdQQ9j7KUH6gASB+1s2+X1Aa7FBosLihG2hDTcbRKHzO1b/dZtUOJN3D3g9Y9Rgok
         iOudcJpwoZVJ/8UnQPcHTTL6zbQgegLGf0Z/9Ud56CseJihd9MzIzcwazxd39yTEg4x4
         wi2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JPfhyaVGjlncBwrhSSr7GTZqxFHYwwKsyDxbfAgBSBg=;
        b=UZ6UJf9E79a0fRC2mP04ZqS15EDDUZGgeWNdTTjK8QFvVFLh/hcpxBo4ZtPGXrpOob
         8AKEGJQ+gKlWEVImPEwWHbonpbV1t5Qe5dC1isyrNk9EPrRWAt/ExSKpiE8X6eyK4QU7
         Jcz894kEGP6mbfk6OKsZblcaOuAl2Nn06WkZ7qCNvRn1Oy5cPHEUTnY/DEsA+kvigHR0
         5/5bWTTwSYFrq6SrmH7tHwdRxMTA5e9hhO3dX/67sQcxLlt8+GUewzrF63Z6cjcldfVj
         u0VXO3k22jJdNdVrD8wAB+U8WyROTzX/5cajMPi1bDZJqvGgJer0CVOdYT8qRWtMkWr0
         EWcQ==
X-Gm-Message-State: APjAAAWD4xQqu/x03gD6YWOwEVqB3gR566AlAc3NuNkKx0vsG58HnNjC
        bNNOnq38TXvQanGhtYHvOps=
X-Google-Smtp-Source: APXvYqzVUPgVGXAYdQ5GyrO/HyKFCXuCI0tB+jg7FpHrygvHUVz9Z83pYXSIvJtzG0mhR2DRgzzBUw==
X-Received: by 2002:a17:90a:c389:: with SMTP id h9mr838298pjt.128.1582660970409;
        Tue, 25 Feb 2020 12:02:50 -0800 (PST)
Received: from localhost.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id v29sm10636362pgc.72.2020.02.25.12.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:02:50 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     sds@tycho.nsa.gov, plautrba@redhat.com, selinux@vger.kernel.org
Cc:     William Roberts <william.c.roberts@intel.com>
Subject: [PATCH 07/17] sidput: annotate deprecated
Date:   Tue, 25 Feb 2020 14:02:09 -0600
Message-Id: <20200225200219.6163-8-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225200219.6163-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/include/selinux/avc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/avc.h b/libselinux/include/selinux/avc.h
index c5c842a34470..472f6918ca83 100644
--- a/libselinux/include/selinux/avc.h
+++ b/libselinux/include/selinux/avc.h
@@ -76,7 +76,7 @@ extern int sidget(security_id_t sid) __attribute__ ((deprecated));
  * zero, the SID is invalid, and avc_context_to_sid() must
  * be called to obtain a new SID for the security context.
  */
-extern int sidput(security_id_t sid);
+extern int sidput(security_id_t sid) __attribute__ ((deprecated));
 
 /**
  * avc_get_initial_sid - get SID for an initial kernel security identifier
-- 
2.17.1

