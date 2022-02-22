Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDD6C433EF
	for <selinux@archiver.kernel.org>; Tue, 22 Feb 2022 13:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiBVNzJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Feb 2022 08:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiBVNzJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Feb 2022 08:55:09 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805AC119411
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 05:54:43 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id d10so43153006eje.10
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 05:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GJVbpNI2CUbpr0oKChgmLgGjXwbhlKQVK6Hbhg0SoSE=;
        b=Yuv/sayGFRP7IfhovASACMkCwirGmXvfBX8esp5VrlfGHl5xGky3xQzMXvZdy2Mq4g
         fy6N7kPZ/o1l4+GvXLmu20RYtMRvwmF37HXJ+hTH42rEpHwqVee/0a3Mb0tcel7576zS
         hFygyAIyujJXKW4Zz2lkSuuR3YhY+s6rW2wiyAGmif2syN+NRreJLghB8BFeIBhQX+zP
         Tor94/DMm1HfNoeFTT92iIFcZvcSrH6tkek89l/rfT3VajLJeeoebDLWLNphkF9jSnZK
         UyMboQVvDSDmWSHyN2HNW+nAP+O7V72nO/u3KTgvEO8NjhJsT4eCVGW2znQB5v95VFqu
         lQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GJVbpNI2CUbpr0oKChgmLgGjXwbhlKQVK6Hbhg0SoSE=;
        b=S5NO0CI0qw/CcN4wKuYIuXf6IRQdY2BeOn/EJolnukvBiywd7s3yzQ+oJRXPvfxB9X
         9JWVkAb67QZ6KLBonzQVNbSHfFWsVPcYobJDH242WQaxVpoSRYAZj4es3igaqdwPqtpE
         sQ9MR6pBpVa8KCDrX24/L5QNChSkhJpNrGntT+51411FC0Z3kre5lY9iRUEcXekO3ai/
         9rbDqVVb1/7IKz+UTqRYbws6sDipRSydfhgOwHCoFwYovnfIM715ume7e0UpDcvlcT9r
         mZ97v+i6tuewxMEE+0QN11xWTnkOtmFqcrNc9bXksLhZrn7HAk9H/MgA3dT+rPb4pHLM
         9Dug==
X-Gm-Message-State: AOAM530cQz6ftsykdNKYODnVlVKFRvqa0aStFj9Z21I3Wr20Eke+Eihb
        JZPUf93svoWrvkTyPp8pB3JFZ0dZkgM=
X-Google-Smtp-Source: ABdhPJz8zLmCE3GHfo7XxXgqfIWfWvx4gozU5nXeeHAiX1xlilPQrMSmda8dXHx3gVVQOQeXVJ0bBQ==
X-Received: by 2002:a17:906:5e13:b0:6cf:42c:56b7 with SMTP id n19-20020a1709065e1300b006cf042c56b7mr19578796eju.725.1645538082037;
        Tue, 22 Feb 2022 05:54:42 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-065-014.77.3.pool.telefonica.de. [77.3.65.14])
        by smtp.gmail.com with ESMTPSA id l13sm4688424edr.61.2022.02.22.05.54.41
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:54:41 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 2/4] libsepol: introduce sepol_const_security_context_t typedef
Date:   Tue, 22 Feb 2022 14:54:33 +0100
Message-Id: <20220222135435.31216-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222135435.31216-1-cgzones@googlemail.com>
References: <20220204133507.26977-1-cgzones@googlemail.com>
 <20220222135435.31216-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The typedef `sepol_security_context_t` is used for contexts.  For the
read-only input parameter in `sepol_context_to_sid()`
`const sepol_security_context_t` is used as type, which does not expand
to the expected `const char*` but `char *const`.

Introduce a corresponding typedef for `const char*`.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/include/sepol/policydb/flask_types.h | 1 +
 libsepol/include/sepol/policydb/services.h    | 2 +-
 libsepol/src/context.c                        | 2 +-
 libsepol/src/services.c                       | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/libsepol/include/sepol/policydb/flask_types.h b/libsepol/include/sepol/policydb/flask_types.h
index 7bec5129..02c22eac 100644
--- a/libsepol/include/sepol/policydb/flask_types.h
+++ b/libsepol/include/sepol/policydb/flask_types.h
@@ -27,6 +27,7 @@ extern "C" {
  * understanding of the security policy.
  */
 typedef char *sepol_security_context_t;
+typedef const char *sepol_const_security_context_t;
 
 /*
  * An access vector (AV) is a collection of related permissions
diff --git a/libsepol/include/sepol/policydb/services.h b/libsepol/include/sepol/policydb/services.h
index 44de3863..bcb0930f 100644
--- a/libsepol/include/sepol/policydb/services.h
+++ b/libsepol/include/sepol/policydb/services.h
@@ -155,7 +155,7 @@ extern int sepol_sid_to_context(sepol_security_id_t sid,	/* IN */
  * Return a SID associated with the security context that
  * has the string representation specified by `scontext'.
  */
-extern int sepol_context_to_sid(const sepol_security_context_t scontext,	/* IN */
+extern int sepol_context_to_sid(sepol_const_security_context_t scontext,	/* IN */
 				size_t scontext_len,	/* IN */
 				sepol_security_id_t * out_sid);	/* OUT */
 
diff --git a/libsepol/src/context.c b/libsepol/src/context.c
index e81b28c6..5cc90afb 100644
--- a/libsepol/src/context.c
+++ b/libsepol/src/context.c
@@ -22,7 +22,7 @@ int policydb_context_isvalid(const policydb_t * p, const context_struct_t * c)
 int sepol_check_context(const char *context)
 {
 
-	return sepol_context_to_sid((const sepol_security_context_t)context,
+	return sepol_context_to_sid(context,
 				    strlen(context) + 1, NULL);
 }
 
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index b2fb804e..c3897c91 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -1269,7 +1269,7 @@ int sepol_sid_to_context(sepol_security_id_t sid,
  * Return a SID associated with the security context that
  * has the string representation specified by `scontext'.
  */
-int sepol_context_to_sid(const sepol_security_context_t scontext,
+int sepol_context_to_sid(sepol_const_security_context_t scontext,
 				size_t scontext_len, sepol_security_id_t * sid)
 {
 
-- 
2.35.1

