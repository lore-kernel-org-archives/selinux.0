Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB6F248871
	for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 23:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140253; cv=none; b=jRb+slC5H7PlrOYMTXgPNzwu8Sa9VCVhebaBug8sBOp/YcU/eksTNesN//XFI+2EEyzLQnp9XhX/y7SqL8IPT6xAFhJ5KM8Fml+lIZ3jHpOgZ4ym5gYtk/N9AjYKrsxOTWdj1hq/BS725YavWwHqylpUMipGon0/pAdvDTwKAXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140253; c=relaxed/simple;
	bh=HCh9v8FXwNoH2o+J6NBb02fZ22PTdaa9s/gHlIzShOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6QK2S5rSSQo5Q4A+gK+AmInc11xgSEen6sRLU4mtmZFnzWC1MOosL7vsinK11fN+h2L4LPCOXS/bbtXim+Jx3RHW8nYfnbn0QL030oGDJDv2xn0Z/NrMLU+CXuD/qMaSyNnSTnnRmUawOkO/37uvmY8Lw9k+e6gNAYSzH2rL8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=H4hcAC/N; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="H4hcAC/N"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e32c95775aso499499785a.3
        for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 16:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140250; x=1753745050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFxrtXIv4+uoW9eouX73/aB+3doQjTft486+v5IMTc8=;
        b=H4hcAC/NXTqwa3ziS+xDloHIG3bJajKDLMK8JspBYAg/4ijTq4Rrc8EEhX/o38Z3jR
         K0DIFwz8H25ke7Mhq3zI0y6Hcc7jMvAvmj0PU70DO0JzbAw9IQJh5z0r5K5sRZu775c0
         CqcBUjYaz4K1tVbZtWeDBnBBvTnEbCj7efDSmAsNrOjCuAvDkNbLbCBrZzmRXxTVhT3S
         AvB88BOpWs3wNRmYS3wVZ9YmUTYsIoaUAHhd9k+XlDcur8OeVms1Ro77V00dg0M/RC2Q
         TYlz8B/1pgQl48+YjoYGKx1E9RKrkQtRhhxSSBPzjuLO8oTDHBtS8CGpCHAT8inZ5c4n
         xHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140250; x=1753745050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFxrtXIv4+uoW9eouX73/aB+3doQjTft486+v5IMTc8=;
        b=pnvhxcG0foJDRrElZt6Lf56Xg1dgZWBKemfvFJeWo8UU0Jj/jlZHYbUiRILlvdjobX
         WMBDXF6ux40eN8cU9SC70RoXEq2P1Wcc9t84bUZyODo8vdbBkzh3q7NheqK4fgCBdjdr
         k9CAfFCfJcoGiHJrCzq8dNLy0J7BP2SK24ZgHmyemwZ3VuOTHwl4YUEn7qDyiO36CwKu
         ljMq7tPS6+sQVz2namyhFd7UbxwBid1wcpVbmKPj17AkahSBX354dqdaW8XXNJDW/Q48
         wrAfz69g3UqKrvJQ0vojDdDSVyknf4zQ8Maxs9RBNNtKbq4mmBK4Jh6qys0Xscjul2bt
         6VWg==
X-Forwarded-Encrypted: i=1; AJvYcCWf4JSwM+Pu9HDOzGsmOylXdrH8ltqMCZnQ7OCh3iK6x6eD0qtHia1v8fPbulgLD8hFjcLq8kw0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw18pQi2T0gCunLM/vuRGWIsZlPtqZtFe8HKIGw8oyDrNkNhRbN
	0U5uqetIFJqGZR7qrM+/SL5h5Gau+W5Ap9wOAHlZNJHrCqDtqh/c2bBe6/8mzyWf/g==
X-Gm-Gg: ASbGncuDRA4OwYZv3x84Mdvxc/f+fGdd0y9PTlLmZg+urMis4zrlCWBPP9BYi3n73lr
	w84tdIsI4q9f+4blIYeK/n/jozDwUFGs4d9i4dgTld30PdEufA7dEXr9T0+/GLp5aj1GAWydxNq
	cT5/05thC/r3RuspYgfcvH0jeRTTHhUp8f0t6PjCerkrX1GJ6Clfzn7ySuV2lGfpyX3LJfj9uzj
	nhGj3HWrbkmoSDF+yVoGge4sLIQDFGVo3XwConwNpQ7k4iZdSm+zBVngpw0UPUmWL0cE7m1tBYh
	+i3JSlgf1U51CbpzSmR1bXUF1tLSVrXkjfPpW1lxorzEC9gvKvm/rU7xMUi6ohBQK/N2lKUf7I6
	f3NUWxja7UWjhMGu7o1kspn0nbpUS+3n9Z0qDcpsJ85L9dAoO8k9Si7rbsMGueN2Wu/8=
X-Google-Smtp-Source: AGHT+IEaWV9DqNldq1DtZpY2l6IrTfev9H+s78qRFzN5rJeJrCXC4lRt8iMeJK65BvS+4jyMqdsQdQ==
X-Received: by 2002:a05:620a:63c2:b0:7d5:dbdc:ceef with SMTP id af79cd13be357-7e34356f48cmr2547224585a.18.1753140249971;
        Mon, 21 Jul 2025 16:24:09 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4abb4b491c2sm47740981cf.69.2025.07.21.16.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:09 -0700 (PDT)
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
Subject: [RFC PATCH v2 10/34] lsm: rework lsm_active_cnt and lsm_idlist[]
Date: Mon, 21 Jul 2025 19:21:13 -0400
Message-ID: <20250721232142.77224-46-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3343; i=paul@paul-moore.com; h=from:subject; bh=HCh9v8FXwNoH2o+J6NBb02fZ22PTdaa9s/gHlIzShOE=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsutsmWBK4qA4LK3BIgxUyjbNqA657sK6bGyf CSqJTtdDoOJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7LrQAKCRDqIPLalzeJ c4Y9D/94ZXF/OMq3d8GsY9lPj6c77UvDMUr7KvfKVytN1w1oVMFy+Ze3BurSWw/HKmk95PvkPB6 l8lz3R0Fv0R5mLV+urW0BvMlPMozyLPgjdZkbfqMc/zqkdWGWvmTEDEOuPMvWOAHJjzlec5sGdm aPmXva2nKVIHSqACZc5tVEDm5MI2GP2YUU8jojmG7eMsmwRpSEuGlmjUaiKIhWCzzJLk/FQ86SN 3CmtVeXd92avevvXYqS7Je1lIraFgIg+viYKoF0olH16qO992XcgIRGsaAHRl9xwUYFViZLwrCj Ylf1flnAan6jPDUVU5yKRBLB1bZ9n7FgFCFz8gVi0ksH6ZUc9QqUDVkNewd+HaMVrSZWfjAIsEC To5mJjnp+/IsdqBgZFPGR6dM89vNGPwzgw6iUFkEHY8H9aj99XZI+IeicZOhbIBd74Beuue0Cia SNNIF2GA0CytB94BWmFj/fMp7PonPEmSirNPU8egLKAIHgJ5GIlwx8JZvBeBe3EqW4hUJxGwnGf ukpruJ5zFRuITLi6jYNoJ87t5fe+AJdypY4trzGX9S4G42qhQNeUusyMGQUgr5W4P0mcrkn7yKG RiEUPsJ3131Ki4rN85252ZI12CIjq+nCystTiL+08de5pTGO7/kYLoq2bR64A3X1a2nfSVWxPfQ EWQnA+4AGk2d01g==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Move the LSM active count and lsm_id list declarations out of a header
that is visible across the kernel and into a header that is limited to
the LSM framework.  This not only helps keep the include/linux headers
smaller and cleaner, it helps prevent misuse of these variables.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/security.h | 2 --
 security/lsm.h           | 5 +++++
 security/lsm_init.c      | 8 +-------
 security/lsm_syscalls.c  | 2 ++
 security/security.c      | 3 +++
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index e8d9f6069f0c..c57a9a7499ea 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -167,8 +167,6 @@ struct lsm_prop {
 };
 
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
-extern u32 lsm_active_cnt;
-extern const struct lsm_id *lsm_idlist[];
 
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
diff --git a/security/lsm.h b/security/lsm.h
index 0e1731bad4a7..dbe755c45e57 100644
--- a/security/lsm.h
+++ b/security/lsm.h
@@ -7,6 +7,11 @@
 #define _LSM_H_
 
 #include <linux/lsm_hooks.h>
+#include <linux/lsm_count.h>
+
+/* List of configured LSMs */
+extern unsigned int lsm_active_cnt;
+extern const struct lsm_id *lsm_idlist[];
 
 /* LSM blob configuration */
 extern struct lsm_blob_sizes blob_sizes;
diff --git a/security/lsm_init.c b/security/lsm_init.c
index cbdfac31ede4..03d3e140e0b1 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -22,8 +22,8 @@ static __initdata const char *lsm_order_cmdline;
 static __initdata const char *lsm_order_legacy;
 
 /* Ordered list of LSMs to initialize. */
-static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
 static __initdata struct lsm_info *lsm_exclusive;
+static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
 
 static __initdata bool debug;
 #define init_debug(...)							\
@@ -214,12 +214,6 @@ static void __init initialize_lsm(struct lsm_info *lsm)
 	}
 }
 
-/*
- * Current index to use while initializing the lsm id list.
- */
-u32 lsm_active_cnt __ro_after_init;
-const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
-
 /* Populate ordered LSMs list from comma-separated LSM name list. */
 static void __init ordered_lsm_parse(const char *order, const char *origin)
 {
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index 8440948a690c..5648b1f0ce9c 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -17,6 +17,8 @@
 #include <linux/lsm_hooks.h>
 #include <uapi/linux/lsm.h>
 
+#include "lsm.h"
+
 /**
  * lsm_name_to_attr - map an LSM attribute name to its ID
  * @name: name of the attribute
diff --git a/security/security.c b/security/security.c
index e77791058086..106f225f4a80 100644
--- a/security/security.c
+++ b/security/security.c
@@ -73,6 +73,9 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
+unsigned int lsm_active_cnt __ro_after_init;
+const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
+
 struct lsm_blob_sizes blob_sizes;
 
 struct kmem_cache *lsm_file_cache;
-- 
2.50.1

