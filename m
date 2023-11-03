Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E0FC4332F
	for <selinux@archiver.kernel.org>; Fri,  3 Nov 2023 18:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjKCS1G (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Nov 2023 14:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjKCS1F (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Nov 2023 14:27:05 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C701D7A
        for <selinux@vger.kernel.org>; Fri,  3 Nov 2023 11:26:45 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507b96095abso2936919e87.3
        for <selinux@vger.kernel.org>; Fri, 03 Nov 2023 11:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1699036004; x=1699640804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4pURf0alLN08ixOS1VV1i7eCNrZbW+l/zjaCePixsfo=;
        b=GrL9E820cRjzcdjKOd4x+aORjLMWFzSyxxzY6drHzm0Ux6GuA5dMgxh/ghU46HEeZv
         m8qR+8VNZ8PjrILos/qqq17mg/jSKffySy4RgmoAGV7N2tgDe4Z9HLfy1qfYgE52hZZn
         PinfOq1bNFJUE9k6zvO3YvWWug9JazJvVO7KQ8QjWcNp814z14ArzLJEOEasPl7Ez/bd
         4FnDa+NPJH/+zt2q2E9C/N1pFb+uXdUAhli/Mx0r9etx7qAnu7vRy+Xoom9NnpW/nNfK
         ti5BFdrO2hZ2cGUy4hGaf7FyWlaMvgPK4cHQ+l4bNi4Yq6uBOXfKEo60K0UzmAycL2Ad
         iajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699036004; x=1699640804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pURf0alLN08ixOS1VV1i7eCNrZbW+l/zjaCePixsfo=;
        b=j6oV6TzH0FVPnzPdtrPYW1Lc+FmLtDSdxUHmIS+JnVUl3mfLeuSyUrfubmjY9VZXP1
         MuIHJIESdD+jlggFov5hsQ9Obp2MTCsxxavlrsRF2hKA6mofuLCU977IyAZFtOWW2ASo
         UFsfHtaE4gT906M7Zaxagm6My+KIHUYup3NNIINj3yi9+ZlmLB5lBKYEE67YF4xXwO1D
         ItzwsHg+1njEPCUuWW0Qpe5hUDLcrs55s+9K7+nbnM8u/AfVnSql0HYwXq47HWqc5p0z
         hJvQQIMC3g5BCr64t4u+1cuA2gjMrfWicNtL0neqj58EXWzeLytbvhOrgiRuE01QM7jK
         56Xw==
X-Gm-Message-State: AOJu0YzmLDehU6/nFQhH6BzsR1+2Rns4bxHr7b7Y1ERto6fCMtCeB0oH
        DnLgP9t0+sAKAM56qOgCaK3hGXLRodY=
X-Google-Smtp-Source: AGHT+IFYtN+RjAJd0cGdfXjDfy0knpTlSgLhzTZCukhYQZuzmUjYWZ03vJ2QKDH8ADTb0QINNZ71QA==
X-Received: by 2002:a19:f007:0:b0:504:7ff8:3430 with SMTP id p7-20020a19f007000000b005047ff83430mr15726624lfc.10.1699036003482;
        Fri, 03 Nov 2023 11:26:43 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-003-098-230.77.3.pool.telefonica.de. [77.3.98.230])
        by smtp.gmail.com with ESMTPSA id v10-20020aa7dbca000000b0052ff9bae873sm1210275edt.5.2023.11.03.11.26.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 11:26:43 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 2/3] libsepol: validate constraint depth
Date:   Fri,  3 Nov 2023 19:26:36 +0100
Message-ID: <20231103182637.85003-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231103182637.85003-1-cgzones@googlemail.com>
References: <20231103182637.85003-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ensure constraint expressions are complete and do not exceed the
supported depth limit.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 810c3263..b20ed579 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -228,6 +228,7 @@ bad:
 static int validate_constraint_nodes(sepol_handle_t *handle, unsigned int nperms, const constraint_node_t *cons, validate_t flavors[])
 {
 	const constraint_expr_t *cexp;
+	int depth;
 
 	for (; cons; cons = cons->next) {
 		if (nperms == 0 && cons->permissions != 0)
@@ -240,8 +241,14 @@ static int validate_constraint_nodes(sepol_handle_t *handle, unsigned int nperms
 		if (!cons->expr)
 			goto bad;
 
+		depth = -1;
+
 		for (cexp = cons->expr; cexp; cexp = cexp->next) {
 			if (cexp->expr_type == CEXPR_NAMES) {
+				if (depth >= (CEXPR_MAXDEPTH - 1))
+					goto bad;
+				depth++;
+
 				if (cexp->attr & CEXPR_XTARGET && nperms != 0)
 					goto bad;
 				if (!(cexp->attr & CEXPR_TYPE)) {
@@ -282,6 +289,10 @@ static int validate_constraint_nodes(sepol_handle_t *handle, unsigned int nperms
 					goto bad;
 				}
 			} else if (cexp->expr_type == CEXPR_ATTR) {
+				if (depth >= (CEXPR_MAXDEPTH - 1))
+					goto bad;
+				depth++;
+
 				if (!ebitmap_is_empty(&cexp->names))
 					goto bad;
 				if (validate_empty_type_set(cexp->type_names))
@@ -318,8 +329,14 @@ static int validate_constraint_nodes(sepol_handle_t *handle, unsigned int nperms
 			} else {
 				switch (cexp->expr_type) {
 				case CEXPR_NOT:
+					if (depth < 0)
+						goto bad;
+					break;
 				case CEXPR_AND:
 				case CEXPR_OR:
+					if (depth < 1)
+						goto bad;
+					depth--;
 					break;
 				default:
 					goto bad;
@@ -335,6 +352,9 @@ static int validate_constraint_nodes(sepol_handle_t *handle, unsigned int nperms
 					goto bad;
 			}
 		}
+
+		if (depth != 0)
+			goto bad;
 	}
 
 	return 0;
-- 
2.42.0

