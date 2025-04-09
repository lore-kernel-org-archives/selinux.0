Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB11127C84D
	for <selinux@vger.kernel.org>; Wed,  9 Apr 2025 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224831; cv=none; b=N1Uf6rLmL296sETEsV1a0AQPP0zRCcmS9Jtxs6WdQC/Vtwn/TO7C4Ez/jDFgKBNSPnRRqch3B7bklNBsks/6H/gZzZqqyOqCgpBMG6wzmh2E4c2uObOQxJ4i6tMIyhGqkNVL3AIk5edyQr29L3nR15g4Xf9hIFq5vQz4jdMp8jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224831; c=relaxed/simple;
	bh=AVkJRjtNhqXhyUlfGVNTrUMP8tB9qm5nbyF0thgK/JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3EJASPqeamwl4yD8bJM5GBZ2p/Dn8rQBhG8Esrp0rEkFc1Jlgt3TS1KN0APah2HbJewWPoYIgpoZVPMm5socN+43q+ciY+JmsnCbq9nEkFgGCPLgdUUN1cMBAuPuptk8uJa68MXGtcpgtt70zv/I1IC6Dt7k2o90lMDQ87o+Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HdD5mXjx; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HdD5mXjx"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6ed0cc5eca4so11765636d6.1
        for <selinux@vger.kernel.org>; Wed, 09 Apr 2025 11:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224828; x=1744829628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKO29QV8yek+caUxIhnywepsP3FQanTvQ8hfSVxZoMM=;
        b=HdD5mXjxQX7FsbEwP4WkXckCmmwws0HYW4RfZHgTC0lM1ZzVOfcb1JaeSzOf/q+9YF
         I91aL0epn9KJhTeYe2caGurMjA3cQpbvou43oBTUv67LuGaALhv8Zp8DUIDsvC4iXYRL
         bZSQE0qAiFq0YUALIXdVMrDfAwF5LO2gYKmnr/Har6pbItTvnth02ZfWu1pUZw/PnMq3
         1QSocebQiJSexpE+efqfkhdXHzrXtCI39mTZF2WSL6W8Zgk55pw4eaGMSmmX+sdpfT5l
         d7IJL+X8sHIKc1AyMU1Cn+BFEfT/VprrvbkKaIDKx4/tZ+hosUMjew2Kfgx7liweTGvR
         NWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224828; x=1744829628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKO29QV8yek+caUxIhnywepsP3FQanTvQ8hfSVxZoMM=;
        b=f6IIlOqg+WqtJvFRbrMGLHy64E2pUG3zd6djN4rrH7VvRr/6qasRqadFxdzQBkWGJr
         xJbAfP8qO29sI1f9vTXFge7DO1G3m8TpHFF8Hdf69o1XDag0aO453G6UpvnIb7YoAi4w
         uS4IUnnytTYgeuNeSgJ5TR0hgROL7ntCAaFvXoKuyOXswDmD68ShVkZuj5rT9Bx4KOY/
         RNxf74bP/LzVYIQwGbV0W1NvfOBM6UXw5hQ9VFxVtTnnwhmFrDFVEBz3cIGhMcsAl23I
         pXTMcYmQXGqJ1bPPAnI0Mrw//J6tM7Dwg4r4PZ8nuTREKK/yXBBDmZ0xzWPWjximIDrc
         /XOA==
X-Forwarded-Encrypted: i=1; AJvYcCW7Vqrc6JE+kUG9h4xBABM5y44bH7EgdqiFoAk3CGtVy5o2xiDI9xVtPu68CPx9KXo9OQ/BX1PB@vger.kernel.org
X-Gm-Message-State: AOJu0YyLh8FbzmpA03cHNNY8TFxmjHhqOeVIJ0wPLKhs3UQFLtXOvicN
	jtiqCYqhZm2muJ99UTisOBX8hdtnNMwfL6NNcIOJZzftvXIIlVVUm8WEfokBEQ==
X-Gm-Gg: ASbGncv+rmXx4wrQ8xZXJqagdvpyrWYpIHRwjP9WWwIOga1J4M4rweRP5IRcDCtRrev
	Q+qXhR22HBoe17yugvBv2nGD83TEIL4aAmk5k1qLYoeU7Qrq6cGZ/k7v8P90pbK1AIuVLRBFYps
	VXkm4ySqmSMzI5MkOgLJgZVZMKlnTq+gV3GGrsFcrxgMcficA+5e4y29AJc7KikT8djK1acb6FM
	amW5xXShgf/9HPxeLwMp1KXaccfy6rkqlVwZjIBW47cQL5eORyo1ttrbeLIWIyRwIfyKPlzOB8b
	k1EuC0LgtcTZUkagBdum5XJ1ntv1Zka7QFERNx5cvc9lFQ8IFFxCxqeuxoOs2F5/D8wvABdUfx8
	Fh0N0GYPcCg==
X-Google-Smtp-Source: AGHT+IGKMAYZQN2V76MHT3Js6gITRLB6/iF8KnmrzKiRhKmZSw8tQwBa3BrqLH4QaSEYiEHiRDo1lw==
X-Received: by 2002:ad4:5993:0:b0:6ea:d503:6cfd with SMTP id 6a1803df08f44-6f0e4d04e59mr9943876d6.19.1744224828399;
        Wed, 09 Apr 2025 11:53:48 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0de98088dsm10479746d6.58.2025.04.09.11.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:48 -0700 (PDT)
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
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 20/29] smack: move initcalls to the LSM framework
Date: Wed,  9 Apr 2025 14:50:05 -0400
Message-ID: <20250409185019.238841-51-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2917; i=paul@paul-moore.com; h=from:subject; bh=AVkJRjtNhqXhyUlfGVNTrUMP8tB9qm5nbyF0thgK/JU=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sHiys+u8M003Mml32kBFN+BOJZVTyVEBEHBj 0HLFBNfBdKJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bB4gAKCRDqIPLalzeJ cym7D/0cO1r1L2sdyvHjCYfW98sk0Zr7C2IQOTybQtrf3CEyTX556gVxI7u0yaAGyFGJ7wTyBiN Tv0iaPq/MEstauti5dq5iOAcgZxmM8JqBbaTF489G2jODPQPZ0DRe2JKeV1PIJbW7z4LS4vNXMh sXuDOClT5cLJxPAZXK1jMLMmV38TB7tXZz3dXnNsLpil/tEqosw2iuthX/TOKNRfb+20vqty7mL AsnKQ+0egsonYJQu5BcLeurySXBfjqRuRcwjvsV6+4/QlM1wdVVo8wndbwKV9dkwlFh5GjEoN1d ztu8QcE0aq/LbEl5XZlhJrHf7V2w4kYwCHhMVihgf3YgHh+r3CPSqDqv1y3uVWnd9ydS9zW1uOL mltFax4XfE2WNeDrykY3vGPbHUri7vXIZCR90dj5/l1v+QnxKaq2j9/XNYPqaX6QInu+sGbWJO/ y/tugf9vWo1UGmXX5ClBR/zoiaiS40Y3TLKtjoITmpR1tQf9mJSpsug3eg32YbEr/nvzZEfXjz4 ITIvHlRUeOj0osAi3wx/lnSY+4uTspUFQDECDNPVBt2jZAHji2sDJxwZNFQseJZKkFAzW9MUtsL 9ItubyJeodzYOvxKi5bery3E5E/aKgaB/cWcMfTacaaKyGa0+wJxqKAG1apKl3pjPYd4oNgJy9j OyuqAL+gWyw8Byg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

As the LSM framework only supports one LSM initcall callback for each
initcall type, the init_smk_fs() and smack_nf_ip_init() functions were
wrapped with a new function, smack_initcall() that is registered with
the LSM framework.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/smack/smack.h           |  6 ++++++
 security/smack/smack_lsm.c       | 16 ++++++++++++++++
 security/smack/smack_netfilter.c |  4 +---
 security/smack/smackfs.c         |  4 +---
 4 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index bf6a6ed3946c..709e0d6cd5e1 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -275,6 +275,12 @@ struct smk_audit_info {
 #endif
 };
 
+/*
+ * Initialization
+ */
+int init_smk_fs(void);
+int smack_nf_ip_init(void);
+
 /*
  * These functions are in smack_access.c
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index e09b33fed5f0..80b129a0c92c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5277,6 +5277,21 @@ static __init int smack_init(void)
 	return 0;
 }
 
+static int smack_initcall(void)
+{
+	int rc, rc_tmp;
+
+	rc_tmp = init_smk_fs();
+	if (rc_tmp)
+		rc = rc_tmp;
+
+	rc_tmp = smack_nf_ip_init();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+
+	return rc;
+}
+
 /*
  * Smack requires early initialization in order to label
  * all processes and objects when they are created.
@@ -5286,4 +5301,5 @@ DEFINE_LSM(smack) = {
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
index 90a67e410808..d33dd0368807 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -2980,7 +2980,7 @@ static struct vfsmount *smackfs_mount;
  * Returns true if we were not chosen on boot or if
  * we were chosen and filesystem registration succeeded.
  */
-static int __init init_smk_fs(void)
+int __init init_smk_fs(void)
 {
 	int err;
 	int rc;
@@ -3023,5 +3023,3 @@ static int __init init_smk_fs(void)
 
 	return err;
 }
-
-__initcall(init_smk_fs);
-- 
2.49.0

