Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9089C433FE
	for <selinux@archiver.kernel.org>; Tue, 22 Feb 2022 13:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbiBVNwR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Feb 2022 08:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiBVNwP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Feb 2022 08:52:15 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C4B986EE
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 05:51:49 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id hw13so42924443ejc.9
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 05:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iv+2a7tqm2jECt97x/Sq1uKwBTjbldUt0AY5QMtK2PY=;
        b=nW2OxukDWIL9GK1qSlR7xXhsMfBtm89bjwLjzkFOLqexutUs9jMblBY8g44Gm7Lv1x
         wzOsKpSSEMwxGHVeBhlwOQyCXy8a6Qu5VP6HeThmtZ77IBfCo5eOfYEm1VQNCdCS8yYq
         MYI5/6CSWRzZoKQxnesjz7QYhsfdekKd/vxGnZGp8dRDFBHV5SAkyN6ks6AtP5iOMpEL
         AXK+0ptigCvvtdgDOpFf1DLeuHZEUb2HmQPNW7SA7SqOVNCShkyGTOJQ9Mg6aSMAr9so
         RMl1z7ZxyDakjcvQd2U02Zd2uxG0ZkaMWayDp0uDIidxrtPji57yRt+6erEFN03tbums
         6HlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iv+2a7tqm2jECt97x/Sq1uKwBTjbldUt0AY5QMtK2PY=;
        b=AJbH7QOBwxIw/XhXo1Ya9Uz9YUvZf6SIN+lNN+itW/3n2IJVkG5ZPguNWpNtjjiy1/
         vCUY0FCsyif3Tbp5oenMPxK6mjdyYhQMNyMLKVK5mvzbTRYhaC8A7WjUZq2iEmASEbba
         q/OwTApDLaakrTDZN+zWWmpdv68U6WVjeyjnBzNqJoE38HZIMKoskEAcJuTZfn5iaZlP
         alXP2FUZS+FTQQGmNxU/2e8cFmPW0AycRZd85JOTCqQTJy0iUJHHywCxwxmjp89nnjN2
         QzZwriUukrWy1p17hUczJl0gezlyMGK98ZdKbh2HrdGbl4YpGASDPHRZRE8aPmBo/HtY
         BpfQ==
X-Gm-Message-State: AOAM533vJijNwBV7kHdaL2iTl0AeQ0Bao0VrRYquaVIL34GZVtg0H1Kd
        aDx/kMLI6AYlDgjG+umWhPjqusMHu5s=
X-Google-Smtp-Source: ABdhPJzXHuqgVKF7XVAn4Eelb/AbIgPKTe1ztf4N3IcjtqNX9HugJPXF/8yBV5n8Jjk/+lGctyzpXA==
X-Received: by 2002:a17:906:5a5c:b0:6cf:11a2:6b79 with SMTP id my28-20020a1709065a5c00b006cf11a26b79mr19432168ejc.602.1645537908497;
        Tue, 22 Feb 2022 05:51:48 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-065-014.77.3.pool.telefonica.de. [77.3.65.14])
        by smtp.gmail.com with ESMTPSA id eg42sm8266916edb.79.2022.02.22.05.51.47
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:51:48 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/4] newrole: check for crypt(3) failure
Date:   Tue, 22 Feb 2022 14:51:42 +0100
Message-Id: <20220222135143.30602-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222135143.30602-1-cgzones@googlemail.com>
References: <20220222135143.30602-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Depending on the implementation crypt(3) can fail either by returning
NULL, or returning a pointer to an invalid hash and setting errno.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/newrole/newrole.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index c9989863..781f99b6 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -368,9 +368,14 @@ static int authenticate_via_shadow_passwd(const char *uname)
 	}
 
 	/* Use crypt() to encrypt user's input password. */
+	errno = 0;
 	encrypted_password_s = crypt(unencrypted_password_s,
 				     p_shadow_line->sp_pwdp);
 	memset(unencrypted_password_s, 0, strlen(unencrypted_password_s));
+	if (errno || !encrypted_password_s) {
+		fprintf(stderr, _("Cannot encrypt password.\n"));
+		return 0;
+	}
 	return (!strcmp(encrypted_password_s, p_shadow_line->sp_pwdp));
 }
 #endif				/* if/else USE_PAM */
-- 
2.35.1

