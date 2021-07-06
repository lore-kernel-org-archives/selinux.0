Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7457BC07E9C
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60A8561C3C
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhGFR52 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Jul 2021 13:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhGFR52 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Jul 2021 13:57:28 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C60C06175F
        for <selinux@vger.kernel.org>; Tue,  6 Jul 2021 10:54:48 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id l24so29177781edr.11
        for <selinux@vger.kernel.org>; Tue, 06 Jul 2021 10:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qklAFuHgG6PaBIN7LRiq0ZqDomO1gxp4FJcY+IieCno=;
        b=pGzBkixzLr8F4NsB7DZWdbIK2FODkgy8Xcmv+9ICE1vnpWpxgrg87dGtSO/khtHf5E
         RdvJMORw9aJGAKnNRyKJS1qdGzHqzt4k/TweeSbGJQ/FyrI3/02ZuOHiaQZ78I8vSNT+
         Re28z3/CwQGZGh42u865DuOMimugTdN3LNHW6628BzGvmJWtVnk31CLdCI2YQ6ti0/gv
         SJHqFbCU+Qufre9H9zmYiVpjOQoL5P1uUgXlA8l9hv5mlEtcY+2uOEpeQWST9gpT9iGH
         hrYCUWBWd0PbZDEsV4XUadxdnuSDgcd7XPKBjMFgFIW3qUHfDR7lvTxjSOxp8HHxbkVm
         mJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qklAFuHgG6PaBIN7LRiq0ZqDomO1gxp4FJcY+IieCno=;
        b=G7oYAmhilbJV8DZ4bF2HbXDW1bTn6oSCSTk83zvvqCnbWL9ckMeJUoYhuzMASs9AFm
         5PmyG5+ZlczTIAoIFx3gfubrWCiQFKH5r1ZsnTTP7j04Pl3VipUD2NEBPTFRElPF1HKo
         uikisdul54KrRIwT7xZ7PkngFh1yJyFd33YpiLRViGOQiYTlZPcnNUTj/UDBpY2R2Qoh
         /WeI1qXN/BeKvc2o3apZTu18AwS5hbp5QsSoSMsuUYRNbyvuB4aRFLOXKj0DBRAKMOR2
         C/Td98WZRya4k2uTDMcyu/K3Xxw5KFMwRpv6Yi2cyEGU4ArZVjXpaIJ+huTMTLPcktPB
         z1EQ==
X-Gm-Message-State: AOAM531QK/wxcN8rpDQH7GSrzC2nbkfBCPhIyQR9mJDXvFQksptEUszx
        ocZs/OcWLzMEVJX7bJCnDXAElCP//3c=
X-Google-Smtp-Source: ABdhPJxbCxj4Hwdm7zZXzbIBb025aJP6+JKdiStMZot7R5/R6xZpihCf7PGckeFYmL4qfHHO/uXzww==
X-Received: by 2002:a05:6402:31b3:: with SMTP id dj19mr25426513edb.24.1625594087043;
        Tue, 06 Jul 2021 10:54:47 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-100-174.95.116.pool.telefonica.de. [95.116.100.174])
        by smtp.gmail.com with ESMTPSA id lg16sm6050950ejb.69.2021.07.06.10.54.46
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 10:54:46 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 13/13] checkpolicy: mark read-only parameters in policy define const
Date:   Tue,  6 Jul 2021 19:54:33 +0200
Message-Id: <20210706175433.29270-13-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210706175433.29270-1-cgzones@googlemail.com>
References: <20210706175433.29270-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Make it more obvious which parameters are read-only and not being
modified and allow callers to pass const pointers.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 462e3994..a8aa615e 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -77,7 +77,7 @@ extern int yyerror(const char *msg);
 #define ERRORMSG_LEN 255
 static char errormsg[ERRORMSG_LEN + 1] = {0};
 
-static int id_has_dot(char *id);
+static int id_has_dot(const char *id);
 static int parse_security_context(context_struct_t *c);
 
 /* initialize all of the state variables for the scanner/parser */
@@ -141,7 +141,7 @@ int insert_id(const char *id, int push)
 
 /* If the identifier has a dot within it and that its first character
    is not a dot then return 1, else return 0. */
-static int id_has_dot(char *id)
+static int id_has_dot(const char *id)
 {
 	if (strchr(id, '.') >= id + 1) {
 		return 1;
@@ -2172,7 +2172,7 @@ void avrule_xperm_setrangebits(uint16_t low, uint16_t high,
 	}
 }
 
-int avrule_xperms_used(av_extended_perms_t *xperms)
+int avrule_xperms_used(const av_extended_perms_t *xperms)
 {
 	unsigned int i;
 
@@ -2347,7 +2347,7 @@ unsigned int xperms_for_each_bit(unsigned int *bit, av_extended_perms_t *xperms)
 	return 0;
 }
 
-int avrule_cpy(avrule_t *dest, avrule_t *src)
+int avrule_cpy(avrule_t *dest, const avrule_t *src)
 {
 	class_perm_node_t *src_perms;
 	class_perm_node_t *dest_perms, *dest_tail;
@@ -2395,7 +2395,7 @@ int avrule_cpy(avrule_t *dest, avrule_t *src)
 	return 0;
 }
 
-int define_te_avtab_ioctl(avrule_t *avrule_template)
+int define_te_avtab_ioctl(const avrule_t *avrule_template)
 {
 	avrule_t *avrule;
 	struct av_ioctl_range_list *rangelist;
@@ -3444,9 +3444,10 @@ bad:
 	return -1;
 }
 
-static constraint_expr_t *constraint_expr_clone(constraint_expr_t * expr)
+static constraint_expr_t *constraint_expr_clone(const constraint_expr_t * expr)
 {
-	constraint_expr_t *h = NULL, *l = NULL, *e, *newe;
+	constraint_expr_t *h = NULL, *l = NULL, *newe;
+	const constraint_expr_t *e;
 	for (e = expr; e; e = e->next) {
 		newe = malloc(sizeof(*newe));
 		if (!newe)
-- 
2.32.0

