Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D653622FDFF
	for <selinux@vger.kernel.org>; Fri,  9 May 2025 02:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746759057; cv=none; b=ed+hH4bSiPuCciwEmJGk8YhCtyuQrgtXikw6AaJyRIxRhgrDYytcgYMoCfYCMGRNZC+/3WRccaUT03WarZwJXOkbKdEcvM3K493kh+SynP2fkD1oB97JGEY8aOFN3cBT2FXK1x1JAQPN/NjIzugrL+K6U4Xg7AU0N2ahOCQ/nCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746759057; c=relaxed/simple;
	bh=LkLoXwkIRewUueKKzD0OHSqc8OpBK2itN5DTIO8M6fo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FGi/7mQUDIHNBEwiM3uRRJ7YejfqRIMiObyPikcTpfSgTLPAAUYBrBmCZEgS4YvuKP6G1lL0dX0wfrb9TBltTLtdPUIDYS1PgI96OXogvkYvyG2rtywuPLSudAMHEiR4bEymrnSPnfBY4mi+9dbkPhEt4R3B2J0QXBwU7/n9NDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jEuxJplo; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jEuxJplo"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54993c68ba0so2288000e87.2
        for <selinux@vger.kernel.org>; Thu, 08 May 2025 19:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1746759054; x=1747363854; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LkLoXwkIRewUueKKzD0OHSqc8OpBK2itN5DTIO8M6fo=;
        b=jEuxJplonj6BSPB3pC2aJeD5W6mYJS++aTw2vXHiQgSwHqktPQYiz2JpCo0HAhkup+
         CgW5IhoLxPWneW9rdbKyNkfrHIt2mOn5aCUhfRMLRMplIvC2I/AhBUxtfjRDemRf8PzI
         VRVqGnOZFY5IIMUiUoOXnuqUBVbraRheLS4xM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746759054; x=1747363854;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LkLoXwkIRewUueKKzD0OHSqc8OpBK2itN5DTIO8M6fo=;
        b=M4j+aMcT5JHu63fmkc9spdo6V9uSoYJ7NwamKQQRwZPIbu3PK3unNsPkArClGBzHHR
         IfZkGCeNEtB/k10nHpYQvvp1au+u4uwEiAkRqm3Myn0lVXN8vBgKcb8XJFqEASBSHQor
         Js0pCcdkkZOgC1NeOXsogV+cS543A/QohcqBNKo0RFeRtkjlpyUGyYPER6gjG2wgP6rB
         V7VOlseOCczOoS2oUE2ZvOoIjo3LD4saeVG1VVFeWbPqek74VCziIzxxingfcmK1kKnG
         WNHSMHPK+OulJIk1qC/dcLB16m4lsuWyev/u5WOmilXeqY436Iz6dHrqpDV+BBtoBVkS
         1pmA==
X-Gm-Message-State: AOJu0Yxi1YbkkstzhC0sy0rwOXZt3mwJMW95qgIaxEZDyaC9vPYyQid7
	XIcQRCrYPgD475nKb3zbnH5EqUERY2Lc18brna5BVA6K+HWYv/jQlBoi2YCb5h0ZCLNmqTdBNY3
	wz0zFKk3gXLK3cAoFcVwQacthKg0w2Yc585c=
X-Gm-Gg: ASbGncsLPWrW0Pyi2qmnsz2LBPyS+Y7g5rLByrcGgN2Y+TuyIyT4BmYBX3bwPoggRLa
	8xhjjetW1Srqxct2Z15qIiiY6OVRlsjQlSta3qR83VdAuDbCXVmuhe7CcrszQI9CWmr0HNU59JY
	D288hGXz/mEppxF3fnvTuVa93W2uuknGyKftkj6zELpcAr9O5qonev
X-Google-Smtp-Source: AGHT+IHDG88eN6zI7x7iNivlK1raucEP7JI0EBcxXzIM4efSnrK/unJ5dmTAOEpaWnQpSlTR5NV9CLhSZbrdakTeBsY=
X-Received: by 2002:a05:6512:4408:b0:54d:6a89:8448 with SMTP id
 2adb3069b0e04-54fc67aff3bmr490125e87.10.1746759053718; Thu, 08 May 2025
 19:50:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Takaya Saeki <takayas@chromium.org>
Date: Fri, 9 May 2025 11:50:42 +0900
X-Gm-Features: ATxdqUG5xok-iqV_86qt3NSmavrOSuI7N_bB36oL7esY-CvsEa5Zq6f30T0uEAA
Message-ID: <CAH9xa6eFqcLh=NSz+vFPr05yZjmn2ScDvVeFzib3DhY67SrP0A@mail.gmail.com>
Subject: [RFC] selinux: Keep genfscon prefix match semantics in userspace for wildcard
To: Stephen Smalley <stephen.smalley.work@gmail.com>, Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Inseob Kim <inseob@google.com>, Daniel Burgener <dburgener@linux.microsoft.com>, 
	Junichi Uekawa <uekawa@chromium.org>, Tatsuyuki Ishi <ishitatsuyuki@google.com>
Content-Type: text/plain; charset="UTF-8"

Hello Stephen, Paul, and all libselinux maintainers.

I'd like to ask your opinions about an idea to keep the semantics of genfs in
the userspace, before sending a patch to expose the new genfs_seclabel_wildcard
kernel capability to libselinux users in polcaps.h as
POLICYDB_CAP_GENFS_SECLABEL_WILDCARD.

As a background, we introduced the genfs wildcard feature to the kernel selinux
in https://lore.kernel.org/selinux/20250318083139.1515253-1-takayas@chromium.org/
(Thank you for your help and reviews!)
That enabled libselinux to use wildcards in genfs rules. There we changed the
semantics of genfs with the capability enabled in the kernel space from prefix
match to exact match with wildcards for kernel implementation simplicity.

I'm wondering whether we can keep the user-facing semantics of (genfscon ...)
statements in CIL files in the following way.

When secilc compiles a (genfscon ...) statement to the kernel binary format, it
adds a following `*` to the compiled kernel genfscon statement if the input has
(policycap genfs_seclabel_wildcard). If the input doesn't have one, secilc does
not add any following `*`. That keeps the behavior of (genfscon ...) in CIL
from the user perspective with and without the new wildcard capability. This is
similar to what our first kernel patch did, but done in the userspace by secilc
this time. So, the (genfscon ...) keeps the backward compatibility of prefix
match for libselinux users, while keeping the kernel implementation simple.
That would allow users to keep existing rules without modification.

I'd like to hear your opinions.
