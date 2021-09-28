Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACEDC433EF
	for <selinux@archiver.kernel.org>; Tue, 28 Sep 2021 15:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE09160F44
	for <selinux@archiver.kernel.org>; Tue, 28 Sep 2021 15:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241688AbhI1PtO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Sep 2021 11:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241565AbhI1PtO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Sep 2021 11:49:14 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6654AC06161C
        for <selinux@vger.kernel.org>; Tue, 28 Sep 2021 08:47:34 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id dn26so8011319edb.13
        for <selinux@vger.kernel.org>; Tue, 28 Sep 2021 08:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lwPC9qd4TiWmTPTuMtvJNWeHF3d0/n+2LcIsyskvAaM=;
        b=Boykq6AelQwjFjTJlw++77P7d3EDeXSLnLr/UYAqeA5ozbfWSqbLmzSisur8PTORpn
         qmoX69fTD0ez1FCvXXZb4jFaH9ORcJZ3YqAZElBnI90M/T9Bbnc3wvwe+X6qN0BHWFPt
         ZFOv65UdxQ/dhRy7xlf/iihBWaCKRVHq9LrtTVZkhVAyE0QJWsMiOXS04o09qYDww0pp
         YtEef4eOuSYwfx+aFwjaqDhLW4mif+qtK7SGwXRrPganC2KX3uKi3VegQ8ZqVOpaiVBu
         UyWX4nanS5HDGlcRI3soYojpAsYM48DwOzF6PPDTvqEWU4ZlBLhxkTWAhWdlpPaKatkV
         2/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lwPC9qd4TiWmTPTuMtvJNWeHF3d0/n+2LcIsyskvAaM=;
        b=0pv1wPabPAZscX10Nc3PODQGlHf5C+4hDXAqrEbYWTBRpjLzr+1BwOr/+fpk4AdZjC
         SFU2BehOgDnh1IMyMhoFfmq3S55tIsxNaO1OLIY3+/lTZGXlG6UVMP0KN9KBzhx9TMZP
         mpGK7uObckgV3wFfZgBq3OlgJOCE5RGhEbNYx9pVJZVblzdmZxHR4Ql3QEHb3YW+3ja9
         agfXdeUTHMicy5//N8HcRPCkciWySneneUtRGAZJTPEBJ16jCa1eETx/YSYbDFFsM1VM
         RPV+A4YBmVNvTtDJjRO7V4y1AwZwawRqNeplaVGUcaCjBZLelGMTXBNBnuz7qxmOy2T7
         ZN8g==
X-Gm-Message-State: AOAM532npVZZC+zJlUfQLSi0JbhLpTlZ6gdQlpDktgyoHn3KZNw/5YH4
        JuGyP41jXnspkyA/lxASA4NMJhSvGOg=
X-Google-Smtp-Source: ABdhPJyueXmNwTHfXhzy7o4Vwm6PPLcfNeewhz94+KBgn1fHcdpgS6LuEHrRW4IO+n5IlL2jEltPMQ==
X-Received: by 2002:a17:906:dbc9:: with SMTP id yc9mr7627054ejb.439.1632843988032;
        Tue, 28 Sep 2021 08:46:28 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-152-081.95.112.pool.telefonica.de. [95.112.152.81])
        by smtp.gmail.com with ESMTPSA id l18sm13403834edw.78.2021.09.28.08.46.27
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 08:46:27 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 9/9] checkpolicy: delay down-cast to avoid align warning
Date:   Tue, 28 Sep 2021 17:46:20 +0200
Message-Id: <20210928154620.11181-9-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928154620.11181-1-cgzones@googlemail.com>
References: <20210928154620.11181-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Delay the down-cast from hashtab_datum_t, alias void*, to the actual
type once its kind has been determined.

    module_compiler.c:174:19: warning: cast from 'symtab_datum_t *' (aka 'struct symtab_datum *') to 'level_datum_t *' (aka 'struct level_datum *') increases required alignment from 4 to 8 [-Wcast-align]
                            *dest_value = ((level_datum_t *)s)->level->sens;
                                           ^~~~~~~~~~~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/module_compiler.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index a1cf9fc4..5f5b0b19 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -165,7 +165,7 @@ static int create_symbol(uint32_t symbol_type, hashtab_key_t key, hashtab_datum_
 			    decl->decl_id, dest_value);
 
 	if (ret == 1 && dest_value) {
-		symtab_datum_t *s =
+		hashtab_datum_t s =
 			hashtab_search(policydbp->symtab[symbol_type].table,
 				       key);
 		assert(s != NULL);
@@ -173,7 +173,7 @@ static int create_symbol(uint32_t symbol_type, hashtab_key_t key, hashtab_datum_
 		if (symbol_type == SYM_LEVELS) {
 			*dest_value = ((level_datum_t *)s)->level->sens;
 		} else {
-			*dest_value = s->value;
+			*dest_value = ((symtab_datum_t *)s)->value;
 		}
 	} else if (ret == -2) {
 		return -2;
-- 
2.33.0

