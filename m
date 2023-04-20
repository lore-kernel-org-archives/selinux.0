Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E332EC77B72
	for <selinux@archiver.kernel.org>; Thu, 20 Apr 2023 15:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjDTPPN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Apr 2023 11:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjDTPPM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Apr 2023 11:15:12 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7009E3
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:15:07 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id fy21so7101797ejb.9
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682003706; x=1684595706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AnrQwDtFxlw5DWIhokJvKCT7TWn1lVJrVcAmFi3+goQ=;
        b=BSRdypgHXlq23A8UuXRyCaYWaqiSSi2U80cXhTzQBqf+sV6NtKYvJN1vysoHW21a5y
         1hkXnCO8TPmept+60TPVS/uGdtpcyEcqUZF2v98HjcN6/OwfQWHPwOXYj/Rv2Oobiy0Y
         a/K5p3Xazd8O4chiIKhZDURJEeVukrvaoupmVf8mAi78dlp+4JHoz7HTGHkO8YrEt3DL
         /pVhLbsdJq6VfmOVwkbWotKx7mlye/pLgAPFkUDyn/9NybjesHqDwQDvNXj6maR4D+ef
         Vt64CiCj1ifxgSPjEVTAE6eBcj9nOUB5LFd0mJYCKXgcFzTDuJSotZk1yy4vkBjc/c/+
         fg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682003706; x=1684595706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnrQwDtFxlw5DWIhokJvKCT7TWn1lVJrVcAmFi3+goQ=;
        b=FKVUMMzWmRBh9hEp7BmoCBHQZrCXp065FxwVcveB6Jx+atu7rDMtTmi4QG4GjDR1sF
         pk6c8nCjII9yK/APz4G35dXs0NcGXm0hLFCTzoyVt3/UpvjmjlXIs40W8zUbhvlvXpJu
         bTeunnIojVcxDc55uM2HymcSDofDbWwD/Pv+0ia2Ea+RgTpGuXnS6QviRO3x6oRkG63Q
         Z7oTfzPrgo/Kg07SuxugyKq1VPM1kclttJJo88UZUWYTlHZVme0HBXAIDyskZSeQAbNS
         QSizZwUsfAovgpjim/PGgx+NJISUCoOkGGKxzx9xDy38pAufkpK9woR889WFl3V1UCQf
         5kvw==
X-Gm-Message-State: AAQBX9d+6wsMkYi4E0ArQvMFBNKuPbWorjk5YlWSZtxLWjCfNGDb6CQw
        yb1QyGcFE5odZK2aeYafnldEB5WE7A8=
X-Google-Smtp-Source: AKy350bOWBj8TF2+UiL8UnC316faA6sghUrlPtscmyOgtqsaqluN6wfBA+ZxiIg9amqphciK07AEyg==
X-Received: by 2002:a17:907:9247:b0:94e:afb6:eda2 with SMTP id kb7-20020a170907924700b0094eafb6eda2mr1686638ejb.8.1682003706227;
        Thu, 20 Apr 2023 08:15:06 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-119-201-251.95.119.pool.telefonica.de. [95.119.201.251])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090676ce00b00932ba722482sm850503ejn.149.2023.04.20.08.15.05
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 08:15:05 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH RESEND] libsemanage: fix memory leak in semanage_user_roles
Date:   Thu, 20 Apr 2023 17:15:00 +0200
Message-Id: <20230420151500.23679-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230401124902.76959-1-cgzones@googlemail.com>
References: <20230401124902.76959-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The output parameter `role_arr` of semanage_user_get_roles() is an array
of non-owned role names.  Since the array is never used again, as its
contents have been copied into the return value `roles`, free it.

Example leak report from useradd(8):

    Direct leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x5597624284a8 in __interceptor_calloc (./shadow/src/useradd+0xee4a8)
    #1 0x7f53aefcbbf9 in sepol_user_get_roles src/user_record.c:270:21

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
same as v1, only signed-of
---
 libsemanage/src/seusers_local.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsemanage/src/seusers_local.c b/libsemanage/src/seusers_local.c
index 6508ec05..795a33d6 100644
--- a/libsemanage/src/seusers_local.c
+++ b/libsemanage/src/seusers_local.c
@@ -47,6 +47,7 @@ static char *semanage_user_roles(semanage_handle_t * handle, const char *sename)
 						}
 					}
 				}
+				free(roles_arr);
 			}
 			semanage_user_free(user);
 		}
-- 
2.40.0

