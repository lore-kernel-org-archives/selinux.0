Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECD3C4743E
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 16:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC050610A2
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 16:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhFHQCi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:02:38 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:45604 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbhFHQCi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Jun 2021 12:02:38 -0400
Received: by mail-ej1-f43.google.com with SMTP id k7so33378654ejv.12
        for <selinux@vger.kernel.org>; Tue, 08 Jun 2021 09:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uD6bk0/nI/HRTwKq9nevppFxCTn5qcRA6NT6yLc3prk=;
        b=BQRLV7uD1FJI7CTgdUqLIj2wBgJWuESElzR+myaOJYCTdBV/RTDWi4U70Wd8Eq57Lo
         AdUmj52kH5RTgdka79GwC1aufom4egYuWMDE8yWcnIbPA46rhEK6M5O1ZKE8c+Ofzmn1
         mGu2pQX8Tg0wCMWZrGFeO/ZZoq6rw2rSk4GZAzzZt9WuEgWRpE7l99C3pmSHfZ3mtKUt
         8fCrDA5PA6FWenb4ilcuRD0MRrUZYiMiLkEL6TIWiA6ygP0Zpm7ERKHOiFctkqm99YHF
         kw/qfmvdtGU4WpJbe7KWvhpmbQv2dAeKGBEciIkyWE53i1b0GnIRE98dkUPZxmf28/zp
         oshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uD6bk0/nI/HRTwKq9nevppFxCTn5qcRA6NT6yLc3prk=;
        b=VTb9exXUwE4jlcXwygjRJpkkVSHp2iuj4Iqsvyn+vDKvGlK7XY7rYx/yTI/GRhx5fW
         o26e8h2Um/dtKWj1GaYkE4z3kFtWrBvy4uDUM2ApbrSS2wym1jqZF9NkFSj+Rp65N1oF
         j81SrO7WADe75DIP0uidSla9E9A1YpokGymC0Hpf27L9jY1OVM+wcGp1GmVqj18mTd7/
         0nCOWpgv5oymmbENnNskYIlYuKtDmKfDlTyu9X8OvYqJ8u8DZjKlFzd5FK3oD0wmD6mn
         NWkt9SxExF4WPsYvizjAVaDSPvTVt4wjLgMqXX0bWSC8cQpnE/yzz0M1atoOsvUQDXJW
         t4wA==
X-Gm-Message-State: AOAM5313HNVBHtPVl/4a3hIsnMPwkpA7TEnXIdrOS1y83Q4MinO+tFJF
        w/wbDJvregHkwEv7wk5msFKJO83qutQ=
X-Google-Smtp-Source: ABdhPJwSj1MLJgYfylZe3LQUWu/A628uoVhlgfn3l7iGkXq/a6McHKYOtPp9ooSMIHOdLiGTIzXAbQ==
X-Received: by 2002:a17:906:7b4f:: with SMTP id n15mr23639989ejo.220.1623167970983;
        Tue, 08 Jun 2021 08:59:30 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-183-231.95.112.pool.telefonica.de. [95.112.183.231])
        by smtp.gmail.com with ESMTPSA id n13sm51134ejk.97.2021.06.08.08.59.30
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:59:30 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 21/23] libsepol: drop unnecessary casts
Date:   Tue,  8 Jun 2021 17:59:10 +0200
Message-Id: <20210608155912.32047-22-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608155912.32047-1-cgzones@googlemail.com>
References: <20210608155912.32047-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

`hashtab_search()` does take `const_hashtab_key_t` as second parameter,
which is a typedef for `const char *`.
Drop the unnecessary and const-violating cast.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/services.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index f7c31d80..47a3dc14 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -1182,7 +1182,7 @@ int sepol_string_to_security_class(const char *class_name,
 	class_datum_t *tclass_datum;
 
 	tclass_datum = hashtab_search(policydb->p_classes.table,
-				      (hashtab_key_t) class_name);
+				      class_name);
 	if (!tclass_datum) {
 		ERR(NULL, "unrecognized class %s", class_name);
 		return STATUS_ERR;
@@ -1211,7 +1211,7 @@ int sepol_string_to_av_perm(sepol_security_class_t tclass,
 	/* Check for unique perms then the common ones (if any) */
 	perm_datum = (perm_datum_t *)
 			hashtab_search(tclass_datum->permissions.table,
-			(hashtab_key_t)perm_name);
+			perm_name);
 	if (perm_datum != NULL) {
 		*av = 0x1 << (perm_datum->s.value - 1);
 		return STATUS_SUCCESS;
@@ -1222,7 +1222,7 @@ int sepol_string_to_av_perm(sepol_security_class_t tclass,
 
 	perm_datum = (perm_datum_t *)
 			hashtab_search(tclass_datum->comdatum->permissions.table,
-			(hashtab_key_t)perm_name);
+			perm_name);
 
 	if (perm_datum != NULL) {
 		*av = 0x1 << (perm_datum->s.value - 1);
-- 
2.32.0

