Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01434C43219
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE09160EE5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhJKQ2m (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbhJKQ2j (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:39 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59509C061570
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:39 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id d3so42461794edp.3
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=U5rAOO5bnnml2hW62beszDghEdJvnAtLGC5HBonMbyw=;
        b=EkHU0zDr1pmxzKoTOhwZ2QF2RcFUbySMYwKguPmjh8KxLYvODNI/LTpix9t9p+9k7D
         dC85pBG2oCwN3h8sMsMX+SMKfqht9c0Z/FwdS//v62NJ0QOfqnqz6QdqKv8ZDwpBFgtX
         /SQWTMq3LtukP5TGEUnTYAjZCdfeBomR3PitsOlfsKVYvTbo7KMtKqawaiebKKvxeaVo
         nqvTjvLJ9tgN3Hb4LXMW9YplipZUOUglis622I4o3FbOGp86LLLWZ0L9JjRAQjupTRW2
         +f60U+7H2o55BMZo9pR3qEv+Ar+uuUX6mNNSLy1sbUpBN9ZcOEoZKLFZ5MZQqGcmaprD
         pT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U5rAOO5bnnml2hW62beszDghEdJvnAtLGC5HBonMbyw=;
        b=PONt6fSFDrVR+e+4xs+POsWuoPYiz2D3YjLA4k5mB2lBzD4ERAhW32uW/qAEmX3nTV
         ItjZrcvEnvfd3MlVsKlqzZm6gCXX6OwszKMAX7/au+Wyf1EvpevAFME7P+fk3uGoPkjl
         KuWgoRGXf28uyySu+Zh1dXCldTTY3MDedm5gj6lCsFE8vksJCdXngo5uz4j8hg+H+F2V
         sRvuOX8qVle2mh/3IXrzq1KBubZpX7s/DYxKk8OJ/giBOyXRLgMvisatNWOZlKolrw3T
         mC8MfyqBtenDLXEWeMl/bZElwHFpEkqdqkcP5HFjqK9+cAsuEqIYL/INDZ70hqiK+Rkb
         WYEA==
X-Gm-Message-State: AOAM532yBmT5vuUv3ONUvpgvxkCM5xiWv/Wjz9KeQhEuexbuhw6yCuNn
        TKHuF3SfJPQ/YK6QdZw1HD3wOdc4S4c=
X-Google-Smtp-Source: ABdhPJyp+4ctIq13tA8k7pu6TShXIh6128qR7zYWdvORDmMHf5YjRk3Imwy2/ynal27H5jDwImIrrw==
X-Received: by 2002:a05:6402:190f:: with SMTP id e15mr30257681edz.310.1633969597713;
        Mon, 11 Oct 2021 09:26:37 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.37
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:37 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 31/35] libsepol: validate policy properties
Date:   Mon, 11 Oct 2021 18:25:29 +0200
Message-Id: <20211011162533.53404-32-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 51 ++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index b1dacdad..860f9647 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -903,6 +903,54 @@ bad:
 	return -1;
 }
 
+static int validate_properties(sepol_handle_t *handle, policydb_t *p)
+{
+	switch (p->policy_type) {
+	case POLICY_KERN:
+		if (p->policyvers < POLICYDB_VERSION_MIN || p->policyvers > POLICYDB_VERSION_MAX)
+			goto bad;
+		break;
+	case POLICY_BASE:
+	case POLICY_MOD:
+		if (p->policyvers < MOD_POLICYDB_VERSION_MIN || p->policyvers > MOD_POLICYDB_VERSION_MAX)
+			goto bad;
+		break;
+	default:
+		goto bad;
+	}
+
+	switch (p->target_platform) {
+	case SEPOL_TARGET_SELINUX:
+	case SEPOL_TARGET_XEN:
+		break;
+	default:
+		goto bad;
+	}
+
+	switch (p->mls) {
+	case 0:
+	case 1:
+		break;
+	default:
+		goto bad;
+	}
+
+	switch (p->handle_unknown) {
+	case SEPOL_DENY_UNKNOWN:
+	case SEPOL_REJECT_UNKNOWN:
+	case SEPOL_ALLOW_UNKNOWN:
+		break;
+	default:
+		goto bad;
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid policy property");
+	return -1;
+}
+
 static void validate_array_destroy(validate_t flavors[])
 {
 	unsigned int i;
@@ -922,6 +970,9 @@ int validate_policydb(sepol_handle_t *handle, policydb_t *p)
 	if (validate_array_init(p, flavors))
 		goto bad;
 
+	if (validate_properties(handle, p))
+		goto bad;
+
 	if (p->policy_type == POLICY_KERN) {
 		if (validate_avtabs(handle, &p->te_avtab, flavors))
 			goto bad;
-- 
2.33.0

