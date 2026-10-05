Received: from mail-qk2-f36.google.com (mail-qk2-f36.google.com [74.125.230.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F414046D09A
	for <selinux@vger.kernel.org>; Mon,  5 Oct 2026 10:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195853; cv=none; b=AUDsjDEmAApTWLCDnxmAjtANR4AmQeB9+lMb6k78oHrYmyRG3m+IARDh6SE35MNGAHB5bRCiAwCBBEDaTFLH9eOu9MWeHYUgne2jlbeRpbF0LnqTji75+FeC/wAK+5UvSf1B7/71RUjrcCozgszUtJjXulZTFw/HNtepBacJe2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195853; c=relaxed/simple;
	bh=0DrTSL6jA3LDjm25WGqvSFl9avhGmUFNtOgrYeyvjB4=;
	h=Date:Message-ID:From:To:Cc:Subject; b=gxloqtZafSDJWoxPIy617EsCrGLqq/FjqseU3KpPa4J9+GI5d20cD1Ff1Cpu9joWIdCiAvIJ9EFT94IfQ5fraaPXg50B+3kvSkEz2t+bxSVyxeUofxf4ttIcANgLQI3rYUm0TfwSlxJvX8jUB8UeY5yns1hV/cwQ9OB4iHSB/wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FshnhGi0; arc=none smtp.client-ip=74.125.230.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FshnhGi0"
Received: by mail-qk2-f36.google.com with SMTP id af79cd13be357-93e5da808adso180352785a.0
        for <selinux@vger.kernel.org>; Mon, 05 Oct 2026 03:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1791195851; x=1791800651; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U8BpmcZNfSSdrnLD+HsvRfeM9LDp7n/LzTsg72UO35s=;
        b=FshnhGi0H4TUR1dBLS4m1a8PJEzRDa4f81vNqUFyNshMfe+Vq3cMWVXdu0+59Trezr
         jGTmaSyycB7BZV8pkr9OQDREeUvEKroNDh3vQacnI4W6r4HjmZ5HaUt41K70Bp8jRU3l
         KbrTq6Akvb2HomDu1femABsBA3m9MS6HEgBk3kqT0FrtoE9YTJDUyFB8rZISNEn5FEMO
         DQLbiXqYmhH2eextpLJPW6I+3IEEov5GDUx7+Xd2P+q07x8XjReLJC2CCJYRakymT7YS
         2ajqvpvRY1sbUjt2YgrP+C6Uops6gmy/DKSoyFbpwSDQVo7ZS5XJXlPwSdRtOUfiZfKo
         jyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791195851; x=1791800651;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U8BpmcZNfSSdrnLD+HsvRfeM9LDp7n/LzTsg72UO35s=;
        b=GOyoL8IUHkyA3CZf3RMIA8BskzaIXz4jZltmKinSXlkih2O/ZMCu/OP8YImEQ/ZQ82
         oq8eRMVkkoWhOT2rv1UH6sbqRysOUY2aF57q1CnoHXCSfZxoHi6WL2J3GFSLzNXq+uls
         W8Ax9GU9HXDVBW6orZq2MA+rzRgiKbP3VkqvIUZAoQnKMgeP+6hciHtJvpQe+ta84BkJ
         R0vlA7qPbW/H5fjv0PZnw2KQ9/I/mKNjsrLlb0phI1gV98ewuIlacBiDbDT8XbKN115u
         Dg1BijB+OGonVxM3oQKdyqZVhZZKHVXLwEh2Jn7PKL+0GcJDjowkb+RpNGnmIv693e/q
         oYPw==
X-Gm-Message-State: AFuF++nD5zyrvP16i+QTkRT5MPTpXT/6lvn7XUJ6SYpm31SAhQT+KtRy
	qDKMWI1hRacKINwg5mn0z0+jhtCol3Z7FtfdO7Gw4SBboBMP5AEIjhKVoHHwZXeujA==
X-Gm-Gg: AYBFou35/RCMG+IuW/6/66JY27akP1XtrzNJ4mp3uUAP8iX7K/zItj8vf/A6TtvmyGE
	GGGTE3r/HqyoghvTHAz8hA7l7tCWDukLjAp4le7KRocRVSwNKGToq+vSQCFd+kaJgWNHNOMIfOO
	trmzGMSbjf9x2Pc9Le+v0AokECqdzzFTl1d3rkAdqNu7I5hzvmtQcyBg/SiT69bzQr69Ps3GoUG
	VagoiO2RI+1KoVCuukVQwz9LKad/dPV+VdLowiX27xdEWjewSooqiuAKeSB4S7OStNpEwFv17Zk
	on5XFlWH30un/VWCshAT6bMRTAaWZJriLP/6NEalvkSZHwwfe58VHFauJLS14T6QE0JKGdc0VYo
	C/RO2+fuSge2EZmODuBABWg4f8RfBk9zLILUprESxC2OSBKUbEwpNUI6vM1iwf/KEWo23jFZGQ7
	TyF3fZp7GILiq9nUcnVu1QrYdFP4qdrNlZIzKWcK3/L/5WImuzx7aMBbixPx3SPPvr6thyrSmvK
	XU7+VlcP1QPcG+uuwkbc2qirddZl8PTSN9KVlM8S5UenYKAYUv1Kp2P9p8GFRNux8aPpWBwktVv
	ahb7hEUhPQ==
X-Received: by 2002:a05:620a:470d:b0:93e:5eaf:dd87 with SMTP id af79cd13be357-93e5eafe197mr913474485a.62.1791195850675;
        Mon, 05 Oct 2026 03:24:10 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0b19424sm84480306d6.15.2026.10.05.03.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 03:24:09 -0700 (PDT)
Date: Mon, 05 Oct 2026 06:24:05 -0400
Message-ID: <32b99c092d7a668f114cecb3ecb22c28@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20261005
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Linus,

Two SELinux patches for the next Linux v7.3-rcX release:

- Preserve SECURITY_LSM_NATIVE_LABELS when reusing superblocks

Similar to a previous fix (see the commit description of Stephen's fix)
we need to check to see if we have already mounted/setup the superblock
passed into the security_sb_set_mnt_opts() LSM hook so we don't mistakenly
unset SECURITY_LSM_NATIVE_LABELS.

- Fix a potential AVC sequence number data race

Thanks,
Paul

--
The following changes since commit 93f51579e7df248780214094418f205253383cc5:

  Linux 7.3-rc4 (2026-09-20 13:48:15 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20261005

for you to fetch changes up to 28b7260548af3d35773477993ad4e4de41578dd7:

  selinux: preserve NATIVE_LABELS on already-initialized sb in set_mnt_opts
    (2026-09-30 15:10:41 -0400)

----------------------------------------------------------------
selinux/stable-7.3 PR 20261005
----------------------------------------------------------------

Christian Göttsche (1):
      selinux: fix data race on AVC latest_notif

Stephen Smalley (1):
      selinux: preserve NATIVE_LABELS on already-initialized sb in
         set_mnt_opts

 security/selinux/avc.c   |    5 +++--
 security/selinux/hooks.c |    9 ++++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

--
paul-moore.com
