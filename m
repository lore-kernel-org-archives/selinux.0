Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F60C43217
	for <selinux@archiver.kernel.org>; Tue, 28 Sep 2021 15:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4549860F44
	for <selinux@archiver.kernel.org>; Tue, 28 Sep 2021 15:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241680AbhI1Ps7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Sep 2021 11:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241565AbhI1Ps6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Sep 2021 11:48:58 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29438C06161C
        for <selinux@vger.kernel.org>; Tue, 28 Sep 2021 08:47:19 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b26so36812384edt.0
        for <selinux@vger.kernel.org>; Tue, 28 Sep 2021 08:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BDGnpFOwaxgu4kjpNrN1FgZ1yXTRYcJnX/ad5ij8bQw=;
        b=Mmp4fOAsUCiI2/nFkltSYielvpPIoJEpFxlo20ya125/H+r5eYcd8mciJfDXtQQ3P0
         QciMsSqEHG6BUd0bLXMnUxDHfq4n4HvRcoHNZ1pr/69irkfFgb1d/3XDWGzwlhFNfb3Z
         z4o3pbxkpqKTFN0Cposii3+Jiq6cigxJ2mV+f/5VYTnRNr5ezHy25qA1YXM8In9HCMEz
         GUuWBHi7PUz8ClPXtOYAJJ7jZGxfV6Oon2GKcFzdE2l/xUy2C/H749JI4fjpJj2GooEX
         LvJaaTdGEFzd33mo1qpFIITlI5pElBN+Kw9gAUZZfDPVzK/PZmiAG0o7zeU3ItioiXS9
         P8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BDGnpFOwaxgu4kjpNrN1FgZ1yXTRYcJnX/ad5ij8bQw=;
        b=Nv3a13UJLNUCeBFak96vBuwTeHp6SB0pruZ93rsU3YcFBojID1BYaSTChykA2ZXE/9
         7ka34vKKTWeN5+P+bpGU7kdKXMWbc6RPWuhbxNGGHX8JxOmjxcZtvahWcSYwWp6javNB
         XN2RSwpdo/t4tm8OlPzQnOst+uWvVHnCZbtkL3NxxYt0sTnzyYP2ernayVLyjWxS82Vd
         /DtQyAJEkSbpGUn4/iKKvXYDwnRslOIO5i9IAIkxX1w9MqsIdbvKt9VRy3AD34Uw4RX8
         WWvoelPe8NtVS/zzx4iSRaF/nSBtXZgII3fAOoPaoPxWYSIEx7s01d0Qxe+GAENIAsFf
         WvKA==
X-Gm-Message-State: AOAM533X9akSk4X8GL6ukhPd1DW/ghv7S/y8b/BY7gM4xy1bEZ3SCLDp
        fI8Dv7NUf9xy5sOuBoxZz86qDz6rbi0=
X-Google-Smtp-Source: ABdhPJw4oLxEyW4N3Qgpj2BgeJdAV+F9IiCujxglC7XgIe2c9ZSwEXW8VfAnon5uRzIxzYq/Xyw5tw==
X-Received: by 2002:a17:906:3542:: with SMTP id s2mr7811373eja.379.1632843987459;
        Tue, 28 Sep 2021 08:46:27 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-152-081.95.112.pool.telefonica.de. [95.112.152.81])
        by smtp.gmail.com with ESMTPSA id l18sm13403834edw.78.2021.09.28.08.46.26
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 08:46:27 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 8/9] checkpolicy: drop incorrect cast
Date:   Tue, 28 Sep 2021 17:46:19 +0200
Message-Id: <20210928154620.11181-8-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928154620.11181-1-cgzones@googlemail.com>
References: <20210928154620.11181-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The function require_symbol takes the type hashtab_datum_t (alias void*)
as third argument. Do not cast to hashtab_datum_t* alias void**. Since
explicit casting to void* is unnecessary, drop the casts.

    module_compiler.c:1002:36: warning: cast from 'cond_bool_datum_t *' (aka 'struct cond_bool_datum *') to 'hashtab_datum_t *' (aka 'void **') increases required alignment from 4 to 8 [-Wcast-align]
                require_symbol(SYM_BOOLS, id, (hashtab_datum_t *) booldatum,
                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    module_compiler.c:1092:40: warning: cast from 'cat_datum_t *' (aka 'struct cat_datum *') to 'hashtab_datum_t *' (aka 'void **') increases required alignment from 4 to 8 [-Wcast-align]
            retval = require_symbol(SYM_CATS, id, (hashtab_datum_t *) cat,
                                                  ^~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/module_compiler.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index e8f15f4e..a1cf9fc4 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -999,7 +999,7 @@ static int require_bool_tunable(int pass, int is_tunable)
 	if (is_tunable)
 		booldatum->flags |= COND_BOOL_FLAGS_TUNABLE;
 	retval =
-	    require_symbol(SYM_BOOLS, id, (hashtab_datum_t *) booldatum,
+	    require_symbol(SYM_BOOLS, id, booldatum,
 			   &booldatum->s.value, &booldatum->s.value);
 	if (retval != 0) {
 		cond_destroy_bool(id, booldatum, NULL);
@@ -1051,7 +1051,7 @@ int require_sens(int pass)
 		return -1;
 	}
 	mls_level_init(level->level);
-	retval = require_symbol(SYM_LEVELS, id, (hashtab_datum_t *) level,
+	retval = require_symbol(SYM_LEVELS, id, level,
 				&level->level->sens, &level->level->sens);
 	if (retval != 0) {
 		free(id);
@@ -1089,7 +1089,7 @@ int require_cat(int pass)
 	}
 	cat_datum_init(cat);
 
-	retval = require_symbol(SYM_CATS, id, (hashtab_datum_t *) cat,
+	retval = require_symbol(SYM_CATS, id, cat,
 				&cat->s.value, &cat->s.value);
 	if (retval != 0) {
 		free(id);
-- 
2.33.0

