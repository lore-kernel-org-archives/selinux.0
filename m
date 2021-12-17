Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F763C433EF
	for <selinux@archiver.kernel.org>; Fri, 17 Dec 2021 18:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbhLQST0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Dec 2021 13:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbhLQST0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Dec 2021 13:19:26 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DACBC061574
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:26 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id de30so3038266qkb.0
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tKn85cKJmtY5fpLVgW6csAcITiSKsyGMOP6Hjw9OQtI=;
        b=et3rIzqrqDF9R/cDozPZgJIdlv5HqGnulC74dmCHjwvx8jsVDif81pJ/s1Rh5WLrWO
         g+frQkvPhGejap9oJVpMJ0EiJtlcy9rc8CuEaxg43i2NLLL8osObwA97Z8XN5ddI1ZDh
         IyWpkDcTzmdQPVFeOkEa4ARA3egoIHhITF+L0zSGUFbLo51zb8Ap9Plaz/UpQLRPg/Hx
         MUlMMnJ5+BQGOr9aNFPIaDVU7TnaH85C+XOy5hOtfB4zwnJlMEcozAgTDM/fQD8MFgC4
         7bWZAEmKknWqBa3kRqptHN4TXRT3jOA6FYLp+znfvKEhbg7W6PTkv+NzajJRu7ofcREI
         xy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tKn85cKJmtY5fpLVgW6csAcITiSKsyGMOP6Hjw9OQtI=;
        b=X+3Nsdh5X8h1XYSi6ZtlFFu3acY7sgj+y4Rc6a++bRR50LjufQa6yHVpeIe4s1HKno
         sEuIEQe5p8IdwEwEL8S46PZR3eHgcvqN67Ndo2xe3GmInNw5QXBeuiP+dQ04OgV/KI/q
         8icwMhGEtzi6rb/fbVAwJTiIrizZ0oqZSvoeDRcPLqRZ+XOkG8BkUsmQmzOnDWML9YyJ
         yNlpK0ubLIYl0V8sT3hDgM0mBGYr5YUvI2/gwh19MZIBqZWeVhhm1vAdggGvR8dB1+s4
         BQty7mE/WGDpUtu7Yk6UyxgcV7SQbMDXFo91YN5LWgWTkgyj/pRodp9cwrA98KTcp/ez
         izgA==
X-Gm-Message-State: AOAM531njhGYqXyMvXevLwOTRZZ3hefxzbQuRKQ1xb6ODCIusHJhXiJ8
        J+gfqJ579LvB7m1JbZnxQuECHPgu7LQ=
X-Google-Smtp-Source: ABdhPJxlNSLNDlztQ4ZVnmpYtEmS3fF7RW9hBuWWHGza5ijxFMjvaC/EhYdyhawhAsBRbVud44aBaA==
X-Received: by 2002:a05:620a:2407:: with SMTP id d7mr2680177qkn.114.1639765165329;
        Fri, 17 Dec 2021 10:19:25 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id o17sm7468094qtv.30.2021.12.17.10.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 10:19:24 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 01/16] libsepol: Return an error if check_assertion() returns an error.
Date:   Fri, 17 Dec 2021 13:18:58 -0500
Message-Id: <20211217181913.336360-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211217181913.336360-1-jwcart2@gmail.com>
References: <20211217181913.336360-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Instead of calling report_assertion_failures() and treating an
error like it was a neverallow violation, just return an error.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/assertion.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index dd2749a0..ba4a204f 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -538,6 +538,10 @@ int check_assertions(sepol_handle_t * handle, policydb_t * p,
 		if (!(a->specified & (AVRULE_NEVERALLOW | AVRULE_XPERMS_NEVERALLOW)))
 			continue;
 		rc = check_assertion(p, a);
+		if (rc < 0) {
+			ERR(handle, "Error occurred while checking neverallows");
+			return -1;
+		}
 		if (rc) {
 			rc = report_assertion_failures(handle, p, a);
 			if (rc < 0) {
-- 
2.31.1

