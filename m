Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF0BC433F5
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 844D161183
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhKEPsg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbhKEPsf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:35 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FC8C061714
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:45:55 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r4so33723711edi.5
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+b07vzbHaFZ64ixsJ/03cS6hcL3GUuhwNXQGLe4OIxw=;
        b=Z8jJzPKzrG96QZum7Q8sYldfIx/3Ajd43eih9enr5j3gPmIcKnogAJjpqG9sxEGmfA
         6OEu3rZR4tTuOSXR4gXYGaC7Q1lWsH5a/i9EtF4u3wonGod+2Fd61JVeB1cycK5vRHjE
         +r+YIFt2EFUndn16iyZYAmIT0vEtajVxl+QVsf5kPX8jqI1mdfOUX4IqOtXOVUmgx/Ns
         ZhUF6p/pocdxD4DriyGU449aZVvFdRmjLRnHAu6NvececY3JuOKfvqZKXmlvr1Amp/td
         i7wRWoTvNN+IgOj8NqFboj95axzQzZgziYOFVSqSSFkONesMHHZjo/T8YD4Ys1T9zkQE
         DcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+b07vzbHaFZ64ixsJ/03cS6hcL3GUuhwNXQGLe4OIxw=;
        b=6Ao7fBbrDgap220/Xi9SWXyXtx9sk7LNJIEkAqIecwZvGKeu3ROYi/XXDjVtN756ei
         KBa6PVjBnxzCGz7tc+FLiSp4X4Kj1pUHQvwKm3m1YF9Fxp94skaj9o0HTCJs82yHWMrr
         z4VtP5j+Bkhng8XSy4lzlY5W180FYXhjhjotmC30eqKf4fygg/V+LPfQTtwrIV65LNVj
         8K50DS/OPPglcRinR9e/StoQ8IxFs2/ZI8hffcL6xOSI5hSRg8wcpQK5Nc59nCjzy7Uw
         Zz39TPEuWQUsCQnYwTTJdKq2/OTovkDUCF/8fbeWU+unAGocDLQ+4l/zs1/LlkmIyxJg
         4k9w==
X-Gm-Message-State: AOAM530+dqjOScULQJhiQlozfHIpaOxVFKvxfj3C5TSnl2+5/o3T/UA4
        4vRqDR96u6wck731bXphJzq+hqBImR0=
X-Google-Smtp-Source: ABdhPJw2hFNCIe+wuIl/Ec08dfijGMAqYCW2GHF/EKn5J7fKv1af4Sw11BRSpm/LMwpazAXUTUcvaA==
X-Received: by 2002:a05:6402:34d3:: with SMTP id w19mr46805775edc.35.1636127153241;
        Fri, 05 Nov 2021 08:45:53 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.45.52
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:45:52 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 12/36] libsepol: clean memory on conditional insertion failure
Date:   Fri,  5 Nov 2021 16:45:14 +0100
Message-Id: <20211105154542.38434-13-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105154542.38434-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
 <20211105154542.38434-1-cgzones@googlemail.com>
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
2.33.1

