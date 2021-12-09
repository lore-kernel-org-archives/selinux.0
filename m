Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45202C433EF
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbhLIQzc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236251AbhLIQzb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:55:31 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246F6C061746
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:51:58 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v1so21773432edx.2
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qF+PXOArti3/R9BFZl1GJ1Iv00XxiVMZEQ0NfUGglSI=;
        b=KpzwI12tiYNHdbZKfEsnA454OcgxAnbd/cmQHS1ORBTebS/0I0IlCBi1Gjm9vhGTAZ
         zIaRaHtWEsRetlCgwsL259MDgnMRnXCcox8/cZqUPfwEBM4GZRozNher7tlsR728h9Qm
         4qMqnYErkSqOiw9Kp+UEoScwWHiH++ydnxEQHvm+QWesRRwvp/QTC57O4/ajaMsZzAvS
         IJEv7FbqU+ejdn1wnw1EArc0ZqtHmaa05r5ItoIcNJhieTnBSGpR8ZdnSyXLtWbMwCYg
         DoTbYQjHdg59cZt02OmGLzjM8Ee8lnHrQ6XW9/giqavaJpB4/06TJpZTFOTxJO/8ocS9
         0dKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qF+PXOArti3/R9BFZl1GJ1Iv00XxiVMZEQ0NfUGglSI=;
        b=ZqgEJIrKwjk25GrvRVmrpefqHeum1onxEj3H/iJmuT76YHnSvZAZ5Lsd3cX9TmScjy
         zV8yTT1oXj766v2PO56BL8o4GT+ggJ8Y94z6ZMTjXKmzZSmTcER9bIwCfuY3kiegJdpW
         0Iy3neN7YTq6j3mtuVF4hPq4KbU56cvObwNBM5lKLFcTm057+OHTHD5Va9IR47e+sjcq
         xiEVjfHJQcAFYWPlI7Hxo0k3JUDi56SVmvOgOarWD0N2AEBq7X2cIRIU9KYyL7oX1Vxn
         sx0ef92oIJTEk/tdWxc77+NgqMptR9wYXqo1OET7UzzMNgkULcfCiXFAwWQwSzynulDh
         jPDg==
X-Gm-Message-State: AOAM530USc3T4eMsG/eQ5QJxQ9wGMzvw8ZRXKf0P15i8ZHgGh30fqfoJ
        7x7q3c6EB9OYlojPRtsAcNE8m2uB1t0=
X-Google-Smtp-Source: ABdhPJwlPYc0pAm2lsX/7CXAiIqhlzmqIiZslhfzKSjuo70LHZ9hLHeW9m7Bjy3IUGHm3dR3kQT8Qw==
X-Received: by 2002:a17:906:730f:: with SMTP id di15mr16975886ejc.22.1639068598998;
        Thu, 09 Dec 2021 08:49:58 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.58
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:58 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 34/36] libsepol: validate categories
Date:   Thu,  9 Dec 2021 17:49:26 +0100
Message-Id: <20211209164928.87459-35-cgzones@googlemail.com>
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

Check all categories have valid values, especially important for
aliases.

        ==7888==ERROR: AddressSanitizer: SEGV on unknown address 0x602000400710 (pc 0x00000055debc bp 0x7ffe0ff2a9d0 sp 0x7ffe0ff2a8e0 T0)
        ==7888==The signal is caused by a READ memory access.
        #0 0x55debc in write_category_rules_to_conf ./libsepol/src/kernel_to_conf.c:946:9
        #1 0x55debc in write_mls_rules_to_conf ./libsepol/src/kernel_to_conf.c:1137:7
        #2 0x55adb1 in sepol_kernel_policydb_to_conf ./libsepol/src/kernel_to_conf.c:3106:7
        #3 0x55a34f in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:37:9
        #4 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
        #5 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
        #6 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
        #7 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
        #8 0x7fe80ccaf7ec in __libc_start_main csu/../csu/libc-start.c:332:16
        #9 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index fc0b26a3..2f30a3ad 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -485,6 +485,14 @@ bad:
 	return -1;
 }
 
+static int validate_datum(__attribute__ ((unused))hashtab_key_t k, hashtab_datum_t d, void *args)
+{
+	symtab_datum_t *s = d;
+	uint32_t *nprim = (uint32_t *)args;
+
+	return !value_isvalid(s->value, *nprim);
+}
+
 static int validate_datum_array_entries(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
 {
 	map_arg_t margs = { flavors, handle, p->mls };
@@ -507,6 +515,9 @@ static int validate_datum_array_entries(sepol_handle_t *handle, policydb_t *p, v
 	if (p->mls && hashtab_map(p->p_levels.table, validate_level_datum, flavors))
 		goto bad;
 
+	if (hashtab_map(p->p_cats.table, validate_datum, &flavors[SYM_CATS]))
+		goto bad;
+
 	return 0;
 
 bad:
@@ -905,14 +916,6 @@ bad:
 	return -1;
 }
 
-static int validate_datum(__attribute__ ((unused))hashtab_key_t k, hashtab_datum_t d, void *args)
-{
-	symtab_datum_t *s = d;
-	uint32_t *nprim = (uint32_t *)args;
-
-	return !value_isvalid(s->value, *nprim);
-}
-
 static int validate_symtabs(sepol_handle_t *handle, symtab_t symtabs[], validate_t flavors[])
 {
 	unsigned int i;
-- 
2.34.1

