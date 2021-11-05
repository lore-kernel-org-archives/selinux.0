Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0325BC433F5
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E35C961183
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbhKEPsz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbhKEPst (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:49 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E12C06120C
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:46:09 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w1so34807137edd.10
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lDrA8BJbz2yokQyMSFSVlfVGj1rE2IL0NV6E3IrYlnI=;
        b=N9n26k5v7kcdlDHMNWDicshziVVjTmXTjbsstD66b7U6kY5yLOYHUrReS4R8v37maT
         GYh58WzMa16TS53ZyqvEVWR0MkeHZBV/eZBi0dTjvXOwTKIb1A1+eW4xOIc1EmL1UMuW
         XzSkLS0pA8cnpT0YE97LA8jLa9oMLtOvgXuiSI3RsV/m9uBl6zDRP70iSmT6XJ7zl4RZ
         R7xWmaHNx9ZNBGxTdkKwPbkcfZvpGCQ70AOFwsTdD+5tahcDid9S9j4+sh7lyp4KjQPy
         WFpPpwE6YUdhZ4e4cHVjr68rv04j3s40Ao+xBLHLyNBpwSgW8AYU4rCHQ6ZqIwWrbBGt
         KKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lDrA8BJbz2yokQyMSFSVlfVGj1rE2IL0NV6E3IrYlnI=;
        b=MJKY4B7XKcFKbGM4vh45jADgAQKfr41f7jtkOOQrqTNaHuDqFdBBnCrYlUDGrviZCK
         haMZtvXCVB3k6YFgEYRpqa9jIP95KwUcFJ4f+rPmqohd/KFab56UT260gY4HynxDlteA
         heZG3CbSSQchAMm5P6jr38NMPOtDLAi7MujLCw3+HmYmsU6lvFuqDyYvpNRzoP4UTnkk
         4tM7sgh/juEr1ZzLhJUnrXILXP2/9OQXqGjr3HmOeVd5ac1i9fBBFWI9aN/rhetd07Ez
         H6fXad9dsJkApusD/VE7BCTzsPcwB+xXTcTcEz6cECE4boeAygWiobdZ55Tlo8y207+L
         Y88Q==
X-Gm-Message-State: AOAM5317yB2a5r69ToMLppJOsHEZl1rkr5vTLHnHXcNQGVLR46nYyXMP
        d/iUGDxXyWTiJOPhVJ0AIuXOPe/dehc=
X-Google-Smtp-Source: ABdhPJynP4yshkbe3MWhGbB9pLhLruY3Tec1X8R+2fM/9ff6YE9RXoZRVYdh0ttJsZ0MMv5Q6VUIZg==
X-Received: by 2002:a17:907:6d05:: with SMTP id sa5mr60492545ejc.246.1636127168426;
        Fri, 05 Nov 2021 08:46:08 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.46.07
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:46:08 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 36/36] libsepol: validate class default targets
Date:   Fri,  5 Nov 2021 16:45:38 +0100
Message-Id: <20211105154542.38434-37-cgzones@googlemail.com>
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

Check the class default targets are valid values, e.g. source or target
for user, role and type.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

---
v2:
   do not reject in binary reading, but check at validation step
---
 libsepol/src/policydb_validate.c | 41 ++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 1c5ca0dd..b7868fbe 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -258,6 +258,47 @@ static int validate_class_datum(sepol_handle_t *handle, class_datum_t *class, va
 	if (class->permissions.nprim > PERM_SYMTAB_SIZE)
 		goto bad;
 
+	switch (class->default_user) {
+	case 0:
+	case DEFAULT_SOURCE:
+	case DEFAULT_TARGET:
+		break;
+	default:
+		goto bad;
+	}
+
+	switch (class->default_role) {
+	case 0:
+	case DEFAULT_SOURCE:
+	case DEFAULT_TARGET:
+		break;
+	default:
+		goto bad;
+	}
+
+	switch (class->default_type) {
+	case 0:
+	case DEFAULT_SOURCE:
+	case DEFAULT_TARGET:
+		break;
+	default:
+		goto bad;
+	}
+
+	switch (class->default_range) {
+	case 0:
+	case DEFAULT_SOURCE_LOW:
+	case DEFAULT_SOURCE_HIGH:
+	case DEFAULT_SOURCE_LOW_HIGH:
+	case DEFAULT_TARGET_LOW:
+	case DEFAULT_TARGET_HIGH:
+	case DEFAULT_TARGET_LOW_HIGH:
+	case DEFAULT_GLBLUB:
+		break;
+	default:
+		goto bad;
+	}
+
 	return 0;
 
 bad:
-- 
2.33.1

