Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA837E728E4
	for <selinux@archiver.kernel.org>; Fri, 29 Sep 2023 19:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjI2T4q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Sep 2023 15:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbjI2T4p (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Sep 2023 15:56:45 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CE81A7
        for <selinux@vger.kernel.org>; Fri, 29 Sep 2023 12:56:41 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77421a47db6so739642585a.0
        for <selinux@vger.kernel.org>; Fri, 29 Sep 2023 12:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696017400; x=1696622200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35CJJpDoVj/GETigOLPSGUH+BDkgMwBAtDEZtn70ROg=;
        b=NqyvoXHsLp54/XtevMWqgUq1QFPYcRh1CQHt5k/w84QfI2QSgkPhuTryzDBYjJUktt
         wWdW/45MKwku6D4dO41ycoskxEzFWErvzxTrQjRXAqo/hB9P7Qmr6LCLkEI7u6RvuT10
         9h/KomjwHwkd8MVAUr29/rQdx0G1hlpAFFLrTBJzSptw/Iox9kBkAUYgOOFwlyn0mE/y
         O62nstGyG37VH+waQGM+tJq1luri+RqpXyzyjBTS26z7tT1u9PYtL/F7VjeJuc2RJmgj
         7NWtCnz6BR559U/bWfrmz81wKvR3KhR2ffabOCrRAk0gVBnWElnytlwK3DMTfz01v8vM
         9xZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696017400; x=1696622200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35CJJpDoVj/GETigOLPSGUH+BDkgMwBAtDEZtn70ROg=;
        b=nVSoBMdJCiEWq3L0WJPfn1KsJNQwC0wlp8nyHiUtNTLGQEKngvPWWD1/3l0cbQJTed
         1WQEQtG76eqZkQjNkM+kd4QjrP5MSb8sw6hdW2L0DNKGMYWiJm7kSH75BJVjTkKt52cr
         sRVmYkCSmQLQwxbSBt5lj4HU2d31VinMuTZW9d3KMhU2NpSw6UD9ZgWuo/uZfkFcVvV8
         sAliAoSX3nfBd5XZ96OB/wL80ZrTwajkMffif+58SHWnuVfFksHEnRGVfiKFpfhZ2BkW
         RtfPLW/VeqfdbEcGRxYQqv+en67Ly4Bjqi4A6seO63wkA/TekbGzCU8PVfPC+gOin5Xe
         n/EA==
X-Gm-Message-State: AOJu0Yydhrfb6qq9dNkdcz43F3yDLLiAkVqhSLCZuWEqZeJWmEr84O4c
        xpc8QcMpM6FfomyEIq/DkldnMuwAXHM=
X-Google-Smtp-Source: AGHT+IHirwBco23cWVslM0wUDTLTxAlzXettjx0I43DiAbWrxxpAd8z9l84jJ5KeysYI5xXD0DJ+Nw==
X-Received: by 2002:a05:620a:40c4:b0:76f:1318:d7d1 with SMTP id g4-20020a05620a40c400b0076f1318d7d1mr6565004qko.75.1696017400008;
        Fri, 29 Sep 2023 12:56:40 -0700 (PDT)
Received: from 5bc235456ce7.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id t6-20020a05620a034600b00767e98535b7sm5795291qkm.67.2023.09.29.12.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:56:39 -0700 (PDT)
From:   Jacob Satterfield <jsatterfield.linux@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Jacob Satterfield <jsatterfield.linux@gmail.com>,
        stephen.smalley.work@gmail.com, paul@paul-moore.com,
        omosnace@redhat.com
Subject: [PATCH 1/4] selinux: simplify avtab_insert_node() prototype
Date:   Fri, 29 Sep 2023 19:56:12 +0000
Message-ID: <20230929195617.65120-2-jsatterfield.linux@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230929195617.65120-1-jsatterfield.linux@gmail.com>
References: <20230929195617.65120-1-jsatterfield.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

__hashtab_insert() in hashtab.h has a cleaner interface that allows the
caller to specify the chain node location that the new node is being
inserted into so that it can update the node that currently occupies it.

Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>
---
 security/selinux/ss/avtab.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 095b8cd24806..8751a602ead2 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -67,8 +67,7 @@ static inline u32 avtab_hash(const struct avtab_key *keyp, u32 mask)
 }
 
 static struct avtab_node*
-avtab_insert_node(struct avtab *h, u32 hvalue,
-		  struct avtab_node *prev,
+avtab_insert_node(struct avtab *h, struct avtab_node **dst,
 		  const struct avtab_key *key, const struct avtab_datum *datum)
 {
 	struct avtab_node *newnode;
@@ -90,15 +89,8 @@ avtab_insert_node(struct avtab *h, u32 hvalue,
 		newnode->datum.u.data = datum->u.data;
 	}
 
-	if (prev) {
-		newnode->next = prev->next;
-		prev->next = newnode;
-	} else {
-		struct avtab_node **n = &h->htable[hvalue];
-
-		newnode->next = *n;
-		*n = newnode;
-	}
+	newnode->next = *dst;
+	*dst = newnode;
 
 	h->nel++;
 	return newnode;
@@ -138,7 +130,8 @@ static int avtab_insert(struct avtab *h, const struct avtab_key *key,
 			break;
 	}
 
-	newnode = avtab_insert_node(h, hvalue, prev, key, datum);
+	newnode = avtab_insert_node(h, prev ? &prev->next : &h->htable[hvalue],
+				    key, datum);
 	if (!newnode)
 		return -ENOMEM;
 
@@ -178,7 +171,8 @@ struct avtab_node *avtab_insert_nonunique(struct avtab *h,
 		    key->target_class < cur->key.target_class)
 			break;
 	}
-	return avtab_insert_node(h, hvalue, prev, key, datum);
+	return avtab_insert_node(h, prev ? &prev->next : &h->htable[hvalue],
+				 key, datum);
 }
 
 /* This search function returns a node pointer, and can be used in
-- 
2.41.0

