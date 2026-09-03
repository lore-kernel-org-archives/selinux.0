Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8664A4E8DEA
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450984; cv=none; b=VyVUR3LDEX40maSW8vOY76t3bE6AnnIP9Ve6hudHW9RWTRJMLaDwXcoCEvNxqwi25Ect+bdZRoeGoC9sVR/rXmhLL0WMr4vusRS4WFHnC5t2YPr8YifB8JWZHYsq/P3h6SJqSuVnDnQ8hGcs2P1UtFpCZrKoY519XQiMN/3Y4nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450984; c=relaxed/simple;
	bh=9BK1kyxk5Z0/CaDbriSQ++DzrreFQG+kLaclcVYwGN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gsBH2wL62JZ1xKeiJwYdzz+iyf+BGcJLp5Gkqu4+b0Ix0mSNHB9cudDxCXqe5Huqz4FtaaxMy9DsSEGU8VpFKY+nYMueIRPRNOju841t5AL/9maKfAiGDyZjw2Ub+KwZ0k8zTxYd/5juSd0gZaDkgF2yOhwJktU5AQpu3g+XjDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btkRkqlf; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btkRkqlf"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48441fa5c37so9798f8f.3
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 08:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788450979; x=1789055779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qf5A2iWXrze7f/WQGCmLESIXScEzdMF2bet/pRtY3Is=;
        b=btkRkqlfotTbaNJJyaxS4LwL7rBuN8VRekBWvzMifhXVTv7st8iBwhg2et4/seMKtS
         5kuo1D/4VmvPntokf67cJPDTL4LNAz+SGUysGEw3s5N98UdMU1ZtwhVAvhi+ugahidtT
         jfSwJQ7pt+GVLsXUHRvvPtjmuMziLsx0F1yEEAC8PWrg/W1mpyacXoyLgZGqnQVA273r
         n2i5GatRaL7j9G+lbpjzzjimD0AMbaXAu3o3KhOAfahyW52IJHcUxKg0SCr+TeVFtSYl
         LGlpsCEQRtO0rJ3q7SZbTqvR4ugigRDWDeGnU0OgmVdqIfW8u//Ii3evKOY6AJACEg0S
         DACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788450979; x=1789055779;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qf5A2iWXrze7f/WQGCmLESIXScEzdMF2bet/pRtY3Is=;
        b=lRQr0UNURvYpBZhMDs9ifCRTyIpc884ngDQMxw7BSar9OOtbg/JQ8iaQhXGutnwGx6
         TdPaO3wSVBS5Fm9fKcRSpX0gHsfICh6fdm9IxIu2wqajVgrzDFKns+NHBIoF8yL13/lY
         LQL3PxQNck2fu0rRuIQnqFAx5TCU+Gilpl2iEI4HuV3Fp/GBdNyMcKyX8gegYKAc2nVX
         Y1Gu+McUiEablRZUs5Xpx5eQMqLhmgNo6P4wGj4YDiiJe4LXat1mbczvEn4ko/qQjClk
         0VQqMEcXwWaVEdRYnyWLk6D0cZ/dMaUw7MU7+VD/AKwOHJA5dVBEZMqjmQxORcT1ay+8
         uOJg==
X-Gm-Message-State: AFuF++kUetx1s9/f5+EFnAdhDy/clePnf09bEStL86yO/2FnL/gq6z7X
	1tWiQ+RIAsJQki1MTQbrhKuJsMaBfpihdPUhHxAYksjq41W26+iXFYpH6gtqdfOCqYI=
X-Gm-Gg: AYBFou3maPyD+BNOBsLV9aafKawGj9qVoqoEvYz3RaHTbX1+4lbP44+PIEJqbjr5EKp
	klPST7+QBpE4IZHzxMb5kaeQPzURPQdtc0ZIxCKB+x2INKzjAOz8kgYHY2DuIWflTzOYjrv7VYW
	oH0/iNm/cFjijFtKjuwcmCOQg8eTa6zF5qdgLKaCZgRrywZv9By8QyPJHdexS2bhGKmD9krWmxO
	g4URTKP5Jxhi8wxBsaI15V6g30PM31ZuNT1GwYSXXSGa2d4E50f86uK7dG7F6+IAZxyjwmTfx14
	OqDlT95XJDhO+ns9oUAsKm0l7R0ACsl61vKfsie31sZCrB3dS0mr7iEpwGsdqIgjIk0S3xXRNQL
	NQW78tXFHlPcpr33SVRJslauXljVw8W7A3I3fWQXXXDh4KuvIiTtixwaCCKOKl5mtN36Nvwzsq1
	9BjezBMbM2cHMJ18WYe7k/z2J2tyTk2UabPu2GmR0t3mHc+qr0CkK46wW/MWeQYQgcz86o7nzb7
	D1FfxYELxMK9h18CDnsBXHgO8qcrRKy/TJsDg==
X-Received: by 2002:a05:600c:354b:b0:49b:d03:8d3a with SMTP id 5b1f17b1804b1-49ce58180bbmr220232615e9.11.1788450978626;
        Thu, 03 Sep 2026 08:56:18 -0700 (PDT)
Received: from omos-acer (109-81-21-204.rct.o2.cz. [109.81.21.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6024a8sm80527185e9.6.2026.09.03.08.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 08:56:17 -0700 (PDT)
From: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] =?UTF-8?q?MAINTAINERS,=20mailmap:=20update=20email=20addr?= =?UTF-8?q?ess=20for=20Ondrej=20Mosn=C3=A1=C4=8Dek?=
Date: Thu,  3 Sep 2026 17:56:15 +0200
Message-ID: <20260903155615.516010-1-omosnacek@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm going to use my personal email for kernel contributions from now on.
Update MAINTAINERS and .mailmap to reflect this.

Also switch to use proper spelling with diacritics, since I normally use
the full Unicode name with my personal email address. I'm leaving
in-code occurences unchanged though, as that would be just unnecessary
churn.

Link: https://lore.kernel.org/lkml/CAFqZXNvOGbzy8-ZnJtKi94jfu2H173Tz7VYpK8KuseMQS-9tNA@mail.gmail.com/
Signed-off-by: Ondrej Mosnáček <omosnacek@gmail.com>
---

Hoping for this to get picked up via the SELinux tree, since the main
change is in the SELinux MAINTAINERS entry.

 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 6803f3bd2865..0e672a60afdc 100644
--- a/.mailmap
+++ b/.mailmap
@@ -699,6 +699,7 @@ Oliver Hartkopp <socketcan@hartkopp.net> <oliver.hartkopp@volkswagen.de>
 Oliver Hartkopp <socketcan@hartkopp.net> <oliver@hartkopp.net>
 Oliver Upton <oupton@kernel.org> <oupton@google.com>
 Oliver Upton <oupton@kernel.org> <oliver.upton@linux.dev>
+Ondrej Mosnáček <omosnacek@gmail.com> <omosnace@redhat.com>
 Ondřej Jirman <megi@xff.cz> <megous@megous.com>
 Oza Pawandeep <quic_poza@quicinc.com> <poza@codeaurora.org>
 Pali Rohár <pali@kernel.org> <pali.rohar@gmail.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index fc320b373656..875d0baed8b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24772,7 +24772,7 @@ K:	\bsecurity_[a-z_0-9]\+\b
 SELINUX SECURITY MODULE
 M:	Paul Moore <paul@paul-moore.com>
 M:	Stephen Smalley <stephen.smalley.work@gmail.com>
-R:	Ondrej Mosnacek <omosnace@redhat.com>
+R:	Ondrej Mosnáček <omosnacek@gmail.com>
 L:	selinux@vger.kernel.org
 S:	Supported
 W:	https://github.com/SELinuxProject
-- 
2.54.0

