Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0DCC001DE
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 16:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjHKQ2A (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 12:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjHKQ17 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 12:27:59 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253382D70
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:59 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99c353a395cso302081666b.2
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691771277; x=1692376077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F76+OARcbDG+Dhzl4dXmbQMfBLLsN2l7V+qnY8M1apY=;
        b=lyQPMEzjTNRTbEBOWqvWO0pxoytXg/wcscEh3GHcFFEua1SHqKZkZxME5ddEQ3UzJu
         QxxXdj+vvkD64k+7pXthfZLKPMLzSlHg6QG7wq9JTFxV79Wd6X8oiJgFqkTmv3Of1KZZ
         XJc+wiOTtB6H6QG6HHIWt/XEfx0tmZBXqtfSE3zdPIUDh8FGObexXUngFTjumpKS0YOr
         a6g7jUfdrxZzNgsApzU8EeUzCVfXnLcn6wFqa12qmpjdj3Zr/o4boJTp1VTRlr7pa2aN
         VeFL4dTH2u6/hmBCsUDko/PfGT5jUvu1WBmdZRilXlbGngMbSU4pA/Z2y24hQofwQWpm
         DqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771277; x=1692376077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F76+OARcbDG+Dhzl4dXmbQMfBLLsN2l7V+qnY8M1apY=;
        b=CD36SFERA+AOuDbehLLn08YAx5E6Fk70jE1QYyMkzPDtHx+daaIMAcg68LLABhBT1V
         t+R7INVA5RwgtyCDJVz7kqOB8GTTebXq2Pv7HwT5cMQAP43u4DNzrrTVTphURzwKA++7
         kf3/3DGhZ8vDw6/l3Yjwqd6OmPcZuuRCI6bOc+O4d5hYZ/+IjfLblfjrfm+9nmSmH0Oh
         HcD7vnhfazlZ9ANXaLte1TEnztMKazHe9lmGENTIhiWxPMv1mv8WUuBXOq2SwrBdnG9Q
         LjkiBCk63nBCSpUhr5LYPDn5L8OAVdN+IvWvDspDywcYqp0ulzNMbzJC3CIeQr5u2UUm
         An1g==
X-Gm-Message-State: AOJu0YzAe4YMUEs7CnFh6oU5/nshn2+LeXeu0ijuJFqPdpeq/QPQmMX5
        U2aN5Cq7e1Qbuncr3oqkV0tWJwhAXdgxig==
X-Google-Smtp-Source: AGHT+IGOfjR3MJ0hPM8qNzDLmC19f+kk+ZL+lO0fXM7gLllp6PssX/fNoW5xKug/vOpoygMszAU3fQ==
X-Received: by 2002:a17:907:aa6:b0:99b:44aa:fae0 with SMTP id bz6-20020a1709070aa600b0099b44aafae0mr1760231ejc.21.1691771277583;
        Fri, 11 Aug 2023 09:27:57 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-174-226.77.0.pool.telefonica.de. [77.0.174.226])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906b20900b00992afee724bsm2408807ejz.76.2023.08.11.09.27.57
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 09:27:57 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 18/24] libselinux: fix logic for building android backend
Date:   Fri, 11 Aug 2023 18:27:25 +0200
Message-Id: <20230811162731.50697-19-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230811162731.50697-1-cgzones@googlemail.com>
References: <20230811162731.50697-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fix the typo and adjust the logic accordingly so the android backend is
not build by default, but if either ANDROID_HOST or
LABEL_BACKEND_ANDROID is set to y.

Fixes: c2a58cc52574 ("libselinux: LABEL_BACKEND_ANDROID add option to enable")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 15d224e1..86a254da 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -131,11 +131,10 @@ DISABLE_FLAGS+= -DNO_MEDIA_BACKEND -DNO_DB_BACKEND -DNO_X_BACKEND \
 SRCS= callbacks.c freecon.c label.c label_file.c \
 	label_backends_android.c regex.c label_support.c \
 	matchpathcon.c setrans_client.c sha1.c booleans.c
-else
 LABEL_BACKEND_ANDROID=y
 endif
 
-ifneq ($(LABEL_BACKEND_ANDROIDT),y)
+ifneq ($(LABEL_BACKEND_ANDROID),y)
 SRCS:= $(filter-out label_backends_android.c, $(SRCS))
 DISABLE_FLAGS+= -DNO_ANDROID_BACKEND
 endif
-- 
2.40.1

