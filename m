Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A4F32B49B
	for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 22:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060884; cv=none; b=S3WsFwIG9UKPmf01WTS3H5pkrThqbyjraZwmtcPaB4ZeBJH1sTRXan264lLMj5TNA1kReiiBU+vOnEPaN2GnM50BQVyIgk1doCcIWua4jJPKOJnAf372iric4V6gXSFCs7P/JbndUkndtjFoJ3oc2GgSMNtqPVENp9wDuQkSjrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060884; c=relaxed/simple;
	bh=aCC82L2q0ysTfaRazG/CWqQeq8HFWa6+t3PPs9R+FMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NG1UtBW4eUIAypGBd6RGM6FfD3/bMQNP30385K5XAeuatXGfoewCYGfTaBkmxEq1joUZubFj1m9K7D1aDeJlO71RSG/Ydh3GPTOcv+rfxsvbMmB+g0arRaO67DCpz63EOukN00XDrPuW2Q3VWZHZddtUwYbPyNavYHrIJ43NxRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LVzHf5MV; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LVzHf5MV"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-782ba4488b8so29981176d6.3
        for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 15:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060882; x=1758665682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01szfj2Cz8qfgT6cyE8Os4+shA0fv2T2/bVUGDyEzf8=;
        b=LVzHf5MVNE643XNPSSlSg2haxWFxB/Oq9OD+GrC7bYouRY9dbJBeGZ2CxMng4dWQVP
         Ez4R/dtHWFd2dgxVhfc86I4snrnlZLN5Lx3xDMPda4bIrXqwAJgxGS4X8y/0Gny38KD0
         yfFz9n5CZkJRjLJKoqCf8Q6dfS6GPc5oB40C7CSpN5jVv3Mn5Hij0uUJPUb4UXnWN2H5
         uNpHQj9dpyY98eR9JJmT/QxmVCIT42U+QVAKJwVxu34qxyEXWOrfDuXhIp8mbo8TqM3h
         MXJCwo/0fEMvHtEQoms2mNHkiDpgTb6HjglgWQEDLKTk59gNU7mQw2hRqgVKulJDQnQG
         t8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060882; x=1758665682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01szfj2Cz8qfgT6cyE8Os4+shA0fv2T2/bVUGDyEzf8=;
        b=v4Ak8CaUuPmG5556h3Qc6s4cE7GG1jyhQw3S9sqCB/Sgj5dCFlMcAxvsxNeE52yu8q
         sR9clcnqGqcRJEZU63UCw+udbwyReQhg+WycLMzdjHFj3+67bDZqEV+yCXF9QbBR4Xhl
         eENdTF+7jxoE/Le9GvFyd927y8YOCbyDBekQUwIvYJj/frFQYZKq4de7s4Nh1w0AKbx9
         KJfQmrlKbDUGHlMu03+IVX9ZQozf6or+7TEmNVi9khmUKFG12TRY7kcJz0k98L0b8hsj
         GGJS1HO9PD66e0+wXZLRwC+Lm2qvPFQCLr8JVNuXBdzQG84QQ267hTsrxP30E0yzagET
         6AOg==
X-Forwarded-Encrypted: i=1; AJvYcCXDQnTTJnuTWr5PIcyTP1y1oOkDwZaLDzR3lLLf0a563C4P78SbJ8pC2WevaWIDTruY0WPvpl6G@vger.kernel.org
X-Gm-Message-State: AOJu0YxpB8MHFQ9ll+Ty6wMdbjt7hrJa3p00B73gpVB+Hn3lJI7/ts7D
	5OsnmIOWdkZTSVfZLpyDSk4zykBArbmOomprEuJ4cmx/4e4jgY+hnYMpCvM7EH+YyQ==
X-Gm-Gg: ASbGncv5ybpTCpttsqBO2YlVpPU4nJ/ZnDa+3zx/yuCMigUZwvZt2m3sbs7CrN8hhvZ
	nVs5W+ct902T6GQbu/c4wit4aAcvH7YA+DzGCBiG8CDqEWPYf7RdC4GKNIT7LyQpuqMeQKXhPBC
	T9WG+xYETIRfk+g1CHBjG5HOM+T+UuMyy74kZdf/vnqnxumSMC35ez0tKOthZ12+czrx45A+dvg
	BCCIA0KwQd4n0Vy/IuzUs7+KB+pJweo5/bLc9aoQTW0rUkZubzzC4RFZFTihY28xN8mS+2iXu9K
	/SM3UhqcxOLu29fwe2xwDyiUaO5U7/eLjppkXfNDm3eCly/NR7bxutNfhf2Fwtv4VKwPURnv46f
	KKQ0xlJhoTMyOe7U7WfKb9Vd+9BQoOGEf+xjMlmV0uYmecs1mrdqVGdr72jNz8WFKZZ3s
X-Google-Smtp-Source: AGHT+IF1dqpDXLNbt8CmRok87Jh+UImED7Clfzg7Ej4N3+L8YwCkf8OUBsmT+MP+k7B+bCivdtcyOA==
X-Received: by 2002:ad4:5e89:0:b0:77c:eb84:8de0 with SMTP id 6a1803df08f44-77ceb848f79mr134501036d6.26.1758060881918;
        Tue, 16 Sep 2025 15:14:41 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-763b3f49139sm101521606d6.9.2025.09.16.15.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:40 -0700 (PDT)
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
Subject: [PATCH v4 34/34] lsm: add a LSM_STARTED_ALL notification event
Date: Tue, 16 Sep 2025 18:04:01 -0400
Message-ID: <20250916220355.252592-70-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130; i=paul@paul-moore.com; h=from:subject; bh=aCC82L2q0ysTfaRazG/CWqQeq8HFWa6+t3PPs9R+FMg=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd846bpw0/+yoZxyQYOyFvIbV8lN+aCviDkZP XEGukbIvcmJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMnfOAAKCRDqIPLalzeJ c/j4EACQv3IyAp1a6CGB5WxKeCmgzNhL+HZiDLDBIaW/iAbkiZpvYBFCsvOWOuZbe7VTC02tQG/ RNj0eRQ50N6xdM8yRdp1kUHQjGys1aOGlFN2PwLEDoCZb5Y4ZFCxm3ctvJnwTCw8CfzdlCJLcXC sR+lUfGdHuYQuG3H6Ddf2Asq5bnOjTP53DzGPbJHkCciHrJCZkZAv5IbBpy1PQXLXm83EBz6cep CSNc3O/sOWEqk+grtxeS6nTcdLjFM7has+QIuP9jNshkoGffl37Ltw6pvLoW0ku0iSpsT22MW/l 4d4Mf0ghXp61Ayd8Ay+bNoVGERvh+0n78PhWN5tjZLPNqKaIlSylR3/UX6xGnkiKUJDseCl/3v6 I289CwjJhRWbR7K7gCqGItzETYHvsQXQkZXoObI1QDv+MmedJGiDNtrBaWG+fjIVEKjDFZQVi8n Or38t1N/cBoSV8sogiABL29Eq5kcgVgRPd9LCngb4pti7H8bSR2wQOoVWXlPj37LVSuIpeuczd/ 8CZBedW7Roi9c7nG7Z3oelDSrSMimGR4QQF9OnpxwIa7stfupQrW0748FQPjZH+4HpCKLerN+8e Dj6E96LTEvDq+Jv04p8z3F/gos5IYhZE4aJ4k1WWrkf/BwFNwxM5LiYq5Pk0k/WG0EYeXJrIBhs +e3X68c3GRynkYw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Add a new LSM notifier event, LSM_STARTED_ALL, which is fired once at
boot when all of the LSMs have been started.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/security.h | 1 +
 security/lsm_init.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 8560c50edd2e..c13f0a849024 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -85,6 +85,7 @@ struct timezone;
 
 enum lsm_event {
 	LSM_POLICY_CHANGE,
+	LSM_STARTED_ALL,
 };
 
 struct dm_verity_digest {
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 2bd705836df8..af4046c5c581 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -556,6 +556,7 @@ static int __init security_initcall_late(void)
 
 	rc = lsm_initcall(late);
 	lsm_pr_dbg("all enabled LSMs fully activated\n");
+	call_blocking_lsm_notifier(LSM_STARTED_ALL, NULL);
 
 	return rc;
 }
-- 
2.51.0

