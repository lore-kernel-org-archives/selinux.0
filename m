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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AC7C48BCD
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 16:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE5E660FEA
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 16:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbhFHQCb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:02:31 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:43993 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbhFHQC3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Jun 2021 12:02:29 -0400
Received: by mail-ed1-f54.google.com with SMTP id s6so25101498edu.10
        for <selinux@vger.kernel.org>; Tue, 08 Jun 2021 09:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=H3YB1WMTihvMYXd4viLcaKhMEb0OVXEjSm6kuCa/G6w=;
        b=XWe9vLXqqo+/Kv0Xmp4p0RLwJmMddDHaBJxe9M1WpYl9dwoYH/H4LSSSvqi4nIuSyY
         ndK1fAL+OMg693hEAcsfOXTbH7gBx+3LFviVC8Fedu1blUrDXwgB5OCRojilU20NBCkx
         fpMZ51oSWozYCV0R12cblKrFGSIha1uHKfwkWEZHaceBCjS0W9SdZV0zJEKUkk4cpZYj
         zi3m12cV7TUdY6LLIBkysKi88c6eokip1r16exbxBDzW0GVYDdithi65taiVaApb5NGQ
         CPdJv+C4f2Symto1Ysv7GvzdJ9Ozh3ysShh5rCxPB0yhYmjFIBV5FNTg29gtm83dookl
         N6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H3YB1WMTihvMYXd4viLcaKhMEb0OVXEjSm6kuCa/G6w=;
        b=AGUQlhDgiCq1fmwI9RtnGYP6SOGoRUoKvmCACK0lK2v4W+qK8+u/gvRQ7kJAIEwqM+
         kpThGDddhrwhT/LQazVG34pR9KDIFy2sUwMmgXc1KSfveHeKqhqgo6E3t1BouSM2CRyW
         2LKTdty5On4Ieo8ZJVFEj1edifTj2iKZgVSbsS//k4pR5c80/at7oZDTyMqf6dJEsiB8
         H726vk7S5ne8d4Z9SudddhXm4tL2Ry+CXtMr5SQCnoHG4bsc/YFEWy/OhhURtvxm1NQV
         E4Wuqouv++/QusJkuQV6AsBdUdOv8PDS7UFFR/TSRI59tq8lZtugVPvdqjDpxn5yu7Ei
         rWiQ==
X-Gm-Message-State: AOAM531l1UL5FS+L6sVrV4K4LmDaj8hHRNRxIS6ByjCExmrwxtaWCu20
        WC7N3u3xSxXYjHvefoejWQ49sC47o0k=
X-Google-Smtp-Source: ABdhPJy0jzN2W6y71IEKyEVW1sF94GoA8S2SQZgpCz2HvJ+JfEL6kVXTMDZbHUGg1hBumqrEUbPq6A==
X-Received: by 2002:aa7:de8b:: with SMTP id j11mr26444793edv.363.1623167965485;
        Tue, 08 Jun 2021 08:59:25 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-183-231.95.112.pool.telefonica.de. [95.112.183.231])
        by smtp.gmail.com with ESMTPSA id n13sm51134ejk.97.2021.06.08.08.59.24
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:59:25 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 11/23] libsepol: mark read-only parameters of type_set_ interfaces const
Date:   Tue,  8 Jun 2021 17:59:00 +0200
Message-Id: <20210608155912.32047-12-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608155912.32047-1-cgzones@googlemail.com>
References: <20210608155912.32047-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Make it more obvious which parameters are read-only and not being
modified and allow callers to pass const pointers.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/include/sepol/policydb/policydb.h | 4 ++--
 libsepol/src/policydb.c                    | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index c29339dc..78699fb4 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -667,8 +667,8 @@ extern int scope_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p);
 extern void class_perm_node_init(class_perm_node_t * x);
 extern void type_set_init(type_set_t * x);
 extern void type_set_destroy(type_set_t * x);
-extern int type_set_cpy(type_set_t * dst, type_set_t * src);
-extern int type_set_or_eq(type_set_t * dst, type_set_t * other);
+extern int type_set_cpy(type_set_t * dst, const type_set_t * src);
+extern int type_set_or_eq(type_set_t * dst, const type_set_t * other);
 extern void role_set_init(role_set_t * x);
 extern void role_set_destroy(role_set_t * x);
 extern void avrule_init(avrule_t * x);
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 3389a943..7739b0fb 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1753,7 +1753,7 @@ int symtab_insert(policydb_t * pol, uint32_t sym,
 	return retval;
 }
 
-static int type_set_or(type_set_t * dst, type_set_t * a, type_set_t * b)
+static int type_set_or(type_set_t * dst, const type_set_t * a, const type_set_t * b)
 {
 	type_set_init(dst);
 
@@ -1770,7 +1770,7 @@ static int type_set_or(type_set_t * dst, type_set_t * a, type_set_t * b)
 	return 0;
 }
 
-int type_set_cpy(type_set_t * dst, type_set_t * src)
+int type_set_cpy(type_set_t * dst, const type_set_t * src)
 {
 	type_set_init(dst);
 
@@ -1783,7 +1783,7 @@ int type_set_cpy(type_set_t * dst, type_set_t * src)
 	return 0;
 }
 
-int type_set_or_eq(type_set_t * dst, type_set_t * other)
+int type_set_or_eq(type_set_t * dst, const type_set_t * other)
 {
 	int ret;
 	type_set_t tmp;
-- 
2.32.0

