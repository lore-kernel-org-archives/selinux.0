Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A422243378
	for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 23:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140243; cv=none; b=Tn4A17LvDRe0ilXGFfZTMkd2PNm5xmp9fWLkYRUmGK4781S184+Uqwh7d7ncAansC0JfH8O8xoic+jjOdOuDVoj2ELzDLKmqCHQVngzjoQ+Jq6pm5j3AxarwPlsJjNgOonJvXt6xrbdnfdc4vCx5z2nvnXyvWdvlPaly+7VFhp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140243; c=relaxed/simple;
	bh=BpnzLKyax6TWtiI8z5VvJ/c9/Rj+WRBndKTXtAVGn38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uoenspm+jT5zwgnLmRTyzDn3E3il3gV3X0vtzspC57nNs36+EK6bTqDRnVi+hcXqqtvgz9GddTeCO+Rn+Jbhpk3DhDG9nPsnxYw9gjvl2c47iW1tzDfxX6Riv3Of6Nfwv7w43Yy8Y80Q3/CotPyj7NpnBIYbOMruSK1QkVHfzAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=D1dgoYdf; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="D1dgoYdf"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e169ac6009so505646685a.0
        for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 16:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140240; x=1753745040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y323Bbjwiz7kOG1ig3sNrpu1AYlaUiJPLBwwRFhiOWk=;
        b=D1dgoYdfyZ0QgkTxE6JBQEWKj82KrXZVf5uKyk1k3+49TTjU59qrMv1FrWAfW1RzmV
         jZtBsSS+e9tWxChRKYC3WKuGYuuyLGPkciBTq4JeFvBvkQOPUjlSsWdfSOwJWNlqtdtw
         uEoGxABS5Q23IG9flrL//RcVUec3N3qJLjVjw6kE1NPxAQGR1Ec0Ny+Khf03ObNhhvav
         zqmkXaMoNmuCvHQPSRCUxxd1LL3IJdvouMeMJUELCX0fpfxiKanvB8NmtZWLpVkSZDrm
         XCCOO8d0PlNVg6JjI9DSKkMJEagBy0Mfr6McbXlMzxYXLJ6+sUZLqilbik4myabxDzKM
         8FhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140240; x=1753745040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y323Bbjwiz7kOG1ig3sNrpu1AYlaUiJPLBwwRFhiOWk=;
        b=T87Ey7lDxFobhVzbI/rMzyPNLRJByirRuVezGF27pLTdX9CYQoab2bTvUs6mKtWw1n
         X/EdXVIu60NZyEdLJq2C3ANo7EpwBJJd27TY1G/2kLWtYMRwLUU6BF58liA3+8XXA7C4
         +omI5sbGZ7bgz+Fa4Ue2wSB94q+rcOgDFKDQa9nl8Jta+XgYGYR6C+aw90CBFWxTm3P/
         4E+qBIY+RjGBxui5oLSrzRly/1clD05yqxsRLS0dk1vs3bzKzyjVgpjSrnwkFnj+0H5s
         kVbNSSPA/vK66xIeclTe0f70L1LmjWaeeDMoGeZQb20n61BuNmpvpvGGvwARUigB/rUV
         A7VA==
X-Forwarded-Encrypted: i=1; AJvYcCVRsSt4V8OLzovQAMJvCY8erps6qvkZzB7qxHwMjPWs9ZZd4vMM5iCBk02ndiUxxr0WZ5sfcsEu@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9oc2uHXtKPEjhEjAs+LmccijYc9z/uoi/n3UvK3TDcr81zVnW
	RXTvGNSkg972yHfh9RfKvvlbfZ4+h/nPRQz3syuh784TJ5iHs2JCOBOJjxhTJAvJLQ==
X-Gm-Gg: ASbGncsBbO+AmNIwEzos3vs+41oNfQBQ7/JUvsnQMTk2FphKBI7aZTMvniZ7aXX6B6i
	qbtOyydy4rquHQRhT4LXnM9KneapH8RESqqCFyU3lgLHw4YtW6fsN/Dr4lU1iuH/Ve5xd27rUxr
	7PJpleKu1qTSNMFZiOgheLPYdL/TPwCR0tfP/V6CpB3/9OPuHOT7N2h7XuEe65Sdk47D7ANURIU
	vhKkEtPe2Y6nFdmsm4yCGMp1fi9HcXsTL77ZMszOfiuia0tyA5JAkxVS+nftQttIj7XNkhGjV+u
	orQz+Z1A7hfXRS8iBF82wKqbjEVMZsEx5+6xB3bTyvTPIzEjxi/VGUD9odFH/CAMxpHslWSAkqa
	2SsvFUDmuTZ4kwuCYIYSaj2g4PJMeBtBHekHY8PZsapYc6qcbtE98Ipt61iImlXyYYMc=
X-Google-Smtp-Source: AGHT+IEn/0WedkW/Ct25N+VJmzqiQoWSvg74koR9t2IUhPGsgaM/aI0BUSOFsXECWS85NYOIp5RRpQ==
X-Received: by 2002:a05:620a:44d4:b0:7e1:b6e4:bb6a with SMTP id af79cd13be357-7e34355df4emr3429545385a.21.1753140240075;
        Mon, 21 Jul 2025 16:24:00 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e356b2a976sm463037985a.13.2025.07.21.16.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:23:59 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [RFC PATCH v2 01/34] lsm: split the notifier code out into lsm_notifier.c
Date: Mon, 21 Jul 2025 19:21:04 -0400
Message-ID: <20250721232142.77224-37-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3473; i=paul@paul-moore.com; h=from:subject; bh=BpnzLKyax6TWtiI8z5VvJ/c9/Rj+WRBndKTXtAVGn38=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsuGPx7zQVtG4MLVmBOMoR+P7Aj3Au5ltgXEk mdejEa3cQuJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7LhgAKCRDqIPLalzeJ c0OaD/wJ14gFUQfYkbfcDThqjiB7mfqVM9/WcAJe9pYsQatrmBnu9EdOyCOz5ZDvEU3PkVjLvJa cSg/x6KadF0kcIRfEiL1c/6jFwSaz+1exkNEwkcEJIyEveKwrz+vcoZXRuXg9Uk33v8bN1jKjO4 29hj1djaZVyYQ08zSehaglK+U87O4OGOuMJviaMNabXWiBEfsVlVjMuH5PLkoP866MXFCuplqJ+ tv/iXkOW5xgJZbPSXye0xFHMrMbl1LPw8Y+QHtFdlcEsTGrwd30x4ax8OiYxJVShe+tCt7WuYmp m9RA5NO/1RIjTCOFkGzjet2uLpguyaPL9ON4QFrx/h5oONLNDthyOFY9R+q9zskH9xeoG483F/G Rh7d4iRHtpnyqyyt62g/hN1iWo9neKxwKhx+lUYsZktoATilUxt3mLz0PbNnAEpy+235soLIljz mMdOcoercg8eliA9uEk+Dh9p5wKHF+y68ZU1F6HkP+xUKkTaX8cIJYMxtwnOZfEc2hbhqsIq7lE Sn4KfxNbvcGSOkDAlXjB92rp9EKRvdkbvLCsglvb0yD/RrSJ5d0m8ORakwDNn5MQsr2GuOw4daC 0kv8yhPL5VFRmZzcyafdscmE12GNvxtBFeDp4flAL6X7YWRPCixrkUhbbxnivh/nbN7UvDYCR7u XqLtVDnCu18GT+Q==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

In an effort to decompose security/security.c somewhat to make it less
twisted and unwieldy, pull out the LSM notifier code into a new file
as it is fairly well self-contained.

No code changes.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/Makefile       |  2 +-
 security/lsm_notifier.c | 31 +++++++++++++++++++++++++++++++
 security/security.c     | 23 -----------------------
 3 files changed, 32 insertions(+), 24 deletions(-)
 create mode 100644 security/lsm_notifier.c

diff --git a/security/Makefile b/security/Makefile
index 22ff4c8bd8ce..14d87847bce8 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_SECURITY) 			+= lsm_syscalls.o
 obj-$(CONFIG_MMU)			+= min_addr.o
 
 # Object file lists
-obj-$(CONFIG_SECURITY)			+= security.o
+obj-$(CONFIG_SECURITY)			+= security.o lsm_notifier.o
 obj-$(CONFIG_SECURITYFS)		+= inode.o
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/
 obj-$(CONFIG_SECURITY_SMACK)		+= smack/
diff --git a/security/lsm_notifier.c b/security/lsm_notifier.c
new file mode 100644
index 000000000000..c92fad5d57d4
--- /dev/null
+++ b/security/lsm_notifier.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * LSM notifier functions
+ *
+ */
+
+#include <linux/notifier.h>
+#include <linux/security.h>
+
+static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
+
+int call_blocking_lsm_notifier(enum lsm_event event, void *data)
+{
+	return blocking_notifier_call_chain(&blocking_lsm_notifier_chain,
+					    event, data);
+}
+EXPORT_SYMBOL(call_blocking_lsm_notifier);
+
+int register_blocking_lsm_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&blocking_lsm_notifier_chain,
+						nb);
+}
+EXPORT_SYMBOL(register_blocking_lsm_notifier);
+
+int unregister_blocking_lsm_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&blocking_lsm_notifier_chain,
+						  nb);
+}
+EXPORT_SYMBOL(unregister_blocking_lsm_notifier);
diff --git a/security/security.c b/security/security.c
index fc8405928cc7..ea09a71d9767 100644
--- a/security/security.c
+++ b/security/security.c
@@ -90,8 +90,6 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
-
 static struct kmem_cache *lsm_file_cache;
 static struct kmem_cache *lsm_inode_cache;
 
@@ -643,27 +641,6 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	}
 }
 
-int call_blocking_lsm_notifier(enum lsm_event event, void *data)
-{
-	return blocking_notifier_call_chain(&blocking_lsm_notifier_chain,
-					    event, data);
-}
-EXPORT_SYMBOL(call_blocking_lsm_notifier);
-
-int register_blocking_lsm_notifier(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_register(&blocking_lsm_notifier_chain,
-						nb);
-}
-EXPORT_SYMBOL(register_blocking_lsm_notifier);
-
-int unregister_blocking_lsm_notifier(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_unregister(&blocking_lsm_notifier_chain,
-						  nb);
-}
-EXPORT_SYMBOL(unregister_blocking_lsm_notifier);
-
 /**
  * lsm_blob_alloc - allocate a composite blob
  * @dest: the destination for the blob
-- 
2.50.1

