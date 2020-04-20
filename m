Return-Path: <SRS0=faga=6E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1DEC3815B
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC1282078E
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AH11fX6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgDTPpx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbgDTPpw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 11:45:52 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C393C061A0C
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:45:52 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g2so4096699plo.3
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5IskOwX5UcT748ON1fTtfkF0uP1N9WejQ0M281usXu4=;
        b=AH11fX6FWLQYPdMC11iVj00IutOEApX3KIZGmx/munlvuva7Rn0GmreuIaRq4sxJPN
         7B/C8r9dwhZGJLh7n61zVKFhjE1pxvh/0FAy6bufO4ZLJTng8z0LPPY+IBwXQL/3ooRC
         /UlgwgyD+ToTml5e3e7KHRp3ItdFUHEXlyXZuYxOR8XwGxFozEY/fk+ru8asJ7iGz0Rs
         Q61hBEmAnDOuKQCgirCZwVzIjXUY5QrWDOPmaIbruZcTzWaIB48YKL4pjmqzC6EPA5LN
         H8gI9jmb999vQpgjvRAh/nAXjwxOk2INplK/e7pNohxtqseCnFZ1QHQjzeTSQt6mE0GG
         zN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5IskOwX5UcT748ON1fTtfkF0uP1N9WejQ0M281usXu4=;
        b=pHuRIGqwwk881JinjAZJK/elW5E08oMgQda9mZeMarKfBJUy6PZpfztwQADifpx9fW
         NmXaNNl3ZVx8l26+vRYwhItT0ubaLIxXG1TcKT5K4mmwA2HgcC0mdT65hSEyYjrdyNhQ
         xMkwiEXJceM2yDIVH0S9YqTf5QkzBkzoDyU143JG1zMGB4KXfIk2B92/ig0KS8xTknpk
         Z5QVwLs83kopfZ3qH5/Q+x89REXABxQje5NnTxUSLi+Qv9tvhDMFhHvdTJtvOgojp56l
         cJEgcs461fJXROUFZOOrgcunjqynA06Z31F392aJh9stY9J36qNDZxu7kbXUs+x8Q4Hb
         T/Jw==
X-Gm-Message-State: AGi0PubTqZdsmo240vMNy3zd9Ym5aR6qQJArWrNX44HiQbC9l3bA94LC
        a/MRTjADDSRmIbbiGMp6hPtuWMnaxWg=
X-Google-Smtp-Source: APiQypKZNLPIeCo8VYy4uAIxfaavSTc9D7tIFZzI0u++F3t6R6zZxh7Ig/TqyyzXHGclMewej/DPDw==
X-Received: by 2002:a17:902:9892:: with SMTP id s18mr17739590plp.321.1587397551315;
        Mon, 20 Apr 2020 08:45:51 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id i15sm1367507pfo.195.2020.04.20.08.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:45:50 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org
Cc:     bill.c.roberts@gmail.com, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v3 03/19] selinux_booleans_path: annotate deprecated
Date:   Mon, 20 Apr 2020 10:45:21 -0500
Message-Id: <20200420154537.30879-4-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420154537.30879-1-william.c.roberts@intel.com>
References: <CAJfZ7==Ote6uQWMjDfNMA=qj79u2ByrnrH==++gDOhPeYD-W5g@mail.gmail.com>
 <20200420154537.30879-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/include/selinux/selinux.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index ae70479511db..19b22c166651 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -579,7 +579,11 @@ extern const char *selinux_contexts_path(void);
 extern const char *selinux_securetty_types_path(void);
 extern const char *selinux_booleans_subs_path(void);
 /* Deprecated as local policy booleans no longer supported. */
-extern const char *selinux_booleans_path(void);
+extern const char *selinux_booleans_path(void)
+#ifdef __GNUC__
+__attribute__ ((deprecated))
+#endif
+;
 extern const char *selinux_customizable_types_path(void);
 /* Deprecated as policy ./users no longer supported. */
 extern const char *selinux_users_path(void);
-- 
2.17.1

