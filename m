Return-Path: <SRS0=qOBY=OI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF34C43441
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 12:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C082081C
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 12:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C082081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeK3ACG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:02:06 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:45178 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbeK3ACF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Nov 2018 19:02:05 -0500
Received: by mail-wr1-f51.google.com with SMTP id v6so1773998wrr.12
        for <selinux@vger.kernel.org>; Thu, 29 Nov 2018 04:56:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t6kh0XCg+qx7I92y5yX5fAdL8M8WcEwvoVhdUYqr5+o=;
        b=CAf6vbnSzHPREWfYmuRSTvZ8yVVT1kdYgcnzl8iLliRymkQCqT4bIG28+AQWo25luD
         oO1t4WGxyGwBpVrtapF0CCq35Hmwgm1nCQ83c9+ZNfWhy6MUDW/w3+dg/wgbQR+mSw8j
         Nu7ZiEYjxzSX7ccc630CEy+bHO9skezt9+2uwTZqcLkBOTFIL5CSh7gzjj0CvRwCOBJY
         dspBoGLmR7DGUVhG1VmWuhSUnWc0XtjIFJ6FLlsKkBLgwo3f5R55iISkJ1hWD6oDpfLy
         xoxCCYlRDy8QeVTiYlPKVMYIXix5iof8562xAfSoax8Z7q5+eBfz/AI5OS7svajGtlwu
         K/6A==
X-Gm-Message-State: AA+aEWaOUpVKyVToMLxB2VADPrhuw+ordrRy+XlBCZj4HXXVZhOiaCoj
        D1D12TS54qHATXeBRkKYN0KRDumqQr4=
X-Google-Smtp-Source: AFSGD/V22Cbqymz/JTd3Tq+P/A7MCBMZv78GCuk1TMqUjbjFSO8mKUaxPsbDqxcsY+jFoWPE92pE4Q==
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr1325619wro.29.1543496207461;
        Thu, 29 Nov 2018 04:56:47 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 125sm2344952wml.35.2018.11.29.04.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 04:56:46 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [RFC PATCH v3 4/9] [fixup] cosmetic tweak for sidtab_search_core()
Date:   Thu, 29 Nov 2018 13:53:57 +0100
Message-Id: <20181129125402.5900-5-omosnace@redhat.com>
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
 security/selinux/ss/sidtab.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index 31588d704b98..45a50172f139 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -118,27 +118,28 @@ static struct context *sidtab_lookup(struct sidtab *s, u32 sid)
 	return &cur->context;
 }
 
+static struct context *sidtab_lookup_initial(struct sidtab *s, u32 sid)
+{
+	return s->isids[sid - 1].set ? &s->isids[sid - 1].context : NULL;
+}
+
 static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int force)
 {
 	struct context *context;
-	struct sidtab_isid_entry *entry;
 
 	if (!s)
 		return NULL;
 
 	if (sid != 0) {
-		if (sid > SECINITSID_NUM) {
+		if (sid > SECINITSID_NUM)
 			context = sidtab_lookup(s, sid - (SECINITSID_NUM + 1));
-		} else {
-			entry = &s->isids[sid - 1];
-			context = entry->set ? &entry->context : NULL;
-		}
+		else
+			context = sidtab_lookup_initial(s, sid);
 		if (context && (!context->len || force))
 			return context;
 	}
 
-	entry = &s->isids[SECINITSID_UNLABELED - 1];
-	return entry->set ? &entry->context : NULL;
+	return sidtab_lookup_initial(s, SECINITSID_UNLABELED);
 }
 
 struct context *sidtab_search(struct sidtab *s, u32 sid)
-- 
2.19.2

