Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B5B3B14B9
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780664689; cv=none; b=jFJbWfZsvTylNdEEHIkTtiFHgP5EeyK6tca+WyzkJv8TlqufoNsGr3Kz73gRaD7xJ9/R4kkkblrkyVgMsTW+7tTAINchDClviUZ+QbgWkLeoWsodhncUy5lEG6ec65z8SAXqddW6dP3erKQrgT1AxMFxRPpYwqvcLh9crIk3HWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780664689; c=relaxed/simple;
	bh=tw4NtayFBB3iGGyktakV18ZClA5V9BVem5CLLIS/K+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lb0icORjhvXVAkc/cDbRxUyE1MkQJYvHR76GoSU0DmJJ14Ei/xFKKTEv5jaqWPkB7hvnKwMsmB8rh7lIz8KEItde4DLBDq+2GPhguF08JPhB93iQHOf6Eu2GqYxR8VfzooGVn1qs5gwUzOrnTi+7oJXUDu6HWflw5TBTID/0FRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lieSzvgK; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lieSzvgK"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-6c3a36fa9edso1397382137.0
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 06:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780664687; x=1781269487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8xO8GGLZEwq3Pfoh7VrivUB46VL7hY7a6+tgHWR+rS4=;
        b=lieSzvgKuktdRW4pbh2QjM6APrz93UmKbchFQmidKdepNFEjcEKkLqkP4etH0pHrmX
         t1lvfoUFj3saUa+u+tXNPnd2YpnG8USFj94vy6GRlnbAB0HLztC3gIudhfTkolmGs1Kk
         QY1XR1bycAnhbm64+fbvBgZQkUiGW02RDhr6dR0kHJcs3bCYJ/+JFD6mjNSEtRx2p4iq
         c8jIo6c74SU2Ce/PlTxFXB2myfg7DAyb6p+lk0bhIb1ZALY8ObkttRCd19SY+TCo4NvZ
         +fU2v0msv1bLhDMJeIwEmDRIFIu9Y8nwcE8W+R5zJldHTp6wN3cfSDBTxScy1mKYGBC2
         lGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780664687; x=1781269487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xO8GGLZEwq3Pfoh7VrivUB46VL7hY7a6+tgHWR+rS4=;
        b=H7va75G5urDQ40X1iw4AeW5JfJMWokr1rk04S9VschXuTt/18uVfJ8WOZ2lldw17KL
         bFLSwl79QlS4YUwibOQ9abkJugtnj76pHoJuGSOX/gvN7EZhiTxGaP0lTQwhpfcXcqAL
         H0OUxF/zRl6Vmds84lrzT67Cg0B6JZTVo68dSjj8vEvNJ2IGpj9jJBR0ASlknSyeDych
         5baYPsMe/n0hSLS9kcnq/Vj2v7NbE7f4GB45kenI8nQqeQUQC1RyuBJgCCfzmIp7OsRQ
         zo6jdN7TgrZbKFl8ECOLjKYsiPg63YK+xCmveJLTyoFHh/RvU696j5fjcsmbJ7yomvah
         oo6w==
X-Gm-Message-State: AOJu0Yze+9gflL5EcWh12cfOBC1VCjI3t20Fl2cQIqB+GeacFKGAguWC
	il2YZNXxDZtuwBJ0GAwvoYT9twIAtQ2iNH2aA10Jl6eWKU6iAR7ZT97ppvtTzg==
X-Gm-Gg: Acq92OEW2D5pzjB5r7CthfC8A/Hh6tteHUnwL+mOHFb2fgi/C8IQhOAa5+iATvq/bnH
	3C4fdOfqQLFyejp93AuNnsV2fBmrLjcZrgWh1RP23DVbF+Ykq8S2vsoehGAU43G0esDldiVpq1k
	Bu2Yu64G/OOj24UI6Na4EdNwc/oatkaxXx93avNDFR50SnA/dUpQ4OrBpz5097t7BkmjpqX8Ixu
	+gUFs5EiopGwC0cXPpR1clSKArBiUZ+EHvSo1ZcXZCSer/UpPW6t4sp6NSPGEhra/MxDX54jYrh
	x0BqFxepvkWtiahOADRwrIhsrNqhZEe88o1GE+F1YThsVtARRFT2JbnaXkb6Rv1AkUYiaUgsqks
	gNRMljdN2x+CvnGO1kQEyND8nYSg6LL/yoCXrAJLDujILCepZgh+vM9+LE2xwZJUhq4qliSoCGP
	wPTKTEkbpoNfU3HmE7scPv51myqilRcdSFf1hkur6Ipy7UGNmXxMG1kvD8YUA5QJKLXsyAo9wmE
	kqpxkBw+bSoD11Yrw5E+S5RoXWw1d5S6IgGWjy3bHrtNErO
X-Received: by 2002:a05:6102:44c2:10b0:633:f7ab:6bd5 with SMTP id ada2fe7eead31-700379cfd68mr603709137.18.1780664686941;
        Fri, 05 Jun 2026 06:04:46 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecc8222bcsm82720096d6.0.2026.06.05.06.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 06:04:46 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsemanage: genhomedircon: fix STR_COMPARATOR() passed to lfind()
Date: Fri,  5 Jun 2026 09:04:32 -0400
Message-ID: <20260605130432.273624-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lfind() passes a pointer to the key and a pointer to the current array
element to the compar() function. The array is group->gr_mem, which is
char *[], so the second argument is a char**.  STR_COMPARATOR() was
incorrectly casting it to char * and passing it to strcmp() such that
the key was being compared to the pointer value and never
matching. Fix STR_COMPARATOR() to instead dereference the second
argument and compare the key with the actual username from the
group->gr_mem array.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/genhomedircon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 68382b95..d990c535 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -563,7 +563,7 @@ static int USER_CONTEXT_PRED(const char *string)
 
 static int STR_COMPARATOR(const void *a, const void *b)
 {
-	return strcmp((const char *)a, (const char *)b);
+	return strcmp((const char *)a, *(const char * const *)b);
 }
 
 /* make_template
-- 
2.54.0

