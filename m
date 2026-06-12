Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC5B3A71B6
	for <selinux@vger.kernel.org>; Fri, 12 Jun 2026 19:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781291527; cv=none; b=f+wct3MNHPHBaaebUC5J7n1oqwpaqufZQiIbhB0ktKxt5/T0nypgfB6l/p8/1yHp5kKycia29pG4Ii+ur8h57edoswqgfmLaYqZBcy5zNyASe56FSigK9mtkeQyA0knKZnl8aYnXihkxVu/H8ncal3GBBqFp1R6bKhCINtthWHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781291527; c=relaxed/simple;
	bh=uGsZbAAcr0osG7Uyt8EScW4G0ZwqFuuK41CEqJkRJZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zx6f+iIRLjcgLNEgOJtef0oooNzm8BX0Q3weD7hfa21J2GLmM9FJx/FVeMeIh4+NHqXYq/Vq+mlQS9SKyTKjOIDhMlom54OviPN0s7cMVPLnad7TqW8LqqJeiB/v8heFgPasEzDUbey5U4AGiABIG0P8TWI1/4aJSVv8iHom82A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3OI3EPS; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3OI3EPS"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-9155183b42cso171347485a.0
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2026 12:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781291526; x=1781896326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OZfbFJA+a3+HIVczrZFyIvX27BVUlaQCOOui/cj66Ls=;
        b=J3OI3EPS9u9HPbHhlXFJOIpWbn1ljrjDtgjUxd9awRBcCZUHp7Me9ZrYK9rbRnx0vs
         ZdRTwI7S7T2RwW2CDSKCBie+3oDILby3JiZMy4C2IWrTKHmC8EI7p4KBzmLxCT3BiI/G
         5saTjwD2oMOFA3LtpUXXK/mukmjAcGvyiGoApGsu4Bv7jnJJGjCV54/mCiemNV2BCjFe
         4e7lnDIMbpV/WsmgYk0DzABXXnWfc7j6vXsWhaStupvlJKNhafGCWfN27VyjyOfxim4y
         W1iiMaMqBzAM9vMc5qBgSKTYnQYV8By5K0dxY41NJBS1iOq5o/LpLdLZb3DQ5EiptLdO
         P6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781291526; x=1781896326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZfbFJA+a3+HIVczrZFyIvX27BVUlaQCOOui/cj66Ls=;
        b=W7YToNE2ZBM0Ry9f+wZibk5bNs0MzsG6O4gLdz8b94Jj/xU/h17CuB7Wy8jJ4+w3Vz
         755Rmr/1mYvMP8ULMfA2VW/pDehlyCyxAdLiOoSoTlQN1i3YKLl2be01b2TU4Vyd4z20
         N5EZP/8s1Gzxnqq9lF6sCT6ATdtfQgMfLvQiPdNgJgNdQfv4k99t8jrIchTzBGokHYVb
         wb5WuhhrdyeiDhGPJg3AfcVU/rpUqu4zJxABVz3/nbPyUvCgPvUyUbcQ0g3FM+D/HbP3
         P9fx5QJeMjCKEeX1u2/B2tqS9+RRByCkNTzVUQa7fs0VYHV8mzSB/Fjt8GhcOHQ7jVCB
         10OQ==
X-Gm-Message-State: AOJu0YwMUzxq9wZDGVtsIZFKkwVRwW23CA8zJcRVIH+8JVCEQMvSxGFX
	l8t6l4/KwJ3C8ZzMeXY0B3WOSfEZ1YBjFuCMH5GcZF4UxWdYStz6aFyHZo2blQ==
X-Gm-Gg: Acq92OELP6V16fS7w3Cp2meviCN8IoFBLKFKVF3Nb0aYCmB35cQmhBOJjoir4QsVtas
	EmP7pAFWcMxhq3s6Ac0NtuRxWMBaBlJDPWpMLkZPixtMyyuWGoH5UwHlpJXoFVJaqa2O9hDHYe4
	YyidFvf6Pcz9uFJU9A01zMkHoVMJh9fzU1zf3BnX+84rAI1a9GPMRyvnUfK7ykLUm/9Wuf0jpj3
	0VAY2FL0+B4PBHWvwuY6X7C690Ak/cqrBmVKtHSo/KjoMXoA6MVMGhUYD9qUCjm8b4RbJ2uvnY8
	mbg4ZYVxE68erLfPwxf6AgwY7GpjYMq/LbpvUBpBlIfvs+R4sf+6X3toRRpF7iswdMBPqf/z1kF
	95hDqFVIZdtjW/OXtzxoPM4yt66Ues6SrlOb+tLrfPe7FSstYLrnU+wbpQLlWEP0SG3Oz559geK
	Y/lgcrGTjMEP5iS9XeTkcMw5wAX3QHSG7DhnLXZCSHLMbyP/3HxttUeY3QJu2H6cDj/1yQbmjKY
	x3oH1CVoYJhLtnHXGD1ZAxbt8U=
X-Received: by 2002:a05:620a:470e:b0:915:b715:e319 with SMTP id af79cd13be357-9161bfb65ccmr527555485a.12.1781291525554;
        Fri, 12 Jun 2026 12:12:05 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a04b472sm295086885a.37.2026.06.12.12.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 12:12:05 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH v2 0/3] Make selinux_check_access() thread-safe
Date: Fri, 12 Jun 2026 15:11:43 -0400
Message-ID: <20260612191146.20122-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a RFC-only series targeting merge after the 3.11 release.

This series tries to address the same thread-safety issues for
selinux_check_access(3) previously raised in 2021 by the
following mailing list links and GitHub issues/pull requests:

[1] https://github.com/SELinuxProject/selinux/issues/287
[2] https://lore.kernel.org/selinux/CAJsHiNx1E7x1jaBkS0i4L1nBWXp8YXLHRWcCaDaH4LOn=zm+Zw@mail.gmail.com/
[3] https://github.com/SELinuxProject/selinux/issues/335
[4] https://github.com/SELinuxProject/selinux/pull/336
[5] https://lore.kernel.org/selinux/20220120073329.15234-1-purushottamchoudhary29@gmail.com/

v2 makes some improvements to each of the three patches, noted
in each one.

Stephen Smalley (3):
  libselinux: avc: use pthread mutexes by default when no lock callbacks
    set
  libselinux: stringrep: serialize access to the discover_class_cache
  libselinux: sestatus: serialize selinux status updates

 libselinux/src/avc_internal.h |  19 +++++-
 libselinux/src/sestatus.c     |  49 +++++++++++---
 libselinux/src/stringrep.c    | 120 ++++++++++++++++++++++++----------
 3 files changed, 144 insertions(+), 44 deletions(-)

-- 
2.54.0

