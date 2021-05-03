Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346E7C43617
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E6E6121D
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhECRzE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 13:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbhECRy6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 13:54:58 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419EEC06134B
        for <selinux@vger.kernel.org>; Mon,  3 May 2021 10:54:04 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u3so9148837eja.12
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 10:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QzQumgOJmDZxWmsBJ+ObYe9igAM8BCQXhoezYQw89vI=;
        b=L1RW0onlI7NIRF1IucZ7QxZhqULN3+W+MIoAlXfeD6eVJ+Pkw5anYbCx62aFLATi2F
         JxLK42s14LEcSFhHukkbYoDhm+ZgsHCkXXVJUcvtZuQmm3yLpHNWr6CATJf+Lj8XFC0d
         aGg/k5oH23BChWr6itzaulRdPSGfkGjwJUq8M9JfizOUEaTJlKyBu967iM/ZbOJz7AEd
         1q4ZjDVl6CbyJ6SPM9Zn4VwMkaDKz+Y6rlzKRICrm7H89Duqfvo06APq1gR1YuydJFyX
         D562PzsfW16M2x986V3i4pDePnYUEIFw6LrdJkW2+OvoRBNGWnLWjcFxWm3Uu2h4DIzv
         dnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QzQumgOJmDZxWmsBJ+ObYe9igAM8BCQXhoezYQw89vI=;
        b=D8Wqc1mGo2ntFG0ywV0uw+qwRDivpbT66Sy0oGPk9otiGQ6HgeRKV+r6f5+BtHupbm
         3A7k08SlcrkxMklZUaF8WYAZjtvwNf8GpKMq+HHt7ZdYlwx1KU8gHY+NhcxodSVugkPz
         g9Ul99KtwXW0QgalrYNA+7xPhytf4XGIEuAwlejAMzlckAopR1fKzeFxm4u4HpJdpmes
         ios/y2yw6NBE5ETUACtNilrTMMfqp/5z/7mHB9YjlmzMIhd87STNwQogLdubiggwvKNx
         hv86XLoEaY8uGyrHyMzvrMzthByUHdRJlkVUIHRcWSpIPiYIOiP7n3XLDYhixBZ2KbqI
         L2Bg==
X-Gm-Message-State: AOAM530vAPbu6/ZBGl3Sf/EjOVz+Yz8zAgjE3AjXy6TLU+irJC0CeTzr
        VrPfPc2yzWU/XGfe07qhHi3kYhN1/Me6MA==
X-Google-Smtp-Source: ABdhPJyXhj9Hf6wH4UaSUkmGKnMlL1o+xXolKAPVDzUrZSxdYH/HsZ6Xu8B49U6aVlLJUhX/jQxlTg==
X-Received: by 2002:a17:906:13c9:: with SMTP id g9mr18106296ejc.69.1620064442604;
        Mon, 03 May 2021 10:54:02 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-172-037.77.0.pool.telefonica.de. [77.0.172.37])
        by smtp.gmail.com with ESMTPSA id b17sm1830165edr.80.2021.05.03.10.54.02
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:54:02 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 23/25] libselinux: sidtab_sid_stats(): unify parameter name
Date:   Mon,  3 May 2021 19:53:48 +0200
Message-Id: <20210503175350.55954-24-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503175350.55954-1-cgzones@googlemail.com>
References: <20210503175350.55954-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Found by clang-tidy.

libselinux/src/avc_sidtab.h:32:6: warning: function 'sidtab_sid_stats' has a definition with different parameter names [readability-inconsistent-declaration-parameter-name]
void sidtab_sid_stats(struct sidtab *s, char *buf, int buflen) ;
     ^
libselinux/src/avc_sidtab.c:103:6: note: the definition seen here
void sidtab_sid_stats(struct sidtab *h, char *buf, int buflen)
     ^
libselinux/src/avc_sidtab.h:32:6: note: differing parameters are named here: ('s'), in definition: ('h')
void sidtab_sid_stats(struct sidtab *s, char *buf, int buflen) ;
     ^                               ~
                                     h

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/avc_sidtab.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/avc_sidtab.c b/libselinux/src/avc_sidtab.c
index 8c81cf65..f179d855 100644
--- a/libselinux/src/avc_sidtab.c
+++ b/libselinux/src/avc_sidtab.c
@@ -100,7 +100,7 @@ sidtab_context_to_sid(struct sidtab *s,
 	return rc;
 }
 
-void sidtab_sid_stats(struct sidtab *h, char *buf, int buflen)
+void sidtab_sid_stats(struct sidtab *s, char *buf, int buflen)
 {
 	int i, chain_len, slots_used, max_chain_len;
 	struct sidtab_node *cur;
@@ -108,7 +108,7 @@ void sidtab_sid_stats(struct sidtab *h, char *buf, int buflen)
 	slots_used = 0;
 	max_chain_len = 0;
 	for (i = 0; i < SIDTAB_SIZE; i++) {
-		cur = h->htable[i];
+		cur = s->htable[i];
 		if (cur) {
 			slots_used++;
 			chain_len = 0;
@@ -124,7 +124,7 @@ void sidtab_sid_stats(struct sidtab *h, char *buf, int buflen)
 
 	snprintf(buf, buflen,
 		 "%s:  %u SID entries and %d/%d buckets used, longest "
-		 "chain length %d\n", avc_prefix, h->nel, slots_used,
+		 "chain length %d\n", avc_prefix, s->nel, slots_used,
 		 SIDTAB_SIZE, max_chain_len);
 }
 
-- 
2.31.1

