Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395281D140
	for <selinux@vger.kernel.org>; Tue, 19 Dec 2023 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lkgtont5"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40c3ca9472dso54441245e9.2
        for <selinux@vger.kernel.org>; Tue, 19 Dec 2023 08:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1703002218; x=1703607018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ju/EHCOgf62rYkQ9q4QUVPKPjhub7kQBsmANpqcaJb4=;
        b=lkgtont5XxqI1J021zcR4I2D5wm9lxHlNnAyifY50UBzZaHWEvR5Gg6LdgC0Ksnhb6
         NcUcB1PbqG3rXEbRtwuheiqrQ/uS0NxprAU88sORnHo8zaosF8CkUg5yiim0ql6MjWXl
         5kRg5zzBWzyYvzS++5xZO2TzRoqXjJoF93akZhaY9u90KMHDWnrVywmf/geJvUJif8g8
         IElv/yelpL6tOY/dwSIrud0HY5whdyCDPJlZXoBzd6Sb+RsgoPbbBfKnVGPrKvb2+F7S
         yQdSpHwQboSQvSblx59Tfcq3OUrnkphziTcOiPEQetrK4/ZDoD9xmDqnJp3EQT2hmDjj
         U8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703002218; x=1703607018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ju/EHCOgf62rYkQ9q4QUVPKPjhub7kQBsmANpqcaJb4=;
        b=G4twudRgEhIU83ttUHReOS7emcge43pVBziAo8RcH3urCJtELr0EjKXs+7u1wE/6xG
         W9YdyJo5v5V2SLQANDPwVGR4dgU0uLsUOdmwjsbKcNa53qNgZ2Gd+oG4u6lWkULL3cpN
         nDhS9VET4KYJ1k/8HhPL74Pb8E8G4TWVb5EcLprYalwLb2/S8CMy34tapb1ZbND5jXRj
         JWQdMmJIkUQys8JNML2SEBIt9G9tDs8MSpZVKWESwHMeJY9JZ7CWJL3SlCVA6VJmyYLi
         NXRvrrWwsxTc73jmbGzmUc4Ig8/4klbP0FrFOFJ9soFcrwTAItbeISVY9ha9iddE5HiT
         CtWw==
X-Gm-Message-State: AOJu0YwpmhsUW48Hsthvb25bA+6pWA96E7z4ObDz1aKHDy1k9FYi0u8o
	RW9cR/+QSnAJrAbu0EoNLkTvqVIwWno=
X-Google-Smtp-Source: AGHT+IGX39+if41AsFuPa3p0OUAvBPkYqPrBmbnlfdjBuQdi+8tfxjv8S7EA6okFkKZS/acommfIpA==
X-Received: by 2002:a05:600c:378d:b0:40b:3f72:de79 with SMTP id o13-20020a05600c378d00b0040b3f72de79mr6806041wmr.5.1703002218235;
        Tue, 19 Dec 2023 08:10:18 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-010-185-155.77.10.pool.telefonica.de. [77.10.185.155])
        by smtp.gmail.com with ESMTPSA id v19-20020a170906489300b00a236378a43fsm1936621ejq.62.2023.12.19.08.10.17
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 08:10:17 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 09/11] libsemanage: support huge passwd entries
Date: Tue, 19 Dec 2023 17:09:31 +0100
Message-ID: <20231219160943.334370-9-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219160943.334370-1-cgzones@googlemail.com>
References: <20231219160943.334370-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

getpwnam_r(3) might return ERANGE in case the supplied buffer was too
short for the passwd entry.  Retry with a bigger buffer.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/genhomedircon.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 66585987..ecb34fc7 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -985,9 +985,6 @@ static int add_user(genhomedircon_settings_t * s,
 		rbuflen = 1024;
 	else if (rbuflen <= 0)
 		goto cleanup;
-	rbuf = malloc(rbuflen);
-	if (rbuf == NULL)
-		goto cleanup;
 
 	if (user) {
 		prefix = semanage_user_get_prefix(user);
@@ -1005,7 +1002,17 @@ static int add_user(genhomedircon_settings_t * s,
 		homedir_role = prefix;
 	}
 
+retry:
+	rbuf = malloc(rbuflen);
+	if (rbuf == NULL)
+		goto cleanup;
+
 	retval = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
+	if (retval == ERANGE && rbuflen < LONG_MAX / 2) {
+		free(rbuf);
+		rbuflen *= 2;
+		goto retry;
+	}
 	if (retval != 0 || pwent == NULL) {
 		if (retval != 0 && retval != ENOENT) {
 			goto cleanup;
-- 
2.43.0

