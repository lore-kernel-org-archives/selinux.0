Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005391DF751
	for <selinux@vger.kernel.org>; Fri, 13 Mar 2026 06:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382366; cv=none; b=U1RMhmC2XiwGS5zl14bntv9WAbgu8yOKmem//wmStfOaXs9bhYOzyXjOZSaYGWm4EZeRraliWytyIFN4pC87bydygL25gQ/pzeNdUV2Sr1meQ3fEZyobOWlF7FCRdwP7Rd0Lkb32kFNYnUCHLM+vyBDZzP5LStX7KpZlEvlIwNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382366; c=relaxed/simple;
	bh=zjUMUP/jhUWQj9vc8NbA7FsK4ClBZpOo7vY18B3X5Xg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LU7hBx4eBPmW+HOYttoUhh26e9QKACY2YHaYskTGX4wu6WuV0UmdBxxMKwFJdfO03N1yP04o96XiB55dqBTHUZ28MLzcug51UjYXgY/7lD7dH7HrCxTQ8rQFW9wF+Ek9U8SHikpRIAn+5Ln9fCPkP2gPlGjDPXelxWTo4rtCGbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dK0Z/Tli; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dK0Z/Tli"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4836d9d54f6so1411085e9.1
        for <selinux@vger.kernel.org>; Thu, 12 Mar 2026 23:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773382363; x=1773987163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oNYlvR+pw1Duu92PnhcUXSmqbSFDIxpNpqG8k4yEtb8=;
        b=dK0Z/Tli1PXAS6Lmnjvip7gL3zJXgv2cvm+/HR7gNxticqBEu+FB5NNVH96pdixRKa
         QRfcY6cQIfn547CbUvkwjLqymCtqqSacnCxfN9tH2Vcb93yPLXCYssxcIeM5la9XEW7w
         QXxQ4N3Atm5MFdTwfWQ7Z0eg5G6r7OZ6MZs1K8zmENHpYnerwxvBdL5RdEGNdrAITcrN
         FmbwsYu9xqSMDNUrbKxP91p49oDotAGIl5ZXTVNzCRkPdkT3EJwKsgGLNOBiEZKOYPqm
         aV9CrNBgAxWYr5NQXYn0LAEY4vH7lHSjqhZUYfhs66O6tauuNclS8AwnHr2XkCH/MlWB
         kbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382363; x=1773987163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNYlvR+pw1Duu92PnhcUXSmqbSFDIxpNpqG8k4yEtb8=;
        b=i/usolDmy4i8cbDyd66+TgqLDfHgPaxsE7A0Mb51/hyXpgQfOLGEPoBM39XiVnzdIS
         dxzYjuBxwfA0iInZA94Uctzbh3hAE6tqcByQw/aDwojxqUu+epPork1bm4wH+uj46uzy
         whAHx+w1UpojHw3kKLaeCh/gyyuABGrOFnqbPDUiCrdiUrHnIubueVyNFkq8wmRXxuQO
         pnn8CYEVYYQCvYcpVg3+yILQycui3moHUyz0/7mtFHYgJHMNuZo3WdT7+YACYDsfLRkW
         HnDQ6pZpLRv+OhBTeROqz4BcdyS/GE6KebWnNZRKshEeqJeRuPohsRAYPY0srpQ/xXzp
         iElA==
X-Forwarded-Encrypted: i=1; AJvYcCVvrZ2z3vQ510y6l77IlwAxKUNYpv7PrB6Lp7tunLZOke5eBE7QnXPWCEUnBDmgHSmEq+/zOXsL@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk0N8MpEpFJb06bDR8Ukoo8LnW/8sfY8mRbh+vepzUPUKDte0u
	RuBOieUVJfyLickc5ISBCw/eC9QyCCtQDh1ev8ACRI5y9UAKdNvOUZgK
X-Gm-Gg: ATEYQzwpQS/YcbCS4dYAnnpijyfDxAY8WE9I4q5Anl29DsYRSI7zI7YbqZjLIun0cO2
	m1po+HbgKSVdyIZf7idjcAOm3Abv0pVACNGHd1fdUYSnr85hP8FYrP4eP70qh6nOYRXBrLUnJE/
	QdI2Gn56qBMnEym1gjX6XVQbZ0DIrg2DlcO/2WDJHL/vpWcyUhPXfBrAsqAKn7VY4Jjq1rQhEMN
	ztcVZJTEhI0Nn8Vq+J5SiwG9pRi6tYglnj+0URyOhTlHrpsuQnxannb7Cd3+W2SMpPlHy+SJM3u
	DtqkoRIOsGetfOCGbnH6TiLR9/FypB0eglGZNPXAX4KK29hlpPlJyQ3tl1xtp6ZC45TPyn96nwm
	vQmTtDsSD7lMxd0kBg/EtuXtj7N7bGsFLoQphS4w29hl3KTCi7AvW01qU967xZ2mMrV07Bc+yuy
	1W8e/8c+gGgzMPHWbaEsgC+jTkCcZ2is9ZW6AVa90zg1l6tfdQJqNoJA==
X-Received: by 2002:a05:600c:4fcd:b0:485:3bc7:a224 with SMTP id 5b1f17b1804b1-48556715146mr14780545e9.6.1773382363256;
        Thu, 12 Mar 2026 23:12:43 -0700 (PDT)
Received: from DESKTOP-LCRLR8G.localdomain ([196.151.68.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1affe9sm14371110f8f.15.2026.03.12.23.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 23:12:42 -0700 (PDT)
From: Marwan Seliem <marwanmhks@gmail.com>
To: paul@paul-moore.com,
	stephen.smalley.work@gmail.com
Cc: omosnace@redhat.com,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC] selinux: add selinux=2 boot parameter for permissive mode through kernel cmdline
Date: Fri, 13 Mar 2026 08:12:35 +0200
Message-Id: <20260313061235.9552-1-marwanmhks@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paul, Stephen, Ondrej,=0D
=0D
I wanted to reach out to ask whether a change like the following would be c=
onsidered useful or acceptable upstream, before investing more time polishi=
ng it.=0D
=0D
Background=0D
----------=0D
On a platform with the following Kconfig:=0D
=0D
  CONFIG_SECURITY_SELINUX_DEVELOP is not set=0D
  CONFIG_SECURITY_SELINUX_BOOTPARAM=3Dy=0D
=0D
The only runtime options for the selinux=3D boot parameter are:=0D
=0D
  selinux=3D0  ->  SELinux disabled entirely=0D
  selinux=3D1  ->  SELinux enforcing, non-switchable=0D
=0D
There is no way to boot into permissive mode without either enabling=0D
CONFIG_SECURITY_SELINUX_DEVELOP (which also enables setenforce and is=0D
not desirable in production) or disabling SELinux entirely.=0D
=0D
Proposal=0D
--------=0D
Introduce selinux=3D2 as a new boot parameter value that boots SELinux=0D
in a permanently permissive mode:=0D
=0D
  - SELinux is fully initialized and policy is loaded normally=0D
  - All AVC denials are logged but never enforced=0D
  - The permissive state is non-switchable at runtime=0D
=0D
Implementation=0D
--------------=0D
The change is minimal, touching only two files:=0D
=0D
  security/selinux/hooks.c:=0D
    - Introduce selinux_permissive_boot __ro_after_init=0D
    - Parse selinux=3D2 in selinux_enabled_setup(), set the flag=0D
=0D
  security/selinux/include/security.h:=0D
    - In the non-DEVELOP enforcing_enabled() path, return=0D
      !(selinux_permissive_boot && state->initialized)=0D
      instead of hardcoded true=0D
=0D
The initialized gate is intentional since, enforcing_enabled()=0D
returns false before policy is loaded, which causes systemd to observe=0D
a permissive+no-policy state and stall boot.=0D
=0D
Use case=0D
---------=0D
The primary use case is embedded platforms shipping with=0D
enforcing locked at build time, where the ABL needs a mechanism to=0D
boot into permissive for debugging SELinux policy issues in the field,=0D
and without enabling DEVELOP in production builds.=0D
=0D
Note that the ABL will be protected by secure boot in production.=0D
=0D
Would a change like this be of interest upstream, or is there an=0D
existing mechanism I have missed that already covers this use case?=0D
=0D
Happy to send a proper patch if there is interest.=0D
=0D
Thanks,=0D
Marwan Seliem=
