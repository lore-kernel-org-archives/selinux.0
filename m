Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75541C433EF
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EC9261108
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbhKEPss (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbhKEPsn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:43 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C819C06120B
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:46:03 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x15so3302643edv.1
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=D25LEwVKPJc1kp1Gs1pKnU188dh+IRlwvQBUij1KciU=;
        b=X+kKmtzbcq+1PAOE5FnzxVjf6NqUKQErp/HFW9Oub6uowVlXlEhEbMIl6HamTKciac
         ANXbCohilqe3vMMIaUTiHWoMG2sdVeNhfoxxzqx1UNipf+cafeNdecvhLT6HO9n1a1SB
         hzwZzNXisHzaXYQjKWZgTB+4qJvMZJOa8qnEQHM7kTXhzJNhs+tQ1wE+6YoTSM6N20ww
         f0jHjlLyEFz+HJF7DbcSDkr1J8GNEU/rofC7nFjknYt+GzqoQR/MmYjaubTppVwSLT5b
         QxMJEefKFZojn0IkCuSdv49gMPBZR4jrhbQb6mrbDWCdV1zt9BL5uRapqvVkQagxym2l
         OzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D25LEwVKPJc1kp1Gs1pKnU188dh+IRlwvQBUij1KciU=;
        b=hDbF6uHny5X/Ogxi5wMRYrb3copaXIO4CKkRjiAiJJ07FkVP183jvCtwZeuM5o+LFD
         /L5H1xs4XaNJisTaLfefk+Hpwo84g0aaNnqiGv4fuyGT3q4/nwunFNnjm4LuS8/aF0hl
         Ogn0LV8CYtfLkq0BoaypaM+1w4NDzKjhmiTo0o6G8wW5Uw8Bv8cu4ZojZ+K6JX/ithgI
         fXPdxiZPZRE4f3e7VUfBWKDe3cIRkwqpEamiNszRsilayGHYYnZIKPgMj5vp9I0uENX6
         kTG7fUi73t4aDXz0MNRWTdYZ8he3l9FtiSgfJUeShjE28bWUFLzHYd9uzVdA1tDEXqBJ
         wtCw==
X-Gm-Message-State: AOAM533nMnT2rBv576SCtYLJW7njKkTzAFG4u9LCJ7UXfMGw0aNz4PPe
        aWnFZCe4Uhe4Aq1mQUbqswTG/It1/sU=
X-Google-Smtp-Source: ABdhPJyQUEs7oFd577Bhftwbb3iwIduV0femxbtJV0NNs5hVqerL9d7lazBQZwbaqyR0BoTxuAaMgw==
X-Received: by 2002:a50:e0c3:: with SMTP id j3mr79058160edl.97.1636127162148;
        Fri, 05 Nov 2021 08:46:02 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.46.01
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:46:01 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 25/36] libsepol: validate permission count of classes
Date:   Fri,  5 Nov 2021 16:45:27 +0100
Message-Id: <20211105154542.38434-26-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105154542.38434-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
 <20211105154542.38434-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Check a common class or a class together with its common class parent
does not have more than the supported 32 permissions.

    ==28413==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000000 (pc 0x7f74ec3341a3 bp 0x7ffd0b7e5030 sp 0x7ffd0b7e47e8 T0)
    ==28413==The signal is caused by a READ memory access.
    ==28413==Hint: address points to the zero page.
        #0 0x7f74ec3341a3  string/../sysdeps/x86_64/multiarch/../strchr.S:32
        #1 0x4bfc78 in strchr (./out/binpolicy-fuzzer+0x4bfc78)
        #2 0x55b7f2 in class_constraint_rules_to_strs ./libsepol/src/kernel_to_conf.c:288:7
        #3 0x55b7f2 in constraint_rules_to_strs ./libsepol/src/kernel_to_conf.c:364:9
        #4 0x55ac80 in sepol_kernel_policydb_to_conf ./libsepol/src/kernel_to_conf.c:3071:7
        #5 0x55a34f in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:38:9
        #6 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
        #7 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
        #8 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
        #9 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
        #10 0x7f74ec2be7ec in __libc_start_main csu/../csu/libc-start.c:332:16
        #11 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

---
v2:
   also check common classes
---
 libsepol/src/policydb_validate.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index adaa3fb2..e8d70585 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -211,6 +211,8 @@ static int validate_class_datum(sepol_handle_t *handle, class_datum_t *class, va
 		goto bad;
 	if (validate_constraint_nodes(handle, class->validatetrans, flavors))
 		goto bad;
+	if (class->permissions.nprim > PERM_SYMTAB_SIZE)
+		goto bad;
 
 	return 0;
 
@@ -226,6 +228,25 @@ static int validate_class_datum_wrapper(__attribute__((unused)) hashtab_key_t k,
 	return validate_class_datum(margs->handle, d, margs->flavors);
 }
 
+static int validate_common_datum(sepol_handle_t *handle, common_datum_t *common)
+{
+	if (common->permissions.nprim > PERM_SYMTAB_SIZE)
+		goto bad;
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid common class datum");
+	return -1;
+}
+
+static int validate_common_datum_wrapper(__attribute__((unused)) hashtab_key_t k, hashtab_datum_t d, void *args)
+{
+	map_arg_t *margs = args;
+
+	return validate_common_datum(margs->handle, d);
+}
+
 static int validate_role_datum(sepol_handle_t *handle, role_datum_t *role, validate_t flavors[])
 {
 	if (validate_value(role->s.value, &flavors[SYM_ROLES]))
@@ -425,6 +446,9 @@ static int validate_datum_array_entries(sepol_handle_t *handle, policydb_t *p, v
 {
 	map_arg_t margs = { flavors, handle, p->mls };
 
+	if (hashtab_map(p->p_commons.table, validate_common_datum_wrapper, &margs))
+		goto bad;
+
 	if (hashtab_map(p->p_classes.table, validate_class_datum_wrapper, &margs))
 		goto bad;
 
-- 
2.33.1

