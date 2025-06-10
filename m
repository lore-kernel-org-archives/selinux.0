Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAA9625
	for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749579285; cv=none; b=MO9xS0Nv78BBoff3GKHUz26OuxYCBEoXKH6IT9PjkaODB34Fndd+xoOUgDxLu1bXPY43rBWziyGkjHx+TD3hPUQ7jUrAuet5yUy73zkpdPmGs4y2RFj9JtheUreurJIQMTZCLO5vaVskY4VURHTOiuzxv4z4xSShwJU9xiHC5OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749579285; c=relaxed/simple;
	bh=RyXCgdZoYrsYoddFKKQt+s/0vcg+lvQ2fYtYgKlFABA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zung1HlmbHAAxVy1inRwqUtE7KxqyToUblQXOnk5tM93TPZpHH7fmQaxUZ4HMftaaXm7H4cBt9XFRCskhqIwixMknvzBqzA21ti2L5avlBTTlifxSTQJLodaxsIZFX1zrafkOU4SzH3RReYxcI0eQgU4I7wldXVt49P1qRsAIf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOQGuaLY; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOQGuaLY"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d21f21baf7so532428885a.0
        for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 11:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749579283; x=1750184083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aUxHv/i5/Ve91A5uJAn4akIy2kUEAGfA5pi7XCidOYM=;
        b=jOQGuaLYLyIy7gsnvrugsfEB3V1o9QpUf3JWjAPHVNHZ4bR6Ztvwy6Kp/TrixCPOKl
         GPK5ZHiUiefI5/Zs5DvZpmpnc22OzR1316Y/nI2+Vvc0NczcxLiu9+6ODfMCZBZIMPLm
         VVxEFZzfAMCkptBGjL+CFnzAYGzfCUNpsrQPlNweZqIVCuEu8PxUV3/tn9lQZ4Q3SsUl
         gCkChkrQO6Tq5vsFUvMnIN31P+SRwSzO2lTnPRkDJk+P6Sk+jSvjOrM/C+NW9rrqsxld
         go6J/U+EoJe9B5MKmifQlhyMR3FUImQgTEMUqc4pdBPWWkc4f09yrYoDZJvCfaLHAqWI
         /M8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749579283; x=1750184083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUxHv/i5/Ve91A5uJAn4akIy2kUEAGfA5pi7XCidOYM=;
        b=ABPwquz9fMi1NJulXUqlUAGeo28Aph91+0fIYLkBgwC+btDAwa7U9WtIPCUZ8ZH5xM
         67gGHL7sJCLlGdvNxqLdhZCPGse0BwLnnQF9gZQTyx0/Ojv2XWVUuBc/W9oXox9VTBdW
         tbAWj4rswlvIHQAYEH4KcXksMrOME8bgJFj/ZzAAoSBs52OOAIzBtF2JJ1bwU14ZqXP1
         T1aLBk5axvgFgNTqfl7JAdHFXVOHhHqdcNmMFY58bDmjYct59nooG29UQ1QyFpjnC+RA
         qMxP2x4AKdVDbk3yny8oeXA6DSRvZf9MZmk9OyJpkolnhExH5eR/kBrP20pfQwsHdRbd
         YT7w==
X-Gm-Message-State: AOJu0YyasYKv72wBIg6JZb960mNPbjA6rZDhlw0h7L/UBoG2jd2EgkNO
	Hgrb8yP1j9MXRyh9GP9OpBrqUKKNYujMQY+0ucSc/MhsVeHp2eDYKSFZEuiWbg==
X-Gm-Gg: ASbGnct2495ZJ0o1PSFVPJrUf1YjLZ4cu2n45/d+byIIKlaiRqdZTOYkFR8rk79eW3d
	VvMUyMtRNJqVGIOUyb6AkAXPnXdMKLZmB+SB5GBknfUoE5UZMqF8ONZkmtxiLLbRtw0khT70Kdt
	pkQyU4GU9fvd2/UE2ofQZ0Kq1+AhftTjmyIsECtktW/OkW63oBeiwZHxiAoZInnRUaSESrMrYJM
	bswi/KhhI6towbDPDDJvx59i+kJnJMg4BixLVIxLcaCC9yixo/B/8dBYLlcJewUPd+lGLCEWGY1
	v8exi6GbULImBCU5huDw06q2/DJIeK5br25PS/pHJ+GoAZwIKCuiZfxPb/yD0TfHK6TVCZnRW3z
	t9vH0+Vj6IK7HQOAoSMDOVs10CAg5VCf9UojsCM6adblzlfZsCs0nHYD9xsjELXIDWaJ3ny1hle
	DAfEFjXz+xk2o7h0U=
X-Google-Smtp-Source: AGHT+IGAJvQUwHsvVTkpqHxMlm6M02Il/M9bbu9+cB8I2R5JE3G9Sa6t4oK4Izpo2gg3uXHnP1QBCw==
X-Received: by 2002:a05:620a:1b9a:b0:7d3:8f55:8195 with SMTP id af79cd13be357-7d3a88e434fmr49714085a.28.1749579282664;
        Tue, 10 Jun 2025 11:14:42 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3917fe608sm380793185a.40.2025.06.10.11.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 11:14:42 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Guido Trentalancia <guido@trentalancia.com>
Subject: [PATCH] selinux: change security_compute_sid to return the ssid or tsid on match
Date: Tue, 10 Jun 2025 14:14:13 -0400
Message-ID: <20250610181413.30851-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the end result of a security_compute_sid() computation matches the
ssid or tsid, return that SID rather than looking it up again. This
avoids the problem of multiple initial SIDs that map to the same
context.

Reported-by: Guido Trentalancia <guido@trentalancia.com>
Fixes: ae254858ce07 ("selinux: introduce an initial SID for early boot processes")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/ss/services.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 7becf3808818..8a8a3fe9a33c 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1909,11 +1909,17 @@ static int security_compute_sid(u32 ssid,
 			goto out_unlock;
 	}
 	/* Obtain the sid for the context. */
-	rc = sidtab_context_to_sid(sidtab, &newcontext, out_sid);
-	if (rc == -ESTALE) {
-		rcu_read_unlock();
-		context_destroy(&newcontext);
-		goto retry;
+	if (context_equal(scontext, newcontext))
+		*out_sid = ssid;
+	else if (context_equal(tcontext, newcontext))
+		*out_sid = tsid;
+	else {
+		rc = sidtab_context_to_sid(sidtab, &newcontext, out_sid);
+		if (rc == -ESTALE) {
+			rcu_read_unlock();
+			context_destroy(&newcontext);
+			goto retry;
+		}
 	}
 out_unlock:
 	rcu_read_unlock();
-- 
2.49.0

