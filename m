Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CEFC433FE
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241040AbhLIQ4a (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbhLIQ4a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:56:30 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B998C061746
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:52:56 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id t5so21315564edd.0
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6eEqNBM4THfrqU7fNMU6dA9I0JYV2jz3wPbNqTqfqcE=;
        b=F7mYU/TQuG6hkcuMu3Cy5PPakrL3Fpd8YpLn1rgWeKzmkrpcxuUjLBSJbEztJTYRiW
         Tjac6yR/5MPUU0p3JAFS4K/gqmjL0HmYfeLUZWGPaB/BDxDs9700JzXL/o3mBQevKY0/
         LFk/55kBvEe31fNCrGoQD5zXjEQlXO6LZfr/VK1K3HQyeWXIynuSuTzyeetARAuIZiDz
         mtQoTFf54m3Qe2ZFhsR599X63aidaEib55Zj7h/szxUe78fi60KWxUhyA436kS4qaW0B
         yK/LjRoRtXZZzeHY4vXB47M94kT0grHRJFXU4JhMpSCsyqk60hpMnqp3/Pz0yskQmor5
         6YsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6eEqNBM4THfrqU7fNMU6dA9I0JYV2jz3wPbNqTqfqcE=;
        b=JscDh6UIH3aEr33a63AAb+NBqAWMI7h0Dbtru1pdnW2dpxK6nISMDowsNLHwvVV/aZ
         QWnNj9hrwGdzQTvjSrB/Y3AqVHwLIPJY0lNJx9l1KXmQE+1aD1+cW8JNx0Tt4eTaY5iw
         aP+EMMxnH15COKVmFR1Gsb27N2XX31/WqO1LwR6q70mgXIDCPb8sYDIcYzBqPjvqS5Lk
         kUDhV/2ZzKzuEeUAbE+u3KadHzyW4aCvdYNE+y6S2GbYbBDI9gwCpU8WpBWRds+f2+Pt
         l4vcI1ghd61zwtLxx0wj/UpzMSOT3G5xISTzg2ubrYeK+47z8Qn/SV2wMIi9NkkbxwaR
         b+DA==
X-Gm-Message-State: AOAM533EhLwyyrqcffHkkLwlMmCxyfis1giZGSFdsP/1cEaoPCYQkLYn
        kc9V0AKOhnLFVdwg5b0QyQswxm7B5SE=
X-Google-Smtp-Source: ABdhPJwCy3n3mfOJNtl04KaesQfeIQx14WBWuEf5IeLMMdUiUEOkzByF6ezwT2x6SVYnYPW2SEhX2g==
X-Received: by 2002:a05:6402:350e:: with SMTP id b14mr31460255edd.313.1639068592144;
        Thu, 09 Dec 2021 08:49:52 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.51
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:51 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 25/36] libsepol: validate permission count of classes
Date:   Thu,  9 Dec 2021 17:49:17 +0100
Message-Id: <20211209164928.87459-26-cgzones@googlemail.com>
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
2.34.1

