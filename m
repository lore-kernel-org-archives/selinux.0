Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E3824729C
	for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 23:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140270; cv=none; b=P8doBaA22uGMS36OYtTu3R/XyH1Dnc6Kwu4cRP0e2Sed2FmZs0bNVdrYzzZmz/QuFOd8/1FG2t5hnSpkL/XRDpxGZMhi5XexX10eSnAbCZ1a26xtaeDa1petctZd/Hb+TIT94f1Z+TsX9YdFbbu358VtPgSw58BKY/FhMr2KpZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140270; c=relaxed/simple;
	bh=8+Yydcda6gliFzIbMQ67RWaGm58avhDYOeg3/XQTpM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYO35dJZ1WyevVAWwljkP0nLf784obvWkATL/jEPsdqZ/o4eAhRp4xy0gXlW2a6x/43mG97t2uaiqGrlmi5GrvPmsOcq37hQKyX8a9oN9zal1xoFSeodCrMacs+JcgOboucHdO6JUIqV9xSly6HZYZP2cU20/5G03tVEhXj9QAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QUDlghoc; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QUDlghoc"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7d7f0fcef86so465698685a.1
        for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 16:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140268; x=1753745068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLTyhJDYMSyoHFCFlVi497HntNvu8sDWshQggyDb5II=;
        b=QUDlghocR5KWTObSbpmm81ZI0gThksittSJW87ClipV7gopwxfZL8k3nO+SjNfCQRb
         jd/Ue7HrH+os4ysUJBdmJNSYqXSmDW3/ClcnVc79nDmtlfH7r5rOej5QS35ZrzrySuOv
         PUYJ8XhZrBkHQXP3hFJ6J49nr3J1Rt8UIlktstUqDP+0yPoz4niExzwJySdwPtOcVj2t
         W3lfC7jovmqLzk4qTLxJb87aPC+fkXjZNfnFF7ujz2ZcEXCzHtmlPBK50P/3H9cLfpTe
         fzxx9Glvg53j6e67BCWyPs9I/MSzaQjD+dJVl0l1pQPepCOC7zOfPrScT5lZYGnzrmsY
         cR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140268; x=1753745068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLTyhJDYMSyoHFCFlVi497HntNvu8sDWshQggyDb5II=;
        b=tHPQm2yfRr+usOgJC4JsUejoUdE4cUMyrKJTT2RdWdNkS6ZT+nauP+V/23wWMzFBC9
         4BWGXj3F8bavhjhtF+jjxMTvTvO9ZMlnxreMIFTcjrfQoBJeJoNYzuS7KfywCSoNq5Xr
         nF/4DFE1vqoG2jYtqr5rhVNCDP3gLnmiifnDNXUItGDCr+msNQ+BKqPTQl+tmmqn27PT
         scfQrRzOlF8e2SfrhR36//rnDpZmhApHJ9SGkyajWWQDTEccPH+iChpIzn8h/IcKPG6p
         C8W7JXVjkthaUB5G6PuV+Hk1GzqH8Sz+LR6097ht9t0q947unIIsmk5pBkhaSSgB58Dt
         X5UA==
X-Forwarded-Encrypted: i=1; AJvYcCVXQIz3Tl5aofPKkiJ+tG5OVcVcZmARg0dMtCPyvWPd4G0OGQoN61cVbQrSShvtN0eTJ8+ah/Kf@vger.kernel.org
X-Gm-Message-State: AOJu0Yw11vtEEM/fkmodJ6BqF8yJh6benQgMI6ctM6Op1popTRnoXy4T
	hXa6+P8Jezs6kyf4WlmrKD7Bnfr91DHDjmP7486evZmUADPZuQKsgeOToYwUftcdJw==
X-Gm-Gg: ASbGncs9MHWbS+xvaCsCIhWOLHd5DQ76SkCCLkXa0kH/Kcrum/ZbS3BhU+jxIegAkWY
	nU4zhJrU3kvRftAFkXxpBC8JWg+K5w6RhLIWpuyDRLghvM27MRWeZT5ug5Mwtx640cN18KYcrpc
	Qn4Mpizi/wccGq1y5AQHtm0vhWSfB5SNupny3OvferlbMY14ErM6m6GNMdsEV8wyhfipMyojP0K
	5o1GDrI3Ua++xp4MoCGqKImhWb40nYVr4Mb4/huZttcsmVPnu40KQS7pDJEgU+bvrPjE3Hn2L8/
	OjrdvaVj6ZDPdBmrUj71s5aZiLGwSJM3xklRWLwAVTMbKjT/9QpOb22BPaBCVbRxg/JqkkNhTLK
	5KAUmwUaeTaDneV9WzEo5K+bwH1c9hWtCyuuh3xJy3OG5sBLcx50lC3gUC9F6ycgXywC4SOewjg
	4SAA==
X-Google-Smtp-Source: AGHT+IFz4ooTAIJ0loj0UJgGkHM1OmScswyrchamBua5mK/t4M9KPAHsfs57yfem5Wuu+uaZcRII+A==
X-Received: by 2002:a05:620a:46a6:b0:7e1:5efc:6f6 with SMTP id af79cd13be357-7e343633b0bmr3192892985a.47.1753140267679;
        Mon, 21 Jul 2025 16:24:27 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e356c938bfsm465516685a.96.2025.07.21.16.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:27 -0700 (PDT)
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
Subject: [RFC PATCH v2 26/34] smack: move initcalls to the LSM framework
Date: Mon, 21 Jul 2025 19:21:29 -0400
Message-ID: <20250721232142.77224-62-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2864; i=paul@paul-moore.com; h=from:subject; bh=8+Yydcda6gliFzIbMQ67RWaGm58avhDYOeg3/XQTpM4=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsvkM5n0lxEDdn41/FJQIR1J//6q3uKF00SFT phtrEz862iJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7L5AAKCRDqIPLalzeJ c3VqD/9uI/8y3pyN2MnwHHeLYUW5vxFR0IbPKzpoc1agz2QTp2oda9iSR9SFj/WPfMQ1mvIARbr uLvFv7QEf80gY2ZZzgbeo7fPV+XXEDYrHVlc1Yx1c1q3nF7vs6kgYCSAkAxRWfBmQ3c3QsChYMq SydeiOIa54unH1XjEEpAPmplmi5MaSg3PkRDCy0UYfapNf7hWGtW6TeXheP6JS/+laS9HDosJRq ekhz4oH9TE79twH4b3ieN6/T19qZVWcL7/kMvc6J6HNc7Bpn6Lit0YTC7zAZoebC1kbxt9h8L+7 tLSfw7G/pftR9QeM7L7mC72iDaO581wbdvf393DpM5/lm+epbhj+VxJIGvbrrDoi+qNueT7mW/t 3pa3ebdOY5eM6r898YXhyobde6swNLUgVRYu/sgEcn8Hyk0+09lI5t0kDpsWucNhTQW20tTV0kg BmMR4u7M0KAy7+C35vVK2I4JQXYYqzPbqIHoNXD4lTjOnLxWVX4Ti3a2w9Ld2z4kU3sWs8y7Q+F qysf0xftizGhudfE6AYRuFPDD3jg4ZuX75V+aB7P7pU6eR4TcJGxy5r7x0BZ+/803eBgeRC8s1j 8VyOfu+suUKTJvaRXrLAts9i9THPtXSjLlifrCXJzSEIw3TMykvRbcPSnW6A4AOKQrvCUk5VrnQ 21UDky/BQ6mzcsQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

As the LSM framework only supports one LSM initcall callback for each
initcall type, the init_smk_fs() and smack_nf_ip_init() functions were
wrapped with a new function, smack_initcall() that is registered with
the LSM framework.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/smack/smack.h           | 7 +++++++
 security/smack/smack_lsm.c       | 9 +++++++++
 security/smack/smack_netfilter.c | 4 +---
 security/smack/smackfs.c         | 4 +---
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index bf6a6ed3946c..885a2f2929fd 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -275,6 +275,13 @@ struct smk_audit_info {
 #endif
 };
 
+/*
+ * Initialization
+ */
+int init_smk_fs(void);
+int smack_nf_ip_init(void);
+int smack_initcall(void);
+
 /*
  * These functions are in smack_access.c
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index e09490c75f59..f14d536c516b 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5270,6 +5270,14 @@ static __init int smack_init(void)
 	return 0;
 }
 
+int __init smack_initcall(void)
+{
+	int rc_fs = init_smk_fs();
+	int rc_nf = smack_nf_ip_init();
+
+	return rc_fs ? rc_fs : rc_nf;
+}
+
 /*
  * Smack requires early initialization in order to label
  * all processes and objects when they are created.
@@ -5279,4 +5287,5 @@ DEFINE_LSM(smack) = {
 	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
 	.blobs = &smack_blob_sizes,
 	.init = smack_init,
+	.initcall_device = smack_initcall,
 };
diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index 8fd747b3653a..17ba578b1308 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -68,7 +68,7 @@ static struct pernet_operations smack_net_ops = {
 	.exit = smack_nf_unregister,
 };
 
-static int __init smack_nf_ip_init(void)
+int __init smack_nf_ip_init(void)
 {
 	if (smack_enabled == 0)
 		return 0;
@@ -76,5 +76,3 @@ static int __init smack_nf_ip_init(void)
 	printk(KERN_DEBUG "Smack: Registering netfilter hooks\n");
 	return register_pernet_subsys(&smack_net_ops);
 }
-
-__initcall(smack_nf_ip_init);
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index b1e5e62f5cbd..405ace6db109 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -2978,7 +2978,7 @@ static struct vfsmount *smackfs_mount;
  * Returns true if we were not chosen on boot or if
  * we were chosen and filesystem registration succeeded.
  */
-static int __init init_smk_fs(void)
+int __init init_smk_fs(void)
 {
 	int err;
 	int rc;
@@ -3021,5 +3021,3 @@ static int __init init_smk_fs(void)
 
 	return err;
 }
-
-__initcall(init_smk_fs);
-- 
2.50.1

