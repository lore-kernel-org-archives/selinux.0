Return-Path: <SRS0=piI6=6W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FF0C54E4B
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A9024955
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vEcSbDsu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgEHPmW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 May 2020 11:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbgEHPmU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 May 2020 11:42:20 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF0BC061A0C
        for <selinux@vger.kernel.org>; Fri,  8 May 2020 08:42:20 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f83so1937521qke.13
        for <selinux@vger.kernel.org>; Fri, 08 May 2020 08:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wVuynlQlZbktWbEpwb1fylA6YGVqOTCn5M3Q/Mvg3IY=;
        b=vEcSbDsu1qINO1QVArsMa7pLMtWQ7socp84ZDM5QE1teDZh6X7LOTkNyrMg50KBM0w
         jVGChVEXcWgarZu6s+riw/3Hp2B14Prv1c6n7/yQ/Uuvaf3nVihE/izrtkHUu1MN4EFL
         ed3plPv+Dyg4vnSzWohwkZiOKU0w60dNo+qBDLL9BLOx89SGouTvjvHr5fRFadTzfen0
         0aWJjUVLf7ITd9tdsR+a2G8Rm2Q1i/xRbSN3yg7ILR6O5yC/cBloEd15vmBI24ZzCh+l
         b4OzlR6ZyAgx8o8hmV1AN02Yb+IDywWDc1W10NdLVs1VKIXSFVH9YJdmlje0IdQCal/Y
         704w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wVuynlQlZbktWbEpwb1fylA6YGVqOTCn5M3Q/Mvg3IY=;
        b=CQmUx7syJ3fss9owHPgGH6GaoYgaALyK3/+BLnugHtcOc8gKtuCTTybT3dwsh+oxTl
         1Jx/yk70j1dd8xELjZnf2pdBSMQEFhFM+MLryt8K8NsHvuBI9h4iJyc6x6QPjv02rxLy
         MPiCVJ0xq3MIw5Bj9OoGuzyyhLJ+hIlbhlRT+QOFLSgVB+4FKafTcFCqhetHuJullqgr
         WPcOoy/Z+HQYxed4SA1au9cJC8gosgXosV0X8pxBDQQFOj/V1yhEoLvJFhm+7LDiVfIz
         So8D1Ajoan4tTC14gku8nL0yk6pv1bXLuH/MWrDuOsxcbaKxSudpGvzZTc1F73SgooJx
         l0Jg==
X-Gm-Message-State: AGi0PuYHgDVkQtvUldZbGE+uHG1Vsjym6Hl1Q3kerUyXLf4zj1MLoLXW
        4hwFUgtpyO/4cD4XuabF6t6EXB2V
X-Google-Smtp-Source: APiQypJhZ2aDZKkJWqLQoBS9b0O63JMlyhKDjdIhs4z2AlCGxanak79cQgB532JpZCkMYdMg6FTf9Q==
X-Received: by 2002:a05:620a:1316:: with SMTP id o22mr3234881qkj.422.1588952539134;
        Fri, 08 May 2020 08:42:19 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id g5sm309055qkl.114.2020.05.08.08.42.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2020 08:42:18 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 testsuite 02/15] test_execute_no_trans.te: stop using mmap_file_perms
Date:   Fri,  8 May 2020 11:41:25 -0400
Message-Id: <20200508154138.24217-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.23.1
In-Reply-To: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
References: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

mmap_file_perms was deprecated in refpolicy in 2017 and is removed
from Debian policy. mmap_exec_file_perms is recommended by refpolicy
but RHEL-7 defined it differently (including execute_no_trans) so we
cannot use it here unconditionally. Just open-code the necessary
permissions and use the existing allow_map() macro defined by the
testsuite to cover map permission if defined.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policy/test_execute_no_trans.te | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/policy/test_execute_no_trans.te b/policy/test_execute_no_trans.te
index 79ba868..2c0346a 100644
--- a/policy/test_execute_no_trans.te
+++ b/policy/test_execute_no_trans.te
@@ -24,4 +24,5 @@ userdom_sysadm_entry_spec_domtrans_to(test_execute_notrans_t)
 
 #Allow test_execute_notrans permissions to the allowed type
 can_exec(test_execute_notrans_t,test_execute_notrans_allowed_t)
-allow test_execute_notrans_t test_execute_notrans_denied_t:file mmap_file_perms;
+allow_map(test_execute_notrans_t, test_execute_notrans_denied_t, file)
+allow test_execute_notrans_t test_execute_notrans_denied_t:file { getattr open read };
-- 
2.23.1

