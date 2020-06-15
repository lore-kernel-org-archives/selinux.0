Return-Path: <SRS0=CKju=74=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346DDC433DF
	for <selinux@archiver.kernel.org>; Mon, 15 Jun 2020 20:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE2F12074D
	for <selinux@archiver.kernel.org>; Mon, 15 Jun 2020 20:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7CrXqAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbgFOUp6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:45:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31442 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729692AbgFOUp6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Jun 2020 16:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592253956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=TJCHkDZhyWuXXWeNe8iaosb9wy02/ddef5wGJbSOb7I=;
        b=W7CrXqAZd3+FKnL5DYdHliT9kTfvJBuE8yu+Ee1EDFT2EweDFNYfgt8IYJ/CeoZiISudoh
        pFylDFlzt2apcSf7c/3vvFxGTRPCqVIRFf2Vxm/N4tVMV4n1vZ23KD6zy9VMKXs4IG86du
        JYHR/Y/orqaM1fkT63qOqILrxvppcoA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-0A_GiOWJPQKkzzlFISpeKg-1; Mon, 15 Jun 2020 16:45:55 -0400
X-MC-Unique: 0A_GiOWJPQKkzzlFISpeKg-1
Received: by mail-qk1-f198.google.com with SMTP id m29so15188971qkm.17
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2020 13:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TJCHkDZhyWuXXWeNe8iaosb9wy02/ddef5wGJbSOb7I=;
        b=S+MAy0HlweU+6MKU6760HQ/cjLXWxpxD5kmS2NNLg7otCNBP1RiN6kfzKprZ8cRKb1
         Dc0QreT2ywMQo98QyuqC5OrEWUMGMHJQDslCxfQdErwl3C2DRD4eWN2NhaA0rDwYSwi2
         8Lyr6wPumHf0i73PgIFFdmwzy3JuPtbuDoUL39hD0ggj+YSAYjYxcO69Rbo1VOe346Of
         LpCngt3o+pziGsR9DAfnR0nktrMDJfFW/XMHtIv55z2ufp1cRsn5vqlvjlAi1mzRh/Ru
         51fhkbypoNG0NfpYwfLfTQ4LlZ66SOu+EblyMdelYDub2Zv4+KAIpgS2HdIVQU4cI+Cn
         v33g==
X-Gm-Message-State: AOAM532rHWvH0+3ldxMEBum9vWiq9USEAGNKhPLCB6vWKejLas9f0K+R
        qjtZ3gT1/z9qv9whIGdXQ8MeLkJrB9fsAErWBX5e48SqPqKoES/wuM+KVNAvPODYcSHliVSsYgT
        jVulqDnLGfFRPAuAnMA==
X-Received: by 2002:a05:6214:1705:: with SMTP id db5mr26325347qvb.14.1592253954764;
        Mon, 15 Jun 2020 13:45:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXbo7hbbH7LW9AmslC0JZpfWQroeYx2/3suBFGIqLSIO/NH3DhE72c7GflQe+8P1pIGbWHfw==
X-Received: by 2002:a05:6214:1705:: with SMTP id db5mr26325332qvb.14.1592253954529;
        Mon, 15 Jun 2020 13:45:54 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s70sm12563576qke.80.2020.06.15.13.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 13:45:53 -0700 (PDT)
From:   trix@redhat.com
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, omosnace@redhat.com, weiyongjun1@huawei.com
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v3] selinux: fix another double free
Date:   Mon, 15 Jun 2020 13:45:48 -0700
Message-Id: <20200615204548.9230-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this double free error

security/selinux/ss/conditional.c:139:2: warning: Attempt to free released memory [unix.Malloc]
        kfree(node->expr.nodes);
        ^~~~~~~~~~~~~~~~~~~~~~~

When cond_read_node fails, it calls cond_node_destroy which frees the
node but does not poison the entry in the node list.  So when it
returns to its caller cond_read_list, cond_read_list deletes the
partial list.  The latest entry in the list will be deleted twice.

So instead of freeing the node in cond_read_node, let list freeing in
code_read_list handle the freeing the problem node along with all of the
earlier nodes.

Because cond_read_node no longer does any error handling, the goto's
the error case are redundant.  Instead just return the error code.

Fixes: 60abd3181db2 ("selinux: convert cond_list to array")

Signed-off-by: Tom Rix <trix@redhat.com>
---
v3: simplify returns

 security/selinux/ss/conditional.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index da94a1b4bfda..450bc02f4cd2 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -392,27 +392,19 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
 
 		rc = next_entry(buf, fp, sizeof(u32) * 2);
 		if (rc)
-			goto err;
+			return rc;
 
 		expr->expr_type = le32_to_cpu(buf[0]);
 		expr->bool = le32_to_cpu(buf[1]);
 
-		if (!expr_node_isvalid(p, expr)) {
-			rc = -EINVAL;
-			goto err;
-		}
+		if (!expr_node_isvalid(p, expr))
+			return -EINVAL;
 	}
 
 	rc = cond_read_av_list(p, fp, &node->true_list, NULL);
 	if (rc)
-		goto err;
-	rc = cond_read_av_list(p, fp, &node->false_list, &node->true_list);
-	if (rc)
-		goto err;
-	return 0;
-err:
-	cond_node_destroy(node);
-	return rc;
+		return rc;
+	return cond_read_av_list(p, fp, &node->false_list, &node->true_list);
 }
 
 int cond_read_list(struct policydb *p, void *fp)
-- 
2.18.1

