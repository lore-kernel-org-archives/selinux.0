Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19A241F34D
	for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206708; cv=none; b=PNwp9Ro4fAn1IDIwqGco/zRk0KXcOS4177VMs0uBoheVc7kfXiABa29kurA3OU8DUbppSUdUpu0tw7VSRl13XCyQ5ql8MSiyDSy99L5ctiUwi5AqhIHd0JLrzdBeWKeGRzY2a5IcB7J34pwBUHa9baIkl/D78pqNMaHYwv2mbGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206708; c=relaxed/simple;
	bh=Q97wDPnb9qr2MD1HNOEaUNE1RuBoZwSe8mnHN7k+wKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fSw6GfgXymt1xiYzZU6//b6nAHi0Urv05fIBjE9Uw/GC5xdNktgaxahFn5Ao4iZ3oNN+yFP+uSUhkAtsdk79G0bGJdFIdtWh90PTJE6QT/zEHFz4ItqI+Wlaudxw2TREx2BcZencCNfhFici0YtP5B4qO7CSSmaZcnosM8x22js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khGpuFA4; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khGpuFA4"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8ef1dc934d1so4823946d6.0
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 05:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784206704; x=1784811504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yDosUrTJpMhFku8/zH2Bapk/dmtGzstf2XwD/qK1ie8=;
        b=khGpuFA47MloVh7whIPd4toQqJijZtc9tVpC/brG42md5hdEVCb1CHDBpZ0G/I8zAA
         NgnQXf/1bJnbTFLarFoMFWLhK7DG5KKIfhXUh9vVKVLhybnT/W+m2xO0+c0/OnVrlHeC
         Rd3T+AIHx/cpMnAqgu8hX71j6US8kYKgJ+W2AsyK6XS9KuF/M0XHq+7q2Fl+oIptsvnu
         S+18TmQqNhvtx3Z4umNfPJ4fhLIxUJkS8E+mZqD2Lde+6o6jx8JtflFKPVfeNhklSYJM
         /VuBqIUknynSU0enQvMT8NhcoeXdx0l1gqhgC2feVOMUEXN83OUCRcyPb7pIXHOOBSB0
         g+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784206704; x=1784811504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yDosUrTJpMhFku8/zH2Bapk/dmtGzstf2XwD/qK1ie8=;
        b=R20k8TbMAQc7dYpE5lB2Oq4JQUBadzB5ncS0+K5mHXi87IXe3poSPj7CVsc3ljrY+/
         oIRlHyFn4sQLcVFtQ9UBa/7Q78It4f6HK2FvcNbmz/R902GKWw9EVEtw81Mgvz8gUNbE
         qvi4hpFNm7+pYvjPBqOykqelzxGdfwm2vUUpNaOlaI58JF/Z00fdBYW/GE2JGSQgpCCw
         fUJc9p09tcdTgxSg6XkTqqWTea4pPKU9tMB4lro7Mn/YJhENAaGr6nA81fUT4tydLwEH
         sjgRKbSL6rWtTTyAJtNvupdA76w/Pd+PYHrdpo4cJQR41aMwp0tv6QiPW2vnb6AYjP8P
         Aapw==
X-Gm-Message-State: AOJu0YwHSpHx9GqvXp2e/nzUFOeLQzh4NnryvthCjvFxZy9q4RODjCTg
	Em7J4whToFtY63QMQkTD+qFHC7u6Le2AV2Wst0ZuFHyy59t/uPSCnYO5EROLCg==
X-Gm-Gg: AfdE7ckFxXpIv3Uz5Gnrcmf42P8TDYc1UlsnlhxwSSZU0UEeiHWMNZVL5Kn8E2wPw8D
	su1WY51wbIsiUMA+AGIMQg7Ujst695bIxOSReADhGXcxu65covxvgLkvvOyb4EKk7p5paFVJC6+
	U2ZoOrULBNDCVq2rAdCaI8LqzgO/WWoS6Hy03ohizdXhid/3paIwk/YP5GcxLzICgXCRnmaM6BW
	BbHGky+w1/NZgptJkoAmeJJTpxdR96RPcbOk/h1/8kA39Drj23+89wd4XLr1as5R+goiGHK9fgm
	OiyUvVGUdrOIKHbWRHWeXE1mNmNGd3hOrB8r/h4PewfLEsKInSEUoYxtJ9SPu/u7XGNVFwhWSp1
	SE1I+n2Pbrh8MHbzElRTsufcXykiOpLANV0NqDUx5sR20/ZF0Gurr0Qck5H5ies+UJa8eMzAcfR
	5ma7Ve1oSs80IdwSj/BtzfQNETHF1ni414jVpOFq115i7h+BHXdRdeZUm0fqe/RlS/tnXaah5Bm
	CsrXA==
X-Received: by 2002:ad4:5764:0:b0:8ef:2d29:699 with SMTP id 6a1803df08f44-90768e06499mr25776966d6.12.1784206703803;
        Thu, 16 Jul 2026 05:58:23 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e3083sm221811846d6.6.2026.07.16.05.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 05:58:23 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] policycoreutils/run_init: handle NULL from crypt() in non-PAM build
Date: Thu, 16 Jul 2026 08:58:03 -0400
Message-ID: <20260716125803.7023-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

crypt() returns NULL on error, so check for NULL and treat as if
authentication failed in that case.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policycoreutils/run_init/run_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/policycoreutils/run_init/run_init.c b/policycoreutils/run_init/run_init.c
index bb9593ad..89921b23 100644
--- a/policycoreutils/run_init/run_init.c
+++ b/policycoreutils/run_init/run_init.c
@@ -213,6 +213,8 @@ static int authenticate_via_shadow_passwd(const struct passwd *p_passwd_line)
 	encrypted_password_s =
 		crypt(unencrypted_password_s, p_shadow_line->sp_pwdp);
 	memset(unencrypted_password_s, 0, strlen(unencrypted_password_s));
+	if (!encrypted_password_s)
+		return 0;
 
 	/* Return 1 (authenticated) iff the encrypted version of the user's *
 	 * input password matches the encrypted password stored in the      *
-- 
2.55.0

