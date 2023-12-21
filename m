Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A743577F2C
	for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 22:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I0QAuNDu"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-427a22138f5so4059911cf.1
        for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 14:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703197564; x=1703802364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4iy6hG5olfX+tqqzJYI9mPz2Kd3wNAbP3zu1gTX3Mxs=;
        b=I0QAuNDulGgnDsxga79Voqv6tLemFDPniaX4hx3mNGz0FOPVFC2f5S/TrWzHnmTaIZ
         WjbYLeR2iWZfnqjvzI2MQFeQVisrjhm93jY2OqGLdjBGxiaKeUeuZ+JhURvusxtWKhGP
         /cHOxHwaKRlZwER5A0piuEWIL85yDH14kyjv0hsqrPg8KUwiHysIYQfuVVHBwfPtSkJF
         FcGRygWpdA8ivc/3YxMh0LARM3qHW3PA9EfVzlUD8rKhucOe+12D2WebO0CjNlog8+uV
         tz8OalxtBXs+g1tFDkdKLFuV7UCXA/Imh6f0+cLHomIhZB196Kp6qwHIGZ2nj7SiFsfT
         q9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703197564; x=1703802364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iy6hG5olfX+tqqzJYI9mPz2Kd3wNAbP3zu1gTX3Mxs=;
        b=jU0kIg0s704hVD+kssx/u5JVBj3aFx4KwuaY7w+9M5KaZHPcNHvhFFUKVhWmi+bo5O
         a2YZk6Qmkx8OD+slW10sYdmAQ7sR3wV/rLnIMax6ux/NqQDix+6FRVPKldipNaIEds9O
         +6D1mAV2RhcjGCt9lE45apetDHnMyOJdZU7QSS/mLhSJyIFxFORa6XMjyONJLgwGgNkq
         yFE0JGi3krb21Hp7vRo+CTWnaBf+9HLuxI/AsaUGyt6MoiGqQEKyRI1qRmaLkaWPIv+T
         BF4ND3s7aA2z4Sr4DMYpiL6cBUg+xkHutABM+q7YZWrPeSc7CR4FUDeFkRI9EL/XKbVs
         AO/w==
X-Gm-Message-State: AOJu0YxW0DNC7edF352rHtutfOQLuZ6OkDECHYfnswiEsMwzwRGH3aho
	MzQlYWGEM6zZ/aycx02XZOQBXYL8sN7EsH9G1ION5qNPNA==
X-Google-Smtp-Source: AGHT+IG5iRmV7uBS1uyZ8NF8iwpX8L5XDaJeCW5HOP9cJxHob/6WWCSpOXg1FI6XzyA5Gv4V9SYTMg==
X-Received: by 2002:a05:6214:238e:b0:67f:6eee:3214 with SMTP id fw14-20020a056214238e00b0067f6eee3214mr405651qvb.89.1703197564297;
        Thu, 21 Dec 2023 14:26:04 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id fe19-20020a0562140b9300b0067f6340a5b7sm917885qvb.84.2023.12.21.14.26.03
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 14:26:03 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 03/15] selinux: align avc_has_perm_noaudit() prototype with definition
Date: Thu, 21 Dec 2023 17:18:46 -0500
Message-ID: <20231221222342.334026-20-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221222342.334026-17-paul@paul-moore.com>
References: <20231221222342.334026-17-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1107; i=paul@paul-moore.com; h=from:subject; bh=21GjL9aUvlTHoLKugYQ+vq/IbyxMCdqzhzkiId2cZYc=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlhLr7mNO3NcTCBhtkQ6wvfIWolLQ57P01R8jlu Yy1oNrdTieJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZYS6+wAKCRDqIPLalzeJ c/+dD/9kBQ20pNkiXbLH4RxB0/PFMzLDKB8KRzOesmZORMQEOqsWlVC2AIMmkV75oteMjyaXJlh FEICvmIGZV1WADl1Zkgaob0W8y50s9zYPlCEOQYZCO6p/ElRtXEMDv8X035/aEvp8wdXnrewnmn g/m9F44Abhg5SgcosZ5w76/JO4RHBvrlolJtFJsO+iRzE1TquT7ZK60LBuVj43LpA5t5gtB6d7a ErH0MrgJZxWv5TjxuqbEchZcXePzDVdwVZJXGnxZJi81FNT9Zdpw7hg66+GDBgBJ6F25ocNrUca BUCkXqGL0YpUPX4F0QyHKjyAdjq0ofylhhL+D6pAjaByTAIQJL8wxyypR3KwGxT+O2XeILH6qus KUZG+LGRvdjfrvrPhyzjo5grZeyez15mlQSMg+n169wWUzzHjIduo9+Vn4+rq9ljWztp2saDHjV 318VZrphH/T8BSpG1tdFuqHkN0xSEkzKfP62H2CN6FpKxMxcpjO7l0qpItFKVdNCCdEXHpgeG+H q1A6INHRrceZ1uYcqp+YfBcm3jXxzJtDLuu/4bpvk8C2FmFl+DQc/ZEp05+eaPh+mpLnwq8Kogn LwoSBIitWoSOiJzCcXt1bl08U5Tae5EIwsSibEn9FSgF4PotxvunxC/3g3MEYwVwS2D68cs0y1+ gS2gwmCVj2N82pg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

A trivial correction to convert an 'unsigned' parameter into an
'unsigned int' parameter so the prototype matches the function
definition.

I really thought that someone submitted a patch for this a few years
ago but sadly I can't find it now.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/include/avc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index eadae219fa78..96a614d47df8 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -131,7 +131,7 @@ static inline int avc_audit(u32 ssid, u32 tsid, u16 tclass, u32 requested,
 #define AVC_STRICT	   1 /* Ignore permissive mode. */
 #define AVC_EXTENDED_PERMS 2 /* update extended permissions */
 int avc_has_perm_noaudit(u32 ssid, u32 tsid, u16 tclass, u32 requested,
-			 unsigned flags, struct av_decision *avd);
+			 unsigned int flags, struct av_decision *avd);
 
 int avc_has_perm(u32 ssid, u32 tsid, u16 tclass, u32 requested,
 		 struct common_audit_data *auditdata);
-- 
2.43.0

