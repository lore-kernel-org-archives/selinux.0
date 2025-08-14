Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C41227D784
	for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 22:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212086; cv=none; b=nt3vJexDo74PsrgUubo6tLwaXY/xMk//y8Arwo7Hl8oQ23WOmH43IlYyGnWi1A8tiygVIKnJz0DnG5O3hhaddsTha6GtKhvoFVbv6K8a5calUOqSFfi2vddelCZWIPHgxhrV+wdk0PKb2g7sS8AG1DveamHGERhJx6iEmGib3UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212086; c=relaxed/simple;
	bh=wad8yPxEqZJqWB5zjU/z7iNb/lxx1a9hnkJhlJgcoa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5NRha5bgAfNZYJ12w8MQ57TwNUtGqx8+5HjwqpVrgD5xkSbTT9ou5sFpzAGaRtO6K/ilsa8aG88zQTHEG2v6jSd7AQrV2Jq9gtsc3HhjqMv5/UB8gAGuvFThV03cpdPnKofSq0ni3gylBMR/QH03UNto28DCokvGgr9yFRGZao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ooj46su4; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ooj46su4"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e8706856e0so134177585a.3
        for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 15:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212084; x=1755816884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55Egp+RXQZtA9dvYXyUja+ZKqUHQpjzNbm1GmwcO400=;
        b=Ooj46su4uIA4DL0+8rURkrQ726A1apiY4/LO0duyOxy9Wa1eU+LVUgNg4dee/p1dFw
         j0ooR0vfuCDKw5PskHSDiPV55iZMQ0GUyhCRvRzZBMvOXFBVEeF80g1bUpzBy1BJRVYd
         IJrzhpwWLvJW+IQ1OLIucf3mevtlC3fa1DY7RqD7m6b/zZiZIidCAslfWMozwMw2urEt
         9JMWOhblCT8lZ52sKonhUwfxNDp0PIZCOkliSAk1i8S4z0vwaqyXcEpgJ0d6ushov6eH
         pVB+TwB27FwXNBYwkiQRsJCKHJC32jR255e5J4WSeq5wgkb9Cdb9l/gqYUFam5uq41gN
         FzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212084; x=1755816884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55Egp+RXQZtA9dvYXyUja+ZKqUHQpjzNbm1GmwcO400=;
        b=S9PIdcb2OZNFTRlO+3cozhqRj2w/hYC+rJn4u3hGzlBw7hq2l8WLDpeVUYAYWO9XyJ
         NPpOoQrjlatjOF9k9gOqidB11t3vxWw3OWPTIIhU9N+JS/b9CNd9qOCxFiCXpyWoBdgq
         dXcc9MfEPJiB8THzTZk3BFCYxpu1tWrMUSl6ceH2MCdlwB+61M79YuqQEmeB12jwUN2W
         Mvql4t+jez8OCoPhpQv8LeqKdQRKUtuMhuyLjBFWr7Hwj8z9pZ9VAf0M5AnPYx9RPm+k
         bJM73w4wlRjwULz0bUc+IfC5kkil98aWH74MWXs1w7ylnqvl+5ireWORMkzOJ8oPV7NC
         WZMA==
X-Forwarded-Encrypted: i=1; AJvYcCWdt0DyMLGJCBT1jTK7emXTiAGBAmHmkTD3FFymzAqrbER0o8S2FvyeQMAvC0HVvYv5qAWi2RHr@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr3lk9LyNBhLyjqtF/cMn7bVtlm/AfkpJ1o7KAyt6bBMi+5iSk
	+PBaGbSSx2H7khdVWhQJAmB0BUikGWePBIaoYG84/5Pm59ioFY8Ju6ivlMxTGkkdKw==
X-Gm-Gg: ASbGncsIrmWgc/FqkBqmMa6aacyF6eHSPmFuMIyEzlxOrC0mXl5hLhZzZTpE4duloGl
	9AG5sOAeFU7CzthZUcsV1Tmy1uKyVZKxzxed174RaJHdhOXbHsbuzz5+LSiei76GiLCgcYaWdnk
	dCe2lu4HW7ecsoQR4ukiFfXL6AvHT7yuZLsTyQUvj8WZ9FZzh3OvA1kcayKh+PNyYY6hT1u5A1G
	Q/H5kdO9rfve8PijddcurnUTSnXojMcTiVs8QS4CddiyVKo2KwWqCa4vgSPIZXPL3gNLLygvl4n
	QyK5Q/a3l1kg3QNVCtUfAfx3eTeoL2zFAUwT0Ij9vRHGxIkb+NtAsWa9MnxrjvKKRkRhhsABZH0
	ltp4OylBDd2aexzMZe87YLlN9jvUCPFMTeDYBinjtkuiFDvGYVwVSkG0PtSofCBrYVtM=
X-Google-Smtp-Source: AGHT+IFATlyDVZgQwGsskaUrsMGLhGawwCV5ho2uB3y1kIW5aDNySggh6hjXcnb1lF+Jz+1ewBInLA==
X-Received: by 2002:a05:620a:3908:b0:7e8:26e0:d3de with SMTP id af79cd13be357-7e871b5aefdmr504549885a.43.1755212084141;
        Thu, 14 Aug 2025 15:54:44 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87b32ef87sm44177485a.7.2025.08.14.15.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:42 -0700 (PDT)
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
Subject: [PATCH v3 22/34] lsm: group lsm_order_parse() with the other lsm_order_*() functions
Date: Thu, 14 Aug 2025 18:50:31 -0400
Message-ID: <20250814225159.275901-58-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4854; i=paul@paul-moore.com; h=from:subject; bh=wad8yPxEqZJqWB5zjU/z7iNb/lxx1a9hnkJhlJgcoa0=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmjUH2R8ndI0hwu0qT0k72q8mJi/ie5cwv4ZL 6/AsZ+tpA2JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5o1AAKCRDqIPLalzeJ c/oID/9tHFTtM1bbmzEE7keI3+CsbS1vT013C8vbxytLOtitFf+ZLnKCPFW3Jkiqmv0X2gL0Idc KFDJwlGfY6lG/duXdFtyex8hki3sgH5hg1L4GgBmz72pH8Bndb9snkTqKOqeSlSUp/fWMeD5Pax 9WS71+9yC0Zyllj6D1Hg6eoCUm4AvPx/bXurQKGFVefCGXdUMwZ1AYPSNfOa87tPb6q6S5fQF3I o0q+O3Ta49Fqxh1gawlUPLU7wxRyfMtzymmcs2t777AHmpzva5pp9DAvpI+3Fm8YoTBU1TEyscM dsOADO5IRIeD9tZVbWkUYvboulObWFt4jKqj1HZUewNfEMjzrxCA5/yttkxu4B3bO2WMLsTcSoY dV0PfQ3xs+YWo0YJJjrPtGtg4dvhQO0+qNhsag1/NDeUI3YOKICv8Ud2RljEFVjmvyr2yUqH0Lt I6pndDOVCoiRgohQfK34b7FxEJPZyqSWmyn4d9JwCiVSngKGmHp5EFYnPyefiN5Euet8cmqTxwO KNXCmvCEsPr8hLWbrFqJGJGtLTedJFMHZ90X3FoJW3uhdPDIqFXGEKkSGEMmPGuTQA79/mluwkO 3uFEkfqvDcLbINHZgNuxMyayFE9GE5qggBsSne0awsHR9k8IU3RkqL5cJcSfWU6oaxrN+r14r13 dTxMTgBbtWGflHA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Move the lsm_order_parse() function near the other lsm_order_*()
functions to improve readability.

No code changes.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
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
2.50.1

