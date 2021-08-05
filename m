Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF30C4338F
	for <selinux@archiver.kernel.org>; Thu,  5 Aug 2021 08:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 235E7603E9
	for <selinux@archiver.kernel.org>; Thu,  5 Aug 2021 08:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237767AbhHEIrZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Aug 2021 04:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50432 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232258AbhHEIrZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Aug 2021 04:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628153155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZZma7ivsMxtSDjAG3wZCxfIa9qVkD8tZ9PjyC01nVeE=;
        b=DnJimNyVZU8LpIT23j2oHFgLFrNOLBVWeyWP0DzSLUhUCL1n5nN8XsZLlkkHe/8THwIaTs
        O2RReUrtATSfXm3tlbI/ffd4i31oLN2/tcQhOT0aXicvF9mDcLdQUhT8wR3KwLkSfu5WKQ
        m+Oe7l/IHT2YqRgZrsIemzUWktRlbhM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-G7m5KQ2hO8GUgkMQ3Rx3dw-1; Thu, 05 Aug 2021 04:45:54 -0400
X-MC-Unique: G7m5KQ2hO8GUgkMQ3Rx3dw-1
Received: by mail-wm1-f72.google.com with SMTP id c2-20020a7bc8420000b0290238db573ab7so2763949wml.5
        for <selinux@vger.kernel.org>; Thu, 05 Aug 2021 01:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZZma7ivsMxtSDjAG3wZCxfIa9qVkD8tZ9PjyC01nVeE=;
        b=riRKsejBh9CEb9uJRkRw7+OgOmHE8+/69JIKltHwwvWW/lcFm4t1RYE6roN4y01e09
         E89RvE071mhvUutZNcdHMqWLHtFq442xv7TbulMAFyk4+vnliQ1OOireYPoS0ZptXZnZ
         1F7JPuFcM1EPxk6x29DB/vbjaOClRHsssbUKhlS9nBUcfu0SgKCfE6HT2rZTH4bX7VKo
         9N1dqubmn9iHoh89/izv+dFMuCufhAbREC6u55YZKY7lmeAxgdF/f1P9Zv6pwMdg9ari
         8TBCIORn3Nv6Lo3gzrzGDqzPhYYM6zcDuwoCLDmKz/UwNEM4/W2OL8GSjPUDw7VHWg/M
         c9Nw==
X-Gm-Message-State: AOAM531kDfgLiJdBFwrkkS888/sUWLJf+tZQfxXZGG7uih+Xdv33ygeT
        srpHwSviwwY7ExS/mDx2BcM8Tzl7t+j/7zQ+EN8ZJz2lU9KeNYUD+i17FGzY+Gw55FoegYYpoKj
        /auTDlhiqD/+o1KUiGtAYrUj2JmZL3cdwKbEIvg9ivNv1jL5+kWAirqZk/WjgIuo/OppgRw==
X-Received: by 2002:adf:f710:: with SMTP id r16mr3925138wrp.124.1628153152667;
        Thu, 05 Aug 2021 01:45:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoOjUxCIrZLY9lYCCSUplYi7PFs3xlhGSh3teu2L27AoDLE2kBRPkginnUt6EqpkHnWc39nA==
X-Received: by 2002:adf:f710:: with SMTP id r16mr3925115wrp.124.1628153152421;
        Thu, 05 Aug 2021 01:45:52 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id j1sm8145497wmo.4.2021.08.05.01.45.51
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 01:45:51 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace] libsepol/cil: remove obsolete comment
Date:   Thu,  5 Aug 2021 10:45:50 +0200
Message-Id: <20210805084550.810783-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Commit a60343cabfc2 ("libsepol/cil: remove unnecessary hash tables")
removed FILENAME_TRANS_TABLE_SIZE macro that this comment was referring
to. Remove the comment as well to avoid confusion.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsepol/cil/src/cil_binary.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 41105c12..2b65c622 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -55,9 +55,6 @@
 #include "cil_find.h"
 #include "cil_build_ast.h"
 
-/* There are 44000 filename_trans in current fedora policy. 1.33 times this is the recommended
- * size of a hashtable. The next power of 2 of this is 2 ** 16.
- */
 #define ROLE_TRANS_TABLE_SIZE (1 << 10)
 #define AVRULEX_TABLE_SIZE (1 <<  10)
 #define PERMS_PER_CLASS 32
-- 
2.31.1

