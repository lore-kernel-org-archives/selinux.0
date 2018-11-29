Return-Path: <SRS0=qOBY=OI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC27C43610
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 12:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A7020834
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 12:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A7020834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbeK3ACE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:02:04 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:55729 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbeK3ACE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Nov 2018 19:02:04 -0500
Received: by mail-wm1-f41.google.com with SMTP id y139so2135531wmc.5
        for <selinux@vger.kernel.org>; Thu, 29 Nov 2018 04:56:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VUrGZNNdQQ3s0uR8GlV5aLr/1TMnN+6HuFlWt7eNfy8=;
        b=DZNph0FS52QurfwrWDzaXL5uylmdLE7SrxaW6DWzdcd6c6UVuLyjx46vqztyW2+fpb
         E9eGITwVNXzuTQb+8e6qpR7luzLmmZzJaYnHwShQ1ZsDts5cQdXhbn6BoGTqqoCAyeX0
         BAF2pspIq8Q86glSMDmnC0mQ3Y3mYPsyyg5nt0iO2viYY5rY0fOBoEPdcOIRIcUruGyj
         xcOITFQUs6t7VzyeXQtmNMwO5WtTM7oDjH2lodYh2ae/e4mtS0u3JNvWopFE+PELSfHD
         2PlEKx4KDdeY1NWPYQ1EmANaar1p93k52j/cNuFV+EmBoXWWICB7o+4MSjWqbu7eCXHv
         /xeQ==
X-Gm-Message-State: AA+aEWbe3xu7vRaPcLxtVM98WEd+G8IxxvJAmMiEIHF2rBuOZunh+E0f
        M81o3L2DHlbEU5gpqp9o2+KwLoDWqnw=
X-Google-Smtp-Source: AFSGD/V9jT3Tk4tBR48x8nfPpZ8PHCEAPYPJQ8559sDXMUEWachlfgrpVmaptPq+b0nV+KD++sJ7lA==
X-Received: by 2002:a1c:6783:: with SMTP id b125-v6mr1622984wmc.147.1543496206137;
        Thu, 29 Nov 2018 04:56:46 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 125sm2344952wml.35.2018.11.29.04.56.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 04:56:45 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [RFC PATCH v3 3/9] [fixup] fix handling of SECSID_NULL
Date:   Thu, 29 Nov 2018 13:53:56 +0100
Message-Id: <20181129125402.5900-4-omosnace@redhat.com>
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
 security/selinux/ss/sidtab.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index e157d8240cf1..31588d704b98 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -123,17 +123,19 @@ static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int force)
 	struct context *context;
 	struct sidtab_isid_entry *entry;
 
-	if (!s || sid == 0)
+	if (!s)
 		return NULL;
 
-	if (sid > SECINITSID_NUM) {
-		context = sidtab_lookup(s, sid - (SECINITSID_NUM + 1));
-	} else {
-		entry = &s->isids[sid - 1];
-		context = entry->set ? &entry->context : NULL;
+	if (sid != 0) {
+		if (sid > SECINITSID_NUM) {
+			context = sidtab_lookup(s, sid - (SECINITSID_NUM + 1));
+		} else {
+			entry = &s->isids[sid - 1];
+			context = entry->set ? &entry->context : NULL;
+		}
+		if (context && (!context->len || force))
+			return context;
 	}
-	if (context && (!context->len || force))
-		return context;
 
 	entry = &s->isids[SECINITSID_UNLABELED - 1];
 	return entry->set ? &entry->context : NULL;
-- 
2.19.2

