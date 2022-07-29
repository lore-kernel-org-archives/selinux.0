Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00FAC00144
	for <selinux@archiver.kernel.org>; Fri, 29 Jul 2022 12:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbiG2MCt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbiG2MCr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Jul 2022 08:02:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03E31863DF
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659096166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WoqBvJ1RPB6zJhzyX8rN5aJ0gmFYZk5hM2vNESXDqyg=;
        b=MiSdk+Cv9SIqIimQdUV95vCpDFqZkygj/k2vbzrYFqKxx1fLhV/RZevwCiydJjCLw/bQPI
        p/14tHlZ1HVDqyvBrlXyA22p1ruIUGs0JJhQtdfg/8hQMdui5iDdeBdkHuLZxO2hGyz3El
        v5btjbh0CzrXM/2ssWhNMeCAxXfrkQA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-6ytuL0o6NvSFoJr2WGf9fg-1; Fri, 29 Jul 2022 08:02:45 -0400
X-MC-Unique: 6ytuL0o6NvSFoJr2WGf9fg-1
Received: by mail-wr1-f72.google.com with SMTP id h9-20020adfa4c9000000b0021ee4a48ea7so1143570wrb.10
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=WoqBvJ1RPB6zJhzyX8rN5aJ0gmFYZk5hM2vNESXDqyg=;
        b=tx/ZTlOIMao7Bh4gaOBaCFC/UgUVwtOx7i993TAbmbybjiIw8R/CVUr3e6tC9X3RZn
         N+2R0247teeH6X4eGx4BolrqIN/4kmxKCzBVn4sCD7lOYo0b2O4KtUWrM+oa0g3DDLfm
         Qim62vRZzAcp+2vIaByAjCsZBZoLn1TqnEmLRV1kiYPTz0g2PIqW5gt0LfroUuhX8667
         CBEtif9cd6/UKSeBMWbd9qjbU6PTsmoI2WS10eYTO4kg9pqiBE/O9e+8s3HVxDmhIkHg
         TgURPJlrg7tDseAsl6hrdaweZGGCJFBHvd6lcHyazGjH5hyvy+qR/TgHm9bdIJmaqwJY
         /6hQ==
X-Gm-Message-State: AJIora/JSIf2j8nbPJ6+IP7Jnek1bgIA4QZfEzBuDFv5rVD9AFC7hJ5w
        v1oaPAmAuFWc19BxMb6ybShv/JrxlGugMCDqnT6yyNlyNUeUO/9IgaQcWBi4iG/qjQsTj4tGART
        qQT90WBIgElfP6ldVoKkv4RYAc2HOr5h6Cdi52+UwQfQbcacnTdk/6H4qMSeJEjAC78RuDw==
X-Received: by 2002:a05:600c:35c6:b0:3a3:4217:f06e with SMTP id r6-20020a05600c35c600b003a34217f06emr2490510wmq.95.1659096163150;
        Fri, 29 Jul 2022 05:02:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1thMrLIlslHcNLArcs98qFcAm/VFmURkYw/xQWhIHCfZqsTgAcY7jR6Gl/X52Ow0hvdvgYD0g==
X-Received: by 2002:a05:600c:35c6:b0:3a3:4217:f06e with SMTP id r6-20020a05600c35c600b003a34217f06emr2490492wmq.95.1659096162842;
        Fri, 29 Jul 2022 05:02:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c354300b003a2e92edeccsm9590622wmq.46.2022.07.29.05.02.41
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 05:02:41 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 06/24] test_policy.if: remove weird rule from testsuite_domain_type_minimal()
Date:   Fri, 29 Jul 2022 14:02:11 +0200
Message-Id: <20220729120229.207584-7-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729120229.207584-1-omosnace@redhat.com>
References: <20220729120229.207584-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The rule doesn't depend on the target domain, so it doesn't make sense
for it to be there.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_policy.if | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/policy/test_policy.if b/policy/test_policy.if
index 4912efd..f17a384 100644
--- a/policy/test_policy.if
+++ b/policy/test_policy.if
@@ -49,7 +49,7 @@ interface(`testsuite_domain_type',`
 
 interface(`testsuite_domain_type_minimal',`
 	gen_require(`
-		type setrans_var_run_t, syslogd_t, unconfined_t;
+		type setrans_var_run_t, unconfined_t;
 	')
 
 	testsuite_domain_type_common($1)
@@ -59,7 +59,6 @@ interface(`testsuite_domain_type_minimal',`
 	allow $1 proc_t:lnk_file { read };
 	allow $1 self:dir { search };
 	allow $1 self:file { open read write };
-	dontaudit init_t syslogd_t:fd use;
 	dontaudit $1 security_t:filesystem getattr;
 	dontaudit $1 self:file getattr;
 	dontaudit $1 setrans_var_run_t:dir search;
-- 
2.37.1

