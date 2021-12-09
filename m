Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B2EC433EF
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241365AbhLIQz7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241357AbhLIQz5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:55:57 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125C7C0617A2
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:52:23 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y13so21203851edd.13
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hRyFyymGX635Ws816SfNq1nKv/ZEM8n1jocSF4iS00k=;
        b=d6ELeJ8+sN4vsHKYWlujCplwLgKor1UW1m2lIAKXvm70wZO6uxwwilmWu0eQ/FeebL
         gVm47ANleFql3z4wLN6HZ2EIfiF7RAmLY1ere5TQ5LBbHKxTBu6lsB2/VDW1RNn+Qo0T
         wcr4M4bRKBBwn06H77oLMHUJdYeVMy9WSNjLOKPy1Su9PLiIyYaacwS37w0SmzcEjWxt
         1TVHbwyMFLW3dIGYk8pX9YZ571Nuaq/tl0tdiSltdgLXSerw8oJvZV6mHIE32KlbdvNg
         lqGKh7R2zJL2n8VFFdVRVX44cYQChngfG+OtH38eGaktF15Xcl9zjilrMbyEBohBj7bE
         awuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hRyFyymGX635Ws816SfNq1nKv/ZEM8n1jocSF4iS00k=;
        b=y0pZr7Z7uvoKorFrShD8Q+Gajf9M6dfwMTD2/tZ0WV2KGcH1zu2WJs3YM22KCOzzEq
         sPx3MZQc3lMs6HPkB1gdM72Q/sIsAROek/x/P67TN2uaAfA5ktMfMmlw04H+Hl1yEnHW
         EBCiSunqzm08tjCgLH0zxQZVa0ww8l49VcLe/KNtfBm8lmAxz1UQfupY3pswc7KSm5qb
         1Cnh2sgcFJoDpLjDoG0DLc52nM5oz/1bP0w8rO07SuMDmr4Pxf3nByx5wgP9/cZsU6zn
         Ya4IzEljabA6yySYapwf3ycAwRwqIDilyZpd2LX9fd7pI+395JF76G/03+cZvy7XTIkC
         hzlw==
X-Gm-Message-State: AOAM531MjR0CE4irNjyPluqCbk52TNEvgzJ3+t8ysaF8EMijO0x7pmJC
        iC7KvlHczU4faZ/Z6F/+KloydHTdxOU=
X-Google-Smtp-Source: ABdhPJymANUcyQZgUe2aVu5uuGkFoe7TebtVUBvtPbUDZGoN/bFK61p4W1TId8iBnvPsFhPoyWSfEg==
X-Received: by 2002:a17:906:1613:: with SMTP id m19mr17631833ejd.136.1639068590736;
        Thu, 09 Dec 2021 08:49:50 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.50
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:50 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 23/36] libsepol: validate MLS levels
Date:   Thu,  9 Dec 2021 17:49:15 +0100
Message-Id: <20211209164928.87459-24-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209164928.87459-1-cgzones@googlemail.com>
References: <20211105154542.38434-1-cgzones@googlemail.com>
 <20211209164928.87459-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Validate the level map of the policy to ensure no level refers to a non
existent category.

READ of size 8 at 0x602000000c58 thread T0
    #0 0x568d2c in cats_ebitmap_len ./libsepol/src/kernel_to_conf.c:1003:14
    #1 0x568d2c in cats_ebitmap_to_str ./libsepol/src/kernel_to_conf.c:1038:19
    #2 0x55e371 in write_level_rules_to_conf ./libsepol/src/kernel_to_conf.c:1106:11
    #3 0x55e371 in write_mls_rules_to_conf ./libsepol/src/kernel_to_conf.c:1140:7
    #4 0x55adb1 in sepol_kernel_policydb_to_conf ./libsepol/src/kernel_to_conf.c:3103:7
    #5 0x55a34f in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:38:9
    #6 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
    #7 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
    #8 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
    #9 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
    #10 0x7f741d0d67ec in __libc_start_main csu/../csu/libc-start.c:332:16
    #11 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index d4dfab5c..03ab4445 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -319,6 +319,27 @@ bad:
 	return -1;
 }
 
+static int validate_mls_level(mls_level_t *level, validate_t *sens, validate_t *cats)
+{
+	if (validate_value(level->sens, sens))
+		goto bad;
+	if (validate_ebitmap(&level->cat, cats))
+		goto bad;
+
+	return 0;
+
+	bad:
+	return -1;
+}
+
+static int validate_level_datum(__attribute__ ((unused)) hashtab_key_t k, hashtab_datum_t d, void *args)
+{
+	level_datum_t *level = d;
+	validate_t *flavors = args;
+
+	return validate_mls_level(level->level, &flavors[SYM_LEVELS], &flavors[SYM_CATS]);
+}
+
 static int validate_user_datum(sepol_handle_t *handle, user_datum_t *user, validate_t flavors[])
 {
 	if (validate_value(user->s.value, &flavors[SYM_USERS]))
@@ -399,6 +420,9 @@ static int validate_datum_array_entries(sepol_handle_t *handle, policydb_t *p, v
 	if (hashtab_map(p->p_users.table, validate_user_datum_wrapper, &margs))
 		goto bad;
 
+	if (p->mls && hashtab_map(p->p_levels.table, validate_level_datum, flavors))
+		goto bad;
+
 	return 0;
 
 bad:
-- 
2.34.1

