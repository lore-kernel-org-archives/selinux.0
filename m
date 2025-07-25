Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C62E244691
	for <selinux@vger.kernel.org>; Fri, 25 Jul 2025 20:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753476571; cv=none; b=skLIL8pH5p27CHSYbNW2qGDH0LUT0ZZVZpWisk+ncGc2OOckZHxYumt/nW3t+Z4ai1N3Me0kRzfb2QLu13w1L8xDSALvxYrfAD54wBBtUXT0DE4yjwROCoeiHShoODLYm5tBcXcyVQhVxeem9bnufp/dlqkaICOJQVMaEyhH8TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753476571; c=relaxed/simple;
	bh=ROdFTJiGd5/GLp4z8lMfSmyZbwS5owsCw58X/jelgDU=;
	h=Date:Message-ID:From:To:Cc:Subject; b=a/M7EH+6c63SlhTYcomsydY10KOLKfjcWOJ+lqfnogIWS73Juyf45ZAsSuIH54EdjFaapVI5Zyh6zH8folRBBvydMRqOROv5rPrwB+3WPwzjvAzWXe+AUOcCMeSBCo4FmeX+gLZHKrjM/eM65T70C6G6W69i+DZuR+wpYoq+x7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KgornxXM; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KgornxXM"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6fa980d05a8so21381166d6.2
        for <selinux@vger.kernel.org>; Fri, 25 Jul 2025 13:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753476568; x=1754081368; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FkTgvWlgVmQ5f7CUc4jJgwLNzq3m1FsFuj0gNddDPA=;
        b=KgornxXMfRYsP03LtjWqTZsaan3uxIm4rDU+sq4UaCZI80JJPM0aRHRQrT5mFIieJe
         nQwpGys0WjkZFkwicEYCXFHx/cZUi/D8qeSZXZb+nSG1W87Nb4hiGpXLTq1n2o9rR3T2
         ZX5dd0Or7ue5b9O7hKcZh6MWbGtvbU0W7EmTKe9prcoOXIkJwmjlH20c01WrsLZxmP3R
         wq+ieH0HvA8U8VP+r3d6X5DLD0FPc+JlCh87Hb7uPP6pa9DV82qwPjucKfqL/qkVqVy9
         TbuNm6WiJlTyNtPGQ5bCAXAR3HvfcMAthSL+MX2Hkgb7wf/Mjbb2EoiAle7A0gMGk/aQ
         a9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753476568; x=1754081368;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FkTgvWlgVmQ5f7CUc4jJgwLNzq3m1FsFuj0gNddDPA=;
        b=HZ/h1psYRCulWhGEcCnzDzFKcWLsdu9HmQ4btLY6G3H3T9fEQlu8HWuYsqOynCvkMD
         JPq0OUFcA8KKRpiQpGAm1kYqN+t4jDhUrnHgPUZIRiFLowhYBGAs8vbrrUKVkkB9dImu
         ZsgXBDLhZkBRnT6Vo5nBVosAcMg7V4MZP8+rGtnDt5lsBCMFzhGE0DFXcOgpGjtFy77U
         YZ/ZZUufUWPaNuLxYJlh15we2r5xR9qtuWX4ycVcJtI1041eRH6TyhsALc+qhGjo609t
         e8V+bfr6jA6G9r7PvXODd2mNMBcTseEc+yJcfr+RoKTifWoZ7JyNJzqvMHlOWGCPtIml
         S/wg==
X-Gm-Message-State: AOJu0YyiJr4nNpHQgT8UVCcvjRNcqbf3/IzzMWvpRvR39pi/bZENoLOr
	AKmIa423RD4pL+NrdesYM6k09mq8ezX3ltZpzqXiJgd9z4JqQtFLBuwx/U5f9Gmky6QOYgnOqOU
	Yuzk=
X-Gm-Gg: ASbGncsSNFEd6Y25zbuJ0xfoc2DymUX34pJ+VjONCmqeV5DOu3bMoEHbPDtNM4x3aoh
	NxhGOCZALhQei/A9uAwcDGo2ELBMnSLjxkk04FMTdteQree3Bs4gLf236AZlK+1bJjvtCPBHII5
	AraGd9f2/0Bvrg8s9bC2xarlAxBVF4+hFmdVpy7VoxgnmQxL/TWJNgYtgDV7R4Rtrzqn5r3gbGf
	eOUfgxPwLH2DnEbh7f984eHCXHRhYn6X1t2st14ZhzZ/8rhNTBOe9VRgZdX8eoIPr7RYpNjbsov
	EcLMhCqnfywQe5YCgCS7CZWds28Nl6qGvxa8qEKl0EnQwvT5ARBYyOVBX0ab0LcB1gxD5pls3XC
	oTM2ZM5b2oRf1EsLW9qM0+e0Htc1o7Gfs6d/b6ACC2xe2bO1YztI89iCItk4g+WdK7Ps=
X-Google-Smtp-Source: AGHT+IGZjdXnqtxButa1Ssw869Og0wrfY516fhkT7Po12uDx1Dt5t8zMGMqQJq1ZQ3TwTXDsIoGl0A==
X-Received: by 2002:a05:6214:767:b0:706:c9df:8f84 with SMTP id 6a1803df08f44-707204f5ac1mr49798896d6.16.1753476568338;
        Fri, 25 Jul 2025 13:49:28 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70729a04ce8sm4555716d6.19.2025.07.25.13.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 13:49:27 -0700 (PDT)
Date: Fri, 25 Jul 2025 16:49:27 -0400
Message-ID: <6e344a8bd7d60522825222628e949a14@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20250725
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Linus,

Six SELinux patches for the upcoming merge window, the highlights are
below, but I also wanted to mention that this pull request isn't based
on the usual -rc1 tag, but rather on a VFS merge that happened shortly
after -rc2 so we could pick up an important xattr/LSM fix.

- Introduce the concept of a SELinux "neveraudit" type which prevents
  all auditing of the given type/domain.
  
  Taken by itself, the benefit of marking a SELinux domain with the
  "neveraudit" tag is likely not very interesting, especially given
  the significant overlap with the "dontaudit" tag.  However, given
  that the "neveraudit" tag applies to *all* auditing of the tagged
  domain, we can do some fairly interesting optimizations when a
  SELinux domain is marked as both "permissive" and "dontaudit" (think
  of the unconfined_t domain).  While this pull request includes
  optimized inode permission and getattr hooks, these optimizations
  require SELinux policy changes, therefore the improvements may not be
  visible on standard downstream Linux distos for a period of time.

- Continue the deprecation process of /sys/fs/selinux/user.

  After removing the associated userspace code in 2020, we marked the
  /sys/fs/selinux/user interface as deprecated in Linux v6.13 with
  pr_warn() and the usual documention update.  This pull request adds
  a five second sleep after the pr_warn(), following a previous
  deprecation process pattern that has worked well for us in the past
  in helping identify any existing users that we haven't yet reached.

- Add a __GFP_NOWARN flag to our initial hash table allocation.

  Fuzzers such a syzbot often attempt abnormally large SELinux policy
  loads, which the SELinux code gracefully handles by checking for
  allocation failures, but not before the allocator emits a warning
  which causes the automated fuzzing to flag this as an error and
  report it to the list.  While we want to continue to support the
  work done by the fuzzing teams, we want to focus on proper issues
  and not an error case that is already handled safely.  Add a NOWARN
  flag to quiet the allocator and prevent syzbot from tripping on this
  again.

- Remove some unnecessary selinuxfs cleanup code, courtesy of Al.

- Update the SELinux in-kernel documentation with pointers to additional
  information.

Paul

--
The following changes since commit fe78e02600f83d81e55f6fc352d82c4f264a2901:

  Merge tag 'vfs-6.16-rc3.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
    (2025-06-16 08:18:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20250725

for you to fetch changes up to ee79ba39b3d6fdcfa53de6519d7e259e284e78f7:

  selinux: don't bother with selinuxfs_info_free() on failures
    (2025-06-24 19:39:28 -0400)

----------------------------------------------------------------
selinux/stable-6.17 PR 20250725
----------------------------------------------------------------

Al Viro (1):
      selinux: don't bother with selinuxfs_info_free() on failures

Paul Moore (2):
      selinux: add a 5 second sleep to /sys/fs/selinux/user
      selinux: add __GFP_NOWARN to hashtab_init() allocations

Stephen Smalley (3):
      documentation: add links to SELinux resources
      selinux: introduce neveraudit types
      selinux: optimize selinux_inode_getattr/permission() based on
         neveraudit|permissive

 Documentation/admin-guide/LSM/SELinux.rst |   11 +++++++++++
 security/selinux/hooks.c                  |   14 +++++++++++++-
 security/selinux/include/avc.h            |    4 ++++
 security/selinux/include/objsec.h         |    8 ++++++++
 security/selinux/include/security.h       |    4 +++-
 security/selinux/selinuxfs.c              |    3 +--
 security/selinux/ss/hashtab.c             |    3 ++-
 security/selinux/ss/policydb.c            |   19 +++++++++++++++++++
 security/selinux/ss/policydb.h            |    2 ++
 security/selinux/ss/services.c            |   20 ++++++++++++++++++++
 10 files changed, 83 insertions(+), 5 deletions(-)

--
paul-moore.com
