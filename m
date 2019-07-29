Return-Path: <SRS0=UHz+=V2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB17BC433FF
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 08:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6A320578
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 08:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfG2IlZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:41:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34585 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbfG2IlZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Jul 2019 04:41:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id w9so42465492wmd.1
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2019 01:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w6hjZaMsiA3P0uqA6gSQG3A0bsA9reuqGUwApnVTNkQ=;
        b=AbZdMby7cmumNwtL9uKoKuSoVbyIo2XwtD0vHjNveBMElPCrwIs/xwfMgsAKvMQ97R
         ztHmrmjDKP71A8hPAWTZUtUcFxEAfooe6tct4Nc7Hw7ju2AaIKL27xeXwcxyXhZXKXNR
         e/gDbNigBqajUcvG6aWDpuX5xXQBQQEvZyi15A8+47MVx/hoTYUBarj3VZQ5RKnxxmiK
         +7h0yruWF9C0WMHcBlxMN6QeCWXE+L+Pqhd14rRUFUgiNhrlGPLlmAZf0aHK9s76rUHF
         iscvpSfpbAfX0ry/PSy2BMXt2QHtYSGUtYSVmnr66Ld/McS95IjFYaXyNEMxx/lZQQs2
         J2/Q==
X-Gm-Message-State: APjAAAW9xpc18hWbKT3OzuHpTg1S6NcasnyFsf5eny61qnKWPuBTo0Kc
        SDeyt0QazX1cEJacpgMM+ux7lCBchI3rsg==
X-Google-Smtp-Source: APXvYqz9/tms/jE+Hnx9pQbBssuJWu0W6ixfugTFDxKqg9cYHFg2TqUbYTrd+CY5EnqT7CPDU4QBzA==
X-Received: by 2002:a1c:6504:: with SMTP id z4mr96061278wmb.172.1564389682384;
        Mon, 29 Jul 2019 01:41:22 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id v5sm70190544wre.50.2019.07.29.01.41.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 01:41:21 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH v2 3/3] selinux: policydb - rename type_val_to_struct_array
Date:   Mon, 29 Jul 2019 10:41:17 +0200
Message-Id: <20190729084117.18677-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729084117.18677-1-omosnace@redhat.com>
References: <20190729084117.18677-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The name is overly long and inconsistent with the other *_val_to_struct
members. Dropping the "_array" prefix makes the code easier to read and
gets rid of one line over 80 characters warning.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/policydb.c | 14 +++++++-------
 security/selinux/ss/policydb.h |  2 +-
 security/selinux/ss/services.c |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index ffeae0e252d2..4e2f35f11d40 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -390,7 +390,7 @@ void policydb_destroy(struct policydb *p)
 	kfree(p->class_val_to_struct);
 	kfree(p->role_val_to_struct);
 	kfree(p->user_val_to_struct);
-	kvfree(p->type_val_to_struct_array);
+	kvfree(p->type_val_to_struct);
 
 	avtab_destroy(&p->te_avtab);
 
@@ -677,7 +677,7 @@ static int type_index(void *key, void *datum, void *datap)
 		    || typdatum->bounds > p->p_types.nprim)
 			return -EINVAL;
 		p->sym_val_to_name[SYM_TYPES][typdatum->value - 1] = key;
-		p->type_val_to_struct_array[typdatum->value - 1] = typdatum;
+		p->type_val_to_struct[typdatum->value - 1] = typdatum;
 	}
 
 	return 0;
@@ -819,10 +819,10 @@ static int policydb_index(struct policydb *p)
 	if (!p->user_val_to_struct)
 		return -ENOMEM;
 
-	p->type_val_to_struct_array = kvcalloc(p->p_types.nprim,
-					       sizeof(*p->type_val_to_struct_array),
-					       GFP_KERNEL);
-	if (!p->type_val_to_struct_array)
+	p->type_val_to_struct = kvcalloc(p->p_types.nprim,
+					 sizeof(*p->type_val_to_struct),
+					 GFP_KERNEL);
+	if (!p->type_val_to_struct)
 		return -ENOMEM;
 
 	rc = cond_init_bool_indexes(p);
@@ -1726,7 +1726,7 @@ static int type_bounds_sanity_check(void *key, void *datum, void *datap)
 			return -EINVAL;
 		}
 
-		upper = p->type_val_to_struct_array[upper->bounds - 1];
+		upper = p->type_val_to_struct[upper->bounds - 1];
 		BUG_ON(!upper);
 
 		if (upper->attribute) {
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 27039149ff0a..05fc672831aa 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -255,7 +255,7 @@ struct policydb {
 	struct class_datum **class_val_to_struct;
 	struct role_datum **role_val_to_struct;
 	struct user_datum **user_val_to_struct;
-	struct type_datum **type_val_to_struct_array;
+	struct type_datum **type_val_to_struct;
 
 	/* type enforcement access vectors and transitions */
 	struct avtab te_avtab;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index d3a8f6fbc552..ca56cd045bf9 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -544,13 +544,13 @@ static void type_attribute_bounds_av(struct policydb *policydb,
 	struct type_datum *target;
 	u32 masked = 0;
 
-	source = policydb->type_val_to_struct_array[scontext->type - 1];
+	source = policydb->type_val_to_struct[scontext->type - 1];
 	BUG_ON(!source);
 
 	if (!source->bounds)
 		return;
 
-	target = policydb->type_val_to_struct_array[tcontext->type - 1];
+	target = policydb->type_val_to_struct[tcontext->type - 1];
 	BUG_ON(!target);
 
 	memset(&lo_avd, 0, sizeof(lo_avd));
@@ -893,7 +893,7 @@ int security_bounded_transition(struct selinux_state *state,
 
 	index = new_context->type;
 	while (true) {
-		type = policydb->type_val_to_struct_array[index - 1];
+		type = policydb->type_val_to_struct[index - 1];
 		BUG_ON(!type);
 
 		/* not bounded anymore */
-- 
2.21.0

