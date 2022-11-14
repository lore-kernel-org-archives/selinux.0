Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9BDC433FE
	for <selinux@archiver.kernel.org>; Mon, 14 Nov 2022 20:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236454AbiKNULJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Nov 2022 15:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237528AbiKNUKx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Nov 2022 15:10:53 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02161A809
        for <selinux@vger.kernel.org>; Mon, 14 Nov 2022 12:10:51 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id v17so18924763edc.8
        for <selinux@vger.kernel.org>; Mon, 14 Nov 2022 12:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qh0HU+tAShCKgs/+4QsOgiWqbnxR91OhcOH1V/c5j4Y=;
        b=XLgSIEty0IBGpJO0dDD1QT/3+PeGupRjK8b0P97xVm1ZwCc1C0pwvphx6tEfIR7Ynt
         8XOFEhPNsn+eYZSp/bSDapWnz6HMOFCxB8EX34y8yM+gnZhKRM33+1KOrno4DQ+Z4iP6
         4QmUby02jXJtg/D2cx4NZCPA2JvsrKXWL7or1rIyYnTY7Gpp4xJBVIPKu7RlpuWUisQJ
         nMIyhtrEsvdQqgoY/Q9r1xOMARNdokZAZABWfMd0awJwohZTv0uRngMgK+Ilm7My6lfl
         HZAR94CZn7CFCPAW2eVF3pUDGiqQ2vZWs2re0cNQPBoa9gBAsS1FFclrK1krlYhnjrq5
         mYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qh0HU+tAShCKgs/+4QsOgiWqbnxR91OhcOH1V/c5j4Y=;
        b=Zmmli5pC/Glwbck7kpZ8WZsobuVxx7kXw80S4tz+DUgcQvVnw19S9/PIqM7cWHDAuE
         hs+hGB8KHRcA1p9YAtnSMTwR58MeOANVmYGWou4KsvxKVyeAgIuHlA76QzkYGCD7HDrW
         nYZ7MLhibYEUk+Jw1GU3EHW6h1ybHV8TSfOytI/AKPJYvSOkf//UdtA2biXGEmMsu2Fw
         ZwTbOQYI0u1zWqEv03GFi6wSmB+v1SbpB2wtoUOpGZWHrTz0eNH+kI3Z73yERvSXsST0
         oZwQPvaN+luNbjX55RqLZr7HfYgNED5ZMxDVW/rASL5YfTBMd7ln6/VLYtne3MEnxgXw
         6RkA==
X-Gm-Message-State: ANoB5pmtJmu0t2tXwsDklQZzss47Mr+NThKaQiKyLVquiVybKtb5BEzg
        LxsukZhTIpteG2JkpDF9F0re+GsJcCA=
X-Google-Smtp-Source: AA0mqf7H6Z0rIzf6X6Yf7Nbnq4+u7B5wCVv8/vqhJI7ka8g4t4uOS674r6TpsqYPTH9qTzyboFD2DQ==
X-Received: by 2002:a05:6402:2b94:b0:467:9976:2e37 with SMTP id fj20-20020a0564022b9400b0046799762e37mr8625058edb.267.1668456650250;
        Mon, 14 Nov 2022 12:10:50 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-090-138.77.3.pool.telefonica.de. [77.3.90.138])
        by smtp.gmail.com with ESMTPSA id cb13-20020a170906a44d00b007abafe43c3bsm4558377ejb.86.2022.11.14.12.10.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 12:10:49 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 4/6] checkpolicy: rename bool identifiers
Date:   Mon, 14 Nov 2022 21:10:40 +0100
Message-Id: <20221114201042.17773-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114201042.17773-1-cgzones@googlemail.com>
References: <20221114201042.17773-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Avoid using the identifier `bool` to improve support with future C
standards.  C23 is about to make `bool` a predefined macro (see N2654).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/checkpolicy.c | 8 ++++----
 checkpolicy/test/dismod.c | 8 ++++----
 checkpolicy/test/dispol.c | 8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index a1406e7b..4c1b9b89 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -354,14 +354,14 @@ static int display_cond_expressions(void)
 
 static int change_bool(const char *name, int state)
 {
-	cond_bool_datum_t *bool;
+	cond_bool_datum_t *boolean;
 
-	bool = hashtab_search(policydbp->p_bools.table, name);
-	if (bool == NULL) {
+	boolean = hashtab_search(policydbp->p_bools.table, name);
+	if (boolean == NULL) {
 		printf("Could not find bool %s\n", name);
 		return -1;
 	}
-	bool->state = state;
+	boolean->state = state;
 	evaluate_conds(policydbp);
 	return 0;
 }
diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index 51b68433..6328d326 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -598,14 +598,14 @@ int display_cond_expressions(policydb_t * p, FILE * fp)
 
 int change_bool(char *name, int state, policydb_t * p, FILE * fp)
 {
-	cond_bool_datum_t *bool;
+	cond_bool_datum_t *boolean;
 
-	bool = hashtab_search(p->p_bools.table, name);
-	if (bool == NULL) {
+	boolean = hashtab_search(p->p_bools.table, name);
+	if (boolean == NULL) {
 		fprintf(fp, "Could not find bool %s\n", name);
 		return -1;
 	}
-	bool->state = state;
+	boolean->state = state;
 	evaluate_conds(p);
 	return 0;
 }
diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index c396bef7..1d619e2c 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -262,14 +262,14 @@ static int display_handle_unknown(policydb_t * p, FILE * out_fp)
 
 static int change_bool(char *name, int state, policydb_t * p, FILE * fp)
 {
-	cond_bool_datum_t *bool;
+	cond_bool_datum_t *boolean;
 
-	bool = hashtab_search(p->p_bools.table, name);
-	if (bool == NULL) {
+	boolean = hashtab_search(p->p_bools.table, name);
+	if (boolean == NULL) {
 		fprintf(fp, "Could not find bool %s\n", name);
 		return -1;
 	}
-	bool->state = state;
+	boolean->state = state;
 	evaluate_conds(p);
 	return 0;
 }
-- 
2.38.1

