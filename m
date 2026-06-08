Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A9435B62C
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780946244; cv=pass; b=msGjfdRaGVUCk1hKP79PVbl4QG0zUy1rxWEr6F4ppwePQbRlaPQg7JLbkZpj+Qf2xgnXNFkcH1G/ovXa/QoKaC++N5VKekTvfe2sKVGT6kqLLg78rVo8XQkpJq/q8JJm0HSlBjIg33+NpO0jnfaZgghwlx40zNxfDreVQNDdoXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780946244; c=relaxed/simple;
	bh=ZafIBNBWSXnjR6rN6dMu5Lfi4zhx4SW/uKdxVwGKVVI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=hUY8+AyX3Z4F6Mr3LtRROdWbgQdKnSATKzFL+8ljKrq+A9qBn2obCuQaLonpGc8u+AQEAVi0QY8DGUpkIKBhnqdVfVS4kY9rq7joKvQgILTYsbMO0KGaDxUEzj+qNHKHcsW1tB8V24h2V7pHHkWqRlRJbZg/aIjVvBv1ib6+CQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDnrE689; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDnrE689"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aa68dbd44fso4763140e87.2
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 12:17:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780946242; cv=none;
        d=google.com; s=arc-20240605;
        b=Nwuxtzc2O14Y9ICDNg9Sno3KYmHicsdtaSKPyw4uZplRmQirbz6Hm7svyM6wCMFdix
         mOL7KN3kyjy75IN9oNeMRUHk+7jXZexqGmuJpGzAO5mL7shjhg/nykEr4ZXwINHl+U4/
         yNrfSjaIYo8km3CdboANL3FPh+80c+WijE5h+2/S+qtHlx8AWH44157n2ixK9s2P37Sl
         y70sYZNPJKqznqa3eZ4JSZBJ629e4grt21svKvIYCQQ7ftUq/Mno4CSZTgZQykBNGtOx
         dE1SJjuY/XP680OllHmPJrOkRbCgKdV6ngO2DdZyLOwkvC29QlkgRpntEbV0x5eAv6Rv
         ivbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ZafIBNBWSXnjR6rN6dMu5Lfi4zhx4SW/uKdxVwGKVVI=;
        fh=l2l+BKIhep14i9a5yxIzwDvgNRHYkyJlbYDDp8LiW6o=;
        b=dEXL6hmBcAAZncmM7HxrIFx01qJSqysRyseOSPt/KvfGS1uXzwfMtbd9PsCCGBMKsT
         p9lHyPpRdf6msy+5oZFGmv5tEW9VjjYtpsF6M2XxeDhkoh73oyv8gN99xbUchq252RRe
         SzGbmKCGlk/JSDfX81udTw+ymqH2ByLrC9uVTYd18E6DCvB/Klj7uBYjJMCKLYgFKyz0
         Suq/sGoqT3U3jk68xtjAXF3fUvl0bOhO7mQCtAhSsi5bK6GINjHazQ+CmCmQ3cCRHx/8
         OX3DI2Q17LndGcy+2nEq61spW+q+kyOe7AEOZ3K4SUT5X8x+++lGroDiwiXVL/RFRi30
         F+oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780946242; x=1781551042; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZafIBNBWSXnjR6rN6dMu5Lfi4zhx4SW/uKdxVwGKVVI=;
        b=XDnrE689Km3QrL+CW71usMa+GFElL1KUkfwWukMuF8olRVCas9oT4wRwvLect3A7fg
         +sNjosMSoCAocC8SxvawrSRDvBvv0hyOeQ8u/oVTT9Jup+dADV3IYItr7hk/S7/uFTPg
         citI4fJmswQONR34hOjsEYGpxNQC0dH9xWDYCCu01PbNhhkeJ2Ya60RbqFxBvRhDbPeA
         9d1c4NoVgs46m3plBSCGuvIJWKZFxe47J9xZdh5ecqGYfQStiAX4P5QPqor0YZwZ4LAg
         xNfZlo4PSdVr50eNZZfuVbTfpjXkXa24uztui4XK2InmSxYLqt/OyiW2epI8MWUIhE6o
         cazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780946242; x=1781551042;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZafIBNBWSXnjR6rN6dMu5Lfi4zhx4SW/uKdxVwGKVVI=;
        b=DUV/JCdGjcJAGlZ3laL6Hm7Ple2d2o1X8PBvcenwSkGdObmxwGD0C2kV7w+noLNGhW
         buFmAX/O+PMfryqY8fKa/UE4yAHqjOtkrLxYh87hvc9P+85Mx1JLleWyosbGdhxy2R1F
         iPBSRKgF3rgYXr0sXSHkIFjhLQBj/9CLgy4AAPqcKehJkMw2sOEGxlbj607Qa6W8R2DW
         cHlMob6IS7nOtePS2ZKw4RYlw5Z4H5l2Qgibr6KgR6RfeMSLhJUZIksrQMshoCgZKneG
         H3/flYGbd2FT9io2FH538UWG8yMYa0/J7VXIThSuFnS1shJC2WnNzVBlc4Kf1qiodR+O
         HzzA==
X-Gm-Message-State: AOJu0YweCb/j9tI+OX7I3tc6aUruJ6d6ELPMQgHoOvTfJPug+uGogV1c
	Dt2tF4ZT3kVk1RfiAw3N+NnpdpLuMVgKU08tGWY9iTM8QzjV2cwkEiFzLc8K3u439VqHZ0mgW6n
	isC9sDlNuKvtYvdggifpk7zJdfyboz/wHnqSu
X-Gm-Gg: Acq92OHlB4dBMCvUsWSPfykWCgPVxoyIfYhRmx2jA8lVoBs+DCQ4OD6cJ3WLv2mUSNe
	fMuuZBJf7pI4uk+PiOO5J1sc0PbGuBg2S33XWPGe4yi08w+Z/JygrRSrCgH0JpMngzTjwl6yU5A
	ZwvB1G5LD9z9xG3853HXPKzUDoKY65O7o8ITaV0Jhj02+qaI1NJmlM9hdUtOKLyuD/5D/4LVMRb
	Hsip05skzZAqN9k2DBPNNvxNSPZigIQXkLcEYHKO9emyeMP8VRxXOgVWn0cr+VKzZh6L0zKMVGX
	189hRpCNBPNCikxUJv/6U74a/Q9g
X-Received: by 2002:a05:6512:1194:b0:5aa:6f93:de67 with SMTP id
 2adb3069b0e04-5aa87b40191mr4979378e87.9.1780946241433; Mon, 08 Jun 2026
 12:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: muneendra kumar <muneendra737@gmail.com>
Date: Tue, 9 Jun 2026 00:45:52 +0530
X-Gm-Features: AVVi8CcXR5qy1zM789Thot5IpYtM5KCTNqIZyH8ZTm5rZN3PiP9H8lwFoDkO-ac
Message-ID: <CAAhcyzmaCLaRmK2anDfThnhy3M_EFRgpk7Aajd+uctvYr27WZg@mail.gmail.com>
Subject: [REGRESSION] LSM/VFS: startup latency spike during rapid library
 lookups (ENOENT) on x86_64 between 6.6 and 6.18
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

We are observing a reproducible 3x performance degradation during the
initial dynamic loading phase of a userspace background daemon when
transitioning from kernel 6.6 to 6.18.

The degradation appears to scale linearly with the density of path
resolution failures (ENOENT) encountered by the dynamic linker (ld.so)
during its library search fallback loops.

Isolation Diagnostics & Matrix

To narrow down the root cause, we isolated several configurations:

- Hardware Profile: The issue is highly reproducible on x86_64.
- Kernel Parameter Isolation: Passing the boot argument lsm=none via
GRUB restores performance to the 6.6 kernel baseline.
- Active Stack Configuration: The regression occurs when all four
modules are active and enforcing:
lsm=capability,lockdown,selinux,bpfaudit. Removing modules reduces the
overhead linearly.

Suspected Root Cause

We suspect this latency amplification is an unintended side effect of
commit 417c5643cd67 ("lsm: replace indirect LSM hook calls with static
calls").

When an application triggers dense path failures, the VFS transitions
from lockless RCU path walking to a heavy Ref-walk to construct
negative dentry states. Since the daemon possesses valid DAC
permissions, every LSM module in the stack returns 0 (Allowed).
Consequently, the kernel must sequentially execute the entire
__static_call chain for every missing path component. On x86_64,
cascading through a four-module chain during high-frequency ENOENT
lookups appears to thrash out-of-line memory trampolines, compounding
latency.

Production Constraints

Our deployment environment mandates that all four security hooks
remain active and enforcing. Workarounds such as structural stack
pruning or dynamic path caching cannot be guaranteed across all client
nodes.

Inquiry

- Has anyone else observed similar hot-path performance degradation on
heavy ENOENT cascades since the static call overhaul?
- Are there existing or upcoming patches aimed at optimizing
full-stack traversal loops when navigating negative dentry structures?

Any insights or recommendations on minimizing this structural stacking
tax within the kernel layer would be greatly appreciated.

Best regards,

Muneendra Kumar M
