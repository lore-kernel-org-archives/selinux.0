Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01093C10A4
	for <selinux@vger.kernel.org>; Sat, 17 Oct 2026 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206022; cv=none; b=s1gEiFd4hKHE9xbq7GicQG/ukwlBeXVskez0HqFUVq9b/PwwPY5a1AMKaFUcf0qk2GUdNMbz6x2rJovK05a5Lcj1uXWaDuKjeE6KHJ6Hi6WTZ7yeYd1JhkiCCII9sL+R+5E5THlkSFQHA1p0ypZhVk+1CYWNPjgu5kgraQa88r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206022; c=relaxed/simple;
	bh=RnyUtaj56FacvXKJT/5BOE5uL4aLHIIMeKqQgZyyy3w=;
	h=Date:Message-ID:From:To:Cc:Subject; b=PqbBtLgXGtApsg7TM/KzPMXfR7XJIfMkgyZvJDwZaTd7z7XLawP+MhKdwoFy1hBZYUW9oZMnXRODc37qGakWM2gcbFfPRIKqzIXJN++LZCV6lEizctxaWcAE4LNjatd7QkQroeaPlArlTVr+dVabig/LG/oU3lhL3vxWe0vtmNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SkyKkWWj; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SkyKkWWj"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91b8306b9f8so7315606d6.3
        for <selinux@vger.kernel.org>; Fri, 16 Oct 2026 20:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1792206006; x=1792810806; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H7TFgfiFf6FEXV3J7Inq1lkdC8JNBzhySk1rzqW+t48=;
        b=SkyKkWWj35bDcts8jT/Vm8ebaAmtwQIQ2aldBjUveWiFsnhPtE2VD0UHBM2h+63BMI
         wHOSrBjN5DZr4EyOYc8VMQCHCVh6mueA0IX4/i0giSK7bBzkRGGMQautk4BBAOOt21Ig
         vLVnT5fVS/TGo9mBBCDKKU1YvI+9gtXlIu6P0/e9MklAsUxTO2VxMtF9f9hV73u9pKwy
         GQaIZa7rkJRP6gHb7/nORUOF/hLYirjJcN81gf/LRtgiCva7zkj8K4RYXuSCv/EinZsi
         kS9sy+YCmmbIM68+/qDwnjh4g8AFfUwZnkv0fujgMWfSt856edmHxDNlOiGuDoWOoNjy
         +LuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792206006; x=1792810806;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H7TFgfiFf6FEXV3J7Inq1lkdC8JNBzhySk1rzqW+t48=;
        b=U8KSMBNTw/t4QWCb5rZtPyfkdoE/SQm6epJ8e9EfyM0TM+ubcAZU6EctXWeaaHrK2s
         GRq2mpVQT9BMTC7C7seYkGqtc6frAW1h/I00ZwZ9j+r/6lwp1d8880/a0XzCLM6/6+9+
         4VHTx5KaqQxc4liRz+mf4NDmDh5+s4hLDc9Xabhb5A8La5TENW8g1WnfveDTpfzJrk78
         T3YdLOeIekaLzzevQMyPG6SwZN6EppW5PY3vuKi3TzpvSBbci8s2FETZzzy3KsvaGWR7
         mOX53gkGDTuIjP744+yuzTQutxF5MWvoKM5/Ff3hvBNvdXjXQSApn7/gvkxS4CKaZOpC
         0C/g==
X-Gm-Message-State: AFq9FYK2W3ullc2Z9011KTxz/WJ7LRIQs4bR7O7WLPCIapT3FnDBieQQ
	1bkLK9f4+mP7SJEu9U773hHZz/cqILegW223jIOr1gRB3obAf7BlfAojJ0VllGSqDhVftAdvUDY
	nmren4w==
X-Gm-Gg: AYBFou2fecefpY1PYtJ1Fmelna27Re3cvv8/3UZC0qEMB0elZ83fWzmKqQboNGLqeWl
	EWu8dGuNtbNROzFAVdMlby8Hi5NnM6ZAE3OhiGQUFbdRpgSZQB9AT8sg8cWlKAO9Fcp8SpIMGdH
	Ux7PigHEqndS5PH1EFrDzE57id9Y31dcPlvSorE10Gx/zqgoHO2pnVmOjQkaTwrVk3hhtXCx8gQ
	sdbK7nLCQDHw6uA45+QycINmeWsTGI5f93SLlLuK+Ha49bSqfZOFSGg7WiWGBJvc5tskfCjMFJa
	XLzG1+mRx1zjNlbSJnYOQIxFqAw2h5q+MGXZ9ycfJPGWwGGTtNvUGuumCjvpovSTFeEGjbLAxHO
	qDOW4lW8fsWibJjP+uSJRHm/wX8NJZTeP+pzZZevuzV99bYvqdd8FlCWSDBzp8EUWULAavzz0C7
	SeVblprhQzPyCNY4LqE44Slh+W6w7Dyti1x6TxlQ+IcbQa+fLhy0hmKFUShdt0K68RHQIG//lSM
	ljhmXd98TTvZaDVOPNu8OKb9KC1KhmMBHqR3h9zo35AwSQZVIzoQuKJ71K8wSdIE+qpXJBUOKk=
X-Received: by 2002:a05:620a:439b:b0:939:9edf:edb7 with SMTP id af79cd13be357-93f29b73708mr304873385a.6.1792206006258;
        Fri, 16 Oct 2026 20:00:06 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a1850cbsm361980985a.24.2026.10.16.20.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 20:00:05 -0700 (PDT)
Date: Fri, 16 Oct 2026 23:00:05 -0400
Message-ID: <e30c2a29706391f16d9ac9446907193c@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20261015
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Linus,

Thirteen SELinux patches for the Linux v7.4 merge window:

- Continue to improve the load time validation of SELinux policies

While SELinux policy loading remains a privileged operation, we continue
the recent trend of hardening the policy parsing and validation code in
the kernel to ensure that invalid, or poorly formatted policies are
rejected at load time.

- Correctly incorporate "neveraudit" into the xperms code

This change aligns the xperms neveraudit handling with the conventional
permission handling code, exiting early from the SELinux auditing
code when neveraudit is enabled for the domain.

- Mark the selinuxfs "status" and "policy" files immutable

These are read-only kernel/userspace interfaces that could successfully
be opened at the VFS layer through the use of CAP_DAC_OVERRIDE.  With
this pull request we are marking these two files as immutable so that
the requests to open these file with write permissions now fail at the
VFS layer.  This also allows us to drop some of our mmap() checks around
write permissions as the VFS will now also handle this for us.

The existing SELinux permissions checks remain untouched.

- Convert the selinuxfs inode numbers to u64

Bring selinuxfs current with other filesystems in using u64 for inode
numbering as opposed to the architecture dependent unsigned long.

- Constify a number of the SELinux AVC function parameters

- Remove a SELinux MLS function that was no longer used

Paul

--
The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20261015

for you to fetch changes up to b73b967b0fc44707f39faa4f298f1f9d9b7bfac5:

  selinux: validate permissive and neveraudit map types at load
    (2026-09-30 16:59:44 -0400)

----------------------------------------------------------------
selinux/stable-7.4 PR 20261015
----------------------------------------------------------------

Christian Göttsche (8):
      selinux: constify avc function parameters
      selinux: reject a policy that both rejects and allows unknown
         classes
      selinux: reject duplicate symbol values during policy load
      selinux: bounds-check filename transition source types at load
      selinux: check neveraudit in avc_xperms_audit_required()
      selinux: bounds-check role and user membership bitmaps at load
      selinux: validate user MLS range and default level at load
      selinux: validate permissive and neveraudit map types at load

Paul Moore (2):
      selinux: convert selinuxfs inode numbers from unsigned long to u64
      selinux: avoid 64-bit division of inode numbers

Stephen Smalley (3):
      selinux: tighten policydb_context_isvalid() checks
      selinux: remove unused mls_setup_user_range()
      selinux: mark status and policy inodes as immutable, drop status
         mmap write checks

 security/selinux/avc.c          |   37 ++++----
 security/selinux/include/avc.h  |    7 -
 security/selinux/selinuxfs.c    |   59 +++++++------
 security/selinux/ss/mls.c       |   38 --------
 security/selinux/ss/mls.h       |    3 
 security/selinux/ss/mls_types.h |    3 
 security/selinux/ss/policydb.c  |  137 ++++++++++++++++++++++++++++----
 7 files changed, 183 insertions(+), 101 deletions(-)

--
paul-moore.com
