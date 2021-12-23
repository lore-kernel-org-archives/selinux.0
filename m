Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1903C433F5
	for <selinux@archiver.kernel.org>; Thu, 23 Dec 2021 18:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbhLWSTz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Dec 2021 13:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbhLWSTy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Dec 2021 13:19:54 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E3FC061401
        for <selinux@vger.kernel.org>; Thu, 23 Dec 2021 10:19:54 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id b13so24518641edd.8
        for <selinux@vger.kernel.org>; Thu, 23 Dec 2021 10:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7/pVvlaw3dQ+hNhaJ+ezt3lbql3IB17VLkUZqUwyQUQ=;
        b=oxuBq62hdJS4teSlS+sVYseENqOyVGmvQCj98V77aPu52cpKH1d9hvGLJjEkdnP1Zt
         n2FSbOkxoFZ/ZTTp4lvHckVX/UmqxkZdwnwp7FjAfjmZVObALqrEeo/wEGOWzMzF1RpB
         7Yj9IoqLb8WFfXfC97HLEHFcWxSnniD6bjDVPri8r2Nidw6dmrXkZ02SCkOm//6UIukv
         hJTAyy3BMk1chqLw7gtgUR4KeINR+Z+nc7Fks+A7DtT8nDUrmlp3dUhU3aeBfzBkURP+
         POhnnpaA/HZ6GZmGMm6Se2J89B5xfvgZR5gD4/xQ8GIYSTaSaiGiaw/SMVSrM3qNFiFl
         X7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7/pVvlaw3dQ+hNhaJ+ezt3lbql3IB17VLkUZqUwyQUQ=;
        b=vH2jesd1lXGsV3X8BH6MWw8uBh+Fd2E4HDmhVJghnQXzsGIsP8LrzwR40tAO7Vfwmx
         UKNC2CyQQ5ib6E+hfdy3zWInMg1qM0T1ip6TMfRgL3J1xXxLLSTvk569t1d6sP2XoeT9
         yck6M+t4pSn8gm3y64du0WBkWZsIwQxLzLx7VLv1C91yZ6QQaq8QSGUY0kAaGMQaWvlE
         qFhrPpxekV7+qKgKh+OTikgfzBHCMKl4jZ5tHsXmYw8+WWfUXez7aCd2Q2RoPLetUnfW
         i0ycrW5XtRzemduRIHY2mXz5U97K9nUO2jjgsLht4oAiHt8DhGnioGGqlod50DnWAsqo
         WFYg==
X-Gm-Message-State: AOAM5335wZ5Rb6XBxdQd90v1CHbg39pf24gmLJP1IQvHJKjNnKxrNhKb
        JbbE4WIcrSvyEhxoZSPsCWC3RRCbwVwVNA==
X-Google-Smtp-Source: ABdhPJyU9SZrLVYtMaSYWMt885/v1FK+4fetFrx9OOzTCQOZMXq9eD0i1299GJQvoCDdoCkhdGfwcQ==
X-Received: by 2002:a17:906:4918:: with SMTP id b24mr2750847ejq.466.1640283592789;
        Thu, 23 Dec 2021 10:19:52 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-008-107-221.77.8.pool.telefonica.de. [77.8.107.221])
        by smtp.gmail.com with ESMTPSA id z18sm2266439edc.76.2021.12.23.10.19.51
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 10:19:52 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2] libsepol: check for valid sensitivity before lookup
Date:   Thu, 23 Dec 2021 19:19:45 +0100
Message-Id: <20211223181945.68723-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Check the sensitivity is valid and thus the lookup in the name array
`p_sens_val_to_name` is valid.

Found by oss-fuzz (#42729, #42730, #42735, #42741)

    ==54784==The signal is caused by a READ memory access.
        #0 0x5a10f3 in mls_semantic_level_expand ./selinux/libsepol/src/expand.c:934:11
        #1 0x53839e in policydb_user_cache ./selinux/libsepol/src/policydb.c:972:7
        #2 0x5c6325 in hashtab_map ./selinux/libsepol/src/hashtab.c:236:10
        #3 0x5392e9 in policydb_index_others ./selinux/libsepol/src/policydb.c:1274:6
        #4 0x53f90a in policydb_read ./selinux/libsepol/src/policydb.c:4496:6
        #5 0x50c679 in LLVMFuzzerTestOneInput ./selinux/libsepol/fuzz/binpolicy-fuzzer.c:35:6
        #6 0x4409e3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) (./selinux/out/binpolicy-fuzzer+0x4409e3)
        #7 0x4295bf in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) (./selinux/out/binpolicy-fuzzer+0x4295bf)
        #8 0x42f850 in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) (./selinux/out/binpolicy-fuzzer+0x42f850)
        #9 0x45b6d2 in main (./selinux/out/binpolicy-fuzzer+0x45b6d2)
        #10 0x7f059fcd71c9 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
        #11 0x7f059fcd7277 in __libc_start_main csu/../csu/libc-start.c:409:3
        #12 0x423900 in _start (./out/binpolicy-fuzzer+0x423900)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

---
v2: also check the entry is non-null

---
 libsepol/src/expand.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 8a7259a0..898e6b87 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -929,6 +929,10 @@ int mls_semantic_level_expand(mls_semantic_level_t * sl, mls_level_t * l,
 	if (!sl->sens)
 		return 0;
 
+	/* Invalid sensitivity */
+	if (sl->sens > p->p_levels.nprim || !p->p_sens_val_to_name[sl->sens - 1])
+		return -1;
+
 	l->sens = sl->sens;
 	levdatum = (level_datum_t *) hashtab_search(p->p_levels.table,
 						    p->p_sens_val_to_name[l->sens - 1]);
-- 
2.34.1

