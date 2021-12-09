Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F367C433EF
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241335AbhLIQzO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241336AbhLIQzO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:55:14 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C27EC061746
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:51:40 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v1so21770526edx.2
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zdWRNyLai4spI46glBVLPT/JuMrRSd2gud4gD7rflgY=;
        b=ogOagTvkfVIvcFE7n41CrG+Xl8d0sMpfn2jHjGaEQEzHHB3goLcifXxeXJG4J7B+Jn
         JcBQ4iPpyq/HdnhPQAp3cYaNcnWXD3sRTxVHYPyTBGHFnsayTBSMnpxleEzAjkwMQCuD
         u9f4ntU9zxw/iMzi1Xwvng9s8xwzmHu+rygJfWNveoKsg5w3sw3lpGuI7wJFuTRzNT8o
         XHfnY9/AP8EwXJR6uRvhsyGoMI81rquaNwsn8sqdhuoEFiWSh3S0rUIec1eSwDdb7VDb
         KHCi5oy3bI2bsLPVsFZMuWxWziHdjtV3rjboyyOwv6/6zdzK8YGAWwNJBJwsJ0LclsTk
         /Szw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zdWRNyLai4spI46glBVLPT/JuMrRSd2gud4gD7rflgY=;
        b=Cw4ZKMCTEG9GGHwhISwqpZOrKB+rcfeAcRAmWpLFtc7E7X14gnNoFwVSWWLNvh2tYV
         JrJLFzed0+BNCZnzU76edDUspdVzOxyalPKkWn6STxEOFrEaAOEfnyYRGcbhA79cK/Og
         5D9c1/ornk4oP9xCjehGs+eWyG+AGFtqbvaKYAN+aFLkTr6CkNYIiP5t3rWhZL2fxk5M
         bEeYPl1oXxh6leGGQiira8idmf5XcIs1P4aDlYskQxvJGiOu/XQg2cB0R7dEyt+zpkQn
         EoZuPKYKUvYGQWSqwhYnPdakuY+NQ8nrbKXMzD5Moa7BeACQ/uHsOAnmAmwcJa2/hfEE
         5Xtw==
X-Gm-Message-State: AOAM5333ZExkyvqlgGkZh/XIsusNS46Udq6T3oSJDq915Sr296XXLf6D
        HD94DFBdJk4y5edWpbvJTVn0+yPbUtc=
X-Google-Smtp-Source: ABdhPJwCDGmoca60zyB52sj2joW8yzQoHblxBwmNYCTR1Ks+IBBFAuG/bsLCBr2NUHsoqzzIg10rCw==
X-Received: by 2002:a17:906:3b84:: with SMTP id u4mr16405859ejf.310.1639068583371;
        Thu, 09 Dec 2021 08:49:43 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:43 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 12/36] libsepol: clean memory on conditional insertion failure
Date:   Thu,  9 Dec 2021 17:49:04 +0100
Message-Id: <20211209164928.87459-13-cgzones@googlemail.com>
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

Free the local access vector list on failure as it does not get moved
into the policy structure.
Drop the now redundant, but non-exhaustive, resource cleanup in
cond_insertf().

    Direct leak of 16 byte(s) in 1 object(s) allocated from:
        #0 0x52596d in malloc (./out/binpolicy-fuzzer+0x52596d)
        #1 0x5b30d2 in cond_insertf ./libsepol/src/conditional.c:682:9
        #2 0x5ac218 in avtab_read_item ./libsepol/src/avtab.c:583:10
        #3 0x5b21f4 in cond_read_av_list ./libsepol/src/conditional.c:725:8
        #4 0x5b21f4 in cond_read_node ./libsepol/src/conditional.c:798:7
        #5 0x5b21f4 in cond_read_list ./libsepol/src/conditional.c:847:7
        #6 0x576b6e in policydb_read ./libsepol/src/policydb.c:4436:8
        #7 0x55a1fe in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-fuzzer.c:24:6
        #8 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) fuzzer.o
        #9 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, unsigned long) fuzzer.o
        #10 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) fuzzer.o
        #11 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
        #12 0x7f47abeb87ec in __libc_start_main csu/../csu/libc-start.c:332:16

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

---
v2:
   drop redundant cleanup in cond_insertf()
---
 libsepol/src/conditional.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
index cc3f4d82..a3125fdd 100644
--- a/libsepol/src/conditional.c
+++ b/libsepol/src/conditional.c
@@ -634,7 +634,7 @@ static int cond_insertf(avtab_t * a
 	if (k->specified & AVTAB_TYPE) {
 		if (avtab_search(&p->te_avtab, k)) {
 			WARN(NULL, "security: type rule already exists outside of a conditional.");
-			goto err;
+			return -1;
 		}
 		/*
 		 * If we are reading the false list other will be a pointer to
@@ -650,7 +650,7 @@ static int cond_insertf(avtab_t * a
 				if (avtab_search_node_next
 				    (node_ptr, k->specified)) {
 					ERR(NULL, "security: too many conflicting type rules.");
-					goto err;
+					return -1;
 				}
 				found = 0;
 				for (cur = other; cur != NULL; cur = cur->next) {
@@ -661,13 +661,13 @@ static int cond_insertf(avtab_t * a
 				}
 				if (!found) {
 					ERR(NULL, "security: conflicting type rules.\n");
-					goto err;
+					return -1;
 				}
 			}
 		} else {
 			if (avtab_search(&p->te_cond_avtab, k)) {
 				ERR(NULL, "security: conflicting type rules when adding type rule for true.\n");
-				goto err;
+				return -1;
 			}
 		}
 	}
@@ -675,13 +675,13 @@ static int cond_insertf(avtab_t * a
 	node_ptr = avtab_insert_nonunique(&p->te_cond_avtab, k, d);
 	if (!node_ptr) {
 		ERR(NULL, "security: could not insert rule.");
-		goto err;
+		return -1;
 	}
 	node_ptr->parse_context = (void *)1;
 
 	list = malloc(sizeof(cond_av_list_t));
 	if (!list)
-		goto err;
+		return -1;
 	memset(list, 0, sizeof(cond_av_list_t));
 
 	list->node = node_ptr;
@@ -691,11 +691,6 @@ static int cond_insertf(avtab_t * a
 		data->tail->next = list;
 	data->tail = list;
 	return 0;
-
-      err:
-	cond_av_list_destroy(data->head);
-	data->head = NULL;
-	return -1;
 }
 
 static int cond_read_av_list(policydb_t * p, void *fp,
@@ -724,8 +719,10 @@ static int cond_read_av_list(policydb_t * p, void *fp,
 	for (i = 0; i < len; i++) {
 		rc = avtab_read_item(fp, p->policyvers, &p->te_cond_avtab,
 				     cond_insertf, &data);
-		if (rc)
+		if (rc) {
+			cond_av_list_destroy(data.head);
 			return rc;
+		}
 
 	}
 
-- 
2.34.1

