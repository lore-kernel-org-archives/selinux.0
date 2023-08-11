Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9357CEB64DD
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 16:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbjHKQ2C (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 12:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbjHKQ2B (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 12:28:01 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B62109
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:28:01 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99cce6f7de2so306108266b.3
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691771279; x=1692376079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tdQNlCF8kllSxhHWrl5dxhxYUastPbI3lxdFSaVbvcs=;
        b=n2B4X06GYMuOLO4Jj6EEEdSjWuYU+Bl7HdXUTFz1783ey2GFheDPzWt2Y1glmsI/BU
         xCU0QuM2kDp0tEwIKiNGNPZAT26OHGAzJUsU3S1fp0T6pfkEr51eaz49YCXfUEZq1cL+
         YQiG8Km9HBKM/piAbnnYfyVLpgdMTOTIQxjp4xc/HRjsynDWgZljvdONsXkXtu5Chw5o
         Irxx1R8j6GFKaFifVoSOEJ8TkyqY715vXrxVt5EPYzpQE78H81qj2xgU6qJIxyaC5ZE4
         WXa6ATyw2cSEPJjVAxfiJQoAJ/1UA5+xcd/kEnQ9z7tiWECyteAUqEs+Z7BrQWVpIayM
         nBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771279; x=1692376079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdQNlCF8kllSxhHWrl5dxhxYUastPbI3lxdFSaVbvcs=;
        b=deDr7fE/PyJL9rdqarObH1M1yFlHUBcHDz925cR3zWoaRY+aHw1dWOZYfRY1bWvlMl
         xNrGiZCQ/QHnuuJwnZ7+85usqfh9wDP6h1cWdNa1vIpyrq4RudWcHzuJ2CZGFhAbMAIa
         YwVliD1yAXHP6DeaiLrRiNbzz+92+XnlJaIJaYolRI4gza4hPowoJGgcB2TBgwOc2oAb
         Qb22fJSWU3y8pldyo8P6OSPiwMct7MDlISmzTXP+UIOQU16Kh4qdp/LOEfwgy9Ecl34Y
         4vSbLaAudAzMs+LjVMJgbNVV8PqG6dJmy67WIaTJdomxWfWGqaHLfainzt9KKpSZIxBW
         zLAQ==
X-Gm-Message-State: AOJu0YziQI6Sbin/+iZXjpV38rIswzM5a/GEWMpMBtz340KRqMxRAyos
        /5pqNfCdykblx7hAMI0BYrJVmigeYTEWXw==
X-Google-Smtp-Source: AGHT+IH7gquk2B3TOJ+90zjqDIgk6X1yRDo/n0ymJ+CTZNmSlybmk5lGxaKqDd2iE9F5YciJeCqJgg==
X-Received: by 2002:a17:906:153:b0:99b:fdbb:3203 with SMTP id 19-20020a170906015300b0099bfdbb3203mr2032748ejh.3.1691771279620;
        Fri, 11 Aug 2023 09:27:59 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-174-226.77.0.pool.telefonica.de. [77.0.174.226])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906b20900b00992afee724bsm2408807ejz.76.2023.08.11.09.27.59
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 09:27:59 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 22/24] libselinux/utils: drop include of internal header file
Date:   Fri, 11 Aug 2023 18:27:29 +0200
Message-Id: <20230811162731.50697-23-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230811162731.50697-1-cgzones@googlemail.com>
References: <20230811162731.50697-1-cgzones@googlemail.com>
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

