Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA37F1A38CF
	for <selinux@vger.kernel.org>; Fri, 14 Jun 2024 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718394306; cv=none; b=i7LkpPAkdvgnqNx/Y14t1MhzX5/IykcRjMssIHHVPAOiWrAC3bD17Sjle2lq1tkx44A6LtLe0aKrBYmaK+km9c6M2S7JuvLC5xO3vY7rnzJX0QJmvJPjLtpKxpMTRJl6Wq6u58JEpMXPYU4ffK5qtzvmjoC+5tCvs1NoZ23hO6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718394306; c=relaxed/simple;
	bh=cCtgMWr/UsMwRNsBN4PLeh+3pS1AcK8U1/pM0nPWukY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GyB66Ru0zV4LWWS6ONswcG5JwzIaSeNskX0X9Pm05nSkZVe0iSNkC2kHEeOAA6ZQbTdTXFe5IiUNx68lEHiqGMQNNoLMTPZaPJgsgjIyqyUulaufelKzxBcatJcQergPJcmZ+x5/CuW3Utc0eDrmErZQJYsTPeHd/QJ2IA77oVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4NeT8Rb; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4NeT8Rb"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-80d64c817a7so740116241.3
        for <selinux@vger.kernel.org>; Fri, 14 Jun 2024 12:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718394303; x=1718999103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W/2ifWr0Kq5BB4cix9dGUBcdf1I5lOWg7vB0hJv4WSc=;
        b=I4NeT8RbftY61ZBzR1RLGd+/gTewM64wedWmmroKNrTctodrumAF2UVYf2A1OJrCT/
         9lXKpr7/UcgDSFsQpEgKM0T6K1T2UzyS57K0mRFJnvRx/PaIclIORaSIzIlW1pNJ+25u
         4EwLgArhE+5bGQf7jvi4kNNf8PkSuqjs4v2ds8XSnqw9oIP9GujSIQIvCzGKOzJtU69T
         huxAbfVQH4fpbNTHD+Fcyi3W8p9CL3SXWiu/RF6oxv0k9SnkuRwrGaZvQVIZRvDd6/AO
         Zw0pMc5USe040GLdhGqmc4TGKikagmMBEk4gpPF+lJMR9NDqTQlpT9G1iWDlRAZQ4ixf
         aWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718394303; x=1718999103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/2ifWr0Kq5BB4cix9dGUBcdf1I5lOWg7vB0hJv4WSc=;
        b=girskisEzEm51viI4Zh7DUfR6B5/wvvo+QXbOTqrXWDM79dd4sUsSnzPmvW5YcXe0y
         DtD9drN9aHMvgbFlezKLEujxnOOx/b8GjIKigZTS3Op7pm2Fq2c82t2en1pxVJm5WUbz
         C1b+q5rQDChoj+lOKEQJceOF0l5SM2Hgcz03Xn+S6xncFz62Toy4t1FYM81UfjHJX7Ms
         BgwMa5oEJYDL+7FxryzdZj9Ddp5+Jksk/Xx8dL6G37jXSh9WMxrfTgaXNDPdUBDl1Xz1
         dVo7Z2MOXauFmhiIDYKIHkvvYZ6C9UQQoQOfqN/1SVfL6KPkSAZ0GC9lvUGu0BaqQ7x3
         1Ecg==
X-Gm-Message-State: AOJu0YxctZsgqNFvdEGWy3ra/ScXWo4aM7aiW7/KHZ/BrY9TGrdt/UvB
	P+XFofxUPBhPXevHTGiXzEjEzVmVo+0Ri1WE3vFoNFOgm8TKLj34pdsxGQ==
X-Google-Smtp-Source: AGHT+IEwykye0M/xZtbSRMGLYKzjnjPfYJ4HGyprd8jttiEjr4vBzDIjHhndjaJJWKlAIDXhAYXCmw==
X-Received: by 2002:a05:6122:2a02:b0:4ec:fc54:9f86 with SMTP id 71dfb90a1353d-4ee3ed7154bmr4878412e0c.5.1718394303281;
        Fri, 14 Jun 2024 12:45:03 -0700 (PDT)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f310c867sm19285551cf.95.2024.06.14.12.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 12:45:02 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: cgzones@googlemail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Do not reject all type rules in conditionals when validating
Date: Fri, 14 Jun 2024 15:45:00 -0400
Message-ID: <20240614194500.631810-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1c91bc84 ("libsepol: reject self flag in type rules in old
policies") actually rejects all type rules in conditionals in modular
policies prior to version 21 (MOD_POLICYDB_VERSION_SELF_TYPETRANS).

The problem is because of fall-through in a switch statement when
the avrule flags are 0. Instead, break rather than fall-through when
avrule flags are 0.
---
 libsepol/src/policydb_validate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 9746f562..2043e437 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1076,6 +1076,7 @@ static int validate_avrules(sepol_handle_t *handle, const avrule_t *avrule, int
 
 		switch(avrule->flags) {
 		case 0:
+			break;
 		case RULE_SELF:
 			if (p->policyvers != POLICY_KERN &&
 			    p->policyvers < MOD_POLICYDB_VERSION_SELF_TYPETRANS &&
-- 
2.45.2

