Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F1CC77B7C
	for <selinux@archiver.kernel.org>; Fri,  5 May 2023 22:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjEEWuD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 May 2023 18:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbjEEWts (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 May 2023 18:49:48 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE8F5FD1
        for <selinux@vger.kernel.org>; Fri,  5 May 2023 15:49:46 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-61af33bdf1dso12463226d6.2
        for <selinux@vger.kernel.org>; Fri, 05 May 2023 15:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1683326985; x=1685918985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+ZVZxFhC+qOpGJjCAReTca009rA4ucMoe68kcV2dac=;
        b=MlHSMoNFMPAAS5B8NmmDf0gGkoPrpOWmf2+XA0OqhKReVff0ezTJOGSamrE5QIHMZe
         c/7O2zuZYw6AQJJsIA+9bEl/3+7cKHnLiChwVycVqHKvcRDNNVZ5Z3GYtjoWy77AOAiC
         j+07kzCD40I4ZxSzz7fBHGRtxO+QCAQlqaEuXa582oGfzWvlgAIXW65p0JCfAigEsIV8
         plyC88z/Zfl509vosZFMpFmCxiBLSBAbO8q+u3X+cjp/81L4or8BnZ6FgPT7fE99VFB4
         4vyUVtMLG9q77v3QQmNxmqBXZBJbu5ZaLxdn/4g15eIhwGK/PxuyFuFDLTjMI8mpIDYi
         KBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683326985; x=1685918985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+ZVZxFhC+qOpGJjCAReTca009rA4ucMoe68kcV2dac=;
        b=HRXKZn1f9twRswdL1AgYi78LEee4Gx1IJ2pEIdg4hnvlsjMRChUAXytfZKU94oO2zK
         9skgtsoGph2s5lx46eloO47IH6WkuwVYbGxBtP6YGd9q9Onp3T62JehrJ/+CjhymNTup
         dtJFG35lSLMVSGPCTTLsai3zmaPYKDf2QPQEk5bunDC+sHqbxonxfI/NnNSN3KgkF41t
         PJuiBgNsCKpjalD3haFs8gCoKEHSm888Gr9ke+GDLhfu+mBglRPi3JfCcqAs9jbSLMDJ
         xXXTVSXk2RxxuWYyyspwRaty56Sa6u6s0lxlRJZ2C+GHXJQR90sy2JS3IUwXW0NwlpSn
         JTFA==
X-Gm-Message-State: AC+VfDyQhPCgpisXhmjAnHKBEQg9T4NeYsFf73GaTppJhv92kgV1GyvA
        scrqcjGfZlyzO2MguljfyMGwAmbRtFUbG2AV+A==
X-Google-Smtp-Source: ACHHUZ7TpIvI6v7gUqw/8ePyxnSL9UdFY/YoqgJxbEerM0w1X39W/jEYJvy4deFlK5R5WZ6o0/AA4g==
X-Received: by 2002:a05:6214:21aa:b0:600:5dbc:c31a with SMTP id t10-20020a05621421aa00b006005dbcc31amr4077340qvc.7.1683326984998;
        Fri, 05 May 2023 15:49:44 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id v16-20020a0cdd90000000b0061b721f27b3sm912242qvk.123.2023.05.05.15.49.44
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 15:49:44 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] selinux: small cleanups in selinux_audit_rule_init()
Date:   Fri,  5 May 2023 18:49:44 -0400
Message-Id: <20230505224944.645203-1-paul@paul-moore.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A few small tweaks to selinux_audit_rule_init():

- Adjust how we use the @rc variable so we are not doing any extra
  work in the common/success case.

- Related to the above, rework the 'out' jump label so that the
  success and error paths are different, simplifying both.

- Cleanup some of the vertical whitespace while we are making the
  other changes.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ss/services.c | 38 ++++++++++++++++------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index f14d1ffe54c5..7840797be23c 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3541,38 +3541,38 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 	tmprule = kzalloc(sizeof(struct selinux_audit_rule), GFP_KERNEL);
 	if (!tmprule)
 		return -ENOMEM;
-
 	context_init(&tmprule->au_ctxt);
 
 	rcu_read_lock();
 	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
-
 	tmprule->au_seqno = policy->latest_granting;
-
 	switch (field) {
 	case AUDIT_SUBJ_USER:
 	case AUDIT_OBJ_USER:
-		rc = -EINVAL;
 		userdatum = symtab_search(&policydb->p_users, rulestr);
-		if (!userdatum)
-			goto out;
+		if (!userdatum) {
+			rc = -EINVAL;
+			goto err;
+		}
 		tmprule->au_ctxt.user = userdatum->value;
 		break;
 	case AUDIT_SUBJ_ROLE:
 	case AUDIT_OBJ_ROLE:
-		rc = -EINVAL;
 		roledatum = symtab_search(&policydb->p_roles, rulestr);
-		if (!roledatum)
-			goto out;
+		if (!roledatum) {
+			rc = -EINVAL;
+			goto err;
+		}
 		tmprule->au_ctxt.role = roledatum->value;
 		break;
 	case AUDIT_SUBJ_TYPE:
 	case AUDIT_OBJ_TYPE:
-		rc = -EINVAL;
 		typedatum = symtab_search(&policydb->p_types, rulestr);
-		if (!typedatum)
-			goto out;
+		if (!typedatum) {
+			rc = -EINVAL;
+			goto err;
+		}
 		tmprule->au_ctxt.type = typedatum->value;
 		break;
 	case AUDIT_SUBJ_SEN:
@@ -3582,20 +3582,18 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 		rc = mls_from_string(policydb, rulestr, &tmprule->au_ctxt,
 				     GFP_ATOMIC);
 		if (rc)
-			goto out;
+			goto err;
 		break;
 	}
-	rc = 0;
-out:
 	rcu_read_unlock();
 
-	if (rc) {
-		selinux_audit_rule_free(tmprule);
-		tmprule = NULL;
-	}
-
 	*rule = tmprule;
+	return 0;
 
+err:
+	rcu_read_unlock();
+	selinux_audit_rule_free(tmprule);
+	*rule = NULL;
 	return rc;
 }
 
-- 
2.40.1

