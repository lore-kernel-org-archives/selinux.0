Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31592D062F
	for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 22:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060860; cv=none; b=cU+3Yzo7qRO9fiURESsLRLyiBOFujVoH0+1jlmPf7KkKa/leNmeDsAvE+TbpR6xgkD8SwHJK+ulfEw/FFqLp0oPyBSCll1zp3/ZcwfbFEwUw6hnYBGo3kV48p9D/+HAKu88e0bFhRCHewv8GWPHIPMowERAGSqpv9p238zOywO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060860; c=relaxed/simple;
	bh=8gCDEDrBlFQUqi4hn+jg4/j7pBAGN/YYTD8L/S06LaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTGcV8IN35qze90nqMnVojKIk4djGpZn6CCzfOjzJH4mvTvtIxiI0wAtaGVYMr14M3Rd6EsOKhFxa3zFf2hyDjTGI1hRxO9JUWaA5XxNhysrgUpTnlYIm1VsjP+2nHuZZeJJDKjvFcAvsgSuY1yHb96MRGJ7EpFXdfmaKoDjW3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OaKfbXyq; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OaKfbXyq"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b48eabaef3so59925741cf.1
        for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 15:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060858; x=1758665658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZBA0Bz23Qx6udSljh8iUgDakvWyzWbN4XBApDh/JEA=;
        b=OaKfbXyqiuQ/Sn05+gK7RnE1DfH5H1byQDct/RmsAWuTUpLP3gcd/+bIiTCkdMcxwL
         dWI0/8fNET/k8MRspr296V87Ra6PV11Al9nUgbsXjFm6wAwRptyy27qDCKUav54woa9a
         PefafhEfHk7fg7qD9uiWgZoCKZ/P1zHSX8Vy60ihnc3HQdDcLhKmKGKdboUNmo7CC0dy
         tnVGZreP6J98H2sjzuUsigF6lUQJkbPoP79G8H2+qJgUGFFQyw7I2ebYkgKyU6ziq9P0
         aMdJyNv7D0Ba6pFMyotIHawzrW21HPLpXzkBS9TmBGaznnn8x4g2HTZk+h/VY3HD+mQx
         sPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060858; x=1758665658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZBA0Bz23Qx6udSljh8iUgDakvWyzWbN4XBApDh/JEA=;
        b=HgvMwH0aSF9I+Fr5aqQ1V3EPsCPU2fQBcLnmjhHaPBK8Fx1X+WxSPLr0SyVtc58rqh
         pPHpHwAQDxf7LD4p0Z38VzVyZXQGGyWbULxXdD8+tA5jkLDxnzhf7/DKj9dtMQFvq9Ol
         PUelGpMMhfziKDCguJAtHgmwUT5MZOmdrV6YDAh0T2xE/7zYrbxSKh9kMX5TLwp4ENSH
         SxtD4AFwU8tbMr4tkv058l8mgMs39+OpIUbMIkeK+ceTRczeVqJG3uZYqxHxW+0wTIOw
         Yu6byCDyHQKylhFSlVWaDWJzwOkCBOmgKisAX6pay12iL/s9CMWTmWe0Mi9c5sxsfkrF
         x/1w==
X-Forwarded-Encrypted: i=1; AJvYcCWVLXAHgLgzA0lpTJDPBFYxRPtkUSPg/8SUeEeq2LU4JqXIKUIfMBWhgEOmsNqxJMRLGybRzfiv@vger.kernel.org
X-Gm-Message-State: AOJu0YzynPorsicIkoo0BE/oqIWuIozfL5h9fnIUNx3038nsGcMthvCt
	rTUBIckSvUGdN8t8X1NdFsLb7UBzchYORQJLsaJJ3TEwJmNOHKj0YyiMPXqI/TgnSQ==
X-Gm-Gg: ASbGncs2zeV6KDYt3x09TTIcou0JI+Mt6He81UxyInPrFSNw7gRFFyjVXAG9BzzpKoC
	BIHEmrEW9V7xB32aMKyo7IwIxxv676WrbsYGOpybgXhuEvGe9S/UUWIvII9XR+5qUpxZzyBqdY8
	xTjL3cWz06jJrxYrZITYYOi+mE75wv9EcntGyqlco1MrWY01CB+GmNqpDLbbjihyK5xa+OJqSfU
	y4GHgriLZVbACpqo7VSZi+XevH4LqRE5f91QFgaeLWnMy696KwSdGaRpuHX+M70k1wx2uRTdjCP
	NWsYj9kDz8k4qYROvEPTzd4eEcUY1UfN/ZgAwp7c5iCkZEeDM2IhbziQxrA1krDpYoMUpppWqja
	Dsr8FTz5N5KlR1m7PftNq0OaixdW4fsDJ0AafZJhQUq3hTm6g5+6MpxVwjPhFJRUPQkdb
X-Google-Smtp-Source: AGHT+IF0XA7xsbOvhtVRYvZRiE/r4WnDWwodWixFo66wQMCRv2q/zwQvSs50KBUjyn02dBdUTj4Jhw==
X-Received: by 2002:a05:622a:1b0b:b0:4b5:1086:9371 with SMTP id d75a77b69052e-4ba69d35169mr1137711cf.42.1758060857618;
        Tue, 16 Sep 2025 15:14:17 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b639daba5dsm89972301cf.31.2025.09.16.15.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:16 -0700 (PDT)
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
Subject: [PATCH v4 22/34] lsm: group lsm_order_parse() with the other lsm_order_*() functions
Date: Tue, 16 Sep 2025 18:03:49 -0400
Message-ID: <20250916220355.252592-58-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4913; i=paul@paul-moore.com; h=from:subject; bh=8gCDEDrBlFQUqi4hn+jg4/j7pBAGN/YYTD8L/S06LaU=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd8RMZI97m71yqQS9QR+wbesGCt97m/apCS4C l0oN0wTiNiJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMnfEQAKCRDqIPLalzeJ c6MaD/46vU2UEsgFeka5DkMAUPA1jsez0naCS6Ob9CyFuhs6CTFBdE+yz5NJSoCWUl7g9TLxo17 pBtIirEdfspeW/WK6iQubIawWXcNhIChJh/IEipXGCnCVEb5NA8o18WkTZStfuM3Q98BY1Cjly+ lOMDdTNWN3NK3DAoAuXBxTA/ItZ80LDPnxnj8HGaFzyEhqxxJylXYoLh9mGAncgBKUD4G1IcpFH WjIF9h5Lr7mSN9j/GYVM31IsncPAdWjKr1DeYdzn2jM2qOgu+suem6726DYkPdhMOqjwTK7ykkJ DODt244bCtikYFsxtaD9iL9uD3aPwUVSBVq1nZnAPQBA+2IJsndGHqWtYDyFb5WvXCXGHkVlHdz uEIKor/0GmqNaAqyIcyM+dfmLQTxRgvH6NJaHZB0BxB+2jnJtcqfEyh6U4+85azkUxrHM+mDwEu TmxqXMC/t20Eq3ayDep5LdJ5Va+ra0BtV07P/CAyeZPbsmvpjmt0qj6krKLnulqggsZPQrwuUDp Vw+Cc11upj/sobrjkaQOj3+3xnR4cJ1SEEeGeco8POBpHeNLALLGkk4S+gaUxq9JrdsDCyVXtbK mY/wDQ39H1f7muPlRFFefuSb3ijYSUnploPtSDTH6ZfDnJ2Egx6nLDUv0rGL7iy4XF1icG0Ka92 gIsDZtGUWTDWqNA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Move the lsm_order_parse() function near the other lsm_order_*()
functions to improve readability.

No code changes.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 140 ++++++++++++++++++++++----------------------
 1 file changed, 70 insertions(+), 70 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index c6aea57a01e6..363aac92a8da 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -169,6 +169,76 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 	lsm_pr_dbg("enabling LSM %s:%s\n", src, lsm->id->name);
 }
 
+/**
+ * lsm_order_parse - Parse the comma delimited LSM list
+ * @list: LSM list
+ * @src: source of the list
+ */
+static void __init lsm_order_parse(const char *list, const char *src)
+{
+	struct lsm_info *lsm;
+	char *sep, *name, *next;
+
+	/* Handle any Legacy LSM exclusions if one was specified. */
+	if (lsm_order_legacy) {
+		/*
+		 * To match the original "security=" behavior, this explicitly
+		 * does NOT fallback to another Legacy Major if the selected
+		 * one was separately disabled: disable all non-matching
+		 * Legacy Major LSMs.
+		 */
+		lsm_for_each_raw(lsm) {
+			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) &&
+			     strcmp(lsm->id->name, lsm_order_legacy)) {
+				lsm_enabled_set(lsm, false);
+				lsm_pr_dbg("skip legacy LSM conflict %s:%s\n",
+					   src, lsm->id->name);
+			}
+		}
+	}
+
+	/* LSM_ORDER_FIRST */
+	lsm_for_each_raw(lsm) {
+		if (lsm->order == LSM_ORDER_FIRST)
+			lsm_order_append(lsm, "first");
+	}
+
+	/* Normal or "mutable" LSMs */
+	sep = kstrdup(list, GFP_KERNEL);
+	next = sep;
+	/* Walk the list, looking for matching LSMs. */
+	while ((name = strsep(&next, ",")) != NULL) {
+		lsm_for_each_raw(lsm) {
+			if (!strcmp(lsm->id->name, name) &&
+			    lsm->order == LSM_ORDER_MUTABLE)
+				lsm_order_append(lsm, src);
+		}
+	}
+	kfree(sep);
+
+	/* Legacy LSM if specified. */
+	if (lsm_order_legacy) {
+		lsm_for_each_raw(lsm) {
+			if (!strcmp(lsm->id->name, lsm_order_legacy))
+				lsm_order_append(lsm, src);
+		}
+	}
+
+	/* LSM_ORDER_LAST */
+	lsm_for_each_raw(lsm) {
+		if (lsm->order == LSM_ORDER_LAST)
+			lsm_order_append(lsm, "last");
+	}
+
+	/* Disable all LSMs not previously enabled. */
+	lsm_for_each_raw(lsm) {
+		if (lsm_order_exists(lsm))
+			continue;
+		lsm_enabled_set(lsm, false);
+		lsm_pr_dbg("skip disabled LSM %s:%s\n", src, lsm->id->name);
+	}
+}
+
 /**
  * lsm_blob_size_update - Update the LSM blob size and offset information
  * @sz_req: the requested additional blob size
@@ -241,76 +311,6 @@ static void __init lsm_init_single(struct lsm_info *lsm)
 	WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
 }
 
-/**
- * lsm_order_parse - Parse the comma delimited LSM list
- * @list: LSM list
- * @src: source of the list
- */
-static void __init lsm_order_parse(const char *list, const char *src)
-{
-	struct lsm_info *lsm;
-	char *sep, *name, *next;
-
-	/* Handle any Legacy LSM exclusions if one was specified. */
-	if (lsm_order_legacy) {
-		/*
-		 * To match the original "security=" behavior, this explicitly
-		 * does NOT fallback to another Legacy Major if the selected
-		 * one was separately disabled: disable all non-matching
-		 * Legacy Major LSMs.
-		 */
-		lsm_for_each_raw(lsm) {
-			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) &&
-			     strcmp(lsm->id->name, lsm_order_legacy)) {
-				lsm_enabled_set(lsm, false);
-				lsm_pr_dbg("skip legacy LSM conflict %s:%s\n",
-					   src, lsm->id->name);
-			}
-		}
-	}
-
-	/* LSM_ORDER_FIRST */
-	lsm_for_each_raw(lsm) {
-		if (lsm->order == LSM_ORDER_FIRST)
-			lsm_order_append(lsm, "first");
-	}
-
-	/* Normal or "mutable" LSMs */
-	sep = kstrdup(list, GFP_KERNEL);
-	next = sep;
-	/* Walk the list, looking for matching LSMs. */
-	while ((name = strsep(&next, ",")) != NULL) {
-		lsm_for_each_raw(lsm) {
-			if (!strcmp(lsm->id->name, name) &&
-			    lsm->order == LSM_ORDER_MUTABLE)
-				lsm_order_append(lsm, src);
-		}
-	}
-	kfree(sep);
-
-	/* Legacy LSM if specified. */
-	if (lsm_order_legacy) {
-		lsm_for_each_raw(lsm) {
-			if (!strcmp(lsm->id->name, lsm_order_legacy))
-				lsm_order_append(lsm, src);
-		}
-	}
-
-	/* LSM_ORDER_LAST */
-	lsm_for_each_raw(lsm) {
-		if (lsm->order == LSM_ORDER_LAST)
-			lsm_order_append(lsm, "last");
-	}
-
-	/* Disable all LSMs not previously enabled. */
-	lsm_for_each_raw(lsm) {
-		if (lsm_order_exists(lsm))
-			continue;
-		lsm_enabled_set(lsm, false);
-		lsm_pr_dbg("skip disabled LSM %s:%s\n", src, lsm->id->name);
-	}
-}
-
 /**
  * lsm_static_call_init - Initialize a LSM's static calls
  * @hl: LSM hook list
-- 
2.51.0

