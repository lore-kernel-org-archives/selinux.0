Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D9AC4332F
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238016AbhLIQz0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241348AbhLIQzY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:55:24 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFC9C0617A2
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:51:50 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id l25so21582970eda.11
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cy0/2nBeKRtpq+e+Xz7cRojPVmxThmn5kbfFGMc52Oo=;
        b=l7BjFFmwdckBake94FcEtNVgMVoLer/3YchewsaASXvui+QEjGx13ObHc5vbMrsqXe
         vasTW9cqsHSWrInHBeWoM8C2iYrX29h74UoIGE7XwHMHOZYPLvugN4UgYthCDUEmZEzl
         A6Vo/GKq+IwBArtXb1ZfbR26jWgRerHxae3Ztith2O4X+KqEJg5V4++faFkYJB6+uS7I
         nZQ7lXZSmA89+BwfJVeO0iZcs9pEWT+Jx4OZRtDK7HvXxCVC9x7mD9aXCPTyWXPcbTAk
         4o/azTeyUcBHhOCWZRMbubz1qGTa6ua1TooKl/OKCvYFEQjSfuGoAq1p9m/z+QSTTYvo
         yhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cy0/2nBeKRtpq+e+Xz7cRojPVmxThmn5kbfFGMc52Oo=;
        b=q5tRqX0agIql8GCm78ChvJFPcFKo+ym+XsRWVUsRYCtZgDY4ev0mjl6E37Tn8fGlUj
         b1l5vR0WGleyP/6FL978ghEdy9sx25IJu4s8L030L0Tn/+Nc759T47Vq3ckqcTGV56yQ
         vPz9kjHucSxXmxwOHkCNYFcMRcyvMUuVO0P+hYLUCk2mEYEJetV+/7bg6Qr4JOS1Co1Z
         bMd09kOSBHrORHZlxaesCMwHlIIHh0zal1L2YfgPX0oaYk6buWx6RnJP88vj96NCJjdu
         f2O6hlVftwz0m3qZRJ6e045xud/kX0PmuiE+Cp98hcsP5jAZ35ESZ0gSqauj4rPbfRPK
         xd5w==
X-Gm-Message-State: AOAM532VZtmgBY+neKpTXHcpklopaQ32K9otiN/l9Tj3KLd6w2hY8uBr
        1YRUbA28YZAUf+62b8OkiTFCgd7EwkM=
X-Google-Smtp-Source: ABdhPJyJuBOi+5soYiJQHf2UiSTIWAgNKyXupHdskUlJEKqGP8i2yjchNSqRkE6eNnsEFOnygxLJ0g==
X-Received: by 2002:a17:907:250f:: with SMTP id y15mr16646342ejl.0.1639068598344;
        Thu, 09 Dec 2021 08:49:58 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.57
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:57 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 33/36] libsepol: validate policy properties
Date:   Thu,  9 Dec 2021 17:49:25 +0100
Message-Id: <20211209164928.87459-34-cgzones@googlemail.com>
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

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 51 ++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index d9968a8e..fc0b26a3 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -978,6 +978,54 @@ bad:
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
@@ -997,6 +1045,9 @@ int validate_policydb(sepol_handle_t *handle, policydb_t *p)
 	if (validate_array_init(p, flavors))
 		goto bad;
 
+	if (validate_properties(handle, p))
+		goto bad;
+
 	if (p->policy_type == POLICY_KERN) {
 		if (validate_avtab(handle, &p->te_avtab, flavors))
 			goto bad;
-- 
2.34.1

