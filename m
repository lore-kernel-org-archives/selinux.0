Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB99C43217
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D994661183
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbhKEPs4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbhKEPsw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:52 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1B2C06120B
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:46:10 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r12so34515478edt.6
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Sb29ZTp2vHfHooQmFLyAg5NPa5IOXfTkfBpi+a7yWxQ=;
        b=YlmjHexw1HDJvXurwTExJpnT2T7kY79kL2o/tC6HAucai/kN3vitoD29r1UhrUGPZ7
         tICQDT4w1bEdbzx5NFzDwf/NqO/O/WJiINJT0l1HwmzbIe4GVJiAtrjW6XzY9DVbbISC
         J9foYCcxnsoNFOZeiPw4UKUMhEgjX5jsDQuwfia81leRZjqv1h1Gv7UhpxlJxm/ZTm2j
         enUHAfiqHJBxah+PaxmPZ6XkByjYKeSe9+jATIbgUggrPcRJtTRcC8/h0piTTKvt+Rpi
         Jbf94OqgjboYQj9qQ7MRMWlLePTN+c7wAgDlA8gLZJWOlwBzMhcXkNAxJd+8chRm237q
         bI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sb29ZTp2vHfHooQmFLyAg5NPa5IOXfTkfBpi+a7yWxQ=;
        b=wYHscIT6XIMOwAja4IR3y/W0O8htmH38rt/0PSJVymTiTLQ/tWO9sxd4kUoG6ORdKj
         K/+PR218kRYxkEQPjQcvNWoaAfyNY3QS54hWo6BRK0ryuCELrKymZbuXHVCJjlh2if0i
         YOU9+gUaMgnYXl9C4qp6Nb0gOhakevO5mxaZivY5WGDwPYBOzPOKVPWn3c2BuQaCN6A+
         K2oOHTIOZfJGJoEJTY74YcVozROaowQuHF/nP7jVzDrL9v0PMwlApxJvZg9S0N9JCVwl
         ecmkY7tAUFntmOjiqqp7bK0v4l5zQNm3ZDEJe16Vv9L1fis90w2KewwW+qoLpGkMtwmX
         wRcA==
X-Gm-Message-State: AOAM531BhN8EF5RbrKp2pQhpdLy57y8K+RPLGphbIi6nI8Y/682JLvp/
        gCGPZPw36BNIZ6j9VLhgHictqSrhjKc=
X-Google-Smtp-Source: ABdhPJxtb7rtqF0InWioHMui0N4E1QiOCBMTceAy62WDAtNOqlTX029fXQe2kxpMxsCVK7bzGgU4UQ==
X-Received: by 2002:a17:907:7850:: with SMTP id lb16mr19556551ejc.67.1636127169496;
        Fri, 05 Nov 2021 08:46:09 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.46.09
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:46:09 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 38/40] [WIP] checkpolicy: validate generated policies
Date:   Fri,  5 Nov 2021 16:45:40 +0100
Message-Id: <20211105154542.38434-39-cgzones@googlemail.com>
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

After generating policies validate them.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/checkmodule.c | 8 ++++++++
 checkpolicy/checkpolicy.c | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
index 3432608b..846e5a36 100644
--- a/checkpolicy/checkmodule.c
+++ b/checkpolicy/checkmodule.c
@@ -29,6 +29,7 @@
 #include <sepol/policydb/expand.h>
 #include <sepol/policydb/link.h>
 #include <sepol/policydb/sidtab.h>
+#include <sepol/policydb/validate.h>
 
 #include "queue.h"
 #include "checkpolicy.h"
@@ -329,6 +330,13 @@ int main(int argc, char **argv)
 
 	sepol_sidtab_destroy(&sidtab);
 
+	modpolicydb.policyvers = policyvers;
+
+	if (validate_policydb(NULL, &modpolicydb)) {
+		fprintf(stderr, "%s:  validation of generated policy failed\n", argv[0]);
+		exit(1);
+	}
+
 	if (outfile) {
 		FILE *outfp = fopen(outfile, "w");
 
diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 926ce72c..3ce63d06 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -87,6 +87,7 @@
 #include <sepol/policydb/hierarchy.h>
 #include <sepol/policydb/expand.h>
 #include <sepol/policydb/link.h>
+#include <sepol/policydb/validate.h>
 
 #include "queue.h"
 #include "checkpolicy.h"
@@ -652,6 +653,11 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (validate_policydb(NULL, policydbp)) {
+		fprintf(stderr, "%s:  validation of generated policy failed\n", argv[0]);
+		exit(1);
+	}
+
 	if (outfile) {
 		if (!strcmp(outfile, "-")) {
 			outfp = stdout;
-- 
2.33.1

