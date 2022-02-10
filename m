Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D17EC433EF
	for <selinux@archiver.kernel.org>; Thu, 10 Feb 2022 18:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiBJSib (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Feb 2022 13:38:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiBJSia (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Feb 2022 13:38:30 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FF7CE9
        for <selinux@vger.kernel.org>; Thu, 10 Feb 2022 10:38:31 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id bx2so12430013edb.11
        for <selinux@vger.kernel.org>; Thu, 10 Feb 2022 10:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0I7FTx9aIwIt86StE0rfcvYETkASELE4qsvxTxPpUpo=;
        b=HGulxUI/TX43C6YKPXIt7AQ021AsTrqIiimkOPCMy/FHBIq/ORaTWt/C7CtlkzxcES
         ts+GbQcNUDeET4FQs3WdI9jijHvQzQI4iQpT7bfK6AfvdqRqWqZOTezqdw0TwYSV5dQz
         +zqnuoXD22scWcnBXYaAYGGC/Z5boVf/aeDy0SMh+luktqss6L6eMU8d6MaLh4ZgRLdY
         BiNhVHUzy2MEJW5Cp5L08pSRwTpbVU4s2Xq0NhWorYVQv0GYbP9FhdbBMA0jLbDx3AD5
         HRbqknS7fU3Msms6Rylan5tgiqvIx4LtfRY3Q8SY78rp6Sv3p8RtrVoG5+Y1EyShMDcy
         X2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0I7FTx9aIwIt86StE0rfcvYETkASELE4qsvxTxPpUpo=;
        b=l2T9L6nZ8+J1Z42i0Fc1HIIA9E14z37ABCD4Beg2YoFfiZ8xMuSwBfKx1Qj2Sqd9Oc
         u7TwfFdqKSA9LOnY6OVgHBctUyXa2Uf6IC530guh9RFSH18z1XxYd8XQnRDR2WIkvraP
         nOsg3XgdJbbAeH7Km0SR2MoMZZ0GmvGwz35Km9ohwFLofs4FptuHI922xJ9gwote65K7
         9UeiJozeGQnKgMULohz/EINNp89SxG9EU7xVI5Ny2DUQDj2FMz7lgOs+6xjIhiIh39AP
         vENnXC3UcfWeMAJ0us6x6i1ALdfG7J5eD9EQEzbAzm4Sjqyb4KVLkCArp91XxfTEkLco
         R5bA==
X-Gm-Message-State: AOAM532CCmhRjh/CXlBlDN999Zua3ZkFKjQ0Bvx3wDVdkeTxdxSJCeoS
        qSmxkVGmlE0WzKZTwFMa+eg3qX2K/Bw=
X-Google-Smtp-Source: ABdhPJx6h1nToUzotWVnbclGEP+uwuLJefK+Ff0EHqJMyN76swKaiufUdXPXa6SXr1qVRCYVbTo5NA==
X-Received: by 2002:a05:6402:2710:: with SMTP id y16mr9018107edd.350.1644518310019;
        Thu, 10 Feb 2022 10:38:30 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-000-131-054.77.0.pool.telefonica.de. [77.0.131.54])
        by smtp.gmail.com with ESMTPSA id wq18sm4773364ejb.149.2022.02.10.10.38.29
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 10:38:29 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2] checkpolicy: allow wildcard permissions in constraints
Date:   Thu, 10 Feb 2022 19:38:23 +0100
Message-Id: <20220210183823.39187-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204133717.27793-1-cgzones@googlemail.com>
References: <20220204133717.27793-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Allow all and complement permission sets in constraints, e.g.:

    constrain service ~ { status } (...);
    constrain service * (...);

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

---

v2:
   - do not set invalid permission bits
   - omit constrain rules with an empty permission bitset
---
 checkpolicy/policy_define.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index b2ae3263..16b78346 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -3477,6 +3477,8 @@ static constraint_expr_t *constraint_expr_clone(const constraint_expr_t * expr)
 	return NULL;
 }
 
+#define PERMISSION_MASK(nprim) ((nprim) == PERM_SYMTAB_SIZE ? (~UINT32_C(0)) : ((UINT32_C(1) << (nprim)) - 1))
+
 int define_constraint(constraint_expr_t * expr)
 {
 	struct constraint_node *node;
@@ -3590,6 +3592,22 @@ int define_constraint(constraint_expr_t * expr)
 			cladatum = policydbp->class_val_to_struct[i];
 			node = cladatum->constraints;
 
+			if (strcmp(id, "*") == 0) {
+				node->permissions = PERMISSION_MASK(cladatum->permissions.nprim);
+				continue;
+			}
+
+			if (strcmp(id, "~") == 0) {
+				node->permissions = ~node->permissions & PERMISSION_MASK(cladatum->permissions.nprim);
+				if (node->permissions == 0) {
+					yywarn("omitting constraint with no permission set");
+					cladatum->constraints = node->next;
+					constraint_expr_destroy(node->expr);
+					free(node);
+				}
+				continue;
+			}
+
 			perdatum =
 			    (perm_datum_t *) hashtab_search(cladatum->
 							    permissions.
-- 
2.34.1

