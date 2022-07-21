Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3189CCA489
	for <selinux@archiver.kernel.org>; Thu, 21 Jul 2022 15:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiGUPFc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiGUPFa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Jul 2022 11:05:30 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B86211A2A
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 08:05:29 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id z23so3656864eju.8
        for <selinux@vger.kernel.org>; Thu, 21 Jul 2022 08:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Skx4w+WSZoUBe0VansEN520eMgtHIQeTD+HGsMbcmPM=;
        b=I3hMm40b7qYw/b+MS/i7raETkNVmNNhFg5sqFO6rTPiA1o1c7ijyhZYoOOXGvujJXJ
         mj4SZN0R3pow8L3ozfZAVSBzaY3lCv2zGG/CY65b9aFXu1cAGxsb3vNlfZXYY7rkEE1X
         HLBpXGSKTFPQuRxAs5inwfiOreTCDykr8ctOqeFF6f8yUPPT9zl8sR3FMbEg5+A4XpUg
         R2LkbkrMOVs54njHWWH174B1lmYfpyk6bqx+6OFBEc6eTeek9bVIk3CNPWX7kL9kYlp2
         +qCFUGLkUhGCfnZ/XUTIdr2lLfwSKTBGImWY+yVNw1oAADZVFDFaHD4CGog8ugbf5IDr
         9tHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Skx4w+WSZoUBe0VansEN520eMgtHIQeTD+HGsMbcmPM=;
        b=D3z60wNSFiiy0KHGC/Znp8ib9q1KcIUfZXSC66Xfx7Ql8aO0aMIYdvYZ6K4nv4S8Xz
         NTkQWawiAzvrH4uO99u7lD+PcZPZsW2vGTHuHnAvXYOC4K0u4tYzheGtdbuDcKnQJ5Vh
         VXvMJyXo0hx3r24bVtphaZ/1fJ3jobJ2oW34OqYKpycXRGclwXalWsMGRNVXMIQgH2+t
         hs4eP+oJuNMd6EtCerlNFMEqAQXxB84b0Sypy36Aa8YZKUwaeIkkdf/eVl/SLYRKlJ5J
         Lj/pFa0+1iPIWhDMqQcVQEnq88RZ86y7vnEWQQPHwS97ZGBI1EWBCqErISHtT+dpZpmZ
         0wAQ==
X-Gm-Message-State: AJIora8mj6GqdQCfzpyB46Um8Kdd279cv3YMu56pyRDdwbywfH19Ot/a
        W1UBdbmH1oMHdrr8S6HbnAnBfuezv6aqqQ==
X-Google-Smtp-Source: AGRyM1t+6ipkclUyI7Kaz3BeiwENzwKHZm18C5TG3REpxUaV1u8MUjaqGHJBA7ASYQUUtzte4htj4A==
X-Received: by 2002:a17:906:9b0a:b0:72b:4f33:b247 with SMTP id eo10-20020a1709069b0a00b0072b4f33b247mr41524141ejc.267.1658415927496;
        Thu, 21 Jul 2022 08:05:27 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-209-027.77.0.pool.telefonica.de. [77.0.209.27])
        by smtp.gmail.com with ESMTPSA id s7-20020aa7c547000000b0043a1255bc68sm1120992edr.94.2022.07.21.08.05.26
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 08:05:27 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 8/8] secilc: include segregate attributes in tests
Date:   Thu, 21 Jul 2022 17:05:15 +0200
Message-Id: <20220721150515.19843-8-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721150515.19843-1-cgzones@googlemail.com>
References: <20220721150515.19843-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 secilc/test/policy.cil | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/secilc/test/policy.cil b/secilc/test/policy.cil
index e6b78618..4e1d6b61 100644
--- a/secilc/test/policy.cil
+++ b/secilc/test/policy.cil
@@ -118,13 +118,16 @@
 	(typeattribute foo_type)
 	(typeattribute bar_type)
 	(typeattribute baz_type)
+	(typeattribute bad_type)
 	(typeattribute not_bad_type)
 	(typeattributeset exec_type (or bin_t kernel_t))
 	(typeattributeset foo_type (and exec_type kernel_t))
 	(typeattributeset bar_type (xor exec_type foo_type))
 	(typeattributeset baz_type (not bin_t))
 	(typeattributeset baz_type (and exec_type (and bar_type bin_t)))
+	(typeattributeset bad_type (bad_t))
 	(typeattributeset not_bad_type (not bad_t))
+	(segregateattributes (bad_type not_bad_type))
 	(typealias sbin_t)
 	(typealiasactual sbin_t bin_t)
 	(typepermissive device_t) 
-- 
2.36.1

