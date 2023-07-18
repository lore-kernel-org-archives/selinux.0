Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25838EB64DC
	for <selinux@archiver.kernel.org>; Tue, 18 Jul 2023 19:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjGRTAf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 15:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjGRTAe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jul 2023 15:00:34 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E89B198
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 12:00:29 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9922d6f003cso834610466b.0
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 12:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1689706828; x=1692298828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tGm76TP2Lzl4mroJqgC7s33076/FSW+9yWS/FMEJBvA=;
        b=UKIUbt6dJJY4dJwVSTWACZKrBTu5AkKmqKtngXTz3AvEKfC8StppXxuxFb7pr3c4Jr
         6Ds9Eal2FZp9nYAnU8cn50Py8eeIEwR0VRXiVGni8imMPIp8gfdC002kxPwMX81f7X0V
         Wc1m31rXWCG1hN63YoQservUmdWLQt7cd+feFHBrroifqqKDoMhygQg/poIt+q/i7duR
         wUMz/2IUtehtONKTUh96JNdBOFuevb2SvkHE9xSbHcQAAc9YdWaobZgYfVXA3B5kTHqh
         PUH5Jh16dafJfnSgW+210gVT91VyOmx3ee9oAtHros6cjG1YGR+f2VM5ZoNnfXOvC6Qp
         VwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689706828; x=1692298828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGm76TP2Lzl4mroJqgC7s33076/FSW+9yWS/FMEJBvA=;
        b=LcR3I2p6rcN1SxWAz5bYoyWfFsYBkagIkvCmYzsoUfS+Kdtje6taaCCrZqlCBh9k8k
         gJ63yZuf0jIV6s0KMSDyie8bmduZ+qkNoNB6yQxGLT/nPrGar2DRBgMq4qWzGqFJ4LFO
         7W97bQY0GhrlGcbVO064Thx4kXJv4hj1acLsj/fS8bxLOJPsZnh9m2IXqDy7lWIe0HW1
         1leZnl4Oh0oweVubMekHtXO2Q2Gpw8CG6X7NBz5P3YHlBy7RifeFgE57sQhNU8U25DPd
         G5HbK2OwLNmEQMFMHGQAznXBkDnRUDXvfkOsji7DeB23aPusBWKdJLg6bGxQeT7gcOLb
         om0Q==
X-Gm-Message-State: ABy/qLZ+eg1a+03lb/bC3PLLtJ4MI7MJz/kM/bAGUNqzmggDxGo3Wy5D
        Kz+eSuShjj6ic+IfWrWJy3lMjrEI81Hg0A==
X-Google-Smtp-Source: APBJJlHCMnWYPTsSZYszLilq2d6auZzBU/l9R5CauoqtQOGvo8ZrhKsoo5KDR9AT+SjrNcK50MqPgg==
X-Received: by 2002:a17:907:7819:b0:988:9d0f:db52 with SMTP id la25-20020a170907781900b009889d0fdb52mr660311ejc.35.1689706827754;
        Tue, 18 Jul 2023 12:00:27 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-119-136-221.95.119.pool.telefonica.de. [95.119.136.221])
        by smtp.gmail.com with ESMTPSA id a11-20020a170906244b00b0099307a5c564sm1352669ejb.55.2023.07.18.12.00.27
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 12:00:27 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] selinux: add missing newlines in print statements
Date:   Tue, 18 Jul 2023 21:00:24 +0200
Message-Id: <20230718190024.117662-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The kernel print statements do not append an implicit newline to format
strings.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/hooks.c       | 2 +-
 security/selinux/ss/policydb.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b8a8a4f0f2ad..121741e63c48 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2930,7 +2930,7 @@ static int selinux_inode_init_security_anon(struct inode *inode,
 		struct inode_security_struct *context_isec =
 			selinux_inode(context_inode);
 		if (context_isec->initialized != LABEL_INITIALIZED) {
-			pr_err("SELinux:  context_inode is not initialized");
+			pr_err("SELinux:  context_inode is not initialized\n");
 			return -EACCES;
 		}
 
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index cfe77ef24ee2..61e0e5000025 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1687,7 +1687,7 @@ static int user_bounds_sanity_check(void *key, void *datum, void *datap)
 
 		if (++depth == POLICYDB_BOUNDS_MAXDEPTH) {
 			pr_err("SELinux: user %s: "
-			       "too deep or looped boundary",
+			       "too deep or looped boundary\n",
 			       (char *) key);
 			return -EINVAL;
 		}
@@ -1766,7 +1766,7 @@ static int type_bounds_sanity_check(void *key, void *datum, void *datap)
 
 		if (upper->attribute) {
 			pr_err("SELinux: type %s: "
-			       "bounded by attribute %s",
+			       "bounded by attribute %s\n",
 			       (char *) key,
 			       sym_name(p, SYM_TYPES, upper->value - 1));
 			return -EINVAL;
@@ -3675,7 +3675,7 @@ int policydb_write(struct policydb *p, void *fp)
 	info = policydb_lookup_compat(p->policyvers);
 	if (!info) {
 		pr_err("SELinux: compatibility lookup failed for policy "
-		    "version %d", p->policyvers);
+		    "version %d\n", p->policyvers);
 		return -EINVAL;
 	}
 
-- 
2.40.1

