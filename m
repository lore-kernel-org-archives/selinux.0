Return-Path: <SRS0=qOBY=OI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF23DC04EBA
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 12:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04382081C
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 12:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04382081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbeK3ACK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:02:10 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:54753 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbeK3ACK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Nov 2018 19:02:10 -0500
Received: by mail-wm1-f53.google.com with SMTP id z18so2155128wmc.4
        for <selinux@vger.kernel.org>; Thu, 29 Nov 2018 04:56:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e6+dzIW0AvH4FYBynlB96KspnUP1tPaoHBqZTqKBVpI=;
        b=aJ3FYGHFpQVHg2D831OKDLOdt6oa8pg5b9LCJln1+JHwXeWipWbBr3tGRlJBCwyi6v
         BfgY8m7wQFrr0+rjN1J3pBKOWzDdRoLqUODMiFe4Mxp4t0mUr6Cu1OmmykF/9xC1yb75
         FlF8FTO2KVxDXmt/kD4tUUSoW2Z1Uzo/kVkAnuXoqtEyavfco2DYr8xwzsZ+YdWABzec
         Gt+zMrBGqDlkPVinc/9lOe9cgSGCB3a8AzUv/uD2eIaLgOH19a0U4+qPPlAxCTRhxff6
         W4Ry+38CqnCy1bLQ+DTSzeKLFfvPO6kLWHqzpxF1IbVpqxkFTCz1WIx7obH1BYrbuHme
         JYGQ==
X-Gm-Message-State: AA+aEWbs1MuCQTPb2mbfHrEXNzy/IoaQbfyTyoAiofqDSvqhvvVLFBAY
        prF4FR6eciuqrCpjyRDZvtwneXRlTVM=
X-Google-Smtp-Source: AFSGD/Woa/znWsj0UOh16v+j6SXU3XraaevbHwvXShamcmtdIRev9PsLiTL/uJj9054k/+GtflzU9g==
X-Received: by 2002:a1c:b0f:: with SMTP id 15mr1702603wml.128.1543496212151;
        Thu, 29 Nov 2018 04:56:52 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 125sm2344952wml.35.2018.11.29.04.56.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 04:56:51 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [RFC PATCH v3 8/9] [fixup] fix SIDTAB_LEAF_ENTRIES to use the correct size macro
Date:   Thu, 29 Nov 2018 13:54:01 +0100
Message-Id: <20181129125402.5900-9-omosnace@redhat.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129125402.5900-1-omosnace@redhat.com>
References: <20181129125402.5900-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

---
 security/selinux/ss/sidtab.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
index 292512792a70..4c46a48f8d7e 100644
--- a/security/selinux/ss/sidtab.h
+++ b/security/selinux/ss/sidtab.h
@@ -36,9 +36,9 @@ union sidtab_entry_inner {
 
 #define SIDTAB_INNER_SHIFT \
 	(SIDTAB_NODE_ALLOC_SHIFT - size_to_shift(sizeof(union sidtab_entry_inner)))
-
-#define SIDTAB_LEAF_ENTRIES  (PAGE_SIZE / sizeof(struct sidtab_entry_leaf))
 #define SIDTAB_INNER_ENTRIES ((size_t)1 << SIDTAB_INNER_SHIFT)
+#define SIDTAB_LEAF_ENTRIES \
+	(SIDTAB_NODE_ALLOC_SIZE / sizeof(struct sidtab_entry_leaf))
 
 #define SIDTAB_MAX_BITS 31 /* limited to INT_MAX due to atomic_t range */
 #define SIDTAB_MAX (((u32)1 << SIDTAB_MAX_BITS) - 1)
-- 
2.19.2

