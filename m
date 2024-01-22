Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52BE3D0D2
	for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931722; cv=none; b=CeWumulWFDQqP3m0wGweQWl4CrRNjGMInqOA4hiA2SJmZN6WhEGCtnYzGngYY5oUL5PQrlpiAjIEo5i/YGFAIotmH4MIugM2mQanxQxFKzqqolCSOVyLjZGoMGxLS1mPfSJrTSlm381KMenFts//pZlc0OZIY7+miSS/iqKjjUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931722; c=relaxed/simple;
	bh=nfczQJjs6fspy0YNjrp19+MwQac1ZEv/eYPqKQZONJQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IG4u65jfqbB5umOXA4O0kkaJnkLHMtHE4LbFgzyxqBvy+VOStwHJ9xgn8/2hGgzt4DSaEd2d5fX1fG43Alq147hBc5TWAunjj1B4hrXikUNmVUvWqYMy+IcbWNIaG2t9YfuSL31CO9SL00se0UjPKO5LCZsxWm6ygnvgUBHAo2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=IAuB35Hv; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IAuB35Hv"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3082d450adso61436466b.1
        for <selinux@vger.kernel.org>; Mon, 22 Jan 2024 05:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705931719; x=1706536519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dUGV6DRvgNfHE1+4P5R69sz1GbmB/SMciU+f+yUlYP0=;
        b=IAuB35Hvo1K1QYpHtRwtlQZMvIpFS7QxgyJZs/zv7pqQ5ZxVKTZ+aEyyCNYE+mF3ZV
         jeqw4W7zjQCmTIjP7+qj+spmwJ84/HVj9RwjWPwYgK/P9r/2znLUaZYowWo0tfFJL/aK
         qzaXEIz9jzyL23Ns2O8fyn72QWmqkemCB0Uwx9Qk61VYdKgde6q1WIrhwCdTFowQs3Ev
         IT/TOh491UMZR7ON6mX5KJZbQsMH9WcU2ep1mQm/0CuE2XgOgfHNjsideYwZ/ieoYASD
         hlu6WHbEMVMk38Ds8SC+grIlDxRaoHAyeJfDGsvY78MEPN01a6cwH9ItQpUX+9Exv2DE
         23Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705931719; x=1706536519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUGV6DRvgNfHE1+4P5R69sz1GbmB/SMciU+f+yUlYP0=;
        b=wWVHfg/LhrpBf+rz9esS/UmoT6cWjV6wxlEqFpqowI/CAL8kvxfaJPPQ7zAf4Az6uQ
         5c9x3ml3Pepb7VjqG5LCSeM7Ec1/ROPPJX0k6k5mFrKF8FIz4tRdhpeDKoVf0u74/e5n
         ravA4l3Fkoswnn31RN44bTCfaC1IHJFBOwqkUO8gNF+AR38/S54q+U5rzfo0Frz91hhX
         PsHp9mNEgPwoBbU8sWjJm8jAMHXhEuhLZ3zlh8i0ZSARjv5uChgU7Q2mC3gEfw3S80oT
         qLyL74JsX0L2LlmNHyGP0MnZQfB603p0+5t0aVLKO3NbazHRLTwRpUVrGygUZ/7UqGdR
         Es1g==
X-Gm-Message-State: AOJu0YyRkFMMZo0NiXvRJfoR/1Sfz4TS8RojB5Jk4BdCjG3UADFv6RSM
	kBToc8nBbMeCZPayklXB4kMhVWggoaaMZPzSEuytHRX5Hm9o/kMWYc+jHA9V
X-Google-Smtp-Source: AGHT+IGJhd47QdG0DWHzEG3lOlB53GrCAwx60lPFP9zXUfTOTrnLkj/b2a76hrYTkijBm/NanJtm8g==
X-Received: by 2002:a17:906:1787:b0:a29:4d7b:e707 with SMTP id t7-20020a170906178700b00a294d7be707mr1899100eje.82.1705931718937;
        Mon, 22 Jan 2024 05:55:18 -0800 (PST)
Received: from ddev.DebianHome (dynamic-077-003-088-202.77.3.pool.telefonica.de. [77.3.88.202])
        by smtp.gmail.com with ESMTPSA id i16-20020a1709061cd000b00a28825e0a2bsm13340284ejh.22.2024.01.22.05.55.18
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 05:55:18 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 10/15] libsepol: add copy member to level_datum
Date: Mon, 22 Jan 2024 14:55:02 +0100
Message-ID: <20240122135507.63506-10-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122135507.63506-1-cgzones@googlemail.com>
References: <20240122135507.63506-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a new member to the struct level_datum to indicate whether the
member `level` is owned by the current instance, and free it on cleanup
only then.

This helps to implement a fix for a use-after-free issue in the
checkpolicy(8) compiler.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/include/sepol/policydb/policydb.h | 1 +
 libsepol/src/policydb.c                    | 6 ++++--
 libsepol/src/policydb_validate.c           | 3 +++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 6682069e..06231574 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -218,6 +218,7 @@ typedef struct level_datum {
 	mls_level_t *level;	/* sensitivity and associated categories */
 	unsigned char isalias;	/* is this sensitivity an alias for another? */
 	unsigned char defined;
+	unsigned char copy;	/* whether the level is a non-owned copy (compile time only) */
 } level_datum_t;
 
 /* Category attributes */
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index f10a8a95..322ab745 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1390,8 +1390,10 @@ static int sens_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
 	if (key)
 		free(key);
 	levdatum = (level_datum_t *) datum;
-	mls_level_destroy(levdatum->level);
-	free(levdatum->level);
+	if (!levdatum->copy) {
+		mls_level_destroy(levdatum->level);
+		free(levdatum->level);
+	}
 	level_datum_destroy(levdatum);
 	free(levdatum);
 	return 0;
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index d86f885e..e3af7ccd 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -623,6 +623,9 @@ static int validate_level_datum(__attribute__ ((unused)) hashtab_key_t k, hashta
 	level_datum_t *level = d;
 	validate_t *flavors = args;
 
+	if (level->copy)
+		return -1;
+
 	return validate_mls_level(level->level, &flavors[SYM_LEVELS], &flavors[SYM_CATS]);
 }
 
-- 
2.43.0

