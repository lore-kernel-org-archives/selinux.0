Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32FF126BE8
	for <selinux@vger.kernel.org>; Tue,  3 Sep 2024 22:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725404215; cv=none; b=Px4GtRwBMc1cWloosYfz3fWKS+ccdJfLNBAmu6aRbiJC1K8nj4sSNA6Vk5nDQPq06vvXDR5YdKzd7pUsKrOpPWV+92YRqFBkLmZt9Qxd6mJ7UYD9LeqIlFz163qaMY7IHFu3KM8Y3mlZvBnA72SkweSOMjvy7LjZUJOMGbZ0Rkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725404215; c=relaxed/simple;
	bh=dFOPSGhbKzzDMinNits5m6xV0TyTzthuQfHfS6K8/YE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=idffEB4hF2nev0+hdyr5lRiHf+mllwjIXFN/5Zn1bQd/474NzSgAE6xizwzoHjvFmaeVYt5L/7abKTE+CfPM1sjnXHSsasjlkJkmC0n0ZDLDVBJ9y3vL93Uamx0eAJ7U2pR5fY3u1vbzc4VMEFZXB4IRHIIxlpb/+rDP2soC8OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=A70g6gkr; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="A70g6gkr"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5dfa315ccf1so141166eaf.3
        for <selinux@vger.kernel.org>; Tue, 03 Sep 2024 15:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725404213; x=1726009013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kYavisSilh2mdBF7g1ge2WYh6C/PDdZIJoupxBqhO9c=;
        b=A70g6gkrwZZjA/sl04nyOGLlVBCIWAhLD19BTrAzqtQDvhVCKEtuZ6lAiKyWp9pe5d
         eZLNVcKWtUVkzkQql3veG1lpcqnPSbGu9DNrGvso0DkFyVdiYdRYBm2KQmuzDmbkCXaC
         nXnYQuDLWx5YH3gCk+SPpmZBIEcaoZQ9mUXpVg/l2QeUz1aOE4ggb0+geXhE48Hz2+fj
         Gy13gCrmcGIwYRFpinLIdvxeyXNOPqckeeNT323D49Az9ArJZAoG4f28Vl2l/Rn1iNuS
         7CqaWVC4hR5l+KAOzNVoEy3gHnyieFLtIPY0SGIVVk6tR9ews4VzGjMYO1mJpA7c8TiU
         oLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725404213; x=1726009013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kYavisSilh2mdBF7g1ge2WYh6C/PDdZIJoupxBqhO9c=;
        b=nfYFSrqb7UBtsDDw4+BTty3mIlobgRMYqgyLXfvqNNQs439XDw9tn9wK+zinPTRV6b
         WB6bsMWyB2t/AJuLsiQjppUK0ZVHCqMUtqZ26wCNQ0xshtsQXMHH1oo1sCFwZgcu9TEN
         J6vRF+1rMIhMxSWB/jhggJI/C9ZAO814a5a3NiEZ6ijoAUDcKFI0KxsIItEU3iT6Nd86
         bk2sxYCBePsh8mXmNCK9rAPKLrTg8Msx1/a5V3eY9OHOY7gdGvbKBFDSevh6D2OT/EMm
         nYELMO7/7431nNwb45JKzD53P4Aj8Q86BwEnMZcmIxg1QCID55uoBNeUDUOdOGTgq63g
         Lp5g==
X-Gm-Message-State: AOJu0Yy/QZHfqr71fuGQ7oOpwYwcBbEHOy9Dd6V3MPIUJ+5hu7jS+Zd9
	Ye+Uu3jnyZQ5QxJyk1b1DpBGARbFVCtdHllkq7JxrRcUcvzIwTa6OAtzalIPnG7RkcflePMTgB4
	=
X-Google-Smtp-Source: AGHT+IEzLuGZyMt/eniz+QE9lmcKkr/uQXBHRfEsA+RqILMJzPAEM1RCQz7j7fjW51lTeaot1i2MSg==
X-Received: by 2002:a05:6870:e248:b0:277:eb68:2878 with SMTP id 586e51a60fabf-277eb6837c3mr8975480fac.44.1725404212721;
        Tue, 03 Sep 2024 15:56:52 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d6bccfsm571222985a.124.2024.09.03.15.56.52
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 15:56:52 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH] selinux: fix style problems in security/selinux/include/audit.h
Date: Tue,  3 Sep 2024 18:56:46 -0400
Message-ID: <20240903225645.282250-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3380; i=paul@paul-moore.com; h=from:subject; bh=dFOPSGhbKzzDMinNits5m6xV0TyTzthuQfHfS6K8/YE=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBm15QtT92MNEhtWR9Ej9n0cCdSwW/fVv9UKsMkq UqqSCAOJ7eJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZteULQAKCRDqIPLalzeJ c72jEACt2q4b3q6O7fSuMCLyqtBPug+DXM8CewrlYwvPCOyT5VGi/HMhrLsqzuEFnzAy8KDzWoe PbBKRRB6lyNpdqq7/sdyyuCsI7ZgQcZadeUv/+jQB/BaWD0+YO7gSSWTijcGmGE+u3kDX9AH2LE JMTsovakb/+fH7iobp3/hCIdaMO6eVf1Nuzcyyke1f3sX5M20x9VEp+V2GEmcSUnZdhKnnjfHFi ctYAGEkX+dZjPrjjxacHnTcCr3DGhsGAz7u/BLCyU9orCl/ysuA3viXUBuI9HJ+t+9d0WYqMMil LTUWWos0fW2NyRAfsHkkDg7tA2Of+vw+jqz+jhtDvIxiVzeLaxdUpkPNHSyorVIe42OGEVsIWHj uRP3h4lFJob3e5ksiQIpQxfYdFsqxA8+k4nMSvBm67YAPTq9NlBrRWE/XJ1C0jsys5eIMwMxjYj gx3S47EkDF54gYKxsekPoFjgClQwsibdR0hOJ4g2O15bm8bgSjVP2qai2deVVpZOGy/1LaMCOjX TwS9X8hp2zUM36TCV0shXpLTLAzIMhwotEqz0ZWFo18JJRWAFeF4HEnj8GDXc1x9IpmDtBuJk8+ atLp9WTTIQAr4Ztmp848MzygLTPeGaVfxyTpKYFsIl8E6Y2IHVQYqUMla9hHLEFaelfd8jHShga HiXJKSZLAFLCtTA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Remove the needless indent in the function comment header blocks.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/include/audit.h | 46 ++++++++++++++++----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
index 29c7d4c86f6d..168d17be7df3 100644
--- a/security/selinux/include/audit.h
+++ b/security/selinux/include/audit.h
@@ -16,45 +16,45 @@
 #include <linux/types.h>
 
 /**
- *	selinux_audit_rule_init - alloc/init an selinux audit rule structure.
- *	@field: the field this rule refers to
- *	@op: the operator the rule uses
- *	@rulestr: the text "target" of the rule
- *	@rule: pointer to the new rule structure returned via this
- *	@gfp: GFP flag used for kmalloc
+ * selinux_audit_rule_init - alloc/init an selinux audit rule structure.
+ * @field: the field this rule refers to
+ * @op: the operator the rule uses
+ * @rulestr: the text "target" of the rule
+ * @rule: pointer to the new rule structure returned via this
+ * @gfp: GFP flag used for kmalloc
  *
- *	Returns 0 if successful, -errno if not.  On success, the rule structure
- *	will be allocated internally.  The caller must free this structure with
- *	selinux_audit_rule_free() after use.
+ * Returns 0 if successful, -errno if not.  On success, the rule structure
+ * will be allocated internally.  The caller must free this structure with
+ * selinux_audit_rule_free() after use.
  */
 int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **rule,
 			    gfp_t gfp);
 
 /**
- *	selinux_audit_rule_free - free an selinux audit rule structure.
- *	@rule: pointer to the audit rule to be freed
+ * selinux_audit_rule_free - free an selinux audit rule structure.
+ * @rule: pointer to the audit rule to be freed
  *
- *	This will free all memory associated with the given rule.
- *	If @rule is NULL, no operation is performed.
+ * This will free all memory associated with the given rule.
+ * If @rule is NULL, no operation is performed.
  */
 void selinux_audit_rule_free(void *rule);
 
 /**
- *	selinux_audit_rule_match - determine if a context ID matches a rule.
- *	@sid: the context ID to check
- *	@field: the field this rule refers to
- *	@op: the operator the rule uses
- *	@rule: pointer to the audit rule to check against
+ * selinux_audit_rule_match - determine if a context ID matches a rule.
+ * @sid: the context ID to check
+ * @field: the field this rule refers to
+ * @op: the operator the rule uses
+ * @rule: pointer to the audit rule to check against
  *
- *	Returns 1 if the context id matches the rule, 0 if it does not, and
- *	-errno on failure.
+ * Returns 1 if the context id matches the rule, 0 if it does not, and
+ * -errno on failure.
  */
 int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *rule);
 
 /**
- *	selinux_audit_rule_known - check to see if rule contains selinux fields.
- *	@rule: rule to be checked
- *	Returns 1 if there are selinux fields specified in the rule, 0 otherwise.
+ * selinux_audit_rule_known - check to see if rule contains selinux fields.
+ * @rule: rule to be checked
+ * Returns 1 if there are selinux fields specified in the rule, 0 otherwise.
  */
 int selinux_audit_rule_known(struct audit_krule *rule);
 
-- 
2.46.0

