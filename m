Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7228324C68B
	for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 20:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732966; cv=none; b=Lm8h1YV1fgfnJqqLhDG57KaxiFxdbhkqp8SSgCGHj6EiATl3wQiiLq6K0kFWyjxen2IdeB5jUXXBk8hYTSrAVkVlN4uNbq+xVxwi4tJBCUttm0V2M28E5VTiHqfUdKJBmTc4cjKo8fbYHQaYknj4vP7D2Aif8ok6c1qi2IoqHaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732966; c=relaxed/simple;
	bh=+AgQgKtaqNMi1yAZdICwPpgfNW05oFXJvyC6sPLU0AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klpIS6ESlpt1aRV/FbeutkcoUZZyH1N61m0Z85nTgu1dCSz4mZl4pfRpWYekTUBBSb7B0SL47QBZVMnnokDllDe5AZ5KjWwdOBD3zfmGwe4FImpMQY+0XeO/rQ0QkP6KEYd252ABJOrfGdfUbgggobk7PN6iG5uf32QbdLKi4VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dTt18pqX; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dTt18pqX"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-87c1f61ba98so29189106d6.0
        for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 13:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760732963; x=1761337763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ee+TNAznWP8sW27Db3XVRWSWcnknvzNRIQSVjzv23iY=;
        b=dTt18pqXFweh2VeUjtm9IeLlkkKQhXihz1+Lemu4Dh0gSvuHhduhONar3YXhIOHH3P
         kd5CdkVa1wgXith4vWSZkocbxtNHmMv7Ghx83zVyrokonVdkv1ZYkuisxUGtDnjG6H2B
         KwWpG24qhFfeEFnSQkQofqK7wOv+7d2l6tbnY2wtT8HhLJxszE1OiQ/RzUfCQz1bWbcr
         P+8xUyXvxXQVJgh+2Lqq++bZUeNYpo5dVy5ZX7dk0Z4MWVyMaH6wPHDpg3VGMMBLpdE2
         tR2KZAcmagrs73m/qwifYqUIe3HgZ4VE//wvOKdah6esQlleWD8pvcBIZh4mlEPRB9fO
         8iyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732963; x=1761337763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ee+TNAznWP8sW27Db3XVRWSWcnknvzNRIQSVjzv23iY=;
        b=SPPbt+8WsEzA1gL8by8MrzPFQ8DmUo9WiovtDO03V1ZWrlIet2GNGKgZh8NLyi2Tv7
         o4tkSG4cVNHpPXuTfl3EyPGXYrBoDMgA9P/7Jq4qx8FmVkcDkwv7bfET3mc9roVLaSTS
         Hh9QCq8Tfwd8T3JeSTHL8YWb6yFZTbN2THL6KtHpfHRTOg32WMLfbh3pLkEbE9OVt2kM
         knr8R2z0fv+nSPjVubRl7mS4M3u8d8x2yczsHyUiKgpFWXiOF07JI9Uz13p/w8snTNZH
         iWE0oe25DxTeOsSyAcl686hvdPhNF194an7PuGkRo0IIQMf0CdjeTXcErIWfN/+c6mbe
         KJQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE4rB6I1/IFRn7TRKgt/Kud+luTbk7yMPGlOt36NNNfweZdxZjVxjlnNX5H8wDaJwiiFqB5qs4@vger.kernel.org
X-Gm-Message-State: AOJu0YxoFyWDHIcfDVWsbayAe0rGAbtI28bH5i73JzFB9oH0WbG6/cU5
	rRqw7VYE3Qq/uFNUAoTxt+Svpqc1ZXBbVirgcXThPVPfW5GTOUQN0K/IJAlwRr05zQ==
X-Gm-Gg: ASbGncvo9QLEbCguAi9fwID3kx86PH/HMJavgXZEy01W8ilH4M5orjpIGTpH/VtT5pK
	A+ROVMfeUqIRQerEvsxAX6enIcmluZhjsrzVg84SKuD1S6vUqM1qCQYUBMLP8QWCiPz4sjAt5d8
	m+AAKA0ttwQrW+wzoxFM783q6S1kUVknAUTspi33QzpVo3Etn6AZn0lRcBTz3KXwlGcyaghaBu6
	MRgjZatBSUj5ATpTjf088ZF6WgHsEcNsttGKnVePe14kP2272/YUyUpRhIUqKK1XG3S23sN0zyG
	2oXZGesjnHrZ05vsKiTidj+bISK03X3iY2SQK1zthVMWh9uYNwuhyqzDgmEry0Z8siKosEpeNYr
	w8ePnSXrgpFs14JixWGyFBTVDeVwOcL0gAmZfCXLGEg+4KfzG4kTe+7THemYtBjtP4AxYjI+pyj
	cmZtkrh6nxAMVlrfBeImpq0uGv3KYuGMN/OPzeE3HiOvomvw==
X-Google-Smtp-Source: AGHT+IGNLee3EJzz9XWfHY6eUePINqn1r6hJ2WPB0ahd94cw4nBJuT3ltQrWfbV2ixZGuspmARpc1Q==
X-Received: by 2002:a05:6214:1c85:b0:87c:1e27:f7b4 with SMTP id 6a1803df08f44-87c2066890fmr69555906d6.67.1760732963264;
        Fri, 17 Oct 2025 13:29:23 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8aaf5fbf8sm5097671cf.11.2025.10.17.13.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:29:22 -0700 (PDT)
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
Subject: [PATCH v5 20/34] lsm: cleanup the debug and console output in lsm_init.c
Date: Fri, 17 Oct 2025 16:24:48 -0400
Message-ID: <20251017202456.484010-56-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10395; i=paul@paul-moore.com; h=from:subject; bh=+AgQgKtaqNMi1yAZdICwPpgfNW05oFXJvyC6sPLU0AE=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qZWP5ONNYO4lgHz5axwg68EDY1AaH0RQATj7 zKztXy9jXeJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKmVgAKCRDqIPLalzeJ cyPaEAC8f4YRFCrzUH+W5Wp0Lq3c4sVSbRKlWMLqSKlEbUGiw0oCbheA54oMQfMo3d8eq619Gxk NrxVxuP6xn5PiF7lvIobfmUZzeeDgOnLv9gOeHK/a8/QfCvPzN4eclmUpqATE/hJX2p/S3Ud8i6 q4mw2z8QSbfDn/Kd/AdP97M80a2U9IevzKdnhrHmvBcpvHIeT76NSonAlV+lxuic0QMR9volInt rqD9scFd8AvZVkli7+Y2XKdvMMulK8QsS4YOqVpg18qpwiAXsel9efmxE987qi7MgwGmgSTeUBf XSxp/KYfkBDcYAiqZfuRnUp81SvYlc0uvBm8J4gly8/2WoVw//vGVtdaFnqsYlNQZu6Fc9d93ku cSJYbdQjJlhEyVpBqH7pvro6pvtg2HBAvPRtCxmfExkbSWM/cxrwSE/VPS+l8CRtcjWd+unO/oo v7m1yvF8c1SVj27T1MRddSN9r9nJdXPpHVMge0g5tItvkDAl0txuWxSTkTTw+nwnDPi0Sq4S5IG rRDQTwVTE/OLeu4UngACn+HncneMWCdwzyjVmrnjBAJKY4UGQlZel5uUFGAPHwfY2wR6LRQeiSl ie82iq2riWl0KH01hMORxwAaYwWBwA2mhhrPHVvVxJDOs328HYI2SxloGRBEzYkB+0QSn8UV6S1 J/J2LS1C3M9qL1w==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Move away from an init specific init_debug() macro to a more general
lsm_pr()/lsm_pr_cont()/lsm_pr_dbg() set of macros that are available
both before and after init.  In the process we do a number of minor
changes to improve the LSM initialization output and cleanup the code
somewhat.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm.h      |  11 ++++
 security/lsm_init.c | 123 +++++++++++++++++++-------------------------
 security/security.c |   2 +
 3 files changed, 66 insertions(+), 70 deletions(-)

diff --git a/security/lsm.h b/security/lsm.h
index dbe755c45e57..8dc267977ae0 100644
--- a/security/lsm.h
+++ b/security/lsm.h
@@ -6,9 +6,20 @@
 #ifndef _LSM_H_
 #define _LSM_H_
 
+#include <linux/printk.h>
 #include <linux/lsm_hooks.h>
 #include <linux/lsm_count.h>
 
+/* LSM debugging */
+extern bool lsm_debug;
+#define lsm_pr(...)		pr_info(__VA_ARGS__)
+#define lsm_pr_cont(...)	pr_cont(__VA_ARGS__)
+#define lsm_pr_dbg(...)							\
+	do {								\
+		if (lsm_debug)						\
+			pr_info(__VA_ARGS__);				\
+	} while (0)
+
 /* List of configured LSMs */
 extern unsigned int lsm_active_cnt;
 extern const struct lsm_id *lsm_idlist[];
diff --git a/security/lsm_init.c b/security/lsm_init.c
index bf861081d592..cd1779e03497 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -30,13 +30,6 @@ static __initdata const char *lsm_order_legacy;
 static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
 static __initdata struct lsm_info *lsm_exclusive;
 
-static __initdata bool debug;
-#define init_debug(...)							\
-	do {								\
-		if (debug)						\
-			pr_info(__VA_ARGS__);				\
-	} while (0)
-
 #define lsm_order_for_each(iter)					\
 	for ((iter) = lsm_order; *(iter); (iter)++)
 #define lsm_for_each_raw(iter)						\
@@ -77,7 +70,7 @@ __setup("lsm=", lsm_choose_lsm);
  */
 static int __init lsm_debug_enable(char *str)
 {
-	debug = true;
+	lsm_debug = true;
 	return 1;
 }
 __setup("lsm.debug", lsm_debug_enable);
@@ -143,22 +136,28 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 		return;
 
 	/* Skip explicitly disabled LSMs. */
-	if (lsm->enabled && !lsm_is_enabled(lsm))
-		goto out;
+	if (lsm->enabled && !lsm_is_enabled(lsm)) {
+		lsm_pr_dbg("skip previously disabled LSM %s:%s\n",
+			   src, lsm->id->name);
+		return;
+	}
 
-	if (WARN(lsm_active_cnt == MAX_LSM_COUNT,
-		 "%s: out of LSM static calls!?\n", src)) {
+	if (lsm_active_cnt == MAX_LSM_COUNT) {
+		pr_warn("exceeded maximum LSM count on %s:%s\n",
+			src, lsm->id->name);
 		lsm_enabled_set(lsm, false);
-		goto out;
+		return;
 	}
 
 	if (lsm->flags & LSM_FLAG_EXCLUSIVE) {
 		if (lsm_exclusive) {
-			init_debug("exclusive disabled: %s\n", lsm->id->name);
+			lsm_pr_dbg("skip exclusive LSM conflict %s:%s\n",
+				   src, lsm->id->name);
 			lsm_enabled_set(lsm, false);
-			goto out;
+			return;
 		} else {
-			init_debug("exclusive chosen:   %s\n", lsm->id->name);
+			lsm_pr_dbg("select exclusive LSM %s:%s\n",
+				   src, lsm->id->name);
 			lsm_exclusive = lsm;
 		}
 	}
@@ -167,9 +166,7 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 	lsm_order[lsm_active_cnt] = lsm;
 	lsm_idlist[lsm_active_cnt++] = lsm->id;
 
-out:
-	init_debug("%s ordered: %s (%s)\n", src, lsm->id->name,
-		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
+	lsm_pr_dbg("enabling LSM %s:%s\n", src, lsm->id->name);
 }
 
 /**
@@ -239,7 +236,7 @@ static void __init lsm_init_single(struct lsm_info *lsm)
 	if (!lsm_is_enabled(lsm))
 		return;
 
-	init_debug("initializing %s\n", lsm->id->name);
+	lsm_pr_dbg("initializing %s\n", lsm->id->name);
 	ret = lsm->init();
 	WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
 }
@@ -266,8 +263,8 @@ static void __init lsm_order_parse(const char *list, const char *src)
 			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) &&
 			     strcmp(lsm->id->name, lsm_order_legacy)) {
 				lsm_enabled_set(lsm, false);
-				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
-					   lsm_order_legacy, lsm->id->name);
+				lsm_pr_dbg("skip legacy LSM conflict %s:%s\n",
+					   src, lsm->id->name);
 			}
 		}
 	}
@@ -310,8 +307,7 @@ static void __init lsm_order_parse(const char *list, const char *src)
 		if (lsm_order_exists(lsm))
 			continue;
 		lsm_enabled_set(lsm, false);
-		init_debug("%s skipped: %s (not in requested order)\n",
-			   src, lsm->id->name);
+		lsm_pr_dbg("skip disabled LSM %s:%s\n", src, lsm->id->name);
 	}
 }
 
@@ -319,7 +315,7 @@ static void __init lsm_order_parse(const char *list, const char *src)
  * lsm_static_call_init - Initialize a LSM's static calls
  * @hl: LSM hook list
  */
-static void __init lsm_static_call_init(struct security_hook_list *hl)
+static int __init lsm_static_call_init(struct security_hook_list *hl)
 {
 	struct lsm_static_call *scall = hl->scalls;
 	int i;
@@ -331,11 +327,12 @@ static void __init lsm_static_call_init(struct security_hook_list *hl)
 					     hl->hook.lsm_func_addr);
 			scall->hl = hl;
 			static_branch_enable(scall->active);
-			return;
+			return 0;
 		}
 		scall++;
 	}
-	panic("%s - Ran out of static slots.\n", __func__);
+
+	return -ENOSPC;
 }
 
 /**
@@ -353,7 +350,9 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 
 	for (i = 0; i < count; i++) {
 		hooks[i].lsmid = lsmid;
-		lsm_static_call_init(&hooks[i]);
+		if (lsm_static_call_init(&hooks[i]))
+			panic("exhausted LSM callback slots with LSM %s\n",
+			      lsmid->name);
 	}
 }
 
@@ -384,19 +383,16 @@ int __init security_init(void)
 {
 	unsigned int cnt;
 	struct lsm_info **lsm;
-	struct lsm_info *early;
-	unsigned int first = 0;
 
-	init_debug("legacy security=%s\n", lsm_order_legacy ? : " *unspecified*");
-	init_debug("  CONFIG_LSM=%s\n", lsm_order_builtin);
-	init_debug("boot arg lsm=%s\n", lsm_order_cmdline ? : " *unspecified*");
+	if (lsm_debug) {
+		lsm_pr("built-in LSM list: %s\n", lsm_order_builtin);
+		lsm_pr("legacy LSM parameter: %s\n", lsm_order_legacy);
+		lsm_pr("boot LSM parameter: %s\n", lsm_order_cmdline);
+	}
 
 	if (lsm_order_cmdline) {
-		if (lsm_order_legacy) {
-			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
-				lsm_order_legacy, lsm_order_cmdline);
+		if (lsm_order_legacy)
 			lsm_order_legacy = NULL;
-		}
 		lsm_order_parse(lsm_order_cmdline, "cmdline");
 	} else
 		lsm_order_parse(lsm_order_builtin, "builtin");
@@ -404,38 +400,25 @@ int __init security_init(void)
 	lsm_order_for_each(lsm)
 		lsm_prepare(*lsm);
 
-	pr_info("initializing lsm=");
-	lsm_early_for_each_raw(early) {
-		if (lsm_is_enabled(early))
-			pr_cont("%s%s",
-				first++ == 0 ? "" : ",", early->id->name);
+	if (lsm_debug) {
+		lsm_pr("blob(cred) size %d\n", blob_sizes.lbs_cred);
+		lsm_pr("blob(file) size %d\n", blob_sizes.lbs_file);
+		lsm_pr("blob(ib) size %d\n", blob_sizes.lbs_ib);
+		lsm_pr("blob(inode) size %d\n", blob_sizes.lbs_inode);
+		lsm_pr("blob(ipc) size %d\n", blob_sizes.lbs_ipc);
+		lsm_pr("blob(key) size %d\n", blob_sizes.lbs_key);
+		lsm_pr("blob(msg_msg)_size %d\n", blob_sizes.lbs_msg_msg);
+		lsm_pr("blob(sock) size %d\n", blob_sizes.lbs_sock);
+		lsm_pr("blob(superblock) size %d\n", blob_sizes.lbs_superblock);
+		lsm_pr("blob(perf_event) size %d\n", blob_sizes.lbs_perf_event);
+		lsm_pr("blob(task) size %d\n", blob_sizes.lbs_task);
+		lsm_pr("blob(tun_dev) size %d\n", blob_sizes.lbs_tun_dev);
+		lsm_pr("blob(xattr) count %d\n", blob_sizes.lbs_xattr_count);
+		lsm_pr("blob(bdev) size %d\n", blob_sizes.lbs_bdev);
+		lsm_pr("blob(bpf_map) size %d\n", blob_sizes.lbs_bpf_map);
+		lsm_pr("blob(bpf_prog) size %d\n", blob_sizes.lbs_bpf_prog);
+		lsm_pr("blob(bpf_token) size %d\n", blob_sizes.lbs_bpf_token);
 	}
-	lsm_order_for_each(lsm) {
-		if (lsm_is_enabled(*lsm))
-			pr_cont("%s%s",
-				first++ == 0 ? "" : ",", (*lsm)->id->name);
-	}
-	pr_cont("\n");
-
-	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
-	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
-	init_debug("ib blob size         = %d\n", blob_sizes.lbs_ib);
-	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
-	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
-#ifdef CONFIG_KEYS
-	init_debug("key blob size        = %d\n", blob_sizes.lbs_key);
-#endif /* CONFIG_KEYS */
-	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
-	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
-	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
-	init_debug("perf event blob size = %d\n", blob_sizes.lbs_perf_event);
-	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
-	init_debug("tun device blob size = %d\n", blob_sizes.lbs_tun_dev);
-	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
-	init_debug("bdev blob size       = %d\n", blob_sizes.lbs_bdev);
-	init_debug("bpf map blob size    = %d\n", blob_sizes.lbs_bpf_map);
-	init_debug("bpf prog blob size   = %d\n", blob_sizes.lbs_bpf_prog);
-	init_debug("bpf token blob size  = %d\n", blob_sizes.lbs_bpf_token);
 
 	if (blob_sizes.lbs_file)
 		lsm_file_cache = kmem_cache_create("lsm_file_cache",
@@ -447,9 +430,9 @@ int __init security_init(void)
 						    SLAB_PANIC, NULL);
 
 	if (lsm_cred_alloc((struct cred __rcu *)current->cred, GFP_KERNEL))
-		panic("%s: early cred alloc failed.\n", __func__);
+		panic("early LSM cred alloc failed\n");
 	if (lsm_task_alloc(current))
-		panic("%s: early task alloc failed.\n", __func__);
+		panic("early LSM task alloc failed\n");
 
 	cnt = 0;
 	lsm_order_for_each(lsm) {
diff --git a/security/security.c b/security/security.c
index b4eec4f00730..31a688650601 100644
--- a/security/security.c
+++ b/security/security.c
@@ -73,6 +73,8 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
+bool lsm_debug __ro_after_init;
+
 unsigned int lsm_active_cnt __ro_after_init;
 const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
 
-- 
2.51.1.dirty

