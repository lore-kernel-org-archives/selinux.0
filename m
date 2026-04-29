Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0966A3FD128
	for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482535; cv=none; b=r2j6McZe3RtgRUjsShBfW/7LDLCYdwwheS2k69jp4HZohrQVOD6/dNchhV6UHGxBRAYjmbeul/LaNx/02ff1esQJT+8e/NRAbTabXEzZzPFj07A+sW4B4Q8ICz1GJNCnxPvUs6My3AkHoaTHkOmqRfwr9qiwj7n8lhzSdvJAhlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482535; c=relaxed/simple;
	bh=PbnUl6sBBd4f5/Bp+Rhh0f/wIF4UzzNkCC25JD/uBNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXNjqCEFDvTHRzvFWuG20pzpswR9M5ZdCgVu7hTv2LCByxOr6FG7b0KoSaRdBFGc60JnX0Pa7aIBxumlB2I9a5D6WN8AVC6yr7b6PGbs96dq3zTT0M9b8dhGh3AqqoyT2ymC7iQmDWGNhRNXqwgupgnn4/6UOaNMaKzNdy18md4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUxoulII; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUxoulII"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8ee9ec26edaso964376485a.2
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 10:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777482533; x=1778087333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNkOsBWZF9SGD77Q5byqh8HDnKpnfonBP8zQTkY7+Yw=;
        b=DUxoulIIPffXOzXZsSTLvGbiarfLLGh9V6ilAXp4DqprrEVM5vX+Atg3Ri0xmSz2ve
         WKJatZKuTsnw4aEWLslhPcoRXxasqzhqYJVq71AWsfQP2k1nzX8F2VVYVRe2AjOj+pqi
         tN4n2jPtFYLWCd5LeWrpr9wziGTRxq9ICSh1jSOQsDcadU3GObNC7dVgI6iWwn84vEqw
         8q6pjZ15XQmDonN3fdu0pnPmCiuqFf9jJb8VbFkSUvTqBhcKLwr+XdKMALV8QBxlSNuO
         UajuSIAq7NN4WBSO6gbWHUm7hkGw51fNhU2Ncw8sukoWCbV33SdhMyN5CIwqgQTk/Fot
         NMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777482533; x=1778087333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rNkOsBWZF9SGD77Q5byqh8HDnKpnfonBP8zQTkY7+Yw=;
        b=qvVoryh2CJGzHy0OqTkOcW8JTbWvTVlcOLRfiFIY5hIWaLexzmiRE5Zd5v68qF/8C4
         JUeCfGOrD+z7hysQT6BaqrRlcPnRJMvg5sMOejwpGdqIoYebfwBXlH/VB8uGRVoMJWpo
         Kcml81F63SThyFP79r4XZ6Wr3W+A7sOjTSMKONVXTu/rUEm/TfFqOUlbUWUugy5Yc1/8
         4EsSkJyOiD7UPbuvqxEp0T2npzmr5vEH71KHLTxzNqDSf2SgunGyCA5vq99L3oQ0UH6X
         DgSYoHPJF5MIHJJ6tUcYt2dttfkd23zHhRoNPmOW3L2rVRHn7DIGeiCTS0JjkyEK9bq7
         nSDg==
X-Gm-Message-State: AOJu0YwMVZ2NnC3MOJwTjtj3tatZypi+E/Isfrom+vK1uCRCpJ0q0mwQ
	nINleESjP5F4Hn3WvOsVRHPUFJXiCjPPzCltaQeQCkUEPxZCkDhetQhLzro34A==
X-Gm-Gg: AeBDieudzbgePJQbsx13g5AzmyYcOcaX4anry2D0jv6m4PciuFQg4fi1sQRteFk8IGr
	dkuNk0jEVeKOcUXSifc96L6M9WrqdtejFP+svptrG8SvbiqtkTbo5wlmleczMxxqd8TUUXPtRGO
	cUgeeVGqqaPuPV/QoB/8+KgrdZgrJO7niCAaR8aVUtVuKHsugq8PxcXeK65ZtsSYpX2CVKkiZab
	FYFDhdjJJrqMIcxiiU4tGoF/Bd+xdGioxbmjOATgzlZqp2LCN3G99eU9sllk8uufI/WDhrJ7hl5
	DdHIXQJc1Rgfinswvz3veRz+Kpp9oE/6FhEo2icRR5uMiAq3AtK15XBqoLCv9sQvik1o6e+jjcM
	hhjBYNt3vtQqpuIbS1eIiHVybQTO3/yq3/48hf2rL26BiZvmPBz7IoqI9FKDYVnUMgCFcPOMYyT
	LLJUaQl21YzLpqg1LSnflqrDQZpTgzTrTsvon0bjs4TdjBIeohF1OMIZmEWtcTItKusYUbvj2nm
	TujE+plF4ur7s0oTDLk+D5Z9C5/+bUh/OrS4rEGXNIIDgWa2HRluptkhfz6vrjepg==
X-Received: by 2002:a05:620a:4446:b0:8e9:13ea:a0e7 with SMTP id af79cd13be357-8f7d94fcbfemr1147202185a.41.1777482532595;
        Wed, 29 Apr 2026 10:08:52 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f93f58333esm225980685a.28.2026.04.29.10.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 10:08:52 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/3] selinux: remove /sys/fs/selinux/disable
Date: Wed, 29 Apr 2026 13:08:32 -0400
Message-ID: <20260429170833.2581-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429170833.2581-1-stephen.smalley.work@gmail.com>
References: <20260429170833.2581-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f22f9aaf6c3d ("selinux: remove the runtime disable functionality")
removed the SELinux runtime disable functionality but left the
/sys/fs/selinux/disable node intact and logged an error message.
Get rid of it entirely.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/selinuxfs.c | 42 ------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 678cf0ad1d6c..5a80aff2a941 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -56,7 +56,6 @@ enum sel_inos {
 	SEL_POLICYVERS,	/* return policy version for this kernel */
 	SEL_COMMIT_BOOLS, /* commit new boolean values */
 	SEL_MLS,	/* return if MLS policy is enabled */
-	SEL_DISABLE,	/* disable SELinux until next reboot */
 	SEL_MEMBER,	/* compute polyinstantiation membership decision */
 	SEL_CHECKREQPROT, /* check requested protection, not kernel-applied one */
 	SEL_COMPAT_NET,	/* whether to use old compat network packet controls */
@@ -267,46 +266,6 @@ static const struct file_operations sel_handle_status_ops = {
 	.llseek		= generic_file_llseek,
 };
 
-static ssize_t sel_write_disable(struct file *file, const char __user *buf,
-				 size_t count, loff_t *ppos)
-
-{
-	char *page;
-	ssize_t length;
-	int new_value;
-
-	if (count >= PAGE_SIZE)
-		return -ENOMEM;
-
-	/* No partial writes. */
-	if (*ppos != 0)
-		return -EINVAL;
-
-	page = memdup_user_nul(buf, count);
-	if (IS_ERR(page))
-		return PTR_ERR(page);
-
-	if (sscanf(page, "%d", &new_value) != 1) {
-		length = -EINVAL;
-		goto out;
-	}
-	length = count;
-
-	if (new_value) {
-		pr_err("SELinux: https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-runtime-disable\n");
-		pr_err("SELinux: Runtime disable is not supported, use selinux=0 on the kernel cmdline.\n");
-	}
-
-out:
-	kfree(page);
-	return length;
-}
-
-static const struct file_operations sel_disable_ops = {
-	.write		= sel_write_disable,
-	.llseek		= generic_file_llseek,
-};
-
 static ssize_t sel_read_policyvers(struct file *filp, char __user *buf,
 				   size_t count, loff_t *ppos)
 {
@@ -1904,7 +1863,6 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 		[SEL_POLICYVERS] = {"policyvers", &sel_policyvers_ops, S_IRUGO},
 		[SEL_COMMIT_BOOLS] = {"commit_pending_bools", &sel_commit_bools_ops, S_IWUSR},
 		[SEL_MLS] = {"mls", &sel_mls_ops, S_IRUGO},
-		[SEL_DISABLE] = {"disable", &sel_disable_ops, S_IWUSR},
 		[SEL_MEMBER] = {"member", &transaction_ops, S_IRUGO|S_IWUGO},
 		[SEL_CHECKREQPROT] = {"checkreqprot", &sel_checkreqprot_ops, S_IRUGO|S_IWUSR},
 		[SEL_REJECT_UNKNOWN] = {"reject_unknown", &sel_handle_unknown_ops, S_IRUGO},
-- 
2.54.0

