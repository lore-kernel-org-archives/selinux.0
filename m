Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A225414BF92
	for <selinux@vger.kernel.org>; Wed, 18 Dec 2024 04:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734497526; cv=none; b=IxbVj9K6s4NFHPJBgXgfM1N2B1RWTZGVv2lzuJwnaXdp4VqftlvvOO5uds61enDliVYzJNvOm2sSymXmpBcx/5x8Br1NvkAF0oClqq/11Pl3tLYSo77OkUxQmkN0976yZAqDX+XsSPAzpq7/FY93PH4T3y/lH3ZDGrxGC4fpxRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734497526; c=relaxed/simple;
	bh=kok0zc3eMer5C1HhBdN/GHJdm0tzzDUEl4j2ZX8sZBI=;
	h=Date:Message-ID:From:To:Cc:Subject; b=sThsyFM8TZs/7swMdz+OT4VnqyMsfJ8dLDArhiwYcRQjLg7xc71zmQn+SZY4XI3IFd+P5AuQPUcnXrKlWCnLpt6EcMW2llaQkaPm1O88fuCgH4TsYoSMaZrwDs/EXWV9CE4sB7Lt23FANJAEcg5whIwQQXy5FloNrZY1XhIXdAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PYXWkFGV; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PYXWkFGV"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-467a1ee7ff2so47651481cf.0
        for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 20:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734497523; x=1735102323; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4u188fwwLz5ur+zRkfbW24ZR21SR4bFjDTgnLQvheOM=;
        b=PYXWkFGV9CVQ41RrZ8NRrKdl+L7bMjI+o4GSC+GKyCnJYmETwUN3mTbKnudiq9O63H
         qVRDvdZD2ZDVxJ6uI72+tnepZCiylO1gDgPljqTEF4ZvESur+HP4S9IRXvPNA0/DLCbg
         cxgp+gn53A2ZtyGQGqjmlMPUtsNoPwg5nHh2JZLl/fm37hK+yV4D36SWjVWZ2TdoE6+m
         12EQuMk9ZoH6MmiPHOx717tAGBRX3uf0Zk5clG3Gki8G3uv6rkIaD0Ahr6tgMEfESFNY
         jJconiiKDbTHlePXiWi0mVgYT/kn/wBRUqdsJAtm0Ww6fyHrqC/IMTGXS/AiILcKQHfe
         eFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734497523; x=1735102323;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4u188fwwLz5ur+zRkfbW24ZR21SR4bFjDTgnLQvheOM=;
        b=VKDqk7JilpWCZG8h4QMDdUJZ63D+6w2pQE4ucTAHKUgz9Kzbn1tS9ESATMHWGHAs0G
         pw70vkXie7Zi3TpzvRDj5ltJUt+QsiemvcMh1ARqOuOmRk+yvcjuUvUC/F33ZM27cj32
         zIaIX5bYaZ5H87VQmZEnKB9KgBUTM+mA9CDSpbNLz16lh70oHljfTxqHwnRclLRMF2Ry
         LSBGPrMKpGdQdyLcdJcJURVq+kA2xM76Ta59CWT1bzHUpKdIi+CzURCgggaTtn4OQcgl
         xGe7M6C/dPB4Lkc7Qr+aHkhxLNVQh4CA8aD8ms/eccIh3MNh0O4fiALUVmfOS21L/aW9
         mz7A==
X-Gm-Message-State: AOJu0Yy+v7ud7pso5jkSH1FDnXW5IEwZfM6iXZ2xfVi91jLBhrilx+yL
	zr7e8OaRbWlcMPIEip9tYye5qNsop4pxlcYfGrfDzxydT37Vzjq6s1UkvjUkeQ==
X-Gm-Gg: ASbGncvzRLPRnze3uixfXaXlwJtSxye4VE4IzWDIdZ9v/h8TAPQDZohT2RMrSgpzf/m
	xkCG2WB2vLrkY4ouMv1YMuI4ob6P/PqAoXyi7lwJKGG2mwC4nhi9EEyh8Ql+K5/L61WvJ8Q0Mhv
	2mwJTw8tXExTqSq6OI41blac2jwOYPQIwDjGvixIhChXUB3tFKQ9GaVt11Q/JwUQK0KVgdEk0CZ
	D564jQz5iToRgbE+DPMqzYmzS4nW6VvPM0vG+amwND66/H8ZpE=
X-Google-Smtp-Source: AGHT+IGpgRNZyn48P8+vL4Zxk5E5VsvTJHu1mGknTyiPBCmAlwrep5Urrrc9tA/AEzoXYDlUfki+4w==
X-Received: by 2002:ad4:5fcf:0:b0:6d4:211c:dff0 with SMTP id 6a1803df08f44-6dd091ddcb6mr21927306d6.29.1734497523486;
        Tue, 17 Dec 2024 20:52:03 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd390fdasm46037696d6.124.2024.12.17.20.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 20:52:03 -0800 (PST)
Date: Tue, 17 Dec 2024 23:52:02 -0500
Message-ID: <ac07005d555b51b0ae021bc2b0222f39@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20241217
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Linus,

One small SELinux patch to get rid improve our handling of unknown
extended permissions by safely ignoring them.  Not only does this
make it easier to support newer SELinux policy on older kernels in
the future, it removes to BUG() calls from the SELinux code.

-Paul

--
The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20241217

for you to fetch changes up to 900f83cf376bdaf798b6f5dcb2eae0c822e908b6:

  selinux: ignore unknown extended permissions (2024-12-15 21:59:03 -0500)

----------------------------------------------------------------
selinux/stable-6.13 PR 20241217
----------------------------------------------------------------

Thiébaud Weksteen (1):
      selinux: ignore unknown extended permissions

 security/selinux/ss/services.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--
paul-moore.com
