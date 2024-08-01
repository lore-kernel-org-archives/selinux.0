Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84531EB4BF
	for <selinux@vger.kernel.org>; Thu,  1 Aug 2024 19:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722540947; cv=none; b=ncKlpe6JKM99jmT8lB3JHDnbVoD/54g0XUYYbNatY+mw+xgf3mifunFhO5Nlw3rZ2Ufd/FCamzw9jEtqXJq2h/oH7qR6tFGNc/wyHTNIr3sQvjps5qsN8wXeqMW+f3LpdEHD6OWeY13HA5iMaEfb5A333DlL85dRAwZgBsKqNtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722540947; c=relaxed/simple;
	bh=YIHNS31Qci8cf1dZrwTIpohl3onN2SLhfqiqJZHRWOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVPczjUWfeR2vXRUsvg+Nmiad0H10vpugv4kkeYu1tzVrowfChKa14WbvzQG5HH0adbhed33xJs8qjZ8NWPXwAw9iTlQJT8oprGdEQwmSwYhlWckoT03M7x+2iAw8fTECXA47WuAekm0bSvMthCiA3rc+rhu4JUftq93TsXxhp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=siderolabs.com; spf=pass smtp.mailfrom=siderolabs.com; dkim=pass (2048-bit key) header.d=siderolabs.com header.i=@siderolabs.com header.b=WZqArmpp; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=siderolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siderolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siderolabs.com header.i=@siderolabs.com header.b="WZqArmpp"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ef2cce8be8so92194001fa.1
        for <selinux@vger.kernel.org>; Thu, 01 Aug 2024 12:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=siderolabs.com; s=google; t=1722540944; x=1723145744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urJGesFp/+/B5M6GPH6dJY9MWa8UwbOecc7OW3bb8c8=;
        b=WZqArmppdkjE6NqrtMpQG9VpaEKqBfARiBZTDvNTnAYXblx6JgUHtQai2p/ensm78C
         KTSFkus11IG1uAsqTWhO9Bm/28mv+gcP4mOc61wnADfEMMn2v0QcdwOn261iPcknB6uw
         HMa3QTijih6OeQgdo9s/wcugPKv+t0vH5YngmYIPMro9Fzt0PBsPPtK3v5Yy5yFcfksh
         rQZrsLDL1cXOJhNVq4ESlOGCQwmXQjXs0bZETbLU0bQD2k1pyQ3aMKy1ydS+7Zt98Kgs
         d/1rBSe5DUb77f7XWgoJ1WQbnQ6givPlZicl21WiUlP/r72mV87SZG0iH5c9erTjGbdF
         ru8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722540944; x=1723145744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urJGesFp/+/B5M6GPH6dJY9MWa8UwbOecc7OW3bb8c8=;
        b=XdqhvthlxiuE2jRAJ075C3pp0RzzYdnJiLW1dAqZO0p9U4iUvEpDxmt7hK9OgrkWE5
         bT5mvizXO4jeWLFLrcWmGTxI43Zn0dtipWUWg0z5l05GQyw1XjBG6qZAVmFpB2j58ORj
         2IAoF+XZFOwlHtXckq8LGedqRm/tB3vTPHoEltB9U8AIGNsFk0L85yYSXxR9r5QLtOnI
         zpY8jzje2KrD0WyWTWwUjfyjAwp0KGGdphXV47qjNPDF3AOANnHXrNB5XvdxKkR33N48
         87zxUvSovxVhw7g5wE3g1Ub5F+ZMUzgFdprV+UHO6yY6sDX7xsgnLMETEQJwnOTBqTJQ
         ffFw==
X-Gm-Message-State: AOJu0YztoYYSbnIhveYFjobwKtpGu6DKeJYdfXLbbMFp2YDhTWm+A1yl
	nL9NbkPF2ffQvD3eDnQMRXbaqArOFbTGZvw02xUZ2w+4EB5gI3uNYpcStL5BIHyekRCphmOV2kN
	ovEQ=
X-Google-Smtp-Source: AGHT+IHB7k9vYt9zBSJqRu78RuGH0P/CCyOPfpHDvgfFQcD8JhqreIPS5E+3SsZaUsRKofXuguuRaA==
X-Received: by 2002:a2e:a0c2:0:b0:2ef:28da:246f with SMTP id 38308e7fff4ca-2f15ab0412bmr8901991fa.35.1722540943214;
        Thu, 01 Aug 2024 12:35:43 -0700 (PDT)
Received: from localhost.localdomain ([85.143.112.108])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-2f15c47e1d2sm305401fa.133.2024.08.01.12.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 12:35:43 -0700 (PDT)
From: dmitry.sharshakov@siderolabs.com
To: selinux@vger.kernel.org
Cc: Dmitry Sharshakov <dmitry.sharshakov@siderolabs.com>
Subject: [PATCH v1 2/2] policygen: respect CIL option when generating comments
Date: Thu,  1 Aug 2024 22:32:41 +0300
Message-ID: <20240801193241.1627605-2-dmitry.sharshakov@siderolabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801193241.1627605-1-dmitry.sharshakov@siderolabs.com>
References: <20240801193241.1627605-1-dmitry.sharshakov@siderolabs.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Sharshakov <dmitry.sharshakov@siderolabs.com>

Make explanatory comments follow the common style of comments (Classic language / CIL)

Signed-off-by: Dmitry Sharshakov <dmitry.sharshakov@siderolabs.com>
---
 python/sepolgen/src/sepolgen/policygen.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/python/sepolgen/src/sepolgen/policygen.py b/python/sepolgen/src/sepolgen/policygen.py
index 5d59dad7..7715bed5 100644
--- a/python/sepolgen/src/sepolgen/policygen.py
+++ b/python/sepolgen/src/sepolgen/policygen.py
@@ -179,7 +179,9 @@ class PolicyGenerator:
             rule.rule_type = rule.DONTAUDIT
         rule.comment = ""
         if self.explain:
-            rule.comment = str(refpolicy.Comment(explain_access(av, verbosity=self.explain)))
+            comment = refpolicy.Comment(explain_access(av, verbosity=self.explain))
+            comment.set_gen_cil(self.gen_cil)
+            rule.comment = str(comment)
 
         if av.type == audit2why.ALLOW:
             rule.comment += "\n%s!!!! This avc is allowed in the current policy" % self.comment_start
-- 
2.45.2

