Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888ECC433FE
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7045C61108
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbhKEPsw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhKEPso (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:44 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE4EC061208
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:46:04 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w1so34806122edd.10
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VXhXii7NYI14x1OOMpMPTCEKzbtSCi7j55DkhoF+Fhk=;
        b=Mo2iI+5D2D58nPJgJIURwSXEuDKMU48xigHSweMmrEfKeLJTIw6kklhssP2LAhCeJn
         tVCYdHMrYj58BVDDmK1mVNk9NMFnQnLS47A2hA1DIbXPhigi0xeGUMa8Ajh/pbfEdDnH
         FwmPXI7Y52fxwJ5yctvISxNH5HojdYBGArqbD0gSMkY8BalAh7ZEjNz42evfMXtIrNDu
         B8p8pLdqTZVQSv3NmWjiw27F02XG6Upg8Xe7pSD4WjbuIlzkqplIVFwK/aycv75WZmfu
         jZFTVXpRo6WpKvkd/0A7Uh3hh5eRiP5d0gHBwaBk4Ke7EaD9nCs0uMy5JI7ymNB1Pj9F
         5E+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VXhXii7NYI14x1OOMpMPTCEKzbtSCi7j55DkhoF+Fhk=;
        b=C7eD3Zw5F+q/0b6U+bKSkyjOXnvdp0Io3p1cl5M2gveXXmCt4WK03SVKiVe7hmDr/l
         PMY/IVxWnpbTBSdtl7CnguUsGE+zW7W1//tOwTrfXUMbVdwJNJwVGQyDvW1t349KPpRb
         EPPopSrHe3h18fS81vf/q+R+jNc6N+z/it0Dt4PU1ay5+fhacRzklskSKrzUgYQliHtF
         POx2HjP3eOS3AcRH2dA+3FpJY+Cz/lFydrdUkB4MVBCfwwwbjs2TXHqp3RDvmG8WaTCt
         C1c3W3XD0k677JwVqtt1ETQmJhuhyzwX26oT4JoSWp4sqm6mcnGY0izw7k13DM4JvrST
         sKGw==
X-Gm-Message-State: AOAM5327JrE49OzkAAgBT1P/EAQIgLHtA7xj8bREuiBwL94olrKg8ArF
        aOyk9UZqZvc+1RxSXSAHQSyMtb0SSAY=
X-Google-Smtp-Source: ABdhPJwakgHxy3SPWEnX9AKs9D5PF960F4yehl1nuK+9SHeobwszawK8RbEMQu545qPzy9eQs7YRaQ==
X-Received: by 2002:a50:950b:: with SMTP id u11mr79320711eda.121.1636127163255;
        Fri, 05 Nov 2021 08:46:03 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.46.02
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:46:02 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 27/36] libsepol: validate avtab and avrule types
Date:   Fri,  5 Nov 2021 16:45:29 +0100
Message-Id: <20211105154542.38434-28-cgzones@googlemail.com>
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

Check for invalid avtab or avrule types.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

---
v2:
   also check avrule types
---
 libsepol/src/policydb_validate.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 82193379..5ef95c61 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -483,6 +483,20 @@ static int validate_avtab_key(avtab_key_t *key, validate_t flavors[])
 		goto bad;
 	if (validate_value(key->target_class, &flavors[SYM_CLASSES]))
 		goto bad;
+	switch (0xFFF & key->specified) {
+	case AVTAB_ALLOWED:
+	case AVTAB_AUDITALLOW:
+	case AVTAB_AUDITDENY:
+	case AVTAB_XPERMS_ALLOWED:
+	case AVTAB_XPERMS_AUDITALLOW:
+	case AVTAB_XPERMS_DONTAUDIT:
+	case AVTAB_TRANSITION:
+	case AVTAB_MEMBER:
+	case AVTAB_CHANGE:
+		break;
+	default:
+		goto bad;
+	}
 
 	return 0;
 
@@ -536,6 +550,23 @@ static int validate_avrules(sepol_handle_t *handle, avrule_t *avrule, validate_t
 			if (validate_value(class->tclass, &flavors[SYM_CLASSES]))
 				goto bad;
 		}
+		switch(avrule->specified) {
+		case AVRULE_ALLOWED:
+		case AVRULE_AUDITALLOW:
+		case AVRULE_AUDITDENY:
+		case AVRULE_DONTAUDIT:
+		case AVRULE_NEVERALLOW:
+		case AVRULE_TRANSITION:
+		case AVRULE_MEMBER:
+		case AVRULE_CHANGE:
+		case AVRULE_XPERMS_ALLOWED:
+		case AVRULE_XPERMS_AUDITALLOW:
+		case AVRULE_XPERMS_DONTAUDIT:
+		case AVRULE_XPERMS_NEVERALLOW:
+			break;
+		default:
+			goto bad;
+		}
 	}
 
 	return 0;
-- 
2.33.1

