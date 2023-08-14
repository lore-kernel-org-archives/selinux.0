Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2D9C25B5E
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjHNNVZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjHNNVG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:21:06 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69304198A
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:54 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-522ab557632so5808027a12.0
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692019253; x=1692624053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tdQNlCF8kllSxhHWrl5dxhxYUastPbI3lxdFSaVbvcs=;
        b=JEg0Jv7RkjXPsXshNn7pNOWHmyKIREGUx06Gzl1WVaiJY5ab9MmX6mde8YX8TUHNqW
         llOVFosgBU0JEmqYz+fCo6MffDfF5QCgwIRIeUmSeXCwqPZae0YSt0kWwlYf6qnCsrk4
         Qtk1GEsVBF5IEZxAxb/YXpixuxDya+5rEbqldCgOu8Lz0N4Bn2hkPxeq/04mfJg5EbCh
         NNvlJ9nBcGBa8WYBLk30IGg8igfInpokmV63SH0y+yhxznJuGtJG95KfCO/rX0/IMEdL
         ccgn2bD29oOzZJr1IiQ3FvRRQ3ovKz/cz1NEIJZm6xLvhkIfMso21PITz/yt/NAUAGXH
         IiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019253; x=1692624053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdQNlCF8kllSxhHWrl5dxhxYUastPbI3lxdFSaVbvcs=;
        b=T0QmOXV7iiGL9HkPTF32fmfHO6Xaa64AGJI85iiB5ZQTJA7OUwXQUxoGoEEYu8TIVz
         J3NtPIAsrIzp3FxnxwkrszgCdGGxlsk72EPlblzqP9m4hsPMxHufc3iR1n4LAPEa3M12
         5rAk1FswOl2HdPVvd+5G5En8nJfVgoY/wR6H8v+KTpULREzHfhqVwv0zAPW5/3Zk95IF
         NcMB9nfyXxFfovYU07DpTv6MJQOquaUjhRMw9vQYZVu521c8CDHa4hXS46Pqss7aYoso
         bosnldcLrJpGSGuUGb4u5EymF9w30bbHtLFHGTLeIKnvnDdDzHzO4QVpZPDlwGps996r
         Pd0g==
X-Gm-Message-State: AOJu0YzVB3ULE42BOOpmlQj2AHlPZDXPHnILamXELfUiKAt+9mdBfs+h
        Y1lY8WgC4pGZoyxAmaJDMpmY4fqiDpxyAI9IZ08=
X-Google-Smtp-Source: AGHT+IGU0OY+6NxRgnkYpkrKToGxpM6k/e5uDWmW0qxHj9ukJd9sa4Bv1exUAC+CNYHXKLsDqL5xTA==
X-Received: by 2002:a17:907:1dc4:b0:99b:4174:77f6 with SMTP id og4-20020a1709071dc400b0099b417477f6mr7194275ejc.33.1692019252838;
        Mon, 14 Aug 2023 06:20:52 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-167-009.95.112.pool.telefonica.de. [95.112.167.9])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5683541ejb.103.2023.08.14.06.20.52
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:20:52 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 22/27] libselinux/utils: drop include of internal header file
Date:   Mon, 14 Aug 2023 15:20:20 +0200
Message-Id: <20230814132025.45364-23-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814132025.45364-1-cgzones@googlemail.com>
References: <20230814132025.45364-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

selabel_get_digest_all_partial_matches is dynamically linked against
libselinux, so it should not depend on any internals and thus do not
make use of an internal header file

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/selabel_get_digests_all_partial_matches.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/libselinux/utils/selabel_get_digests_all_partial_matches.c b/libselinux/utils/selabel_get_digests_all_partial_matches.c
index c4e0f836..e2733b41 100644
--- a/libselinux/utils/selabel_get_digests_all_partial_matches.c
+++ b/libselinux/utils/selabel_get_digests_all_partial_matches.c
@@ -8,8 +8,6 @@
 #include <selinux/selinux.h>
 #include <selinux/label.h>
 
-#include "../src/label_file.h"
-
 static __attribute__ ((__noreturn__)) void usage(const char *progname)
 {
 	fprintf(stderr,
-- 
2.40.1

