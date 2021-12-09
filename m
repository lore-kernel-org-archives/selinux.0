Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1F4C433EF
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhLIQz0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238016AbhLIQzX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:55:23 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32787C061746
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:51:49 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id o20so21703994eds.10
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GHwjEczevlDNTtezcgI8SLnEHrr4MSAb9QR5cl0FIrI=;
        b=XZpINcDSOSl46ZVUX+m57wbqM+maykLB3ENk5U5lY8QSPzVYDk40QgHPSW6wMRw7H6
         esyXCssWfb2SWiSo5w2W73+4BfPScDyeLlTtelnGRzo3vMwGScXU6lLJFPrJOVPIXl4v
         hO3B+ziutYeBwxL0T2wIqxT5S9nfAZvRMwqg4rHn4ju4w9JNfKb3RdX5uCSXq1HmonM0
         2CQBAw3a+Jek6ByMY90rtEHvCfmhMGeaCg77zsTI1uYF5toV8XzDrIithqQs2f3XD+OR
         iihjQmOJYyHfBmbc/7ShxwKSg5OgmQPYe65IdB6+CwpV82WFXn6UjflMnsnWtmiV4MMI
         UzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GHwjEczevlDNTtezcgI8SLnEHrr4MSAb9QR5cl0FIrI=;
        b=y/6bSdMXPTFuE1ybk7LdY0+wWEi75UbErStaLe8EvqNCYmE1pTvI9d9muUf4ZI+4WN
         bPG4XKl0aLswr8xqaW50hI9vhu9WFdkEq1kJ/YIv3dgX0FjWyo50mi1GuL+rcsvH7gpF
         N07DUUCKagd8a79W/fbZTvLycFUSaRZ0b4GPtOQIZpkGS7oBUgOF13jgR4kBE1tRpT3h
         rSos39Xh3iqCxXfaItQ/em3tyf99C9ZWGYvu/ew8YY9HUpI1IJJZYkta/lDvla7JviTk
         gqFccjtEBZZ5KKr8sECacrBKPKaMvJNUaKtnfAYJ4vq5NI9DaoitiUf2pjQSufFRj1Pg
         3sWg==
X-Gm-Message-State: AOAM533y1QPIIMZAz4lWQhdOSmoWZ+CPlm70Xp41WUkIPzP2clUJtTKJ
        3d07gBkpTMWUSzZaxmxoIjyMxKIV4eY=
X-Google-Smtp-Source: ABdhPJxKAdRHU//6Q3Fm0LO8pBo64FhhNcQVV82Ygm7iwP9lKR/FK1R5WXnehiWYaEGC8DSOiqbP0A==
X-Received: by 2002:a17:907:7294:: with SMTP id dt20mr16939002ejc.321.1639068592840;
        Thu, 09 Dec 2021 08:49:52 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.52
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:52 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 26/36] libsepol: resolve log message mismatch
Date:   Thu,  9 Dec 2021 17:49:18 +0100
Message-Id: <20211209164928.87459-27-cgzones@googlemail.com>
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

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index e8d70585..82193379 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -263,7 +263,7 @@ static int validate_role_datum(sepol_handle_t *handle, role_datum_t *role, valid
 	return 0;
 
 bad:
-	ERR(handle, "Invalid class datum");
+	ERR(handle, "Invalid role datum");
 	return -1;
 }
 
-- 
2.34.1

