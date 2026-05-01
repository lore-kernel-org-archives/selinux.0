Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D5F40FDA8
	for <selinux@vger.kernel.org>; Fri,  1 May 2026 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777665938; cv=none; b=G0BRw9z2l03mDp9MtxHCqguvbRa3Qu8PAclXwNl1/kcr+wEWWuS28jnkillG2+oClTzo2H8pvllZTpNHsGB6R6EmOIwMptUCD5Kwj+P5ONOMKxgmldpDPT6Sd+WzPJLIOpcJp+xg8aND981JdOpL5v6zKec860wdQuj5QqjLZ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777665938; c=relaxed/simple;
	bh=jBanCbUbazYJ3oeSZLBuNjWBi4k4g4QaKEwj69b+TiY=;
	h=Date:Message-ID:From:To:Cc:Subject; b=soZkTNlRzmjTVp70nkOxv6M6m9YgeMZGnbtjbAp+DeDjz3/+OUfh1uYVq2YWH0KYIu1SMLmqvPOu3Vv/CWCX91HrUCdt3I3v9IT+Pc+JHlnUwOgE0NFNjh431wVT9yaEj1WsKLsyVEHrDinOzIltnWpDq8jhg0OgQxQSFp9W3bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=E9zyZ40K; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E9zyZ40K"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cbc593a67aso201718585a.2
        for <selinux@vger.kernel.org>; Fri, 01 May 2026 13:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777665936; x=1778270736; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLP4j+bRFf9v6uMjhdLFBi9sH3z2iAa4MpmbjX3d320=;
        b=E9zyZ40KP1tHF1VgdnP8zyECh0d9BrdNdrvw21HZvbOfb2rZ5LmFvavg80MPUiLjLp
         7v4yqmfnuK8YiLzkxA07AeqeVAulf/RWu/boZ1pie15Eu8s8YTf3+YHhlAraGSx9NnrB
         OAtOgR/amMdCsZwUUt/hLAYhjCZ5L4KkOSH7N9nG2G+W3+zmDkpUNUxkd6Tk3+IWRFYx
         jKUm7YotbucTr9p8PVF4JnlIAFeAXR2p/JWhFqqHIKby6R1WCWSZtDNa6urvBjKFDhtN
         TVD5is3wx0EFeJjFyd6qKosG28ja3cDWcjbPZPQrCakPBMJIZkKV8/NCuztBedl3DFxx
         sYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777665936; x=1778270736;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iLP4j+bRFf9v6uMjhdLFBi9sH3z2iAa4MpmbjX3d320=;
        b=nWJWEFkrcfM+66+ioyk2DWdQSpj87QMBZtkP8kd717A/J1mR0MUMVii91I+pKkMOX3
         IKOEjhdLk7ZNAFo0dqNoClqt6/4bQsNKQmzh9+OFbC9+eZ2k1yL7411AoOjzGWC67Kjq
         c7rpo4a1s4Ov2sFFykiWW0aQzZ7DqAcjXQKEMLF7WQ4TIEamT4TVHtp01DoiqtA4VpXs
         oOPqY8mKuMM1u8tMpP9ZW5kfLezaykjyLEic35k1aA23jVLdro9ET3sGe6KCx2dO/neb
         +NIa2n4r1jHMgqiIv5JXcJJezuYqWbJDC9b8ZelbKjAITKEsPLYmNc0Y+tJU+Zh1UlCO
         6A2Q==
X-Gm-Message-State: AOJu0Yyigu2YTwkMFB4GmS3C8EWeRXnVPEguPWQeT+MeWMpUyknIAmUd
	XIu/i12v6qG75nGzqxq+9v2rUQUomR+laNqio42DkNlktAwqJObX97/QeGGh+WeMEg==
X-Gm-Gg: AeBDieuKssDiGHM5Va46/sBTOIiaOVwuObF5vUdy09zT5nwESVoVxJ8yG/Xi/W6y8pd
	2CRWGCIsktl7Zp1S6NnOm/ONy3aEME3lQaIrR6M/M877kTTsrO3+qYENhPyFRbe8Fgm8uXPk6cP
	SB+1sAeLoHav0vcTJISUEkTZafmIqq/j9UvPQV4GYqkaDs1oYxPMMY9cXgTLXsXGFrAPIW+taav
	KIU/EjGLKFAaxETzM0AtGjfh7n6KbT65RWN9TXCRTdMCOoV9Cr9nbQy1TCU99XZ2eKQpxwuWdEq
	xiQKinxzmDC6Zr3pBJ1XKaaQA5arSv8OMJHB4V1nFalUx0c/fa/kLJB2h8ACwvIz0Ilt8Qof560
	R9fTWvwXOioVlwDFNDkyy7pDehjcQXmDqnTFHnfT8SvtJcQ6wBHu/q3BAwXDsiwGruUYGmrb0Ag
	eEyVmOKnxD5TjPKNkWGuI3dn6AGS+41K328SCyM5sw3eA6ZfA+TsuoRbFT0rXFAKYAmKGmvIoNh
	snLKAo=
X-Received: by 2002:a05:620a:1a11:b0:8ec:c4a7:f8dc with SMTP id af79cd13be357-8fd164c5d3fmr146374385a.27.1777665936094;
        Fri, 01 May 2026 13:05:36 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c253c17sm289316585a.30.2026.05.01.13.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 13:05:35 -0700 (PDT)
Date: Fri, 01 May 2026 16:05:34 -0400
Message-ID: <c40ca3bb83a27f66229acd4fe3888e78@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20260501
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Linus,

Three SELinux patches to address issues found in Linux v7.1-rcX (and
earlier):

- Ensure SELinux is always properly accessing it's own sock LSM state

- Only reserve an xattr slot for SELinux if it will be used

- Fix a SELinux auditing regression in the directory avdcache

Just as a FYI, I expect there will be some additional v7.1-rcX patches
next week, but they aren't ready quite yet.

Paul

--
The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20260501

for you to fetch changes up to f92d542577db878acfd21cc18dab23d03023b217:

  selinux: fix avdcache auditing (2026-04-28 18:13:58 -0400)

----------------------------------------------------------------
selinux/stable-7.1 PR 20260501
----------------------------------------------------------------

David Windsor (1):
      selinux: don't reserve xattr slot when we won't fill it

Stephen Smalley (1):
      selinux: fix avdcache auditing

Zongyao Chen (1):
      selinux: use sk blob accessor in socket permission helpers

 security/selinux/hooks.c          |   38 +++++++++++++-----------------
 security/selinux/include/objsec.h |    4 ---
 2 files changed, 18 insertions(+), 24 deletions(-)

--
paul-moore.com
