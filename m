Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA2EC433F5
	for <selinux@archiver.kernel.org>; Fri,  4 Feb 2022 13:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiBDNfQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Feb 2022 08:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiBDNfP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Feb 2022 08:35:15 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D12DC061714
        for <selinux@vger.kernel.org>; Fri,  4 Feb 2022 05:35:15 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ka4so19432666ejc.11
        for <selinux@vger.kernel.org>; Fri, 04 Feb 2022 05:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VS3WU+gwrpSSJMt/mqjUmdPFw8EiSqjTpyodisihBEo=;
        b=B0Gvuprj8gtRAvBJYl6AydPLa/fUS7HdGYGV17xU3sR5TTAXTMF1BYtYoyJAuJfVio
         SQILPMkrU2ESNuiNYFnvNh9AqpvVpcQTH01HCDSyp2sj/yYEekVlY+xqt30Vmpqezy4h
         7l6rz6yCCzg3m/9kE7k3MVtoIrAzKc46lvAFvsaMN7IJcnYMU2hkZPn1OoROhJr89UMz
         bunLzwbSrVXsQi5R1t1b23XDoWJT5gPsm7cfUjSVAt3D20HVyQgf1k7AmfJxcBgKZ659
         2NZE4Z9CyFHtparXxpgoaxb8uq6oCgREhQLD6+yGsebsgQdG8YwbembLa/FZ5kXX0ADK
         qHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VS3WU+gwrpSSJMt/mqjUmdPFw8EiSqjTpyodisihBEo=;
        b=YGrekwrEoAVFdJxYMEvJ0aSJCzcCWpcIoB2vlNLfiPkpAvDEkYwXHQVvUTbBKOOWp4
         kRttYSHZrcgMEmKjY2Ob/OrKZWUk3yOHuO9SBmXzt2FMXFy5AGQIBoJ5fedAK3zkIsm6
         u69BJlD9MRk1xBC/MSQWp9HfRC9R257qfD824HJkGBut9eoIXhNsnKZcj1GqmTFjUa1W
         2XcUyRNN3M09TKDRVkcPW3J0fYY31GK4D57UzwmyHMXtqrRQ/6YtefQEcZhnvlIU+eVS
         vUtG500NVBMau30EyIlmb9kM0mHYFMYJno4g7ajkpxDMNtWAY/ssRz/i2CbwKmzJ+WTH
         bHEg==
X-Gm-Message-State: AOAM5305LecrAojPUT7u+78aiil4xhDfKuzKLp7D7kUpFu8RfAIt72IT
        ckRwQFZfUkrlntfY1nLF6TM9NC46v5I=
X-Google-Smtp-Source: ABdhPJwTGK5mnhxvcqnviakxTWcKp3nn7++s5+gH+T8Dsv/rIB0FIUgICABUhZnqMVTHuY5TjAOzgg==
X-Received: by 2002:a17:906:4fd6:: with SMTP id i22mr2553194ejw.502.1643981714131;
        Fri, 04 Feb 2022 05:35:14 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-008-249-090.77.8.pool.telefonica.de. [77.8.249.90])
        by smtp.gmail.com with ESMTPSA id m13sm664662eja.160.2022.02.04.05.35.13
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:35:13 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] libsepol: add sepol_av_perm_to_string
Date:   Fri,  4 Feb 2022 14:35:06 +0100
Message-Id: <20220204133507.26977-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
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
2.34.1

