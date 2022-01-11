Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B68C433FE
	for <selinux@archiver.kernel.org>; Tue, 11 Jan 2022 21:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345361AbiAKVzR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Jan 2022 16:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbiAKVzE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Jan 2022 16:55:04 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968B3C061748
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:55:04 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id v7so807858qtw.13
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HqowdsrtetExLhFsrH9aI0xzH9bMziJ8hdFMjMvbq88=;
        b=nU85OLSLlOtiRkTNKB2vjy3+k+vxxICYc0qKNMbdr266y6wIoMHaedRzoHct6LhuYl
         pCSBr14v/OhqKgsj/75tntL9T4y2LXxaZqvVnbwITIcuUYi6RG2DgkAFn3LhAaX8QtVX
         uNPT5t4dhzrnETzBEhSNn0QsQxVFBlYcTvu8tkMGuziblzESVMenl5u0LLzyQ/n18MAk
         Xv3sXuiyrIGwa8/IwNpjD9aUoAM10x7OOb+PDb+sBBqAcWEPnyl++q8g2fEbq9f4nZ4i
         4JJlNtbGa1wZURRPszbzpaU9lnYbbh3WKn3TqQqZDuxs9dNBlGc6MgtqIxy8TvMmna0a
         t8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HqowdsrtetExLhFsrH9aI0xzH9bMziJ8hdFMjMvbq88=;
        b=Zy8CMuSVKNfvmeh6YfrQzJOkuWMXAse6bKVh487zi/4zZWFE5NIdrrTJNS4qNphUXW
         NsD2JOZPl+Ee1N88Z74W8hxoafDlgJsDrgXm6KAU5N7zQ/BJcpQPuDfI+guzCWLSKDyW
         byitd2NhHhUA1qIJNUe/MiazZjOx2L80LNjZrP1VH1cX4RpNAOshoOa2gUQSfyfSnH8M
         TynMJZl+A5eg5dZIXVm9sIjLWiLqVUOFM20jV5L0NcOceecmG1WYlNkUjSguL4SXsPal
         fTHGoYPnmwl3IXd2mBZ72lM0pM1vfRY5lklEx0yxP7y0bqo/lju0DgfTtHOvqosT06JA
         TWCA==
X-Gm-Message-State: AOAM532PYwIouXBW03bkA4q65uyvt2AKBgC4Rom2cidEAmJTx8Vm1+TJ
        giBYIEq+U3zNO1w6zsj2gl3vaBTsPPM=
X-Google-Smtp-Source: ABdhPJzTsOwGn+9gHkY/invrveLs/mfGIAJK5mrmzfZIMoo75ay+HWXFcX+eDf3RsLbJROzmxZ4h2Q==
X-Received: by 2002:a05:622a:1054:: with SMTP id f20mr4921516qte.132.1641938103694;
        Tue, 11 Jan 2022 13:55:03 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id j22sm5826949qko.46.2022.01.11.13.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 13:55:03 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 13/16 v2] libsepol: Make return value clearer when reporting neverallowx errors
Date:   Tue, 11 Jan 2022 16:54:43 -0500
Message-Id: <20220111215446.595516-14-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220111215446.595516-1-jwcart2@gmail.com>
References: <20220111215446.595516-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The value returned from report_assertion_extended_permissions() is
the nubmer of errors, so call it that instead of ret.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/assertion.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 26fa8d96..93c57061 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -148,8 +148,8 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
 	ebitmap_t *tattr = &p->type_attr_map[ttype];
 	ebitmap_node_t *snode, *tnode;
 	unsigned int i, j;
-	int rc = 1;
-	int ret = 0;
+	int rc;
+	int errors = 0;
 
 	memcpy(&tmp_key, k, sizeof(avtab_key_t));
 	tmp_key.specified = AVTAB_XPERMS_ALLOWED;
@@ -178,15 +178,14 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
 							p->p_class_val_to_name[curperm->tclass - 1],
 							sepol_extended_perms_to_string(&error));
 
-					rc = 0;
-					ret++;
+					errors++;
 				}
 			}
 		}
 	}
 
 	/* failure on the regular permissions */
-	if (rc) {
+	if (!errors) {
 		ERR(handle, "neverallowxperm on line %lu of %s (or line %lu of policy.conf) violated by\n"
 				"allow %s %s:%s {%s };",
 				avrule->source_line, avrule->source_filename, avrule->line,
@@ -194,11 +193,11 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
 				p->p_type_val_to_name[ttype],
 				p->p_class_val_to_name[curperm->tclass - 1],
 				sepol_av_to_string(p, curperm->tclass, perms));
-		ret++;
+		errors++;
 
 	}
 
-	return ret;
+	return errors;
 }
 
 static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void *args)
-- 
2.31.1

