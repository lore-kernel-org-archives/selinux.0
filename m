Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1F5C43219
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E7561108
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbhKEPsy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhKEPss (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:48 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4B9C061205
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:46:07 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id c8so17815250ede.13
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2YWtbflnxQp3ilDmPryEy4at+biC5YAKzIeHSD6+JUo=;
        b=JXT3iCsqfJumYhTDHjYFUPk3QtVcmmcbRCVTh32EPeageWianc0nI6RNjrTQ/cOFv2
         f7VOxRRhyeT0GATCm2t4/d/7HCDomsXsPRiOOJoNnb6itmANAgXTCfrUhlPjWSFmkNZS
         AVg0Gf0ryeviFdJqoyHb5+uZ34W5YqeYnPgGjta5MnoUx9Hh+RDokBgFwqJy1cD7hURi
         cdrOf4EAvtS0wxwHvsdh7zH1HqzDBcbhbs9D6us8ijmGt1S+XdRz68yRcH1Jk5MAPcsk
         WzLyz67AAgDUCqVE1B8gHuaweAhmkhDdDfpx/MR7H29F54RSyIipZcaARFu7KetEVxsU
         Fuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2YWtbflnxQp3ilDmPryEy4at+biC5YAKzIeHSD6+JUo=;
        b=ETo9dnIjmYgJysZfh82zpyrDQ0JZwPv6mA34hMljWvaPoM/mm7Td15dSTkMS4wHlfb
         0Uv4G6qgT9/h4+HPRHeXsMXRpI2oqnLqOdENc1QPJRrdtqx+Zm4isLe+7uTCeqN0wofU
         6G/K4SMeCIRTMLsuXn18BqsBMYR8sxGxETRjkIaw9Qlwut0qjfO07W16DNU87Jy93vzk
         L82EXzveEZLPdhFsPHpQY2cJJDyJwQLG0N1LMOF98CyHsrCLOHPDTdo33PiS+WzLZARl
         7gsXSy73rYJ015ZpQG3pWGpMhIHCXzhV5FYThW3dsRCRJyabgZ3q1iBSfBvSV+/4KB81
         t1Sw==
X-Gm-Message-State: AOAM53078X9LX/Ev8EkGZum64iXLFTb2NFSosI8/yXX9LFXTUdiub4JE
        rDh/NLoeaJFHqPi0PauXUUGKMss02bc=
X-Google-Smtp-Source: ABdhPJzgJ3GX7sR6tkmmOKrjxYTwGFy4I4sR725v5J74zOyc+lLJQxUmSKAP18iV1Yz5jx+RFZLVHQ==
X-Received: by 2002:a17:907:6d07:: with SMTP id sa7mr55759213ejc.339.1636127166065;
        Fri, 05 Nov 2021 08:46:06 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.46.05
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:46:05 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 32/36] libsepol: validate permissive types
Date:   Fri,  5 Nov 2021 16:45:34 +0100
Message-Id: <20211105154542.38434-33-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105154542.38434-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
 <20211105154542.38434-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 5cec143f..ffa21ee1 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -959,6 +959,23 @@ bad:
 	return -1;
 }
 
+static int validate_permissives(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
+{
+	ebitmap_node_t *node;
+	unsigned i;
+
+	ebitmap_for_each_positive_bit(&p->permissive_map, node, i) {
+		if (validate_value(i, &flavors[SYM_TYPES]))
+			goto bad;
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid permissive type");
+	return -1;
+}
+
 static void validate_array_destroy(validate_t flavors[])
 {
 	unsigned int i;
@@ -1011,6 +1028,9 @@ int validate_policydb(sepol_handle_t *handle, policydb_t *p)
 	if (validate_datum_array_entries(handle, p, flavors))
 		goto bad;
 
+	if (validate_permissives(handle, p, flavors))
+		goto bad;
+
 	validate_array_destroy(flavors);
 
 	return 0;
-- 
2.33.1

