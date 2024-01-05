Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89E4358B1
	for <selinux@vger.kernel.org>; Fri,  5 Jan 2024 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="K2f18xsv"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a28f66dc7ffso156479966b.0
        for <selinux@vger.kernel.org>; Fri, 05 Jan 2024 10:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1704479744; x=1705084544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dMHguGUyJJoR1cjboqAis4SvqnwQSlr3rxYvzOG9Q8g=;
        b=K2f18xsvMI34EiuzCjir6UOeAq7xsI2zr6DVh1dfz2x5MOpXuZLDsm9ehzhKRqZeiU
         oSEe3RfVOn3YjiEQiA+RvdJ6cjCX8ZULxlRNR3A34Lsn2yhMWxvrIFPllzCQjj7NCvzk
         8KLG4sgALQ0X5FaTW+pLdMT2t3AgR0/YAS5hohEdegc2+3tqzYr/uqf3yekZPMyYP6Tb
         Tq+SZIANB2I8LWmT0DwTGEF9uU3o9xDGqAuBdE5gzcGwz1e/r/cmFqub4+66NDYY4sRa
         3yStXgMnBEOB11JVAIuQ0sdMOya02am1BHXpY5DiaQX3SOSLp5ZfTTbrWJbmC0ml5aW1
         Jdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704479744; x=1705084544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMHguGUyJJoR1cjboqAis4SvqnwQSlr3rxYvzOG9Q8g=;
        b=kFbln9UHrdBWnoQDY/7OJfRNSIvU3j26u0vt4hYC1nHMOv3AW8Nqk5zoi+kxIYSscg
         N0BfusX1G+xZdzQCV8G1ezPiwl4AsxpAL0N1NJHc/L3hfdwroT643z8FAcvkJKkU6+A5
         N2LOeTIEttQKBzG5IbTBJwFna5GJJFBXf38f22bIFyUUwJ5vMSW4nAjjT9MVNpLfvarz
         3SRLhr9mEjnsJEZqlVaNewNUjLJ+gzklpYgpvz5bHy8jNRghsL/sEv7CA6FF84R8Vp4u
         47W1hrMd5m7urqEPL+dqIk3iHI1bJlwrS0JD4oQtX98ghTUGAZWxBmWZWv+3hgoBWOQX
         PShA==
X-Gm-Message-State: AOJu0YyDVBBnVpApyQ0cQhwO3NnfALagxpTSAdtFcl7GlVoNZXLWJzGZ
	oRAa7pAVgwHOv/JS727IK3O/GWvb6Vc=
X-Google-Smtp-Source: AGHT+IEuEe1AFP8+KLcWJ8pqabnKjkFKYOxRcfFuO9YreUKcM17+6QnHxVCbQk2lEoC/ZNwy6JpkUA==
X-Received: by 2002:a17:907:9704:b0:a28:e1a4:ae46 with SMTP id jg4-20020a170907970400b00a28e1a4ae46mr3105399ejc.13.1704479744054;
        Fri, 05 Jan 2024 10:35:44 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-008-063-036.77.8.pool.telefonica.de. [77.8.63.36])
        by smtp.gmail.com with ESMTPSA id ds9-20020a0564021cc900b0055267663784sm1231319edb.11.2024.01.05.10.35.43
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 10:35:43 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 4/4] mcstrans: check memory allocations
Date: Fri,  5 Jan 2024 19:35:34 +0100
Message-ID: <20240105183534.1110639-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105183534.1110639-1-cgzones@googlemail.com>
References: <20240105183534.1110639-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Avoid NULL dereferences on allocation failure.

Reported by GCC analyzer.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 mcstrans/src/mls_level.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mcstrans/src/mls_level.c b/mcstrans/src/mls_level.c
index 2017f117..2ee1a231 100644
--- a/mcstrans/src/mls_level.c
+++ b/mcstrans/src/mls_level.c
@@ -13,6 +13,8 @@ mls_level_t *mls_level_from_string(char *mls_context)
 	}
 
 	l = (mls_level_t *) calloc(1, sizeof(mls_level_t));
+	if (!l)
+		return NULL;
 
 	/* Extract low sensitivity. */
 	scontextp = p = mls_context;
@@ -124,6 +126,9 @@ char *mls_level_to_string(mls_level_t *l)
 	if (len == 0)
 		return NULL;
 	char *result = (char *)malloc(len + 1);
+	if (!result)
+		return NULL;
+
 	char *p = result;
 
 	p += sprintf(p, "s%d", l->sens);
-- 
2.43.0

