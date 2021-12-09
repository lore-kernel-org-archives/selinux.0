Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FC6C433EF
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241357AbhLIQ4P (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbhLIQ4O (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:56:14 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E74C0617A1
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:52:41 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x10so4330494edd.5
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=X3FgUN/DDQ4sJzzIyJ9C0AbwUZLlkbndGXVdo7GgbdU=;
        b=FHzjxdDetdbjQt16+gza5ee1f9v5DpncwQNCoKFJMo+CdU8lH7lhW+Bn0yJ64e6Qpl
         FoFzzZ7Uyj6tetx6HFPfttWExOYtQAgUq9PiIb+gMlMNRauu24qKdG4+gdo1bJeLRSKk
         k8WQboXxtDDr203es0cli+yukBIBS8T/hZNinP7+LL4CXL/93Mz5oAi6osPlg3WaW0oF
         uwmPgsrZNhuf2NgKayHE6yPSE0UQjEd2WDcuu/ZYHkSxdFSjxDtSsJBub2081xZxkDg/
         ICfr5a8YwszgOdvy2th+ZFlKAkW4PL99zn+CYc6Av6MxG3hBJfWeX56UDVjzzWI2TFH+
         ueiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X3FgUN/DDQ4sJzzIyJ9C0AbwUZLlkbndGXVdo7GgbdU=;
        b=MPgDNISeoLY8Yab12fuqPar6lpF29s9FCXjmn3pm+Tl96m3X/BV7BU9haKf7zBiEv2
         U3/GRPEwyROgfXvvpEXgVf4woGEzNdyrwxCexMoppYmyhYQ5dG19Igq8oExS1ZEOptyL
         Wzv6kCJxfObEJISL6uSWFiCY0Erl4Pt7+3c3vQS2nyDFu9nSwKTrw2afxa3jl0+Uqeeh
         KEVO+OpVUcnbbRAGr8a4CvaiqIFhrpbPaswMELHcgx0rfl8ivJ3RQi02Vosq/ZlE9e8h
         T007AA/aKYbkYnRrbZjKppfCQXi7tQE5lJIuhOJaQq5u5khsuyF4n9WQTLMCKt977tT/
         0bHQ==
X-Gm-Message-State: AOAM533nXLPavoQWHtyGkSj5xzTTsxsnM3Wat0zLNslx+swYSz7xkNpi
        K3LV/SFvSG27j4U4lySWrTx1sNfnUDo=
X-Google-Smtp-Source: ABdhPJwFjEh9hxd1l8bVcqmLlT1Zq2JLByvfjlmZTFOvtUi0w4t6hmWyhGB6tKQFHWfSOkpCqJxKHA==
X-Received: by 2002:a17:906:5d0b:: with SMTP id g11mr16975739ejt.295.1639068596370;
        Thu, 09 Dec 2021 08:49:56 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.55
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:56 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 31/36] libsepol: validate genfs contexts
Date:   Thu,  9 Dec 2021 17:49:23 +0100
Message-Id: <20211209164928.87459-32-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209164928.87459-1-cgzones@googlemail.com>
References: <20211105154542.38434-1-cgzones@googlemail.com>
 <20211209164928.87459-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Check the literal contexts in a genfs statement are defined.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

---
v2:
   also check in base modules
---
 libsepol/src/policydb_validate.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index bedf3b90..11f13d65 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -779,6 +779,25 @@ bad:
 	return -1;
 }
 
+static int validate_genfs(sepol_handle_t *handle, policydb_t *p, validate_t flavors[])
+{
+	genfs_t *genfs;
+	ocontext_t *octx;
+
+	for (genfs = p->genfs; genfs; genfs = genfs->next) {
+		for (octx = genfs->head; octx; octx = octx->next) {
+			if (validate_context(&octx->context[0], flavors, p->mls))
+				goto bad;
+		}
+	}
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid genfs");
+	return -1;
+}
+
 /*
  * Functions to validate a module policydb
  */
@@ -982,6 +1001,9 @@ int validate_policydb(sepol_handle_t *handle, policydb_t *p)
 	if (validate_ocontexts(handle, p, flavors))
 		goto bad;
 
+	if (validate_genfs(handle, p, flavors))
+		goto bad;
+
 	if (validate_scopes(handle, p->scope, p->global))
 		goto bad;
 
-- 
2.34.1

