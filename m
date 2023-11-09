Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D65C41535
	for <selinux@archiver.kernel.org>; Thu,  9 Nov 2023 13:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjKINve (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Nov 2023 08:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjKINvc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Nov 2023 08:51:32 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472AE2D65
        for <selinux@vger.kernel.org>; Thu,  9 Nov 2023 05:51:30 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9e4675c7a5fso145276466b.0
        for <selinux@vger.kernel.org>; Thu, 09 Nov 2023 05:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1699537889; x=1700142689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rXM1yzHhZfeCdqppdDUd/j5PIuOJdhbrlyNG9DBRlX4=;
        b=DuqYcwiPRNfJvYEfjCHt/uYjb1kZIlxZY63I+nCW6Sf/+QGmHaKpE+LWUMSzJuN63d
         Ls8NJ3KjERpxZEHjDDYvr/kLjZXDvLScxzpzrczvsnn9MWhmfgIrQXwsxobe7a2vmVcs
         Mkne8iQklAuAh/hXN42fO+jY90658hqshgWETE0vzgEfoA8IuJxlOUR4uuQ44p6/GbpV
         TnXC9vVMMrzhVToCP/Cw6OHXQN2vbDe5ThzlJPH5BJhFI4yuBg/aGAxMfHtW2/Vr9vn+
         92qGH83lNtKPD7LqIxoMU6wuMwcd5WErs88O4vzxL00dQpNY7l1YpnAAk8B5FH2q63Xc
         2G5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699537889; x=1700142689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXM1yzHhZfeCdqppdDUd/j5PIuOJdhbrlyNG9DBRlX4=;
        b=aKAegxrPRiM4KDpzPu5smba9h5+0x4f34YbPY8qFJzA8i/qMRj/5mYGfPea1PATFhh
         abvwA7PZAbxia/9adpgeWNOgKLgl4DUeJWixalI5Jmt6shWf1bpTzQ49e4S8Z3DYKttG
         m7ZTcSfh1W5M96ee/431Cgj/I2tdDW25b3tZjqCJpUgzQbzpnNgp03KHQIo6AFAPgwti
         ADCnusgs9WvEZSkVdgelOmTtatVycu2KlTVKm0hdH05th9NZ8EivvClfKDSucHKBxGcR
         JwbS3+HYaDjnyCphIoaWqLBFm/ODnvMoH9i7PDym0Z1wy/mdZz1qaZqg4qN4AF59qMy7
         5lSA==
X-Gm-Message-State: AOJu0YxbzF9ykH1/J/l/FandK8JjdPhsUm6g68JD7tdwS52EFiQzoPby
        tHpzSFslNmQQNkKs5sIsMKIMyVxDkXw=
X-Google-Smtp-Source: AGHT+IGvXugR9bf2utR7Zm+APQOtDKnP3AzIGTEEAlZN2TRiCriuWlBFnHEUGn+PnvJo7gO/CCItBw==
X-Received: by 2002:a17:907:744:b0:9de:32bb:faab with SMTP id xc4-20020a170907074400b009de32bbfaabmr4149154ejb.32.1699537888576;
        Thu, 09 Nov 2023 05:51:28 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-000-043-071.77.0.pool.telefonica.de. [77.0.43.71])
        by smtp.gmail.com with ESMTPSA id b4-20020a170906038400b0099bc8bd9066sm2581530eja.150.2023.11.09.05.51.28
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:51:28 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 4/4] libsepol: validate the identifier for initials SID is valid
Date:   Thu,  9 Nov 2023 14:51:21 +0100
Message-ID: <20231109135121.42380-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231109135121.42380-1-cgzones@googlemail.com>
References: <20231109135121.42380-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Check the identifier for initial SIDs is less than the maximum known ID.
The kernel will ignore all unknown IDs, see
security/selinux/ss/policydb.c:policydb_load_isids().

Without checking huge IDs result in OOM events, while writing policies,
e.g. in write_sids_to_conf() or write_sids_to_cil(), due to allocation
of large (continuous) string lists.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
   check while validation against actual number of ISIDs
---
 libsepol/src/policydb_validate.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 016ab655..32ad5a18 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -6,6 +6,7 @@
 #include <sepol/policydb/services.h>
 
 #include "debug.h"
+#include "kernel_to_common.h"
 #include "policydb_validate.h"
 
 #define bool_xor(a, b) (!(a) != !(b))
@@ -1180,6 +1181,10 @@ static int validate_ocontexts(sepol_handle_t *handle, const policydb_t *p, valid
 
 			if (p->target_platform == SEPOL_TARGET_SELINUX) {
 				switch (i) {
+				case OCON_ISID:
+					if (octx->sid[0] == SEPOL_SECSID_NULL || octx->sid[0] >= SELINUX_SID_SZ)
+						goto bad;
+					break;
 				case OCON_FS:
 				case OCON_NETIF:
 					if (validate_context(&octx->context[1], flavors, p->mls))
@@ -1216,6 +1221,10 @@ static int validate_ocontexts(sepol_handle_t *handle, const policydb_t *p, valid
 				}
 			} else if (p->target_platform == SEPOL_TARGET_XEN) {
 				switch(i) {
+				case OCON_XEN_ISID:
+					if (octx->sid[0] == SEPOL_SECSID_NULL || octx->sid[0] >= XEN_SID_SZ)
+						goto bad;
+					break;
 				case OCON_XEN_IOPORT:
 					if (octx->u.ioport.low_ioport > octx->u.ioport.high_ioport)
 						goto bad;
-- 
2.42.0

