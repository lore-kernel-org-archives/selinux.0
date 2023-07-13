Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA787C001B0
	for <selinux@archiver.kernel.org>; Thu, 13 Jul 2023 18:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjGMSIb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Jul 2023 14:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjGMSIa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Jul 2023 14:08:30 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C281BFB
        for <selinux@vger.kernel.org>; Thu, 13 Jul 2023 11:08:29 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9926623e367so144768266b.0
        for <selinux@vger.kernel.org>; Thu, 13 Jul 2023 11:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1689271707; x=1691863707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qf+ep2AGieWfF/6F4u3rk63REkDECe/z7Ykuugp3gNM=;
        b=mtxj0XOsU38fcn3YrvDPDLlqiy755guqcUY6WQWhM1Mxp6MLrqBy2QsItvc4ozMBVg
         n+10Jqycub7UJ6IeUYNr7GncO2PguDl1KaBCodyEZSZw/Rc135DLXz/kaXopgFLD9VRC
         tmbfZJQ52+x9hWCBjpEIhPLlp7AEflUgd36pYg3xiL9v01YWfux1efDYCYSKVhnlHRNu
         bcBsN6ZlPBteM4ycptiR71v23XjlYcubH2fBnFvneQxQPwW71LMEHhDY/UOpQMNosY/A
         mH9CBZo5mUfokCjD9zxklRL2F+GfCq5ZpMcP+Zxc+Sdp/l/+uie10Sf+pcV0oiZzlYdu
         O+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689271707; x=1691863707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qf+ep2AGieWfF/6F4u3rk63REkDECe/z7Ykuugp3gNM=;
        b=bUZWDvIEMu4eHnklYV7nxANE2+3nrdIwWg2EmeX/1AmXjg84Tu35AMaNSTom2H4H+2
         p0yumncYosZxB/AL0SSLAXj0QUdQ1CcItqlpaDUvVy0dr7wUGCREQoW2JuTn6Zo3Bfn6
         rYIpdKZWrReY3ZPG3pS5vPoGzACmkiJ58wTC0lb8Qa2s9eO50hNPJfqKbXK/tgfK+G+3
         4PXV89HADIfkRUiAdJOVVaQ/PSkVwiheciWz89qEj5/NDhcD1u+6nITtsqJIlH6e53sR
         y6TapEgKfKr05gKKvSJY2TYbrzqf18HqQ/XXgqiJgrjlt81GU9AQoaq9ZSkIzooce7iA
         wDKw==
X-Gm-Message-State: ABy/qLZdSjcXAGEO5SBzVR85TyJ1WKJnT2wBAtBKvLWYB83Il6y5rkbk
        oUq++Hv5XXNBOW7DbESpq/C3YKKEarq1b3ZE
X-Google-Smtp-Source: APBJJlGxIANS6sizvtjX3zHjQrm+YpenC3s0tnUgxRFNT5MbDY86xh/6eBMjMjwVA0KWoxhhxGTulg==
X-Received: by 2002:a17:906:6bc6:b0:988:c3f9:3ad6 with SMTP id t6-20020a1709066bc600b00988c3f93ad6mr1772406ejs.42.1689271707454;
        Thu, 13 Jul 2023 11:08:27 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-010-190-210.77.10.pool.telefonica.de. [77.10.190.210])
        by smtp.gmail.com with ESMTPSA id q11-20020a170906940b00b00992d70f8078sm4270014ejx.106.2023.07.13.11.08.26
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 11:08:27 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 4/5] libsepol: drop superfluous check
Date:   Thu, 13 Jul 2023 20:08:15 +0200
Message-Id: <20230713180816.101924-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713180816.101924-1-cgzones@googlemail.com>
References: <20230713180816.101924-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

str_read() internally performs a sanity length check.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 552eb77a..e1f8bb06 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -3560,8 +3560,6 @@ static int filename_trans_rule_read(policydb_t *p, avrule_t **r,
 			return -1;
 
 		len = le32_to_cpu(buf[0]);
-		if (zero_or_saturated(len))
-			return -1;
 
 		rc = str_read(&cur->object_name, fp, len);
 		if (rc)
-- 
2.40.1

