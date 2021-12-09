Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45809C433EF
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhLIQzG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbhLIQzF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:55:05 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02E2C061746
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:51:31 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x15so21956173edv.1
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yXtDVbCd19C8I0PGL2D3uhz4S2KAdu0Pi8emVL02UrA=;
        b=dtFxqSZ1pOakTXOgZlbO3awrdjlsiKeClG/cAXHkIRDw0/JN/no44kL5Kbg8v99Sgg
         diN/nyh4J4iZMK47lWLRL8eGUAQ90w+xENkTR5tLnlDA0HcLJjDn+BXk9rO/vk/qg5tg
         9jRi9/9MpyCLdSj9mWM4IZkleXpLNppWL55K8o8O8tJAnoyf8m06kaYtHCltnl7g2qo6
         7gRAHaxlVKC61fgQ+vbTMuTwQxHr3GmJnNlO0Ug5LXqpwp9wORajTsLuilMDmJmLNdqP
         j128SJsygrX9C7Et+Xdyw8QhoaesI3sIlQcRrl15jLUhWxuVmQJ9vZEzUfEa6Un6VLtP
         WRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yXtDVbCd19C8I0PGL2D3uhz4S2KAdu0Pi8emVL02UrA=;
        b=ZzmFGM9B6VqWYE5TFmO80fJ9HpEZ4/vpHEGYijad5AYDcrgzwKsj7jM8tK/mcrS2sc
         a4Qdyfrgrxt3bUSRfgQK+qpljpVyKpOWKCxR+6BEYfAx0OIyrzfMg0GZk9lRpquBp41O
         7Eja1gYt7NHnHvA22C4O2HTZZOavubk2BlciDqq4ompbyxK5XzlfPn8RnsYu8OrSwD/P
         oOw4rT4K/OGUxO0vmtoetqX8LFtzFcgI4ZVahpSDTkqnoWKIi2HFjlVG2FsUgKiaQ6y8
         ShEFdQ3NpquhJzboDwqd9CwgT2pgXHiVwzs+drmbneBWEkzVLwER0EZpG1uCe0iGRPlh
         8V/A==
X-Gm-Message-State: AOAM532p8Zzhq2ThXLrUYSXO6MAt/4/iqnnHgJohnORk6BhJmT75nFsY
        dq8SGlaEMFYsF0EBv2+y7c38gaMcQRw=
X-Google-Smtp-Source: ABdhPJwP1pGPiX+Di2RmT/LwC2madRtA6ng3jzqdC6BLvzDvpsh7JgpWnkTzGgBSTmHiOW86ve4PNA==
X-Received: by 2002:a05:6402:51c7:: with SMTP id r7mr31064029edd.359.1639068594971;
        Thu, 09 Dec 2021 08:49:54 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.54
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:54 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 29/36] libsepol: validate type of avtab type rules
Date:   Thu,  9 Dec 2021 17:49:21 +0100
Message-Id: <20211209164928.87459-30-cgzones@googlemail.com>
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

    ==80903==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x6020000005c0 at pc 0x0000005696c8 bp 0x7ffdb11ea560 sp 0x7ffdb11ea558
    READ of size 8 at 0x6020000005c0 thread T0
        #0 0x5696c7 in avtab_node_to_str ./libsepol/src/kernel_to_conf.c:1736:9
        #1 0x569013 in map_avtab_write_helper ./libsepol/src/kernel_to_conf.c:1767:10
        #2 0x5ab837 in avtab_map ./libsepol/src/avtab.c:347:10
        #3 0x561f9a in write_avtab_flavor_to_conf ./libsepol/src/kernel_to_conf.c:1798:7
        #4 0x561f9a in write_avtab_to_conf ./libsepol/src/kernel_to_conf.c:1819:8
        #5 0x55afba in sepol_kernel_policydb_to_conf ./libsepol/src/kernel_to_conf.c:3159:7
        #6 0x55a34f in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:38:9
        #7 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
        #8 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
        #9 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
        #10 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
        #11 0x7f97a83fd7ec in __libc_start_main csu/../csu/libc-start.c:332:16
        #12 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 25c6f0db..57eb2550 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -547,15 +547,22 @@ bad:
 	return -1;
 }
 
-static int validate_avtab_key_wrapper(avtab_key_t *k,  __attribute__ ((unused)) avtab_datum_t *d, void *args)
+static int validate_avtab_key_and_datum(avtab_key_t *k, avtab_datum_t *d, void *args)
 {
 	validate_t *flavors = (validate_t *)args;
-	return validate_avtab_key(k, flavors);
+
+	if (validate_avtab_key(k, flavors))
+		return -1;
+
+	if ((k->specified & AVTAB_TYPE) && validate_value(d->data, &flavors[SYM_TYPES]))
+		return -1;
+
+	return 0;
 }
 
 static int validate_avtab(sepol_handle_t *handle, avtab_t *avtab, validate_t flavors[])
 {
-	if (avtab_map(avtab, validate_avtab_key_wrapper, flavors)) {
+	if (avtab_map(avtab, validate_avtab_key_and_datum, flavors)) {
 		ERR(handle, "Invalid avtab");
 		return -1;
 	}
-- 
2.34.1

