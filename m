Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA1E28F1
	for <selinux@vger.kernel.org>; Fri, 13 Sep 2024 01:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726190319; cv=none; b=J9aSD9sLOfpwN2GQlCO4nZRiLm229TxL0JA/YUAa3Uh62yIxrnxfzaqh2S0azfE+vCI9PPDxbLqpgvFXAaiBTLT4Mgd97OId+t9y0Gv3++Krlg53nuRxWRN23JMIrUt3/3e6ACREh/vl+YzUg9jsHjk3fsecnwh/crsqxJ+6j/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726190319; c=relaxed/simple;
	bh=NA6fdfMXOcNcjOXQj/GmFhALd+tPv0w1x2df+NW4U5w=;
	h=Date:Message-ID:From:To:Cc:Subject; b=J/rlh5oeZ26n5Z7eEdLq1Pi58iIZmQfLAxg/LwFysJOG8aommUAXdEs3vpO/NBf7M2NNMNSgnE0I5IUbVGyBsCNWG8fIwnE1OBlS0bN8HqGOYISe2SQa3af7GYtmRQXRp1UlquG2K0FPBnxmmrXwx8UBdPHL+WUVSU1Ypch/qTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cflh8pVu; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cflh8pVu"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a9af813f6cso149809285a.3
        for <selinux@vger.kernel.org>; Thu, 12 Sep 2024 18:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726190315; x=1726795115; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YKYyd6pVgIHHfDYldydf/l8er/9vTj3rQlAXSuFfGs=;
        b=cflh8pVuG5RqHpTuNzUq2VoXtKga8iaN+6rudvjfbuVhaSz2vWTCs8YdCE+j1J+2JV
         8Z34A29jxmgT9Stz6u/w96X++iLBVbHE70daXGl8VmoESBVIcC1vPn5rmOlHQyYG8gCm
         fvOiJN7DkeM00NVckUvOcp8TswhgLz4luI7UBrPzdKvaxZ4rRii0DXCVyynDaulitMlT
         PUJ4QaI+FYGjsXakfkqqW0ECqP9y9gHbTvBcL+otiL58s+0FE1DxYcfvDfpCcbQOL4EL
         M8s4N0joI1c6oV4qsO9xT6T1MC7zNmRtYT6jO16cL9d0WTmv+ai02AZNEgo4PDRf9XHK
         omkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726190315; x=1726795115;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YKYyd6pVgIHHfDYldydf/l8er/9vTj3rQlAXSuFfGs=;
        b=PEXiIPlU3M9LoXAld4T/8bLq4gdRbHEHiOx21+6tyo1PVmrsleUrvxYw0d22KeHDKK
         E6oxayGNKr8NBROvIs4vOQXO74bfh8/fdtU61fFQtTUcJCpdS72EHDW/cCcoO6aUC8Jb
         mXzHQ2gLND0PwpiHZ1y5KwmZZxqgJ9A2ICpTHSpUeY4DNEpUJRFlftRhnnsCjPdYujBG
         Z4DsNBc1A0RW8Xz44BIdRCItYzggY6aP4Wt/lKZZPvYQch3HBRUh2sIToJF2jxRNTuDP
         KG13nzA6Rgo8KrB658E+Y/cZZ1Xrvslhj4LenSljQc42DP9/BSGMozTGCOHNduNJur3N
         B04w==
X-Gm-Message-State: AOJu0YxH6ecJJdNLOnh7p1MKiZag2UNurmTirAc44a4peUkEzZ4Xyim2
	7T3XXy5K0DdKs5+sg85EWKJbh71vRllV1VDsyIpH86gHd6o6HgRGGxuZZ8zun8793ZGBdn/FU3c
	=
X-Google-Smtp-Source: AGHT+IHp1hgkE96Wih0ITNuYvZtXTJ9Giba/CeSTfOTehlb9V+ct3FfrhjuOdJRzHqnTPSuI/KacTw==
X-Received: by 2002:a05:620a:4086:b0:7a9:c160:c80b with SMTP id af79cd13be357-7a9e5ee70f9mr826282985a.8.1726190314835;
        Thu, 12 Sep 2024 18:18:34 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7946afbsm600876785a.3.2024.09.12.18.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 18:18:34 -0700 (PDT)
Date: Thu, 12 Sep 2024 21:18:33 -0400
Message-ID: <c6139509267be86f56f189c243d57426@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20240911
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Linus,

A number of small SELinux patches for the v6.12 merge window:

* Ensure that both IPv4 and IPv6 connections are properly initialized

While we always properly initialized IPv4 connections early in their
life, we missed the necessary IPv6 change when we were adding IPv6
support.

* Annotate the SELinux inode revalidation function to quiet KCSAN 

KCSAN correctly identifyies a race in __inode_security_revalidate() when
we check to see if an inode's SELinux has been properly initialized.
While KCSAN is correct, it is an intentional choice made for performance
reasons; if necessary, we check the state a second time, this time with a
lock held, before initializing the inode's state.

* Code cleanups, simplification, etc.

A handful of individual patches to simplify some SELinux kernel logic,
improve return code granularity via ERR_PTR(), follow the guidance on
using KMEM_CACHE(), and correct some minor style problems.

-Paul

--
The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20240911

for you to fetch changes up to d19a9e25a722d629041ac8fd320a86c016e349d1:

  selinux: fix style problems in security/selinux/include/audit.h
    (2024-09-03 18:54:38 -0400)

----------------------------------------------------------------
selinux/stable-6.12 PR 20240911
----------------------------------------------------------------

Canfeng Guo (1):
      selinux: Streamline type determination in security_compute_sid

Eric Suen (1):
      selinux: replace kmem_cache_create() with KMEM_CACHE()

Gaosheng Cui (1):
      selinux: refactor code to return ERR_PTR in
         selinux_netlbl_sock_genattr

Guido Trentalancia (1):
      selinux: mark both IPv4 and IPv6 accepted connection sockets as
         labeled

Paul Moore (1):
      selinux: fix style problems in security/selinux/include/audit.h

Stephen Smalley (1):
      selinux: annotate false positive data race to avoid KCSAN warnings

Zhen Lei (1):
      selinux: simplify avc_xperms_audit_required()

 security/selinux/avc.c           |   20 ++++---------
 security/selinux/hooks.c         |    7 ++++
 security/selinux/include/audit.h |   46 +++++++++++++++----------------
 security/selinux/netlabel.c      |   20 ++++++-------
 security/selinux/ss/avtab.c      |    7 +---
 security/selinux/ss/ebitmap.c    |    4 --
 security/selinux/ss/hashtab.c    |    4 --
 security/selinux/ss/services.c   |   36 ++++++++++++------------
 8 files changed, 68 insertions(+), 76 deletions(-)

--
paul-moore.com
