Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68836C433F5
	for <selinux@archiver.kernel.org>; Tue, 22 Feb 2022 13:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiBVNzI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Feb 2022 08:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiBVNzI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Feb 2022 08:55:08 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE04C117C9B
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 05:54:42 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id p9so43182825ejd.6
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 05:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kIoRwgmVgKQy25Inw+UMQd/SObWedY+q5OKWEnnmw3M=;
        b=Zo3VL/f3Cd4mg701y4asaFAc/GYvw52E7LjsalCkEQ0FnJQGeeR1T+M5DaoczMVD8o
         5QaqMQZdVF8cTbs59DQ9yy+ixU69+nt+/NuDSR0f9nIZ6aERcJEQIdGPVzjMeHZtHWHJ
         ldRVbq6jehupI1GtKyKuqLW4xKpA4F0KFew8SMa8+4LpoTDyA8DnA4Dfh1YH8V3ee5YG
         vDYPbLnylkjFVokoUfHGwxIZgAluO8L2T59yRTJVZQfc6PBRXxtxwq+miI4Zo8CZQI5h
         kUW3WZWmfVnTPxBWKQuprrqB0AF/Hkziyalqzm1CqLzTaKqq3YC30BswidTghBffMUpF
         0tOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kIoRwgmVgKQy25Inw+UMQd/SObWedY+q5OKWEnnmw3M=;
        b=EjvIOHMuZV54HpRjRvACNaHl5ZWVZ9UpLORhtu36Zaq1aCv2If1u1u3hMjjKkHEPje
         5ASyxcApjVyG+D7DDZ6gdOtb2TDUV2izuLv1wAkSLTSoyXBviZK89cTSiTHt67unKcHO
         ysQZ4/4d4iAb1Qjiyii2j1Aqau9J/7CZL8FMnOynfKFcqldCzaj9FltxPi2tJq5hYS36
         T7hCzryx0YLX0hxeFgkpX/8C3bGdMB3zgVRkotUmW5EIijyu2vAu1dfSlB42RK6M6zJn
         6A9TpL9/L5aKi+LR10UoP6WtcempuuviR1wBNZEjh05v4HesyzaA7oxZYRyUu+wiS7Py
         lK/w==
X-Gm-Message-State: AOAM5321d8rKywAeGG1Hb9P2j61iubCXGlIKYeS9YfruvUVcSxeve+DH
        sgzz0JafGw3hEsTApho4soMGJNHgwLk=
X-Google-Smtp-Source: ABdhPJwS5ycb1UfOpaomS6Y5yvy56JPlB+XlxiCeJus3V5H+Z8pb1FVXAfg7NkLWUGwySmfi/jrEoA==
X-Received: by 2002:a17:906:d8d2:b0:6cf:6273:9c37 with SMTP id re18-20020a170906d8d200b006cf62739c37mr20562473ejb.727.1645538081244;
        Tue, 22 Feb 2022 05:54:41 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-065-014.77.3.pool.telefonica.de. [77.3.65.14])
        by smtp.gmail.com with ESMTPSA id l13sm4688424edr.61.2022.02.22.05.54.40
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:54:40 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 1/4] libsepol: add sepol_av_perm_to_string
Date:   Tue, 22 Feb 2022 14:54:32 +0100
Message-Id: <20220222135435.31216-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220204133507.26977-1-cgzones@googlemail.com>
References: <20220204133507.26977-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a wrapper around the utility function sepol_av_to_string() on the
service internal policy.  This allows callers to convert a permission
bit set into a string representation without access to the internal
policy structure.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/include/sepol/policydb/services.h | 9 +++++++++
 libsepol/src/services.c                    | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/libsepol/include/sepol/policydb/services.h b/libsepol/include/sepol/policydb/services.h
index 048f8a5a..44de3863 100644
--- a/libsepol/include/sepol/policydb/services.h
+++ b/libsepol/include/sepol/policydb/services.h
@@ -103,6 +103,15 @@ extern int sepol_string_to_av_perm(sepol_security_class_t tclass,
 					const char *perm_name,
 					sepol_access_vector_t *av);
 
+/*
+ * Return a string representation of the permission av bit associated with
+ * tclass.
+ * Returns a pointer to an internal buffer, overridden by the next call to
+ * this function or sepol_av_to_string().
+ */
+ extern const char *sepol_av_perm_to_string(sepol_security_class_t tclass,
+					sepol_access_vector_t av);
+
 /*
  * Compute a SID to use for labeling a new object in the 
  * class `tclass' based on a SID pair.  
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 7becfd1b..b2fb804e 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -1233,6 +1233,12 @@ out:
 	return STATUS_ERR;
 }
 
+ const char *sepol_av_perm_to_string(sepol_security_class_t tclass,
+					sepol_access_vector_t av)
+{
+	return sepol_av_to_string(policydb, tclass, av);
+}
+
 /*
  * Write the security context string representation of 
  * the context associated with `sid' into a dynamically
-- 
2.35.1

