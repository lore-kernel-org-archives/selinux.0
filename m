Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C59C77B76
	for <selinux@archiver.kernel.org>; Thu, 20 Apr 2023 15:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbjDTPF5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Apr 2023 11:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjDTPF4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Apr 2023 11:05:56 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3644EEC
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:05:54 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dx24so6994032ejb.11
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682003153; x=1684595153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iEIzYI2DzFkL7r+Yzqs6NW5tgIgkJmurMydT/G55GYc=;
        b=mDmBnAl+YHFj32Xnfd6fh7HEjG6nWd9BWBooCNWsBNgSUJumOUFZIrNcElQ9Ah8zxf
         mg4ODHZh0ojUIZSyUGY371dLSfdF4g04c+0E92kh/Cwknls9s2jQgMSUcB9r0jMuVTAR
         eqy0oIfpM0eodpoKWsJVusNqK/IA5l8UJV9JaBeKZgX+ocEbQpdbyxkFA2QqvqPaPQT7
         ivW2++vVfOUIoWE9Gux8PMcMOI1IZYAqkoscG14QWwApvGKDdP/TYZMAx/4Y3xbBwo1S
         LiNn5upxdd9I2wkKEI2pEBxEpULNjzmEGQ3U5zfprmLAnsfNACnEPHRVtyHoj8hh54CO
         QTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682003153; x=1684595153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEIzYI2DzFkL7r+Yzqs6NW5tgIgkJmurMydT/G55GYc=;
        b=N+ASc/OWINnMVa43QwDqeO9Oe8SLb/5C+AA+xw+67RhZwqczD6hlBR9YFuSwWtwY4h
         Pi+7SsM6j6wVlyytKB3qMVL2K8cZi4IkZMHdNgsAmC6nwzAe13DJ7IMlBD2nCUovnQaf
         aTevBkt/DXRsrmJULSazR5erTs6e6xdHzvgLpgTr2ptBVC+0YzKTsOtcNdK9F1rAbFL7
         hYulW2OJRG7ZQqZjCCoGw0HjQXp+bva3lXLdGrjmkIQGmtBIPrhABsKex2PukSBxglbe
         XR9FLr0PemCAAH8dLxjsZ+Wf45pN5obm+PpF8/9GEE1U2Q+Vce8PCf0bhKH75Qv1NP2D
         tttg==
X-Gm-Message-State: AAQBX9cWvH2f3c0vACVF6HiN0njXdjx005RLTXSxMJxVbF3S7jHfBCqy
        nJsLQUzdCrk7jnbIE2s81nrttPb50xA=
X-Google-Smtp-Source: AKy350Z1VQp7oWhFKsLfQtu1HzLbYAQja8brBagP8NpxrVnBK42HXMo4e9YO7eVeehJKh2kVCE4MhQ==
X-Received: by 2002:a17:907:96a1:b0:94a:937a:58f1 with SMTP id hd33-20020a17090796a100b0094a937a58f1mr2652641ejc.1.1682003152725;
        Thu, 20 Apr 2023 08:05:52 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-119-201-251.95.119.pool.telefonica.de. [95.119.201.251])
        by smtp.gmail.com with ESMTPSA id jo2-20020a170906f6c200b009538cc79241sm827430ejb.56.2023.04.20.08.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 08:05:52 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Subject: [PATCH 5/6] selinux: retain const qualifier on string literal in avtab_hash_eval()
Date:   Thu, 20 Apr 2023 17:05:02 +0200
Message-Id: <20230420150503.22227-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230420150503.22227-1-cgzones@googlemail.com>
References: <20230420150503.22227-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The second parameter `tag` of avtab_hash_eval() is only used for
printing.
In policydb_index() it is called with a string literal:

    avtab_hash_eval(&p->te_avtab, "rules");

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/avtab.c | 2 +-
 security/selinux/ss/avtab.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 8480ec6c6e75..6766edc0fe68 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -354,7 +354,7 @@ int avtab_alloc_dup(struct avtab *new, const struct avtab *orig)
 	return avtab_alloc_common(new, orig->nslot);
 }
 
-void avtab_hash_eval(struct avtab *h, char *tag)
+void avtab_hash_eval(struct avtab *h, const char *tag)
 {
 	int i, chain_len, slots_used, max_chain_len;
 	unsigned long long chain2_len_sum;
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index d3ebea8d146f..d6742fd9c560 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -92,7 +92,7 @@ int avtab_alloc(struct avtab *, u32);
 int avtab_alloc_dup(struct avtab *new, const struct avtab *orig);
 struct avtab_datum *avtab_search(struct avtab *h, const struct avtab_key *k);
 void avtab_destroy(struct avtab *h);
-void avtab_hash_eval(struct avtab *h, char *tag);
+void avtab_hash_eval(struct avtab *h, const char *tag);
 
 struct policydb;
 int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
-- 
2.40.0

