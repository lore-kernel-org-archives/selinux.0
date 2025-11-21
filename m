Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9D9303C91
	for <selinux@vger.kernel.org>; Fri, 21 Nov 2025 20:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763758652; cv=none; b=MbT9LdC3UA/KIAigoE2pLDGXq99/qFBqvNKJSSVQQToaJIa04T6mQJXax8CCbA+aZCg8KIR3SMB3Ye748d+obqjk/Jv5jGt2q6WvYzPOEreyfdw1ff9iHGSKstuHY2eTmPfpRO4ola7aXZVvAEHDiQJJJo8iDrYC/C0lchUtGIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763758652; c=relaxed/simple;
	bh=JKijqc8wOYCjKCXxb/aASNxNvgctpBpqhlMRIAeEcmA=;
	h=Date:Message-ID:From:To:Cc:Subject; b=YMajjhqzDX3eM5+5yG3RMfv5u+celn8k7ev9Tus9O5UTd0kwV1Px5i6tGmmaW+06GtPqk1Ly+E4zdWkJ5DftqhGOtcCYp/k6I9cyCytHJZIdHKCy6zyrLINM/giXtE3JCw4Ns85MWxP9uoyO9iwUDYTpQtvHZ0al+oCwBNvIs+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=E7k5hkYM; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E7k5hkYM"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-88059c28da1so26587176d6.2
        for <selinux@vger.kernel.org>; Fri, 21 Nov 2025 12:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1763758649; x=1764363449; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HguO6GcHAOvEOIpYcUY0fN2LJojxdMWo0XdVG/dzQM=;
        b=E7k5hkYMIcgQjjEOGdv9N3sOKdZZAOryd10lyJX5lz0xxxSAhsMK/7sulmn3Z7kIx+
         GXwRqez/DJfZVKwYO0wcLf8KykL5VKyBfjtsxUH+o36TCnQDK9Ujc1vBx0OlAvOXKuyH
         DGdiEuY40gaAjGldZn/rjhcvSNb7R0pHyI4gFHtXwEA0TnO142HZxwvN4Y5pDGMjibi9
         0HrnDfnLVIyVjLooshITpdTcpx+9dyeLwW31fFqiHyiNmWXg/wrmdrwAdVaxySMrXdm1
         tjfF9ugUAOeiWDhdVnAXEpwQyPxwXMk1g3q5U2BM2BwY/c+wKWOjoFACo+18ZpJ7/Oxj
         W/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763758649; x=1764363449;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2HguO6GcHAOvEOIpYcUY0fN2LJojxdMWo0XdVG/dzQM=;
        b=qfr5pLjGhJKOgRiibAelT6lfp4LZvBIbp4BZrmjtgY/7bNKWUeZ4cYQj+sXFoOkyA9
         X6jSTaKBeKvgzkESQoSbWtrz1sxaoQDwoMDKfqnBz7jxqhpKYhjEqHzH+tWrPPGwrcyr
         EawgKrwaaXbeFQQugTQLqtwJ5d5kw0ijWPvwNgT03CXVbAfJ51vYV4GR7s3VBNZCMHzz
         RGEEnkSZ91Ic29gLibBm6EqkhAyB536OTmscDxMEC8LqWT71rp/8EfuoGRqwtMlI/j4e
         fR+eBHrnaDB1DAC6VRma9sRHxsD09sXN49JjVL1WBa72qLLzZ0nLTCA0VvKumiYS66j9
         REPg==
X-Gm-Message-State: AOJu0YznErIjl0Q4D/sBLL0o9VDLignexsmb9RQpzZ3UIq27dBDh+jxu
	vmwwJxyoGz6fIQ5q4ry5/r6UumyiHMSfXFXWyt6I1JL9LOgULYnro65riAQFAAHwLg==
X-Gm-Gg: ASbGncsI0CmQyJ2Mvg2bISoBQR3HROxB37JjFQbKeoqhHXYqpNcKSChYcbJ6YdpYFDS
	nPikOVYLpojg3tePgdfFHQIWNx4pEgvfOcIl3nUDwFgNDHsdqfF+E0+Ie0dW6sxcXZ96WBOiycU
	r5MCUWXXY70Thz7vrEICcAXS432byRKotNH53Pgu9ssoUqe5psNeJV+Q2VUeCAEofkmbDQ3D8Tb
	hovmHGQA1AFnCSbCkAtzouS6rd+Axd+EjPWbkkSVkW1FElsapY00mLZe3ath0f40Xtr1Y8ZZPGF
	5GVHxeVWUtBKTe3Ug/FAdq+9EN1uz2BRK6kvxKrne0/oOxKuVhcT6jwdHtlvrkz+1HH6RvC8GpI
	b1ipodOSCRwPyYV/PsQ0M+YFBW9JQbkwX/REGSHIqL7xkyWEj6/fmtMcsd1D07RHyaxnkuH7nVu
	pCKnPVbNJoks1Kgj0GNQSeyT4TFwoP3KakoYwnbDAs10h+fU8lSRZU5LQ8
X-Google-Smtp-Source: AGHT+IFbGD/DPFVnjSByEUCrBh+IgINtUgnb9tnflkGpR6ozD7bUcSF3T1wUKOd2pAWkBWwGqFqWIA==
X-Received: by 2002:ad4:5ca4:0:b0:880:4dd2:1d0b with SMTP id 6a1803df08f44-8847c5796c9mr57289356d6.58.1763758648692;
        Fri, 21 Nov 2025 12:57:28 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e54e7bfsm46637936d6.29.2025.11.21.12.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 12:57:27 -0800 (PST)
Date: Fri, 21 Nov 2025 15:57:27 -0500
Message-ID: <e6a2c26951147ce12c57ff1fd53651c0@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20251121
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Hi Linus,

Three SELinux patches for v6.18 to fix issues around accessing the
per-task decision cache that we introduced in v6.16 to help reduce
SELinux overhead on path walks.  The problem was that despite the
cache being located in the SELinux "task_security_struct", the
parent struct wasn't actually tied to the task, it was tied to a cred.

Historically SELinux did locate the task_security_struct in the
task_struct's security blob, but it was later relocated to the cred
struct when the cred work happened, as it made the most sense at the
time.  Unfortunately we never did the task_security_struct to
cred_security_struct rename work (avoid code churn maybe? who knows)
because it didn't really matter at the time.  However, it suddenly
became a problem when we added a per-task cache to a per-cred object
and didn't notice because of the old, no-longer-correct struct naming.
Thanks to KCSAN for flagging this, as the silly humans running
things forgot that the task_security_struct was a big lie.

This pull request contains three patches, only one of which actually
fixes the problem described above and moves the SELinux decision cache
from the per-cred struct to a newly (re)created per-task struct.  The
other two patches, which form the bulk of the diffstat, take care of
the associated renaming tasks so we can hopefully avoid making the
same stupid mistake in the future.  For the record, I did contemplate
sending just a fix for the cache, leaving the renaming patches for the
upcoming merge window, but the type/variable naming ended up being
pretty awful and would have made v6.18 an outlier stuck between the
"old" names and the "new" names in v6.19.  The renaming patches are
also fairly mechanical/trivial and shouldn't pose much risk despite
their size.

TLDR; naming things may be hard, but if you mess it up bad things
happen.

Paul

--
The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20251121

for you to fetch changes up to 3ded250b97c3ae94a642bc2e710a95700e72dfb0:

  selinux: rename the cred_security_struct variables to "crsec"
    (2025-11-20 16:47:50 -0500)

----------------------------------------------------------------
selinux/stable-6.18 PR 20251121
----------------------------------------------------------------

Paul Moore (1):
      selinux: rename the cred_security_struct variables to "crsec"

Stephen Smalley (2):
      selinux: rename task_security_struct to cred_security_struct
      selinux: move avdcache to per-task security struct

 security/selinux/hooks.c          |  251 +++++++++++++++---------------
 security/selinux/include/objsec.h |   22 +-
 2 files changed, 144 insertions(+), 129 deletions(-)

--
paul-moore.com
