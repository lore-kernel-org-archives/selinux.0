Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4633E1D8DFE
	for <selinux@vger.kernel.org>; Tue,  7 Jan 2025 21:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736284131; cv=none; b=nxH3dd0HHNWFEgdZxTGHKS54I7v7CPP+wDpDT7tbMEHsnNCvWRSELlk1eCyxY57Pxoqjmi2neo/SKyWhlW6fq+7BT9R+y6L0EIMbNrDo/ygL7NJW+LI0JR5eu5AXBeXrajG5oEpxfrIwxCKM9KPAFDxsHvwCFcoyhtpO7CxjBkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736284131; c=relaxed/simple;
	bh=UmYpMqsgFp7ajUlGqgT4nC+RerPJh6mWPt1LC32ppE4=;
	h=Date:Message-ID:From:To:Cc:Subject; b=n0T/5QoS63Q3N6mqUW+TlG5wgxvNtcz8a6DuVmXvTxQjy6jJTxuT5zF651xh9QFoUmAsQSTCbzUv09Yvfua1ySWtIKfRb6Csbf9nLYoxZ5FaJ0ZEplwfulTX3PEbGRTXMkf5yZG3hi0K3ImxZ3TsAjHptqA6LRuPylhDzLIcUI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TXc1o96P; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TXc1o96P"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6dcdd9a3e54so159420376d6.3
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2025 13:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736284129; x=1736888929; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGfiCoS1DlmnGkeIzaR9XAzcygC5mY6MEHB6jpv/RnQ=;
        b=TXc1o96PjprMpgpZ1tRYN3qxB69rVxutHPxZjv3xbXjOOdYIGYk6Rb08SqTRPhHVki
         ngYFSVWAR/9I7luOCBKQ17ICtpusE+lS1D69HPOZo4FqOUhNOObcG73zJ3OY6WG+Y++f
         W3dKDol9c8WUCJ7GpVaZ7d1eO48Ml+mC0kuNkx6O7bOqnLhYDujjsQcqwXaO4sTjLL2G
         szDzM5X6Zd1z3ODivAqHr0PZOSEHv9YgATprz5oNfQd+LS6VnVlorMmu28sM7oREwWN2
         JfKPnxU3OiARYwCJCFufspuFLc1JIjOM1/f25I55g+AN8iV2vePZz9Rfz5htJRvZLwMK
         UJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736284129; x=1736888929;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGfiCoS1DlmnGkeIzaR9XAzcygC5mY6MEHB6jpv/RnQ=;
        b=JseFNboUinXGnsXrBoJxUZUIdAfknVoLQLP1jn4PT9dEtSRhgLJ88WealIpeDm0uHE
         LBL8t9m9ld54L8oR61rT/x9fhSKF/dc/fqnJxMn7xsfKLCixbzMyP71GTj7LBVHylQj7
         IM/t00YDExbgE/Jh8niHKhrxjzDRR8Kitt5Tt5zzKGmkyReV6plZQYLo3GxitjfNa97L
         b5cq9RPuqBr3oAx9XxSmy7aA6d7CpFOALOenuWrq0QrminhfDBfuPxqEWHrYwp1lRvgC
         4K0oGswV+Sp/O+ktEabw9YWYlEor/YRGmcGnjEo9XhyUBRuN8vRNvlAZsO+09fG09QwJ
         iMSQ==
X-Gm-Message-State: AOJu0Yyjdq/8p8XURLcNIT5FXnyTIWidmnN0VYUaLmZNJoG+pRtoXxwi
	kASfR/csUk0w/P9HH7BHs3gi01zT1iJjcI0Gq6/fV0QWN5rhXyuCX2fMWd+o8g==
X-Gm-Gg: ASbGncuBAlEpu2PgxkS3hJp6x8/F+BI+MOlLQKP3ieKmCj/rmnzADvGilrR2JbI9vvl
	pVyuGMcSFm7RH1Fhq9tHmEvnMGSPI+PXS37UVh9fi24s8XjN6by2u1sfHnyh/cGihsKUE2QkTzA
	VYdM7rIMoxHUjUCEDbzvSbX/T+s/tZrMHSV65N0VQE8nbGT+7zI8bWSN0ZtTCvRXaLCwmFYDQ7H
	/i3od2eUIxFdxGqTReJMBGlTWHwDD4smvGtY+IO3cwIaUE8vww=
X-Google-Smtp-Source: AGHT+IFGas+JxRm2YxJhoo4Z1fiUNC4KivtV2LvZ5+p0cpAU2PRONKlmEZNxym1SKrVl5TiEgPwePg==
X-Received: by 2002:a05:6214:252c:b0:6d8:adfe:4c73 with SMTP id 6a1803df08f44-6df9b2b0835mr8172006d6.27.1736284129290;
        Tue, 07 Jan 2025 13:08:49 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd7debcc33sm108115196d6.123.2025.01.07.13.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 13:08:48 -0800 (PST)
Date: Tue, 07 Jan 2025 16:08:48 -0500
Message-ID: <c3eecfb79581eed47b37aac6b1ab8432@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20250107
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Linus,

A single SELinux patch to address a problem with a single domain using
multiple xperm classes, please merge.

-Paul

--
The following changes since commit 900f83cf376bdaf798b6f5dcb2eae0c822e908b6:

  selinux: ignore unknown extended permissions (2024-12-15 21:59:03 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20250107

for you to fetch changes up to 5e7f0efd23238039bcd4fc72ff28d94f364ec26b:

  selinux: match extended permissions to their base permissions
    (2025-01-04 20:58:46 -0500)

----------------------------------------------------------------
selinux/stable-6.13 PR 20250107
----------------------------------------------------------------

Thiébaud Weksteen (1):
      selinux: match extended permissions to their base permissions

 security/selinux/avc.c              |   61 +++++++++++++++-------------
 security/selinux/hooks.c            |    6 +-
 security/selinux/include/avc.h      |    5 +-
 security/selinux/include/security.h |    3 +
 security/selinux/ss/services.c      |   28 +++++++++---
 5 files changed, 65 insertions(+), 38 deletions(-)

--
paul-moore.com
