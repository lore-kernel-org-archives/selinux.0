Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC1AC4332F
	for <selinux@archiver.kernel.org>; Wed,  1 Nov 2023 16:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjKAQhv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Nov 2023 12:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjKAQhv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Nov 2023 12:37:51 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFF210F
        for <selinux@vger.kernel.org>; Wed,  1 Nov 2023 09:37:44 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-540c54944c4so2193778a12.1
        for <selinux@vger.kernel.org>; Wed, 01 Nov 2023 09:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1698856662; x=1699461462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=e3CyZF/Yqm+Ug/c3vzKpkTYLHgr+AkOoKmF0nAdqqBI=;
        b=h7Ycq4Qtz8xqkEFlfR3PNCvM5kv8CVPv4xTizW52NXJAa9CwJ1IpLn02fVZvTg2MhQ
         ZtXodoH0PXiSASv0GeGdz0qJJCM3ZVB71+QmX1wZKHtkOgsDW2tXiiN/wRPw4FHqVnEY
         6KMSJHU2hiESKgm3SP5XNUw5/ZpwPSXNGqyKLH+r/G8z188ns7k1SSg1+OQHDO9AZzfK
         49Ic65No7TKAeGvtKqHnz8gi+j4XpL52T2RrtB+WYJajgdscjBKlT3dIW9HMBOaWPpKB
         NyDXARoSJxAIv5UKIHRMDleVOOO5/5VSuequuFLYYWEfxaroDZfAZ6XMSLMfsI+5OMMA
         iUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698856662; x=1699461462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3CyZF/Yqm+Ug/c3vzKpkTYLHgr+AkOoKmF0nAdqqBI=;
        b=utPHeiEL1hHXLdtN0jLHwJF4FnATnX0vWp1yk6qvekFoWgqZr5vfY1E69G+NV5Lr20
         4SUzICSIT5k7Y8KUgroRolCProLn/895zPjIhbPee2eYhDCjNma5N/FDwjZhebjtgODj
         Z8XACbdvRZx8yn72RSR5UIPLkU8j26MFR0Cg9AWTeUNfkRZfioEkK4CNK8cZ1UhePEQH
         KXTQ+dj4+bf8q4y9yeljWFuS8FvmUIccLy8xuNw9iLHUALotV1rmWLeYyDzUpcq63DcS
         Clur7949BlLBG3JJVAMLYl8gfmM10EnqkoHSHGZ6g1FzobJzJVOW2ZOvHgwrBs0JFEJP
         whRQ==
X-Gm-Message-State: AOJu0YxKltUpFO7G9rdgT2qR4lHjq0bUIjMI90zw7SyrlMUjFV4tDFne
        WCTc9NFSaZ7wzbNpuinXr+3p9V6oKKM=
X-Google-Smtp-Source: AGHT+IHzeGR2rYi33EPhUhvVdFoukupVsxiG2pUzJsHcBjq2tsm0VWyhaV8KlWrqfuXRaFkVRRAc1g==
X-Received: by 2002:a05:6402:2692:b0:53e:5c4d:ba15 with SMTP id w18-20020a056402269200b0053e5c4dba15mr3276363edd.8.1698856662364;
        Wed, 01 Nov 2023 09:37:42 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-116-163-023.95.116.pool.telefonica.de. [95.116.163.23])
        by smtp.gmail.com with ESMTPSA id 30-20020a50875e000000b0053e07fe8d98sm1275154edv.79.2023.11.01.09.37.41
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 09:37:42 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 1/2] libsepol: reject avtab entries with invalid specifier
Date:   Wed,  1 Nov 2023 17:37:24 +0100
Message-ID: <20231101163725.177237-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Neverallow avtab entries are not supported (normal and extended). Reject
them to avoid lookup confusions via avtab_search(), e.g. when searching
for a invalid key of AVTAB_TRANSITION|AVTAB_NEVERALLOW and the result of
only AVTAB_NEVERALLOW has no transition value.

Simplify the check for the number of specifiers by using the compiler
popcount builtin (already used in libsepol).

Reported-by: oss-fuzz (issue 60568), caused at the time by the filetrans
             prefix proposal
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
   rebase after revert of filename prefix proposal
---
 libsepol/src/avtab.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 6ab49c5e..1ef5ee00 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -441,7 +441,6 @@ int avtab_read_item(struct policy_file *fp, uint32_t vers, avtab_t * a,
 	avtab_key_t key;
 	avtab_datum_t datum;
 	avtab_extended_perms_t xperms;
-	unsigned set;
 	unsigned int i;
 	int rc;
 
@@ -535,13 +534,13 @@ int avtab_read_item(struct policy_file *fp, uint32_t vers, avtab_t * a,
 	key.target_class = le16_to_cpu(buf16[items++]);
 	key.specified = le16_to_cpu(buf16[items++]);
 
-	set = 0;
-	for (i = 0; i < ARRAY_SIZE(spec_order); i++) {
-		if (key.specified & spec_order[i])
-			set++;
+	if (key.specified & ~(AVTAB_AV | AVTAB_TYPE | AVTAB_XPERMS | AVTAB_ENABLED)) {
+		ERR(fp->handle, "invalid specifier");
+		return -1;
 	}
-	if (!set || set > 1) {
-		ERR(fp->handle, "more than one specifier");
+
+	if (__builtin_popcount(key.specified & ~AVTAB_ENABLED) != 1) {
+		ERR(fp->handle, "not exactly one specifier");
 		return -1;
 	}
 
-- 
2.42.0

