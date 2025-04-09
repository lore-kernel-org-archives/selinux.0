Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01070279342
	for <selinux@vger.kernel.org>; Wed,  9 Apr 2025 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224826; cv=none; b=AsbvvaWLlMNOvT1aPIVKBhDtLxsUuUCdHkBkckYmHkPBN7QneQNIQxH4o92Uex7yH0RlkxHeVsuZAK9un/5u6C2nFbCkLusMLNQJIxj6wUolKc4aoqUV/5hw+XJ3fcLrDwnQsBGgr1XBvPsOmwiXnFls1erK9pR3gum5PHkd2bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224826; c=relaxed/simple;
	bh=/zOcp6vW00K9OLTDKuRlnUWVeOMi2M8xMQFO5DBpqm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gf2elzZE1yH8RyuTW5rhAuecXdz4DHuDkxHSCpAXDp5DhQUXYR6k01rIPqvibxqrDSmJjRtcMy6AGrJNcG5vvZINZqlCBAtAz546wb7zeOkOpObVtWoK9BQ0R7ZYfqPiGfzjFQ4uwUterK+z+sWjL1eID/z17T5tTAbxo6Ped2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FfFeFJlL; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FfFeFJlL"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47692b9d059so37921431cf.3
        for <selinux@vger.kernel.org>; Wed, 09 Apr 2025 11:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224824; x=1744829624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVHQG1C6ddsrtK1xivLmHJGGL5ZFOJnUaGXlM9Lc7Wc=;
        b=FfFeFJlLiU9AJkjYWc8u17pG+xs3UGGwQ49pyOYEfHUV1rXctKsI+zVcGQTipIzBDQ
         cUxQZIva716V2FR5xjD9p2fSgCg9TeeTyflLrWFWWApIogU1zawiiMFx5F6EN+OonjV9
         VePA11UeWwG2XqcjFVi3XJO2TOAV+HoHH6OVBMsQ5S/VwOF6nsf1fX+ohWUyLF7/4kbk
         zPR52QjuI51VbdmJNksW+AK2tpNWzWBrPaLDaZCB6nt4p8+urGcd4ps+bEozplqgulQg
         w2yO6dIIeu+k2dUT3o7NXGiWLvSEIVzWHJPYAMoKrezeEx0ZCmYlhbQsb/tmpkGwPpH4
         DV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224824; x=1744829624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVHQG1C6ddsrtK1xivLmHJGGL5ZFOJnUaGXlM9Lc7Wc=;
        b=fhg1/Ue+6htG+4E76Dza6PHVQgXRERiTnmjStvooFzhQzG/y4eWOBjhnxejfg/Ttaa
         otV3QOVFe2seTU9qi2sovFy7bd1U5gOyVctCzY2/OJw4Vh5MFngJFxgR3W0wXEk+sg2A
         GvpgmbF6ClJq/EO64KdhIl7MHTerT8ti2sgExy9jvHsZwvR06EBDr2353+03RCtPTmBt
         R93hUEfGTqeYgfR6/H9Aqsno7OJXXorviNUWq1eqL+/7+32OY/MjxYb3XVteYp20+I4T
         oqkK+P0oU+jXep8Pb82sblNqnntesAo5vNBOfFO2fdfUi+EogILdcg3bQ6tys64ENq2l
         keWg==
X-Forwarded-Encrypted: i=1; AJvYcCX4rIJYyIT2gvhl4DlkeV4BrgpiGmT05RRnd8NxH5l9pzcY2uGjelQtqzuvZRQXU2IBQm3nxIlM@vger.kernel.org
X-Gm-Message-State: AOJu0YwJpF67RhI40CT6srmVQb5foRvmOMB6w3ggg9a51D6n5weaTSbg
	gJgfOUx03S2zwox+Vq87Uv0IS30j+8yOLMJEoiYGUVTDwSitmPj7SvwE3eqEnA==
X-Gm-Gg: ASbGncuZkVEZguGH2nem5nDoT6RcV0G3ZdrzHGjarGg2URMnOmsRnfPz74IA/b8fB6d
	UTGwVx9CUxkaTjnCgk1n0neXE8R/lJkwwpIaz2fl4NFKK8CGw6qJW6wzazD8+CULpxPiwsXW0Sl
	H//EUQvGJPhygWhag3lql3kl9H5dpbIfqB6g1RIaIWZCmrWgcdzCSF20+sIjiC79k4NJ05TI24X
	K299GM6sg0Ti7LQ+pD0sj+fHEvsLNRNWDZ3z0u2gPAu3z583k5R58dU17xJ7TwdMafoNoalhuo9
	V7udI8Ld7lP0rJInc4TSp7jHo0RPEJy5ygWXijcfhO/dIXOj6i4N5Cv7XX1n4VFosWXgBM6Kmow
	MOGEcCi71ax54NjVGhKNe
X-Google-Smtp-Source: AGHT+IHq2RugIX4WFOD7M6JwKXBKHkVCFAeiVCQHqswlFJhgNBEKGqnTf6VvFQlUt2Jo/O4eoCMF0w==
X-Received: by 2002:ac8:7d4c:0:b0:476:8cad:72d7 with SMTP id d75a77b69052e-4796007888bmr42523341cf.8.1744224823860;
        Wed, 09 Apr 2025 11:53:43 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47964de143csm10415171cf.35.2025.04.09.11.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:43 -0700 (PDT)
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
Subject: [RFC PATCH 15/29] lsm: cleanup the debug and console output in lsm_init.c
Date: Wed,  9 Apr 2025 14:50:00 -0400
Message-ID: <20250409185019.238841-46-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9645; i=paul@paul-moore.com; h=from:subject; bh=/zOcp6vW00K9OLTDKuRlnUWVeOMi2M8xMQFO5DBpqm8=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sHExz7JhVCfgvu+Ih/5YNSFjFh8turGzhYHF qPOgqUXmcuJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bBxAAKCRDqIPLalzeJ c4gfD/44avckg6JgGRlufNqqKjPFYqQ1kAscZQ08oevz+Z2QV6EfhD8RdjLgz71HRj7r31sytFz D2BrZotzxu/t6dVDbV7pboHsw8y2CV1JTEmgpAba4Xejv9vdFUrWJP5mpX+d75BsQIb1WZ9GbB2 cOkPqr4lTsKVP0bkDxwBnYLVlKlDOK7HThO+OjlstNdf5frannP8yF6tkGUr0D7KXtuO51KBO/y E7ZFLtL8nImTOQKT9vlI1dEmsjcUx0Zd/PplD2gCJO2LW6Fq+DJwdQTlpFWH8NucVHY1uytIBUz 1Pbu75lCfsuOmCSnnR2BkJng+qLMXJmzbgmc/6wB+pj6sPJIzx6y6ut8d/lc83B2g42s4tPKClx PWSTtDbKIn4X2EI0HSSXLcisO3TasfXYTCSRkinq+bsPJuSK4HDBqHNPRZDDZMb8aeTzhZxUSu6 ZCvy7lvYr2wEFRsWQMTlUQMpj8uZ2zoFX7ztheA4SaRbKtJWNXBumXYaKWaFvwaqSgiP92iX+nk 7S8R7ex8kxm9CR9UW8MxTcyXN5OMTmdKuVhyiLIrCd6gnLscDHWuA0jCll3fzS7e/OBpxUMKV6P sQmgZfjodrRpD2TMQ/4MZjMrCMDfODyLE/tqapZjnkzbp2kKhUqBHD1cJP+uWYvMznAgNd8McDO x6HFMQ7otkFEBFw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

One part of a larger effort to cleanup the LSM framework initialization
code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm.h      |  11 ++++
 security/lsm_init.c | 121 +++++++++++++++++++-------------------------
 security/security.c |   2 +
 3 files changed, 66 insertions(+), 68 deletions(-)

diff --git a/security/lsm.h b/security/lsm.h
index af343072199d..8ecb66896646 100644
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
 extern unsigned int lsm_count;
 extern const struct lsm_id *lsm_idlist[];
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 04b1f5e760b1..aba1253ffc4c 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -30,13 +30,6 @@ static __initdata const char *lsm_order_legacy;
 static __initdata struct lsm_info *lsm_exclusive;
 static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
 
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
@@ -145,22 +138,28 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 		return;
 
 	/* Skip explicitly disabled LSMs. */
-	if (lsm->enabled && !lsm_is_enabled(lsm))
-		goto out;
+	if (lsm->enabled && !lsm_is_enabled(lsm)) {
+		lsm_pr_dbg("skip previously disabled LSM %s:%s\n",
+			   src, lsm->id->name);
+		return;
+	}
 
-	if (WARN(lsm_count == MAX_LSM_COUNT,
-		 "%s: out of LSM static calls!?\n", src)) {
+	if (lsm_count == MAX_LSM_COUNT) {
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
@@ -169,9 +168,7 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 	lsm_order[lsm_count] = lsm;
 	lsm_idlist[lsm_count++] = lsm->id;
 
-out:
-	init_debug("%s ordered: %s (%s)\n", src, lsm->id->name,
-		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
+	lsm_pr_dbg("enabling LSM %s:%s\n", src, lsm->id->name);
 }
 
 /**
@@ -196,8 +193,8 @@ static void __init lsm_order_parse(const char *list, const char *src)
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
@@ -240,8 +237,7 @@ static void __init lsm_order_parse(const char *list, const char *src)
 		if (lsm_order_exists(lsm))
 			continue;
 		lsm_enabled_set(lsm, false);
-		init_debug("%s skipped: %s (not in requested order)\n",
-			   src, lsm->id->name);
+		lsm_pr_dbg("skip disabled LSM %s:%s\n", src, lsm->id->name);
 	}
 }
 
@@ -308,16 +304,18 @@ static void __init lsm_init_single(struct lsm_info *lsm)
 	if (!lsm_is_enabled(lsm))
 		return;
 
-	init_debug("initializing %s\n", lsm->id->name);
+	lsm_pr_dbg("initialize LSM %s\n", lsm->id->name);
 	ret = lsm->init();
-	WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
+	if (ret)
+		pr_warn("failed to initialize LSM %s with errno %d\n",
+			lsm->id->name, ret);
 }
 
 /**
  * lsm_static_call_init - Initialize a LSM's static calls
  * @hl: LSM hook list
  */
-static void __init lsm_static_call_init(struct security_hook_list *hl)
+static int __init lsm_static_call_init(struct security_hook_list *hl)
 {
 	struct lsm_static_call *scall = hl->scalls;
 	int i;
@@ -329,11 +327,12 @@ static void __init lsm_static_call_init(struct security_hook_list *hl)
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
@@ -351,7 +350,9 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 
 	for (i = 0; i < count; i++) {
 		hooks[i].lsmid = lsmid;
-		lsm_static_call_init(&hooks[i]);
+		if (lsm_static_call_init(&hooks[i]))
+			panic("exhausted LSM callback slots with LSM %s\n",
+			      lsmid->name);
 	}
 }
 
@@ -382,18 +383,16 @@ int __init security_init(void)
 {
 	unsigned int cnt;
 	struct lsm_info **lsm;
-	struct lsm_info *early;
 
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
@@ -401,36 +400,22 @@ int __init security_init(void)
 	lsm_order_for_each(lsm)
 		lsm_prep_single(*lsm);
 
-	pr_info("initializing lsm=");
-	lsm_early_for_each_raw(early) {
-		if (lsm_is_enabled(early))
-			pr_cont("%s%s",
-				early == __start_early_lsm_info ? "" : ",",
-				early->id->name);
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
 	}
-	lsm_order_for_each(lsm) {
-		if (lsm_is_enabled(*lsm))
-			pr_cont("%s%s",
-				lsm == lsm_order ? "" : ",", (*lsm)->id->name);
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
 
 	if (blob_sizes.lbs_file)
 		lsm_file_cache = kmem_cache_create("lsm_file_cache",
@@ -442,9 +427,9 @@ int __init security_init(void)
 						    SLAB_PANIC, NULL);
 
 	if (lsm_cred_alloc((struct cred *)current->cred, GFP_KERNEL))
-		panic("%s: early cred alloc failed.\n", __func__);
+		panic("early LSM cred alloc failed\n");
 	if (lsm_task_alloc(current))
-		panic("%s: early task alloc failed.\n", __func__);
+		panic("early LSM task alloc failed\n");
 
 	cnt = 0;
 	lsm_order_for_each(lsm) {
diff --git a/security/security.c b/security/security.c
index a3e8dd640b39..cbd544d71093 100644
--- a/security/security.c
+++ b/security/security.c
@@ -73,6 +73,8 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
+bool lsm_debug __ro_after_init;
+
 unsigned int lsm_count __ro_after_init;
 const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
 
-- 
2.49.0

