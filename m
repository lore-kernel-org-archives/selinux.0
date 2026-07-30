Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C561335564
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785416249; cv=none; b=GQgQ5xiHFZJdVIWj9CQNYj953K06+D288cvpM1fe8df/ojlCJPUINOSlDqs/bQ7tToxvqNLBgMb/rASjkW1dJ/puJqmJMKKbiIUW2Z3u5V7PrEx25QBAbbGaZDd4qcyaCGAB1xz7HM54m6h10p/O6jt5cb1T+Hzk7wIdGqk13ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785416249; c=relaxed/simple;
	bh=2RCJlFRHlbCyvwQFmYIS8P/y2vS8Mxb3YG2flkNPCwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=okLxN17tso5UUBxyRwsNkbobNwQylh0rT5rkEbKrXj1qq3IbVvUDI6UMEwucIQ53MrKBbKcJ/3n9+XLq3MUW1TGFiKaAbAg2nCNC+ZcJn4OtEj4aCiZAwISINf9IWH8mTfABuTkX+EKUc/XRhTj4wND8YQAd7QMx/GD74KldNrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPi07nXJ; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPi07nXJ"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-9061a795d76so18271406d6.3
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 05:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785416247; x=1786021047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2uK3T0M5/QzLTR8Mh61zLZZrzsyax32JmH+kt/46cTY=;
        b=hPi07nXJDa6zT71FXg8Adef+RUZuJzeiASxgKer7nGKV/FE7N5e1t41p74LfibDYGc
         EfYhxp/K89X4+c/uZWMaI9rs+NEX3qX6Yc2H5DSCzqRDy84CWsOSSbI6EBe0kKoou7be
         FbTKD4WqVh6rvnH1k+DIAiLKnimNJen7jO2A4N/+6jg+UBCpcyrUKnzJxMS2HjkOaXwZ
         rtvDStcGpx+4bvGLZjstftpFh/Riu1FQOz8FMwIaVJDOgEbE34Q0+6itcjJhJSt5iIep
         fx28rwJJwNUZMosAEgQ7oUU1QEA5hhrGVbG3unKfwKTc/MyyoeqtSis2NhtRXHkgjFsE
         oH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785416247; x=1786021047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2uK3T0M5/QzLTR8Mh61zLZZrzsyax32JmH+kt/46cTY=;
        b=F9Un3r9SZbRUzCasdld84gebidL0o4bAU6ly2QZrU1UEba7bFDStarCwOL59fAXW/s
         Jx6OENWzS67TIAUFkcoiaE9d0AxfMJItf0nyeJE8g651+u27rsxDvROOFWxtvQqXapE6
         i9BYhug4q6c1E7sEDbieCziRl/7XzBYwBe/ml+Pb+99WRXY+L+/PP8HxJKp3KA/eFzkd
         s8aHtE9JNFz1QqsLMFlgLMd9HTio9Aw8f69j+Jc1WE/6LZJ9bXUMiAJPVvfmXDr71+lY
         9VpnbksLQ5uM3IO5z4p/FWNHoq8C4kbYLxvNP7McHJaCVzi5woWMjtLQLbUw7MLQauEC
         gFGw==
X-Gm-Message-State: AOJu0YywlqQd02yQ5l3sWRd/wcnt7DeyeHikZnOFwsqXngefDaWLroR2
	lFPDhfLkGPzKOSGS1fC64fMPgld4U2wr5x30QEXHqn3Hyo0mWXxrAMvOp9BNsw==
X-Gm-Gg: AR+sD13fG3iBAsMJ8QblaznMnMRP2bgMZsPsGxvAKpdBrWq3kjQPrWgGsSoD2Fw5T6Z
	GHiC0hECkoH6O7A8WG/k64nr7pRxhW6JApvRc+kLNt8uADyUHzrQGUW9hrXUjk4QYjTq2k2BS1R
	L09hTWJ1RKK4KU9hyt3dJHO7TJbvBxC24Lgwa6E7ryrjrmMVhEQDYzt0zg7yzUup/i+0qLciN3q
	SQoM/QaK8z2XDb7VYRS7hCQMknIoKG+knxlhbsssHEEc4g73FidVNM+HUPvEZ+IhG9dQK6Bow9F
	LTiacT9aUg9LvD6EEzlXiV1N8YCcevwfyzYlkM7RJCqIWyB4SDJtciMmAbfmBhLtoOpz+S4kxkK
	tqMBrxYrFfzUfhsmAkxnkM+UMzTLeW7rsUuini9A3kTULC9V6Eel8ZVK97YgYZNi8eXBrgCFkHo
	OEopLzKcbvo9BWRFIdyeL4osWuKeWMmbW2ClRbH+UxWcpoEPgmD9jL1NdAcVqs5lSbuAUhQTa4k
	A60t6+DJZc=
X-Received: by 2002:ad4:5ca8:0:b0:907:d6cb:234f with SMTP id 6a1803df08f44-908346e72b3mr23399066d6.24.1785416247355;
        Thu, 30 Jul 2026 05:57:27 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90832514ca5sm17259566d6.47.2026.07.30.05.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 05:57:26 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH v2] libsepol: Turn assert into error in type_set_expand()
Date: Thu, 30 Jul 2026 08:57:12 -0400
Message-ID: <20260730125712.29409-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The assertion in function type_set_expand() can only be violated by
a malformed policy. Since it is called before the policy has been
validated just return an error.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: Do not delete the continue

 libsepol/src/expand.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 8d7fe519..7883dbc5 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2827,7 +2827,8 @@ int type_set_expand(type_set_t *set, ebitmap_t *t, policydb_t *p,
 		for (i = 0; i < p->p_types.nprim; i++) {
 			if (p->type_val_to_struct[i] &&
 			    p->type_val_to_struct[i]->flavor == TYPE_ATTRIB) {
-				assert(!ebitmap_get_bit(t, i));
+				if (ebitmap_get_bit(t, i))
+					goto err_neg;
 				continue;
 			}
 			if (ebitmap_get_bit(t, i)) {
-- 
2.55.0

