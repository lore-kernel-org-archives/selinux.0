Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3BEC433FE
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240919AbhLIQz1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241344AbhLIQzZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:55:25 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3A6C0617A1
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:51:52 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id l25so21583282eda.11
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nVqp5+GuCpdaftoACIfFQheU6JbiNZHa+oXybl1CUu4=;
        b=ZvcEpexAlepTBV1CfyeS04bbtSwEC4pZa4roV6m/rf80Z82FuMvSjeyGtBeZwQC0GI
         favACExiqgp+i4Os3hPf8XfpCOMGI0j15VN226lq5kNzGTUOMCKiSEOWVRDwTICGdc0f
         3ClHHzuzbCNKQggb1TrBAbJj8uudISs/U/iEyGJGH7+nwinv6DMy2y4EvsuJrr9aI9h7
         pTt8EphiEv5k1R1JADrKIHtIbG90RmBrk5ZHZRP9qu9do2YkkbdEBqlDpp928ovnrXDg
         75vRqTnlNS+9JdzdW5L3DKYPuJAvW/ebN6LE2fRcqWDtVuXd4qDQz/ocu4K5fe7FWmxF
         0RZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nVqp5+GuCpdaftoACIfFQheU6JbiNZHa+oXybl1CUu4=;
        b=uSDwRcaukUbUnTsvqs6Up9Sgr89E3kCpu0ulK6ADaYd2EuCzbEdMEzn6TE3oka9CF5
         b7b7ZW8qczid+/vxhthGol53r9Wz5Fsfb4Gl6HkkpnQ+V03ys3uf+nQ3bKdG3a+1ucGm
         SrKvW6geJeD6XcMPbG02KrCubZ5N0H7DsgBWbcaA9E2r1RNNaHQvisKM3D1yVdrx4ZfZ
         JTyqf991SUZiEXiz45ON3lmUKYbVGNqQV1+AI+uyCvyXC2jSNqA3bOL6BTX8YIEw0b+A
         dXOjaVh5r7pLgWhOz31PcdIglHCCtKrcSEl0+/HjdjURZCs8XVVaOzQ5JBjkpxdTGB26
         PpjQ==
X-Gm-Message-State: AOAM531ewDibsFU4whuAOlz5hswvGOaFBk//8t6u5m+iwRaRn2Mkcyau
        fvKF8w62ABXG8V8blXkf42tVyb7vKcw=
X-Google-Smtp-Source: ABdhPJzu6pa8ZWn8E7Hc1uK6qlX8TQ3o67AXt0+n8b2jfzV6zgyU1ImploLxyv8ZDfSIFaA/ZJLs5g==
X-Received: by 2002:a17:906:f43:: with SMTP id h3mr17016266ejj.414.1639068600236;
        Thu, 09 Dec 2021 08:50:00 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.59
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:59 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 36/36] libsepol: validate class default targets
Date:   Thu,  9 Dec 2021 17:49:28 +0100
Message-Id: <20211209164928.87459-37-cgzones@googlemail.com>
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
index b2d0e5e5..0650f4d1 100644
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
2.34.1

