Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C129C30595B
	for <selinux@vger.kernel.org>; Thu,  7 May 2026 22:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192222; cv=none; b=d+zl4qOGmYFb8hSG5upfNTJ27c6R0g1rgffj1kDENaCQwZs9eYiyG0N6DF3HyFvfbw/V9nBLqRfdWNUzEGBb/HI2Ie/tgnyzRfIyScwda18BGEnT8iLAcxR5Qf455G535ES4o0CcpWTE+BIJya0rX4q1emA17uf89aycOqORDkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192222; c=relaxed/simple;
	bh=s3GYLtaL3wW2ahUfHQCq1R811uHQ9zma4Rmk5a3gMGs=;
	h=Date:Message-ID:From:To:Cc:Subject; b=JdNFyVZoeiD762/D1Of3QCEjaVEJDqenrpS1OOI6VE7vodluU63UaF7HsInXfDQEP2SgY3mc4EufpXJ4jKbTCDKSYQF00Qgwe7LsLriJ55NbtuxwRJxBBcd/sHJcVhmmBo9YIciYJJdcW3f24vlPtG4Pgy5Jtw1ngErZH7snTqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=J3ONGC1V; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="J3ONGC1V"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8eb5ad01402so138678285a.2
        for <selinux@vger.kernel.org>; Thu, 07 May 2026 15:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778192220; x=1778797020; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Xnap0l24OBizsFJZW5Mlqj6akTtgTGGifGrOCJjVmg=;
        b=J3ONGC1VRvZRi6F2KhoCooSanMeLCaRo38qotslYHXJVZ+1f9LOG2dpG1wfEMnDwH6
         ogdIBzmAvC8XPVT7vqEtnDzS9pYubF12Q+P0toVUKEGYmGuGkaEiRg5Fahqqg+C4MWin
         cdFWUVkfPywgA+thP1ovt3TRd1IcL1R4en8dH746lHBsAkGn473FpYMjOr81nIQgpsOd
         R14w1CflbJ9e7k4lTbd1CsnlVDGAZ2GHpU6t08LuTAovyVjc6Db4wWPyM+fCvggvHsHc
         Nj+GXUVu2g6Usw19V7ieN9PEyFriVTuuW7l0i6uTGK5E+FizvGk88kzCo1sdneh5NG8i
         Y4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778192220; x=1778797020;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Xnap0l24OBizsFJZW5Mlqj6akTtgTGGifGrOCJjVmg=;
        b=LVap7aZ8m2LF2uVMVvZk6HT66Ur1FmhYYPrZwJYMfH2QLifuNpOt3YSXIqu7ctm5ff
         IWt259Z5bVKZdY+jzH5Dk+N2f+Ky3au1+BTdiI1eA5MaoQOC/0ugLG9u8oiaGQvEve7q
         5oCvK6t/nok4TJzEtw0vY52orQfi5YbkgU+Q7MRxPaTK0Imq5l+QGAL9eg+dT8jLsgyE
         niI3aArfuylr2GSzU8QyUZ8r3uJX5BY7UcBgxbgaReeIXvZcdVMbxNi2i1t/PoSGh9PJ
         vQE7UdyxWkgYSNdfZzjeTMAl07qNI92v3FMs8FY+zhNhibtztgZtCmvRktRjuqdCBsGt
         Vzkw==
X-Gm-Message-State: AOJu0YwOmYk/05QxSF2XFPONX9Gu7/kqrTw7raWiM4y8VjJqpJHRobEc
	ZGumBU2hlTKu8QNHykgaMAO2QfTAdBZ8LBA8NZ11atI0CWyP/KVuAzMPYFnKrpX56w==
X-Gm-Gg: AeBDiesNqxbNfCd8+1ePpeHcYray1q463nre7c3jFb0pcFk01R2zR+MKxvnaUW4JIC/
	DcerqvbmmV8qpZw7Ys46BmCBmrZqRCNA1PIOhGPRdDHfw4T9GDxJ1zAa82H9lzN/5wEeME2az9x
	oSJz9k49kjOtd8nlopI7XvG0QftdViFW2GmfOv+oSM0y4563BgCxYIpjCLZ6U3u1MuQI+R5rKOj
	/RpN0T0H85g/xjD1xyHeFATOrmLd4vfroM4s5XxoWa6s82OOOtNlJGMA/G+MAhBh6/fzn7gQewc
	n4EovxCS8wQWg9lClkqd+h7kxT6QIiNHHwuFeLYWSAKM1A8zwRF0zxVV6tQNo2HXDP8Hu725I3M
	XVOnzsfSqyt8IrhBF51abQQ4fdK8Pw/lWC2vhr9rf8rN6/74xvBHSUVHNne0w9TwlqtXkrDfH2M
	NOW/nF832KYEOX91kFf1Z5mGQAuBEIWlRHIfVPvfc68HkPE5UWIlJTxLCnuRxfOKtZnS2C
X-Received: by 2002:a05:620a:4152:b0:8f6:4b59:9662 with SMTP id af79cd13be357-904d69da35emr1433067485a.45.1778192219098;
        Thu, 07 May 2026 15:16:59 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b87c037esm10546985a.30.2026.05.07.15.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 15:16:58 -0700 (PDT)
Date: Thu, 07 May 2026 18:16:57 -0400
Message-ID: <71f5ecc18e71e40093ddaf1b0dd1df2b@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20260507
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Linus,

We've got five more SELinux patches to fix a few problems, quick summary
below:

- Allow for multiple opens of /sys/fs/selinux/policy

Prevents a single process from blocking others from reading the
SELinux policy loaded in the kernel.  This does have the side effect
of potentially allowing userspace to trigger additional kernel memory
allocations as part of the open/read operation, but this is mitigated
by requiring the SELinux security/read_policy permission.

- Reduce the critical sections where the SELinux policy mutex is held

This includes the patch to the policy loader code where we move the
permission checks and an allocation outside the mutex as well as the
the patch to checkreqprot which drops the code/lock entirely.  While
the checkreqprot code had effectively been dropped in an earlier release,
portions of the code still remained that would have triggered the mutex
to perform an IMA measurement.  This pull request finally drops all of
that while preserving the user visible behavior.

- Eliminate potential sources of log spamming

There were a few areas where processes could flood the system logs and
hide other, more critical events.  The previously disabled checkreqprot
and runtime disable knobs in selinuxfs were two such areas that have now
been greatly simplified and a pr_err() replaced with a pr_err_once().  The
third such place is the /sys/fs/selinux/user file, which hasn't been
used by a userspace release since 2020 and was scheduled for removal
after 2025; this pull request effectively disables this functionality,
but similar to checkreqprot, it is done in a way that should not break
old userspace.

Paul

--
The following changes since commit 7fd2df204f342fc17d1a0bfcd474b24232fb0f32:

  Linux 7.1-rc2 (2026-05-03 14:21:25 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20260507

for you to fetch changes up to 868f31e4061eca8c3cd607d79d954d5e54f204aa:

  selinux: shrink critical section in sel_write_load()
    (2026-05-05 16:02:28 -0400)

----------------------------------------------------------------
selinux/stable-7.1 PR 20260507
----------------------------------------------------------------

Stephen Smalley (5):
      selinux: prune /sys/fs/selinux/checkreqprot
      selinux: prune /sys/fs/selinux/disable
      selinux: prune /sys/fs/selinux/user
      selinux: allow multiple opens of /sys/fs/selinux/policy
      selinux: shrink critical section in sel_write_load()

 security/selinux/include/security.h |    2 
 security/selinux/selinuxfs.c        |  196 ++++------------------------
 security/selinux/ss/services.c      |  125 -----------------
 3 files changed, 31 insertions(+), 292 deletions(-)

--
paul-moore.com
