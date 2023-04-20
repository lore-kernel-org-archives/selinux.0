Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59A5C77B76
	for <selinux@archiver.kernel.org>; Thu, 20 Apr 2023 15:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjDTPFy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Apr 2023 11:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbjDTPFy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Apr 2023 11:05:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6758527A
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:05:52 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id dm2so7057868ejc.8
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682003151; x=1684595151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWjcK5QBFoPapJ2mUnTvrIxFHaP0NjqWeXLAOwwwqVQ=;
        b=qfsmhjAjPUK+vRtFe3VN5A7/rM1mE6pBbIjgo7b1MewD+JfVrRaSOSeoM5ci+/zCPd
         cwNGZJshSJfT9EzDCkMdLU2Zus4+EvLlNzPugppx5XkvEQisF71mjNbH3xFTrCJzZ5rL
         v9dipBs3+Oi6rWG1JRgbZuUZi5AJFlmBZQhylEgcDDEOKe9E7Lci6ZCSD5RyADzm2K0k
         PytMP0C3zS4ZHj6EXIzNonQPUYU8D3PDEf2v/YtmJXUfWseKOA0iATL4dlEGUL06EGa5
         tnGuPExUIpvOD0tad/08Ovntcs/CkmiJQzUavtNTpPn5zuHZW7mRG1p7qdewYidXhqQi
         o+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682003151; x=1684595151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWjcK5QBFoPapJ2mUnTvrIxFHaP0NjqWeXLAOwwwqVQ=;
        b=d4ddvd+JcGtJmCPbDFKNDmYkMEyYmoeOlLcgOP1Il01dZYMI99dBtVwv02fU4N5EqI
         irSm0/goeohNv+Pbjj+cIP6xMV1nOFlTuDSbNhyLySot+mCknU4WY0vvwpFriLD04gif
         98g6nRNkUUqvHP0zwVBd8ZA7IbcQ4PHv1M6HipOaXNQLEQvKiJFHcQGdyROkLxwtfY5c
         erxqxik4ooxUt+jUSiJ4Nv/KpKPdKtOGP6gBlSkhMO3lYjBDgARDdS3E6b2YMJrNAi6a
         2jYiCrhNpwYcs706lr7CP+H4FGpAjyFqHkTI+rWR1kQ7m6Y9FHzFUmA4w2fFB2HdatsU
         tuag==
X-Gm-Message-State: AAQBX9fJXAYZvNyP3k1uxMKQrgZtmVpOlc3RsNBOSO3ZkC6VaAFES2TU
        pa3wTn0unN3Cq/F6EfhbPcY=
X-Google-Smtp-Source: AKy350b6dbHXse+0G0vXW8ZMhMZFkx1BBcW9L60OPz4+7vOpac5uWRRS/YoTmxbsWXt9yQ27FdoaoA==
X-Received: by 2002:a17:906:5648:b0:94f:2eb1:ffd2 with SMTP id v8-20020a170906564800b0094f2eb1ffd2mr2071423ejr.40.1682003150953;
        Thu, 20 Apr 2023 08:05:50 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-119-201-251.95.119.pool.telefonica.de. [95.119.201.251])
        by smtp.gmail.com with ESMTPSA id jo2-20020a170906f6c200b009538cc79241sm827430ejb.56.2023.04.20.08.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 08:05:50 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Subject: [PATCH 2/6] selinux: adjust typos in comments
Date:   Thu, 20 Apr 2023 17:04:59 +0200
Message-Id: <20230420150503.22227-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230420150503.22227-1-cgzones@googlemail.com>
References: <20230420150503.22227-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Found by codespell(1)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/hooks.c         | 2 +-
 security/selinux/ima.c           | 2 +-
 security/selinux/include/audit.h | 2 +-
 security/selinux/include/ima.h   | 2 +-
 security/selinux/selinuxfs.c     | 2 +-
 security/selinux/ss/services.c   | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 79b4890e9936..c49ce2044a17 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -937,7 +937,7 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
 }
 
 /*
- * NOTE: the caller is resposible for freeing the memory even if on error.
+ * NOTE: the caller is responsible for freeing the memory even if on error.
  */
 static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 {
diff --git a/security/selinux/ima.c b/security/selinux/ima.c
index 7daf59667f59..aa34da9b0aeb 100644
--- a/security/selinux/ima.c
+++ b/security/selinux/ima.c
@@ -4,7 +4,7 @@
  *
  * Author: Lakshmi Ramasubramanian (nramas@linux.microsoft.com)
  *
- * Measure critical data structures maintainted by SELinux
+ * Measure critical data structures maintained by SELinux
  * using IMA subsystem.
  */
 #include <linux/vmalloc.h>
diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
index 406bceb90c6c..d5495134a5b9 100644
--- a/security/selinux/include/audit.h
+++ b/security/selinux/include/audit.h
@@ -41,7 +41,7 @@ void selinux_audit_rule_free(void *rule);
  *	selinux_audit_rule_match - determine if a context ID matches a rule.
  *	@sid: the context ID to check
  *	@field: the field this rule refers to
- *	@op: the operater the rule uses
+ *	@op: the operator the rule uses
  *	@rule: pointer to the audit rule to check against
  *
  *	Returns 1 if the context id matches the rule, 0 if it does not, and
diff --git a/security/selinux/include/ima.h b/security/selinux/include/ima.h
index 05e04172c86d..93c05e97eb7f 100644
--- a/security/selinux/include/ima.h
+++ b/security/selinux/include/ima.h
@@ -4,7 +4,7 @@
  *
  * Author: Lakshmi Ramasubramanian (nramas@linux.microsoft.com)
  *
- * Measure critical data structures maintainted by SELinux
+ * Measure critical data structures maintained by SELinux
  * using IMA subsystem.
  */
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 69a583b91fc5..7cc7e2f0272b 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -951,7 +951,7 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 		 * either whitespace or multibyte characters, they shall be
 		 * encoded based on the percentage-encoding rule.
 		 * If not encoded, the sscanf logic picks up only left-half
-		 * of the supplied name; splitted by a whitespace unexpectedly.
+		 * of the supplied name; split by a whitespace unexpectedly.
 		 */
 		char   *r, *w;
 		int     c1, c2;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index f14d1ffe54c5..9571a447e427 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -583,7 +583,7 @@ static void type_attribute_bounds_av(struct policydb *policydb,
 
 /*
  * flag which drivers have permissions
- * only looking for ioctl based extended permssions
+ * only looking for ioctl based extended permissions
  */
 void services_compute_xperms_drivers(
 		struct extended_perms *xperms,
-- 
2.40.0

