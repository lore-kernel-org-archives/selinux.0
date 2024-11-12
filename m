Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAD221C177
	for <selinux@vger.kernel.org>; Tue, 12 Nov 2024 23:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731452534; cv=none; b=s24GPl7rADcJsuOv/Snz1oiGsOPp/vEH7Kt7JJev60/bA9C9eY6JmgQJKo9hfdNnn+6jrj9PF4q83CyM9UmaDuWVtMFXGGgKEUHw/j7AsaBpR+7rC2wOX5gLExYy3/ATFqyas6I/FSdmivr+P+T0FjMQEY+Mixf6v8hUoG4It/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731452534; c=relaxed/simple;
	bh=FK01Cqcp97I7XL+wXX+mJ3b5BMi9xsq3QWrUoxHj1mA=;
	h=Date:Message-ID:From:To:Cc:Subject; b=Bviv6A20zeg4fcuY6b+B5lasl2RDSX7rsXokHZOGQ+q5pr1GmAq8zKFMWN7T08QpwU5pzkJz09g8eOhvpU+AAGslF4B0c25dWkbmh228oRidb8NLcOTKZD7jVVtrllWH9BCYU2TTDT3a6lZQZ3gJmo2EPMAKk44YPWILm3sta2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PAr+5kLT; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PAr+5kLT"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e30d212b6b1so5854716276.0
        for <selinux@vger.kernel.org>; Tue, 12 Nov 2024 15:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1731452531; x=1732057331; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHvetM05P3zGjWpuRnYjsqYcRWEVa2mfqaBVGc8Mcps=;
        b=PAr+5kLTSajzVlcyiLUezsCvegkrW3S0lvt3DfTypaYblnmS5Ydx5J4eXutZip2YxL
         szTZVv6cSfcExDqWuftP6Fy8dXUrnRDzqqVsHszbiHOE2gSjRWe4/CWMkDE2t0CYbYJc
         HhhMT/ENL/fXn8t8muJY6HWz/EvahelloXOTs48mEbs7vj8Tq5YDApJ09p9slWPCaQbG
         gulC9ahfj+QuUarZxq6+3eONsN4bS80PYVer5qqG65pn0LpsRXg49psnrB+ROPZ2yjga
         2qEZy7tGK8ZYUixLnpI7H2t6DDMYZzJzi6iuQQHr2RKpJTEsbHlqyAHE6HaWEMCrVTvl
         A6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731452531; x=1732057331;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHvetM05P3zGjWpuRnYjsqYcRWEVa2mfqaBVGc8Mcps=;
        b=sFelj15Z2ibrG9apGHp+tSWH/67RjRmFcrBj/9Y7IcmQ0HgGitsSb6S+PYFSWUjJSi
         zKeJmWfyjF6PLnWTTp6VZsq0xE9p3rEhEhpSIHdQWnIkkQwkGYF0f22sT2/VyQsf75Mo
         RcoIS8ReUW7QI59XycpL6fe4QXsd39rNLi6HHO3obEVtcbGIH0BqEAFAEgL9hEw1jjIo
         mEpC4Tv/BI5nW5UhWgAXJgd8ZCAj1h1VDf+klJuLvx4jmcsihgTxJ9BhsEmj+PyJUXAU
         pxPg005em4tNGQj86cr3nBeL8c70rr1wpc0cMH7f5TbptBCc6VjYN+RJ8ptLvpoyJVVd
         s8dg==
X-Gm-Message-State: AOJu0YzuLmT0ZgvGQX4R5D6rTjKXTHK4fCDeKIs9czI0fEqie8RBh+Ha
	AhI9Qn+ussr+avc/JC4dCaFZw96J7co9aNnWqTS8Lysgod+Zvw82dgG6+LIAX98i+2OcEvXBWgU
	=
X-Google-Smtp-Source: AGHT+IEeplSh+zRVdxlGEMyRKLmcBzSWozQ9XuX62SjwqcAgtKT2e4I/k8eAuNvod0Mqrsw0HL2YtA==
X-Received: by 2002:a05:690c:48c8:b0:6e3:2192:e0e6 with SMTP id 00721157ae682-6eaddda2d9fmr189360147b3.14.1731452531393;
        Tue, 12 Nov 2024 15:02:11 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac2dd1fsm635997185a.15.2024.11.12.15.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 15:02:10 -0800 (PST)
Date: Tue, 12 Nov 2024 18:02:10 -0500
Message-ID: <accfdfaee6d92e9049ecc0f8b7e16889@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20241112
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Linus,

I'm expecting to have spotty network access later this week and early
into next so I'm sending my v6.13 merge window pull requests a bit
earlier than normal.  The SELinux highlights are below:

- Add support for netlink xperms

Some time ago we added the concept of "xperms" to the SELinux policy
so that we could write policy for individual ioctls, this pull request
builds upon this by using extending xperms to netlink so that we can
write SELinux policy for individual netlnk message types and not rely
on the fairly coarse read/write mapping tables we currently have.
There are limitations involving generic netlink due to the multiplexing
that is done, but it's no worse that what we currently have.  As usual,
more information can be found in the commit message.

- Deprecate /sys/fs/selinux/user

We removed the only known userspace use of this back in 2020 and now
that several years have elapsed we're starting down the path of
deprecating it in the kernel.

- Cleanup the build under scripts/selinux

A couple of patches to move the genheaders tool under security/selinux
and correct our usage of kernel headers in the tools located under
scripts/selinux.  While these changes originated out of an effort to
build Linux on different systems, they are arguably the right thing to
do regardless.

- Minor code cleanups and style fixes

Not much to say here, two minor cleanup patches that came out of the
netlink xperms work.

-Paul

--
The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20241112

for you to fetch changes up to d7b6918e22c74f2b354d8dc0ef31ab17ae334b93:

  selinux: Deprecate /sys/fs/selinux/user (2024-10-07 16:39:49 -0400)

----------------------------------------------------------------
selinux/stable-6.13 PR 20241112
----------------------------------------------------------------

Masahiro Yamada (2):
      selinux: do not include <linux/*.h> headers from host programs
      selinux: move genheaders to security/selinux/

Paul Moore (2):
      selinux: streamline selinux_nlmsg_lookup()
      selinux: apply clang format to security/selinux/nlmsgtab.c

Stephen Smalley (1):
      selinux: Deprecate /sys/fs/selinux/user

Thiébaud Weksteen (1):
      selinux: Add netlink xperm support

 Documentation/ABI/obsolete/sysfs-selinux-user    |   12 
 scripts/remove-stale-files                       |    3 
 scripts/selinux/Makefile                         |    2 
 scripts/selinux/genheaders/.gitignore            |    2 
 scripts/selinux/genheaders/Makefile              |    5 
 scripts/selinux/mdp/Makefile                     |    2 
 scripts/selinux/mdp/mdp.c                        |    4 
 security/selinux/.gitignore                      |    1 
 security/selinux/Makefile                        |    7 
 security/selinux/genheaders.c                    |    3 
 security/selinux/hooks.c                         |   51 ++
 security/selinux/include/classmap.h              |   19 
 security/selinux/include/initial_sid_to_string.h |    4 
 security/selinux/include/policycap.h             |    1 
 security/selinux/include/policycap_names.h       |    1 
 security/selinux/include/security.h              |    6 
 security/selinux/nlmsgtab.c                      |  299 +++++++--------
 security/selinux/selinuxfs.c                     |    4 
 security/selinux/ss/avtab.h                      |    5 
 security/selinux/ss/services.c                   |   78 ++-
 20 files changed, 295 insertions(+), 214 deletions(-)

--
paul-moore.com
