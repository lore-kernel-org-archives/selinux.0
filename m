Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43768C77B71
	for <selinux@archiver.kernel.org>; Thu, 13 Apr 2023 19:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjDMTex (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Apr 2023 15:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjDMTew (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Apr 2023 15:34:52 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3E9212F
        for <selinux@vger.kernel.org>; Thu, 13 Apr 2023 12:34:51 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54c17fa9ae8so401730857b3.5
        for <selinux@vger.kernel.org>; Thu, 13 Apr 2023 12:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681414490; x=1684006490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bgDBrCaF764XDO++Hb918lQnKf1q24OKaJ+xsY1z98=;
        b=saiUix4zHKluPudkoLvKN6Y8PEC6HY/NG3RcXaXS87ST23BmT8NES5AvKs6HszpXhl
         /H7hIEUXDCfR836VuqAUe8/g1d4JkQRqOLuv070ck00rJu4oK46OH7z+Oz98u6r92Yzj
         2916qcdVh/fQmUnQKxKPE3sWeWWQflkfpCrrDkv91obKjS7pIean8PJlpNBHUGvmbDZb
         CYoDMgVm3M844PG/WlL6/amXd9/If69Psc4QukjAIk+Z2K2v/NK4h/Q0XDx58duBYNAO
         6c7xnncSYDMHK5zpFfRxmujg0ATCxYXrxbnIvWWtKwzHcYL6oo12Q7xTgsoVkVEqTsM1
         Kqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681414490; x=1684006490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bgDBrCaF764XDO++Hb918lQnKf1q24OKaJ+xsY1z98=;
        b=XpO/WFlL3VKSZQLbgqvsT6qzW+7nvxjILkxmrnfF+M6VHVTbvdQjmqoThCkOgOneSA
         zIeHuNE4Qlyv2ipPC++cdVoFTalS8YITnTG9UhPEibpmZ+yUkkvzYcf98VAMJ99CdBdn
         eHZjKUBgEuhkKE+kgguldlCRz/ushuWHVu5p04265QtAlfpieZbqvtmMIqrJT4dAl+o9
         w7xRSyVSfsrrsEuYfFJmrm5BjTw4ti3yKJw/l9fD/FMWzcZ9LdFegKy9PvnxysQvwCBa
         kHRTc3+9Gmwnc5WvT3hQ1LgDMv7ROXiAJKUcSU2l839IXlIclr6r/xRSTxL40ezvgE/a
         Cpdw==
X-Gm-Message-State: AAQBX9e8P6UB9UB1qexZGTk6lzWMFxa80OxwANzddHmvb+2c1zjTy2zq
        MhiE5iCcSyskAXFczK4tOnJAdZM5XjU=
X-Google-Smtp-Source: AKy350ZK7n5L3o0sm9AOMMNCeC8FoQqtRjBMrGHzTrmRNtzvFvA8f5aQVHSKzH9mk36P0KEXCjv0Ig==
X-Received: by 2002:a0d:dfd3:0:b0:54f:27c6:a496 with SMTP id i202-20020a0ddfd3000000b0054f27c6a496mr2719906ywe.1.1681414490187;
        Thu, 13 Apr 2023 12:34:50 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id 21-20020a811615000000b0054c0f46b24bsm691350yww.5.2023.04.13.12.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 12:34:49 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/9 v3] libsepol/cil: Add cil_list_is_empty macro
Date:   Thu, 13 Apr 2023 15:34:38 -0400
Message-Id: <20230413193445.588395-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413193445.588395-1-jwcart2@gmail.com>
References: <20230413193445.588395-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a macro, called cil_list_is_empty, that returns true if the
list pointer or list head is NULL.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_list.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libsepol/cil/src/cil_list.h b/libsepol/cil/src/cil_list.h
index 6b4708a0..f974fddc 100644
--- a/libsepol/cil/src/cil_list.h
+++ b/libsepol/cil/src/cil_list.h
@@ -44,6 +44,9 @@ struct cil_list_item {
 	void *data;
 };
 
+#define cil_list_is_empty(list) \
+	((list) == NULL || (list)->head == NULL)
+
 #define cil_list_for_each(item, list) \
 	for (item = (list)->head; item != NULL; item = item->next)
 
-- 
2.39.2

