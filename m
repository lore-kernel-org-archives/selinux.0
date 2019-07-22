Return-Path: <SRS0=8ULP=VT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B448C76194
	for <selinux@archiver.kernel.org>; Mon, 22 Jul 2019 13:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295DA21901
	for <selinux@archiver.kernel.org>; Mon, 22 Jul 2019 13:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfGVNVQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:21:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40129 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbfGVNVQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Jul 2019 09:21:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id r1so39395274wrl.7
        for <selinux@vger.kernel.org>; Mon, 22 Jul 2019 06:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6xdFD26pzy0BMDeFjS2w4OeuE3vbxUzI4nJ0HnGm5ug=;
        b=AalcruJ6WfWetIF8Sp6xgw7gckIAwOsWZFyZvIPGWpOuOUfUVmrEfH5lOvpnRzHYiA
         ubWtPZrbOtTkKD2OWrwgqk08NAp7yF4eyletnY5li0wZB+Z1EYMj9DmnNIBgDWJfiLc6
         IDXo8epVCZwfuGEWWMR8s/VQ+6L/kWkLNFYwJ+mziT6161m89U5qtAG7rs/tmV7eIlq3
         BAbGlFdz93QkgSYWmCqZsc89A8YdV34yUzWe0iN8rpW4VDMV9D2oG+tHv6s5oi4ad0C9
         UDoRDDfi9YeCH2u+7/EdzaDNmWzeemwO6olixfAgYKsAT/s7aaBIo9D1DZyorPVPtiEe
         4h7Q==
X-Gm-Message-State: APjAAAV8J2ZSrkY4C3VWT9XF26BGDzmXmpcyLTs0VuPewV18vpDmsPrf
        vYPdkAen8II2WXgG7hTeR82HTGyFm2A=
X-Google-Smtp-Source: APXvYqwMNDPSQy9ey7HxRTb4UR6sXwjdyOcJy6lL3Od55VZGCNZO1lT9/D6hKg/gJFNitDWBaLbjEw==
X-Received: by 2002:adf:e843:: with SMTP id d3mr26317115wrn.249.1563801674266;
        Mon, 22 Jul 2019 06:21:14 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f70sm46021087wme.22.2019.07.22.06.21.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 06:21:13 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     NitinGote <nitin.r.gote@intel.com>,
        kernel-hardening@lists.openwall.com,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] selinux: check sidtab limit before adding a new entry
Date:   Mon, 22 Jul 2019 15:21:11 +0200
Message-Id: <20190722132111.25743-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

We need to error out when trying to add an entry above SIDTAB_MAX in
sidtab_reverse_lookup() to avoid overflow on the odd chance that this
happens.

Fixes: ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve performance")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/sidtab.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index e63a90ff2728..54c1ba1e79ab 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -286,6 +286,11 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
 		++count;
 	}
 
+	/* bail out if we already reached max entries */
+	rc = -ENOMEM;
+	if (count == SIDTAB_MAX)
+		goto out_unlock;
+
 	/* insert context into new entry */
 	rc = -ENOMEM;
 	dst = sidtab_do_lookup(s, count, 1);
-- 
2.21.0

