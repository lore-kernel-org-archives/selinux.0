Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E15C4167B
	for <selinux@archiver.kernel.org>; Thu,  9 Nov 2023 13:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjKINvc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Nov 2023 08:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjKINvc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Nov 2023 08:51:32 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639D72702
        for <selinux@vger.kernel.org>; Thu,  9 Nov 2023 05:51:29 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9dd6dc9c00cso148102966b.3
        for <selinux@vger.kernel.org>; Thu, 09 Nov 2023 05:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1699537887; x=1700142687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bm45oeM6k4PguQzjWqSeyghD0z8zmKPrFsjAQdnirU=;
        b=Gnlx6oUHhRJLBOjC+ccwqdYnA2oyqZUz/3xxh1rb9S6U/jWFmYzEYGRAXpy3m8B/CW
         WdAoszwtWUrCov2CLgGpibF2AkAPO2woi6DShwIqxBdh1orIBpL543UfN0tLWBu2OJWz
         F9aIMeS543H7WgexGr+5Tp/q6mY7E736p7h+/oWWAJaicyx+uH5nqTuLo3E/OPQY5SIh
         3oA55oL6m1PEVMWNM7cO0b13AEWh8uxv+LvAeYD/V537J8+O6bSnqOPxUVd8BsHkCl1Q
         yfcbSoFuOeTRvknlbOmUddIab+TGmkavBjHtLUPoSUXUpVN7iFeFOqR2ujpCRdWOJikK
         KWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699537887; x=1700142687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bm45oeM6k4PguQzjWqSeyghD0z8zmKPrFsjAQdnirU=;
        b=MtR/cZ6i8VgyzXJcTKm9fRJMjrlUgBcnhL7cL9rLLKRcjD8CY2XfbvP+GPy8rnEa0z
         9bfpgMZJRWCG37R0fD+Wftpu+6zDv8Xv9KGn+HUkonuipNQpkZYOZIvW1Kr+oI/iazq6
         P2WHOgATvRjVPk06Ft8ivLXhJS/J1JdB1ZPHZk+ERyZ339KX55VhvVtBLumR1VGCkUZd
         IMuNEiiSYdBkIMt32/+UTFlPoAYHyj2gsBO6RWNhLHlI3d2nDGQV2mGRzAZxpSdJSg98
         8XoDJppE3840Vvk6tprQCr6TvNBzmybRYa45K5miVnZ9eCw9WGJeE1XqZsyBo6Pojeiv
         gfsw==
X-Gm-Message-State: AOJu0YyuqKIUOFHJAFPTIeBTNq+/z+mN2rG5Fuxek7ksuNTMNQ7FBm5S
        4+YY0lSCFC0L/qawIeHN/SYhsDWHjc8=
X-Google-Smtp-Source: AGHT+IFLPk/kxNFhoDSeBQ3Au6TsQo16VPLzYgHR82kRUwbAIbaDjDgPdMX7Xtw7ZDui2qWtjXBuCg==
X-Received: by 2002:a17:907:8d87:b0:9e3:f99a:3061 with SMTP id tf7-20020a1709078d8700b009e3f99a3061mr3475489ejc.44.1699537887336;
        Thu, 09 Nov 2023 05:51:27 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-000-043-071.77.0.pool.telefonica.de. [77.0.43.71])
        by smtp.gmail.com with ESMTPSA id b4-20020a170906038400b0099bc8bd9066sm2581530eja.150.2023.11.09.05.51.26
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:51:27 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 2/4] libsepol: adjust type for saturation check
Date:   Thu,  9 Nov 2023 14:51:19 +0100
Message-ID: <20231109135121.42380-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231109135121.42380-1-cgzones@googlemail.com>
References: <20231109135121.42380-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the type for the number of primary names in a symtab to uint32_t,
which conforms to the bytes read and the type used in the symtab.
The type is important for the saturation check via is_saturated(), since
it checks against -1 casted to the specific type.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  Split from subsequent patch
---
 libsepol/src/policydb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index f608aba4..bc7bc9dc 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -4120,8 +4120,8 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 {
 
 	unsigned int i, j, r_policyvers;
-	uint32_t buf[5];
-	size_t len, nprim, nel;
+	uint32_t buf[5], nprim;
+	size_t len, nel;
 	char *policydb_str;
 	const struct policydb_compat_info *info;
 	unsigned int policy_type, bufindex;
-- 
2.42.0

