Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688F0CCA47A
	for <selinux@archiver.kernel.org>; Thu, 16 Jun 2022 13:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376387AbiFPNOT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jun 2022 09:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376998AbiFPNOP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jun 2022 09:14:15 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0124E3981B
        for <selinux@vger.kernel.org>; Thu, 16 Jun 2022 06:14:14 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b8so2121553edj.11
        for <selinux@vger.kernel.org>; Thu, 16 Jun 2022 06:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UTWtabnJa7Xg8h74E8kl3qJqlm+q/2RlSTvMbZVkOyg=;
        b=aaeywK2+88GJN0Xj8XfnhMAxu40IqADOWr68wIMClivgZgjB0tynt5iINdM1uo5ttp
         mWcp1xiVu6hpm2y3rgFizgKHd07zRrVB5/M1WUyxGLRIuU28ADtVcSzsjUE98395Mtx6
         VHhLrT5H80xAbBFcNQSt0nVONn6zkcGg6sAQuzoVNBVfzI0v+Mie/oBKbM7IbBYhQkTt
         vkidfAbWm8hM1IoBY3mcK8gMX9lTil4YePghqpYg6W2KlkilxEuVYYV0IelQS66Usr35
         FLc+R6zwOc2wCeHn/qVKa84I8LsXakn/SzuI67zp9UU7UBFOQAZhFIjtjyQDfmXnr2H6
         KTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UTWtabnJa7Xg8h74E8kl3qJqlm+q/2RlSTvMbZVkOyg=;
        b=vPY70XkSt/c3iuDLVidPJHTgLptMLQPiivSxwJDUdreIxqo9z8a+Pf4JPTnnHsEMuS
         IUVCTrqgdK9DIALLgveMGfb2VsMfHv7I6D2LSLVTC8czOYk6yuMJGahRm6x9R9tIBYNq
         HnLhnikOhm+ULrNC63XoE7PU2MPsHAYJG640IOeWO2+uT4RssF5MtD7ee0Vgv0p0W+xr
         xIQLMuSod978CVE86KTdrlCZhYTjZD/KfvIOY7auruOVtNeZRI8sfjUXWoNu8YGvr5eV
         wXzfWBvD9XHorkdc16XRQgjT0692eB/jJH+E310IWkj7LaM3jVMZ8Ft6RUYEiBSEa+lF
         feyQ==
X-Gm-Message-State: AJIora8xooT0Xot2Ickfx2B2oiD30YYe9jGG7pNuypaKk/ESgD9oBWsS
        Xxm40XiY0tCnqlvnHn+QizipSKrfJeMlXA==
X-Google-Smtp-Source: AGRyM1s88q2p1rXmq2ugx+QkGrpRIwQHZToBPvpDNgFV/25HCPdOsuaEzgxXurZhAteIGVBYPcLRLg==
X-Received: by 2002:aa7:d895:0:b0:42e:985:40f7 with SMTP id u21-20020aa7d895000000b0042e098540f7mr6384607edq.351.1655385253491;
        Thu, 16 Jun 2022 06:14:13 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-158-068.77.8.pool.telefonica.de. [77.8.158.68])
        by smtp.gmail.com with ESMTPSA id y11-20020a056402270b00b0042e1cbc4471sm1831530edd.3.2022.06.16.06.14.12
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 06:14:13 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 2/4] libsepol: add ebitmap iterator wrapper with startnode
Date:   Thu, 16 Jun 2022 15:14:07 +0200
Message-Id: <20220616131409.23271-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220616131409.23271-1-cgzones@googlemail.com>
References: <20220616131409.23271-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Similar like ebitmap_for_each_bit() iterates over all bits of an ebitmap
add ebitmap_for_each_bit_starting() iterating over all bits starting
from a specific node and bit, which can be from an outer iteration.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/include/sepol/policydb/ebitmap.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/include/sepol/policydb/ebitmap.h
index 81d0c7a6..83ff54c2 100644
--- a/libsepol/include/sepol/policydb/ebitmap.h
+++ b/libsepol/include/sepol/policydb/ebitmap.h
@@ -80,6 +80,13 @@ static inline int ebitmap_node_get_bit(const ebitmap_node_t * n, unsigned int bi
 #define ebitmap_for_each_positive_bit(e, n, bit) \
 	ebitmap_for_each_bit(e, n, bit) if (ebitmap_node_get_bit(n, bit)) \
 
+#define ebitmap_for_each_bit_starting(e, startnode, startbit, n, bit) \
+	n = startnode; \
+	for (bit = ebitmap_next(&n, startbit); bit < ebitmap_length(e); bit = ebitmap_next(&n, bit)) \
+
+#define ebitmap_for_each_positive_bit_starting(e, startnode, startbit, n, bit) \
+	ebitmap_for_each_bit_starting(e, startnode, startbit, n, bit) if (ebitmap_node_get_bit(n, bit)) \
+
 extern int ebitmap_cmp(const ebitmap_t * e1, const ebitmap_t * e2);
 extern int ebitmap_or(ebitmap_t * dst, const ebitmap_t * e1, const ebitmap_t * e2);
 extern int ebitmap_union(ebitmap_t * dst, const ebitmap_t * e1);
-- 
2.36.1

