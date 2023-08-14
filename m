Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD1CC07E8F
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjHNNVU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjHNNU6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:20:58 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CD51715
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:50 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99d937b83efso237416266b.3
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692019249; x=1692624049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFHeKtuzr80FElLaFbiAjddhDdkcDaWlinC+MHI3t3U=;
        b=gQm/T/R+haoBWmCpMBGCq3kZiBZEM4pT9bkHOpeLjL+kHP8+r2HimV4BjRmMrHAAu4
         izdBLUPwYdF1t5W8TOlGTzyWS+J3L2nCiDlXdaGPl3Pz0xa2QIntRyuh/VGAbDmPJCcr
         OBlbPfcWCH7TROl9PGsX0tz1lQisXF1RJd8Cp/Pbh/6cy1FkLrePjOpHM2AMlehss7D1
         smfsBogrCQnTv/QuQZwJZvnTOomNI12Awz4+pKUePhoIFiN6IaBbc8mekUrqqbJ8RTZ5
         SXw/BLL+UvxG5GX9g16dmPTpfyKCWKC2n0EEiH0N2LRtqU1t5Hv337pMYEn8ZfJWXPWM
         UTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019249; x=1692624049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFHeKtuzr80FElLaFbiAjddhDdkcDaWlinC+MHI3t3U=;
        b=JHuN5acYRAAFf+L8fwLJB9zGMM5k/4/CU8FfHTbH/f3kK0ADD0hoPVFXSP7nFT2C/3
         p3N4Or/lvu1l+pMjM5C5B6p0HluBYLXBP7JxUIJOFy0iOGerv14Z6OgY6m+sokz3yG69
         6XiX5UCQaOgcVg2m5YzCoDEz0D92aJ0nyZrmhUFVFYM0g3zjeq2/hiBDlk4dKyu/ACYB
         ksAMMSh2XWi3C+0aVFW7LST0lLWmZOGaDlUqOk7Mhvg2ROH7/npKElk1JXffbKMrKWhZ
         qtassdUwZVpPIQ84Mw5TysQRPpQP5mf7Etpbm5d9sCkYNYNU9cuYxMLEj+yGG3aWLQky
         3piQ==
X-Gm-Message-State: AOJu0YywUHbANF+updnS71opaX84eOTTMqCvtQmE2+c8pfinMygWS7ob
        kG3bb3YtTQ2c1Low2/mJJtYPXWhPM+jS+ei6Lu8=
X-Google-Smtp-Source: AGHT+IGN3AjW7wWtjcSl1X+zBlHnGgctAJp/Ze9G9zhkkOBwFbGSJFEarScFPXq6uybpRddXw2t2Gg==
X-Received: by 2002:a17:906:76d3:b0:99b:4fff:6bb with SMTP id q19-20020a17090676d300b0099b4fff06bbmr8358470ejn.4.1692019248665;
        Mon, 14 Aug 2023 06:20:48 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-167-009.95.112.pool.telefonica.de. [95.112.167.9])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5683541ejb.103.2023.08.14.06.20.48
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:20:48 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 15/27] libselinux/utils: use correct type for backend argument
Date:   Mon, 14 Aug 2023 15:20:13 +0200
Message-Id: <20230814132025.45364-16-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814132025.45364-1-cgzones@googlemail.com>
References: <20230814132025.45364-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

selabel_open(3) expects the backend to be of type unsigned int.

Also initialize with a macro flag instead raw 0.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/selabel_digest.c | 3 ++-
 libselinux/utils/selabel_lookup.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/libselinux/utils/selabel_digest.c b/libselinux/utils/selabel_digest.c
index 6a8313a2..bf22b472 100644
--- a/libselinux/utils/selabel_digest.c
+++ b/libselinux/utils/selabel_digest.c
@@ -59,7 +59,8 @@ static int run_check_digest(char *cmd, char *selabel_digest)
 
 int main(int argc, char **argv)
 {
-	int backend = 0, rc, opt, validate = 0;
+	unsigned int backend = SELABEL_CTX_FILE;
+	int rc, opt, validate = 0;
 	char *baseonly = NULL, *file = NULL, *digest = (char *)1;
 	char **specfiles = NULL;
 	unsigned char *sha1_digest = NULL;
diff --git a/libselinux/utils/selabel_lookup.c b/libselinux/utils/selabel_lookup.c
index 112ffda1..5dc32548 100644
--- a/libselinux/utils/selabel_lookup.c
+++ b/libselinux/utils/selabel_lookup.c
@@ -32,7 +32,8 @@ static __attribute__ ((__noreturn__)) void usage(const char *progname)
 
 int main(int argc, char **argv)
 {
-	int raw = 0, type = 0, backend = 0, rc, opt;
+	int raw = 0, type = 0, rc, opt;
+	unsigned int backend = SELABEL_CTX_FILE;
 	char *validate = NULL, *key = NULL, *context = NULL, *file = NULL;
 
 	struct selabel_handle *hnd;
-- 
2.40.1

