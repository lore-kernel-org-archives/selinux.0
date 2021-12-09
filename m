Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44095C433F5
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241341AbhLIQzU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241342AbhLIQzT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:55:19 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21579C061746
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:51:46 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id l25so21582291eda.11
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SlhT9tRSKgg0RR+CqDMiGM1JvVgwnHkQbXnzEyqHQuE=;
        b=Bs7VxDjxcTBbc21DqmH9klmQmEKqUbmp7L5Q2AJrVXCzgye/S7Ifj+It/DgHAuFMeY
         q9TZ73RBmN2uJd3d+bRUMejoRWwgXCNfMxRYjtbjwu2fsKsc8T6AYiA1VHIgmolG2aVS
         4cIRd+S7MsUdss61vnh3a6eX8q4u7V+gYmqm3vPlsUsDd5Z9ukeFmhhd4D4o0E3z22wD
         4dadHkOZCtf6YftKU3P/hM1yjtRrPtzPPIxts0QHTZyKXj19c9dMMJIROaJhi/oDGuVg
         ikpHFXWc+HrA8OEyMdE6cgjWA2qTjXeY+CE3Ug0x+ZdcnpB38wV9Xvckp8EcD7uvhc06
         /zJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SlhT9tRSKgg0RR+CqDMiGM1JvVgwnHkQbXnzEyqHQuE=;
        b=4/a1DoDVpHa8RmTN10wEaEjlCwkW5obBGeSUEOFwpaxCEz3Q7ICGXutf94V4L6RkRD
         eFjx3PthSyPIC0qqcCLrCw9FgZy4U5BF0EVuinNcFol/gCincacxzSZCibt2JFVTeiHe
         cKHG2P3gpIFezXK1w1PwM4XJxFmdj+WAemJXFpw5OPiMwvZIwh4vG/cHCIgWvhJ1lPaK
         8JWbYJ+YaDcnjolCzbjD1ZOJ7MiXaJghlreELoN5ArKA9LzaaeY3qgjkfhMgRwqOPvP2
         HAUexlqzG60FOoqpEGCpl1oB4kCFvCORd8pMyDbvAoHikwakJqbSF6h3Y0EUjbbpVEOl
         iEzg==
X-Gm-Message-State: AOAM532rc16Tb614E3h4oFv4L4KcUVptodiqWHX/0DnTHOlZyAoIIMNr
        N1FdNBOI/7kfSxBNxoFlglRqUYuUPI0=
X-Google-Smtp-Source: ABdhPJwd6MZOK1TEG11aZ6pMuiNJ4PYQy5yXu9O/9UoQXA8j+5Eag8Audc2MVWYYGURNA8EVLvQcPg==
X-Received: by 2002:a17:906:55d7:: with SMTP id z23mr17043798ejp.393.1639068594327;
        Thu, 09 Dec 2021 08:49:54 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.53
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:53 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 28/36] libsepol: validate constraint expression operators and attributes
Date:   Thu,  9 Dec 2021 17:49:20 +0100
Message-Id: <20211209164928.87459-29-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209164928.87459-1-cgzones@googlemail.com>
References: <20211105154542.38434-1-cgzones@googlemail.com>
 <20211209164928.87459-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 43 ++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 5ef95c61..25c6f0db 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -193,6 +193,49 @@ static int validate_constraint_nodes(sepol_handle_t *handle, constraint_node_t *
 				if (validate_type_set(cexp->type_names, &flavors[SYM_TYPES]))
 					goto bad;
 			}
+
+			if (cexp->expr_type == CEXPR_ATTR || cexp->expr_type == CEXPR_NAMES) {
+				switch (cexp->op) {
+				case CEXPR_EQ:
+				case CEXPR_NEQ:
+				case CEXPR_DOM:
+				case CEXPR_DOMBY:
+				case CEXPR_INCOMP:
+					break;
+				default:
+					goto bad;
+				}
+
+				switch (cexp->attr) {
+				case CEXPR_USER:
+				case CEXPR_USER | CEXPR_TARGET:
+				case CEXPR_USER | CEXPR_XTARGET:
+				case CEXPR_ROLE:
+				case CEXPR_ROLE | CEXPR_TARGET:
+				case CEXPR_ROLE | CEXPR_XTARGET:
+				case CEXPR_TYPE:
+				case CEXPR_TYPE | CEXPR_TARGET:
+				case CEXPR_TYPE | CEXPR_XTARGET:
+				case CEXPR_L1L2:
+				case CEXPR_L1H2:
+				case CEXPR_H1L2:
+				case CEXPR_H1H2:
+				case CEXPR_L1H1:
+				case CEXPR_L2H2:
+					break;
+				default:
+					goto bad;
+				}
+			} else {
+				switch (cexp->expr_type) {
+				case CEXPR_NOT:
+				case CEXPR_AND:
+				case CEXPR_OR:
+					break;
+				default:
+					goto bad;
+				}
+			}
 		}
 	}
 
-- 
2.34.1

