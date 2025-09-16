Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE772C0270
	for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060822; cv=none; b=ix6qruvYKGiYuJGa+4DO78s/XrOzXbMNFxoN6OqxOXMDySt62FVraV1mr62UzQVFTGJ9mAk/f9+CUVdSnn4jmKS+lZz0Prb3s33rvt0yb9nc7F+9S6Wnurf/torN24MJuVTmb08stsK5FISFqprID2KaBfGOCAzWpbR3B8RaQb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060822; c=relaxed/simple;
	bh=mfkBMItzJhFQJu/PuedlvYt9bTCf8fMXvyIQj3cWTMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HImY4ukYFMnNrfOoQ7LTmHEXJfdtF4iAhOBtXyVFS84LJyYnxpCxcjjyqQS2uAPlFK8/c85n+C951fuVKH3UaEL3xeVl8X3aLoofIqss3OgxsWjZgtCjmQGUA/nhcaJgozkXnpYX+w7n4hESzeAEadVYr3pANGDJjJhv0Gj0WWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=M9mfdvwS; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="M9mfdvwS"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b61161c35cso67907601cf.3
        for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 15:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060819; x=1758665619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18FOTXntgpAZ3qb3+GziGbMqXkiLQd3byPCP0xXbQnc=;
        b=M9mfdvwS8sS93EgYz14YbgPu45lRKpWPlyQnpG8G7i+OuN+2QJ9iDZqD/UARAyi/UW
         knJ25f5PlqeIBRsEGoEe4PgyrNKBPiJBZiXOe+KOvPZq4iFHaHRiTY+Nc1/WJKCq+IZc
         xKG058JEFA5ndbJ/9ki58ILhkLG1q6ouP5SIPJJSiQdlxTsjmdKxjEwBgSaA0qPgYRQO
         v7z1LMprucMamHSfuC4Nt46W18eee3pMYueIRpetytTpy5xkkjvd5921uaqVu2Iwfg8/
         fdZiSQ16L9ir5AQadl5DH2Nll7ItK9CiHidoukdZesqjgSxxJsGg/T531Gry7YYD4pDN
         difA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060819; x=1758665619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18FOTXntgpAZ3qb3+GziGbMqXkiLQd3byPCP0xXbQnc=;
        b=T6P9ehoqIFQmYEVm9XIWU5+8g6Ysw7RvbiGSqUW9Gark8gS+caGoT50KsDRj5THkvg
         8DSVgvKW5EUha80qssoiCzcjOI/XYFcpe+FuBtLKPwaSs8qobiVx9UvVTUiK7XuPymub
         fLCs2e4nu8RSTgD4BVGpVKIkQXFOlaOBlav+Du8EeKQxbAzyq2ChbRzsv2Qu+t9WWK6l
         UBY34xsWpprOO40bA0wR4JVSyAhs5Zwo+XBVfbfRnsILVnwgY8Y1pxa1EyGOzeWis62z
         IfT4muMOfeYUD76yRCbjAvRLFnsovRTKzJ5UcCNlKBSDtOAZ4nuqXK4vZry0wz5diC5+
         RuZA==
X-Forwarded-Encrypted: i=1; AJvYcCV96ezXsEaGqkHsZEuRzLHoqvlOoqx9CVbQFt+l2wOS8K2BHCZCSRLWDa0vnhtx171jHJg2g5rA@vger.kernel.org
X-Gm-Message-State: AOJu0YxiiiS5o90hq/x3wY6c6gE0zQlCPaVbjEBNjzr9qs6+6VkWnJ0R
	42yv3mzo4ikvQxcF9764Z3u0m797jIGdN8KPXC96odYwWH5tXX+7aF1V+VuwfOYBgg==
X-Gm-Gg: ASbGncu1SWLmg7mPyUtsVBj6NR3KGDRRzF/zHL+ttPUA/GZi+nRSG3AcLTEojAXlHZZ
	LXcjPZ22DMB+N3D7pt0flhbFTgcmIiwLXznT4I/IbDbyjKaO+wp3Zw5vc3971J+9o84tAmiDxhR
	IVGe++mDQrsyIliDU4xZ/N4wpaxZRLiqJ+whVrE74ltE6jmKupnk84TJ4qcyjnF55aC0/+umlJ1
	Nqk9kG7dBj15kIOyI3jxJB5imWD8p90LQRNgKjtVvvZQ7uPGbHTbUp46FFs6dJw/DjZd+QVi4J4
	7rENg4oykeeJPPzJGysdep68tftH99cxB2o/t68xF23Hh3K9kfwMf9Ixqy2+Q5Xuw/AIwiTtyu0
	/ptBIkyGSZcLFioF/o+GIg2LQGch2+2U5BCMQBlRnPUPY71aQp3IcpdEPrwdb1tOfSvCu
X-Google-Smtp-Source: AGHT+IESyIsHFCcXzYk/1fbgSDp9qTkuseJYYb83LKtwu0TpJSm4JlHGY4mqEZbFNGbIouZ4TCoyug==
X-Received: by 2002:a05:622a:5c8a:b0:4b5:f43e:b7ac with SMTP id d75a77b69052e-4ba6c6b331emr742261cf.77.1758060819161;
        Tue, 16 Sep 2025 15:13:39 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b7a6ab810asm37353551cf.46.2025.09.16.15.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:13:38 -0700 (PDT)
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
Subject: [PATCH v4 03/34] lsm: consolidate lsm_allowed() and prepare_lsm() into lsm_prepare()
Date: Tue, 16 Sep 2025 18:03:30 -0400
Message-ID: <20250916220355.252592-39-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5822; i=paul@paul-moore.com; h=from:subject; bh=mfkBMItzJhFQJu/PuedlvYt9bTCf8fMXvyIQj3cWTMg=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd7SJDL0JdGeaZ2zpcLfaIuXThz5ZAgnusSdr gaXUCHiKK2JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMne0gAKCRDqIPLalzeJ cw73D/9CzyuUrINfnUSQtPTJI+C7oxuVhr+ojOJS3VypwqEBv8NhDhXQns3ZvN2vzPgDczb4Dxv SIcsFiVHZHkSfcCsRdFMN2ZEZTZOhNdviqWJ+OKg+oBuu1jtupMrJFn5ZVCdCdARA/Agcqm/r1H bw6ibqNVyRTbrro3FjewRy3YXCYqiVpJbgCXd7aDJFViOfRAB1WdyC9rWjaJw0FN+nsLYr+Hhnk E4H0y6yaBsOJyB9jRJizhWH9hKIqTPhs0pW2vPQcs2CBrbxJz+Y81qwy12zxXwDzBZjZywjsevw iPhJFCyt8g/ZvOjtws3easOzollVmjpf/brESSYc08vzRJ6PYkbpkhSvsNPACUGduT4SHGGgPL9 ye/JhBha1C66Mycf+KnXV73ssQ9Q+jjxe14CupLpyBbqdZfLO18MR3nPJauA98AQtx15nXJvo3+ 0agDAvmQc+3DnZsyC9JMcAk5jllqaMHehBIb/kt/WJh6a8Kr5vr5YVXSnVL56SfwE6uGiXW+ILX up2obVp3HNJ8QXDoU05J1wuz/08YzZxTJljlomgY/Y2ZOj8BRylmKoWQ9F313xTvkXphXBdlEnL RvpDcfRcgInZP4RuWzei9ZpP7rUthPlpzckphbnY2ZbPKHKqbGSwxKcI4tOa8P21OEDjGgMRrSu is9Qu49UdesYsxw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Simplify and consolidate the lsm_allowed() and prepare_lsm() functions
into a new function, lsm_prepare().

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 109 +++++++++++++++++++-------------------------
 1 file changed, 46 insertions(+), 63 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 124213b906af..6f40ab1d2f54 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -123,22 +123,6 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 		   is_enabled(lsm) ? "enabled" : "disabled");
 }
 
-/* Is an LSM allowed to be initialized? */
-static bool __init lsm_allowed(struct lsm_info *lsm)
-{
-	/* Skip if the LSM is disabled. */
-	if (!is_enabled(lsm))
-		return false;
-
-	/* Not allowed if another exclusive LSM already initialized. */
-	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
-		init_debug("exclusive disabled: %s\n", lsm->name);
-		return false;
-	}
-
-	return true;
-}
-
 static void __init lsm_set_blob_size(int *need, int *lbs)
 {
 	int offset;
@@ -151,54 +135,53 @@ static void __init lsm_set_blob_size(int *need, int *lbs)
 	*need = offset;
 }
 
-static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
+/**
+ * lsm_prepare - Prepare the LSM framework for a new LSM
+ * @lsm: LSM definition
+ */
+static void __init lsm_prepare(struct lsm_info *lsm)
 {
-	if (!needed)
+	struct lsm_blob_sizes *blobs;
+
+	if (!is_enabled(lsm)) {
+		set_enabled(lsm, false);
+		return;
+	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
+		init_debug("exclusive disabled: %s\n", lsm->name);
+		set_enabled(lsm, false);
 		return;
-
-	lsm_set_blob_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
-	lsm_set_blob_size(&needed->lbs_file, &blob_sizes.lbs_file);
-	lsm_set_blob_size(&needed->lbs_ib, &blob_sizes.lbs_ib);
-	/*
-	 * The inode blob gets an rcu_head in addition to
-	 * what the modules might need.
-	 */
-	if (needed->lbs_inode && blob_sizes.lbs_inode == 0)
-		blob_sizes.lbs_inode = sizeof(struct rcu_head);
-	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
-	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
-	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
-	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
-	lsm_set_blob_size(&needed->lbs_perf_event, &blob_sizes.lbs_perf_event);
-	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
-	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
-	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
-	lsm_set_blob_size(&needed->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
-	lsm_set_blob_size(&needed->lbs_xattr_count,
-			  &blob_sizes.lbs_xattr_count);
-	lsm_set_blob_size(&needed->lbs_bdev, &blob_sizes.lbs_bdev);
-	lsm_set_blob_size(&needed->lbs_bpf_map, &blob_sizes.lbs_bpf_map);
-	lsm_set_blob_size(&needed->lbs_bpf_prog, &blob_sizes.lbs_bpf_prog);
-	lsm_set_blob_size(&needed->lbs_bpf_token, &blob_sizes.lbs_bpf_token);
-}
-
-/* Prepare LSM for initialization. */
-static void __init prepare_lsm(struct lsm_info *lsm)
-{
-	int enabled = lsm_allowed(lsm);
-
-	/* Record enablement (to handle any following exclusive LSMs). */
-	set_enabled(lsm, enabled);
-
-	/* If enabled, do pre-initialization work. */
-	if (enabled) {
-		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
-			exclusive = lsm;
-			init_debug("exclusive chosen:   %s\n", lsm->name);
-		}
-
-		lsm_set_blob_sizes(lsm->blobs);
 	}
+
+	/* Mark the LSM as enabled. */
+	set_enabled(lsm, true);
+	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
+		init_debug("exclusive chosen:   %s\n", lsm->name);
+		exclusive = lsm;
+	}
+
+	/* Register the LSM blob sizes. */
+	blobs = lsm->blobs;
+	lsm_set_blob_size(&blobs->lbs_cred, &blob_sizes.lbs_cred);
+	lsm_set_blob_size(&blobs->lbs_file, &blob_sizes.lbs_file);
+	lsm_set_blob_size(&blobs->lbs_ib, &blob_sizes.lbs_ib);
+	/* inode blob gets an rcu_head in addition to LSM blobs. */
+	if (blobs->lbs_inode && blob_sizes.lbs_inode == 0)
+		blob_sizes.lbs_inode = sizeof(struct rcu_head);
+	lsm_set_blob_size(&blobs->lbs_inode, &blob_sizes.lbs_inode);
+	lsm_set_blob_size(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
+	lsm_set_blob_size(&blobs->lbs_key, &blob_sizes.lbs_key);
+	lsm_set_blob_size(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
+	lsm_set_blob_size(&blobs->lbs_perf_event, &blob_sizes.lbs_perf_event);
+	lsm_set_blob_size(&blobs->lbs_sock, &blob_sizes.lbs_sock);
+	lsm_set_blob_size(&blobs->lbs_superblock, &blob_sizes.lbs_superblock);
+	lsm_set_blob_size(&blobs->lbs_task, &blob_sizes.lbs_task);
+	lsm_set_blob_size(&blobs->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
+	lsm_set_blob_size(&blobs->lbs_xattr_count,
+			  &blob_sizes.lbs_xattr_count);
+	lsm_set_blob_size(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
+	lsm_set_blob_size(&blobs->lbs_bpf_map, &blob_sizes.lbs_bpf_map);
+	lsm_set_blob_size(&blobs->lbs_bpf_prog, &blob_sizes.lbs_bpf_prog);
+	lsm_set_blob_size(&blobs->lbs_bpf_token, &blob_sizes.lbs_bpf_token);
 }
 
 /* Initialize a given LSM, if it is enabled. */
@@ -361,7 +344,7 @@ static void __init ordered_lsm_init(void)
 		ordered_lsm_parse(builtin_lsm_order, "builtin");
 
 	for (lsm = ordered_lsms; *lsm; lsm++)
-		prepare_lsm(*lsm);
+		lsm_prepare(*lsm);
 
 	report_lsm_order();
 
@@ -505,7 +488,7 @@ int __init early_security_init(void)
 	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
 		if (!lsm->enabled)
 			lsm->enabled = &lsm_enabled_true;
-		prepare_lsm(lsm);
+		lsm_prepare(lsm);
 		initialize_lsm(lsm);
 	}
 
-- 
2.51.0

