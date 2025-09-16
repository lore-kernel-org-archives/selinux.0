Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C672BEFFF
	for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 22:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060846; cv=none; b=V6KhQVBmMkzSZfmfvRbDPoyu1b5J0n5jIi0t/NVDxLIDsn/Al8OAfG61Y/Hn+QNtQoJtHPukB8oFuHzLJMtzkJPWhAA3WCJpXjd7jikWDXjOgzZQ+By4mfpbgYyIgBy2s8aa8xHn87jQvK2s158PnvjahLT8nod3KqskjLwhjPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060846; c=relaxed/simple;
	bh=3GFz75+pgXuExyfdB0UrHZ6YMZucLji/ZI4WfsyWv58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdajTbJ16mW0bJfCz4M6kZDjDmmKB80O24nBwBO8RQdR2g1H1flRvy0DyB3s7noZ607Xv3VUGRgV7AFWWiy9TqtdQrex5rpMpQ+QqA92HwoW6V69AYsLcKqQOKh1j0nAwxonKhlQUDQX9TN45pK48FIWWsu8VXEn/J+yvdKSLoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=exzqZ+jC; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="exzqZ+jC"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-82946485d12so278329785a.2
        for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 15:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060843; x=1758665643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aquDpFi6EPnUyUpVuWQPcP3hbc226yXojkZjW2fiqEU=;
        b=exzqZ+jCjaJn7/Zu+osuvhXYXqsLu/PaSi4XeVEmq5yU/6qC7FSalnVtHeTuuB7zs9
         fXcfGe5rB7Ucsp/Jdr3Z5FZ0L2yK67c60S3IZ6wtPCJzy8hvmLM1vHsCzp+7erauNU7N
         PqWAXaiR8Nrn79TWY3dbRItyC0FIpupwEK+VhNDyDHz2dPB0Yb4sYEGyhXs3tJPHOdx0
         BliP5Ppmnd0WNAoiMRwPD8LfwhTeDSMF0bhfKtBCOI1p4jFrFFWD3L29aeDVXsq18luK
         0ZaJHeb7yXdj3Q8HIrlREFggLP7hupNymtBZ9JqpDnxTFvZ/NfuV/cjrgFCjycVGUIlH
         xyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060843; x=1758665643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aquDpFi6EPnUyUpVuWQPcP3hbc226yXojkZjW2fiqEU=;
        b=pPw4VnfWgb/jW4l1dv/G9l6Te6VrVzAi9f22ADw2U9U5u9eLqlpq8ozNkoamzqfAoT
         4OH+epdRDbI5cQUUqZ8Uso05cMA8mqf7eoqFCRAdeERZiqGVHVW6+EEvu2A9XHNOFXG8
         lyWxFhHCm8sdKDx8+zVQ5jm/2HlZNEH6W6m5N8za6Zj7WUaWzunb9Cr78lVt9DebKf2+
         TB9wP/XKx/GSPghjDIWTUeV5yk+xDqaLIj0up9kfT4Myrenbu7lpAdTdCc9WPT8aA0z0
         CyCaOV7RtGTTZfWaEgq0tBBMIftC2FQt/+SDozFgeBFFfXB3guS9EmBpJTYzkLOREgXW
         ii4w==
X-Forwarded-Encrypted: i=1; AJvYcCXxvijdj6qMiZ4ccSyS7wLw85YegilE/Yze20rR05AWasSX+Rga8GK8p471oAN1Y36p+Tf0jOQZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwTvAAB7bf+HDuSN+ri94aa9Lj0JyxhAAjVMkhelYUaVXydP/BO
	IscLmy1T12KYhtGDO9/B04ksYdmI0IPo+k4/MHqcF1UbiESNFJtPdMDdhroAyH7laQ==
X-Gm-Gg: ASbGncuUj7XcOLJbVcEi1Tn1X9uA9Jlljh4JpzG9PoVDS+b+1HevlB70ztiXiW//FCy
	0SXNg8k4qiGCfN9j2HKibYyONZ0b48j0U/5I9BqjAP+7p0zACN+lA4m9+c+D2HWC4HH/YxRUzS6
	KndUFpyN0yh6wFN9xKve36Sxtr7LRQM/RUblnqxT35gGiAzfuAJkPnAmgmDusPklPt6rRFZA8d6
	kQZZOVcloWpv9jKAOAM+gCDim1/NWnlFsXzBTN03Hl2ewqbvEWULHjTgff21SKnXX6F0oMwBHLY
	W7s2qwYtwfMOUTW5pKi97O8w87lgmPx3mbe9n27nurRj5bCwn8vk6UrDoQCWOpFqIkElfkffEah
	ee5NEEt6K5rhIOQZsfGP7o47DLy57e/4zE+j/S2/EhUEWx6+8XGTmNBG/FRYms3l78gCJ
X-Google-Smtp-Source: AGHT+IE3gXuncNdhkFFyVyee4Fp4ebQN5wcKsTalKx1WkrbaTo2XnuU9p3aBx9XVl0yfaqpOoklqaQ==
X-Received: by 2002:a05:620a:c50:b0:80a:fc34:5646 with SMTP id af79cd13be357-823ff7cf99cmr2378838685a.37.1758060843296;
        Tue, 16 Sep 2025 15:14:03 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-82aeb24fcebsm285420585a.56.2025.09.16.15.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:02 -0700 (PDT)
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
Subject: [PATCH v4 15/34] lsm: rename/rework ordered_lsm_parse() to lsm_order_parse()
Date: Tue, 16 Sep 2025 18:03:42 -0400
Message-ID: <20250916220355.252592-51-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4897; i=paul@paul-moore.com; h=from:subject; bh=3GFz75+pgXuExyfdB0UrHZ6YMZucLji/ZI4WfsyWv58=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd769jU4AXqIZKQQZ9wVroUx2pWy3VkSDN7hX kwRIWb2vfGJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMne+gAKCRDqIPLalzeJ cyqbEADdNoBfwYJJXE1+7Z3Wara/7C40NN3+up9v0+x4kKGXkaQRd/GCJx7wGy/307HrY9ChuaW uFsInaCSHkk5ACWBI1TZZZvPDeKT0KmtQOlyLeMw7eEeF4uyfdt0lA9RVBX0vSM9rtJQTaWixMx r64KjMDdD6/2tQJKJXKiipNgzHwysPDw5BIpipFhFVhaFsbCaZEzJveqJ456Qerd+LRrS2NWO51 u1FMtEjTCNTDSnLNr5UiemhEqwKs5M65ApICHbV0IWESReZI0ETWkkraXztZs75V0mbrIVaWvHw 5CNYQ1iYcQD7QTzMgNg9pi64zDN2xAIfYtoHOr97yHJoDxWNkjCbDA5SCJ+exy06ter33ZwraUs JuxL/m3HJucldQUiVmVm4BynPKEybR5YRPACF2U8dtALVjuardgXYR3AQ0LG2MeruMV+fxE2BBr r672V6K6pHlsbS/IQN0HD58+qi2YUDmPfFY1azlNgs3bKVqVNGSv/fZRnwZTe6EdWY0LFexSl+y KZxmlMTY2fraJPv7ri5tyBSJDpRUqvngImFlNgTn+McK4+hHvv64tZWh11ho9iS080WT9vSzZ5S TmvZEZdCE6Rlmz+fxQzsjSa2/EODAe2wKb9Q9/io5n9QqLG0fXDVEgKPv1F2oW5bOjrGsvBDqTm QMj97Qw/NFz+wYQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Rename ordered_lsm_parse() to lsm_order_parse() for the sake of
consistency with the other LSM initialization routines, and also
do some minor rework of the function.  Aside from some minor style
decisions, the majority of the rework involved shuffling the order
of the LSM_FLAG_LEGACY and LSM_ORDER_FIRST code so that the
LSM_FLAG_LEGACY checks are handled first; it is important to note
that this doesn't affect the order in which the LSMs are registered.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 82 ++++++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 45 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index a314484d7c2f..7b2491120fc8 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -228,83 +228,75 @@ static void __init initialize_lsm(struct lsm_info *lsm)
 	}
 }
 
-/* Populate ordered LSMs list from comma-separated LSM name list. */
-static void __init ordered_lsm_parse(const char *order, const char *origin)
+/**
+ * lsm_order_parse - Parse the comma delimited LSM list
+ * @list: LSM list
+ * @src: source of the list
+ */
+static void __init lsm_order_parse(const char *list, const char *src)
 {
 	struct lsm_info *lsm;
 	char *sep, *name, *next;
 
-	/* LSM_ORDER_FIRST is always first. */
-	lsm_for_each_raw(lsm) {
-		if (lsm->order == LSM_ORDER_FIRST)
-			lsm_order_append(lsm, "  first");
-	}
-
-	/* Process "security=", if given. */
+	/* Handle any Legacy LSM exclusions if one was specified. */
 	if (lsm_order_legacy) {
-		struct lsm_info *major;
-
 		/*
-		 * To match the original "security=" behavior, this
-		 * explicitly does NOT fallback to another Legacy Major
-		 * if the selected one was separately disabled: disable
-		 * all non-matching Legacy Major LSMs.
+		 * To match the original "security=" behavior, this explicitly
+		 * does NOT fallback to another Legacy Major if the selected
+		 * one was separately disabled: disable all non-matching
+		 * Legacy Major LSMs.
 		 */
-		lsm_for_each_raw(major) {
-			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
-			    strcmp(major->id->name, lsm_order_legacy) != 0) {
-				lsm_enabled_set(major, false);
+		lsm_for_each_raw(lsm) {
+			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) &&
+			     strcmp(lsm->id->name, lsm_order_legacy)) {
+				lsm_enabled_set(lsm, false);
 				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
-					   lsm_order_legacy, major->id->name);
+					   lsm_order_legacy, lsm->id->name);
 			}
 		}
 	}
 
-	sep = kstrdup(order, GFP_KERNEL);
+	/* LSM_ORDER_FIRST */
+	lsm_for_each_raw(lsm) {
+		if (lsm->order == LSM_ORDER_FIRST)
+			lsm_order_append(lsm, "first");
+	}
+
+	/* Normal or "mutable" LSMs */
+	sep = kstrdup(list, GFP_KERNEL);
 	next = sep;
 	/* Walk the list, looking for matching LSMs. */
 	while ((name = strsep(&next, ",")) != NULL) {
-		bool found = false;
-
 		lsm_for_each_raw(lsm) {
-			if (strcmp(lsm->id->name, name) == 0) {
-				if (lsm->order == LSM_ORDER_MUTABLE)
-					lsm_order_append(lsm, origin);
-				found = true;
-			}
+			if (!strcmp(lsm->id->name, name) &&
+			    lsm->order == LSM_ORDER_MUTABLE)
+				lsm_order_append(lsm, src);
 		}
-
-		if (!found)
-			init_debug("%s ignored: %s (not built into kernel)\n",
-				   origin, name);
 	}
+	kfree(sep);
 
-	/* Process "security=", if given. */
+	/* Legacy LSM if specified. */
 	if (lsm_order_legacy) {
 		lsm_for_each_raw(lsm) {
-			if (lsm_order_exists(lsm))
-				continue;
-			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
-				lsm_order_append(lsm, "security=");
+			if (!strcmp(lsm->id->name, lsm_order_legacy))
+				lsm_order_append(lsm, src);
 		}
 	}
 
-	/* LSM_ORDER_LAST is always last. */
+	/* LSM_ORDER_LAST */
 	lsm_for_each_raw(lsm) {
 		if (lsm->order == LSM_ORDER_LAST)
-			lsm_order_append(lsm, "   last");
+			lsm_order_append(lsm, "last");
 	}
 
-	/* Disable all LSMs not in the ordered list. */
+	/* Disable all LSMs not previously enabled. */
 	lsm_for_each_raw(lsm) {
 		if (lsm_order_exists(lsm))
 			continue;
 		lsm_enabled_set(lsm, false);
 		init_debug("%s skipped: %s (not in requested order)\n",
-			   origin, lsm->id->name);
+			   src, lsm->id->name);
 	}
-
-	kfree(sep);
 }
 
 /**
@@ -322,9 +314,9 @@ static void __init lsm_init_ordered(void)
 				lsm_order_legacy, lsm_order_cmdline);
 			lsm_order_legacy = NULL;
 		}
-		ordered_lsm_parse(lsm_order_cmdline, "cmdline");
+		lsm_order_parse(lsm_order_cmdline, "cmdline");
 	} else
-		ordered_lsm_parse(lsm_order_builtin, "builtin");
+		lsm_order_parse(lsm_order_builtin, "builtin");
 
 	lsm_order_for_each(lsm) {
 		lsm_prepare(*lsm);
-- 
2.51.0

