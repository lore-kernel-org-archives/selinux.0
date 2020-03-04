Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE92CC3F2D7
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 21:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8498420828
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 21:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhg/sisO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbgCDV2S (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 16:28:18 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41731 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgCDV2S (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Mar 2020 16:28:18 -0500
Received: by mail-qk1-f193.google.com with SMTP id b5so3195223qkh.8
        for <selinux@vger.kernel.org>; Wed, 04 Mar 2020 13:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=edPBLykYJAohbuOs1SUORwvsvJbZ1RsCv9v5jubQw3U=;
        b=rhg/sisOOagIFT2fUxvJUXJ90OwJLZJBVRjmxXdguY+dCOqjiiiOdvOO2D5JEQH9HX
         4ZBJo10ee1Vgfgd1C91INy/myJd3jRefiMwQ3h6ES4tzRQJOoJqpBG/F4Hy+FM6OGuiW
         nDre71o8ztjYk5MvcX9zDKxU8b1Wq31wnaJaz521pSZTPc7Cg+Ri/eJ5jIAPuQ+KJo0O
         Uo/dcKp9ePJAeBl7l477TOWhK6pefqiieXvtZq78E7pR8de6WLY/vhhmL4vpU5EVPJuc
         IqIBUNBFCi3v3y/N9d6UGxyVzQbff/7ykF/ryq1zbdKOYAvn04JZ9oLoZT2OjhFxE3oy
         Wb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=edPBLykYJAohbuOs1SUORwvsvJbZ1RsCv9v5jubQw3U=;
        b=FCGVdcgUjOLmLUCsqKlr0EFNJkLMCQ08NU/4cNPuRjy5s0iVvCdMYSmdc3RCiIjviV
         cL3kdllIMkAgmbniUXRG4Zwg1LvALqEXu67A6kvrD6rFPlBi1ihGq1DwuLvLdxpom1Eg
         VVJIhAASHboUbT0x3x7fKe4Bz9x52kXQT2afpCvGyTbp9Lr76bl/Pmp+qpuW4tRMLLML
         OTlRxrJaUj9yXFluj/+EX2XMsypqDrPJWBjR+SvDBChb1LUq73SHmvqx8EZeJt3m+5ad
         RqxkqdyvCS33s0iIMUvaK2QOAKbiUC+6JRXN/VzOgP8XsOlZdpxRNtzvfBXjfe/Q62R3
         ga0A==
X-Gm-Message-State: ANhLgQ3z5r1r3vw9Jo7J4tXGIlI7bDPSKuDslGPK4ujhe436GbHJ3ww1
        ge++zUqSHSHjhMD09Yy9IEj0SO8j
X-Google-Smtp-Source: ADFU+vue/MjOxHJ4GL8gkjhx28xadDD0Z1xLFA8QbcwgGVsHOdcrO3+JBBVyqxLIB+PKYg1BT+q6pA==
X-Received: by 2002:a05:620a:691:: with SMTP id f17mr4829768qkh.342.1583357296898;
        Wed, 04 Mar 2020 13:28:16 -0800 (PST)
Received: from r21-ubuntu-01.ltsnet.net ([65.127.220.137])
        by smtp.googlemail.com with ESMTPSA id k11sm14685403qti.68.2020.03.04.13.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 13:28:16 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     jwcart2@tycho.nsa.gov, James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Check if name is a macro parameter first
Date:   Wed,  4 Mar 2020 16:28:11 -0500
Message-Id: <20200304212811.18242-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Type transition file names are stored in a symbol table. Before the
name is added, the symbol table is searched to see if the name had
already been inserted. If it has, then the already existing datum is
returned. If it has not, then the name is added if either the
typetransition rule does not occur in a macro or the name is not one
of the macro parameters.

Checking for a previous insertion before checking if the name is a
macro parameter can cause a macro parameter to be treated as the
actual name if a previous type transition file name is the same as
the parameter.

Now check the name to see if it a macro paramter before checking for
its existence in the symbol table.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 87575860..daf873be 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -76,14 +76,6 @@ static struct cil_name * __cil_insert_name(struct cil_db *db, hashtab_key_t key,
 	enum cil_sym_index sym_index;
 	struct cil_symtab_datum *datum = NULL;
 
-	cil_flavor_to_symtab_index(CIL_NAME, &sym_index);
-	symtab = &((struct cil_root *)db->ast->root->data)->symtab[sym_index];
-
-	cil_symtab_get_datum(symtab, key, &datum);
-	if (datum != NULL) {
-		return (struct cil_name *)datum;
-	}
-
 	if (parent->flavor == CIL_CALL) {
 		struct cil_call *call = parent->data;
 		macro = call->macro;	
@@ -99,6 +91,14 @@ static struct cil_name * __cil_insert_name(struct cil_db *db, hashtab_key_t key,
 		}
 	}
 
+	cil_flavor_to_symtab_index(CIL_NAME, &sym_index);
+	symtab = &((struct cil_root *)db->ast->root->data)->symtab[sym_index];
+
+	cil_symtab_get_datum(symtab, key, &datum);
+	if (datum != NULL) {
+		return (struct cil_name *)datum;
+	}
+
 	cil_name_init(&name);
 	cil_symtab_insert(symtab, key, (struct cil_symtab_datum *)name, ast_node);
 	cil_list_append(db->names, CIL_NAME, name);
-- 
2.17.1

