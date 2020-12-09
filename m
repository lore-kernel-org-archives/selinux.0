Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B77C4167B
	for <selinux@archiver.kernel.org>; Wed,  9 Dec 2020 19:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8935123CD0
	for <selinux@archiver.kernel.org>; Wed,  9 Dec 2020 19:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387792AbgLITrE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Dec 2020 14:47:04 -0500
Received: from linux.microsoft.com ([13.77.154.182]:47492 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387857AbgLITnG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Dec 2020 14:43:06 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id A6EB720B7189;
        Wed,  9 Dec 2020 11:42:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A6EB720B7189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607542945;
        bh=13W9y/glUb8I3SzOqOuxO+1MJwZs/tFHH0a5DtYqn+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TZVpGynKEEZSZfv4sGpjoXpRov6wDOKUZe6Bk2s0M7IyWfEjL11cvBW/RiftHz9k1
         8vI8zRWmbI63YTH0/dTkHJXgwqs1bxLGX1+6La9EI/+jASChz6i/LT+0FX+9tNXTrX
         ACemq6NpMQLBt4kUsRNpMutGXMRsw7tTv2AaleWY=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v7 4/8] IMA: add policy rule to measure critical data
Date:   Wed,  9 Dec 2020 11:42:08 -0800
Message-Id: <20201209194212.5131-5-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201209194212.5131-1-tusharsu@linux.microsoft.com>
References: <20201209194212.5131-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A new IMA policy rule is needed for the IMA hook
ima_measure_critical_data() and the corresponding func CRITICAL_DATA for
measuring the input buffer. The policy rule should ensure the buffer
would get measured only when the policy rule allows the action. The
policy rule should also support the necessary constraints (flags etc.)
for integrity critical buffer data measurements.

Add a policy rule to define the constraints for restricting integrity
critical data measurements.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima_policy.c | 35 +++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 2a0c0603626e..9a8ee80a3128 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -34,6 +34,7 @@
 #define IMA_PCR		0x0100
 #define IMA_FSNAME	0x0200
 #define IMA_KEYRINGS	0x0400
+#define IMA_DATA_SOURCE	0x0800
 
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -85,6 +86,7 @@ struct ima_rule_entry {
 	} lsm[MAX_LSM_RULES];
 	char *fsname;
 	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
+	struct ima_rule_opt_list *data_source; /* Measure data from this source */
 	struct ima_template_desc *template;
 };
 
@@ -479,6 +481,12 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
 		else
 			opt_list = rule->keyrings;
 		break;
+	case CRITICAL_DATA:
+		if (!rule->data_source)
+			return true;
+		else
+			opt_list = rule->data_source;
+		break;
 	default:
 		break;
 	}
@@ -518,13 +526,19 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 {
 	int i;
 
-	if (func == KEY_CHECK) {
-		return (rule->flags & IMA_FUNC) && (rule->func == func) &&
-			ima_match_rule_data(rule, func_data, cred);
-	}
 	if ((rule->flags & IMA_FUNC) &&
 	    (rule->func != func && func != POST_SETATTR))
 		return false;
+
+	switch (func) {
+	case KEY_CHECK:
+	case CRITICAL_DATA:
+		return ((rule->func == func) &&
+			ima_match_rule_data(rule, func_data, cred));
+	default:
+		break;
+	}
+
 	if ((rule->flags & IMA_MASK) &&
 	    (rule->mask != mask && func != POST_SETATTR))
 		return false;
@@ -1119,6 +1133,19 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		if (ima_rule_contains_lsm_cond(entry))
 			return false;
 
+		break;
+	case CRITICAL_DATA:
+		if (entry->action & ~(MEASURE | DONT_MEASURE))
+			return false;
+
+		if (!(entry->flags & IMA_DATA_SOURCE) ||
+		    (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR |
+		    IMA_DATA_SOURCE)))
+			return false;
+
+		if (ima_rule_contains_lsm_cond(entry))
+			return false;
+
 		break;
 	default:
 		return false;
-- 
2.17.1

