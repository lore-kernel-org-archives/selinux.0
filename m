Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D46C4167D
	for <selinux@archiver.kernel.org>; Fri,  3 Nov 2023 18:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjKCS1H (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Nov 2023 14:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbjKCS1F (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Nov 2023 14:27:05 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D972D78
        for <selinux@vger.kernel.org>; Fri,  3 Nov 2023 11:26:44 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so3963275a12.2
        for <selinux@vger.kernel.org>; Fri, 03 Nov 2023 11:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1699036003; x=1699640803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GI6urP8avQHI9OnbekJVeVyZjxhxcug7LrgeMj4M0W8=;
        b=ku8lcThRL99sdz4attBOYgbiQh22ZR5MOmtsKlyfmS0DooJDf20RHdvDOVfiQXxeFu
         wfmFpMCdA/0xfTNhHEH5DBz0FcXP8N5FsajiEJGFG26nudM4XBejEsSrx14OX53Zothc
         X0LsxCF2bXGD7lQMENBjL2u/Fw8EP4E+WQcKaweahTAYnGau40w78mfXl6fRnhqaxzxm
         TzKQINmWs/iLyyFWFD7DjXT/9a3vkQvbCsVQDfD2p9P4claOhLsqQ+14H5271RB14XeF
         UgTFRWOvOMgMDYP7sFYyb5oJTDsJQq5Wu4bJ3yiwByGqbkuHJ+hDzaUyMMl39MokJck+
         fylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699036003; x=1699640803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GI6urP8avQHI9OnbekJVeVyZjxhxcug7LrgeMj4M0W8=;
        b=BqxeXYY3I4iEZACm8ZiVKaH0XzZFzZdtA+OUMdkggaSnh2SlvkaMYU0uAvRGmC9yE5
         T9NAGbZ3I0KInqKZwblQIcjWkBUXDUUwnUTZQp0MlK84dMi5s0lU1Xx/CfCEOlB2sW/L
         sSqL246Tbrmu/ZBTNb/UjbEI+guBnh78mXUD1FPBdbmckJUjGrPHFO2v9IG2Rolwegd4
         xcs4mTkno86UVoevtsBMstvQlrdLlggVMz9trqiKfowK+3MGjlweslcP9GuiENO8tb6Q
         EsppcmGQKR2nbQWGmVC606a7rW7+uHqHaNBdkavOAz5YfqhQWcFzvF1GCwFA4pItqE0b
         sXPA==
X-Gm-Message-State: AOJu0YwAKDkxPUPebOwsbed85tHkZxGVU1RmSL3i9iFqlySqlREGs7pi
        kuXxB/RKlLrPhGpouQ/R+aBU6U4k/+4=
X-Google-Smtp-Source: AGHT+IFNYA/g/IL6gtXnN9/G26R8e1MoFiQ2Y41S5eIENLiOTI1cL0/Z9h6SZgeJexPRijKYWWNGYA==
X-Received: by 2002:a50:c351:0:b0:543:7256:6370 with SMTP id q17-20020a50c351000000b0054372566370mr9693208edb.23.1699036002789;
        Fri, 03 Nov 2023 11:26:42 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-003-098-230.77.3.pool.telefonica.de. [77.3.98.230])
        by smtp.gmail.com with ESMTPSA id v10-20020aa7dbca000000b0052ff9bae873sm1210275edt.5.2023.11.03.11.26.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 11:26:42 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 1/3] libsepol: validate default type of transition is not an attribute
Date:   Fri,  3 Nov 2023 19:26:35 +0100
Message-ID: <20231103182637.85003-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The default type of a type transition must be a regular type, not an
attribute.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  fix build error by supplying necessary arguments to
  validate_simpletype()
---
 libsepol/src/policydb_validate.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 892a0ffd..810c3263 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -468,7 +468,7 @@ static int validate_role_datum_wrapper(__attribute__((unused)) hashtab_key_t k,
 	return validate_role_datum(margs->handle, d, margs->flavors);
 }
 
-static int validate_simpletype(uint32_t value, const policydb_t *p, validate_t flavors[])
+static int validate_simpletype(uint32_t value, const policydb_t *p, const validate_t flavors[SYM_NUM])
 {
 	const type_datum_t *type;
 
@@ -1094,7 +1094,9 @@ static int validate_filename_trans(hashtab_key_t k, hashtab_datum_t d, void *arg
 {
 	const filename_trans_key_t *ftk = (filename_trans_key_t *)k;
 	const filename_trans_datum_t *ftd = d;
-	validate_t *flavors = (validate_t *)args;
+	const map_arg_t *margs = args;
+	const validate_t *flavors = margs->flavors;
+	const policydb_t *p = margs->policy;
 
 	if (validate_value(ftk->ttype, &flavors[SYM_TYPES]))
 		goto bad;
@@ -1105,7 +1107,7 @@ static int validate_filename_trans(hashtab_key_t k, hashtab_datum_t d, void *arg
 	for (; ftd; ftd = ftd->next) {
 		if (validate_ebitmap(&ftd->stypes, &flavors[SYM_TYPES]))
 			goto bad;
-		if (validate_value(ftd->otype, &flavors[SYM_TYPES]))
+		if (validate_simpletype(ftd->otype, p, flavors))
 			goto bad;
 	}
 
@@ -1115,9 +1117,11 @@ bad:
 	return -1;
 }
 
-static int validate_filename_trans_hashtab(sepol_handle_t *handle, hashtab_t filename_trans, validate_t flavors[])
+static int validate_filename_trans_hashtab(sepol_handle_t *handle, const policydb_t *p, validate_t flavors[])
 {
-	if (hashtab_map(filename_trans, validate_filename_trans, flavors)) {
+	map_arg_t margs = { flavors, handle, p };
+
+	if (hashtab_map(p->filename_trans, validate_filename_trans, &margs)) {
 		ERR(handle, "Invalid filename trans");
 		return -1;
 	}
@@ -1555,7 +1559,7 @@ int policydb_validate(sepol_handle_t *handle, const policydb_t *p)
 		if (validate_role_allows(handle, p->role_allow, flavors))
 			goto bad;
 		if (p->policyvers >= POLICYDB_VERSION_FILENAME_TRANS)
-			if (validate_filename_trans_hashtab(handle, p->filename_trans, flavors))
+			if (validate_filename_trans_hashtab(handle, p, flavors))
 				goto bad;
 	} else {
 		if (validate_avrule_blocks(handle, p->global, p, flavors))
-- 
2.42.0

