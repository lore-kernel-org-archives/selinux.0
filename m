Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21896433032
	for <selinux@vger.kernel.org>; Tue, 14 Jul 2026 23:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071519; cv=none; b=IsxtIalZdunmQ2EqbHLBG91OZzFESu6SJYNANeTIgulGpSXVAFAKQ61Ect/B9hxf+3sb/2OTqkKo7+ZQzr+G5YNXa4etlKJ+0jn2dJ3nDwbhhUpi/hRdu6DmXAJno2SbwC4CUvn44VSpoH1iW255ZTXL+SebdqKhMuz8AB0c0fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071519; c=relaxed/simple;
	bh=EMyaIqviEI6poMNupyWK+XIXrTgcJ7Zo4Qm63jehrIQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EtMAQeJzbdtWI9bjb8wnUctG0M+otHQhwhyy2jqjyh8/XRyx5woEINhCkiXoC1XfanXf5pursOYQcLndDE+ji8QJsq/5AOZHm8YWx4OKvhZXhheXSqkgrnHl7vOvNFPSt+vr1cL6ySjZWKZRDA96wcNP7EdstyJeACSAMnLuYts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ijiN8Xhx; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ijiN8Xhx"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c891ed872ddso8487389a12.2
        for <selinux@vger.kernel.org>; Tue, 14 Jul 2026 16:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784071517; x=1784676317; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6/6BFd7Hisvo7cgiWImn27M1vk9Sd7mPW78xfZEG14I=;
        b=ijiN8Xhx+NgW2nYH3TiiBV31eyEucgXTzg1mD4mzMnIUoCfitea3cKKzF6hvCdYW08
         e0nXknA5zLS/EBgM6Wi6nUjmNGpn2GttzbWPN/ev33QfmhOBi4fq41dGl0uaZ/coVWLP
         YLuATDPWug93XwZcynDBh0EqwfTpErQJDfBkxMamvUUt8nIjltWutLloLJbFPWJ7XBDh
         AT/7qO2M/AKKDUxDrgu5sEx0RFQukxE03rC1JgMZ83CNU2W6y7jK1YBEOu+OHJjngVWA
         TSftlkuNz77uTFcV0D3KIs0IWP4fNkysnzbmzvXc/zIB7Y1LDSOjllJnV6ouC13Qsyyk
         BRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784071517; x=1784676317;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6/6BFd7Hisvo7cgiWImn27M1vk9Sd7mPW78xfZEG14I=;
        b=mlhZVhOMlhQHkEhWiu2kLZrOtvWpEHYgPz3WkoHeRP22OyVZ4CcnkHEnhid0xPwVrf
         D+Nf8yvu5jXc0NZFVJ40vjvwEmoZYLqbAVffWIASNLBrJLxJLCfpuFPRNPLphgHmSoXF
         PrkC2tBcIf+RMykxlIUkiM9nmvXJR3nkpTN4yD7qTc7Gj01n4JAALgUgofRTrTexsuX+
         eunrb8cMPeu0dc7MnUKmKItVlRyxC29BgHa+0MD2gMPl75VWA8Z9/ZnvwGrEO9RCjVXy
         vvGL3MnMG/cQO4fZEP35fiirc+9I1sgT167wdCUDZLJTVlUReZz6x4llhHVIjkbhgskr
         5Ctw==
X-Gm-Message-State: AOJu0YxAj/YRBvWrwoYDduNhIQUTNtZyr+P4fSRX0woSzLpeWJtNwpgf
	16eIT4pUsGq5N9eA+oZ0RB7Aev5+jnwS1kLtq/3Xn5591/C6c7przp5vsA9cgKQxh7J+viZaHyx
	T8i7yZQHXxbHJ2nZPF4LOz74+NQ8NoETrfn8i/Sezv40SAVawFeYwd9wdtshj5xJvr+DBf8Q2lB
	VMPtCilsJRd0nGKX0nWqMzJdp+dxgSV7JT
X-Received: from dlbrd17.prod.google.com ([2002:a05:7022:f111:b0:138:5e8:1b36])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:320b:b0:3bf:e761:6285
 with SMTP id adf61e73a8af0-3c34d5d2da4mr6933191637.29.1784071517167; Tue, 14
 Jul 2026 16:25:17 -0700 (PDT)
Date: Wed, 15 Jul 2026 09:25:11 +1000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260714232511.2858868-1-tweek@google.com>
Subject: [PATCH v2] libselinux: use designated initializers for label initfuncs
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Previously, the initfuncs array relied on implicit positional ordering
to match backend context constants (e.g., SELABEL_CTX_FILE). If constants
were reordered or added, array indexing could become misaligned.

Use C99 designated initializers in initfuncs to explicitly bind each
initialization function to its corresponding context constant.

Additionally, define _SELABEL_CTX_NUM in include/selinux/label.h
to count total backends, and add a compile-time static_assert ensuring
initfuncs stays in sync with _SELABEL_CTX_NUM.

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
v2: Rebase on selinux/main and format

 libselinux/include/selinux/label.h |  5 +++++
 libselinux/src/label.c             | 18 ++++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinu=
x/label.h
index 748b0db0..bde2501f 100644
--- a/libselinux/include/selinux/label.h
+++ b/libselinux/include/selinux/label.h
@@ -37,6 +37,11 @@ struct selabel_handle;
 #define SELABEL_CTX_ANDROID_PROP 4
 /* Android service contexts */
 #define SELABEL_CTX_ANDROID_SERVICE 5
+/*
+ * Total number of context backends. When adding a new backend,
+ * please increase this value.
+ */
+#define _SELABEL_CTX_NUM 6
=20
 /*
  * Available options
diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 1ccd1abe..991b9769 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -4,6 +4,7 @@
  * Author : Eamon Walsh <ewalsh@epoch.ncsc.mil>
  */
=20
+#include <assert.h>
 #include <sys/types.h>
 #include <ctype.h>
 #include <errno.h>
@@ -45,14 +46,19 @@ typedef int (*selabel_initfunc)(struct selabel_handle *=
rec,
 				const struct selinux_opt *opts, unsigned nopts);
=20
 static const selabel_initfunc initfuncs[] =3D {
-	&selabel_file_init,
-	CONFIG_MEDIA_BACKEND(selabel_media_init),
-	CONFIG_X_BACKEND(selabel_x_init),
-	CONFIG_DB_BACKEND(selabel_db_init),
-	CONFIG_ANDROID_BACKEND(selabel_property_init),
-	CONFIG_ANDROID_BACKEND(selabel_service_init),
+	[SELABEL_CTX_FILE] =3D &selabel_file_init,
+	[SELABEL_CTX_MEDIA] =3D CONFIG_MEDIA_BACKEND(selabel_media_init),
+	[SELABEL_CTX_X] =3D CONFIG_X_BACKEND(selabel_x_init),
+	[SELABEL_CTX_DB] =3D CONFIG_DB_BACKEND(selabel_db_init),
+	[SELABEL_CTX_ANDROID_PROP] =3D
+		CONFIG_ANDROID_BACKEND(selabel_property_init),
+	[SELABEL_CTX_ANDROID_SERVICE] =3D
+		CONFIG_ANDROID_BACKEND(selabel_service_init),
 };
=20
+static_assert(ARRAY_SIZE(initfuncs) =3D=3D _SELABEL_CTX_NUM,
+	      "initfuncs array size does not match _SELABEL_CTX_NUM");
+
 static inline struct selabel_digest *
 selabel_is_digest_set(const struct selinux_opt *opts, unsigned n)
 {
--=20
2.55.0.229.g6434b31f56-goog

