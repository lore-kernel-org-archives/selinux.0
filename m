Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E33C433F5
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4214C61108
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbhKEPsu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbhKEPso (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:44 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94E4C061714
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:46:04 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id f4so34277182edx.12
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jzKfVZkV3dgFA3SsACKwZ8re2XytntIUNt5Z2i3tnFE=;
        b=R2tZJLCIEEUvgiMGenk4xd/6qAR8tgE+Sk3+bX17u0r4ncY0GPkcY5UTr+4Ajjj592
         FRCYvVhhCb+d6WWltZjJxIFQVtKTggqWcC9echPX5OD6YcNq5LkFh54ksEuGwIvHP3KN
         f7Gl6B9Q3OaCZc1f4/Av8GMUWIkJmTwVk9al3G0qOMxzLM0GSggEtR0+QGVVf/HpYhrq
         ZIwdgYu1ChPcnKveVdLZT8vyRUyl2DPxjSjrPiQD5aRFFGNIiEpuK24NkaHsX3xFEMAj
         jPMl6COeI9mHn5Insz8sKXUpGbGegKE7g78VPW7UTXngIyD6I9srSzuEhDoIOY+ngA+U
         lYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jzKfVZkV3dgFA3SsACKwZ8re2XytntIUNt5Z2i3tnFE=;
        b=TgZUNhSuo4VlUrfH5u2Z0ANj5tl0HVQRaiD71HKzwEirC345G8Cgt0BpBnleuKu2n4
         Zix/Uk/KXmzumSHrBVPtH0QzpM1HfgrNFDshvPG9ESWDxfLq3ghKbUbOE3/aTT1PMAzP
         TPf9zl4viVYq3FfOHg0YCu9yU+6huyRB1ATXv02vUqs2lwXk3HmeNYx3YJKiJfj2V12W
         GsEncbR1cZcmTWBq0XHSx7SCoyvDGvDgEmyoU3qnM5GLPyX8HTYbJcWEfCow3cj3RVjN
         EZpw6zWor2cXhmIkx2L18ky2gkH92hoY0VgLI6kFPY4C9FySyWowXnUtZYco6g7uSFV2
         y8Zg==
X-Gm-Message-State: AOAM532S4U1dOHIgcanvGOecYq2Njnun0IxC9oyy8/ZjJJNaDwbHPuYi
        OuiXK2gL7SWP6bbwus+4boMkh0sBxF4=
X-Google-Smtp-Source: ABdhPJxHLEzw11V0ShfqRrbBEmTTjAkbkU0FcnS2m4QIeAk3n8MsKr94Rq9Wz8UBG7zT1Faxl+nmFA==
X-Received: by 2002:a50:d4d1:: with SMTP id e17mr78909491edj.348.1636127162715;
        Fri, 05 Nov 2021 08:46:02 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.46.02
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:46:02 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 26/36] libsepol: resolve log message mismatch
Date:   Fri,  5 Nov 2021 16:45:28 +0100
Message-Id: <20211105154542.38434-27-cgzones@googlemail.com>
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
2.33.1

