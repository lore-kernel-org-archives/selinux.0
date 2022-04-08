Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F6BC433FE
	for <selinux@archiver.kernel.org>; Fri,  8 Apr 2022 13:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbiDHNOR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Apr 2022 09:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236546AbiDHNNs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Apr 2022 09:13:48 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046CB2B7
        for <selinux@vger.kernel.org>; Fri,  8 Apr 2022 06:11:01 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id qh7so17181254ejb.11
        for <selinux@vger.kernel.org>; Fri, 08 Apr 2022 06:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BvIE2zMxG4NDtw8oQ0Xw4pNzLYEnSCR1iuxy9zpRYU4=;
        b=q2HnMbUFz3a9rFp6A3CV99b96T1q+bPcWeyucKTY3YlEcokWD2A6ND4a6h8pSl1OW6
         M3CKl2uRoMEwz+V508Sy28+rUw4JsGzEGiLZ54DSjGmIdZGVszwCrZ3h3VmX0q4434ex
         OSuokHrv7P7u+q5bObOesGHC4OIQrHkqaC+IEh+a6pSYf5y4hnUn0uyhJnk10r3Mesnm
         p5oKrAtAi7e9VUu7Nthh6QftyeU57iBtR4GUocJni4X0ss/JuwzbW0RWtJcA+zarDrWu
         xfXlaY7pzYfbl8anOhZ+7XNbewy39FQR0dRiS1ojKYbVq63lCGmGd4gpFF87guMnNPbL
         j9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BvIE2zMxG4NDtw8oQ0Xw4pNzLYEnSCR1iuxy9zpRYU4=;
        b=VB7B2mT0jw2p5u3uZYulBPudHnbY845ILMUg13v739mCNn+nGrHnlC1rPZk2nCk24L
         +iAWwiFZTTpLQvIYraixp5x9H3uRDGH2KrzAsiopoEFqaLyW2U2jghnfrn04zwWUQ9zZ
         z4RbT+oIxYA1x3+khk5vnPSKdMIsCNjizPCXj8y2FcfO5t0+7kjOCfpgKAHDyVnhkil2
         Z+1COkbvKmyvmuTKkFn7Fog535YA5+mYcAJIi4q7bbGqV5Rlp00JwKgoAH3vOl/6qd+i
         BDflK1U0BmkFkuNCjtS5XHpiX3qJAZbYT8oBT26iDYoUe6qyB+XMnt0OG7/UvAGSHJ2L
         /Psw==
X-Gm-Message-State: AOAM530Is9ACXHT3C2OG9soHR1UFmZ1sjVCw7TRiwJcI7Y6rBXR9DOQl
        vake/cDZhe9rrpXqVczjyvxQpCBet30=
X-Google-Smtp-Source: ABdhPJyifVO2oJgWSejAbEYm9pHQmzt8PWGn5h3p63h+ZtlbsS+GCs6Tbz10Q6lAhrBlPCwW27ssTA==
X-Received: by 2002:a17:906:6a1d:b0:6e8:4127:6bc3 with SMTP id qw29-20020a1709066a1d00b006e841276bc3mr5928574ejc.633.1649423459514;
        Fri, 08 Apr 2022 06:10:59 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-032-209.77.3.pool.telefonica.de. [77.3.32.209])
        by smtp.gmail.com with ESMTPSA id h26-20020a170906111a00b006e778bd4fc8sm6398601eja.38.2022.04.08.06.10.58
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 06:10:59 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/5] libsepol: drop unnecessary const discarding casts
Date:   Fri,  8 Apr 2022 15:10:52 +0200
Message-Id: <20220408131054.7957-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408131054.7957-1-cgzones@googlemail.com>
References: <20220408131054.7957-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

`hashtab_search()` takes a const_hashtab_key_t, alias `const char*` as
second key parameter type.  Do not unnecessarily cast variables of type
`const char*` to hashtab_key_t, alias `char*`.

    policydb.c: In function ‘policydb_string_to_security_class’:
    policydb.c:4164:39: warning: cast discards ‘const’ qualifier from pointer target type [-Wcast-qual]
     4164 |                                       (hashtab_key_t) class_name);
          |                                       ^
    policydb.c: In function ‘policydb_string_to_av_perm’:
    policydb.c:4184:25: warning: cast discards ‘const’ qualifier from pointer target type [-Wcast-qual]
     4184 |                         (hashtab_key_t)perm_name);
          |                         ^
    policydb.c:4193:25: warning: cast discards ‘const’ qualifier from pointer target type [-Wcast-qual]
     4193 |                         (hashtab_key_t)perm_name);
          |                         ^

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 5c7e35e8..0c71f09f 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -4160,7 +4160,7 @@ static sepol_security_class_t policydb_string_to_security_class(
 	class_datum_t *tclass_datum;
 
 	tclass_datum = hashtab_search(policydb->p_classes.table,
-				      (hashtab_key_t) class_name);
+				      class_name);
 	if (!tclass_datum)
 		return 0;
 	return tclass_datum->s.value;
@@ -4180,7 +4180,7 @@ static sepol_access_vector_t policydb_string_to_av_perm(
 
 	perm_datum = (perm_datum_t *)
 			hashtab_search(tclass_datum->permissions.table,
-			(hashtab_key_t)perm_name);
+			perm_name);
 	if (perm_datum != NULL)
 		return UINT32_C(1) << (perm_datum->s.value - 1);
 
@@ -4189,7 +4189,7 @@ static sepol_access_vector_t policydb_string_to_av_perm(
 
 	perm_datum = (perm_datum_t *)
 			hashtab_search(tclass_datum->comdatum->permissions.table,
-			(hashtab_key_t)perm_name);
+			perm_name);
 
 	if (perm_datum != NULL)
 		return UINT32_C(1) << (perm_datum->s.value - 1);
-- 
2.35.1

