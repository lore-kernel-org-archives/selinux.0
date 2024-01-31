Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CF279DD0
	for <selinux@vger.kernel.org>; Wed, 31 Jan 2024 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706532; cv=none; b=Rwy5MFHfv3jNg+5R9JE27SW/ucQM0R/6N3jpZKykn3lCQtVkebtIzNpb0XK5AUepqDwGSLyOLHSWM3cexbK/oLNxq7ELkRy3gKLJrEGHhNzwWZe6vhKr43RlMDDuVLzsRSTascYezkHrukzKGPJQE1hWwwjO+uIHFZA/kY7KwJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706532; c=relaxed/simple;
	bh=NIax8MHOUENkMtI9YzOIaUUqrDEBf0QxlpcOJo96GD4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UuYFZc8dLNzZfvofdXoCQ2U5VdsW9G9FYA/o0NKvQ+Ya99BYrKCNJUMtLpBgoeElz3z4mGiDYjllVAhFTeAI0hmvrLLUqvh5HkQEULLNbami9KefqIebxGcI+qjYNmGKIo5uP9BRqoFVOYnUMhgXUmbLAtWw5Vb2K/IoPiQpz8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=dSDMq12T; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dSDMq12T"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a35c0ed672cso449353166b.1
        for <selinux@vger.kernel.org>; Wed, 31 Jan 2024 05:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706706529; x=1707311329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYnnqPvB2mVNPcwfm4wp8HiKFXrf2BHhOZeerXjPRko=;
        b=dSDMq12Ty0+WM0SJzHLQF8bIxOTNBkIvNUX0hpIWK1qmJHQr5WHIiWofkdMNgFgJh1
         wy83aGiR2h95GxFZFyUnYiuyOjadIqOwNal0kS//rC4jXbZFgCyG+d75MJjcMJkVBQOp
         XqckCUGHDHDMlOVFYEGkoag+5s1z5bgyTuQ1dgY0NXAmoO2UgvvyER41aaFMIQsPC8hf
         VWgCKZ28aPtNJN79+blaYscdNMZX9/FnIte9lNC3V57aDKgNwuE6+AzzkqNYIWL3azUM
         8H+W8Wwaj7mcagOgq8QNVEw7ySKwUH+x21FtR+yXBNEVJXQ0ewOYMr2C2d2YMTnTSJfU
         w6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706706529; x=1707311329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYnnqPvB2mVNPcwfm4wp8HiKFXrf2BHhOZeerXjPRko=;
        b=HqmuEY5MOk71bxUuVDtUihoeqdnXMDm+qWWDxZMdLQWR5DoYg5WHZFldzeEi7olMnw
         x2A3WAVkusGgVXHUdifk8T6m7UPY9G2KhL9Nz5M4aH6wIHcTs/l/5s4+EDKoxehDl+De
         vwumtcUDC9QjJPtFVcG2rcdRcOhXFgRRu8E7qSEQn9gwhKj4DnX+Gt+EUCuH7x7zLJ87
         erIMpt88pUlF2sEH4wNllqDk8Emoq1RqJjrGE80SGgcgfm6piYnjSTQgh82Wyj2mx1eS
         arhHqzxT3QeJM8RNoa9hwn4XWZM1fXSaWxa4PNHem6zy5V++94hcG3dLRk6WDYeghxla
         +ctw==
X-Gm-Message-State: AOJu0YzdEVeFspcB2OzqRaiNnfpwlQVrxfIPeNtAnjNH/ceQJqEP8j6N
	kDaUwwBrH5fc5Ten9efCS5CJP9YPPlgg17cQbD9G5GM8eqCfNojQXxcliaQG
X-Google-Smtp-Source: AGHT+IHkJSpFlPU+43/vvB1EewkySMeyMOE7ck9wM2FUscuJXG49KdvX1FhU3KFvn0aBw3f0BRc67w==
X-Received: by 2002:a17:906:bce7:b0:a27:6e73:a248 with SMTP id op7-20020a170906bce700b00a276e73a248mr1133507ejb.68.1706706528949;
        Wed, 31 Jan 2024 05:08:48 -0800 (PST)
Received: from ddev.DebianHome (dynamic-078-050-045-093.78.50.pool.telefonica.de. [78.50.45.93])
        by smtp.gmail.com with ESMTPSA id p14-20020a170906784e00b00a365c673251sm890351ejm.216.2024.01.31.05.08.48
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:08:48 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [RFC PATCH v2 3/9] libselinux: use more appropriate types in sidtab
Date: Wed, 31 Jan 2024 14:08:29 +0100
Message-ID: <20240131130840.48155-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131130840.48155-1-cgzones@googlemail.com>
References: <20240131130840.48155-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use type unsigned for hash values, as returned by sidtab_hash().
Use size_t for buffer length and counting variables.
Constify stats parameter.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  add patch
---
 libselinux/src/avc_sidtab.c | 16 +++++++++-------
 libselinux/src/avc_sidtab.h |  2 +-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/libselinux/src/avc_sidtab.c b/libselinux/src/avc_sidtab.c
index 3303537b..fce5bddf 100644
--- a/libselinux/src/avc_sidtab.c
+++ b/libselinux/src/avc_sidtab.c
@@ -45,7 +45,8 @@ int sidtab_init(struct sidtab *s)
 
 int sidtab_insert(struct sidtab *s, const char * ctx)
 {
-	int hvalue, rc = 0;
+	unsigned hvalue;
+	int rc = 0;
 	struct sidtab_node *newnode;
 	char * newctx;
 
@@ -75,7 +76,8 @@ int
 sidtab_context_to_sid(struct sidtab *s,
 		      const char * ctx, security_id_t * sid)
 {
-	int hvalue, rc = 0;
+	unsigned hvalue;
+	int rc = 0;
 	struct sidtab_node *cur;
 
 	*sid = NULL;
@@ -98,10 +100,10 @@ sidtab_context_to_sid(struct sidtab *s,
 	return rc;
 }
 
-void sidtab_sid_stats(struct sidtab *s, char *buf, int buflen)
+void sidtab_sid_stats(const struct sidtab *s, char *buf, size_t buflen)
 {
-	int i, chain_len, slots_used, max_chain_len;
-	struct sidtab_node *cur;
+	size_t i, chain_len, slots_used, max_chain_len;
+	const struct sidtab_node *cur;
 
 	slots_used = 0;
 	max_chain_len = 0;
@@ -121,8 +123,8 @@ void sidtab_sid_stats(struct sidtab *s, char *buf, int buflen)
 	}
 
 	snprintf(buf, buflen,
-		 "%s:  %u SID entries and %d/%d buckets used, longest "
-		 "chain length %d\n", avc_prefix, s->nel, slots_used,
+		 "%s:  %u SID entries and %zu/%d buckets used, longest "
+		 "chain length %zu\n", avc_prefix, s->nel, slots_used,
 		 SIDTAB_SIZE, max_chain_len);
 }
 
diff --git a/libselinux/src/avc_sidtab.h b/libselinux/src/avc_sidtab.h
index cc5abe35..e823e3f3 100644
--- a/libselinux/src/avc_sidtab.h
+++ b/libselinux/src/avc_sidtab.h
@@ -29,7 +29,7 @@ int sidtab_insert(struct sidtab *s, const char * ctx) ;
 int sidtab_context_to_sid(struct sidtab *s,
 			  const char * ctx, security_id_t * sid) ;
 
-void sidtab_sid_stats(struct sidtab *s, char *buf, int buflen) ;
+void sidtab_sid_stats(const struct sidtab *s, char *buf, size_t buflen) ;
 void sidtab_destroy(struct sidtab *s) ;
 
 #endif				/* _SELINUX_AVC_SIDTAB_H_ */
-- 
2.43.0

